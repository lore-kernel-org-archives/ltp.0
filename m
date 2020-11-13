From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Nov 2020 16:51:23 +0100
Subject: [LTP] [PATCH v2 5/5] fanotify: Add a pedantic check for return value
In-Reply-To: <20201113155123.5959-1-pvorel@suse.cz>
References: <20201113155123.5959-1-pvorel@suse.cz>
Message-ID: <20201113155123.5959-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

for fanotify_init() in safe_fanotify_init()

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2.

FYI We agreed in LTP to test these.

 testcases/kernel/syscalls/fanotify/fanotify.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
index 277760c09..f3c2d48b3 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -67,6 +67,11 @@ int safe_fanotify_init(const char *file, const int lineno,
 		tst_brk(TBROK | TERRNO, "%s:%d: fanotify_init() failed",
 			file, lineno);
 	}
+
+	if (rval < -1) {
+		tst_brk(TBROK | TERRNO, "%s:%d: invalid fanotify_init() return %d",
+			file, lineno, rval);
+	}
 #else
 	tst_brk(TCONF, "Header <sys/fanotify.h> is not present");
 #endif /* HAVE_SYS_FANOTIFY_H */
-- 
2.29.2

