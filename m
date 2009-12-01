Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NFbds-0002bt-Fh
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 22:56:20 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NFbdm-0008SR-NB
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 22:56:20 +0000
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id A9566136AD4D9
	for <ltp-list@lists.sourceforge.net>;
	Tue,  1 Dec 2009 23:54:49 +0100 (CET)
Received: from [90.180.172.144] (helo=debian)
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314) id 1NFbcP-00012P-00
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 23:54:49 +0100
Date: Tue, 01 Dec 2009 23:51:24 +0100
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u3969wwycfnueu@debian>
Subject: [LTP] [PATCH] Small fixes (some bashisms and probable typos)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20091201225124.TBPV4g5aBBiUetBwlrwNusi5N_qGEoPAqydZAS9jEWs@z>

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 .../kernel/controllers/cpuacct/run_cpuacct_test.sh |    6 +++---
 testcases/network/nfs/nfsstat01/nfsstat01          |    2 +-
 testcases/network/tcp_cmds/rdist/rdist01           |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh b/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh
index 38b2ab6..648ead5 100755
--- a/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh
+++ b/testcases/kernel/controllers/cpuacct/run_cpuacct_test.sh
@@ -246,7 +246,7 @@ echo "TEST STARTED: Please avoid using system while this test executes";
 status=0
 case ${TEST_NUM} in
 	"1" )
-		ls $PWD/cpuacct_task01 &> /dev/null
+		ls $PWD/cpuacct_task01 > /dev/null 2>&1
 		if [ $? -ne 0 ]
 		then
 		        echo "TFAIL Task file cpuacct_task01.c not compiled"
@@ -314,7 +314,7 @@ case ${TEST_NUM} in
                         exit -1
                 fi
 
-                ls $PWD/cpuacct_task01 &> /dev/null
+                ls $PWD/cpuacct_task01 > /dev/null 2>&1
                 if [ $? -ne 0 ]
                 then
                         echo "TFAIL Task file cpuacct_task01.c not compiled"
@@ -323,7 +323,7 @@ case ${TEST_NUM} in
 			task_kill 2> /dev/null
 		        exit -1
                 fi
-		for (( m=0 ; m<=$num_online_cpus ; m++ ))
+		for m in $(seq 0 $num_online_cpus)
 		do
 			nr_tasks
         	        echo $pid > $cg_path/group_1/group_11/tasks
diff --git a/testcases/network/nfs/nfsstat01/nfsstat01 b/testcases/network/nfs/nfsstat01/nfsstat01
index 39d73cd..4d2aa20 100755
--- a/testcases/network/nfs/nfsstat01/nfsstat01
+++ b/testcases/network/nfs/nfsstat01/nfsstat01
@@ -48,7 +48,7 @@ HOST=`hostname`
 CLEANUP=${CLEANUP:="ON"}
 VERSION=${VERSION:=2}
 TESTDIR=${TESTDIR:=/tmp/$TC$PID.testdir}
-NFS_TYPE=${NFS_TYPE:nfs}
+NFS_TYPE=${NFS_TYPE:-nfs}
 
 if [ "x$NFS_TYPE" != "xnfs4" ]; then
     OPTS=${OPTS:="-o vers=$VERSION "}
-- 
1.6.4.3




------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
