module utf8io

import os

pub struct Utf8io {
mut:
	f   os.File
	pos u64
}

pub fn (mut u Utf8io) open(path string) {
	u.f = os.open(path) or { panic('open failed') }
}

pub fn (mut u Utf8io) peek_char() ![]u8 {
	mut res := []u8{cap: 4}
	res << u.f.read_u8()!
	count := utf8_char_len(res[0])
	for _ in 0 .. count - 1 {
		res <<  u.f.read_u8()!
	}
	defer {
		u.f.seek(u.pos, .start) or { panic('seek failed') }
	}
	return res
}

/*
pub fn (mut u Utf8io) read_char() ?[]u8 {
	mut res := []u8{cap: 4}
	res << u.f.read_u8() or { return none }
	count := u64(utf8_char_len(res[0]))
	u.pos += count
	for _ in 0 .. count - 1 {
		res << u.f.read_u8()!
	}
	return res
}
*/

/*
pub fn (mut u Utf8io) read_line() ![]u8 {
	mut res := []u8{}
	for {
		ch := u.read_char() or { break }
		println(ch)
		if ch.len == 0 || ch[0] == 10 || ch[0] == 13 {
			break
		}
		res << ch
	}
	return res
}
*/


pub fn (mut u Utf8io) close() {
	u.f.close()
}

@[unsafe]
pub fn (mut u Utf8io) free() {
	unsafe { free(u) }
}
