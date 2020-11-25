From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 25 Nov 2020 10:09:10 +0000
Subject: [LTP] [PATCH] Annotate tst_brk with noreturn
Message-ID: <20201125100910.25617-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Prevents compiler warnings when tst_brk is placed at the end of a
non-void function's control flow. Indeed tst_brk never returns control
to the caller.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_test.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index c91d3f18a..b49243e4b 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -70,7 +70,7 @@ void tst_resm_hexd_(const char *file, const int lineno, int ttype,
  */
 void tst_brk_(const char *file, const int lineno, int ttype,
               const char *fmt, ...)
-              __attribute__ ((format (printf, 4, 5)));
+              __attribute__ ((format (printf, 4, 5))) LTP_ATTRIBUTE_NORETURN;
 
 #define tst_brk(ttype, arg_fmt, ...)						\
 	({									\
-- 
2.29.1

