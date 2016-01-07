From: Khem Raj <raj.khem@gmail.com>
Date: Thu,  7 Jan 2016 12:25:16 +0000
Subject: [LTP] [PATCH V2] Use a union of sigval instead of sigval_t
Message-ID: <1452169516-104606-1-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

sigval_t is glibc only construct, we use a union of sigval
which pretty much is same effect as sigval_t

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 lib/tlibio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/tlibio.c b/lib/tlibio.c
index 6b6103f..7b6bb33 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
@@ -130,9 +130,6 @@
 #endif
 
 static void lio_async_signal_handler();
-#ifdef sgi
-static void lio_async_callback_handler();
-#endif
 
 /*
  * Define the structure as used in lio_parse_arg1 and lio_help1
@@ -441,7 +438,7 @@ static void lio_async_signal_handler(int sig)
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

