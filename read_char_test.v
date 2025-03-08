module utf8io

fn test_one() {
	mut u := utf8io.Utf8io{}
	u.open('./testdata/one.dat')
	for _ in 0..16 {
		u.peek_char()!
	}
	assert u.read_char()! == [u8(97)]
	ch := u.read_char()!
	assert ch.len == 0
	assert u.eof
	u.close()
	unsafe { u.free() }
}

fn test_five() {
	mut u := utf8io.Utf8io{}
	u.open('./testdata/five.dat')
	mut ch := []u8{}
	mut res := []u8{}
	for _ in 0 .. 7 {
		ch = u.read_char()!
		if u.eof == true { break }
		res << ch
	}
	assert u.eof
	assert res == [u8(49), 50, 51, 52, 53]
	u.close()
	unsafe { u.free() }
}
