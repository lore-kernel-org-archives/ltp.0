Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <biessmann@corscience.de>) id 1QYzCF-0002Pj-2T
	for ltp-list@lists.sourceforge.net; Tue, 21 Jun 2011 11:32:43 +0000
Received: from moutng.kundenserver.de ([212.227.126.171])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QYzCC-000653-3P
	for ltp-list@lists.sourceforge.net; Tue, 21 Jun 2011 11:32:40 +0000
From: =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <biessmann@corscience.de>
Date: Tue, 21 Jun 2011 13:32:31 +0200
Message-Id: <1308655951-13647-1-git-send-email-biessmann@corscience.de>
MIME-Version: 1.0
Subject: [LTP] [PATCH] t/k/s/eventfd2/eventfd2_03: fix build error
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

V2l0aG91dCB0aGlzIHBhdGNoIGxpbmtpbmcgbGlibHRwLmEgY29tcGxhaW5zIGFib3V0IG1pc3Np
bmcgVEVTVF9FUlJOTyB3aGVuCmJ1aWxkaW5nIHdpdGggVUNMSU5VWD0xLgoKU2lnbmVkLW9mZi1i
eTogQW5kcmVhcyBCaWXDn21hbm4gPGJpZXNzbWFubkBjb3JzY2llbmNlLmRlPgotLS0KIHRlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvZXZlbnRmZDIvZXZlbnRmZDJfMDMuYyB8ICAgIDEgKwogMSBm
aWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ldmVudGZkMi9ldmVudGZkMl8wMy5jIGIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9ldmVudGZkMi9ldmVudGZkMl8wMy5jCmluZGV4IGViZDYy
MDUuLmQ5ZDJkYzkgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZXZlbnRm
ZDIvZXZlbnRmZDJfMDMuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2V2ZW50ZmQy
L2V2ZW50ZmQyXzAzLmMKQEAgLTM3LDYgKzM3LDcgQEAKIAogLyogSGFybmVzcyBTcGVjaWZpYyBJ
bmNsdWRlIEZpbGVzLiAqLwogI2luY2x1ZGUgInRlc3QuaCIKKyNpbmNsdWRlICJ1c2N0ZXN0Lmgi
CiAjaW5jbHVkZSAibGludXhfc3lzY2FsbF9udW1iZXJzLmgiCiAKIGNoYXIgKlRDSUQgPSAiZXZl
bnRmZDJfMDMiOyAgICAgLyogdGVzdCBwcm9ncmFtIGlkZW50aWZpZXIqLwotLSAKMS43LjIuNQoK
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpFZGl0TGl2ZSBFbnRlcnByaXNlIGlzIHRoZSB3b3JsZCdz
IG1vc3QgdGVjaG5pY2FsbHkgYWR2YW5jZWQgY29udGVudAphdXRob3JpbmcgdG9vbC4gRXhwZXJp
ZW5jZSB0aGUgcG93ZXIgb2YgVHJhY2sgQ2hhbmdlcywgSW5saW5lIEltYWdlCkVkaXRpbmcgYW5k
IGVuc3VyZSBjb250ZW50IGlzIGNvbXBsaWFudCB3aXRoIEFjY2Vzc2liaWxpdHkgQ2hlY2tpbmcu
Cmh0dHA6Ly9wLnNmLm5ldC9zZnUvZXBob3gtZGV2MmRldgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpMdHAtbGlzdCBtYWlsaW5nIGxpc3QKTHRwLWxpc3RA
bGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNlZm9yZ2UubmV0L2xpc3Rz
L2xpc3RpbmZvL2x0cC1saXN0Cg==
