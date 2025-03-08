module utf8io

fn test_peek() {
	mut u := utf8io.Utf8io{}
	u.open('./testdata/EOF.dat')
	println(u.peek_char()!)
	u.close()
	unsafe { u.free() }
}
