// module utf8io
import os

pub struct Utf8io {
mut:
	f   os.File
	pos u64
}

pub fn (mut u Utf8io) open(path string) {
	u.f = os.open(path) or { panic('open failed') }
}

pub fn (mut u Utf8io) peek_char() !string {
	mut res := []u8{}
	res << u.f.read_u8() or { return res.bytestr() }
	count := utf8_char_len(res[0])
	for _ in 0 .. count - 1 {
		res << u.f.read_u8()!
	}
	defer {
		u.f.seek(u.pos, .start) or { panic('seek failed') }
	}
	return res.bytestr()
}

pub fn (mut u Utf8io) read_char() !string {
	mut res := []u8{}
	res << u.f.read_u8() or { return res.bytestr() }
	count := u64(utf8_char_len(res[0]))
	u.pos += count
	for _ in 0 .. count - 1 {
		res << u.f.read_u8()!
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
	defer { u.close() }

	mut c := ''
	for {
		// println('start')
		// c = u.peek_char()!
		// if c.len == 0 { break }
		// println('peek:|${c}|')

		c = u.read_char()!
		if c.len == 0 {
			break
		}
		println('read:|${c}|')
		// println('end')
	}
}
