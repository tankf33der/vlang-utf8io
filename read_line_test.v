module utf8io

fn test_read_line() {
	mut u := Utf8io{}
	u.open('./testdata/five.dat')
	mut line := u.read_line()!
	assert line == [u8(49), 50, 51, 52, 53]
	assert u.peek_char()! == []
	u.close()
	unsafe { u.free() }
}

fn test_twoline() {
	mut u := Utf8io{}
	u.open('./testdata/twolines.dat')
	mut lines := []u8{}
	for {
		l := u.read_line()!
		if l.len == 0 {
			break
		}
		lines << l
	}
	assert lines == [u8(97), 98, 99, 65, 66, 67]
	u.close()
	unsafe { u.free() }
}

fn test_zero_line() {
	mut u := Utf8io{}
	u.open('./testdata/zero.dat')
	mut line := u.read_line()!
	assert line == []
	u.close()
}
