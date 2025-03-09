// TODO:
// o) add inline
// o) add Windows EOL support

module utf8io

import os


pub struct Utf8io {
mut:
	f   os.File
	eof bool
	pos u64
}

pub fn to_arrays(pattern string) [][]u8 {
	mut res := [][]u8{}
	mut start := 0
	patt_bytes := pattern.bytes()
	if pattern.len > 0 {
		for {
			// protection
			if start == pattern.len { break }
			// work
			count := utf8_char_len(pattern[start])
			res << patt_bytes[start .. start+count]
			start += count
		}
	}
	return res
}

pub fn (mut u Utf8io) open(path string) {
	u.f = os.open(path) or { panic('open failed') }
}

pub fn (mut u Utf8io) peek_char() ![]u8 {
	mut res := []u8{cap: 4}
	res << u.f.read_u8() or {
		u.eof = true
		return res
	}
	count := utf8_char_len(res[0])
	for _ in 0 .. count - 1 {
		res <<  u.f.read_u8()!
	}
	defer {
		u.f.seek(u.pos, .start) or { panic('seek failed') }
	}
	return res
}

pub fn (mut u Utf8io) read_char() ![]u8 {
	mut res := []u8{cap: 4}
	res << u.f.read_u8() or {
		u.eof = true
		return res
	}
	count := u64(utf8_char_len(res[0]))
	u.pos += count
	for _ in 0 .. count - 1 {
		res << u.f.read_u8()!
	}
	return res
}

pub fn (mut u Utf8io) read_line() ![]u8 {
	mut res := []u8{}
	for {
		ch := u.read_char()!
		if u.eof || ch[0] == 10 {
			break
		}
		res << ch
	}
	return res
}

/*
pub fn (mut u Utf8io) read_till(pattern string) ![]u8 {
	mut res := []u8{}
	for {
		ch := u.read_char()!
		if u.eof {
			break
		}
		res << ch
	}
}
*/

pub fn (mut u Utf8io) close() {
	u.f.close()
}

@[unsafe]
pub fn (mut u Utf8io) free() {
	unsafe { free(u) }
}
