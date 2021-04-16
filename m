From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 16 Apr 2021 10:46:34 +0200
Subject: [LTP] [PATCH] commands/ld01: relax check for missing files
Message-ID: <720dd61b04bf13974f9e3d69bfec5dc9a02a9e8d.1618562750.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Older gcc versions used to report:
  gcc: cannot find x.o: No such file or directory
newer ones now report:
  ld: cannot find x.o: No such file or directory

This is a sanity test and exact message is not important. Relax the check.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/commands/ld/ld01.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/commands/ld/ld01.sh b/testcases/commands/ld/ld01.sh
index a05627f9d9f8..0a598ec3a768 100755
--- a/testcases/commands/ld/ld01.sh
+++ b/testcases/commands/ld/ld01.sh
@@ -27,7 +27,7 @@ test1()
 {
 	EXPECT_FAIL $LD x.o y.o 2\> ld.out
 
-	if grep -q "$LD:.*[xy]\.o.*No such file or directory" ld.out; then
+	if grep -q "[xy]\.o.*No such file or directory" ld.out; then
 		tst_res TPASS "Missing files were reported"
 	else
 		tst_res TFAIL "Missing files were not reported"
@@ -39,7 +39,7 @@ test2()
 {
 	EXPECT_FAIL $CC x.o y.o 2\> cc.out
 
-	if grep -q "$CC:.*[xy]\.o.*No such file or directory" cc.out; then
+	if grep -q "[xy]\.o.*No such file or directory" cc.out; then
 		tst_res TPASS "Missing files were reported"
 	else
 		tst_res TFAIL "Missing files were not reported"
-- 
2.18.1

