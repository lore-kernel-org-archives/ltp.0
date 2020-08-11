From: Yuan Gao <aiden.gaoyuan@gmail.com>
Date: Tue, 11 Aug 2020 18:49:11 +0000
Subject: [LTP] [PATCH v2 3/3] hotplug/memory_hotplug: Add a memtoy command
 to delete a file
In-Reply-To: <20200811184911.4089327-1-aiden.gaoyuan@gmail.com>
References: <20200811184911.4089327-1-aiden.gaoyuan@gmail.com>
Message-ID: <20200811184911.4089327-2-aiden.gaoyuan@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Add a new memtoy command for interactively deleting a file.
USAGE: deletefile <filename>
Example: deletefile /data/local/tmp
This will delete a file named tmp in /data/local

Change from v1:
1. Replace printf with fprintf in stderr for error message

Signed-off-by: Yuan Gao <aiden.gaoyuan@gmail.com>
---
 .../kernel/hotplug/memory_hotplug/commands.c  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/testcases/kernel/hotplug/memory_hotplug/commands.c b/testcases/kernel/hotplug/memory_hotplug/commands.c
index 9cd69ebcd..43edebb83 100644
--- a/testcases/kernel/hotplug/memory_hotplug/commands.c
+++ b/testcases/kernel/hotplug/memory_hotplug/commands.c
@@ -727,6 +727,28 @@ static int file_seg(char *args)
 	return CMD_SUCCESS;
 }
 
+/*
+ * deletefile <file-name>
+ */
+static int delete_file(char *args)
+{
+	glctx_t *gcp = &glctx;
+	char *filename, *nextarg;
+
+	args += strspn(args, whitespace);
+	if (!required_arg(args, "<file-name>"))
+		return CMD_ERROR;
+	filename = strtok_r(args, whitespace, &nextarg);
+
+	if (remove(filename)) {
+		fprintf(stderr, "%s: deletefile failed - %s\n",
+			gcp->program_name, strerror(errno));
+		return CMD_ERROR;
+	}
+
+	return CMD_SUCCESS;
+}
+
 /*
 * createfile <file-name> <size>[k|m|g|p]]
 */
@@ -1074,6 +1096,8 @@ struct command {
 		    "\t<seg-share> := private|shared - default = private\n"}, {
 	.cmd_name="createfile",.cmd_func=create_file,.cmd_help=
 			"createfile <file-name> <size>[k|m|g|p]]",}, {
+	.cmd_name = "deletefile", .cmd_func = delete_file, .cmd_help =
+			"deletefile <file-name>"}, {
 	.cmd_name = "shm",.cmd_func = shmem_seg,.cmd_help =
 		    "shm <seg-name> <seg-size>[k|m|g|p] - \n"
 		    "\tdefine a shared memory segment of specified size.\n"
-- 
2.28.0.236.gb10cc79966-goog

