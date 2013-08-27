Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1VE9hR-00035Q-VJ
	for ltp-list@lists.sourceforge.net; Tue, 27 Aug 2013 03:12:10 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VE9hQ-0007nt-Hi
	for ltp-list@lists.sourceforge.net; Tue, 27 Aug 2013 03:12:09 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r7R3BxbO008935
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Aug 2013 11:11:59 +0800
Message-ID: <521C198C.4020604@cn.fujitsu.com>
Date: Tue, 27 Aug 2013 11:14:20 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2] mount/mount05.c: format the device when necessary
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
To: LTP list <ltp-list@lists.sourceforge.net>


Format the device only when "-D device" & "-T type" are specified.

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mount/mount05.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/mount/mount05.c b/testcases/kernel/syscalls/mount/mount05.c
index 4b2a07c..fb5a385 100644
--- a/testcases/kernel/syscalls/mount/mount05.c
+++ b/testcases/kernel/syscalls/mount/mount05.c
@@ -113,7 +113,6 @@ int main(int argc, char *argv[])
 void setup(void)
 {
 	tst_require_root(NULL);
-	tst_mkfs(NULL, device, fstype, NULL);

 	tst_sig(NOFORK, DEF_HANDLER, cleanup);

@@ -122,9 +121,12 @@ void setup(void)
 	SAFE_MKDIR(cleanup, mntpoint_src, DIR_MODE);
 	SAFE_MKDIR(cleanup, mntpoint_des, DIR_MODE);

-	if (dflag && tflag)
+	if (dflag) {
+		tst_mkfs(NULL, device, fs_type, NULL);
+
 		if (mount(device, mntpoint_src, fs_type, 0, NULL) == -1)
 			tst_brkm(TBROK | TERRNO, cleanup, "mount failed");
+	}

 	SAFE_FILE_PRINTF(cleanup, file_src, "TEST FILE");

@@ -133,7 +135,7 @@ void setup(void)

 void cleanup(void)
 {
-	if (dflag && tflag)
+	if (dflag)
 		if (umount(mntpoint_src) != 0)
 			tst_brkm(TBROK | TTERRNO, NULL, "umount(2) failed");

-- 
1.8.1

------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
