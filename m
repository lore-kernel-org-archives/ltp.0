From: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
Date: Tue, 14 Sep 2021 20:08:51 +0300
Subject: [LTP] [PATCH v1 6/6] rt:pi-tests:testpi-6: return exit code
In-Reply-To: <20210914170851.22931-1-bogdan.lezhepekov@suse.com>
References: <20210914170851.22931-1-bogdan.lezhepekov@suse.com>
Message-ID: <20210914170851.22931-6-bogdan.lezhepekov@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
---
 testcases/realtime/func/pi-tests/testpi-6.c | 22 ++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/testcases/realtime/func/pi-tests/testpi-6.c b/testcases/realtime/func/pi-tests/testpi-6.c
index 637d38355..bc271f242 100644
--- a/testcases/realtime/func/pi-tests/testpi-6.c
+++ b/testcases/realtime/func/pi-tests/testpi-6.c
@@ -69,27 +69,35 @@ int do_test(int argc, char **argv)
 {
 	pthread_mutexattr_t mutexattr;
 	int retc, robust;
+	unsigned int err;
 
-	if (pthread_mutexattr_init(&mutexattr) != 0)
+	if (pthread_mutexattr_init(&mutexattr) != 0) {
 		printf("Failed to init mutexattr\n");
+		err++;
+	}
 
 	if (pthread_mutexattr_setrobust(&mutexattr,
-					   PTHREAD_MUTEX_ROBUST) != 0)
+					   PTHREAD_MUTEX_ROBUST) != 0) {
 		printf("Can't set robust mutex\n");
-
-	if (pthread_mutexattr_getrobust(&mutexattr, &robust) != 0)
+		err++;
+	}
+		
+	if (pthread_mutexattr_getrobust(&mutexattr, &robust) != 0) {
 		printf("Can't get mutexattr protocol\n");
-	else
+		err++;
+	} else 
 		printf("robust in mutexattr is %d\n", robust);
 
 	retc = pthread_mutex_init(&child_mutex, &mutexattr);
-	if (retc != 0)
+	if (retc != 0) {
 		printf("Failed to init mutex: %d\n", retc);
+		err++;
+	}
 
 	create_other_thread(child_thread, NULL);
 	join_threads();
 
-	return 0;
+	return err > 0 ? 1 : 0;
 }
 
 #include "test-skeleton.c"
-- 
2.32.0

