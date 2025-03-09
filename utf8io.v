// TODO:
// o) add Windows EOL support

module utf8io

import os

pub struct Utf8io {
mut:
	f os.File
}

pub fn to_arrays(pattern string) [][]u8 {
	mut res := [][]u8{}
	mut start := 0
	patt_bytes := pattern.bytes()
	if pattern.len > 0 {
		for {
			// protection
			if start == pattern.len {
				break
			}
			// work
			count := utf8_char_len(pattern[start])
			res << patt_bytes[start..start + count]
			start += count
		}
	}
	return res
}

pub fn (mut u Utf8io) open(path string) {
	u.f = os.open(path) or { panic('open failed') }
}

@[inline]
fn (mut u Utf8io) one_char(seek_flag bool) ![]u8 {
	mut res := []u8{cap: 4}
	res << u.f.read_u8() or {
		// u.eof = true
		return res
	}
	count := u64(utf8_char_len(res[0]))
	for _ in 0 .. count - 1 {
		res << u.f.read_u8()!
	}
	defer {
		if seek_flag {
			u.f.seek(-count, .current) or { panic('seek failed') }
		}
	}
	return res
}

pub fn (mut u Utf8io) peek_char() ![]u8 {
	return u.one_char(true)!
}

pub fn (mut u Utf8io) read_char() ![]u8 {
	return u.one_char(false)!
}

pub fn (mut u Utf8io) read_line() ![]u8 {
	mut res := []u8{}
	for {
		ch := u.read_char()!
		if u.f.eof() || ch[0] == 10 {
			break
		}
		res << ch
	}
	return res
}

pub fn (mut u Utf8io) read_till(pattern string) ![]u8 {
	mut res := []u8{}
	patt_bytes := to_arrays(pattern)
	again: for {
		ch := u.peek_char()!
		if ch.len == 0 || ch == patt_bytes[0] {
			break
		}
		res << u.read_char()!
	}
	if u.f.eof() {
		unsafe {
			goto exit
		}
	}
	pos_loop := u.f.tell()!
	mut again_flag := false
	for p in patt_bytes {
		ch := u.read_char()!
		if ch.len == 0 || p != ch {
			again_flag = true
			break
		}
	}
	u.f.seek(pos_loop, .start)!
	if again_flag {
		res << u.read_char()!
		unsafe {
			goto again
		}
	}
	exit:
	return res
}

pub fn (mut u Utf8io) close() {
	u.f.close()
}

@[unsafe]
pub fn (mut u Utf8io) free() {
	unsafe { free(u) }
}
