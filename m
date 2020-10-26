From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 26 Oct 2020 17:47:56 +0100
Subject: [LTP] [PATCH 19/19] Unify error handling in
 include/lapi/safe_rt_signal.h
In-Reply-To: <20201026164756.30556-1-mdoucha@suse.cz>
References: <20201026164756.30556-1-mdoucha@suse.cz>
Message-ID: <20201026164756.30556-20-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Properly format caller file:line location
- Pedantically check invalid syscall return values

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/lapi/safe_rt_signal.h | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/include/lapi/safe_rt_signal.h b/include/lapi/safe_rt_signal.h
index 67fa44417..f218f19a2 100644
--- a/include/lapi/safe_rt_signal.h
+++ b/include/lapi/safe_rt_signal.h
@@ -15,10 +15,15 @@ static inline int safe_rt_sigaction(const char *file, const int lineno,
 	int ret;
 
 	ret = ltp_rt_sigaction(signum, act, oact, sigsetsize);
-	if (ret < 0) {
-		tst_brk(TBROK | TERRNO,
-			"%s:%d: ltp_rt_sigaction(%i, %p, %p, %zu) failed",
-			file, lineno, signum, act, oact, sigsetsize);
+
+	if (ret == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"ltp_rt_sigaction(%i, %p, %p, %zu) failed",
+			signum, act, oact, sigsetsize);
+	} else if (ret) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid ltp_rt_sigaction(%i, %p, %p, %zu) return "
+			"value %d", signum, act, oact, sigsetsize, ret);
 	}
 
 	return ret;
@@ -35,10 +40,14 @@ static inline int safe_rt_sigprocmask(const char *file, const int lineno,
 	int ret;
 
 	ret = tst_syscall(__NR_rt_sigprocmask, how, set, oldset, sigsetsize);
-	if (ret < 0) {
-		tst_brk(TBROK | TERRNO,
-		        "%s:%d: rt_sigprocmask(%i, %p, %p, %zu) failed",
-			file, lineno, how, set, oldset, sigsetsize);
+	if (ret == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"rt_sigprocmask(%i, %p, %p, %zu) failed",
+			how, set, oldset, sigsetsize);
+	} else if (ret) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"Invalid rt_sigprocmask(%i, %p, %p, %zu) return "
+			"value %d", how, set, oldset, sigsetsize, ret);
 	}
 
 	return ret;
-- 
2.28.0

