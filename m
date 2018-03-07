From: Michael Moese <mmoese@suse.de>
Date: Wed,  7 Mar 2018 09:05:18 +0100
Subject: [LTP] [PATCH v5 2/3] Add a library wrapper for sigaction()
In-Reply-To: <20180307080519.15066-1-mmoese@suse.de>
References: <20180307080519.15066-1-mmoese@suse.de>
Message-ID: <20180307080519.15066-3-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In a multithreaded program, using signal() results in unspecified
behavior. In this case, sigaction() has to be used to install a
signal handler.
Therefore, SAFE_SIGACTION() is added.

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 include/tst_safe_macros.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
index 06bff13c7..bf12e0719 100644
--- a/include/tst_safe_macros.h
+++ b/include/tst_safe_macros.h
@@ -397,6 +397,26 @@ static inline sighandler_t safe_signal(const char *file, const int lineno,
 #define SAFE_SIGNAL(signum, handler) \
 	safe_signal(__FILE__, __LINE__, (signum), (handler))
 
+
+
+static inline int safe_sigaction(const char *file, const int lineno,
+				 int signum, const struct sigaction *act,
+				 struct sigaction *oldact)
+{
+	int rval;
+
+	rval = sigaction(signum, act, oldact);
+
+	if (rval == -1) {
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"sigaction(%d, %p, %p) failed", signum, act, oldact);
+	}
+
+	return rval;
+}
+#define SAFE_SIGACTION(signum, act, oldact) \
+	safe_sigaction(__FILE__, __LINE__, (signum), (act), (oldact))
+
 #define SAFE_EXECLP(file, arg, ...) do {                   \
 	execlp((file), (arg), ##__VA_ARGS__);              \
 	tst_brk_(__FILE__, __LINE__, TBROK | TERRNO,       \
-- 
2.13.6

