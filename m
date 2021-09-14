From: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Date: Tue, 14 Sep 2021 20:08:47 +0300
Subject: [LTP] [PATCH v1 2/6] rt:pi-tests::sbrk_mutex: return actual exit
 code
In-Reply-To: <20210914170851.22931-1-bogdan.lezhepekov@suse.com>
References: <20210914170851.22931-1-bogdan.lezhepekov@suse.com>
Message-ID: <20210914170851.22931-2-bogdan.lezhepekov@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The original version always returned 0.

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 testcases/realtime/func/pi-tests/sbrk_mutex.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/sbrk_mutex.c b/testcases/realtime/func/pi-tests/sbrk_mutex.c
index 7ed7969d9..34e4e9666 100644
--- a/testcases/realtime/func/pi-tests/sbrk_mutex.c
+++ b/testcases/realtime/func/pi-tests/sbrk_mutex.c
@@ -97,7 +97,8 @@ void *worker_thread(void *arg)
 
 int main(int argc, char *argv[])
 {
-	int m, ret, robust;
+	int m, robust;
+	int ret = 0;
 	intptr_t t;
 	pthread_mutexattr_t mutexattr;
 	setup();
@@ -123,7 +124,8 @@ int main(int argc, char *argv[])
 		if (!(mutexes[m] = malloc(sizeof(pthread_mutex_t)))) {
 			perror("malloc failed\n");
 		}
-		if ((ret = pthread_mutex_init(mutexes[m], &mutexattr))) {
+		if (pthread_mutex_init(mutexes[m], &mutexattr)) {
+			ret = 1;
 			perror("pthread_mutex_init() failed\n");
 		}
 	}
@@ -140,11 +142,13 @@ int main(int argc, char *argv[])
 	/* destroy all the mutexes */
 	for (m = 0; m < NUM_MUTEXES; m++) {
 		if (mutexes[m]) {
-			if ((ret = pthread_mutex_destroy(mutexes[m])))
+			if (pthread_mutex_destroy(mutexes[m])) {
+				ret = 1;
 				perror("pthread_mutex_destroy() failed\n");
+			}
 			free(mutexes[m]);
 		}
 	}
 
-	return 0;
+	return ret;
 }
-- 
2.32.0

