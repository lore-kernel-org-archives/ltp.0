From: Alistair Strachan <astrachan@google.com>
Date: Wed, 11 Jul 2018 14:03:36 -0700
Subject: [LTP] [PATCH] filecaps: Respect TMPDIR environment variable
In-Reply-To: <93480014.31836255.1531299278505.JavaMail.zimbra@redhat.com>
References: <93480014.31836255.1531299278505.JavaMail.zimbra@redhat.com>
Message-ID: <20180711210336.186949-1-astrachan@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The filecapstest.sh wrapper script already allowed the /tmp directory to
be overridden with the TMP environment variable, however doing so had
no effect on verify_caps_exec because it created its own version of this
fifo at a hardcoded location under /tmp.

Change the wrapper script to check for TMPDIR instead of TMP, to match
the value exported by runltp. Export FIFOFILE, to be used by the test
binaries invoked by the script.

Change the print_caps and verify_caps_exec to read FIFOFILE from the
environment (if it exists). Otherwise, TMPDIR will be read from the
environment and used to construct the path to the caps_fifo file.

Signed-off-by: Alistair Strachan <astrachan@google.com>
---
 .../kernel/security/filecaps/filecapstest.sh  |  5 ++-
 .../kernel/security/filecaps/print_caps.c     | 29 +++++++++++++++--
 .../security/filecaps/verify_caps_exec.c      | 32 ++++++++++++++++---
 3 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/security/filecaps/filecapstest.sh b/testcases/kernel/security/filecaps/filecapstest.sh
index 213b095bb..9bb5702df 100755
--- a/testcases/kernel/security/filecaps/filecapstest.sh
+++ b/testcases/kernel/security/filecaps/filecapstest.sh
@@ -22,9 +22,8 @@
 echo "Running in:"
 #rm -f print_caps
 #cp $LTPROOT/testcases/bin/print_caps .
-#FIFOFILE="$LTPROOT/testcases/bin/caps_fifo"
-TMP=${TMP:=/tmp}
-FIFOFILE="$TMP/caps_fifo"
+FIFOFILE="${TMPDIR:=/tmp}/caps_fifo"
+export FIFOFILE
 rm -f $FIFOFILE
 mkfifo $FIFOFILE
 chmod 777 $FIFOFILE
diff --git a/testcases/kernel/security/filecaps/print_caps.c b/testcases/kernel/security/filecaps/print_caps.c
index ee7a5f580..2479c4590 100644
--- a/testcases/kernel/security/filecaps/print_caps.c
+++ b/testcases/kernel/security/filecaps/print_caps.c
@@ -27,6 +27,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
+#include <limits.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -37,7 +38,31 @@
 #include <sys/capability.h>
 #endif
 
-#define FIFOFILE "/tmp/caps_fifo"
+#ifdef HAVE_LIBCAP
+
+static const char *get_caps_fifo(void)
+{
+	static char fifofile[PATH_MAX] = { 0, };
+
+	if (!fifofile[0]) {
+		const char *fifofile_ = getenv("FIFOFILE");
+
+		if (!fifofile_) {
+			const char *tmpdir = getenv("TMPDIR");
+
+			if (!tmpdir)
+				tmpdir = "/tmp";
+			snprintf(fifofile, PATH_MAX, "%s/caps_fifo", tmpdir);
+		} else {
+			strncpy(fifofile, fifofile_, PATH_MAX);
+			fifofile[PATH_MAX - 1] = 0;
+		}
+	}
+
+	return fifofile;
+}
+
+#endif
 
 int main(int argc, char *argv[])
 {
@@ -55,7 +80,7 @@ int main(int argc, char *argv[])
 		exit(1);
 	}
 
-	fd = open(FIFOFILE, O_WRONLY);
+	fd = open(get_caps_fifo(), O_WRONLY);
 	if (!fd) {
 		perror("print_caps: open fifo");
 		exit(2);
diff --git a/testcases/kernel/security/filecaps/verify_caps_exec.c b/testcases/kernel/security/filecaps/verify_caps_exec.c
index 7183d8b4a..fa2f0659c 100644
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
@@ -119,22 +120,43 @@ static int perms_test(void)
 	return ret;
 }
 
-#define FIFOFILE "/tmp/caps_fifo"
+static const char *get_caps_fifo(void)
+{
+	static char fifofile[PATH_MAX] = { 0, };
+
+	if (!fifofile[0]) {
+		const char *fifofile_ = getenv("FIFOFILE");
+
+		if (!fifofile_) {
+			const char *tmpdir = getenv("TMPDIR");
+
+			if (!tmpdir)
+				tmpdir = "/tmp";
+			snprintf(fifofile, PATH_MAX, "%s/caps_fifo", tmpdir);
+		} else {
+			strncpy(fifofile, fifofile_, PATH_MAX);
+			fifofile[PATH_MAX - 1] = 0;
+		}
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
@@ -144,7 +166,7 @@ static void read_from_fifo(char *buf)
 	int fd;
 
 	memset(buf, 0, 200);
-	fd = open(FIFOFILE, O_RDONLY);
+	fd = open(get_caps_fifo(), O_RDONLY);
 	if (fd < 0)
 		tst_brkm(TFAIL | TERRNO, NULL, "Failed opening fifo\n");
 	read(fd, buf, 199);
