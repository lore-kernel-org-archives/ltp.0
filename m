Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <jstancek@redhat.com>) id 1QC6Cf-0000Dy-G4
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 08:22:33 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QC6Ce-0007LH-EX
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 08:22:33 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p3J8MQOo027458
	for <ltp-list@lists.sourceforge.net>; Tue, 19 Apr 2011 04:22:26 -0400
Date: Tue, 19 Apr 2011 04:22:26 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1772868088.24910.1303201346610.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_24909_287074242.1303201346609"
Subject: [LTP] [PATCH v2] kill05: fix sporadic failures
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

------=_Part_24909_287074242.1303201346609
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
 testcases/kernel/syscalls/kill/kill05.c |   47 ++++++++++++++++++++++--------
 1 files changed, 34 insertions(+), 13 deletions(-)


------=_Part_24909_287074242.1303201346609
Content-Type: text/x-patch; name=0001-kill05-fix-sporadic-failures.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0001-kill05-fix-sporadic-failures.patch

ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2lsbC9raWxsMDUuYyBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2lsbC9raWxsMDUuYw0KaW5kZXggMDE5MzEwMC4uMTU5
MzkzMiAxMDA2NDQNCi0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMva2lsbC9raWxsMDUu
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
CisJCWlmICgqZmxhZyA9PSB2YWx1ZSkNCisJCQlleGl0KDApOw0KKwkJZWxzZQ0KKwkJCXNsZWVw
KDEpOw0KKwl9DQorfQ0KKw0KIC8qDQogICogZG9fbWFzdGVyX2NoaWxkKCkNCiAgKi8NCkBAIC0x
NDEsMTAgKzE1OCwxNiBAQCB2b2lkIGRvX21hc3Rlcl9jaGlsZChjaGFyICoqYXYpDQogCWNoYXIg
dXNlcjFuYW1lW10gPSAibm9ib2R5IjsNCiAJY2hhciB1c2VyMm5hbWVbXSA9ICJiaW4iOw0KIA0K
LQlzdHJ1Y3QgcGFzc3dkICpsdHB1c2VyMSwgKmx0cHVzZXIyOw0KKwlzdHJ1Y3QgcGFzc3dkICp1
c2VyOw0KKwl1bnNpZ25lZCBpbnQgdWlkMSwgdWlkMiwgZ2lkMSwgZ2lkMjsNCiANCi0JbHRwdXNl
cjEgPSBTQUZFX0dFVFBXTkFNKE5VTEwsIHVzZXIxbmFtZSk7DQotCWx0cHVzZXIyID0gU0FGRV9H
RVRQV05BTShOVUxMLCB1c2VyMm5hbWUpOw0KKwl1c2VyID0gU0FGRV9HRVRQV05BTShOVUxMLCB1
c2VyMW5hbWUpOw0KKwl1aWQxID0gdXNlci0+cHdfdWlkOw0KKwlnaWQxID0gdXNlci0+cHdfZ2lk
Ow0KKw0KKwl1c2VyID0gU0FGRV9HRVRQV05BTShOVUxMLCB1c2VyMm5hbWUpOw0KKwl1aWQyID0g
dXNlci0+cHdfdWlkOw0KKwlnaWQyID0gdXNlci0+cHdfZ2lkOw0KIA0KIAlURVNUX0VYUF9FTk9T
KGV4cF9lbm9zKTsNCiANCkBAIC0xNTgsMTEgKzE4MSwxMSBAQCB2b2lkIGRvX21hc3Rlcl9jaGls
ZChjaGFyICoqYXYpDQogCQl0c3RfYnJrbShUQlJPS3xURVJSTk8sIGNsZWFudXAsICJGb3JrIGZh
aWxlZCIpOw0KIA0KIAlpZiAocGlkMSA9PSAwKSB7DQotDQotCQlpZiAoc2V0cmV1aWQobHRwdXNl
cjEtPnB3X3VpZCwgbHRwdXNlcjEtPnB3X3VpZCkgPT0gLTEpIHsNCisJCWlmIChzZXRyZXVpZCh1
aWQxLCBnaWQxKSA9PSAtMSkgew0KIAkJCXBlcnJvcigic2V0cmV1aWQgZmFpbGVkIChpbiBjaGls
ZCkiKTsNCiAJCQlleGl0KDEpOw0KIAkJfQ0KKwkJKmZsYWcgPSAxOw0KICNpZmRlZiBVQ0xJTlVY
DQogCQlpZiAoc2VsZl9leGVjKGF2WzBdLCAiIikgPCAwKSB7DQogCQkJcGVycm9yKCJzZWxmX2V4
ZWMgZmFpbGVkIik7DQpAQCAtMTcyLDE1ICsxOTUsMTggQEAgdm9pZCBkb19tYXN0ZXJfY2hpbGQo
Y2hhciAqKmF2KQ0KIAkJZG9fY2hpbGQoKTsNCiAjZW5kaWYNCiAJfQ0KLQlpZiAoc2V0cmV1aWQo
bHRwdXNlcjItPnB3X3VpZCwgbHRwdXNlcjItPnB3X3VpZCkgPT0gLTEpIHsNCisJaWYgKHNldHJl
dWlkKHVpZDIsIGdpZDIpID09IC0xKSB7DQogCQlwZXJyb3IoInNldGV1aWQgZmFpbGVkIik7DQog
CQlleGl0KDEpOw0KIAl9DQogDQorCS8qIHdhaXQgdW50aWwgY2hpbGQgc2V0cyBpdHMgZXVpZCAq
Lw0KKwl3YWl0X2Zvcl9mbGFnKDEpOw0KKw0KIAlURVNUKGtpbGwocGlkMSwgVEVTVF9TSUcpKTsN
CiANCiAJLyogc2lnbmFsIHRoZSBjaGlsZCB0aGF0IHdlJ3JlIGRvbmUgKi8NCi0JKmZsYWcgPSAx
Ow0KKwkqZmxhZyA9IDI7DQogDQogCWlmICh3YWl0cGlkKHBpZDEsICZzdGF0dXMsIDApID09IC0x
KSB7DQogCQlwZXJyb3IoIndhaXRwaWQgZmFpbGVkIik7DQpAQCAtMjA5LDEyICsyMzUsNyBAQCB2
b2lkIGRvX2NoaWxkKCkNCiAJcGlkX3QgbXlfcGlkOw0KIA0KIAlteV9waWQgPSBnZXRwaWQoKTsN
Ci0Jd2hpbGUgKDEpIHsNCi0JCWlmICgqZmxhZyA9PSAxKQ0KLQkJCWV4aXQoMCk7DQotCQllbHNl
DQotCQkJc2xlZXAoMSk7DQotCX0NCisJd2FpdF9mb3JfZmxhZygyKTsNCiB9DQogDQogdm9pZCBz
ZXR1cCh2b2lkKQ0K
------=_Part_24909_287074242.1303201346609
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
------=_Part_24909_287074242.1303201346609
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_24909_287074242.1303201346609--

