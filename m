From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 21 Jun 2021 12:38:02 +0100
Subject: [LTP] [PATCH 1/3] scripts/coccinelle: Add headers to lib checks and
 fix macro fix
Message-ID: <20210621113804.26179-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We have to explicitly add the header directory.

Also allow the TEST macro fix to replace multiple variables.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 scripts/coccinelle/libltp-test-macro.cocci |  4 +++-
 scripts/coccinelle/run-spatch.sh           | 10 ++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/scripts/coccinelle/libltp-test-macro.cocci b/scripts/coccinelle/libltp-test-macro.cocci
index 7563d23aa..937d6c94f 100644
--- a/scripts/coccinelle/libltp-test-macro.cocci
+++ b/scripts/coccinelle/libltp-test-macro.cocci
@@ -24,7 +24,7 @@ virtual fix
 
  TEST(...)
 
- ...
+ <...
 
 (
 - TST_RET
@@ -37,6 +37,8 @@ virtual fix
 + TERRNO
 )
 
+ ...>
+
 // Replace TEST in all functions where it occurs only at the start. It
 // is slightly complicated by adding a newline if a statement appears
 // on the line after TEST(). It is not clear to me what the rules are
diff --git a/scripts/coccinelle/run-spatch.sh b/scripts/coccinelle/run-spatch.sh
index e8e6f47d8..978998cd1 100755
--- a/scripts/coccinelle/run-spatch.sh
+++ b/scripts/coccinelle/run-spatch.sh
@@ -25,6 +25,12 @@ libltp_spatch() {
 	       -D fix \
 	       --include-headers \
 	       $*
+	spatch --dir include \
+	       --use-gitgrep \
+	       --in-place \
+	       -D fix \
+	       --include-headers \
+	       $*
     else
 	spatch --dir lib \
 	       --ignore lib/parse_opts.c \
@@ -33,6 +39,10 @@ libltp_spatch() {
 	       --use-gitgrep \
 	       --include-headers \
 	       $*
+	spatch --dir include \
+	       --use-gitgrep \
+	       --include-headers \
+	       $*
     fi
 }
 
-- 
2.31.1

