From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 24 May 2019 11:53:17 +0200
Subject: [LTP] [PATCH] net: Disable building tst_get_unused_port in old API
Message-ID: <20190524095317.10240-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Commit fa6a4e708 moved tst_get_unused_port into new API, but left code
in Makefile built it also for old API. It was up to make which of these
was copied last and remain installed.

Also remove comparison for tst_get_unused_port from ltpapicmd.c.

Fixes: fa6a4e708 ("net: Introduce TST_GET_UNUSED_PORT() macro into C API")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

sorry for introducing a regression.

Kind regards,
Petr
---
 tools/apicmds/Makefile    | 2 +-
 tools/apicmds/ltpapicmd.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/apicmds/Makefile b/tools/apicmds/Makefile
index 11763e2cc..4b2a60495 100644
--- a/tools/apicmds/Makefile
+++ b/tools/apicmds/Makefile
@@ -28,7 +28,7 @@ CPPFLAGS		+= -D_GNU_SOURCE
 
 MAKE_TARGETS		:= $(addprefix tst_,brk brkm exit \
 			     res resm ncpus ncpus_conf ncpus_max \
-			     get_unused_port fs_has_free)
+			     fs_has_free)
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
 
diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
index f7e2a5eab..c4fab3218 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -262,8 +262,7 @@ int main(int argc, char *argv[])
 	tst_total = getenv("TST_TOTAL");
 	tst_cntstr = getenv("TST_COUNT");
 	if (TCID == NULL || tst_total == NULL || tst_cntstr == NULL) {
-		 if(!strcmp(cmd_name, "tst_fs_has_free") &&
-		    !strcmp(cmd_name, "tst_get_unused_port")) {
+		 if(!strcmp(cmd_name, "tst_fs_has_free")) {
 			fprintf(stderr,
 				"\nSet variables TCID, TST_TOTAL, and TST_COUNT before each test:\n"
 				"export TCID=<test name>\n"
-- 
2.21.0

