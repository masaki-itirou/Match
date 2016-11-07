/**
 * @author Administrator
 */
function easy_sha512(raw){
	var shaObj = new jsSHA("SHA-512", "TEXT");	
	shaObj.update(raw);
	return shaObj.getHash("HEX");	
};
