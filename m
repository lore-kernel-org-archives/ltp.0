Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jshao@redhat.com>) id 1TnOv1-0002na-Ua
	for ltp-list@lists.sourceforge.net; Tue, 25 Dec 2012 07:27:19 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TnOv0-0000R3-63
	for ltp-list@lists.sourceforge.net; Tue, 25 Dec 2012 07:27:19 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qBP7RCsm025452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Dec 2012 02:27:12 -0500
From: Monson Shao <jshao@redhat.com>
Date: Tue, 25 Dec 2012 15:26:32 +0800
Message-Id: <1356420393-4253-2-git-send-email-jshao@redhat.com>
MIME-Version: 1.0
Subject: [LTP] =?utf-8?q?=5BPATCH_2/3=5D_pidns16=3A_modified_test_results?=
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

VGhlIHRlc3Qgc2hvdWxkIHJlc3VsdCBURkFJTCBpZiBjaGlsZCBpcyBzaWduYWxsZWQgZnJvbSB1
bmV4cGVjdGVkIHBpZCwKaW5zdGVhZCBvZiBUQlJPSy4gVGhlIHNhbWUgYXMgVFBBU1MvVElORk8g
LgoKU2lnbmVkLW9mZi1ieTogTW9uc29uIFNoYW8gPGpzaGFvQHJlZGhhdC5jb20+Ci0tLQogdGVz
dGNhc2VzL2tlcm5lbC9jb250YWluZXJzL3BpZG5zL3BpZG5zMTYuYyB8IDQgKystLQogMSDkuKrm
lofku7booqvkv67mlLnvvIzmj5LlhaUgMiDooYwoKynvvIzliKDpmaQgMiDooYwoLSkKCmRpZmYg
LS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2NvbnRhaW5lcnMvcGlkbnMvcGlkbnMxNi5jIGIvdGVz
dGNhc2VzL2tlcm5lbC9jb250YWluZXJzL3BpZG5zL3BpZG5zMTYuYwppbmRleCA5YTEyMTlhLi4w
YzU0YWNmIDEwMDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL2NvbnRhaW5lcnMvcGlkbnMvcGlk
bnMxNi5jCisrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvY29udGFpbmVycy9waWRucy9waWRuczE2LmMK
QEAgLTg0LDkgKzg0LDkgQEAgdm9pZCBjaGlsZF9zaWduYWxfaGFuZGxlcihpbnQgc2lnLCBzaWdp
bmZvX3QgKiBzaSwgdm9pZCAqdW51c2VkKQogCX0KIAogCWlmIChzaS0+c2lfcGlkID09IGV4cGVj
dGVkX3BpZCkKLQkJdHN0X3Jlc20oVElORk8sICJjaGlsZCBpcyBzaWduYWxsZWQgZnJvbSBwaWQg
JWQiLCBleHBlY3RlZF9waWQpOworCQl0c3RfcmVzbShUUEFTUywgImNoaWxkIGlzIHNpZ25hbGxl
ZCBmcm9tIHBpZCAlZCIsIGV4cGVjdGVkX3BpZCk7CiAJZWxzZQotCQl0c3RfcmVzbShUQlJPSywg
ImNoaWxkIGlzIHNpZ25hbGxlZCBmcm9tIHVuZXhwZWN0ZWQgcGlkICVkLCIKKwkJdHN0X3Jlc20o
VEZBSUwsICJjaGlsZCBpcyBzaWduYWxsZWQgZnJvbSB1bmV4cGVjdGVkIHBpZCAlZCwiCiAJCQkg
IiBleHBlY3RpbmcgcGlkICVkIiwgc2ktPnNpX3BpZCwgZXhwZWN0ZWRfcGlkKTsKIAogCWMrKzsK
LS0gCjEuNy4xMS43CgoKLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCkxvZ01lSW4gUmVzY3VlOiBBbnl3
aGVyZSwgQW55dGltZSBSZW1vdGUgc3VwcG9ydCBmb3IgSVQuIEZyZWUgVHJpYWwKUmVtb3RlbHkg
YWNjZXNzIFBDcyBhbmQgbW9iaWxlIGRldmljZXMgYW5kIHByb3ZpZGUgaW5zdGFudCBzdXBwb3J0
CkltcHJvdmUgeW91ciBlZmZpY2llbmN5LCBhbmQgZm9jdXMgb24gZGVsaXZlcmluZyBtb3JlIHZh
bHVlLWFkZCBzZXJ2aWNlcwpEaXNjb3ZlciB3aGF0IElUIFByb2Zlc3Npb25hbHMgS25vdy4gUmVz
Y3VlIGRlbGl2ZXJzCmh0dHA6Ly9wLnNmLm5ldC9zZnUvbG9nbWVpbl8xMjMyOWQyZApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMdHAtbGlzdCBtYWlsaW5n
IGxpc3QKTHRwLWxpc3RAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNl
Zm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL2x0cC1saXN0Cg==
