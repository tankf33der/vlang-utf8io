module utf8io


fn test_to_arrays_empty() {
	res := utf8io.to_arrays('')
	assert res == []
}

fn test_to_arrays_one() {
	res := utf8io.to_arrays('a')
	assert res == [[u8(97)]]
}

fn test_to_arrays_many() {
	res := utf8io.to_arrays('abc')
	assert res == [[u8(97)],[u8(98)],[u8(99)]]
}

fn test_to_arrays_utf8_one() {
	res := utf8io.to_arrays('а')
	assert res == [[u8(208),176]]
}

fn test_to_arrays_utf8_many() {
	res := utf8io.to_arrays('абв')
	assert res == [[u8(208),176],[u8(208),177],[u8(208),178]]
}

fn test_to_arrays_utf8_combo1() {
	res := utf8io.to_arrays('mишa')
	assert res == [[u8(109)], [u8(208), 184], [u8(209), 136], [u8(97)]]
}

fn test_to_arrays_utf8_combo2() {
	res := utf8io.to_arrays(' мisа')
	assert res == [[u8(32)], [u8(208), 188], [u8(105)], [u8(115)], [u8(208, 176]]
}
