From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 13 Feb 2017 11:02:34 +0100
Subject: [LTP] [PATCH] mmap16: extend checkpoint wait time during fs fill
In-Reply-To: <793ef4af0e7bb8827b5d2bd04321267ad530ed55.1486733825.git.jstancek@redhat.com>
References: <793ef4af0e7bb8827b5d2bd04321267ad530ed55.1486733825.git.jstancek@redhat.com>
Message-ID: <20170213100234.GD16973@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +
> +	/* Give parent enough time to consume FS free blocks */
> +	if (tst_checkpoint_wait(0, 60*1000))
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			"wait for parent to fill entire space");

Hrm, I wonder why I hardcoded the timeout into the library. It would be
much better if we could have used the safe variant here.

What about we add TST_SAFE_CHECKPOINT_WAIT2() that would take a timeout
parameter. Pretty much the same as we do for WAKE2 that takes a number
of processes to wake as a paramter.

Something like this:

diff --git a/include/old/old_checkpoint.h b/include/old/old_checkpoint.h
index 37bdf92..c8ffc92 100644
--- a/include/old/old_checkpoint.h
+++ b/include/old/old_checkpoint.h
@@ -41,7 +41,10 @@
 	tst_checkpoint_init(__FILE__, __LINE__, cleanup_fn)
 
 #define TST_SAFE_CHECKPOINT_WAIT(cleanup_fn, id) \
-        tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id);
+        tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id, 0);
+
+#define TST_SAFE_CHECKPOINT_WAIT2(cleanup_fn, id, msec_timeout) \
+        tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id, msec_timeout);
 
 #define TST_SAFE_CHECKPOINT_WAKE(cleanup_fn, id) \
         tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, 1);
@@ -51,6 +54,6 @@
 
 #define TST_SAFE_CHECKPOINT_WAKE_AND_WAIT(cleanup_fn, id) \
         tst_safe_checkpoint_wake(__FILE__, __LINE__, cleanup_fn, id, 1); \
-        tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id);
+        tst_safe_checkpoint_wait(__FILE__, __LINE__, cleanup_fn, id, 0);
 
 #endif /* OLD_CHECKPOINT__ */
diff --git a/include/tst_checkpoint.h b/include/tst_checkpoint.h
index ae5a68b..e0dc1a5 100644
--- a/include/tst_checkpoint.h
+++ b/include/tst_checkpoint.h
@@ -21,7 +21,10 @@
 #include "tst_checkpoint_fn.h"
 
 #define TST_CHECKPOINT_WAIT(id) \
-        tst_safe_checkpoint_wait(__FILE__, __LINE__, NULL, id);
+        tst_safe_checkpoint_wait(__FILE__, __LINE__, NULL, id, 0);
+
+#define TST_CHECKPOINT_WAIT2(id, msec_timeout) \
+        tst_safe_checkpoint_wait(__FILE__, __LINE__, NULL, id, msec_timeout);
 
 #define TST_CHECKPOINT_WAKE(id) \
         tst_safe_checkpoint_wake(__FILE__, __LINE__, NULL, id, 1);
diff --git a/include/tst_checkpoint_fn.h b/include/tst_checkpoint_fn.h
index ebfd22b..0730fb0 100644
--- a/include/tst_checkpoint_fn.h
+++ b/include/tst_checkpoint_fn.h
@@ -45,7 +45,8 @@ int tst_checkpoint_wake(unsigned int id, unsigned int nr_wake,
                         unsigned int msec_timeout);
 
 void tst_safe_checkpoint_wait(const char *file, const int lineno,
-                              void (*cleanup_fn)(void), unsigned int id);
+                              void (*cleanup_fn)(void), unsigned int id,
+			      unsigned int msec_timeout);
 
 void tst_safe_checkpoint_wake(const char *file, const int lineno,
                               void (*cleanup_fn)(void), unsigned int id,
diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index 5d12ac9..a23bd02 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -126,14 +126,20 @@ int tst_checkpoint_wake(unsigned int id, unsigned int nr_wake,
 }
 
 void tst_safe_checkpoint_wait(const char *file, const int lineno,
-                              void (*cleanup_fn)(void), unsigned int id)
+                              void (*cleanup_fn)(void), unsigned int id,
+			      unsigned int msec_timeout)
 {
-	int ret = tst_checkpoint_wait(id, DEFAULT_MSEC_TIMEOUT);
+	int ret;
+
+	if (!msec_timeout)
+		msec_timeout = DEFAULT_MSEC_TIMEOUT;
+
+	ret = tst_checkpoint_wait(id, msec_timeout);
 
 	if (ret) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
 		         "%s:%d: tst_checkpoint_wait(%u, %i)",
-		         file, lineno, id, DEFAULT_MSEC_TIMEOUT);
+		         file, lineno, id, msec_timeout);
 	}
 }
 
-- 
Cyril Hrubis
chrubis@suse.cz
