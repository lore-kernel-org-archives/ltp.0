Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1QTx8W-0001xT-S8
	for ltp-list@lists.sourceforge.net; Tue, 07 Jun 2011 14:20:04 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1QTx8R-0005sf-BL
	for ltp-list@lists.sourceforge.net; Tue, 07 Jun 2011 14:20:04 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p57EJreY026461
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jun 2011 10:19:53 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id p57EJqUR008155
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jun 2011 10:19:53 -0400
Message-ID: <4DEE3388.5010307@redhat.com>
Date: Tue, 07 Jun 2011 16:19:52 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030401010503050109070302"
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
--------------030401010503050109070302
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



--------------030401010503050109070302
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


--------------030401010503050109070302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
--------------030401010503050109070302
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------030401010503050109070302--

