From: aidengao <aiden.gaoyuan@gmail.com>
Date: Mon, 27 Jul 2020 16:44:02 +0000
Subject: [LTP] [PATCH 2/3] hotplug/memory_hotplug: Add a memtoy command to
 create a file of specified size
In-Reply-To: <20200727164403.1177686-1-aiden.gaoyuan@gmail.com>
References: <20200727164403.1177686-1-aiden.gaoyuan@gmail.com>
Message-ID: <20200727164403.1177686-2-aiden.gaoyuan@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: aidengao <aidengao@google.com>

Add a new memtoy command for interactively creating an empty file of
specified size.
USAGE: createfile <filename> <size>[k|m|p|g]
Example: createfile /data/local/tmp 100m
This will create a file named temp in /data/local/tmp/ with the size of
100 megabytes.

Signed-off-by: Yuan Gao <aiden.gaoyuan@gmail.com>
---
 .../kernel/hotplug/memory_hotplug/commands.c  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/testcases/kernel/hotplug/memory_hotplug/commands.c b/testcases/kernel/hotplug/memory_hotplug/commands.c
index 2e8972c1c..d37c6b40b 100644
--- a/testcases/kernel/hotplug/memory_hotplug/commands.c
+++ b/testcases/kernel/hotplug/memory_hotplug/commands.c
@@ -36,6 +36,7 @@
 #include <sys/mman.h>
 #include <ctype.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <numa.h>
 #include <numaif.h>
 #include <stdarg.h>
@@ -725,6 +726,44 @@ static int file_seg(char *args)
 	return CMD_SUCCESS;
 }
 
+/*
+ * createfile <file-name> <size>[k|m|g|p]]
+ */
+static int create_file(char *args)
+{
+	char *filename, *nextarg;
+	size_t len;
+	int fd;
+
+	args += strspn(args, whitespace);
+	if (!required_arg(args, "<file-name>"))
+		return CMD_ERROR;
+	filename = strtok_r(args, whitespace, &nextarg);
+	args = nextarg + strspn(nextarg, whitespace);
+
+	if (!required_arg(args, "<size>"))
+		return CMD_ERROR;
+	args = strtok_r(args, whitespace, &nextarg);
+	len = get_scaled_value(args, "size");
+	if (len == BOGUS_SIZE)
+		return CMD_ERROR;
+	args = get_next_arg(args, nextarg);
+
+	fd = open(filename, O_RDWR | O_CREAT, 0600);
+	if (fd < 0) {
+		printf("Fail to create a file %s\n", filename);
+		return CMD_ERROR;
+	}
+
+	if (posix_fallocate(fd, 0, len)) {
+		printf("Fail to create a file %s\n", filename);
+		return CMD_ERROR;
+	}
+	close(fd);
+	return CMD_SUCCESS;
+}
+
+
 /*
  * remove_seg:  <seg-name> [<seg-name> ...]
  */
@@ -1029,6 +1068,8 @@ struct command {
 		    "\tspecified offset into the file.  <offset> and <length> may be\n"
 		    "\tomitted and specified on the map command.\n"
 		    "\t<seg-share> := private|shared - default = private\n"}, {
+	.cmd_name = "createfile", .cmd_func = create_file, .cmd_help =
+			"createfile <file-name> <size>[k|m|g|p]]",}, {
 	.cmd_name = "shm",.cmd_func = shmem_seg,.cmd_help =
 		    "shm <seg-name> <seg-size>[k|m|g|p] - \n"
 		    "\tdefine a shared memory segment of specified size.\n"
-- 
2.28.0.rc0.142.g3c755180ce-goog

