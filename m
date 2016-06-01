From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed,  1 Jun 2016 17:34:52 +0300
Subject: [LTP] [RFC PATCH 1/2] a draft for tst_checkpoint shell wrappers
In-Reply-To: <1464791693-10249-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1464791693-10249-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1464791693-10249-2-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/lib/test.sh     |   33 ++++++++++++++++++++++++++++++++
 tools/apicmds/.gitignore  |    2 +
 tools/apicmds/Makefile    |    3 +-
 tools/apicmds/ltpapicmd.c |   46 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+), 1 deletions(-)

diff --git a/testcases/lib/test.sh b/testcases/lib/test.sh
index 70345e5..33af37d 100644
--- a/testcases/lib/test.sh
+++ b/testcases/lib/test.sh
@@ -374,6 +374,39 @@ tst_module_exists()
 	tst_brkm TCONF "Failed to find module '$mod_name'"
 }
 
+TST_CHECKPOINT_SETUP()
+{
+	local size
+
+	LTP_IPC_PATH="/dev/shm/ltp_$$"
+
+	size=$(getconf PAGESIZE)
+	if [ $? -ne 0 ]; then
+		tst_brkm TBROK "getconf PAGESIZE failed"
+	fi
+
+	ROD_SILENT dd if=/dev/zero of="$LTP_IPC_PATH" bs="$size" count=1
+	ROD_SILENT chmod 600 "$LTP_IPC_PATH"
+	export LTP_IPC_PATH
+}
+
+TST_CHECKPOINT_CLEANUP()
+{
+	if [ -n "$LTP_IPC_PATH" -a -f "$LTP_IPC_PATH" ]; then
+		rm -f "$LTP_IPC_PATH"
+	fi
+}
+
+TST_CHECKPOINT_WAIT()
+{
+	ROD tst_checkpoint_wait "$1" 10000
+}
+
+TST_CHECKPOINT_WAKE()
+{
+	ROD tst_checkpoint_wake "$1" 10000
+}
+
 # Check that test name is set
 if [ -z "$TCID" ]; then
 	tst_brkm TBROK "TCID is not defined"
diff --git a/tools/apicmds/.gitignore b/tools/apicmds/.gitignore
index b4f7922..de5fd4f 100644
--- a/tools/apicmds/.gitignore
+++ b/tools/apicmds/.gitignore
@@ -11,3 +11,5 @@ tst_ncpus_max
 tst_res
 tst_resm
 tst_fs_has_free
+tst_checkpoint_wait
+tst_checkpoint_wake
diff --git a/tools/apicmds/Makefile b/tools/apicmds/Makefile
index 9c9472d..90e776a 100644
--- a/tools/apicmds/Makefile
+++ b/tools/apicmds/Makefile
@@ -28,7 +28,8 @@ CPPFLAGS		+= -D_GNU_SOURCE
 
 MAKE_TARGETS		:= $(addprefix tst_,brk brkm exit flush kvercmp \
 			     kvercmp2 res resm ncpus ncpus_conf ncpus_max \
-			     get_unused_port fs_has_free)
+			     get_unused_port fs_has_free \
+			     checkpoint_wait checkpoint_wake)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
index 12a5bd5..85bcf55 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -69,6 +69,7 @@
  *
  */
 
+#include <errno.h>
 #include <sys/socket.h>
 #include <stdio.h>
 #include <string.h>
@@ -78,6 +79,8 @@
 #include "usctest.h"
 #include "safe_macros.h"
 
+extern void tst_reinit(void);
+
 char *TCID;			/* Name of the testcase */
 int TST_TOTAL;			/* Total number of testcases */
 
@@ -369,6 +372,45 @@ fs_has_free_err:
 	exit(2);
 }
 
+int apicmd_checkpoint_wait_or_wake(int type, int argc, char *argv[])
+{
+	unsigned long id;
+	unsigned long msec_timeout;
+	char *e;
+
+	if (argc != 3)
+		goto err;
+
+	errno = 0;
+	id = strtoul(argv[0], &e, 10);
+	if (errno || (argv[0] == e) || (id > UINT_MAX)) {
+		fprintf(stderr, "ERROR: Invalid value '%s'\n",
+			argv[0]);
+		goto err;
+	}
+
+	errno = 0;
+	msec_timeout = strtoul(argv[1], &e, 10);
+	if (errno || (argv[1] == e) || (msec_timeout > UINT_MAX)) {
+		fprintf(stderr, "ERROR: Invalid value '%s'\n",
+			argv[1]);
+		goto err;
+	}
+
+	tst_reinit();
+
+	if (!type)
+		exit(tst_checkpoint_wait(id, msec_timeout));
+	else
+		exit(tst_checkpoint_wake(id, 1, msec_timeout));
+
+err:
+	printf("Usage: %s ID TIMEOUT\n", cmd_name);
+	printf("       ID - checkpoint id\n");
+	printf("       TIMEOUT - timeout in ms\n");
+	exit(1);
+}
+
 /*
  * Function:    main - entry point of this program
  *
@@ -459,6 +501,10 @@ int main(int argc, char *argv[])
 		printf("%u\n", apicmd_get_unused_port(argc, argv));
 	} else if (strcmp(cmd_name, "tst_fs_has_free") == 0) {
 		apicmd_fs_has_free(argc, argv);
+	} else if (strcmp(cmd_name, "tst_checkpoint_wait") == 0) {
+		apicmd_checkpoint_wait_or_wake(0, argc, argv);
+	} else if (strcmp(cmd_name, "tst_checkpoint_wake") == 0) {
+		apicmd_checkpoint_wait_or_wake(1, argc, argv);
 	}
 
 	exit(0);
-- 
1.7.1

