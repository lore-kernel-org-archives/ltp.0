From: aidengao <aiden.gaoyuan@gmail.com>
Date: Mon, 27 Jul 2020 16:44:03 +0000
Subject: [LTP] [PATCH 3/3] hotplug/memory_hotplug: Add a memtoy command to
 delete a file
In-Reply-To: <20200727164403.1177686-1-aiden.gaoyuan@gmail.com>
References: <20200727164403.1177686-1-aiden.gaoyuan@gmail.com>
Message-ID: <20200727164403.1177686-3-aiden.gaoyuan@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: aidengao <aidengao@google.com>

Add a new memtoy command for interactively deleting a file.
USAGE: deletefile <filename>
Example: deletefile /data/local/tmp
This will delete a file named tmp in /data/local

Signed-off-by: Yuan Gao <aiden.gaoyuan@gmail.com>
---
 .../kernel/hotplug/memory_hotplug/commands.c  | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/testcases/kernel/hotplug/memory_hotplug/commands.c b/testcases/kernel/hotplug/memory_hotplug/commands.c
index d37c6b40b..0aa32ebea 100644
--- a/testcases/kernel/hotplug/memory_hotplug/commands.c
+++ b/testcases/kernel/hotplug/memory_hotplug/commands.c
@@ -726,6 +726,26 @@ static int file_seg(char *args)
 	return CMD_SUCCESS;
 }
 
+/*
+ * deletefile <file-name>
+ */
+static int delete_file(char *args)
+{
+	char *filename, *nextarg;
+
+	args += strspn(args, whitespace);
+	if (!required_arg(args, "<file-name>"))
+		return CMD_ERROR;
+	filename = strtok_r(args, whitespace, &nextarg);
+
+	if (remove(filename)) {
+		printf("Fail to delete a file %s\n", filename);
+		return CMD_ERROR;
+	}
+
+	return CMD_SUCCESS;
+}
+
 /*
  * createfile <file-name> <size>[k|m|g|p]]
  */
@@ -1070,6 +1090,8 @@ struct command {
 		    "\t<seg-share> := private|shared - default = private\n"}, {
 	.cmd_name = "createfile", .cmd_func = create_file, .cmd_help =
 			"createfile <file-name> <size>[k|m|g|p]]",}, {
+	.cmd_name = "deletefile", .cmd_func = delete_file, .cmd_help =
+			"deletefile <file-name>"}, {
 	.cmd_name = "shm",.cmd_func = shmem_seg,.cmd_help =
 		    "shm <seg-name> <seg-size>[k|m|g|p] - \n"
 		    "\tdefine a shared memory segment of specified size.\n"
-- 
2.28.0.rc0.142.g3c755180ce-goog

