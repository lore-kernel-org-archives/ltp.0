Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1XURyW-0007AY-33
	for ltp-list@lists.sourceforge.net; Thu, 18 Sep 2014 03:01:40 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XURyU-0006JB-K9
	for ltp-list@lists.sourceforge.net; Thu, 18 Sep 2014 03:01:40 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s8I31cG1008879
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Sep 2014 11:01:38 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Thu, 18 Sep 2014 11:01:16 +0800
Message-ID: <1411009276-1720-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] runtest/containers: fix errors in netns_par_chld_ftp
	testcase that takes TCONF as TFAIL
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
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

In test case 'testcases/kernel/containers/netns/netns_par_chld_ftp.sh', if iproute tools
do not support setting network namespaces, child process will return TCONF, but parent
process took this as TFAIL wrongly.

So in testcases/lib/test.sh, we introduce tst_record_childstatus()'s shell version, please
see doc/test-writing-guidelines.txt for detailed information this function, it helps to
propagate child process result(child exit status) to the parent process correctly.

In this patch, we fix this issue by using this function.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 .../kernel/containers/netns/netns_par_chld_ftp.sh     |  8 ++------
 testcases/lib/test.sh                                 | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_par_chld_ftp.sh b/testcases/kernel/containers/netns/netns_par_chld_ftp.sh
index 9370a54..67b86bb 100755
--- a/testcases/kernel/containers/netns/netns_par_chld_ftp.sh
+++ b/testcases/kernel/containers/netns/netns_par_chld_ftp.sh
@@ -40,12 +40,8 @@ if [ $? -ne 0 ]; then
 	flag=1
 fi
 
-netns_par_chld_ftp
-if [ $? -eq 0 ]; then
-	tst_resm TPASS "netns_par_child_ftp"
-else
-	tst_resm TFAIL "netns_par_child_ftp"
-fi
+netns_par_chld_ftp &
+tst_record_childstatus $!
 
 if [ $flag -eq 1 ]; then
 	stop_daemon vsftpd
diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 5b9e576..0d16894 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -66,6 +66,25 @@ tst_brkm()
 	tst_exit
 }
 
+tst_record_childstatus()
+{
+	if [ $# -ne 1 ];then
+		tst_resm TWARN "child process id is not valid"
+		return
+	fi
+
+	local child=$1
+	local ret=0
+
+	wait $child
+	ret=$?
+	if [ $ret -eq 127 ];then
+		tst_resm TWARN "child process($child) does not exist"
+		return
+	fi
+	LTP_RET_VAL=$((LTP_RET_VAL|ret))
+}
+
 tst_require_root()
 {
 	if [ "$(id -ru)" != 0 ]; then
-- 
1.8.2.1


------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
