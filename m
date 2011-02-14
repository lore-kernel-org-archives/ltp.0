Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <penght@cn.fujitsu.com>) id 1Poo37-0005Gs-KS
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 02:20:25 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Poo35-0000aC-6Z
	for ltp-list@lists.sourceforge.net; Mon, 14 Feb 2011 02:20:25 +0000
Message-ID: <4D58916C.6010800@cn.fujitsu.com>
Date: Mon, 14 Feb 2011 10:20:28 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] cleanup() should not be called before setup() in
 cases dup3_01 and eventfd2_01
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi Garrett,

Signed-off-by: Peng Haitao <penght@cn.fujitsu.com>

---
 testcases/kernel/syscalls/dup3/dup3_01.c         |    4 ++--
 testcases/kernel/syscalls/eventfd2/eventfd2_01.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/dup3/dup3_01.c b/testcases/kernel/syscalls/dup3/dup3_01.c
index c95e79a..a0f1d63 100644
--- a/testcases/kernel/syscalls/dup3/dup3_01.c
+++ b/testcases/kernel/syscalls/dup3/dup3_01.c
@@ -126,7 +126,7 @@ int main(int argc, char *argv[])
 	int fd, coe;
 
 	if ((tst_kvercmp(2, 6, 27)) < 0)
-		tst_brkm(TCONF, cleanup,
+		tst_brkm(TCONF, NULL,
 			 "This test can only run on kernels that are 2.6.27 and higher");
 	setup();
 
@@ -161,4 +161,4 @@ int main(int argc, char *argv[])
 
 	cleanup();
 	tst_exit();
-}
\ No newline at end of file
+}
diff --git a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
index 38f2ed0..0e87e85 100644
--- a/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
+++ b/testcases/kernel/syscalls/eventfd2/eventfd2_01.c
@@ -133,7 +133,7 @@ int main(int argc, char *argv[])
 	int fd, coe;
 
 	if ((tst_kvercmp(2, 6, 27)) < 0) {
-		tst_brkm(TCONF, cleanup,
+		tst_brkm(TCONF, NULL,
 		    "This test can only run on kernels that are 2.6.27 and higher");
 	}
 	setup();
@@ -167,4 +167,4 @@ int main(int argc, char *argv[])
 	tst_resm(TPASS, "eventfd2(EFD_CLOEXEC) Passed");
 	cleanup();
 	tst_exit();
-}
\ No newline at end of file
+}
-- 
1.7.3.1

-- 
Best Regards,
Peng Haitao


------------------------------------------------------------------------------
The ultimate all-in-one performance toolkit: Intel(R) Parallel Studio XE:
Pinpoint memory and threading errors before they happen.
Find and fix more than 250 security defects in the development cycle.
Locate bottlenecks in serial and parallel code that limit performance.
http://p.sf.net/sfu/intel-dev2devfeb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
