Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <jstancek@redhat.com>) id 1QCAnU-0005PJ-2x
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 13:16:52 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QCAnR-0002k5-RA
	for ltp-list@lists.sourceforge.net; Tue, 19 Apr 2011 13:16:52 +0000
Received: from mail06.corp.redhat.com (zmail06.collab.prod.int.phx2.redhat.com
	[10.5.5.45])
	by mx3-phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p3JDGi9S002503
	for <ltp-list@lists.sourceforge.net>; Tue, 19 Apr 2011 09:16:44 -0400
Date: Tue, 19 Apr 2011 09:16:44 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1067240850.28848.1303219004077.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
In-Reply-To: <508695279.28083.1303217546129.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_28847_1805416078.1303219004076"
Subject: [LTP] [PATCH] cgroups/cpuacct_setup: fix task_kill() search for
	process
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

------=_Part_28847_1805416078.1303219004076
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit


1. "i* in "grep cpuacct_taski*" seems pointless as
its target is cpuacct_task01

2. using cut fails when ps indents the output as following:
  99 cpuacct_task01
 112 cpuacct_task01
1111 cpuacct_task01

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/controllers/cpuacct/cpuacct_setup.sh    |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


------=_Part_28847_1805416078.1303219004076
Content-Type: text/x-patch; name=0001-cgroups-cpuacct_setup-fix-task_kill.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename=0001-cgroups-cpuacct_setup-fix-task_kill.patch

ZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvY3B1YWNjdC9jcHVhY2N0
X3NldHVwLnNoIGIvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9jcHVhY2N0L2NwdWFjY3Rf
c2V0dXAuc2gNCmluZGV4IDQ3Y2QxZGEuLjI0NDNhMjggMTAwNzU1DQotLS0gYS90ZXN0Y2FzZXMv
a2VybmVsL2NvbnRyb2xsZXJzL2NwdWFjY3QvY3B1YWNjdF9zZXR1cC5zaA0KKysrIGIvdGVzdGNh
c2VzL2tlcm5lbC9jb250cm9sbGVycy9jcHVhY2N0L2NwdWFjY3Rfc2V0dXAuc2gNCkBAIC01OCw3
ICs1OCw3IEBAIGNsZWFudXAgKCkNCiB9DQogdGFza19raWxsICgpDQogew0KLQlmb3IgaSBpbiBg
cHMgLWUgfCBncmVwIGNwdWFjY3RfdGFza2kqIHwgY3V0IC1kIiAiIC1mMWANCisJZm9yIGkgaW4g
YHBzIC1lIHwgZ3JlcCBjcHVhY2N0X3Rhc2sgfCBhd2sgJ3twcmludCAkMX0nYA0KIAlkbw0KIAkJ
a2lsbCAtU0lHVVNSMSAkaQ0KIAlkb25lDQo=
------=_Part_28847_1805416078.1303219004076
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
------=_Part_28847_1805416078.1303219004076
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_28847_1805416078.1303219004076--

