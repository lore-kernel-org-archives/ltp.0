Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jshao@redhat.com>) id 1TnOu7-0004S6-2E
	for ltp-list@lists.sourceforge.net; Tue, 25 Dec 2012 07:26:23 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TnOu4-0000Lg-TY
	for ltp-list@lists.sourceforge.net; Tue, 25 Dec 2012 07:26:23 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qBP7QE7J027224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Dec 2012 02:26:15 -0500
From: Monson Shao <jshao@redhat.com>
Date: Tue, 25 Dec 2012 15:25:35 +0800
Message-Id: <1356420335-4204-1-git-send-email-jshao@redhat.com>
MIME-Version: 1.0
Subject: [LTP] =?utf-8?q?=5BPATCH=5D_pidns30_pidns31=3A_syscall_mq=5Fopen?=
	=?utf-8?q?=28=29_failed_EFAULT=28Bad_address=29?=
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
To: ltp-list@lists.sourceforge.net

J21hbiAzIG1xX29wZW4nIHNhaWQgbXFfb3BlbigpIGNhbiB0YWtlIDIgb3IgNCBhcmd1bWVudHMs
IGJ1dCB0aGUgaW1wbGVtZW50CnN5c2NhbGwoX19OUl9tcV9vcGVuLCAuLi4pIHRha2VzIDQsIGFj
Y29yZGluZyB0byBbMV0uCgpNYW51YWxseSB0ZXN0ZWQgb24ga2VybmVsLTMuNi4wIHdpdGggZ2xp
YmMtMi4xNiAuCgpbMV0gZ2xpYmMvc3lzZGVwcy91bml4L3N5c3YvbGludXgvbXFfb3Blbi5jOjU1
CgpTaWduZWQtb2ZmLWJ5OiBNb25zb24gU2hhbyA8anNoYW9AcmVkaGF0LmNvbT4KLS0tCiB0ZXN0
Y2FzZXMva2VybmVsL2NvbnRhaW5lcnMvcGlkbnMvcGlkbnMzMC5jIHwgMiArLQogdGVzdGNhc2Vz
L2tlcm5lbC9jb250YWluZXJzL3BpZG5zL3BpZG5zMzEuYyB8IDIgKy0KIDIg5Liq5paH5Lu26KKr
5L+u5pS577yM5o+S5YWlIDIg6KGMKCsp77yM5Yig6ZmkIDIg6KGMKC0pCgpkaWZmIC0tZ2l0IGEv
dGVzdGNhc2VzL2tlcm5lbC9jb250YWluZXJzL3BpZG5zL3BpZG5zMzAuYyBiL3Rlc3RjYXNlcy9r
ZXJuZWwvY29udGFpbmVycy9waWRucy9waWRuczMwLmMKaW5kZXggNzFlODdjMS4uNzVjNzM2YiAx
MDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9jb250YWluZXJzL3BpZG5zL3BpZG5zMzAuYwor
KysgYi90ZXN0Y2FzZXMva2VybmVsL2NvbnRhaW5lcnMvcGlkbnMvcGlkbnMzMC5jCkBAIC0xODYs
NyArMTg2LDcgQEAgaW50IGNoaWxkX2ZuKHZvaWQgKmFyZykKIAl3aGlsZSAocmVhZChmYXRoZXJf
dG9fY2hpbGRbMF0sIGJ1ZiwgMSkgIT0gMSkKIAkJc2xlZXAoMSk7CiAKLQltcWQgPSBzeXNjYWxs
KF9fTlJfbXFfb3BlbiwgbXFuYW1lLCBPX1JET05MWSk7CisJbXFkID0gc3lzY2FsbChfX05SX21x
X29wZW4sIG1xbmFtZSwgT19SRE9OTFksIDAsIE5VTEwpOwogCWlmIChtcWQgPT0gLTEpIHsKIAkJ
cGVycm9yKCJtcV9vcGVuIGZhaWxlZCIpOwogCQlyZXR1cm4gMTsKZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvY29udGFpbmVycy9waWRucy9waWRuczMxLmMgYi90ZXN0Y2FzZXMva2VybmVs
L2NvbnRhaW5lcnMvcGlkbnMvcGlkbnMzMS5jCmluZGV4IDJhMDc0ODkuLjE0OThkMTYgMTAwNjQ0
Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udGFpbmVycy9waWRucy9waWRuczMxLmMKKysrIGIv
dGVzdGNhc2VzL2tlcm5lbC9jb250YWluZXJzL3BpZG5zL3BpZG5zMzEuYwpAQCAtMTc3LDcgKzE3
Nyw3IEBAIGludCBjaGlsZF9mbih2b2lkICphcmcpCiAJfQogCXRzdF9yZXNtKFRJTkZPLCAiY2lu
aXQ6IG15IGZhdGhlciBpcyByZWFkeSB0byByZWNlaXZlIGEgbWVzc2FnZSIpOwogCi0JbXFkID0g
c3lzY2FsbChfX05SX21xX29wZW4sIG1xbmFtZSwgT19XUk9OTFkpOworCW1xZCA9IHN5c2NhbGwo
X19OUl9tcV9vcGVuLCBtcW5hbWUsIE9fV1JPTkxZLCAwLCBOVUxMKTsKIAlpZiAobXFkID09ICht
cWRfdCkgLSAxKSB7CiAJCXRzdF9yZXNtKFRCUk9LLCAiY2luaXQ6IG1xX29wZW4oKSBmYWlsZWQg
KCVzKSIsCiAJCQkgc3RyZXJyb3IoZXJybm8pKTsKLS0gCjEuNy4xMS43CgoKLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCkxvZ01lSW4gUmVzY3VlOiBBbnl3aGVyZSwgQW55dGltZSBSZW1vdGUgc3VwcG9y
dCBmb3IgSVQuIEZyZWUgVHJpYWwKUmVtb3RlbHkgYWNjZXNzIFBDcyBhbmQgbW9iaWxlIGRldmlj
ZXMgYW5kIHByb3ZpZGUgaW5zdGFudCBzdXBwb3J0CkltcHJvdmUgeW91ciBlZmZpY2llbmN5LCBh
bmQgZm9jdXMgb24gZGVsaXZlcmluZyBtb3JlIHZhbHVlLWFkZCBzZXJ2aWNlcwpEaXNjb3ZlciB3
aGF0IElUIFByb2Zlc3Npb25hbHMgS25vdy4gUmVzY3VlIGRlbGl2ZXJzCmh0dHA6Ly9wLnNmLm5l
dC9zZnUvbG9nbWVpbl8xMjMyOWQyZApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNl
Zm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0
cC1saXN0Cg==
