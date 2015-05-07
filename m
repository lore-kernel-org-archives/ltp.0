Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1YqGUI-0000Gc-CY
	for ltp-list@lists.sourceforge.net; Thu, 07 May 2015 07:44:54 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YqGUF-0006l7-QU
	for ltp-list@lists.sourceforge.net; Thu, 07 May 2015 07:44:54 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t477hNwK003351
	for <ltp-list@lists.sourceforge.net>; Thu, 7 May 2015 15:43:23 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Thu, 7 May 2015 15:35:52 +0800
Message-ID: <1430984152-1661-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1430984152-1661-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <1430984152-1661-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/2] device-drivers/zram/zram03: cleanup
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

Use SAFE_MACROS to simplify this test case, and add a 'TPASS' notification.

Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
---
 runtest/kernel_misc                             |   1 +
 testcases/kernel/device-drivers/zram/.gitignore |   1 +
 testcases/kernel/device-drivers/zram/Makefile   |   2 +-
 testcases/kernel/device-drivers/zram/zram03.c   | 102 ++++++++++--------------
 4 files changed, 44 insertions(+), 62 deletions(-)
 create mode 100644 testcases/kernel/device-drivers/zram/.gitignore

diff --git a/runtest/kernel_misc b/runtest/kernel_misc
index 7615c15..a574802 100644
--- a/runtest/kernel_misc
+++ b/runtest/kernel_misc
@@ -11,3 +11,4 @@ rcu_torture rcu_torture.sh
 lock_torture lock_torture.sh
 zram01 zram01.sh
 zram02 zram02.sh
+zram03 zram03
diff --git a/testcases/kernel/device-drivers/zram/.gitignore b/testcases/kernel/device-drivers/zram/.gitignore
new file mode 100644
index 0000000..7d54f60
--- /dev/null
+++ b/testcases/kernel/device-drivers/zram/.gitignore
@@ -0,0 +1 @@
+/zram03
diff --git a/testcases/kernel/device-drivers/zram/Makefile b/testcases/kernel/device-drivers/zram/Makefile
index 0d73f66..5077cf4 100644
--- a/testcases/kernel/device-drivers/zram/Makefile
+++ b/testcases/kernel/device-drivers/zram/Makefile
@@ -17,6 +17,6 @@
 top_srcdir	?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 
-INSTALL_TARGETS		:= *.sh
+INSTALL_TARGETS		:= *.sh zram03
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/device-drivers/zram/zram03.c b/testcases/kernel/device-drivers/zram/zram03.c
index a5abb38..8448234 100644
--- a/testcases/kernel/device-drivers/zram/zram03.c
+++ b/testcases/kernel/device-drivers/zram/zram03.c
@@ -23,6 +23,7 @@
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
  * 02110-1301, USA.
  */
+
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/mman.h>
@@ -31,7 +32,9 @@
 #include <stdio.h>
 #include <string.h>
 #include <unistd.h>
+
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "zram01";
 int TST_TOTAL = 1;
@@ -81,15 +84,10 @@ static void set_disksize(void)
 	char size[BUFSIZ];
 
 	tst_resm(TINFO, "create a zram device with %ld bytes in size.", SIZE);
-	fd = open(PATH_ZRAM "/disksize", O_WRONLY);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open %s",
-			 PATH_ZRAM "/disksize");
+	fd = SAFE_OPEN(cleanup, PATH_ZRAM "/disksize", O_WRONLY);
 	sprintf(size, "%ld", SIZE);
-	if (write(fd, size, strlen(size)) != strlen(size))
-		tst_brkm(TBROK | TERRNO, cleanup, "write %s to %s", size,
-			 PATH_ZRAM "/disksize");
-	close(fd);
+	SAFE_WRITE(cleanup, 1, fd, size, strlen(size));
+	SAFE_CLOSE(cleanup, fd);
 }
 
 static void write_device(void)
@@ -97,56 +95,48 @@ static void write_device(void)
 	int fd;
 	char *s;
 
-	tst_resm(TINFO, "map it into memory.");
-	fd = open(DEVICE, O_RDWR);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open %s", DEVICE);
-	s = mmap(NULL, SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-	if (s == MAP_FAILED)
-		tst_brkm(TBROK | TERRNO, cleanup, "mmap");
+	tst_resm(TINFO, "map this zram device into memory.");
+	fd = SAFE_OPEN(cleanup, DEVICE, O_RDWR);
+	s = SAFE_MMAP(cleanup, NULL, SIZE, PROT_READ | PROT_WRITE,
+		      MAP_SHARED, fd, 0);
 
 	tst_resm(TINFO, "write all the memory.");
 	memset(s, 'a', SIZE - 1);
 	s[SIZE - 1] = '\0';
 
-	if (munmap(s, SIZE) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "munmap");
-
-	close(fd);
+	SAFE_MUNMAP(cleanup, s, SIZE);
+	SAFE_CLOSE(cleanup, fd);
 }
 
 static void verify_device(void)
 {
 	int fd;
-	long i, fail;
+	long i = 0, fail = 0;
 	char *s;
 
 	tst_resm(TINFO, "verify contents from device.");
-	fd = open(DEVICE, O_RDONLY);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open %s", DEVICE);
-	s = mmap(NULL, SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
-	if (s == MAP_FAILED)
-		tst_brkm(TBROK | TERRNO, cleanup, "2nd mmap");
-
-	i = 0;
-	fail = 0;
+	fd = SAFE_OPEN(cleanup, DEVICE, O_RDONLY);
+	s = SAFE_MMAP(cleanup, NULL, SIZE, PROT_READ, MAP_PRIVATE, fd, 0);
+
 	while (s[i] && i < SIZE - 1) {
 		if (s[i] != 'a')
 			fail++;
 		i++;
 	}
-	if (i != SIZE - 1)
+	if (i != SIZE - 1) {
 		tst_resm(TFAIL, "expect size: %ld, actual size: %ld.",
 			 SIZE - 1, i);
-	else if (s[i] != '\0')
+	} else if (s[i] != '\0') {
 		tst_resm(TFAIL, "zram device seems not null terminated");
-	if (fail)
+	} else if (fail) {
 		tst_resm(TFAIL, "%ld failed bytes found.", fail);
-	if (munmap(s, SIZE) == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "2nd munmap");
+	} else {
+		tst_resm(TPASS, "data read from zram device is consistent "
+			 "with those are written");
+	}
 
-	close(fd);
+	SAFE_MUNMAP(cleanup, s, SIZE);
+	SAFE_CLOSE(cleanup, fd);
 }
 
 static void reset(void)
@@ -154,14 +144,9 @@ static void reset(void)
 	int fd;
 
 	tst_resm(TINFO, "reset it.");
-	fd = open(PATH_ZRAM "/reset", O_WRONLY);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open %s",
-			 PATH_ZRAM "/reset");
-	if (write(fd, "1", 1) != 1)
-		tst_brkm(TBROK | TERRNO, cleanup, "write 1 to %s",
-			 PATH_ZRAM "/reset");
-	close(fd);
+	fd = SAFE_OPEN(cleanup, PATH_ZRAM "/reset", O_WRONLY);
+	SAFE_WRITE(cleanup, 1, fd, "1", 1);
+	SAFE_CLOSE(cleanup, fd);
 }
 
 static void setup(void)
@@ -171,12 +156,16 @@ static void setup(void)
 	tst_require_root(NULL);
 
 retry:
-	if (access(PATH_ZRAM, R_OK | W_OK | X_OK) == -1) {
+	if (access(PATH_ZRAM, F_OK) == -1) {
 		if (errno == ENOENT) {
-			if (retried)
+			if (retried) {
 				tst_brkm(TCONF, NULL,
 					 "system has no zram device.");
-			system("modprobe zram");
+			}
+			if (system("modprobe zram") == -1) {
+				tst_brkm(TBROK | TERRNO, cleanup,
+					 "system(modprobe zram) failed");
+			}
 			modprobe = 1;
 			retried = 1;
 			goto retry;
@@ -190,26 +179,17 @@ retry:
 
 static void cleanup(void)
 {
-	if (modprobe == 1)
-		system("rmmod zram");
+	if (modprobe == 1 && system("rmmod zram") == -1)
+		tst_resm(TWARN | TERRNO, "system(rmmod zram) failed");
 }
 
 static void print(char *string)
 {
-	FILE *fp;
-	char buf[BUFSIZ], value[BUFSIZ];
-
-	sprintf(buf, "%s/%s", PATH_ZRAM, string);
-	fp = fopen(buf, "r");
-	if (fp == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "fopen %s", buf);
-
-	if (fgets(value, BUFSIZ, fp) == NULL)
-		tst_brkm(TBROK | TERRNO, cleanup, "fgets %s", buf);
-	value[strlen(value) - 1] = '\0';
-	fclose(fp);
+	char filename[BUFSIZ], value[BUFSIZ];
 
-	tst_resm(TINFO, "%s is %s", buf, value);
+	sprintf(filename, "%s/%s", PATH_ZRAM, string);
+	SAFE_FILE_SCANF(cleanup, filename, "%s", value);
+	tst_resm(TINFO, "%s is %s", filename, value);
 }
 
 static void dump_info(void)
-- 
1.8.3.1


------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
