From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Tue, 19 Feb 2019 19:10:53 -0300
Subject: [LTP] [PATCH] Define SIGRTMIN and SIGRTMAX for musl
Message-ID: <20190219221053.458-1-rafael.tinoco@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Although unsupported, musl enablement is always good to pursue.
Defining __SIGRTMIN and __SIGRTMAX is needed for musl enablement.

Signed-off-by: Daniel Diaz <daniel.diaz@linaro.org>
Signed-off-by: Rafael David Tinoco <rafael.tinoco@linaro.org>
---
 include/old/test.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/old/test.h b/include/old/test.h
index 0738237e9..01b0bd4de 100644
--- a/include/old/test.h
+++ b/include/old/test.h
@@ -50,6 +50,13 @@
 #define NUMSIGS NSIG
 #endif
 
+#ifndef __SIGRTMIN
+#define __SIGRTMIN 32
+#endif
+
+#ifndef __SIGRTMAX
+#define __SIGRTMAX (_NSIG - 1)
+#endif
 
 /* defines for unexpected signal setup routine (set_usig.c) */
 #define FORK    1		/* SIGCHLD is to be ignored */
-- 
2.20.1

