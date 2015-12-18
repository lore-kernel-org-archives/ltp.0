From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 18 Dec 2015 17:35:29 +0300
Subject: [LTP] [PATCH 1/7] pi_test: move duplicated stuff to the header
In-Reply-To: <1450449335-18223-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1450449335-18223-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1450449335-18223-2-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../functional/threads/include/pitest.h            |   45 +++++++++++++++++++-
 .../functional/threads/pi_test/pitest-1.c          |   44 +-------------------
 .../functional/threads/pi_test/pitest-2.c          |   43 +------------------
 .../functional/threads/pi_test/pitest-3.c          |   43 +------------------
 .../functional/threads/pi_test/pitest-4.c          |   43 +------------------
 .../functional/threads/pi_test/pitest-5.c          |   43 +------------------
 .../functional/threads/pi_test/pitest-6.c          |   43 +------------------
 7 files changed, 50 insertions(+), 254 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/threads/include/pitest.h b/testcases/open_posix_testsuite/functional/threads/include/pitest.h
index dd7a48f..89d2ca0 100644
--- a/testcases/open_posix_testsuite/functional/threads/include/pitest.h
+++ b/testcases/open_posix_testsuite/functional/threads/include/pitest.h
@@ -7,12 +7,41 @@
  *  source tree.
  */
 
-#include <sys/time.h>
+#ifndef __linux__
+#error "Contains Linux-isms that need fixing."
+#endif
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <pthread.h>
+#include <sched.h>
+#include <stdio.h>
+#include <stdlib.h>
 #include <string.h>
+#include <sys/time.h>
+#include <time.h>
+#include <unistd.h>
 #include "test.h"
 
 #define PROTOCOL                PTHREAD_PRIO_INHERIT
 
+struct thread_param {
+	int index;
+	volatile int stop;
+	int sleep_ms;
+	int priority;
+	int policy;
+	const char *name;
+	int cpu;
+	volatile unsigned futex;
+	volatile unsigned should_stall;
+	volatile unsigned progress;
+};
+
+static int cpus;
+static volatile int ts_stop;
+static volatile double base_time;
+
 static inline
 double seconds_read(void)
 {
@@ -83,3 +112,17 @@ int threadattr_init(pthread_attr_t *threadattr)
 	return 0;
 }
 
+static volatile unsigned do_work_dummy;
+static void do_work(unsigned granularity_top, volatile unsigned *progress)
+{
+	unsigned granularity_cnt, i;
+	unsigned top = 5 * 1000 * 1000;
+	unsigned dummy = do_work_dummy;
+
+	for (granularity_cnt = 0; granularity_cnt < granularity_top;
+	     granularity_cnt++) {
+		for (i = 0; i < top; i++)
+			dummy = i | dummy;
+		(*progress)++;
+	}
+}
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
index 11867fe..3db1134 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
@@ -33,37 +33,11 @@
  * Thanks Inaky.Perez-Gonzalez's suggestion and code
  */
 
-#warning "Contains Linux-isms that need fixing."
-
-#include <errno.h>
-#include <pthread.h>
-#include <sched.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <time.h>
-#include <unistd.h>
-#include "test.h"
 #include "pitest.h"
 
-int cpus;
 pthread_mutex_t mutex;
 
-volatile int ts_stop = 0;
-volatile double base_time;
-
-struct thread_param {
-	int index;
-	volatile int stop;
-	int sleep_ms;
-	int priority;
-	int policy;
-	const char *name;
-	int cpu;
-	volatile unsigned futex;
-	volatile unsigned should_stall;
-	volatile unsigned progress;
-} tp[] = {
+struct thread_param tp[] = {
 	{
 	0, 0, 0, 1, SCHED_FIFO, "TL", 0, 0, 0, 0}, {
 	1, 0, 50, 2, SCHED_FIFO, "TP", 0, 0, 0, 0}, {
@@ -75,22 +49,6 @@ struct thread_param {
 	7, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-volatile unsigned do_work_dummy;
-void do_work(unsigned granularity_top, volatile unsigned *progress)
-{
-	unsigned granularity_cnt, i;
-	unsigned top = 5 * 1000 * 1000;
-	unsigned dummy = do_work_dummy;
-
-	for (granularity_cnt = 0; granularity_cnt < granularity_top;
-	     granularity_cnt++) {
-		for (i = 0; i < top; i++)
-			dummy = i | dummy;
-		(*progress)++;
-	}
-	return;
-}
-
 void *thread_fn(void *param)
 {
 	struct thread_param *tp = param;
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
index dda51c3..0220af8 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
@@ -35,36 +35,11 @@
  *
  */
 
-#warning "Contains Linux-isms that need fixing."
-
-#include <errno.h>
-#include <pthread.h>
-#include <sched.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <time.h>
-#include <unistd.h>
-#include "test.h"
 #include "pitest.h"
 
-int cpus;
 pthread_mutex_t mutex;
-volatile int ts_stop = 0;
-volatile double base_time;
-
-struct thread_param {
-	int index;
-	volatile int stop;
-	int sleep_ms;
-	int priority;
-	int policy;
-	const char *name;
-	int cpu;
-	volatile unsigned futex;
-	volatile unsigned should_stall;
-	volatile unsigned progress;
-} tp[] = {
+
+struct thread_param tp[] = {
 	{
 	0, 0, 0, 1, SCHED_FIFO, "TL", 0, 0, 0, 0}, {
 	1, 0, 500, 2, SCHED_FIFO, "TP1", 0, 0, 0, 0}, {
@@ -77,22 +52,6 @@ struct thread_param {
 	8, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-volatile unsigned do_work_dummy;
-void do_work(unsigned granularity_top, volatile unsigned *progress)
-{
-	unsigned granularity_cnt, i;
-	unsigned top = 5 * 1000 * 1000;
-	unsigned dummy = do_work_dummy;
-
-	for (granularity_cnt = 0; granularity_cnt < granularity_top;
-	     granularity_cnt++) {
-		for (i = 0; i < top; i++)
-			dummy = i | dummy;
-		(*progress)++;
-	}
-	return;
-}
-
 void *thread_fn(void *param)
 {
 	struct thread_param *tp = param;
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
index 5e925a5..b9d63ec 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
@@ -35,37 +35,12 @@
  *
  */
 
-#warning "Contains Linux-isms that need fixing."
-
-#include <pthread.h>
-#include <stdio.h>
-#include <unistd.h>
-#include <string.h>
-#include <stdlib.h>
-#include <time.h>
-#include <sched.h>
-#include <errno.h>
-#include "test.h"
 #include "pitest.h"
 
-int cpus;
 pthread_mutex_t mutex1;
 pthread_mutex_t mutex2;
-volatile int ts_stop = 0;
-volatile double base_time;
-
-struct thread_param {
-	int index;
-	volatile int stop;
-	int sleep_ms;
-	int priority;
-	int policy;
-	const char *name;
-	int cpu;
-	volatile unsigned futex;
-	volatile unsigned should_stall;
-	volatile unsigned progress;
-} tp[] = {
+
+struct thread_param tp[] = {
 	{
 	0, 0, 0, 1, SCHED_FIFO, "TL", 0, 0, 0, 0}, {
 	1, 0, 500, 2, SCHED_FIFO, "TP1", 0, 0, 0, 0}, {
@@ -78,22 +53,6 @@ struct thread_param {
 	7, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-volatile unsigned do_work_dummy;
-void do_work(unsigned granularity_top, volatile unsigned *progress)
-{
-	unsigned granularity_cnt, i;
-	unsigned top = 5 * 1000 * 1000;
-	unsigned dummy = do_work_dummy;
-
-	for (granularity_cnt = 0; granularity_cnt < granularity_top;
-	     granularity_cnt++) {
-		for (i = 0; i < top; i++)
-			dummy = i | dummy;
-		(*progress)++;
-	}
-	return;
-}
-
 void *thread_fn(void *param)
 {
 	struct thread_param *tp = param;
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
index dc4bd02..75a776b 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
@@ -36,37 +36,12 @@
  *
  */
 
-#warning "Contains Linux-isms that need fixing."
-
-#include <errno.h>
-#include <pthread.h>
-#include <sched.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <time.h>
-#include <unistd.h>
-#include "test.h"
 #include "pitest.h"
 
-int cpus;
 pthread_mutex_t mutex1;
 pthread_mutex_t mutex2;
-volatile int ts_stop = 0;
-volatile double base_time;
-
-struct thread_param {
-	int index;
-	volatile int stop;
-	int sleep_ms;
-	int priority;
-	int policy;
-	const char *name;
-	int cpu;
-	volatile unsigned futex;
-	volatile unsigned should_stall;
-	volatile unsigned progress;
-} tp[] = {
+
+struct thread_param tp[] = {
 	{
 	0, 0, 0, 1, SCHED_FIFO, "TL", 0, 0, 0, 0}, {
 	1, 0, 100, 4, SCHED_FIFO, "TP", 0, 0, 0, 0}, {
@@ -78,22 +53,6 @@ struct thread_param {
 	7, 0, 0, 2, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-volatile unsigned do_work_dummy;
-void do_work(unsigned granularity_top, volatile unsigned *progress)
-{
-	unsigned granularity_cnt, i;
-	unsigned top = 5 * 1000 * 1000;
-	unsigned dummy = do_work_dummy;
-
-	for (granularity_cnt = 0; granularity_cnt < granularity_top;
-	     granularity_cnt++) {
-		for (i = 0; i < top; i++)
-			dummy = i | dummy;
-		(*progress)++;
-	}
-	return;
-}
-
 void *thread_fn(void *param)
 {
 	struct thread_param *tp = param;
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c
index 9540d06..b70c549 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c
@@ -34,37 +34,12 @@
  * NOTE: Most of the code is ported from test-11 written by inkay.
  */
 
-#warning "Contains Linux-isms that need fixing."
-
-#include <errno.h>
-#include <pthread.h>
-#include <sched.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <time.h>
-#include <unistd.h>
-#include "test.h"
 #include "pitest.h"
 
-int cpus;
 pthread_mutex_t mutex;
-volatile int ts_stop = 0;
-volatile double base_time;
 volatile int unlock_mutex = 0;
 
-struct thread_param {
-	int index;
-	volatile int stop;
-	int sleep_ms;
-	int priority;
-	int policy;
-	const char *name;
-	int cpu;
-	volatile unsigned futex;
-	volatile unsigned should_stall;
-	volatile unsigned progress;
-} tp[] = {
+struct thread_param tp[] = {
 	{
 	0, 0, 0, 1, SCHED_FIFO, "TL", 0, 0, 0, 0}, {
 	1, 0, 200, 2, SCHED_FIFO, "TP", 0, 0, 0, 0}, {
@@ -76,22 +51,6 @@ struct thread_param {
 	7, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-volatile unsigned do_work_dummy;
-void do_work(unsigned granularity_top, volatile unsigned *progress)
-{
-	unsigned granularity_cnt, i;
-	unsigned top = 5 * 1000 * 1000;
-	unsigned dummy = do_work_dummy;
-
-	for (granularity_cnt = 0; granularity_cnt < granularity_top;
-	     granularity_cnt++) {
-		for (i = 0; i < top; i++)
-			dummy = i | dummy;
-		(*progress)++;
-	}
-	return;
-}
-
 void *thread_fn(void *param)
 {
 	struct thread_param *tp = param;
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
index 19d6755..bd92613 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
@@ -33,36 +33,11 @@
  * NOTE: Most of the code is ported from test-11 written by inkay.
  */
 
-#warning "Contains Linux-isms that need fixing."
-
-#include <errno.h>
-#include <pthread.h>
-#include <sched.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <time.h>
-#include <unistd.h>
-#include "test.h"
 #include "pitest.h"
 
-int cpus;
 pthread_mutex_t mutex;
-volatile int ts_stop = 0;
-volatile double base_time;
-
-struct thread_param {
-	int index;
-	volatile int stop;
-	int sleep_ms;
-	int priority;
-	int policy;
-	const char *name;
-	int cpu;
-	volatile unsigned futex;
-	volatile unsigned should_stall;
-	volatile unsigned progress;
-} tp[] = {
+
+struct thread_param tp[] = {
 	{
 	0, 0, 0, 1, SCHED_FIFO, "TL", 0, 0, 0, 0}, {
 	1, 0, 200, 2, SCHED_FIFO, "TP", 0, 0, 0, 0}, {
@@ -74,22 +49,6 @@ struct thread_param {
 	7, 0, 0, 3, SCHED_FIFO, "TF", 6, 0, 0, 0}
 };
 
-volatile unsigned do_work_dummy;
-void do_work(unsigned granularity_top, volatile unsigned *progress)
-{
-	unsigned granularity_cnt, i;
-	unsigned top = 5 * 1000 * 1000;
-	unsigned dummy = do_work_dummy;
-
-	for (granularity_cnt = 0; granularity_cnt < granularity_top;
-	     granularity_cnt++) {
-		for (i = 0; i < top; i++)
-			dummy = i | dummy;
-		(*progress)++;
-	}
-	return;
-}
-
 void *thread_fn(void *param)
 {
 	struct thread_param *tp = param;
-- 
1.7.1

