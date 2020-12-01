From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  1 Dec 2020 18:42:13 +0100
Subject: [LTP] [PATCH v5 09/10] fanotify: Add a pedantic check for return
 value
In-Reply-To: <20201201174214.24625-1-pvorel@suse.cz>
References: <20201201174214.24625-1-pvorel@suse.cz>
Message-ID: <20201201174214.24625-10-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

for fanotify_init() in safe_fanotify_init()

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Same as v4.

 testcases/kernel/syscalls/fanotify/fanotify.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 0e99b4ac1..540c2b0fc 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -54,6 +54,11 @@ int safe_fanotify_init(const char *file, const int lineno,
 		tst_brk_(file, lineno, TBROK | TERRNO,
 			"%s:%d: fanotify_init() failed", file, lineno);
 	}
+
+	if (rval < -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			 "invalid fanotify_init() return %d", rval);
+	}
 #else
 	tst_brk_(file, lineno, TCONF, "Header <sys/fanotify.h> is not present");
 #endif /* HAVE_SYS_FANOTIFY_H */
-- 
2.29.2

