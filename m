From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 26 Oct 2020 17:47:53 +0100
Subject: [LTP] [PATCH 16/19] Unify error handling in
 include/tst_safe_posix_ipc.h
In-Reply-To: <20201026164756.30556-1-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
Message-ID: <20201026164756.30556-17-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Properly format caller file:line location

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_safe_posix_ipc.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/tst_safe_posix_ipc.h b/include/tst_safe_posix_ipc.h
index d74ef4ee8..b60c12c9e 100644
--- a/include/tst_safe_posix_ipc.h
+++ b/include/tst_safe_posix_ipc.h
@@ -36,9 +36,11 @@ static inline int safe_mq_open(const char *file, const int lineno,
 	va_end(ap);
 
 	rval = mq_open(pathname, oflags, mode, attr);
+
 	if (rval == -1) {
-		tst_brk(TBROK | TERRNO, "%s:%d: mq_open(%s,%d,0%o,%p) failed",
-			 file, lineno, pathname, oflags, mode, attr);
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"mq_open(%s,%d,%04o,%p) failed", pathname, oflags,
+			mode, attr);
 	}
 
 	return rval;
-- 
2.28.0

