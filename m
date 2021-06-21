From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 21 Jun 2021 12:38:04 +0100
Subject: [LTP] [PATCH 3/3] API: Cause GCC/Clang to blow up when TEST is used
 in the library
In-Reply-To: <20210621113804.26179-1-rpalethorpe@suse.com>
References: <20210621113804.26179-1-rpalethorpe@suse.com>
Message-ID: <20210621113804.26179-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

As we define LTPLIB on library code, the preprocessor itself can be
used to detect when the TEST[_VOID] macros are expanded in the
library.

If an API header is not included by any library translation
units. Then this will not work. This is true at least for Fuzzy
Sync.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_test_macros.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/tst_test_macros.h b/include/tst_test_macros.h
index 89dfe5a31..9017fd042 100644
--- a/include/tst_test_macros.h
+++ b/include/tst_test_macros.h
@@ -6,6 +6,10 @@
 #ifndef TST_TEST_MACROS_H__
 #define TST_TEST_MACROS_H__
 
+#if LTPLIB
+#define TEST(SCALL) _Pragma("GCC error \"Do not use TEST macro in library\"")
+#define TEST_VOID(SCALL) _Pragma("GCC error \"Do not use TEST_VOID macro in library\"")
+#else
 #define TEST(SCALL) \
 	do { \
 		errno = 0; \
@@ -19,6 +23,7 @@
 		SCALL; \
 		TST_ERR = errno; \
 	} while (0)
+#endif
 
 extern long TST_RET;
 extern int TST_ERR;
-- 
2.31.1

