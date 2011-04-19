Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <jstancek@redhat.com>) id 1QCBCa-0006e7-Jf
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 13:42:48 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QCBCZ-0008Nu-Ls
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 13:42:48 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p3JDgfnm006678
	for <ltp-list@lists.sourceforge.net>; Tue, 19 Apr 2011 09:42:41 -0400
Date: Tue, 19 Apr 2011 09:42:41 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1510096795.29564.1303220561910.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_29563_1584719475.1303220561898"
Subject: [LTP] [PATCH] cgroups/memcg_regression_test: fix random failures
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

------=_Part_29563_1584719475.1303220561898
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


1. dmesg can rotate and number of found bugs can actually go down
clear the buffer before test to avoid this

2. clean any groups left behind, if test_4.sh gets killed by OOM

3. failed mount should be treated as error and return non-zero

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../memcg/regression/memcg_regression_test.sh      |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)


------=_Part_29563_1584719475.1303220561898
Content-Type: text/x-patch;
	name=0001-cgroups-memcg_regression_test-fix-random-failures.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0001-cgroups-memcg_regression_test-fix-random-failures.patch

ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvcmVncmVzc2lv
bi9tZW1jZ19yZWdyZXNzaW9uX3Rlc3Quc2ggYi90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJz
L21lbWNnL3JlZ3Jlc3Npb24vbWVtY2dfcmVncmVzc2lvbl90ZXN0LnNoDQppbmRleCBiNTY0ZWNl
Li5kNTkzNjljIDEwMDc1NQ0KLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9tZW1j
Zy9yZWdyZXNzaW9uL21lbWNnX3JlZ3Jlc3Npb25fdGVzdC5zaA0KKysrIGIvdGVzdGNhc2VzL2tl
cm5lbC9jb250cm9sbGVycy9tZW1jZy9yZWdyZXNzaW9uL21lbWNnX3JlZ3Jlc3Npb25fdGVzdC5z
aA0KQEAgLTQ3LDYgKzQ3LDcgQEAgaWYgWyAkPyAtZXEgMCBdOyB0aGVuDQogCWV4aXQgMA0KIGZp
DQogDQorZG1lc2cgLWMgPiAvZGV2L251bGwNCiBucl9idWc9YGRtZXNnIHwgZ3JlcCAtYyAia2Vy
bmVsIEJVRyJgDQogbnJfbnVsbD1gZG1lc2cgfCBncmVwIC1jICJrZXJuZWwgTlVMTCBwb2ludGVy
IGRlcmVmZXJlbmNlImANCiBucl93YXJuaW5nPWBkbWVzZyB8IGdyZXAgLWMgIl5XQVJOSU5HImAN
CkBAIC04NSw2ICs4Niw4IEBAIGNoZWNrX2tlcm5lbF9idWcoKQ0KIAlucl93YXJuaW5nPSRuZXdf
d2FybmluZw0KIAlucl9sb2NrZGVwPSRuZXdfbG9ja2RlcA0KIA0KKwllY2hvICJjaGVja19rZXJu
ZWxfYnVnIGZvdW5kIHNvbWV0aGluZyEiDQorCWRtZXNnDQogCWZhaWxlZD0xDQogCXJldHVybiAw
DQogfQ0KQEAgLTIwNiwxMSArMjA5LDEzIEBAIHRlc3RfNCgpDQogCSMgdGVzdF80LnNoIG1pZ2h0
IGJlIGtpbGxlZCBieSBvb20sIHNvIGRvIGNsZWFuIHVwIGhlcmUNCiAJa2lsbGFsbCAtOSBtZW1j
Z190ZXN0XzQgMj4gL2Rldi9udWxsDQogCWtpbGxhbGwgLTkgbWVtY2dfdGVzdF80LnNoIDI+IC9k
ZXYvbnVsbA0KKwkjIGlmIHRlc3RfNC5zaCBnZXRzIGtpbGxlZCwgd2Ugc3RpbGwgbmVlZCB0byBj
bGVhbnVwIGFueSBncm91cHMNCisJcm1kaXIgbWVtY2cvMCAyPiAvZGV2L251bGwNCiAJc3dhcG9u
IC1hDQogfQ0KIA0KICMgbWFpbg0KLQ0KK2ZhaWxlZD0wDQogbWtkaXIgbWVtY2cvDQogDQogZm9y
IGN1ciBpbiAkKHNlcSAxICRUU1RfVE9UQUwpOyBkbw0KQEAgLTIxOSwxMSArMjI0LDExIEBAIGZv
ciBjdXIgaW4gJChzZXEgMSAkVFNUX1RPVEFMKTsgZG8NCiAJbW91bnQgLXQgY2dyb3VwIC1vIG1l
bW9yeSB4eHggbWVtY2cvDQogCWlmIFsgJD8gLW5lIDAgXTsgdGhlbg0KIAkJdHN0X3Jlc20gVEZB
SUwgImZhaWxlZCB0byBtb3VudCBtZW1vcnkgc3Vic3l0ZW0iDQorCQlmYWlsZWQ9MQ0KIAkJY29u
dGludWUNCiAJZmkNCiANCiAJdGVzdF8kY3VyDQotDQogCXVtb3VudCBtZW1jZy8NCiBkb25lDQog
DQo=
------=_Part_29563_1584719475.1303220561898
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
------=_Part_29563_1584719475.1303220561898
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_29563_1584719475.1303220561898--

