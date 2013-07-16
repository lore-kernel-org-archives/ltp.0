Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1Uyvew-0001Kj-Go
	for ltp-list@lists.sourceforge.net; Tue, 16 Jul 2013 03:10:38 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Uyveu-0006Gw-EA
	for ltp-list@lists.sourceforge.net; Tue, 16 Jul 2013 03:10:38 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r6G3AQid018886
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Jul 2013 11:10:29 +0800
Message-ID: <51E4B956.9020708@cn.fujitsu.com>
Date: Tue, 16 Jul 2013 11:09:10 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] inotify/inotify03.c: cleanup a parameter-passing error
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


1. Revise code to follow ltp-code-style

2. Fix a bad parameter-passing which causes mount(2) "EINVAL"

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 testcases/kernel/syscalls/inotify/inotify03.c | 48 +++++++++++----------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index 12545b8..f17004f 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -59,7 +59,7 @@ int TST_TOTAL = 3;

 #define EVENT_MAX 1024
 /* size of the event structure, not counting name */
-#define EVENT_SIZE (sizeof (struct inotify_event))
+#define EVENT_SIZE (sizeof(struct inotify_event))
 /* reasonable guess as to size of 1024 events */
 #define EVENT_BUF_LEN		(EVENT_MAX * (EVENT_SIZE + 16))

@@ -77,37 +77,35 @@ int event_set[EVENT_MAX];

 char event_buf[EVENT_BUF_LEN];

-#define DIR_MODE	S_IRWXU | S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP
+#define DIR_MODE	(S_IRWXU | S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP)

-static char *Fstype;
 static char mntpoint[20];
-static int mount_flag = 0;
+static int mount_flag;
 static char *fstype = "ext2";
 static char *device;
-static int Tflag = 0;
-static int Dflag = 0;
+static int dflag;

 static option_t options[] = {
-	{"T:", &Tflag, &fstype},
-	{"D:", &Dflag, &device},
+	{"T:", NULL, &fstype},
+	{"D:", &dflag, &device},
 	{NULL, NULL, NULL}
 };

-int main(int ac, char **av)
+int main(int argc, char *argv[])
 {
 	char *msg;
 	int ret;
 	int len, i, test_num;

-	if ((msg = parse_opts(ac, av, options, &help)) != NULL)
+	msg = parse_opts(argc, argv, options, &help);
+	if (msg != NULL)
 		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);

 	/* Check for mandatory option of the testcase */
-	if (!Dflag) {
+	if (!dflag)
 		tst_brkm(TBROK, NULL, "You must specifiy the device used for "
 			 " mounting with -D option, Run '%s  -h' for option "
 			 " information.", TCID);
-	}

 	setup();

@@ -207,8 +205,8 @@ static void setup(void)
 	}

 	/* Call mount(2) */
-	tst_resm(TINFO, "mount %s to %s fstype=%s", device, mntpoint, Fstype);
-	TEST(mount(device, mntpoint, Fstype, 0, NULL));
+	tst_resm(TINFO, "mount %s to %s fstype=%s", device, mntpoint, fstype);
+	TEST(mount(device, mntpoint, fstype, 0, NULL));

 	/* check return code */
 	if (TEST_RETURN != 0) {
@@ -231,43 +229,37 @@ static void setup(void)
 	}

 	/* close the file we have open */
-	if (close(fd) == -1) {
+	if (close(fd) == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "close(%s) failed", fname);
-	}

 	fd_notify = myinotify_init();

 	if (fd_notify < 0) {
-		if (errno == ENOSYS) {
+		if (errno == ENOSYS)
 			tst_brkm(TCONF, cleanup,
 				 "inotify is not configured in this kernel.");
-		} else {
+		else
 			tst_brkm(TBROK | TERRNO, cleanup,
 				 "inotify_init failed");
-		}
 	}

 	wd = myinotify_add_watch(fd_notify, fname, IN_ALL_EVENTS);
-	if (wd < 0) {
+	if (wd < 0)
 		tst_brkm(TBROK | TERRNO, cleanup,
 			 "inotify_add_watch (%d, %s, IN_ALL_EVENTS) failed.",
 			 fd_notify, fname);
-	};
-
 }

 static void cleanup(void)
 {
-	if (close(fd_notify) == -1) {
+	if (close(fd_notify) == -1)
 		tst_resm(TWARN | TERRNO, "close(%d) failed", fd_notify);
-	}

 	if (mount_flag) {
 		TEST(umount(mntpoint));
-		if (TEST_RETURN != 0) {
+		if (TEST_RETURN != 0)
 			tst_resm(TWARN | TTERRNO, "umount(%s) failed",
 				 mntpoint);
-		}
 	}

 	TEST_CLEANUP;
@@ -278,8 +270,8 @@ static void cleanup(void)
 static void help(void)
 {
 	printf("-T type : specifies the type of filesystem to be mounted."
-	       " Default ext2. \n");
-	printf("-D device : device used for mounting \n");
+	       " Default ext2.\n");
+	printf("-D device : device used for mounting.\n");
 }

 #else
-- 
1.8.1

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
