From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 18 Aug 2017 12:22:52 +0200
Subject: [LTP] [PATCH v4 1/3] lib: add helper SAFE_FANOTIFY_INIT
In-Reply-To: <1502867737-26158-2-git-send-email-xzhou@redhat.com>
References: <20170815133616.GD30800@rei>
 <1502867737-26158-1-git-send-email-xzhou@redhat.com>
 <1502867737-26158-2-git-send-email-xzhou@redhat.com>
Message-ID: <20170818102252.GA22319@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with following patch (to fix warnings), thanks.

diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
index ecd39f8bc..d4d81c6cd 100644
--- a/lib/tst_safe_macros.c
+++ b/lib/tst_safe_macros.c
@@ -18,6 +18,10 @@
 #define _GNU_SOURCE
 #include <unistd.h>
 #include <errno.h>
+#include "config.h"
+#ifdef HAVE_SYS_FANOTIFY_H
+# include <sys/fanotify.h>
+#endif
 #define TST_NO_DEFAULT_MAIN
 #include "tst_test.h"
 #include "tst_safe_macros.h"
@@ -54,10 +58,10 @@ int safe_fanotify_init(const char *file, const int lineno,
 {
 	int rval;
 
+#ifdef HAVE_SYS_FANOTIFY_H
 	rval = fanotify_init(flags, event_f_flags);
 
 	if (rval == -1) {
-
 		if (errno == ENOSYS) {
 			tst_brk(TCONF,
 				"fanotify is not configured in this kernel.");
@@ -65,6 +69,9 @@ int safe_fanotify_init(const char *file, const int lineno,
 		tst_brk(TBROK | TERRNO,
 			"%s:%d: fanotify_init() failed", file, lineno);
 	}
+#else
+	tst_brk(TCONF, "Header <sys/fanotify.h> is not present");
+#endif /* HAVE_SYS_FANOTIFY_H */
 
 	return rval;
 }


-- 
Cyril Hrubis
chrubis@suse.cz
