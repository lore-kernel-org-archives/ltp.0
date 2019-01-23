From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 23 Jan 2019 10:11:18 +0100
Subject: [LTP] [PATCH 1/1] commands/ld01: Fix shared library detection on
	file >= 5.33
Message-ID: <20190123091118.28303-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since commit 6876ebad ("add a conditional in description") in file util
shared library is described as "LSB pie executable", thus check for it
as well.

+ do more precise check for old versions ('shared object').

NOTE: we compile with -fPIC, but file detects pie even if we disable it:
$CC -no-pie -c -o rf1.o /opt/ltp/testcases/data/ld01/rf1.c
$CC -no-pie -c -o f1.o /opt/ltp/testcases/data/ld01/f1.c
$CC -no-pie -c -o rd1.o /opt/ltp/testcases/data/ld01/rd1.c
$CC -no-pie -c -o d1.o /opt/ltp/testcases/data/ld01/d1.c
$CC -no-pie -c -o main.o /opt/ltp/testcases/data/ld01/main.c
ld -no-pie -shared f1.o d1.o -o test.so

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/commands/ld/ld01 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/commands/ld/ld01 b/testcases/commands/ld/ld01
index f24f6f97e..986ad1e60 100755
--- a/testcases/commands/ld/ld01
+++ b/testcases/commands/ld/ld01
@@ -67,7 +67,7 @@ test3()
 {
 	EXPECT_PASS $LD -shared f1.o d1.o -o test.so
 
-	if file test.so |grep -q shared; then
+	if file test.so |grep -q -e 'pie executable' -e 'shared object'; then
 		tst_res TPASS "Shared library could be build"
 	else
 		tst_res TFAIL "Failed to build shared library"
-- 
2.19.2

