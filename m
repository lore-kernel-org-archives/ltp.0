From: Petr Vorel <petr.vorel@gmail.com>
Date: Sat,  2 Sep 2017 02:59:22 +0200
Subject: [LTP] [RFC PATCH 2/6] android: lib: Add missing include for
	tst_safe_pthread.h
In-Reply-To: <20170902005926.15923-1-petr.vorel@gmail.com>
References: <20170902005926.15923-1-petr.vorel@gmail.com>
Message-ID: <20170902005926.15923-3-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
Maybe __ANDROID__ or __BIONIC__ should be used to test.
---
 include/tst_safe_pthread.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/tst_safe_pthread.h b/include/tst_safe_pthread.h
index 0242d4c76..0551f063f 100644
--- a/include/tst_safe_pthread.h
+++ b/include/tst_safe_pthread.h
@@ -18,6 +18,10 @@
 #ifndef TST_SAFE_PTHREAD_H__
 #define TST_SAFE_PTHREAD_H__
 
+#ifdef __ANDROID_API__
+#include <pthread.h>
+#endif
+
 /*
  * Macro to use for making functions called only once in
  * multi-threaded tests such as init or cleanup function.
-- 
2.14.0

