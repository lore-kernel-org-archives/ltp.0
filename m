From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 13 Dec 2018 16:36:00 +0800
Subject: [LTP] [PATCH v3 3/3] lib/tst_test.c: Convert TFAIL to TWARN in test
	cleanup
In-Reply-To: <1544690160-13900-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20181211151733.GC1180@rei>
 <1544690160-13900-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1544690160-13900-3-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1) Both TBROK and TFAIL should be converted to TWARN in test cleanup.
2) Add a hint for the conversion.
2) Update test-writing-guidelines.

Note:
From test-writing-guidelines, Converting TBROK to TWARN seems
intentional design, so i try to convert TFAIL as well.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 doc/test-writing-guidelines.txt | 2 +-
 lib/tst_test.c                  | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
index 4b40760..3e0fa1a 100644
--- a/doc/test-writing-guidelines.txt
+++ b/doc/test-writing-guidelines.txt
@@ -393,7 +393,7 @@ IMPORTANT: 'SAFE_MACROS()' used in cleanup *do not* exit the test. Failure
 	   intentional as we want to execute as much 'cleanup()' as possible.
 
 WARNING: Calling tst_brk() in test 'cleanup()' does not exit the test as well
-         and 'TBROK' is converted to 'TWARN'.
+         and 'TBROK/TFAIL' is converted to 'TWARN'.
 
 NOTE: Creation and removal of the test temporary directory is handled in
       the test library and the directory is removed recursively. Therefore
diff --git a/lib/tst_test.c b/lib/tst_test.c
index e46ab8e..c5826d0 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -279,7 +279,9 @@ static void (*tst_brk_handler)(const char *file, const int lineno, int ttype,
 static void tst_cvres(const char *file, const int lineno, int ttype,
 		      const char *fmt, va_list va)
 {
-	if (TTYPE_RESULT(ttype) == TBROK) {
+	if (TTYPE_RESULT(ttype) == TBROK || TTYPE_RESULT(ttype) == TFAIL) {
+		tst_res(TINFO, "Convert ttype %s to TWARN in test cleanup",
+			tst_strttype(ttype));
 		ttype &= ~TTYPE_MASK;
 		ttype |= TWARN;
 	}
-- 
1.8.3.1



