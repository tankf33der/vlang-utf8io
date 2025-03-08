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
	for {
		ch = u.read_char()!
		if u.eof { break }
		res << ch
	}
	assert u.eof
	assert res == [u8(49), 50, 51, 52, 53]
	u.close()
	unsafe { u.free() }
}

fn test_twolines() {
	mut u := utf8io.Utf8io{}
	u.open('./testdata/twolines.dat')
	mut res := []u8{}
	for {
		if u.eof { break }
		res << u.read_char()!
	}
	assert u.eof
	assert res == [u8(97),98,99,10,65,66,67]
	u.close()
	unsafe { u.free() }


}