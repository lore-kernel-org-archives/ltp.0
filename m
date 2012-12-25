Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jshao@redhat.com>) id 1TnOuz-00040V-GT
	for ltp-list@lists.sourceforge.net; Tue, 25 Dec 2012 07:27:17 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TnOuy-0000Qz-D4
	for ltp-list@lists.sourceforge.net; Tue, 25 Dec 2012 07:27:17 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qBP7RAOk025447
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Dec 2012 02:27:11 -0500
From: Monson Shao <jshao@redhat.com>
Date: Tue, 25 Dec 2012 15:26:31 +0800
Message-Id: <1356420393-4253-1-git-send-email-jshao@redhat.com>
MIME-Version: 1.0
Subject: [LTP] =?utf-8?q?=5BPATCH_1/3=5D_pidns16=3A_split_test_condition_a?=
	=?utf-8?q?nd_result_judge?=
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

TWFrZSBpdCBlYXN5IHRvIHJlYWQuCgpTaWduZWQtb2ZmLWJ5OiBNb25zb24gU2hhbyA8anNoYW9A
cmVkaGF0LmNvbT4KLS0tCiB0ZXN0Y2FzZXMva2VybmVsL2NvbnRhaW5lcnMvcGlkbnMvcGlkbnMx
Ni5jIHwgMjQgKysrKysrKysrKysrKysrKy0tLS0tLS0tCiAxIOS4quaWh+S7tuiiq+S/ruaUue+8
jOaPkuWFpSAxNiDooYwoKynvvIzliKDpmaQgOCDooYwoLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2Fz
ZXMva2VybmVsL2NvbnRhaW5lcnMvcGlkbnMvcGlkbnMxNi5jIGIvdGVzdGNhc2VzL2tlcm5lbC9j
b250YWluZXJzL3BpZG5zL3BpZG5zMTYuYwppbmRleCA4YTIzMmM2Li45YTEyMTlhIDEwMDY0NAot
LS0gYS90ZXN0Y2FzZXMva2VybmVsL2NvbnRhaW5lcnMvcGlkbnMvcGlkbnMxNi5jCisrKyBiL3Rl
c3RjYXNlcy9rZXJuZWwvY29udGFpbmVycy9waWRucy9waWRuczE2LmMKQEAgLTcwLDE3ICs3MCwy
NSBAQCB2b2lkIGNsZWFudXAoKQogdm9pZCBjaGlsZF9zaWduYWxfaGFuZGxlcihpbnQgc2lnLCBz
aWdpbmZvX3QgKiBzaSwgdm9pZCAqdW51c2VkKQogewogCXN0YXRpYyBpbnQgYyA9IDE7CisJcGlk
X3QgZXhwZWN0ZWRfcGlkOworCiAJLyogVmVyaWZ5aW5nIGZyb20gd2hpY2ggcHJvY2VzcyB0aGUg
c2lnbmFsIGhhbmRsZXIgaXMgc2lnbmFsbGVkICovCiAKLQlpZiAoKGMgPT0gMSkgJiYgKHNpLT5z
aV9waWQgPT0gZ2xvYmFscGlkKSkKLQkJdHN0X3Jlc20oVElORk8sICJzaWdfaGFuZGxlciBpcyBz
aWduYWxsZWQgZnJvbSBwaWQgICVkIiwKLQkJCSBnbG9iYWxwaWQpOwotCWVsc2UgaWYgKChjID09
IDIpICYmIChzaS0+c2lfcGlkID09IENISUxEX1BJRCkpCi0JCXRzdF9yZXNtKFRJTkZPLCAic2ln
X2hhbmRsZXIgaXMgc2lnbmFsbGVkIGZyb20gcGlkICAlZCIsCi0JCQkgQ0hJTERfUElEKTsKKwlp
ZiAoYyA9PSAxKQorCQlleHBlY3RlZF9waWQgPSBnbG9iYWxwaWQ7CisJZWxzZSBpZiAoYyA9PSAy
KQorCQlleHBlY3RlZF9waWQgPSBDSElMRF9QSUQ7CisJZWxzZSB7CisJCXRzdF9yZXNtKFRCUk9L
LCAiY2hpbGQgc2hvdWxkIE5PVCBiZSBzaWduYWxsZWQgMysgdGltZXMiKTsKKwkJcmV0dXJuOwor
CX0KKworCWlmIChzaS0+c2lfcGlkID09IGV4cGVjdGVkX3BpZCkKKwkJdHN0X3Jlc20oVElORk8s
ICJjaGlsZCBpcyBzaWduYWxsZWQgZnJvbSBwaWQgJWQiLCBleHBlY3RlZF9waWQpOwogCWVsc2UK
LQkJdHN0X3Jlc20oVEJST0ssICJVbmV4cGVjdGVkIHZhbHVlIGZvciBTZW5kaW5nLVByb2Nlc3NJ
RCIKLQkJCSAiIHdoZW4gc2lnbmFsIGhhbmRsZXIgY2FsbGVkICVkXG4iLCBzaS0+c2lfcGlkKTsK
KwkJdHN0X3Jlc20oVEJST0ssICJjaGlsZCBpcyBzaWduYWxsZWQgZnJvbSB1bmV4cGVjdGVkIHBp
ZCAlZCwiCisJCQkgIiBleHBlY3RpbmcgcGlkICVkIiwgc2ktPnNpX3BpZCwgZXhwZWN0ZWRfcGlk
KTsKKwogCWMrKzsKIH0KIAotLSAKMS43LjExLjcKCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KTG9n
TWVJbiBSZXNjdWU6IEFueXdoZXJlLCBBbnl0aW1lIFJlbW90ZSBzdXBwb3J0IGZvciBJVC4gRnJl
ZSBUcmlhbApSZW1vdGVseSBhY2Nlc3MgUENzIGFuZCBtb2JpbGUgZGV2aWNlcyBhbmQgcHJvdmlk
ZSBpbnN0YW50IHN1cHBvcnQKSW1wcm92ZSB5b3VyIGVmZmljaWVuY3ksIGFuZCBmb2N1cyBvbiBk
ZWxpdmVyaW5nIG1vcmUgdmFsdWUtYWRkIHNlcnZpY2VzCkRpc2NvdmVyIHdoYXQgSVQgUHJvZmVz
c2lvbmFscyBLbm93LiBSZXNjdWUgZGVsaXZlcnMKaHR0cDovL3Auc2YubmV0L3NmdS9sb2dtZWlu
XzEyMzI5ZDJkCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Ckx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQKaHR0
cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8vbHRwLWxpc3QK
