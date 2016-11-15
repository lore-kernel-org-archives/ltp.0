From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Nov 2016 11:06:14 +0100
Subject: [LTP] [PATCH 1/1] Tiny doc fixes
Message-ID: <20161115100614.29222-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/test-writing-guidelines.txt | 4 ++--
 lib/tst_test.c                  | 2 +-
 tools/netpipe-2.4/netpipe.sh    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 384ff09..4a51e01 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -260,7 +260,7 @@ static void setup(void)
 		tst_brk(TBROK | TERRNO, "setenv() failed");
 }
 
-static void test(void)
+static void do_test(void)
 {
 	char *ret;
 
@@ -289,7 +289,7 @@ next:
 
 static struct tst_test test = {
 	.tid = "getenv01",
-	.test_all = test,
+	.test_all = do_test,
 	.setup = setup,
 };
 -------------------------------------------------------------------------------
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 06f0339..f592aa5 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -333,7 +333,7 @@ static struct option {
 } options[] = {
 	{"h",  "-h       Prints this help"},
 	{"i:", "-i n     Execute test n times"},
-	{"I:", "-I x     Execute test for n seconds"},
+	{"I:", "-I n     Execute test for n seconds"},
 	{"C:", "-C ARG   Run child process with ARG arguments (used internally)"},
 };
 
diff --git a/tools/netpipe-2.4/netpipe.sh b/tools/netpipe-2.4/netpipe.sh
index f1445a3..9827e1e 100644
--- a/tools/netpipe-2.4/netpipe.sh
+++ b/tools/netpipe-2.4/netpipe.sh
@@ -17,7 +17,7 @@
 #    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 
 #   FILE        : netpipe.sh
-#   DESCRIPTION : a simple infinite loop of NPtcp for use in runalltests.sh
+#   DESCRIPTION : a simple infinite loop of NPtcp
 #   HISTORY     :
 #       02/05/2003 Robbie Williamson (robbiew@austin.ibm.com)
 #               written
-- 
2.10.2

