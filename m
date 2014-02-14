Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1WEFlB-0000gm-9H
	for ltp-list@lists.sourceforge.net; Fri, 14 Feb 2014 10:12:41 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WEFl9-0003la-WB
	for ltp-list@lists.sourceforge.net; Fri, 14 Feb 2014 10:12:41 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s1EACW2W016634
	for <ltp-list@lists.sourceforge.net>; Fri, 14 Feb 2014 18:12:32 +0800
Message-ID: <1392372746.2085.11.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Fri, 14 Feb 2014 18:12:26 +0800
In-Reply-To: <1392372604.2085.10.camel@G08JYZSD130126>
References: <1392372604.2085.10.camel@G08JYZSD130126>
Mime-Version: 1.0
Subject: [LTP] [PATCH 2/2] mlock/mlock02.c: add EPERM errno test
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
To: ltp-list <ltp-list@lists.sourceforge.net>

Add EPERM errno test for mlock(2).

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/mlock/mlock02.c | 42 +++++++++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/mlock/mlock02.c b/testcases/kernel/syscalls/mlock/mlock02.c
index a635d24..1e87777 100644
--- a/testcases/kernel/syscalls/mlock/mlock02.c
+++ b/testcases/kernel/syscalls/mlock/mlock02.c
@@ -20,11 +20,15 @@
  * ALGORITHM
  * 	test 1:
  *		Call mlock with a NULL address.  ENOMEM should be returned
+ *	test 2:
+ *		The  caller  was  not  privileged and its RLIMIT_MEMLOCK soft
+ *		resource limit was 0. EPERM should be returned
  */
 
 #include <errno.h>
 #include <unistd.h>
 #include <sys/mman.h>
+#include <pwd.h>
 #include "test.h"
 #include "usctest.h"
 #include "safe_macros.h"
@@ -32,20 +36,26 @@
 char *TCID = "mlock02";
 
 static void *addr1;
+static struct passwd *ltpuser;
 static void setup(void);
 static void mlock_verify(int);
+static void setup2(void);
+static void cleanup2(void);
 static void cleanup(void);
 
 static struct test_case_t {
 	void **addr;
 	int len;
 	int error;
+	void (*setupfunc) ();
+	void (*cleanupfunc) ();
 } TC[] = {
-	{&addr1, 1024, ENOMEM},
+	{&addr1, 1024, ENOMEM, NULL, NULL},
+	{&addr1, 1024, EPERM, setup2, cleanup2},
 };
 
 int TST_TOTAL = ARRAY_SIZE(TC);
-static int exp_enos[] = { ENOMEM, 0 };
+static int exp_enos[] = { ENOMEM, EPERM, 0 };
 
 #if !defined(UCLINUX)
 
@@ -85,6 +95,8 @@ int main(void)
 
 static void setup(void)
 {
+	struct rlimit rl;
+
 	TEST_PAUSE;
 
 #ifdef __ia64__
@@ -92,12 +104,28 @@ static void setup(void)
 #else
 	addr1 = NULL;
 #endif
+	ltpuser = SAFE_GETPWNAM(cleanup, "nobody");
+
+	rl.rlim_cur = 0;
+
+	if (setrlimit(RLIMIT_MEMLOCK, &rl) != 0) {
+		tst_resm(TWARN,
+			 "setrlimit failed to set the resource for "
+			 "RLIMIT_MEMLOCK to check for mlock()");
+		return;
+	}
 }
 
 static void mlock_verify(int i)
 {
+	if (TC[i].setupfunc != NULL)
+		TC[i].setupfunc();
+
 	TEST(mlock(*(TC[i].addr), TC[i].len));
 
+	if (TC[i].cleanupfunc != NULL)
+		TC[i].cleanupfunc();
+
 	if (TEST_RETURN != -1) {
 		tst_resm(TFAIL, "mlock succeeded unexpectedly");
 		return;
@@ -112,6 +140,16 @@ static void mlock_verify(int i)
 	}
 }
 
+static void setup2(void)
+{
+	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
+}
+
+static void cleanup2(void)
+{
+	SAFE_SETEUID(cleanup, 0);
+}
+
 static void cleanup(void)
 {
 	TEST_CLEANUP;
-- 
1.8.4.2




------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
