module utf8io

fn test_peek() {
	mut u := utf8io.Utf8io{}
	u.open('./testdata/one.dat')
	for _ in 0..16 {
		u.peek_char()!
	}
	assert [u8(97)] == u.peek_char()!
	u.close()
	unsafe { u.free() }
}
