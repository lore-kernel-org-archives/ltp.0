From: Khem Raj <raj.khem@gmail.com>
Date: Thu,  7 Jan 2016 07:37:07 +0000
Subject: [LTP] [PATCH] Declare lio_async_callback_handler() for linux too
Message-ID: <1452152227-128032-1-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

sigval_t is glibc only construct, we use a union of sigval
which pretty much is same effect as sigval_t

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 lib/tlibio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tlibio.c b/lib/tlibio.c
index 6b6103f..b7d9faa 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
@@ -130,7 +130,7 @@
 #endif
 
 static void lio_async_signal_handler();
-#ifdef sgi
+#if defined(sgi) || (defined(__linux__) && !defined(__UCLIBC__))
 static void lio_async_callback_handler();
 #endif
 
@@ -441,7 +441,7 @@ static void lio_async_signal_handler(int sig)
  * If the handler is called, it will increment the Received_callback
  * global variable.
  ***********************************************************************/
-static void lio_async_callback_handler(sigval_t sigval)
+static void lio_async_callback_handler(union sigval sigval)
 {
 	if (Debug_level)
 		printf
-- 
2.7.0

