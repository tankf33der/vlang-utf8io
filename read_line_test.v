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


// FIXME
/*
fn test_twoline() {
	mut u := Utf8io{}
	u.open('./testdata/twolines.dat')
	mut lines := []u8{}
	for {
		if u.eof {
			break
		}
		lines << u.read_line()!
	}
	assert lines == [u8(97), 98, 99, 65, 66, 67]
	u.close()
	unsafe { u.free() }
}
*/
