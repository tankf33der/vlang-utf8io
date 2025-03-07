// module utf8io

import os

pub struct Utf8io{
pub mut:
	f	os.File
}

pub fn (u Utf8io) open(path string) !os.File {
	return os.open(path)!

}

pub fn (mut u Utf8io) close() {
	u.f.close()
}


fn main() {
	mut u := Utf8io{}
	u.f = u.open('../m.dat')!
	println(u.f.read_u8()!)

	u.close()
}
