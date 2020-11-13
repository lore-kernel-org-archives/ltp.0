From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Nov 2020 17:49:44 +0100
Subject: [LTP] [PATCH v3 5/5] fanotify: Add a pedantic check for return value
In-Reply-To: <20201113164944.26101-1-pvorel@suse.cz>
References: <20201113164944.26101-1-pvorel@suse.cz>
Message-ID: <20201113164944.26101-6-pvorel@suse.cz>
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
index 04b6699cf..dc76d092b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify.h
+++ b/testcases/kernel/syscalls/fanotify/fanotify.h
@@ -193,6 +193,11 @@ int safe_fanotify_init(const char *file, const int lineno,
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

