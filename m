Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <jstancek@redhat.com>) id 1QCAsV-0004di-QC
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 13:22:03 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QCAsV-0002wc-4e
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 13:22:03 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p3JDLvZi003040
	for <ltp-list@lists.sourceforge.net>; Tue, 19 Apr 2011 09:21:57 -0400
Date: Tue, 19 Apr 2011 09:21:57 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <2128371302.29010.1303219317394.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_29009_478793903.1303219317393"
Subject: [LTP] [PATCH] cgroups/cpuset_base_ops: 6 is valid value for
 sched_relax_domain_level
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

------=_Part_29009_478793903.1303219317393
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


commit 01a08546af311c065f34727787dd0cc8dc0c216f in linux
kernel tree introduced SD_LV_BOOK, which made value "6" valid.

It is questionable if this test should be in at all,
the sched domain mapping can be completely overridden by
the architecture-specific code.

Anyway, a quick solution for now is to skip testing value "6",
as it may work on newer kernels.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../cpuset_base_ops_testset.sh                     |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)


------=_Part_29009_478793903.1303219317393
Content-Type: text/x-patch;
	name=0001-cgroups-cpuset_base_ops-6-is-valid-value-for-sched_r.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0001-cgroups-cpuset_base_ops-6-is-valid-value-for-sched_r.patch

ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvY3B1c2V0L2NwdXNldF9i
YXNlX29wc190ZXN0L2NwdXNldF9iYXNlX29wc190ZXN0c2V0LnNoIGIvdGVzdGNhc2VzL2tlcm5l
bC9jb250cm9sbGVycy9jcHVzZXQvY3B1c2V0X2Jhc2Vfb3BzX3Rlc3QvY3B1c2V0X2Jhc2Vfb3Bz
X3Rlc3RzZXQuc2gNCmluZGV4IDJiMTAxNmUuLmRhMWY2ZGEgMTAwNzU1DQotLS0gYS90ZXN0Y2Fz
ZXMva2VybmVsL2NvbnRyb2xsZXJzL2NwdXNldC9jcHVzZXRfYmFzZV9vcHNfdGVzdC9jcHVzZXRf
YmFzZV9vcHNfdGVzdHNldC5zaA0KKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9j
cHVzZXQvY3B1c2V0X2Jhc2Vfb3BzX3Rlc3QvY3B1c2V0X2Jhc2Vfb3BzX3Rlc3RzZXQuc2gNCkBA
IC0xOTAsMTIgKzE5MCwxMyBAQCB0ZXN0X2RvbWFpbigpDQogCQkzCTMNCiAJCTQJNA0KIAkJNQk1
DQotCQk2CVdSSVRFX0VSUk9SDQorCQk3CVdSSVRFX0VSUk9SDQogCQktMQktMQ0KIAkJLTIJV1JJ
VEVfRVJST1INCiAJCUEJV1JJVEVfRVJST1INCiAJRU9GDQogCSMgd2hpbGUgcmVhZCBkb21haW5f
bGV2ZWwgcmVzdWx0DQorCSMgY2hhbmdlZCBsaW1pdCB0byA3LCBhcyA2IG1pZ2h0IHN1Y2NlZWQs
IHNlZSBTRF9MVl9NQVggaW4gaW5jbHVkZS9saW51eC9zY2hlZC5oDQogfQ0KIA0KICMgYXR0YWNo
X3Rhc2tfdGVzdCA8Y3B1cz4gPG1lbXM+IDxleHBlY3Q+DQo=
------=_Part_29009_478793903.1303219317393
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
------=_Part_29009_478793903.1303219317393
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_29009_478793903.1303219317393--

