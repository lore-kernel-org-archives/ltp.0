Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1XBjUM-0003nW-NE
	for ltp-list@lists.sourceforge.net; Mon, 28 Jul 2014 11:53:10 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XBjUK-0001Hq-Q0
	for ltp-list@lists.sourceforge.net; Mon, 28 Jul 2014 11:53:10 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s6SBr07v016786
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Jul 2014 19:53:00 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Mon, 28 Jul 2014 19:51:40 +0800
Message-ID: <1406548301-21888-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1406548301-21888-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <20140722143000.GA22955@rei>
	<1406548301-21888-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 2/3] doc: add paragraph to describe using test
	interface in child process
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

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 doc/test-writing-guidelines.txt | 76 ++++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 4779100..965ca6c 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -571,30 +571,42 @@ printed by the parent and each of the children.
 To avoid that, you should either call 'tst_flush()' right before the 'fork()',
 or even better - use 'tst_fork()' instead.
 
-2.2.7 Fork() and Parent-child synchronization
+2.2.7 Using test interface in child process
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+If you have to do some test work in child process, now you can use test interface
+('tst_resm()', 'tst_brkm()', 'tst_exit()', ...) in child process, but there are some
+rules you must obey:
+    1) If you use tst_resm() to record test results in child process, you *MUST* use
+       tst_exit() in the end.
+
+    2) If you use tst_brkm() with a non-NULL cleanup argument in child process, you're
+       strongly recommended to create a separate cleanup function for child process that
+       will only clean up what has been allocated in child process.
+           *Imagine the 'cleanup()' is called both from the parent and child, the test
+            will likely fail in 'tst_rmdir()', because the directory was removed already
+            by the child.
+
+    3) Meanwhile, in parent process, you'd better call tst_record_childstatus() to make
+       child process's test results propagated to parent process correctly.
+
+       [source,c]
+       -------------------------------------------------------------------------------
+       #include "test.h"
+
+       void tst_record_childstatus(void (*cleanup)(void), pid_t child);
+       -------------------------------------------------------------------------------
+       This function will have a waitpid() on child process and record child process's
+       return value in T_exitval correctly.
+
+If you don't plan to use test interface in child process, then you will use a plain exit()
+to report test results to parent process. You'd better use TPASS or TFAIL, other than numerical value.
+
+2.2.8 Fork() and Parent-child synchronization
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 As LTP tests are written for Linux, most of the test involves fork()-ing and
-parent-child process synchronization. But first of all:
-
-WARNING: Usage of test interface ('tst_resm()', 'tst_brkm()', 'tst_exit()',
-         ...) from child process is forbidden.
-
-If you happen to use the interface from a child process the outcome would
-likely be disastrous. Just to name a few examples:
-
-* Imagine the 'cleanup()' is called both from the parent and child, the test
-  will likely fail in 'tst_rmdir()', because the directory was removed
-  already by the child.
-
-* The test failures reported via 'tst_resm()' are not propagated from the
-  child to the parent (how could they, it's just a static variable in the
-  test library). And the test will report success even when the test in the
-  child process has reported failure.
-
-* And many more...
-
-Now to the child-parent synchronization. We have a checkpoint library code
+parent-child process synchronization. We have a checkpoint library code
 that works even for two different processes, all they need to is to run with
 the same working directory (they use FIFO for synchronization). The checkpoint
 interface provides two pairs of signal and wait functions. One pair to be used
@@ -607,7 +619,7 @@ There is also an interface that allows parent to wait until child is blocked
 in kernel (for example waits in 'pause()'), see 'include/tst_process_state.h'
 for more.
 
-2.2.8 Signal handlers
+2.2.9 Signal handlers
 ^^^^^^^^^^^^^^^^^^^^^
 
 If you need to use signal handlers, keep the code short and simple. Don't
@@ -640,14 +652,14 @@ but this one DOES NOT imply volatile (it's just a typedef to int). So the
 correct type for a flag that is changed from a signal handler is either
 'volatile int' or 'volatile sig_atomic_t'.
 
-2.2.9 Kernel Modules
-^^^^^^^^^^^^^^^^^^^^
+2.2.10 Kernel Modules
+^^^^^^^^^^^^^^^^^^^^^
 
 There are certain cases where the test needs a kernel part and userspace part,
 happily, LTP can build a kernel module and then insert it to the kernel on test
 start for you. See 'testcases/kernel/device-drivers/block' for details.
 
-2.2.10 Usefull macros
+2.2.11 Usefull macros
 ^^^^^^^^^^^^^^^^^^^^^
 
 [source,c]
@@ -665,7 +677,7 @@ LTP_ALIGN(x, a)
 
 Aligns the x to be next multiple of a. The a must be power of 2.
 
-2.2.11 Filesystem type detection
+2.2.12 Filesystem type detection
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Some tests are known to fail on certain filesytems (you cannot swap on TMPFS,
@@ -701,7 +713,7 @@ below:
 	}
 -------------------------------------------------------------------------------
 
-2.2.12 Thread-safety in the LTP library
+2.2.13 Thread-safety in the LTP library
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 It is safe to use library 'tst_' functions in multi-threaded tests.
@@ -735,7 +747,7 @@ void test01(void)
 }
 -------------------------------------------------------------------------------
 
-2.2.13 Acquiring a block device
+2.2.14 Acquiring a block device
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Some tests needs a block device (inotify tests, syscall 'EROFS' failures,
@@ -776,7 +788,7 @@ void tst_release_device(void (cleanup_fn)(void), const char *dev);
 
 Releases the device acquired by 'tst_acquire_device()'.
 
-2.2.14 Formatting a device with a filesystem
+2.2.15 Formatting a device with a filesystem
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 [source,c]
@@ -807,7 +819,7 @@ options passed to mkfs.
 The extra options 'fs_opts' should either be 'NULL' if there are none, or a
 'NULL' terminated array of strings such as '{"-b", "1024", NULL}'.
 
-2.2.15 Verifying a filesystem's free space
+2.2.16 Verifying a filesystem's free space
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Some tests have size requirements for the filesystem's free space. If these
@@ -837,7 +849,7 @@ The required free space is calculated by 'size * mult', e.g.
 filesystem, which '"/tmp/testfile"' is in, has 64MB free space at least, and 0
 if not.
 
-2.2.16 Getting the maximum number of links to a regular file or directory
+2.2.17 Getting the maximum number of links to a regular file or directory
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Some tests need to know the maximum count of links to a regular file or
@@ -880,7 +892,7 @@ newly created dir has two links already - the '.' and the link from parent
 dir). If no limit is hit or if 'mkdir(2)' failed with 'ENOSPC' or 'EDQUOT',
 zero is returned and previously created directories are removed.
 
-2.2.17 Getting an unused PID number
+2.2.18 Getting an unused PID number
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 Some tests require a 'PID', which is not used by the OS (does not belong to
-- 
1.8.2.1


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
