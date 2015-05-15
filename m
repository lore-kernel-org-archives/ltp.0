Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wangxg.fnst@cn.fujitsu.com>) id 1YtBo7-0005JF-Pq
	for ltp-list@lists.sourceforge.net; Fri, 15 May 2015 09:21:27 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YtBo5-00082v-3o
	for ltp-list@lists.sourceforge.net; Fri, 15 May 2015 09:21:27 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t4F9JrVI016005
	for <ltp-list@lists.sourceforge.net>; Fri, 15 May 2015 17:19:53 +0800
From: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Date: Fri, 15 May 2015 17:12:00 +0800
Message-ID: <1431681121-27607-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
In-Reply-To: <1431681121-27607-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
References: <20150512113746.GB6526@rei.suse.de>
	<1431681121-27607-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 2/2] device-drivers/zram/zram03: cleanup
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
 testcases/kernel/device-drivers/zram/zram03.c | 104 +++++++++-----------------
 1 file changed, 37 insertions(+), 67 deletions(-)

diff --git a/testcases/kernel/device-drivers/zram/zram03.c b/testcases/kernel/device-drivers/zram/zram03.c
index a5abb38..9ee77dd 100644
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
@@ -77,19 +80,8 @@ int main(int argc, char *argv[])
 
 static void set_disksize(void)
 {
-	int fd;
-	char size[BUFSIZ];
-
 	tst_resm(TINFO, "create a zram device with %ld bytes in size.", SIZE);
-	fd = open(PATH_ZRAM "/disksize", O_WRONLY);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open %s",
-			 PATH_ZRAM "/disksize");
-	sprintf(size, "%ld", SIZE);
-	if (write(fd, size, strlen(size)) != strlen(size))
-		tst_brkm(TBROK | TERRNO, cleanup, "write %s to %s", size,
-			 PATH_ZRAM "/disksize");
-	close(fd);
+	SAFE_FILE_PRINTF(cleanup, PATH_ZRAM "/disksize", "%ld", SIZE);
 }
 
 static void write_device(void)
@@ -97,71 +89,54 @@ static void write_device(void)
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
 {
-	int fd;
-
 	tst_resm(TINFO, "reset it.");
-	fd = open(PATH_ZRAM "/reset", O_WRONLY);
-	if (fd == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "open %s",
-			 PATH_ZRAM "/reset");
-	if (write(fd, "1", 1) != 1)
-		tst_brkm(TBROK | TERRNO, cleanup, "write 1 to %s",
-			 PATH_ZRAM "/reset");
-	close(fd);
+	SAFE_FILE_PRINTF(cleanup, PATH_ZRAM "/reset", "1");
 }
 
 static void setup(void)
@@ -171,12 +146,16 @@ static void setup(void)
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
@@ -190,26 +169,17 @@ retry:
 
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
1.8.2.1


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
