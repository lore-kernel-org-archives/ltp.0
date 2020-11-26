From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 26 Nov 2020 22:41:21 +0100
Subject: [LTP] [PATCH v4 6/6] fanotify: Add a pedantic check for return value
In-Reply-To: <20201126214121.6836-1-pvorel@suse.cz>
References: <20201126214121.6836-1-pvorel@suse.cz>
Message-ID: <20201126214121.6836-7-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

for fanotify_init() in safe_fanotify_init()

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/fanotify/fanotify.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 4b725f334..e75b27754 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -192,6 +192,11 @@ int safe_fanotify_init(const char *file, const int lineno,
 
 		tst_brk_(file, lineno, TBROK | TERRNO, "fanotify_init() failed");
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

