From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 17:40:51 +0200
Subject: [LTP] [COMMITTED] [PATCH 04/13] Make use of SAFE_OPEN()
In-Reply-To: <20171003154100.807-1-chrubis@suse.cz>
References: <20171003154100.807-1-chrubis@suse.cz>
Message-ID: <20171003154100.807-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 .../kernel/controllers/cpuctl/cpuctl_def_task01.c  |  5 ++-
 .../kernel/controllers/cpuctl/cpuctl_def_task02.c  |  6 ++--
 .../kernel/controllers/cpuctl/cpuctl_def_task03.c  |  5 ++-
 .../kernel/controllers/cpuctl/cpuctl_def_task04.c  |  5 ++-
 .../kernel/controllers/cpuctl/cpuctl_test01.c      |  7 ++---
 .../kernel/controllers/cpuctl/cpuctl_test02.c      |  7 ++---
 .../kernel/controllers/cpuctl/cpuctl_test03.c      |  7 ++---
 .../kernel/controllers/cpuctl/cpuctl_test04.c      |  7 ++---
 testcases/kernel/device-drivers/rtc/rtc01.c        |  6 ++--
 .../kernel/device-drivers/tbio/tbio_user/tbio.c    |  6 +---
 testcases/kernel/fs/ftest/ftest01.c                |  7 ++---
 testcases/kernel/fs/ftest/ftest03.c                |  9 ++----
 testcases/kernel/fs/ftest/ftest04.c                | 16 ++--------
 testcases/kernel/fs/ftest/ftest05.c                |  8 ++---
 testcases/kernel/fs/ftest/ftest07.c                |  8 ++---
 testcases/kernel/fs/ftest/ftest08.c                |  8 ++---
 testcases/kernel/logging/kmsg/kmsg01.c             | 28 +++++------------
 testcases/kernel/mem/lib/mem.c                     |  8 ++---
 testcases/kernel/mem/vma/vma03.c                   |  4 +--
 testcases/kernel/pty/hangup01.c                    |  5 ++-
 testcases/kernel/pty/ptem01.c                      | 26 ++++------------
 testcases/kernel/pty/pty01.c                       | 36 +++++-----------------
 testcases/kernel/syscalls/chmod/chmod01.c          |  6 +---
 testcases/kernel/syscalls/chmod/chmod07.c          |  6 +---
 .../kernel/syscalls/fadvise/posix_fadvise01.c      |  8 ++---
 .../kernel/syscalls/fadvise/posix_fadvise03.c      |  8 ++---
 testcases/kernel/syscalls/fallocate/fallocate01.c  | 11 ++-----
 testcases/kernel/syscalls/fallocate/fallocate03.c  |  5 ++-
 testcases/kernel/syscalls/fchmod/fchmod05.c        |  7 +----
 testcases/kernel/syscalls/fcntl/fcntl14.c          | 14 +++------
 testcases/kernel/syscalls/fcntl/fcntl16.c          |  6 ++--
 testcases/kernel/syscalls/flock/flock01.c          |  5 ++-
 testcases/kernel/syscalls/flock/flock06.c          |  5 ++-
 testcases/kernel/syscalls/fork/fork04.c            |  8 ++---
 testcases/kernel/syscalls/fork/fork10.c            |  5 +--
 testcases/kernel/syscalls/fstat/fstat01.c          |  5 ++-
 testcases/kernel/syscalls/fstat/fstat03.c          |  5 +--
 testcases/kernel/syscalls/fstat/fstat05.c          |  5 +--
 testcases/kernel/syscalls/ftruncate/ftruncate01.c  |  7 ++---
 testcases/kernel/syscalls/ftruncate/ftruncate02.c  |  7 ++---
 testcases/kernel/syscalls/inotify/inotify03.c      |  6 +---
 testcases/kernel/syscalls/ioctl/ioctl01.c          |  5 ++-
 testcases/kernel/syscalls/ioctl/ioctl02.c          | 10 ++----
 testcases/kernel/syscalls/mincore/mincore02.c      |  8 ++---
 testcases/kernel/syscalls/mlock/mlock04.c          |  4 +--
 testcases/kernel/syscalls/mprotect/mprotect01.c    |  5 ++-
 testcases/kernel/syscalls/open/open05.c            |  4 +--
 testcases/kernel/syscalls/open/open11.c            |  4 +--
 testcases/kernel/syscalls/readahead/readahead02.c  |  4 +--
 testcases/kernel/syscalls/sendfile/sendfile08.c    |  8 ++---
 testcases/kernel/syscalls/setfsuid/setfsuid04.c    |  5 ++-
 testcases/kernel/syscalls/setresuid/setresuid04.c  |  5 ++-
 testcases/kernel/syscalls/setreuid/setreuid07.c    |  6 ++--
 testcases/kernel/syscalls/setuid/setuid04.c        |  5 ++-
 54 files changed, 116 insertions(+), 310 deletions(-)

diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
index ae6a37429..90119e4ad 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task01.c
@@ -57,6 +57,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
+#include "safe_macros.h"
 
 #ifdef DEBUG
 #define dbg(x...)	printf(x);
@@ -137,9 +138,7 @@ int main(int argc, char *argv[])
 	write_to_file(mysharesfile, "w", myshares);
 	dbg("Default task's initial shares = %u", myshares);
 
-	fd = open("./myfifo", 0);
-	if (fd == -1)
-		tst_brkm(TBROK, cleanup, "Could not open fifo to synchronizae");
+	fd = SAFE_OPEN(cleanup, "./myfifo", 0);
 
 	read(fd, &ch, 1);	/* To fire all the tasks up at the same time */
 
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
index 5fb3559c0..dc1546e88 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task02.c
@@ -60,6 +60,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
+#include "safe_macros.h"
 
 #define TIME_INTERVAL	30	/* Time interval in seconds */
 #define NUM_INTERVALS	3	/* How many iterations of TIME_INTERVAL */
@@ -148,10 +149,7 @@ int main(int argc, char *argv[])
 	pid = getpid();
 	write_to_file(mytaskfile, "a", pid);	/* Assign task to it's group */
 
-	fd = open("./myfifo", 0);
-	if (fd == -1)
-		tst_brkm(TBROK, cleanup,
-			 "Could not open fifo for synchronization");
+	fd = SAFE_OPEN(cleanup, "./myfifo", 0);
 
 	read(fd, &ch, 1);	/* Block task here to synchronize */
 
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
index af4695f28..92b451793 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task03.c
@@ -61,6 +61,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
+#include "safe_macros.h"
 
 #define TIME_INTERVAL	30	/* Time interval in seconds */
 #define NUM_INTERVALS	2	/* How many iterations of TIME_INTERVAL */
@@ -144,9 +145,7 @@ int main(int argc, char *argv[])
 	pid = getpid();
 	write_to_file(mytaskfile, "a", pid);	/* Assign task to it's group */
 
-	fd = open("./myfifo", 0);
-	if (fd == -1)
-		tst_brkm(TBROK, cleanup, "Could not open fifo synchronize");
+	fd = SAFE_OPEN(cleanup, "./myfifo", 0);
 
 	read(fd, &ch, 1);	/* Block task here to synchronize */
 
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c b/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
index 9a7da9b36..c3348fb31 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_def_task04.c
@@ -61,6 +61,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
+#include "safe_macros.h"
 
 #define TIME_INTERVAL	100	/* Time interval in seconds */
 #define NUM_INTERVALS	2	/* How many iterations of TIME_INTERVAL */
@@ -154,9 +155,7 @@ int main(int argc, char *argv[])
 	mygroup_shares = 100;
 	write_to_file(mysharesfile, "w", mygroup_shares);
 
-	fd = open("./myfifo", 0);
-	if (fd == -1)
-		tst_brkm(TBROK, cleanup, "Could not open fifo synchronize");
+	fd = SAFE_OPEN(cleanup, "./myfifo", 0);
 
 	read(fd, &ch, 1);	/* Block task here to synchronize */
 
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test01.c b/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
index 385ee32fd..0cd587c3a 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test01.c
@@ -62,6 +62,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
+#include "safe_macros.h"
 
 #define TIME_INTERVAL	30	/* Time interval in seconds */
 #define NUM_INTERVALS	3	/* How many iterations of TIME_INTERVAL */
@@ -139,11 +140,7 @@ int main(int argc, char *argv[])
 	write_to_file(mytaskfile, "a", pid);	/* Assign the task to it's group */
 	write_to_file(mysharesfile, "w", myshares);
 
-	fd = open("./myfifo", 0);
-	if (fd == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "Could not open fifo for synchronization");
-	}
+	fd = SAFE_OPEN(cleanup, "./myfifo", 0);
 
 	fprintf(stdout, "\ntask-%d SHARES=%lu\n", my_group_num, myshares);
 	read(fd, &ch, 1);	/* To block all tasks here and fire them up at the same time */
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
index 6f5a0d9bf..d775a3e9f 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test02.c
@@ -61,6 +61,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
+#include "safe_macros.h"
 
 #define TIME_INTERVAL	30	/* Time interval in seconds */
 #define NUM_INTERVALS	3	/* How many iterations of TIME_INTERVAL */
@@ -151,11 +152,7 @@ int main(int argc, char *argv[])
 	pid = getpid();
 	write_to_file(mytaskfile, "a", pid);	/* Assign the task to it's group */
 
-	fd = open("./myfifo", 0);
-	if (fd == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "Could not open fifo for synchronization");
-	}
+	fd = SAFE_OPEN(cleanup, "./myfifo", 0);
 
 	read(fd, &ch, 1);	/* To block all tasks here and fire them up at the same time */
 
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
index 5076ab98a..8a80d6932 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test03.c
@@ -61,6 +61,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
+#include "safe_macros.h"
 
 #define TIME_INTERVAL	30	/* Time interval in seconds */
 #define NUM_INTERVALS	2	/* How many iterations of TIME_INTERVAL */
@@ -147,11 +148,7 @@ int main(int argc, char *argv[])
 	pid = getpid();
 	write_to_file(mytaskfile, "a", pid);	/* Assign the task to it's group */
 
-	fd = open("./myfifo", 0);
-	if (fd == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "Could not open fifo for synchronization");
-	}
+	fd = SAFE_OPEN(cleanup, "./myfifo", 0);
 
 	read(fd, &ch, 1);	/* To block all tasks here and fire them up at the same time */
 
diff --git a/testcases/kernel/controllers/cpuctl/cpuctl_test04.c b/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
index 0daca0ef5..bc67f41d9 100644
--- a/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
+++ b/testcases/kernel/controllers/cpuctl/cpuctl_test04.c
@@ -61,6 +61,7 @@
 
 #include "../libcontrollers/libcontrollers.h"
 #include "test.h"		/* LTP harness APIs */
+#include "safe_macros.h"
 
 #define TIME_INTERVAL	100	/* Time interval in seconds */
 #define NUM_INTERVALS	2	/* How many iterations of TIME_INTERVAL */
@@ -158,11 +159,7 @@ int main(int argc, char *argv[])
 
 	write_to_file(mytaskfile, "a", getpid());	/* Assign the task to it's group */
 
-	fd = open("./myfifo", 0);
-	if (fd == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "Could not open fifo for synchronization");
-	}
+	fd = SAFE_OPEN(cleanup, "./myfifo", 0);
 
 	read(fd, &ch, 1);	/* To block all tasks here and fire them up at the same time */
 
diff --git a/testcases/kernel/device-drivers/rtc/rtc01.c b/testcases/kernel/device-drivers/rtc/rtc01.c
index b3c7e1df6..8a1f62ead 100644
--- a/testcases/kernel/device-drivers/rtc/rtc01.c
+++ b/testcases/kernel/device-drivers/rtc/rtc01.c
@@ -33,6 +33,7 @@
 #include <time.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 int rtc_fd = -1;
 char *TCID = "rtc01";
@@ -228,10 +229,7 @@ int main(int argc, char *argv[])
 	if (access(rtc_dev, F_OK) == -1)
 		tst_brkm(TCONF, NULL, "couldn't find rtc device '%s'", rtc_dev);
 
-	rtc_fd = open(rtc_dev, O_RDONLY);
-
-	if (rtc_fd < 0)
-		tst_brkm(TBROK | TERRNO, NULL, "couldn't open %s", rtc_dev);
+	rtc_fd = SAFE_OPEN(NULL, rtc_dev, O_RDONLY);
 
 	/*Read and alarm tests */
 	read_alarm_test();
diff --git a/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c b/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
index 4ab6b8344..be1420b98 100644
--- a/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
+++ b/testcases/kernel/device-drivers/tbio/tbio_user/tbio.c
@@ -133,11 +133,7 @@ void setup(void)
 			tst_brkm(TBROK | TERRNO, cleanup, "mknod() failed");
 	}
 
-	tbio_fd = open(DEVICE_NAME, O_RDWR);
-	if (tbio_fd < 0) {
-		tst_brkm(TBROK | TERRNO, cleanup, "open of %s failed",
-			DEVICE_NAME);
-	}
+	tbio_fd = SAFE_OPEN(cleanup, DEVICE_NAME, O_RDWR);
 
 	tst_resm(TINFO, "Device opened successfully ");
 }
diff --git a/testcases/kernel/fs/ftest/ftest01.c b/testcases/kernel/fs/ftest/ftest01.c
index f7e320cd9..afad18095 100644
--- a/testcases/kernel/fs/ftest/ftest01.c
+++ b/testcases/kernel/fs/ftest/ftest01.c
@@ -159,11 +159,8 @@ static void runtest(void)
 
 		test_name[0] = 'a' + i;
 		test_name[1] = '\0';
-		fd = open(test_name, O_RDWR | O_CREAT | O_TRUNC, 0666);
-
-		if (fd < 0)
-			tst_brkm(TBROK | TERRNO, NULL, "Can't create %s/%s",
-				 fuss, test_name);
+		fd = SAFE_OPEN(NULL, test_name, O_RDWR | O_CREAT | O_TRUNC,
+			       0666);
 
 		if ((child = fork()) == 0) {
 			dotest(nchild, i, fd);
diff --git a/testcases/kernel/fs/ftest/ftest03.c b/testcases/kernel/fs/ftest/ftest03.c
index 4d0fc803a..ed69e5736 100644
--- a/testcases/kernel/fs/ftest/ftest03.c
+++ b/testcases/kernel/fs/ftest/ftest03.c
@@ -179,13 +179,8 @@ static void runtest(void)
 		test_name[0] = 'a' + i;
 		test_name[1] = '\0';
 
-		fd = open(test_name, O_RDWR | O_CREAT | O_TRUNC, 0666);
-
-		if (fd < 0) {
-			tst_brkm(TBROK, NULL, "\tError %d creating %s/%s.",
-				 errno,
-				 fuss, test_name);
-		}
+		fd = SAFE_OPEN(NULL, test_name, O_RDWR | O_CREAT | O_TRUNC,
+			       0666);
 
 		if ((child = fork()) == 0) {
 			dotest(nchild, i, fd);
diff --git a/testcases/kernel/fs/ftest/ftest04.c b/testcases/kernel/fs/ftest/ftest04.c
index ad26ece06..8eed84c74 100644
--- a/testcases/kernel/fs/ftest/ftest04.c
+++ b/testcases/kernel/fs/ftest/ftest04.c
@@ -48,6 +48,7 @@
 #include <errno.h>
 #include <signal.h>
 #include "test.h"
+#include "safe_macros.h"
 #include "libftest.h"
 
 char *TCID = "ftest04";
@@ -120,11 +121,7 @@ static void setup(void)
 		sprintf(filename, "%s/ftest04.%d", getcwd(wdbuf, MAXPATHLEN),
 			getpid());
 
-	fd = open(filename, O_RDWR | O_CREAT | O_TRUNC, 0666);
-	if (fd < 0) {
-		tst_brkm(TBROK, NULL, "Error %d creating file %s", errno,
-			 filename);
-	}
+	fd = SAFE_OPEN(NULL, filename, O_RDWR | O_CREAT | O_TRUNC, 0666);
 	close(fd);
 
 	/*
@@ -151,14 +148,7 @@ static void runtest(void)
 
 	for (i = 0; i < nchild; i++) {
 		if ((child = fork()) == 0) {
-			fd = open(filename, O_RDWR);
-			if (fd < 0) {
-				tst_brkm(TBROK,
-					 NULL,
-					 "\tTest[%d]: error %d openning %s.",
-					 i,
-					 errno, filename);
-			}
+			fd = SAFE_OPEN(NULL, filename, O_RDWR);
 			dotest(nchild, i, fd);
 			close(fd);
 			tst_exit();
diff --git a/testcases/kernel/fs/ftest/ftest05.c b/testcases/kernel/fs/ftest/ftest05.c
index b647f8b06..0bd32e4f6 100644
--- a/testcases/kernel/fs/ftest/ftest05.c
+++ b/testcases/kernel/fs/ftest/ftest05.c
@@ -166,12 +166,8 @@ static void runtest(void)
 	for (i = 0; i < nchild; i++) {
 		test_name[0] = 'a' + i;
 		test_name[1] = '\0';
-		fd = open(test_name, O_RDWR | O_CREAT | O_TRUNC, 0666);
-
-		if (fd < 0) {
-			tst_brkm(TBROK | TERRNO, NULL,
-				 "\tError creating %s/%s.", fuss, test_name);
-		}
+		fd = SAFE_OPEN(NULL, test_name, O_RDWR | O_CREAT | O_TRUNC,
+			       0666);
 
 		if ((child = fork()) == 0) {
 			dotest(nchild, i, fd);
diff --git a/testcases/kernel/fs/ftest/ftest07.c b/testcases/kernel/fs/ftest/ftest07.c
index f80f1922f..e5998b597 100644
--- a/testcases/kernel/fs/ftest/ftest07.c
+++ b/testcases/kernel/fs/ftest/ftest07.c
@@ -181,12 +181,8 @@ static void runtest(void)
 	for (i = 0; i < nchild; i++) {
 		test_name[0] = 'a' + i;
 		test_name[1] = '\0';
-		fd = open(test_name, O_RDWR | O_CREAT | O_TRUNC, 0666);
-		if (fd < 0) {
-			tst_brkm(TBROK, NULL, "\tError %d creating %s/%s.",
-				 errno,
-				 fuss, test_name);
-		}
+		fd = SAFE_OPEN(NULL, test_name, O_RDWR | O_CREAT | O_TRUNC,
+			       0666);
 
 		if ((child = fork()) == 0) {
 			dotest(nchild, i, fd);
diff --git a/testcases/kernel/fs/ftest/ftest08.c b/testcases/kernel/fs/ftest/ftest08.c
index 1eec79d0d..5e462486a 100644
--- a/testcases/kernel/fs/ftest/ftest08.c
+++ b/testcases/kernel/fs/ftest/ftest08.c
@@ -55,6 +55,7 @@
 #include <unistd.h>
 #include <inttypes.h>
 #include "test.h"
+#include "safe_macros.h"
 #include "libftest.h"
 
 char *TCID = "ftest08";
@@ -124,12 +125,7 @@ static void init(void)
 		sprintf(filename, "%s/ftest08.%d", getcwd(wdbuf, MAXPATHLEN),
 			getpid());
 
-	fd = open(filename, O_RDWR | O_CREAT | O_TRUNC, 0666);
-
-	if (fd < 0) {
-		tst_brkm(TBROK, NULL, "Error %d creating file %s", errno,
-			 filename);
-	}
+	fd = SAFE_OPEN(NULL, filename, O_RDWR | O_CREAT | O_TRUNC, 0666);
 
 	close(fd);
 
diff --git a/testcases/kernel/logging/kmsg/kmsg01.c b/testcases/kernel/logging/kmsg/kmsg01.c
index 58b62d517..294d0a2d1 100644
--- a/testcases/kernel/logging/kmsg/kmsg01.c
+++ b/testcases/kernel/logging/kmsg/kmsg01.c
@@ -65,9 +65,7 @@
 static int inject_msg(const char *msg)
 {
 	int f;
-	f = open("/dev/kmsg", O_WRONLY);
-	if (f < 0)
-		tst_brk(TBROK | TERRNO, "failed to open /dev/kmsg");
+	f = SAFE_OPEN("/dev/kmsg", O_WRONLY);
 	TEST(write(f, msg, strlen(msg)));
 	SAFE_CLOSE(f);
 	errno = TEST_ERRNO;
@@ -93,9 +91,7 @@ static int find_msg(int fd, const char *text_to_find, char *buf, int bufsize,
 	char msg[MAX_MSGSIZE + 1];
 
 	if (fd < 0) {
-		f = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
-		if (f < 0)
-			tst_brk(TBROK, "failed to open /dev/kmsg");
+		f = SAFE_OPEN("/dev/kmsg", O_RDONLY | O_NONBLOCK);
 	} else {
 		f = fd;
 	}
@@ -251,9 +247,7 @@ static void test_read_nonblock(void)
 	int fd;
 
 	tst_res(TINFO, "TEST: nonblock read");
-	fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
-	if (fd < 0)
-		tst_brk(TBROK|TERRNO, "failed to open /dev/kmsg");
+	fd = SAFE_OPEN("/dev/kmsg", O_RDONLY | O_NONBLOCK);
 
 	TEST(timed_read_kmsg(fd, READ_TIMEOUT));
 	if (TEST_RETURN == -1 && TEST_ERRNO == EAGAIN)
@@ -269,9 +263,7 @@ static void test_read_block(void)
 	int fd;
 
 	tst_res(TINFO, "TEST: blocking read");
-	fd = open("/dev/kmsg", O_RDONLY);
-	if (fd < 0)
-		tst_brk(TBROK|TERRNO, "failed to open /dev/kmsg");
+	fd = SAFE_OPEN("/dev/kmsg", O_RDONLY);
 
 	TEST(timed_read_kmsg(fd, READ_TIMEOUT));
 	if (TEST_RETURN == -2)
@@ -287,9 +279,7 @@ static void test_partial_read(void)
 	int fd;
 
 	tst_res(TINFO, "TEST: partial read");
-	fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
-	if (fd < 0)
-		tst_brk(TBROK|TERRNO, "failed to open /dev/kmsg");
+	fd = SAFE_OPEN("/dev/kmsg", O_RDONLY | O_NONBLOCK);
 
 	TEST(read(fd, msg, 1));
 	if (TEST_RETURN < 0)
@@ -365,9 +355,7 @@ static void test_read_returns_first_message(void)
 	 * NUM_READ_RETRY attempts, report TWARN */
 	tst_res(TINFO, "TEST: mult. readers will get same first message");
 	while (j) {
-		fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
-		if (fd < 0)
-			tst_brk(TBROK|TERRNO, "failed to open /dev/kmsg");
+		fd = SAFE_OPEN("/dev/kmsg", O_RDONLY | O_NONBLOCK);
 
 		for (i = 0; i < NUM_READ_MSGS; i++) {
 			if (find_msg(-1, "", msg, sizeof(msg), 1) != 0)
@@ -420,9 +408,7 @@ static void test_messages_overwritten(void)
 	 * We know first message is overwritten when its seqno changes */
 	tst_res(TINFO, "TEST: read returns EPIPE when messages get "
 		"overwritten");
-	fd = open("/dev/kmsg", O_RDONLY | O_NONBLOCK);
-	if (fd < 0)
-		tst_brk(TBROK|TERRNO, "failed to open /dev/kmsg");
+	fd = SAFE_OPEN("/dev/kmsg", O_RDONLY | O_NONBLOCK);
 
 	if (find_msg(-1, "", msg, sizeof(msg), 1) == 0
 		&& get_msg_fields(msg, NULL, &first_seqno) == 0) {
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index f4d12e088..dd82b08d2 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -686,9 +686,7 @@ void read_cpuset_files(char *prefix, char *filename, char *retbuf)
 		if (errno == ENOENT) {
 			snprintf(path, BUFSIZ, "%s/cpuset.%s",
 				 prefix, filename);
-			fd = open(path, O_RDONLY);
-			if (fd == -1)
-				tst_brk(TBROK | TERRNO, "open %s", path);
+			fd = SAFE_OPEN(path, O_RDONLY);
 		} else
 			tst_brk(TBROK | TERRNO, "open %s", path);
 	}
@@ -713,9 +711,7 @@ void write_cpuset_files(char *prefix, char *filename, char *buf)
 		if (errno == ENOENT) {
 			snprintf(path, BUFSIZ, "%s/cpuset.%s",
 				 prefix, filename);
-			fd = open(path, O_WRONLY);
-			if (fd == -1)
-				tst_brk(TBROK | TERRNO, "open %s", path);
+			fd = SAFE_OPEN(path, O_WRONLY);
 		} else
 			tst_brk(TBROK | TERRNO, "open %s", path);
 	}
diff --git a/testcases/kernel/mem/vma/vma03.c b/testcases/kernel/mem/vma/vma03.c
index 1db16eab1..4b34ab0a0 100644
--- a/testcases/kernel/mem/vma/vma03.c
+++ b/testcases/kernel/mem/vma/vma03.c
@@ -85,9 +85,7 @@ int main(int argc, char *argv[])
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 		tst_count = 0;
 
-		fd = open(TESTFILE, O_RDWR);
-		if (fd == -1)
-			tst_brkm(TBROK | TERRNO, NULL, "open %s", TESTFILE);
+		fd = SAFE_OPEN(NULL, TESTFILE, O_RDWR);
 
 		/*
 		 * The pgoff is counted in 4K units and must be page-aligned,
diff --git a/testcases/kernel/pty/hangup01.c b/testcases/kernel/pty/hangup01.c
index 5527bce98..aac3955c9 100644
--- a/testcases/kernel/pty/hangup01.c
+++ b/testcases/kernel/pty/hangup01.c
@@ -35,6 +35,7 @@
 
 /** LTP Port **/
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "hangup01";	/* Test program identifier.    */
 int TST_TOTAL = 5;		/* Total number of test cases. */
@@ -213,9 +214,7 @@ int main(int argc, char **argv)
 	pid_t childpid;
 
 /*--------------------------------------------------------------------*/
-	masterfd = open(MASTERCLONE, O_RDWR);
-	if (masterfd < 0)
-		tst_brkm(TBROK | TERRNO, NULL, "open %s", MASTERCLONE);
+	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
 
 	slavename = ptsname(masterfd);
 	if (slavename == NULL)
diff --git a/testcases/kernel/pty/ptem01.c b/testcases/kernel/pty/ptem01.c
index 8cfc02a89..68994d491 100644
--- a/testcases/kernel/pty/ptem01.c
+++ b/testcases/kernel/pty/ptem01.c
@@ -36,6 +36,7 @@
 
 /** LTP Port **/
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "ptem01";		/* Test program identifier.    */
 int TST_TOTAL = 6;		/* Total number of test cases. */
@@ -58,10 +59,7 @@ int test1(void)
 	struct termio termio;
 	struct termios termios;
 
-	masterfd = open(MASTERCLONE, O_RDWR);
-	if (masterfd < 0) {
-		tst_brkm(TBROK, NULL, "%s", MASTERCLONE);
-	}
+	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
 
 	slavename = ptsname(masterfd);
 	if (slavename == NULL) {
@@ -140,10 +138,7 @@ int test2(void)
 	struct winsize wsz1 = { 24, 80, 5, 10 };
 	struct winsize wsz2 = { 60, 100, 11, 777 };
 
-	masterfd = open(MASTERCLONE, O_RDWR);
-	if (masterfd < 0) {
-		tst_brkm(TBROK, NULL, "%s", MASTERCLONE);
-	}
+	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
 
 	slavename = ptsname(masterfd);
 	if (slavename == NULL) {
@@ -221,10 +216,7 @@ int test3(void)
 	int masterfd, slavefd;
 	char *slavename;
 
-	masterfd = open(MASTERCLONE, O_RDWR);
-	if (masterfd < 0) {
-		tst_brkm(TBROK, NULL, "%s", MASTERCLONE);
-	}
+	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
 
 	slavename = ptsname(masterfd);
 	if (slavename == NULL) {
@@ -272,10 +264,7 @@ int test4(void)
 	int masterfd, slavefd, slavefd2, slavefd3;
 	char *slavename;
 
-	masterfd = open(MASTERCLONE, O_RDWR);
-	if (masterfd < 0) {
-		tst_brkm(TBROK, NULL, "%s", MASTERCLONE);
-	}
+	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
 
 	slavename = ptsname(masterfd);
 	if (slavename == NULL) {
@@ -396,10 +385,7 @@ int test6(void)
 	char *slavename;
 	struct termios termios;
 
-	masterfd = open(MASTERCLONE, O_RDWR);
-	if (masterfd < 0) {
-		tst_brkm(TBROK, NULL, "%s", MASTERCLONE);
-	}
+	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
 
 	slavename = ptsname(masterfd);
 	if (slavename == NULL) {
diff --git a/testcases/kernel/pty/pty01.c b/testcases/kernel/pty/pty01.c
index 283612d55..d390ce717 100644
--- a/testcases/kernel/pty/pty01.c
+++ b/testcases/kernel/pty/pty01.c
@@ -37,6 +37,7 @@
 
 /** LTP Port **/
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "pty01";		/* Test program identifier.    */
 int TST_TOTAL = 5;		/* Total number of test cases. */
@@ -78,10 +79,7 @@ static int test1(void)
 	struct stat st;
 	char buf[TESTSIZE];
 
-	masterfd = open(MASTERCLONE, O_RDWR);
-	if (masterfd < 0) {
-		tst_brkm(TBROK | TERRNO, NULL, MASTERCLONE);
-	}
+	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
 
 	slavename = ptsname(masterfd);
 	if (slavename == NULL) {
@@ -115,10 +113,7 @@ static int test1(void)
 		tst_brkm(TBROK | TERRNO, NULL, "unlockpt() failed");
 	}
 
-	slavefd = open(slavename, O_RDWR);
-	if (slavefd < 0) {
-		tst_brkm(TBROK, NULL, "Could not open %s", slavename);
-	}
+	slavefd = SAFE_OPEN(NULL, slavename, O_RDWR);
 
 	/*
 	 * test writing to the master / reading from the slave
@@ -202,10 +197,7 @@ static void test2(void)
 	char *slavename;
 	char c;
 
-	masterfd = open(MASTERCLONE, O_RDWR);
-	if (masterfd < 0) {
-		tst_brkm(TBROK | TERRNO, NULL, MASTERCLONE);
-	}
+	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
 
 	slavename = ptsname(masterfd);
 	if (slavename == NULL) {
@@ -220,10 +212,7 @@ static void test2(void)
 		tst_brkm(TBROK | TERRNO, NULL, "unlockpt() call failed");
 	}
 
-	slavefd = open(slavename, O_RDWR);
-	if (slavefd < 0) {
-		tst_brkm(TBROK | TERRNO, NULL, "Could not open %s", slavename);
-	}
+	slavefd = SAFE_OPEN(NULL, slavename, O_RDWR);
 
 	/*
 	 * close pty fds.  See what happens when we close the master
@@ -264,10 +253,7 @@ static void test3(void)
 {
 	int masterfd;		/* master pty fd */
 
-	masterfd = open(MASTERCLONE, O_RDWR);
-	if (masterfd < 0) {
-		tst_brkm(TBROK, NULL, MASTERCLONE);
-	}
+	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
 
 	if (ioctl(masterfd, TIOCGWINSZ, NULL) == 0) {
 		tst_brkm(TFAIL | TERRNO, NULL,
@@ -288,10 +274,7 @@ static void test4(void)
 	int slavefd3;
 	char *slavename;
 
-	masterfd = open(MASTERCLONE, O_RDWR);
-	if (masterfd < 0) {
-		tst_brkm(TBROK, NULL, "%s", MASTERCLONE);
-	}
+	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
 
 	slavename = ptsname(masterfd);
 	if (slavename == NULL) {
@@ -306,10 +289,7 @@ static void test4(void)
 		tst_brkm(TBROK | TERRNO, NULL, "unlockpt() call failed");
 	}
 
-	slavefd = open(slavename, O_RDWR);
-	if (slavefd < 0) {
-		tst_brkm(TBROK | TERRNO, NULL, "Could not open %s", slavename);
-	}
+	slavefd = SAFE_OPEN(NULL, slavename, O_RDWR);
 
 	slavefd2 = open(slavename, O_RDWR);
 	if (slavefd < 0) {
diff --git a/testcases/kernel/syscalls/chmod/chmod01.c b/testcases/kernel/syscalls/chmod/chmod01.c
index 4428c9cd1..14002f23f 100644
--- a/testcases/kernel/syscalls/chmod/chmod01.c
+++ b/testcases/kernel/syscalls/chmod/chmod01.c
@@ -148,11 +148,7 @@ void setup(void)
 
 	tst_tmpdir();
 
-	fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %o) failed",
-			 TESTFILE, FILE_MODE);
+	fd = SAFE_OPEN(cleanup, TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
 	SAFE_CLOSE(cleanup, fd);
 
 }
diff --git a/testcases/kernel/syscalls/chmod/chmod07.c b/testcases/kernel/syscalls/chmod/chmod07.c
index 42272414a..6a3938840 100644
--- a/testcases/kernel/syscalls/chmod/chmod07.c
+++ b/testcases/kernel/syscalls/chmod/chmod07.c
@@ -178,11 +178,7 @@ void setup(void)
 		tst_brkm(TBROK, cleanup, "getgrnam failed");
 	group1_gid = ltpgroup->gr_gid;
 
-	fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %#o) failed",
-			 TESTFILE, FILE_MODE);
+	fd = SAFE_OPEN(cleanup, TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
 	SAFE_CLOSE(cleanup, fd);
 	SAFE_CHOWN(cleanup, TESTFILE, user1_uid, group1_gid);
 
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
index fd21f46fd..c12f0563c 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise01.c
@@ -42,6 +42,7 @@
 #include <errno.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #include "lapi/syscalls.h"
 #ifndef _FILE_OFFSET_BITS
@@ -144,12 +145,7 @@ void setup(void)
 
 	TEST_PAUSE;
 
-	fd = open(fname, O_RDONLY);
-	if (fd < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "Unable to open a file(\"%s\") for test: %s\n",
-			 fname, strerror(errno));
-	}
+	fd = SAFE_OPEN(cleanup, fname, O_RDONLY);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
index 161074dfb..4aa3a8cd1 100644
--- a/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
+++ b/testcases/kernel/syscalls/fadvise/posix_fadvise03.c
@@ -41,6 +41,7 @@
 #include <errno.h>
 #include <limits.h>
 #include "test.h"
+#include "safe_macros.h"
 
 #include "lapi/syscalls.h"
 #ifndef _FILE_OFFSET_BITS
@@ -194,12 +195,7 @@ void setup(void)
 
 	TEST_PAUSE;
 
-	fd = open(fname, O_RDONLY);
-	if (fd < 0) {
-		tst_brkm(TBROK, cleanup,
-			 "Unable to open a file(\"%s\") for test: %s\n",
-			 fname, strerror(errno));
-	}
+	fd = SAFE_OPEN(cleanup, fname, O_RDONLY);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/fallocate/fallocate01.c b/testcases/kernel/syscalls/fallocate/fallocate01.c
index 89ce9967d..02aa33100 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate01.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate01.c
@@ -100,6 +100,7 @@
 #include <sys/utsname.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "lapi/fallocate.h"
 #include "lapi/fcntl.h"
 
@@ -145,18 +146,12 @@ void setup(void)
 	tst_tmpdir();
 
 	sprintf(fname_mode1, "tfile_mode1_%d", getpid());
-	fd_mode1 = open(fname_mode1, O_RDWR | O_CREAT, 0700);
-	if (fd_mode1 == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open(%s, O_RDWR) failed",
-			 fname_mode1);
+	fd_mode1 = SAFE_OPEN(cleanup, fname_mode1, O_RDWR | O_CREAT, 0700);
 	get_blocksize(fd_mode1);
 	populate_files(fd_mode1);
 
 	sprintf(fname_mode2, "tfile_mode2_%d", getpid());
-	fd_mode2 = open(fname_mode2, O_RDWR | O_CREAT, 0700);
-	if (fd_mode2 == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open(%s, O_RDWR) failed",
-			 fname_mode2);
+	fd_mode2 = SAFE_OPEN(cleanup, fname_mode2, O_RDWR | O_CREAT, 0700);
 	populate_files(fd_mode2);
 }
 
diff --git a/testcases/kernel/syscalls/fallocate/fallocate03.c b/testcases/kernel/syscalls/fallocate/fallocate03.c
index d73d07d5b..da2b3bfbe 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate03.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate03.c
@@ -96,6 +96,7 @@
 #include <sys/utsname.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "lapi/fallocate.h"
 
 #define BLOCKS_WRITTEN 12
@@ -164,9 +165,7 @@ void setup(void)
 	tst_tmpdir();
 
 	sprintf(fname, "tfile_sparse_%d", getpid());
-	fd = open(fname, O_RDWR | O_CREAT, 0700);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open(%s) failed", fname);
+	fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0700);
 	get_blocksize(fd);
 	populate_file();
 	file_seek(BLOCKS_WRITTEN + HOLE_SIZE_IN_BLOCKS);	/* create holes */
diff --git a/testcases/kernel/syscalls/fchmod/fchmod05.c b/testcases/kernel/syscalls/fchmod/fchmod05.c
index 0ab2f935d..7a270285a 100644
--- a/testcases/kernel/syscalls/fchmod/fchmod05.c
+++ b/testcases/kernel/syscalls/fchmod/fchmod05.c
@@ -203,12 +203,7 @@ void setup(void)
 			 strerror(errno));
 
 	/* Open the test directory for reading */
-	fd = open(TESTDIR, O_RDONLY);
-	if (fd == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDONLY) failed, errno=%d : %s",
-			 TESTDIR, errno, strerror(errno));
-	}
+	fd = SAFE_OPEN(cleanup, TESTDIR, O_RDONLY);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/fcntl/fcntl14.c b/testcases/kernel/syscalls/fcntl/fcntl14.c
index 5f99dc21e..ca68d0f98 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl14.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl14.c
@@ -779,9 +779,7 @@ void run_test(int file_flag, int file_mode, int seek, int start, int end)
 	fail = 0;
 
 	for (test = start; test < end; test++) {
-		fd = open(tmpname, file_flag, file_mode);
-		if (fd < 0)
-			tst_brkm(TBROK, cleanup, "open() failed");
+		fd = SAFE_OPEN(cleanup, tmpname, file_flag, file_mode);
 
 		if (write(fd, FILEDATA, 10) < 0)
 			tst_brkm(TBROK, cleanup, "write() failed");
@@ -1017,9 +1015,8 @@ int main(int ac, char **av)
 		 * argument used for WHENCE (negative value)
 		 */
 
-		fd = open(tmpname, O_CREAT | O_RDWR | O_TRUNC, 0777);
-		if (fd < 0)
-			tst_brkm(TBROK, cleanup, "open failed");
+		fd = SAFE_OPEN(cleanup, tmpname, O_CREAT | O_RDWR | O_TRUNC,
+			       0777);
 
 		if (write(fd, FILEDATA, 10) < 0)
 			tst_brkm(TBROK, cleanup, "write failed");
@@ -1055,9 +1052,8 @@ int main(int ac, char **av)
 		 * additional data is appended to end of file and a new
 		 * process attempts to lock new data
 		 */
-		fd = open(tmpname, O_CREAT | O_RDWR | O_TRUNC, 0777);
-		if (fd < 0)
-			tst_brkm(TBROK, cleanup, "open failed");
+		fd = SAFE_OPEN(cleanup, tmpname, O_CREAT | O_RDWR | O_TRUNC,
+			       0777);
 
 		if (write(fd, FILEDATA, 10) < 0)
 			tst_brkm(TBROK, cleanup, "write failed");
diff --git a/testcases/kernel/syscalls/fcntl/fcntl16.c b/testcases/kernel/syscalls/fcntl/fcntl16.c
index c9defc68f..a77a81298 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl16.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl16.c
@@ -46,6 +46,7 @@
 #include <signal.h>
 #include <errno.h>
 #include "test.h"
+#include "safe_macros.h"
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -451,10 +452,7 @@ int run_test(int file_flag, int file_mode, int start, int end)
 	/* loop through all test cases */
 	for (test = start; test < end; test++) {
 		/* open a temp file to lock */
-		fd = open(tmpname, file_flag, file_mode);
-		if (fd < 0) {
-			tst_brkm(TBROK, cleanup, "open failed");
-		}
+		fd = SAFE_OPEN(cleanup, tmpname, file_flag, file_mode);
 
 		/* write some dummy data to the file */
 		(void)write(fd, FILEDATA, 10);
diff --git a/testcases/kernel/syscalls/flock/flock01.c b/testcases/kernel/syscalls/flock/flock01.c
index 06d89e3b9..a4133f140 100644
--- a/testcases/kernel/syscalls/flock/flock01.c
+++ b/testcases/kernel/syscalls/flock/flock01.c
@@ -71,6 +71,7 @@
 #include <sys/file.h>
 #include <fcntl.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup(void);
 void cleanup(void);
@@ -154,9 +155,7 @@ void setup(void)
 	sprintf(filename, "flock01.%d", getpid());
 
 	/* creating temporary file */
-	fd = open(filename, O_CREAT | O_TRUNC | O_RDWR, 0644);
-	if (fd < 0)
-		tst_brkm(TBROK, tst_rmdir, "creating a new file failed");
+	fd = SAFE_OPEN(tst_rmdir, filename, O_CREAT | O_TRUNC | O_RDWR, 0644);
 }
 
 /*
diff --git a/testcases/kernel/syscalls/flock/flock06.c b/testcases/kernel/syscalls/flock/flock06.c
index a35c8cf31..617eddf54 100644
--- a/testcases/kernel/syscalls/flock/flock06.c
+++ b/testcases/kernel/syscalls/flock/flock06.c
@@ -67,6 +67,7 @@
 #include <sys/file.h>
 #include <sys/wait.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup(void);
 void cleanup(void);
@@ -158,9 +159,7 @@ void setup(void)
 	sprintf(filename, "flock06.%d", getpid());
 
 	/* creating temporary file */
-	fd = open(filename, O_CREAT | O_TRUNC | O_RDWR, 0666);
-	if (fd < 0)
-		tst_brkm(TBROK, tst_rmdir, "creating a new file failed");
+	fd = SAFE_OPEN(tst_rmdir, filename, O_CREAT | O_TRUNC | O_RDWR, 0666);
 	close(fd);
 }
 
diff --git a/testcases/kernel/syscalls/fork/fork04.c b/testcases/kernel/syscalls/fork/fork04.c
index d6b57d990..208636c6b 100644
--- a/testcases/kernel/syscalls/fork/fork04.c
+++ b/testcases/kernel/syscalls/fork/fork04.c
@@ -103,6 +103,7 @@
 #include <signal.h>
 #include <errno.h>
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "fork04";
 
@@ -241,12 +242,7 @@ void parent_environment(void)
 	int ret;
 	char *var;
 
-	fildes = open(OUTPUT_FILE, O_RDWR);
-	if (fildes == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "fork() test. Parent open of temporary file failed. errno %d (%s)\n",
-			 errno, strerror(errno));
-	}
+	fildes = SAFE_OPEN(cleanup, OUTPUT_FILE, O_RDWR);
 	for (index = 0; index < NUMBER_OF_ENVIRON; index++) {
 		ret = read(fildes, tmp_line, MAX_LINE_LENGTH);
 		if (ret == 0) {
diff --git a/testcases/kernel/syscalls/fork/fork10.c b/testcases/kernel/syscalls/fork/fork10.c
index 13db0555d..815eee1f6 100644
--- a/testcases/kernel/syscalls/fork/fork10.c
+++ b/testcases/kernel/syscalls/fork/fork10.c
@@ -77,10 +77,7 @@ int main(int ac, char **av)
 		write(fildes, "ABCDEFGHIJKLMNOPQRSTUVWXYZ\n", 27);
 		close(fildes);
 
-		fildes = open(fnamebuf, 0);
-		if (fildes == -1)
-			tst_brkm(TBROK, cleanup, "Parent: cannot open %s for "
-				 "reading", fnamebuf);
+		fildes = SAFE_OPEN(cleanup, fnamebuf, 0);
 
 		pid = fork();
 		if (pid == -1)
diff --git a/testcases/kernel/syscalls/fstat/fstat01.c b/testcases/kernel/syscalls/fstat/fstat01.c
index 2ceed22b9..a5940c627 100644
--- a/testcases/kernel/syscalls/fstat/fstat01.c
+++ b/testcases/kernel/syscalls/fstat/fstat01.c
@@ -116,6 +116,7 @@
 #include <string.h>
 #include <signal.h>
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -161,9 +162,7 @@ void setup(void)
 	tst_tmpdir();
 
 	sprintf(fname, "tfile_%d", getpid());
-	fd = open(fname, O_RDWR | O_CREAT, 0700);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
+	fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0700);
 }
 
 void cleanup(void)
diff --git a/testcases/kernel/syscalls/fstat/fstat03.c b/testcases/kernel/syscalls/fstat/fstat03.c
index 1ff61c7ca..0fa62b847 100644
--- a/testcases/kernel/syscalls/fstat/fstat03.c
+++ b/testcases/kernel/syscalls/fstat/fstat03.c
@@ -137,10 +137,7 @@ void setup(void)
 	tst_tmpdir();
 
 	/* Create a testfile under temporary directory */
-	fildes = open(TEST_FILE, O_RDWR | O_CREAT, 0666);
-	if (fildes == -1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, 0666) failed", TEST_FILE);
+	fildes = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0666);
 
 	SAFE_CLOSE(cleanup, fildes);
 }
diff --git a/testcases/kernel/syscalls/fstat/fstat05.c b/testcases/kernel/syscalls/fstat/fstat05.c
index 29c253f48..8de5d070a 100644
--- a/testcases/kernel/syscalls/fstat/fstat05.c
+++ b/testcases/kernel/syscalls/fstat/fstat05.c
@@ -211,10 +211,7 @@ void setup(void)
 	tst_tmpdir();
 
 	/* Create a testfile under temporary directory */
-	fildes = open(TEST_FILE, O_RDWR | O_CREAT, 0666);
-	if (fildes == -1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, 0666) failed", TEST_FILE);
+	fildes = SAFE_OPEN(cleanup, TEST_FILE, O_RDWR | O_CREAT, 0666);
 
 	TEST_PAUSE;
 }
diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate01.c b/testcases/kernel/syscalls/ftruncate/ftruncate01.c
index 3bbae0a4f..3309af540 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate01.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate01.c
@@ -75,6 +75,7 @@
 #include <inttypes.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define TESTFILE	"testfile"	/* file under test */
 #define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
@@ -170,11 +171,7 @@ void setup(void)
 	}
 
 	/* open a file for reading/writing */
-	fildes = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
-	if (fildes == -1)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %o) failed",
-			 TESTFILE, FILE_MODE);
+	fildes = SAFE_OPEN(cleanup, TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
 
 	/* Write to the file 1k data from the buffer */
 	while (c_total < FILE_SIZE) {
diff --git a/testcases/kernel/syscalls/ftruncate/ftruncate02.c b/testcases/kernel/syscalls/ftruncate/ftruncate02.c
index 77f40e2ba..bc03075fc 100644
--- a/testcases/kernel/syscalls/ftruncate/ftruncate02.c
+++ b/testcases/kernel/syscalls/ftruncate/ftruncate02.c
@@ -75,6 +75,7 @@
 #include <signal.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 #define TESTFILE	"testfile"	/* file under test */
 #define FILE_MODE	S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH
@@ -253,11 +254,7 @@ void setup(void)
 		tst_buff[i] = 'a';
 	}
 	/* open a file for reading/writing */
-	fd = open(TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
-	if (fd == -1)
-		tst_brkm(TBROK, cleanup,
-			 "open(%s, O_RDWR|O_CREAT, %o) failed",
-			 TESTFILE, FILE_MODE);
+	fd = SAFE_OPEN(cleanup, TESTFILE, O_RDWR | O_CREAT, FILE_MODE);
 
 	/* Write to the file 1k data from the buffer */
 	while (write_len < FILE_SIZE) {
diff --git a/testcases/kernel/syscalls/inotify/inotify03.c b/testcases/kernel/syscalls/inotify/inotify03.c
index ae0c37e84..065890a25 100644
--- a/testcases/kernel/syscalls/inotify/inotify03.c
+++ b/testcases/kernel/syscalls/inotify/inotify03.c
@@ -196,11 +196,7 @@ static void setup(void)
 	mount_flag = 1;
 
 	sprintf(fname, "%s/tfile_%d", mntpoint, getpid());
-	fd = open(fname, O_RDWR | O_CREAT, 0700);
-	if (fd == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "open(%s, O_RDWR|O_CREAT,0700) failed", fname);
-	}
+	fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0700);
 
 	ret = write(fd, fname, 1);
 	if (ret == -1) {
diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
index 79f27f664..ceb54aa65 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
@@ -55,6 +55,7 @@
 #include <termio.h>
 #include <termios.h>
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "ioctl01";
 int TST_TOTAL = 5;
@@ -119,9 +120,7 @@ int main(int ac, char **av)
 
 	setup();
 
-	fd = open(devname, O_RDWR, 0777);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Couldn't open %s", devname);
+	fd = SAFE_OPEN(cleanup, devname, O_RDWR, 0777);
 
 	for (lc = 0; TEST_LOOPING(lc); lc++) {
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl02.c b/testcases/kernel/syscalls/ioctl/ioctl02.c
index 48e8eaa7f..a4b468e43 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl02.c
@@ -361,10 +361,7 @@ static int do_parent_setup(void)
 {
 	int pfd;
 
-	pfd = open(parenttty, O_RDWR, 0777);
-	if (pfd < 0)
-		tst_brkm(TBROK, cleanup, "Could not open %s in "
-			 "do_parent_setup(), errno = %d", parenttty, errno);
+	pfd = SAFE_OPEN(cleanup, parenttty, O_RDWR, 0777);
 
 	/* unset the closed flag */
 	closed = 0;
@@ -430,10 +427,7 @@ static void setup(void)
 	struct sigaction act;
 
 	/* XXX: TERRNO required all over the place */
-	fd = open(devname, O_RDWR, 0777);
-	if (fd < 0)
-		tst_brkm(TBROK, NULL, "Could not open %s in "
-			 "setup(), errno = %d", devname, errno);
+	fd = SAFE_OPEN(NULL, devname, O_RDWR, 0777);
 
 	/* Save the current device information - to be restored in cleanup() */
 	SAFE_IOCTL(cleanup, fd, TCGETA, &save_io);
diff --git a/testcases/kernel/syscalls/mincore/mincore02.c b/testcases/kernel/syscalls/mincore/mincore02.c
index 713473acd..ab73f4bf5 100644
--- a/testcases/kernel/syscalls/mincore/mincore02.c
+++ b/testcases/kernel/syscalls/mincore/mincore02.c
@@ -36,6 +36,7 @@
 #include <errno.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "mincore02";
 int TST_TOTAL = 1;
@@ -72,11 +73,8 @@ static void setup(void)
 	memset(buf, 42, size);
 	vec = malloc((size + page_size - 1) / page_size);
 	
-	fd = open("mincore02", O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
-	if (fd == -1) {
-		tst_brkm(TBROK | TERRNO, cleanup,
-		         "Unable to create temporary file");
-	}
+	fd = SAFE_OPEN(cleanup, "mincore02", O_CREAT | O_RDWR,
+		       S_IRUSR | S_IWUSR);
 
 	/* fill the temporary file with two pages of data */
 	if (write(fd, buf, size) < 0) {
diff --git a/testcases/kernel/syscalls/mlock/mlock04.c b/testcases/kernel/syscalls/mlock/mlock04.c
index fb541ec08..8ac884583 100644
--- a/testcases/kernel/syscalls/mlock/mlock04.c
+++ b/testcases/kernel/syscalls/mlock/mlock04.c
@@ -87,9 +87,7 @@ static void setup(void)
 {
 	tst_tmpdir();
 
-	fd = open(testfile, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open");
+	fd = SAFE_OPEN(cleanup, testfile, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
 
 	SAFE_FTRUNCATE(cleanup, fd, file_len);
 
diff --git a/testcases/kernel/syscalls/mprotect/mprotect01.c b/testcases/kernel/syscalls/mprotect/mprotect01.c
index d514b1352..7c4f10e02 100644
--- a/testcases/kernel/syscalls/mprotect/mprotect01.c
+++ b/testcases/kernel/syscalls/mprotect/mprotect01.c
@@ -43,6 +43,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "mprotect01";
 int TST_TOTAL = 3;
@@ -136,9 +137,7 @@ static void setup2(struct test_case *self)
 
 static void setup3(struct test_case *self)
 {
-	fd = open("/etc/passwd", O_RDONLY);
-	if (fd < 0)
-		tst_brkm(TBROK, cleanup, "open failed");
+	fd = SAFE_OPEN(cleanup, "/etc/passwd", O_RDONLY);
 	
 	self->len = getpagesize();
 
diff --git a/testcases/kernel/syscalls/open/open05.c b/testcases/kernel/syscalls/open/open05.c
index 2577a34ff..051aec3b3 100644
--- a/testcases/kernel/syscalls/open/open05.c
+++ b/testcases/kernel/syscalls/open/open05.c
@@ -129,9 +129,7 @@ static void setup(void)
 
 	sprintf(fname, "file.%d", getpid());
 
-	fd = open(fname, O_RDWR | O_CREAT, 0700);
-	if (fd == -1)
-		tst_brkm(TBROK, cleanup, "open() failed, errno: %d", errno);
+	fd = SAFE_OPEN(cleanup, fname, O_RDWR | O_CREAT, 0700);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/open/open11.c b/testcases/kernel/syscalls/open/open11.c
index 9593671f2..6fa21b0bd 100644
--- a/testcases/kernel/syscalls/open/open11.c
+++ b/testcases/kernel/syscalls/open/open11.c
@@ -373,9 +373,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	/* Create test files */
-	fd = open(T_REG, O_WRONLY | O_CREAT, 0644);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Create %s failed", T_REG);
+	fd = SAFE_OPEN(cleanup, T_REG, O_WRONLY | O_CREAT, 0644);
 	ret = write(fd, T_MSG, sizeof(T_MSG));
 	if (ret == -1) {
 		close(fd);
diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index d21bb9c45..319dc91f5 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -211,9 +211,7 @@ static void read_testfile(int do_readahead, const char *fname, size_t fsize,
 	off_t offset = 0;
 	struct timeval now;
 
-	fd = open(fname, O_RDONLY);
-	if (fd < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "Failed to open %s", fname);
+	fd = SAFE_OPEN(cleanup, fname, O_RDONLY);
 
 	if (do_readahead) {
 		cached_start = get_cached_size();
diff --git a/testcases/kernel/syscalls/sendfile/sendfile08.c b/testcases/kernel/syscalls/sendfile/sendfile08.c
index 3212ca7cc..f9e2605c1 100644
--- a/testcases/kernel/syscalls/sendfile/sendfile08.c
+++ b/testcases/kernel/syscalls/sendfile/sendfile08.c
@@ -109,13 +109,9 @@ static void setup(void)
 		tst_brkm(TBROK | TERRNO, cleanup, "Write %s failed", in_file);
 	close(in_fd);
 
-	in_fd = open(in_file, O_RDONLY);
-	if (in_fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Open %s failed", in_file);
+	in_fd = SAFE_OPEN(cleanup, in_file, O_RDONLY);
+	out_fd = SAFE_OPEN(cleanup, out_file, O_TRUNC | O_CREAT | O_RDWR, 0777);
 
-	out_fd = open(out_file, O_TRUNC | O_CREAT | O_RDWR, 0777);
-	if (out_fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Open %s failed", out_file);
 	ret = write(out_fd, TEST_MSG_OUT, strlen(TEST_MSG_OUT));
 	if (ret == -1)
 		tst_brkm(TBROK | TERRNO, cleanup, "Write %s failed", out_file);
diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid04.c b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
index 6d02b1994..8585d6207 100644
--- a/testcases/kernel/syscalls/setfsuid/setfsuid04.c
+++ b/testcases/kernel/syscalls/setfsuid/setfsuid04.c
@@ -38,6 +38,7 @@
 #include <unistd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "compat_16.h"
 
 TCID_DEFINE(setfsuid04);
@@ -174,9 +175,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	/* Create test file */
-	fd = open(testfile, O_CREAT | O_RDWR, 0644);
-	if (fd < 0)
-		tst_brkm(TBROK, cleanup, "cannot creat test file");
+	fd = SAFE_OPEN(cleanup, testfile, O_CREAT | O_RDWR, 0644);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/setresuid/setresuid04.c b/testcases/kernel/syscalls/setresuid/setresuid04.c
index 4f17cb923..e197476ff 100644
--- a/testcases/kernel/syscalls/setresuid/setresuid04.c
+++ b/testcases/kernel/syscalls/setresuid/setresuid04.c
@@ -51,6 +51,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include "test.h"
+#include "safe_macros.h"
 #include <pwd.h>
 #include "compat_16.h"
 
@@ -202,9 +203,7 @@ void setup(void)
 	sprintf(testfile, "setresuid04file%d.tst", getpid());
 
 	/* Create test file */
-	fd = open(testfile, O_CREAT | O_RDWR, 0644);
-	if (fd < 0)
-		tst_brkm(TBROK, cleanup, "cannot creat test file");
+	fd = SAFE_OPEN(cleanup, testfile, O_CREAT | O_RDWR, 0644);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/setreuid/setreuid07.c b/testcases/kernel/syscalls/setreuid/setreuid07.c
index 30c392d36..ff222cd00 100644
--- a/testcases/kernel/syscalls/setreuid/setreuid07.c
+++ b/testcases/kernel/syscalls/setreuid/setreuid07.c
@@ -36,6 +36,7 @@
 #include <pwd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "compat_16.h"
 
 TCID_DEFINE(setreuid07);
@@ -176,10 +177,7 @@ static void setup(void)
 	sprintf(testfile, "setreuid07file%d.tst", getpid());
 
 	/* Create test file */
-	fd = open(testfile, O_CREAT | O_RDWR, 0644);
-	if (fd < 0)
-		tst_brkm(TBROK | TERRNO,
-			cleanup, "cannot create test file");
+	fd = SAFE_OPEN(cleanup, testfile, O_CREAT | O_RDWR, 0644);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
diff --git a/testcases/kernel/syscalls/setuid/setuid04.c b/testcases/kernel/syscalls/setuid/setuid04.c
index 5879e91fb..3459e6648 100644
--- a/testcases/kernel/syscalls/setuid/setuid04.c
+++ b/testcases/kernel/syscalls/setuid/setuid04.c
@@ -34,6 +34,7 @@
 #include <unistd.h>
 
 #include "test.h"
+#include "safe_macros.h"
 #include "compat_16.h"
 
 char *TCID = "setuid04";
@@ -155,9 +156,7 @@ static void setup(void)
 	tst_tmpdir();
 
 	/* Create test file */
-	fd = open(testfile, O_CREAT | O_RDWR, 0644);
-	if (fd < 0)
-		tst_brkm(TBROK, cleanup, "cannot creat test file");
+	fd = SAFE_OPEN(cleanup, testfile, O_CREAT | O_RDWR, 0644);
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
-- 
2.13.5

