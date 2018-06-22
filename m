From: Alistair Strachan <astrachan@google.com>
Date: Fri, 22 Jun 2018 16:23:53 -0700
Subject: [LTP] [PATCH] verify_caps_exec: Respect TMP environment variable
Message-ID: <20180622232353.151563-1-astrachan@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The filecapstest.sh wrapper script already allows the /tmp directory to
be overridden with the TMP environment variable, however doing so has
no effect on verify_caps_exec because it creates its own version of this
fifo at a hardcoded location under /tmp.

To ensure the fifo is correctly removed by the wrapper script, alter
verify_caps_exec to respect the TMP environment variable and create a
fifo at the same location.

Signed-off-by: Alistair Strachan <astrachan@google.com>
---
 .../security/filecaps/verify_caps_exec.c      | 25 +++++++++++++++----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/security/filecaps/verify_caps_exec.c b/testcases/kernel/security/filecaps/verify_caps_exec.c
index 2c5cc0b2a..ff0a4837b 100644
--- a/testcases/kernel/security/filecaps/verify_caps_exec.c
+++ b/testcases/kernel/security/filecaps/verify_caps_exec.c
@@ -36,6 +36,7 @@
 #include <sys/wait.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <limits.h>
 #include "config.h"
 #if HAVE_SYS_CAPABILITY_H
 #include <linux/types.h>
@@ -119,22 +120,36 @@ static int perms_test(void)
 	return ret;
 }
 
-#define FIFOFILE "/tmp/caps_fifo"
+static const char *get_caps_fifo(void)
+{
+	static char fifofile[PATH_MAX] = { 0, };
+
+	if (!fifofile[0]) {
+		const char *tmpdir = getenv("TMP");
+
+		if (!tmpdir)
+			tmpdir = "/tmp";
+		snprintf(fifofile, PATH_MAX, "%s/caps_fifo", tmpdir);
+	}
+
+	return fifofile;
+}
+
 static void create_fifo(void)
 {
 	int ret;
 
-	ret = mkfifo(FIFOFILE, S_IRWXU | S_IRWXG | S_IRWXO);
+	ret = mkfifo(get_caps_fifo(), S_IRWXU | S_IRWXG | S_IRWXO);
 	if (ret == -1 && errno != EEXIST)
 		tst_brkm(TFAIL | TERRNO, NULL, "failed creating %s\n",
-			 FIFOFILE);
+			 get_caps_fifo());
 }
 
 static void write_to_fifo(const char *buf)
 {
 	int fd;
 
-	fd = open(FIFOFILE, O_WRONLY);
+	fd = open(get_caps_fifo(), O_WRONLY);
 	write(fd, buf, strlen(buf));
 	close(fd);
 }
@@ -144,7 +159,7 @@ static void read_from_fifo(char *buf)
 	int fd;
 
 	memset(buf, 0, 200);
-	fd = open(FIFOFILE, O_RDONLY);
+	fd = open(get_caps_fifo(), O_RDONLY);
 	if (fd < 0)
 		tst_brkm(TFAIL | TERRNO, NULL, "Failed opening fifo\n");
 	read(fd, buf, 199);
