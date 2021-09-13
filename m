From: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Date: Mon, 13 Sep 2021 18:31:18 +0300
Subject: [LTP] [PATCH v1] realtime:matrix_multi: main function to return
 exit status
Message-ID: <20210913153118.25002-1-bogdan.lezhepekov@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The original version always returned 0.

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 testcases/realtime/func/matrix_mult/matrix_mult.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/testcases/realtime/func/matrix_mult/matrix_mult.c b/testcases/realtime/func/matrix_mult/matrix_mult.c
index 61ab887fc..e702c0ff9 100644
--- a/testcases/realtime/func/matrix_mult/matrix_mult.c
+++ b/testcases/realtime/func/matrix_mult/matrix_mult.c
@@ -188,7 +188,7 @@ void *concurrent_thread(void *thread)
 	return NULL;
 }
 
-void main_thread(void)
+int main_thread(void)
 {
 	int ret, i, j;
 	nsec_t start, end;
@@ -308,7 +308,7 @@ void main_thread(void)
 	     criteria);
 	printf("Result: %s\n", ret ? "FAIL" : "PASS");
 
-	return;
+	return ret;
 }
 
 int main(int argc, char *argv[])
@@ -319,7 +319,7 @@ int main(int argc, char *argv[])
 	numcpus = sysconf(_SC_NPROCESSORS_ONLN);
 	/* the minimum avg concurrent multiplier to pass */
 	criteria = pass_criteria * numcpus;
-	int new_iterations;
+	int new_iterations, ret;
 
 	if (iterations <= 0) {
 		fprintf(stderr, "iterations must be greater than zero\n");
@@ -348,7 +348,7 @@ int main(int argc, char *argv[])
 	printf("Number of CPUs: %u\n", numcpus);
 
 	set_priority(PRIO);
-	main_thread();
+	ret = main_thread();
 
-	return 0;
+	return ret;
 }
-- 
2.32.0

