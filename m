Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <jstancek@redhat.com>) id 1QC8wu-00013Y-Is
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 11:18:28 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QC8wt-0007w4-LE
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 11:18:28 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx4-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p3JBIMpT027460
	for <ltp-list@lists.sourceforge.net>; Tue, 19 Apr 2011 07:18:22 -0400
Date: Tue, 19 Apr 2011 07:18:21 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1624817233.26998.1303211901975.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_26997_2135441871.1303211901974"
Subject: [LTP] [PATCH v3] kill05: fix sporadic failures
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

------=_Part_26997_2135441871.1303211901974
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


This test failed sporadically, because of:

1. misusage of getpwnam causes ltpuser1 and ltpuser2 to point
to same passwd structure, from getpwnam(3):
"The return value may point to a static area, and may be overwritten by
subsequent calls to getpwent(3)."
Fix this by copying the results from returned pointer.

2. race condition between parent and child
The test actually worked when child didn't have time to set its euid.
Fix this by waiting for child to set its euid.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/kill/kill05.c |   48 ++++++++++++++++++++++--------
 1 files changed, 35 insertions(+), 13 deletions(-)


------=_Part_26997_2135441871.1303211901974
Content-Type: text/x-patch; name=0001-kill05-fix-sporadic-failures.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0001-kill05-fix-sporadic-failures.patch

ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2lsbC9raWxsMDUuYyBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2lsbC9raWxsMDUuYw0KaW5kZXggMDE5MzEwMC4uZDI3
NWI1ZiAxMDA2NDQNCi0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2lsbC9raWxsMDUu
Yw0KKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9raWxsL2tpbGwwNS5jDQpAQCAtNjEs
NiArNjEsMTMgQEANCiAgKiAgICAgIC0gRml4IGRlbGV0aW9uIG9mIElQQyBtZW1vcnkgc2VnbWVu
dC4gU2VnbWVudCB3YXMgbm90IGNvcnJlY3RseQ0KICAqICAgICAgICBkZWxldGVkIGR1ZSB0byB0
aGUgY2hhbmdlIG9mIHVpZCBkdXJpbmcgdGhlIHRlc3QuDQogICoNCisgKiAgICAgIDEzLzA0LzIw
MDEgSmFuIFN0YW5jZWsgKGpzdGFuY2VrQHJlZGhhdC5jb20pDQorICogICAgICAtIEZpeCBtaXN1
c2FnZSBvZiBnZXRwd25hbQ0KKyAqICAgICAgICAiVGhlIHJldHVybiB2YWx1ZSBtYXkgcG9pbnQg
dG8gYSBzdGF0aWMgYXJlYSwgYW5kIG1heSBiZQ0KKyAqICAgICAgICBvdmVyd3JpdHRlbiBieSBz
dWJzZXF1ZW50IGNhbGxzIHRvIGdldHB3ZW50KDMpIg0KKyAqICAgICAgLSBGaXggcmFjZSBjb25k
aXRpb24gYmV0d2VlbiBwYXJlbnQgYW5kIGNoaWxkDQorICogICAgICAgIFdhaXQgZm9yIGNoaWxk
IHRvIHNldCBpdHMgZXVpZCBiZWZvcmUgYXR0ZW1wdGluZyB0byBraWxsIGl0DQorICoNCiAgKiBS
RVNUUklDVElPTlMNCiAgKglUaGlzIHRlc3QgbXVzdCBiZSBydW4gYXMgcm9vdC4NCiAgKglMb29w
aW5nIHdpdGggdGhlIC1pIG9wdGlvbiBkb2VzIG5vdCB3b3JrIGNvcnJlY3RseS4NCkBAIC0xMzAs
NiArMTM3LDE2IEBAIGludCBtYWluKGludCBhYywgY2hhciAqKmF2KQ0KIAl0c3RfZXhpdCgpOw0K
IH0NCiANCit2b2lkIHdhaXRfZm9yX2ZsYWcoaW50IHZhbHVlKQ0KK3sNCisJd2hpbGUgKDEpIHsN
CisJCWlmICgqZmxhZyA9PSB2YWx1ZSkNCisJCQlicmVhazsNCisJCWVsc2UNCisJCQlzbGVlcCgx
KTsNCisJfQ0KK30NCisNCiAvKg0KICAqIGRvX21hc3Rlcl9jaGlsZCgpDQogICovDQpAQCAtMTQx
LDEwICsxNTgsMTYgQEAgdm9pZCBkb19tYXN0ZXJfY2hpbGQoY2hhciAqKmF2KQ0KIAljaGFyIHVz
ZXIxbmFtZVtdID0gIm5vYm9keSI7DQogCWNoYXIgdXNlcjJuYW1lW10gPSAiYmluIjsNCiANCi0J
c3RydWN0IHBhc3N3ZCAqbHRwdXNlcjEsICpsdHB1c2VyMjsNCisJc3RydWN0IHBhc3N3ZCAqdXNl
cjsNCisJdW5zaWduZWQgaW50IHVpZDEsIHVpZDIsIGdpZDEsIGdpZDI7DQogDQotCWx0cHVzZXIx
ID0gU0FGRV9HRVRQV05BTShOVUxMLCB1c2VyMW5hbWUpOw0KLQlsdHB1c2VyMiA9IFNBRkVfR0VU
UFdOQU0oTlVMTCwgdXNlcjJuYW1lKTsNCisJdXNlciA9IFNBRkVfR0VUUFdOQU0oTlVMTCwgdXNl
cjFuYW1lKTsNCisJdWlkMSA9IHVzZXItPnB3X3VpZDsNCisJZ2lkMSA9IHVzZXItPnB3X2dpZDsN
CisNCisJdXNlciA9IFNBRkVfR0VUUFdOQU0oTlVMTCwgdXNlcjJuYW1lKTsNCisJdWlkMiA9IHVz
ZXItPnB3X3VpZDsNCisJZ2lkMiA9IHVzZXItPnB3X2dpZDsNCiANCiAJVEVTVF9FWFBfRU5PUyhl
eHBfZW5vcyk7DQogDQpAQCAtMTU4LDExICsxODEsMTEgQEAgdm9pZCBkb19tYXN0ZXJfY2hpbGQo
Y2hhciAqKmF2KQ0KIAkJdHN0X2Jya20oVEJST0t8VEVSUk5PLCBjbGVhbnVwLCAiRm9yayBmYWls
ZWQiKTsNCiANCiAJaWYgKHBpZDEgPT0gMCkgew0KLQ0KLQkJaWYgKHNldHJldWlkKGx0cHVzZXIx
LT5wd191aWQsIGx0cHVzZXIxLT5wd191aWQpID09IC0xKSB7DQorCQlpZiAoc2V0cmV1aWQodWlk
MSwgZ2lkMSkgPT0gLTEpIHsNCiAJCQlwZXJyb3IoInNldHJldWlkIGZhaWxlZCAoaW4gY2hpbGQp
Iik7DQogCQkJZXhpdCgxKTsNCiAJCX0NCisJCSpmbGFnID0gMTsNCiAjaWZkZWYgVUNMSU5VWA0K
IAkJaWYgKHNlbGZfZXhlYyhhdlswXSwgIiIpIDwgMCkgew0KIAkJCXBlcnJvcigic2VsZl9leGVj
IGZhaWxlZCIpOw0KQEAgLTE3MiwxNSArMTk1LDE4IEBAIHZvaWQgZG9fbWFzdGVyX2NoaWxkKGNo
YXIgKiphdikNCiAJCWRvX2NoaWxkKCk7DQogI2VuZGlmDQogCX0NCi0JaWYgKHNldHJldWlkKGx0
cHVzZXIyLT5wd191aWQsIGx0cHVzZXIyLT5wd191aWQpID09IC0xKSB7DQorCWlmIChzZXRyZXVp
ZCh1aWQyLCBnaWQyKSA9PSAtMSkgew0KIAkJcGVycm9yKCJzZXRldWlkIGZhaWxlZCIpOw0KIAkJ
ZXhpdCgxKTsNCiAJfQ0KIA0KKwkvKiB3YWl0IHVudGlsIGNoaWxkIHNldHMgaXRzIGV1aWQgKi8N
CisJd2FpdF9mb3JfZmxhZygxKTsNCisNCiAJVEVTVChraWxsKHBpZDEsIFRFU1RfU0lHKSk7DQog
DQogCS8qIHNpZ25hbCB0aGUgY2hpbGQgdGhhdCB3ZSdyZSBkb25lICovDQotCSpmbGFnID0gMTsN
CisJKmZsYWcgPSAyOw0KIA0KIAlpZiAod2FpdHBpZChwaWQxLCAmc3RhdHVzLCAwKSA9PSAtMSkg
ew0KIAkJcGVycm9yKCJ3YWl0cGlkIGZhaWxlZCIpOw0KQEAgLTIwOSwxMiArMjM1LDggQEAgdm9p
ZCBkb19jaGlsZCgpDQogCXBpZF90IG15X3BpZDsNCiANCiAJbXlfcGlkID0gZ2V0cGlkKCk7DQot
CXdoaWxlICgxKSB7DQotCQlpZiAoKmZsYWcgPT0gMSkNCi0JCQlleGl0KDApOw0KLQkJZWxzZQ0K
LQkJCXNsZWVwKDEpOw0KLQl9DQorCXdhaXRfZm9yX2ZsYWcoMik7DQorCWV4aXQoMCk7DQogfQ0K
IA0KIHZvaWQgc2V0dXAodm9pZCkNCg==
------=_Part_26997_2135441871.1303211901974
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
------=_Part_26997_2135441871.1303211901974
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_26997_2135441871.1303211901974--

