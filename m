From: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Date: Tue, 14 Sep 2021 20:08:50 +0300
Subject: [LTP] [PATCH v1 5/6] rt:pi-tests:testpi-5: return exit code
In-Reply-To: <20210914170851.22931-1-bogdan.lezhepekov@suse.com>
References: <20210914170851.22931-1-bogdan.lezhepekov@suse.com>
Message-ID: <20210914170851.22931-5-bogdan.lezhepekov@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 testcases/realtime/func/pi-tests/testpi-5.c | 24 ++++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-5.c b/testcases/realtime/func/pi-tests/testpi-5.c
index a52486417..538be1e44 100644
--- a/testcases/realtime/func/pi-tests/testpi-5.c
+++ b/testcases/realtime/func/pi-tests/testpi-5.c
@@ -68,29 +68,37 @@ int do_test(int argc, char **argv)
 {
 	pthread_mutexattr_t mutexattr;
 	int retc, protocol;
+	unsigned int err = 0;
 
 #if HAS_PRIORITY_INHERIT
 
-	if (pthread_mutexattr_init(&mutexattr) != 0)
+	if (pthread_mutexattr_init(&mutexattr) != 0) {
 		printf("Failed to init mutexattr\n");
+		err++;
+	}
 
 	if (pthread_mutexattr_setprotocol(&mutexattr,
-					  PTHREAD_PRIO_INHERIT) != 0)
+					  PTHREAD_PRIO_INHERIT) != 0) {
 		printf("Can't set protocol prio inherit\n");
-
-	if (pthread_mutexattr_getprotocol(&mutexattr, &protocol) != 0)
+		err++;
+	}
+		
+	if (pthread_mutexattr_getprotocol(&mutexattr, &protocol) != 0) {
 		printf("Can't get mutexattr protocol\n");
-	else
+		err++;
+	} else 
 		printf("protocol in mutexattr is %d\n", protocol);
-
+		
 	retc = pthread_mutex_init(&child_mutex, &mutexattr);
-	if (retc != 0)
+	if (retc != 0) {
 		printf("Failed to init mutex: %d\n", retc);
+		err++;
+	}
 
 	create_other_thread(child_thread, NULL);
 	join_threads();
 
-	return 0;
+	return err > 0 ? 1: 0;
 #else
 	return 1;
 #endif
-- 
2.32.0

