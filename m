From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  1 Dec 2020 18:42:12 +0100
Subject: [LTP] [PATCH v5 08/10] fanotify: Use tst_brk_ in
 safe_fanotify_init()
In-Reply-To: <20201201174214.24625-1-pvorel@suse.cz>
References: <20201201174214.24625-1-pvorel@suse.cz>
Message-ID: <20201201174214.24625-9-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This show correct file and line number
(sync with safe_fanotify_mark()).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v5 (previously part of "[v4,5/6] fanotify: Check FAN_REPORT_{FID,
NAME} support").

 testcases/kernel/syscalls/fanotify/fanotify.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index e0504ba81..0e99b4ac1 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -48,14 +48,14 @@ int safe_fanotify_init(const char *file, const int lineno,
 
 	if (rval == -1) {
 		if (errno == ENOSYS) {
-			tst_brk(TCONF,
-				"fanotify is not configured in this kernel.");
+			tst_brk_(file, lineno, TCONF,
+				"fanotify is not configured in this kernel");
 		}
-		tst_brk(TBROK | TERRNO,
+		tst_brk_(file, lineno, TBROK | TERRNO,
 			"%s:%d: fanotify_init() failed", file, lineno);
 	}
 #else
-	tst_brk(TCONF, "Header <sys/fanotify.h> is not present");
+	tst_brk_(file, lineno, TCONF, "Header <sys/fanotify.h> is not present");
 #endif /* HAVE_SYS_FANOTIFY_H */
 
 	return rval;
-- 
2.29.2

