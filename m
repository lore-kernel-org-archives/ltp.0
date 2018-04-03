From: Erick Reyes <erickreyes@google.com>
Date: Mon,  2 Apr 2018 18:40:06 -0700
Subject: [LTP] [PATCH] Fix floating point tests Android compatibility
Message-ID: <20180403014006.169320-1-erickreyes@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Floating point tests spawn a signal handler thread, which is then
terminated with pthread_cancel / pthread_join calls. Since Android does
not implement these functions, the tests were hanging.

The function calls to end the signal handler thread are actually not
needed, it will just die when the main thread calls exit().

Signed-off-by: Erick Reyes <erickreyes@google.com>
---
 testcases/misc/math/float/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/testcases/misc/math/float/main.c b/testcases/misc/math/float/main.c
index d71ca18e6..7285141a4 100644
--- a/testcases/misc/math/float/main.c
+++ b/testcases/misc/math/float/main.c
@@ -299,8 +299,6 @@ finished:
 		SAFE_FREE(pcom);
 
 	}
-	pthread_cancel(sig_hand);
-	pthread_join(sig_hand, NULL);
 	SAFE_FREE(tabcom);
 	SAFE_FREE(threads);
 	tst_rmdir();
-- 
2.17.0.rc1.321.gba9d0f2565-goog

