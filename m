From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 25 Aug 2021 10:09:32 +0200
Subject: [LTP] [PATCH 2/3] C API: Rename LTP_IPC_PATH -> TST_IPC_PATH
In-Reply-To: <20210825080933.12949-1-pvorel@suse.cz>
References: <20210825080933.12949-1-pvorel@suse.cz>
Message-ID: <20210825080933.12949-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To follow the conventions in the new API.

Update also C API docs.

NOTE: IPC is not supported in the legacy API.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/c-test-api.txt | 2 +-
 include/tst_test.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
index 3127018a4..a092bc572 100644
--- a/doc/c-test-api.txt
+++ b/doc/c-test-api.txt
@@ -654,7 +654,7 @@ int main(void)
 
 The 'tst_res()' function can be also used from binaries started by 'exec()',
 the parent test process has to set the '.child_needs_reinit' flag so that the
-library prepares for it and has to make sure the 'LTP_IPC_PATH' environment
+library prepares for it and has to make sure the 'TST_IPC_PATH' environment
 variable is passed down, then the very fist thing the program has to call in
 'main()' is 'tst_reinit()' that sets up the IPC.
 
diff --git a/include/tst_test.h b/include/tst_test.h
index 27ebed94e..4c0749865 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -275,12 +275,12 @@ struct tst_test {
 void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
                     __attribute__ ((noreturn));
 
-#define IPC_ENV_VAR "LTP_IPC_PATH"
+#define IPC_ENV_VAR "TST_IPC_PATH"
 
 /*
  * Does library initialization for child processes started by exec()
  *
- * The LTP_IPC_PATH variable must be passed to the program environment.
+ * The TST_IPC_PATH variable must be passed to the program environment.
  */
 void tst_reinit(void);
 
-- 
2.32.0

