// module utf8io

import os

pub struct Utf8io {
pub mut:
	f	os.File
	pos	u64
}

pub fn (mut u Utf8io) open(path string) {
	u.f = os.open(path) or { panic('open failed') }
}

pub fn (mut u Utf8io) peek() !(string, []u8) {
	mut res := []u8{}
	res << u.f.read_u8() or { return (res.bytestr(), res) }
	count := utf8_char_len(res[0])
	for _ in 0..count-1 {
		res << u.f.read_u8()!
	}
	defer {
		u.f.seek(u.pos, .start) or { panic('seek failed') }
	}
	return (res.bytestr(), res)
}

pub fn (mut u Utf8io) read_char() !string {
	mut res := []u8{}
	res << u.f.read_u8() or { return res.bytestr() }
	u.pos++
	count := utf8_char_len(res[0])
	for _ in 0..count-1 {
		res << u.f.read_u8()!
		u.pos++
	}
	return res.bytestr()
}


pub fn (mut u Utf8io) close() {
	u.f.close()
}

fn main() {
	mut u := Utf8io{}
	// mut res := []u8{cap: 4}
	u.open('../m2.dat')

	mut c := ''
	c := u.peek()!
	println('|${c}|')
	println(c.len)

/*
	for {
		c = u.read_char()!
		println('|${c}|')
		if c.len == 0 { break }
	}
	println(u)
*/

	// for {
	// 	ch := u.f.read_u8() or { break }
	// 	res << ch
	// }
	// println(res)

	u.close()
}
