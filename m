From: Michael Moese <mmoese@suse.de>
Date: Fri,  9 Mar 2018 10:27:00 +0100
Subject: [LTP] [PATCH v2 2/3] remove old tst_flush()
In-Reply-To: <20180309092701.8161-1-mmoese@suse.de>
References: <20180309092701.8161-1-mmoese@suse.de>
Message-ID: <20180309092701.8161-2-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The old tst_flush() was renamed to tst_old_flush(), and tst_flush()
was removed from tstapicmd.c.
The new tst_flush() has the same prototype as the old one, so any test
using it should still be fine.

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 lib/tst_res.c             | 2 +-
 tools/apicmds/ltpapicmd.c | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/tst_res.c b/lib/tst_res.c
index b56f37db0..9c88b2923 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -245,7 +245,7 @@ static void tst_condense(int tnum, int ttype, const char *tmesg)
 	Buffered = TRUE;
 }
 
-void tst_flush(void)
+void tst_old_flush(void)
 {
 	NO_NEWLIB_ASSERT("Unknown", 0);
 
diff --git a/tools/apicmds/ltpapicmd.c b/tools/apicmds/ltpapicmd.c
index 9ad68b589..4b66c4226 100644
--- a/tools/apicmds/ltpapicmd.c
+++ b/tools/apicmds/ltpapicmd.c
@@ -34,8 +34,6 @@
  *                          break remaining test cases
  *              tst_res   - Print result message, including file contents
  *              tst_resm  - Print result message
- *              tst_flush - Print any messages pending because of CONDENSE mode,
- *                          and flush output stream
  *              tst_exit  - Exit test with a meaningful exit value
  *
  *              These are the minimum set of functions or commands required to
@@ -332,8 +330,6 @@ int main(int argc, char *argv[])
 		apicmd_resm(argc, argv);
 	} else if (strcmp(cmd_name, "tst_exit") == 0) {
 		tst_exit();
-	} else if (strcmp(cmd_name, "tst_flush") == 0) {
-		tst_flush();
 	} else if (strcmp(cmd_name, "tst_ncpus") == 0) {
 		printf("%li\n", tst_ncpus());
 	} else if (strcmp(cmd_name, "tst_ncpus_conf") == 0) {
-- 
2.13.6

