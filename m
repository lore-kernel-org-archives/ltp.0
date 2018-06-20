From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Jun 2018 09:59:16 +0200
Subject: [LTP] [PATCH 2/3] lib: Introduce TESTPTR()
In-Reply-To: <20180620075917.21056-1-pvorel@suse.cz>
References: <20180620075917.21056-1-pvorel@suse.cz>
Message-ID: <20180620075917.21056-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

for testing with pointers

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_test.h | 9 +++++++++
 lib/tst_res.c      | 1 +
 2 files changed, 10 insertions(+)

diff --git a/include/tst_test.h b/include/tst_test.h
index 54ff306d9..ab45e2783 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -195,6 +195,15 @@ void tst_reinit(void);
 extern long TEST_RETURN;
 extern int TEST_ERRNO;
 
+extern void *TEST_RETURN_PTR;
+
+#define TESTPTR(SCALL) \
+	do { \
+		errno = 0; \
+		TEST_RETURN_PTR = (void*)(TEST_RETURN = (intptr_t)SCALL); \
+		TEST_ERRNO = errno; \
+	} while (0)
+
 /*
  * Functions to convert ERRNO to its name and SIGNAL to its name.
  */
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 8ff7ee425..84becbef4 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -55,6 +55,7 @@
 
 long TEST_RETURN;
 int TEST_ERRNO;
+void *TEST_RETURN_PTR;
 
 #define VERBOSE      1
 #define NOPASS       3
-- 
2.17.1

