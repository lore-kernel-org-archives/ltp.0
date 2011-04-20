Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <jstancek@redhat.com>) id 1QCXxZ-0003oi-Jl
	for ltp-list@lists.sourceforge.net; Wed, 20 Apr 2011 14:00:49 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1QCXxV-0007pQ-MY
	for ltp-list@lists.sourceforge.net; Wed, 20 Apr 2011 14:00:49 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p3KE0dxU027262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 20 Apr 2011 10:00:40 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id p3KE0dXC009385
	for <ltp-list@lists.sourceforge.net>; Wed, 20 Apr 2011 10:00:39 -0400
Message-ID: <4DAEE706.309@redhat.com>
Date: Wed, 20 Apr 2011 16:00:38 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------070608080406040507070900"
Subject: [LTP] [PATCH v2] cgroups/cpuacct_setup: fix task_kill() search for
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

This is a multi-part message in MIME format.
--------------070608080406040507070900
Content-Type: text/plain; charset=UTF-8; format=flowed
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



--------------070608080406040507070900
Content-Type: text/x-patch;
	name="0001-cgroups-cpuacct_setup-fix-task_kill-search-for-proce.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-cgroups-cpuacct_setup-fix-task_kill-search-for-proce.pa";
	filename*1="tch"

diff --git a/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh b/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh
index 47cd1da..2443a28 100755
--- a/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh
+++ b/testcases/kernel/controllers/cpuacct/cpuacct_setup.sh
@@ -58,7 +58,7 @@ cleanup ()
 }
 task_kill ()
 {
-	for i in `ps -e | grep cpuacct_taski* | cut -d" " -f1`
+	for i in `ps -e | grep cpuacct_task | awk '{print $1}'`
 	do
 		kill -SIGUSR1 $i
 	done


--------------070608080406040507070900
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
--------------070608080406040507070900
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------070608080406040507070900--

