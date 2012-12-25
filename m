Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jshao@redhat.com>) id 1TnOv3-00040n-Dk
	for ltp-list@lists.sourceforge.net; Tue, 25 Dec 2012 07:27:21 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TnOv2-0002Mk-Mi
	for ltp-list@lists.sourceforge.net; Tue, 25 Dec 2012 07:27:21 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qBP7REkw028577
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Dec 2012 02:27:14 -0500
From: Monson Shao <jshao@redhat.com>
Date: Tue, 25 Dec 2012 15:26:33 +0800
Message-Id: <1356420393-4253-3-git-send-email-jshao@redhat.com>
MIME-Version: 1.0
Subject: [LTP] =?utf-8?q?=5BPATCH_3/3=5D_pidns16=3A_child_should_not_get_p?=
	=?utf-8?q?arent_pid_in_parent_NS?=
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

cGFyZW50IHBpZCBpbiBwYXJlbnQgTlMgaXMgaW52aXNpYmxlIHRvIGNoaWxkLCBldmVuIHdoZW4g
Y2hpbGQgZ290IHNpZ25hbGxlZApmcm9tIHBhcmVudCwgdGhlIHNpZ25hbGxlciBwcm9jZXNzIHNo
b3VsZCBiZSBmYWtlIHBhcmVudCAoUElEIDApLgoKU2lnbmVkLW9mZi1ieTogTW9uc29uIFNoYW8g
PGpzaGFvQHJlZGhhdC5jb20+Ci0tLQogdGVzdGNhc2VzL2tlcm5lbC9jb250YWluZXJzL3BpZG5z
L3BpZG5zMTYuYyB8IDUgKy0tLS0KIDEg5Liq5paH5Lu26KKr5L+u5pS577yM5o+S5YWlIDEg6KGM
KCsp77yM5Yig6ZmkIDQg6KGMKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9jb250
YWluZXJzL3BpZG5zL3BpZG5zMTYuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvY29udGFpbmVycy9waWRu
cy9waWRuczE2LmMKaW5kZXggMGM1NGFjZi4uOWQ0Y2JkYyAxMDA2NDQKLS0tIGEvdGVzdGNhc2Vz
L2tlcm5lbC9jb250YWluZXJzL3BpZG5zL3BpZG5zMTYuYworKysgYi90ZXN0Y2FzZXMva2VybmVs
L2NvbnRhaW5lcnMvcGlkbnMvcGlkbnMxNi5jCkBAIC01NCw3ICs1NCw2IEBACiAKIGNoYXIgKlRD
SUQgPSAicGlkbnMxNiI7CiBpbnQgVFNUX1RPVEFMID0gMTsKLXBpZF90IGdsb2JhbHBpZDsKIAog
LyoKICAqIGNsZWFudXAoKSAtIHBlcmZvcm1zIGFsbCBPTkUgVElNRSBjbGVhbnVwIGZvciB0aGlz
IHRlc3QgYXQKQEAgLTc1LDcgKzc0LDcgQEAgdm9pZCBjaGlsZF9zaWduYWxfaGFuZGxlcihpbnQg
c2lnLCBzaWdpbmZvX3QgKiBzaSwgdm9pZCAqdW51c2VkKQogCS8qIFZlcmlmeWluZyBmcm9tIHdo
aWNoIHByb2Nlc3MgdGhlIHNpZ25hbCBoYW5kbGVyIGlzIHNpZ25hbGxlZCAqLwogCiAJaWYgKGMg
PT0gMSkKLQkJZXhwZWN0ZWRfcGlkID0gZ2xvYmFscGlkOworCQlleHBlY3RlZF9waWQgPSBQQVJF
TlRfUElEOwogCWVsc2UgaWYgKGMgPT0gMikKIAkJZXhwZWN0ZWRfcGlkID0gQ0hJTERfUElEOwog
CWVsc2UgewpAQCAtMTM0LDggKzEzMyw2IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2
W10pCiAJaW50IHN0YXR1czsKIAlwaWRfdCBjcGlkOwogCi0JZ2xvYmFscGlkID0gZ2V0cGlkKCk7
Ci0KIAljcGlkID0gbHRwX2Nsb25lX3F1aWNrKENMT05FX05FV1BJRCB8IFNJR0NITEQsIGNoaWxk
X2ZuLCBOVUxMKTsKIAogCWlmIChjcGlkIDwgMCkgewotLSAKMS43LjExLjcKCgotLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0KTG9nTWVJbiBSZXNjdWU6IEFueXdoZXJlLCBBbnl0aW1lIFJlbW90ZSBzdXBw
b3J0IGZvciBJVC4gRnJlZSBUcmlhbApSZW1vdGVseSBhY2Nlc3MgUENzIGFuZCBtb2JpbGUgZGV2
aWNlcyBhbmQgcHJvdmlkZSBpbnN0YW50IHN1cHBvcnQKSW1wcm92ZSB5b3VyIGVmZmljaWVuY3ks
IGFuZCBmb2N1cyBvbiBkZWxpdmVyaW5nIG1vcmUgdmFsdWUtYWRkIHNlcnZpY2VzCkRpc2NvdmVy
IHdoYXQgSVQgUHJvZmVzc2lvbmFscyBLbm93LiBSZXNjdWUgZGVsaXZlcnMKaHR0cDovL3Auc2Yu
bmV0L3NmdS9sb2dtZWluXzEyMzI5ZDJkCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCkx0cC1saXN0IG1haWxpbmcgbGlzdApMdHAtbGlzdEBsaXN0cy5zb3Vy
Y2Vmb3JnZS5uZXQKaHR0cHM6Ly9saXN0cy5zb3VyY2Vmb3JnZS5uZXQvbGlzdHMvbGlzdGluZm8v
bHRwLWxpc3QK
