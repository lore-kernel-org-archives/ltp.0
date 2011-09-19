Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1R5ZfX-0001aV-GO
	for ltp-list@lists.sourceforge.net; Mon, 19 Sep 2011 08:57:39 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1R5ZfT-0002Yh-Ly
	for ltp-list@lists.sourceforge.net; Mon, 19 Sep 2011 08:57:39 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p8J8vTTx008738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Sep 2011 04:57:30 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id p8J8vSfp009450
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Sep 2011 04:57:29 -0400
Message-ID: <4E7703F8.9000905@redhat.com>
Date: Mon, 19 Sep 2011 10:57:28 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040600000501020101090001"
Subject: [LTP] [PATCH] cgroup/cpuctl: clean cpuctl_task_* in case of OOM
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
--------------040600000501020101090001
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


If one of cpuctl_task_* gets killed by OOM, it won't
signal run script with SIGUSR1, and trap action
"killall cpuctl_task_*;" never runs.

Try to kill all left over cpuctl_task_* in cleanup() to be sure,
none are left behind.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
  testcases/kernel/controllers/cpuctl/parameters.sh |    2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)



--------------040600000501020101090001
Content-Type: text/x-patch;
	name="0001-cgroup-cpuctl-clean-cpuctl_task_-in-case-of-OOM.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-cgroup-cpuctl-clean-cpuctl_task_-in-case-of-OOM.patch"

diff --git a/testcases/kernel/controllers/cpuctl/parameters.sh b/testcases/kernel/controllers/cpuctl/parameters.sh
index 502944e..5f87695 100755
--- a/testcases/kernel/controllers/cpuctl/parameters.sh
+++ b/testcases/kernel/controllers/cpuctl/parameters.sh
@@ -70,6 +70,8 @@ cleanup ()
         echo "Cleanup called";
 	killall cpuctl_def_task01 1>/dev/null 2>&1;
 	killall cpuctl_def_task02 1>/dev/null 2>&1;
+	killall cpuctl_task_* 1>/dev/null 2>&1;
+	sleep 1
         rm -f cpuctl_task_* 2>/dev/null
 	for task in `cat /dev/cpuctl/group_def/tasks`; do
 		echo $task > /dev/cpuctl/tasks 2>/dev/null 1>&2;


--------------040600000501020101090001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
BlackBerry&reg; DevCon Americas, Oct. 18-20, San Francisco, CA
Learn about the latest advances in developing for the 
BlackBerry&reg; mobile platform with sessions, labs & more.
See new tools and technologies. Register for BlackBerry&reg; DevCon today!
http://p.sf.net/sfu/rim-devcon-copy1 
--------------040600000501020101090001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------040600000501020101090001--

