From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 15 Jan 2019 21:30:10 +0100
Subject: [LTP] [COMMITTED][PATCH 1/1] commands/ar01: Fix for test in
	deterministic mode
Message-ID: <20190115203010.7584-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>

If binutils was configured with --enable-deterministic-archives,
ar will run in deterministic mode by default, and use zero for
timestamps and uids/gids, which makes the test case abnormal.

Fix this by add the "U" modifier when deterministic mode is default.

Signed-off-by: Guangwen Feng <fenggw-fnst@cn.fujitsu.com>
Signed-off-by: Fei Jie <feij.fnst@cn.fujitsu.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Guangwen,

thanks for your old fix, merging it finally!

Kind regards,
Petr
---
 testcases/commands/ar/ar01 | 88 +++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 40 deletions(-)

diff --git a/testcases/commands/ar/ar01 b/testcases/commands/ar/ar01
index be105f6da..0252c6d56 100644
--- a/testcases/commands/ar/ar01
+++ b/testcases/commands/ar/ar01
@@ -24,16 +24,24 @@
 #
 AR="${AR:=ar}"
 TST_CNT=17
+TST_SETUP=setup
 TST_TESTFUNC=test
 TST_NEEDS_TMPDIR=1
 TST_NEEDS_CMDS="$AR"
 
 . tst_test.sh
 
+setup()
+{
+	MOD=
+	ar --help | grep "use zero for timestamps and uids/gids (default)" >/dev/null
+	[ $? -eq 0 ] && MOD="U"
+}
+
 test1()
 {
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in
-	ROD ar -ra file1.in lib.a $TST_DATAROOT/file2.in
+	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in
+	ROD ar -ra"$MOD" file1.in lib.a $TST_DATAROOT/file2.in
 	ROD ar -t lib.a \> ar.out
 
 	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
@@ -50,9 +58,9 @@ test1()
 
 test2()
 {
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
-		         $TST_DATAROOT/file3.in $TST_DATAROOT/file4.in
-	ROD ar -ma file1.in lib.a file4.in
+	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
+			       $TST_DATAROOT/file3.in $TST_DATAROOT/file4.in
+	ROD ar -ma"$MOD" file1.in lib.a file4.in
 	ROD ar -t lib.a \> ar.out
 
 	printf "file1.in\nfile4.in\nfile2.in\nfile3.in\n" > ar.exp
@@ -69,8 +77,8 @@ test2()
 
 test3()
 {
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in
-	ROD ar -rb file3.in lib.a $TST_DATAROOT/file2.in
+	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in
+	ROD ar -rb"$MOD" file3.in lib.a $TST_DATAROOT/file2.in
 	ROD ar -t lib.a \> ar.out
 
 	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
@@ -87,9 +95,9 @@ test3()
 
 test4()
 {
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in \
-	                 $TST_DATAROOT/file2.in
-	ROD ar -mb file3.in lib.a file2.in
+	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in \
+			       $TST_DATAROOT/file2.in
+	ROD ar -mb"$MOD" file3.in lib.a file2.in
 	ROD ar -t lib.a \> ar.out
 
 	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
@@ -106,7 +114,7 @@ test4()
 
 test5()
 {
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in \> ar.out
+	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in \> ar.out
 
 	if [ -s ar.out ]; then
 		tst_res TFAIL "ar produced output unexpectedly (-c)"
@@ -120,7 +128,7 @@ test5()
 
 test6()
 {
-	ROD ar -qc lib.a $TST_DATAROOT/file1.in \> ar.out
+	ROD ar -qc"$MOD" lib.a $TST_DATAROOT/file1.in \> ar.out
 
 	if [ -s ar.out ]; then
 		tst_res TFAIL "ar produced output unexpectedly (-qc)"
@@ -134,9 +142,9 @@ test6()
 
 test7()
 {
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
-	                 $TST_DATAROOT/file3.in
-	ROD ar -d lib.a file1.in file2.in
+	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
+			       $TST_DATAROOT/file3.in
+	ROD ar -d"$MOD" lib.a file1.in file2.in
 	ROD ar -t lib.a \> ar.out
 
 	printf "file3.in\n" > ar.exp
@@ -153,9 +161,9 @@ test7()
 
 test8()
 {
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
-	                 $TST_DATAROOT/file3.in
-	ROD ar -d lib.a
+	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
+			       $TST_DATAROOT/file3.in
+	ROD ar -d"$MOD" lib.a
 	ROD ar -t lib.a \> ar.out
 
 	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
@@ -172,8 +180,8 @@ test8()
 
 test9()
 {
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in
-	ROD ar -ri file3.in lib.a $TST_DATAROOT/file2.in
+	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in
+	ROD ar -ri"$MOD" file3.in lib.a $TST_DATAROOT/file2.in
 	ROD ar -t lib.a \> ar.out
 
 	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
@@ -190,9 +198,9 @@ test9()
 
 test10()
 {
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in \
-	                 $TST_DATAROOT/file2.in
-	ROD ar -mi file3.in lib.a file2.in
+	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in \
+			       $TST_DATAROOT/file2.in
+	ROD ar -mi"$MOD" file3.in lib.a file2.in
 	ROD ar -t lib.a \> ar.out
 
 	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
@@ -209,9 +217,9 @@ test10()
 
 test11()
 {
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in \
-	                 $TST_DATAROOT/file2.in
-	ROD ar -m lib.a file3.in
+	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file3.in \
+			       $TST_DATAROOT/file2.in
+	ROD ar -m"$MOD" lib.a file3.in
 	ROD ar -t lib.a \> ar.out
 
 	printf "file1.in\nfile2.in\nfile3.in\n" > ar.exp
@@ -228,9 +236,9 @@ test11()
 
 test12()
 {
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
-	                 $TST_DATAROOT/file3.in
-	ROD ar -p lib.a \> ar.out
+	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
+			       $TST_DATAROOT/file3.in
+	ROD ar -p"$MOD" lib.a \> ar.out
 
 	printf "This is file one\nThis is file two\nThis is file three\n" > ar.exp
 
@@ -247,9 +255,9 @@ test12()
 test13()
 {
 
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
-	                 $TST_DATAROOT/file3.in
-	ROD ar -q lib.a $TST_DATAROOT/file4.in
+	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
+			       $TST_DATAROOT/file3.in
+	ROD ar -q"$MOD" lib.a $TST_DATAROOT/file4.in
 	ROD ar -t lib.a \> ar.out
 
 	printf "file1.in\nfile2.in\nfile3.in\nfile4.in\n" > ar.exp
@@ -267,14 +275,14 @@ test13()
 test14()
 {
 	ROD touch file0.in
-	ROD ar -cr lib.a file0.in $TST_DATAROOT/file1.in
+	ROD ar -cr"$MOD" lib.a file0.in $TST_DATAROOT/file1.in
 
 	file0_mtime1=$(ar -tv lib.a | grep file0.in)
 	file1_mtime1=$(ar -tv lib.a | grep file1.in)
 
 	touch -c -t $(date --date='next day' +"%Y%m%d%H%M") file0.in
 
-	ROD ar -ru lib.a file0.in $TST_DATAROOT/file1.in
+	ROD ar -ru"$MOD" lib.a file0.in $TST_DATAROOT/file1.in
 
 	file0_mtime2=$(ar -tv lib.a | grep file0.in)
 	file1_mtime2=$(ar -tv lib.a | grep file1.in)
@@ -296,7 +304,7 @@ test14()
 
 test15()
 {
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in
+	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in
 	ROD ar -tv lib.a \> ar.out
 
 	if grep -q '[rwx-]\{9\} [0-9].*/[0-9].*\s*[0-9].*.*file1.in' ar.out; then
@@ -311,9 +319,9 @@ test15()
 
 test16()
 {
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
-	                 $TST_DATAROOT/file3.in
-	ROD ar -xv lib.a \> ar.out
+	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in \
+			       $TST_DATAROOT/file3.in
+	ROD ar -xv"$MOD" lib.a \> ar.out
 
 	printf "x - file1.in\nx - file2.in\nx - file3.in\n" > ar.exp
 
@@ -335,8 +343,8 @@ test16()
 
 test17()
 {
-	ROD ar -cr lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in
-	ROD ar -xv lib.a file2.in \> ar.out
+	ROD ar -cr"$MOD" lib.a $TST_DATAROOT/file1.in $TST_DATAROOT/file2.in
+	ROD ar -xv"$MOD" lib.a file2.in \> ar.out
 
 	printf "x - file2.in\n" > ar.exp
 
-- 
2.19.2

