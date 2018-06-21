From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 21 Jun 2018 16:16:47 +0200
Subject: [LTP] [PATCH v3 2/3] lib: Introduce TESTPTR()
In-Reply-To: <20180621141648.11430-1-pvorel@suse.cz>
References: <20180621141648.11430-1-pvorel@suse.cz>
Message-ID: <20180621141648.11430-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

useful for testing with pointers.

NOTE: variable TST_RET_PTR has new format (TST_*), to confirm gh#336.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_test.h | 9 +++++++++
 lib/tst_res.c      | 1 +
 2 files changed, 10 insertions(+)

diff --git a/include/tst_test.h b/include/tst_test.h
index 54ff306d9..7caf2e174 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -195,6 +195,15 @@ void tst_reinit(void);
 extern long TEST_RETURN;
 extern int TEST_ERRNO;
 
+extern void *TST_RET_PTR;
+
+#define TESTPTR(SCALL) \
+	do { \
+		errno = 0; \
+		TST_RET_PTR = (void*)SCALL; \
+		TEST_ERRNO = errno; \
+	} while (0)
+
 /*
  * Functions to convert ERRNO to its name and SIGNAL to its name.
  */
diff --git a/lib/tst_res.c b/lib/tst_res.c
index 8ff7ee425..c35f41b74 100644
--- a/lib/tst_res.c
+++ b/lib/tst_res.c
@@ -55,6 +55,7 @@
 
 long TEST_RETURN;
 int TEST_ERRNO;
+void *TST_RET_PTR;
 
 #define VERBOSE      1
 #define NOPASS       3
-- 
2.17.1

