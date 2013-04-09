Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1UPTTM-0003vO-1o
	for ltp-list@lists.sourceforge.net; Tue, 09 Apr 2013 08:00:08 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UPTTK-00086n-DC
	for ltp-list@lists.sourceforge.net; Tue, 09 Apr 2013 08:00:08 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r397xxF4011613
	for <ltp-list@lists.sourceforge.net>; Tue, 9 Apr 2013 15:59:59 +0800
Message-ID: <5163CA00.9040505@cn.fujitsu.com>
Date: Tue, 09 Apr 2013 15:57:52 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <5163C37E.9@cn.fujitsu.com>
In-Reply-To: <5163C37E.9@cn.fujitsu.com>
Subject: [LTP] [PATCHv2] testscripts/test_fs_bind.sh: adapt to system which
 marks mount point as "shared" defaultly
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

Linux kernel does not allow to move a mount residing under a
shared mount.

This patch tries to make sure test cases of "move" run under
a private mount.

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 testscripts/test_fs_bind.sh | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/testscripts/test_fs_bind.sh b/testscripts/test_fs_bind.sh
index 92c51a1..792fff2 100755
--- a/testscripts/test_fs_bind.sh
+++ b/testscripts/test_fs_bind.sh
@@ -107,6 +107,18 @@ test_prereqs()
 		exit -1
 	fi

+	mount --bind "${sandbox}" "${sandbox}" >& /dev/null
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK true "$0: failed to perform bind mount on directory \"${sandbox}\""
+		exit 1
+	fi
+
+	mount --make-private "${sandbox}" >& /dev/null
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK true "$0: failed to make private mountpoint on directory \"${sandbox}\""
+		exit 1
+	fi
+
 	local mnt_bind=1
 	local mnt_move=1

@@ -153,17 +165,11 @@ test_prereqs()
 		tst_resm TINFO "$0: kernel >= 2.6.15 detected -- continuing"
 	fi

-	mount --bind "${sandbox}" "${sandbox}" && {
-		mount --make-shared "${sandbox}" > /dev/null 2>&1 || "${FS_BIND_ROOT}/bin/smount" "${sandbox}" shared
-		umount "${sandbox}" || {
-			tst_resm TFAIL "$0: failed to umount simplest shared subtree"
-			exit 1
-		}
-	} || {
-		tst_brkm TBROK true "$0: failed to perform bind mount"
+	mount --make-shared "${sandbox}" > /dev/null 2>&1 || "${FS_BIND_ROOT}/bin/smount" "${sandbox}" shared
+	umount "${sandbox}" || {
+		tst_resm TFAIL "$0: failed to umount simplest shared subtree"
 		exit 1
 	}
-
 	tst_resm TPASS "$0: umounted simplest shared subtree"

 }
@@ -428,6 +434,9 @@ run_test()
 	save_sandbox "$tname" "$resdir/$tname" || do_break=1
 	save_mounts "$tname" "$resdir/$tname" || do_break=1
 	save_proc_mounts "$tname" "$resdir/$tname" || do_break=1
+	mount --bind "${sandbox}" "${sandbox}" >& /dev/null || do_break=1
+	mount --make-private "${sandbox}" >& /dev/null || do_break=1
+
 	if [ $do_break -eq 1 ]; then
 		tst_brkm TBROK true "$tname: failed to save pre-test state of \"${sandbox}\""
 		return 2
@@ -453,6 +462,7 @@ run_test()
 		#echo "SUCCEEDED"
 		((nsucceeded++))
 	fi
+	umount -l "${sandbox}" >& /dev/null
 	check_proc_mounts "$tname" "$resdir/$tname" || \
 	restore_proc_mounts "$tname" "$resdir/$tname" || do_break=1
 	check_mounts "$tname" "$resdir/$tname" || \
-- 
1.8.1



------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
