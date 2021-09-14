From: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Date: Tue, 14 Sep 2021 20:08:46 +0300
Subject: [LTP] [PATCH v1 1/6] realtime:async_handler_jk: return actual exit
 code
Message-ID: <20210914170851.22931-1-bogdan.lezhepekov@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The original version always returned 0.

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 testcases/realtime/func/async_handler/async_handler_jk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/testcases/realtime/func/async_handler/async_handler_jk.c b/testcases/realtime/func/async_handler/async_handler_jk.c
index 4d8721822..8b40a474a 100644
--- a/testcases/realtime/func/async_handler/async_handler_jk.c
+++ b/testcases/realtime/func/async_handler/async_handler_jk.c
@@ -137,6 +137,7 @@ int main(int argc, char *argv[])
 {
 	int aes_id;		// asynchronous event server id
 	int user_id;		// User thread - that fires the event
+	int result;
 	long delta;
 	struct thread *server;
 	setup();
@@ -155,10 +156,11 @@ int main(int argc, char *argv[])
 	join_thread(user_id);
 	join_threads();
 	delta = (end - start) / NS_PER_US;
+	result = delta > pass_criteria ? 1 : 0;
 
 	printf("delta = %ld us\n", delta);
 	printf("\nCriteria: latencies < %d\n", (int)pass_criteria);
-	printf("Result: %s\n", delta > pass_criteria ? "FAIL" : "PASS");
+	printf("Result: %s\n",  result ? "FAIL" : "PASS");
 
-	return 0;
+	return result;
 }
-- 
2.32.0

