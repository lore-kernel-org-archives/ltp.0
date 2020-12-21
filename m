From: Radoslav Kolev <radoslav.kolev@suse.com>
Date: Mon, 21 Dec 2020 13:22:50 +0200
Subject: [LTP] [PATCH] unzip01.sh: Fix failure with BusyBox unzip
Message-ID: <20201221112250.27944-1-radoslav.kolev@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

BusyBox unzip uses the word 'inflating' instead of 'extracting'.
Detect it and check for the correct match in the output.

Signed-off-by: Radoslav Kolev <radoslav.kolev@suse.com>
---
 testcases/commands/unzip/unzip01.sh | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/testcases/commands/unzip/unzip01.sh b/testcases/commands/unzip/unzip01.sh
index 750718de4..1b9a1665f 100755
--- a/testcases/commands/unzip/unzip01.sh
+++ b/testcases/commands/unzip/unzip01.sh
@@ -12,6 +12,14 @@ TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="unzip"
 . tst_test.sh
 
+EXTRACT_MATCH=""
+
+if unzip 2>&1 | grep -q 'BusyBox'; then
+	EXTRACT_MATCH="inflating"
+else
+	EXTRACT_MATCH="extracting"
+fi
+
 setup()
 {
 	cat > unzip_exp.out <<EOF
@@ -21,15 +29,15 @@ Archive:  $TST_DATAROOT/test.zip
    creating: dir/d2/
    creating: dir/d3/
    creating: dir/d4/
- extracting: dir/d1/f1
- extracting: dir/d1/f2
- extracting: dir/d1/f3
+ $EXTRACT_MATCH: dir/d1/f1
+ $EXTRACT_MATCH: dir/d1/f2
+ $EXTRACT_MATCH: dir/d1/f3
    creating: dir/d2/d1/
    creating: dir/d2/d2/
    creating: dir/d2/d3/
- extracting: dir/d2/f1
- extracting: dir/d2/f2
- extracting: dir/d2/f3
+ $EXTRACT_MATCH: dir/d2/f1
+ $EXTRACT_MATCH: dir/d2/f2
+ $EXTRACT_MATCH: dir/d2/f3
    creating: dir/d3/d1/
    creating: dir/d3/d2/
    creating: dir/d3/d3/
-- 
2.26.2

