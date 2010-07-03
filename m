Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OV6zT-0006J2-MN
	for Ltp-list@lists.sourceforge.net; Sat, 03 Jul 2010 17:58:59 +0000
Received: from e9.ny.us.ibm.com ([32.97.182.139])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OV6zS-0002Jx-73
	for Ltp-list@lists.sourceforge.net; Sat, 03 Jul 2010 17:58:59 +0000
Received: from d01relay03.pok.ibm.com (d01relay03.pok.ibm.com [9.56.227.235])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o63HTMV4032380
	for <Ltp-list@lists.sourceforge.net>; Sat, 3 Jul 2010 13:29:22 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay03.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o63Hiuhq140120
	for <Ltp-list@lists.sourceforge.net>; Sat, 3 Jul 2010 13:44:56 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o63HiuT2019468
	for <Ltp-list@lists.sourceforge.net>; Sat, 3 Jul 2010 13:44:56 -0400
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <AANLkTikvEYeg8DZfl6Deuge9f9Lk_uhA0MuW_OP4Ve9M@mail.gmail.com>
References: <AANLkTikvEYeg8DZfl6Deuge9f9Lk_uhA0MuW_OP4Ve9M@mail.gmail.com>
Date: Sat, 03 Jul 2010 23:14:52 +0530
Message-Id: <1278179092.7665.7.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [Bug Fix]semctl01 and shmctl01 will hang during
	uClinux	test
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Bob Liu <lliubbo@gmail.com>
Cc: Ltp-list@lists.sourceforge.net

T2suIFRoYW5rcy4KClJlZ2FyZHMtLQpTdWJyYXRhCgpPbiBGcmksIDIwMTAtMDctMDIgYXQgMTM6
NDEgKzA4MDAsIEJvYiBMaXUgd3JvdGU6Cj4gbHRwIHRlc3QgY2FzZSBzaG1jdGwwMSBhbmQgc2Vt
Y3RsMDEgY2FuIG5vdCBleGVjdXRlLiBXaGVuIHByZXNzIGN0cmwKPiBhbmQgYywgaXQgY2FuIG5v
dCBleGlzdC4KPiAKPiAtLQo+IHJvb3Q6Lz4gc2htY3RsMDEKPiAKPiAKPiBeQ3NobWN0bDAxICAg
IDAgIElORk8gIDogIHJlY2VpdmVkIHVuZXhwZWN0ZWQgc2lnbmFsIDIKPiBeQ3NobWN0bDAxICAg
IDAgIElORk8gIDogIHJlY2VpdmVkIHVuZXhwZWN0ZWQgc2lnbmFsIDIKPiAtLQo+IAo+IFRoZSBy
ZWFzb24gaXMgdGhlIGNoaWxkIHdpbGwgdW5saW5rIHRoZSBwaXBlIGlmIHBpcGVuYW1lIGlzbid0
Cj4gTlVMTO+8jHdoaWNoIG1heSBtYWtlIHRoZSBwYXJlbnQKPiB3YWl0dGluZyBmb3JldmVyLgo+
IAo+IAo+IEluZGV4OiB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lwYy9zZW1jdGwvc2VtY3Rs
MDEuYwo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KPiAtLS0gdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pcGMvc2Vt
Y3RsL3NlbWN0bDAxLmMJCj4gKysrIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaXBjL3NlbWN0
bC9zZW1jdGwwMS5jCQo+IEBAIC00MDAsNyArNDAwLDExIEBACj4gIAlpZiAoc3luY19waXBlX25v
dGlmeShzeW5jX3BpcGVzKSA9PSAtMSkKPiAgCQl0c3RfYnJrbShUQlJPSywgY2xlYW51cCwgInN5
bmNfcGlwZV9ub3RpZnkgZmFpbGVkIik7Cj4gCj4gKyNpZmRlZiBVQ0xJTlVYCj4gKwlpZiAoc3lu
Y19waXBlX2Nsb3NlKHN5bmNfcGlwZXMsIE5VTEwpID09IC0xKQo+ICsjZWxzZQo+ICAJaWYgKHN5
bmNfcGlwZV9jbG9zZShzeW5jX3BpcGVzLCBQSVBFX05BTUUpID09IC0xKQo+ICsjZW5kaWYKPiAg
CQl0c3RfYnJrbShUQlJPSywgY2xlYW51cCwgInN5bmNfcGlwZV9jbG9zZSBmYWlsZWQiKTsKPiAK
PiAgCXNvcHMuc2VtX251bSA9IFNFTTQ7Cj4gSW5kZXg6IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvaXBjL3NobWN0bC9zaG1jdGwwMS5jCj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+IC0tLSB0ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2lwYy9zaG1jdGwvc2htY3RsMDEuYwkKPiArKysgdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9pcGMvc2htY3RsL3NobWN0bDAxLmMJCj4gQEAgLTMyNCw4ICszMjQsMTEgQEAK
PiAgCQo+ICAJaWYgKHN5bmNfcGlwZV9ub3RpZnkoc3luY19waXBlcykgPT0gLTEpCj4gIAkJdHN0
X2Jya20oVEJST0ssIGNsZWFudXAsICJzeW5jX3BpcGVfbm90aWZ5IGZhaWxlZCIpOwo+IC0KPiAr
I2lmZGVmIFVDTElOVVgKPiArCWlmIChzeW5jX3BpcGVfY2xvc2Uoc3luY19waXBlcywgTlVMTCkg
PT0gLTEpCj4gKyNlbHNlCj4gIAlpZiAoc3luY19waXBlX2Nsb3NlKHN5bmNfcGlwZXMsIFBJUEVf
TkFNRSkgPT0gLTEpCj4gKyNlbmRpZgo+ICAJCXRzdF9icmttKFRCUk9LLCBjbGVhbnVwLCAic3lu
Y19waXBlX2Nsb3NlIGZhaWxlZCIpOwo+IAo+ICAJLyogZG8gYW4gYXNzaWduZW1lbnQgZm9yIGZ1
biAqLwo+IAoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpUaGlzIFNGLm5ldCBlbWFpbCBpcyBzcG9u
c29yZWQgYnkgU3ByaW50CldoYXQgd2lsbCB5b3UgZG8gZmlyc3Qgd2l0aCBFVk8sIHRoZSBmaXJz
dCA0RyBwaG9uZT8KVmlzaXQgc3ByaW50LmNvbS9maXJzdCAtLSBodHRwOi8vcC5zZi5uZXQvc2Z1
L3NwcmludC1jb20tZmlyc3QKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KTHRwLWxpc3QgbWFpbGluZyBsaXN0Ckx0cC1saXN0QGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5mby9sdHAtbGlz
dAo=
