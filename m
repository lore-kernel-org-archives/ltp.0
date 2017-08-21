From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 21 Aug 2017 11:06:52 +0200
Subject: [LTP] [PATCH 1/1] ltp-pan: Log start of test in kernel log
Message-ID: <20170821090652.17634-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
I know ltp-pan is deprecated, but add kernel stamping can be useful for debugging.
---
 pan/ltp-pan.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/pan/ltp-pan.c b/pan/ltp-pan.c
index 1614c70ff..fc058d1fb 100644
--- a/pan/ltp-pan.c
+++ b/pan/ltp-pan.c
@@ -53,6 +53,7 @@
 
 #include <sys/param.h>
 #include <sys/stat.h>
+#include <stdarg.h>
 #include <sys/times.h>
 #include <sys/types.h>
 #include <sys/wait.h>
@@ -1352,6 +1353,23 @@ static void copy_buffered_output(struct tag_pgrp *running)
 	}
 }
 
+static void write_kmsg(const char *fmt, ...)
+{
+	FILE *kmsg;
+	va_list ap;
+
+	if ((kmsg = fopen("/dev/kmsg", "r+")) == NULL) {
+		fprintf(stderr, "Error %s: (%d) opening /dev/kmsg\n",
+				strerror(errno), errno);
+		exit(1);
+	}
+
+	va_start(ap, fmt);
+	vfprintf(kmsg, fmt, ap);
+	va_end(ap);
+	fclose(kmsg);
+}
+
 static void write_test_start(struct tag_pgrp *running)
 {
 	if (!strcmp(reporttype, "rts")) {
@@ -1362,6 +1380,12 @@ static void write_test_start(struct tag_pgrp *running)
 		     running->cmd->cmdline, "", "exit", "<<<test_output>>>");
 	}
 	fflush(stdout);
+
+	if (strcmp(running->cmd->name, running->cmd->cmdline))
+		write_kmsg("LTP: starting %s (%s)\n", running->cmd->name,
+			   running->cmd->cmdline);
+	else
+		write_kmsg("LTP: starting %s\n", running->cmd->name);
 }
 
 static void
-- 
2.14.0

