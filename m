From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Sat, 17 Apr 2021 10:51:23 +0800
Subject: [LTP] [PATCH] openposix: Correct typos of TEST
Message-ID: <20210417025123.15764-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For those:
	testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/2-1.c
	testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-3.c
	testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-4.c
	testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/1-3.c
	testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/1-4.c
	testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/6-2.c
	testcases/open_posix_testsuite/conformance/interfaces/sem_wait/1-2.c
	testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_1.c
	testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_2.c
	testcases/open_posix_testsuite/functional/threads/schedule/1-1.c
	testcases/open_posix_testsuite/functional/threads/schedule/1-2.c

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 .../conformance/interfaces/pthread_attr_getschedpolicy/2-1.c    | 2 +-
 .../conformance/interfaces/pthread_attr_setinheritsched/2-3.c   | 2 +-
 .../conformance/interfaces/pthread_attr_setinheritsched/2-4.c   | 2 +-
 .../conformance/interfaces/pthread_attr_setschedparam/1-3.c     | 2 +-
 .../conformance/interfaces/pthread_attr_setschedparam/1-4.c     | 2 +-
 .../conformance/interfaces/sem_timedwait/6-2.c                  | 2 +-
 .../open_posix_testsuite/conformance/interfaces/sem_wait/1-2.c  | 2 +-
 .../functional/threads/condvar/pthread_cond_wait_1.c            | 2 +-
 .../functional/threads/condvar/pthread_cond_wait_2.c            | 2 +-
 .../open_posix_testsuite/functional/threads/schedule/1-1.c      | 2 +-
 .../open_posix_testsuite/functional/threads/schedule/1-2.c      | 2 +-
 11 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/2-1.c
index 80dc2c2be..70818e29e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_getschedpolicy/2-1.c
@@ -19,7 +19,7 @@
 #include <stdlib.h>
 #include "posixtest.h"

-#define TEST "1-1"
+#define TEST "2-1"
 #define FUNCTION "pthread_attr_getschedpolicy"
 #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-3.c
index a1047651c..ae268c822 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-3.c
@@ -21,7 +21,7 @@
 #include <stdlib.h>
 #include "posixtest.h"

-#define TEST "4-1"
+#define TEST "2-3"
 #define AREA "scheduler"
 #define ERROR_PREFIX "unexpected error: " AREA " " TEST ": "

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-4.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-4.c
index 85ac35e73..dbc6abfc7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setinheritsched/2-4.c
@@ -21,7 +21,7 @@
 #include <stdlib.h>
 #include "posixtest.h"

-#define TEST "4-2"
+#define TEST "2-4"
 #define AREA "scheduler"
 #define ERROR_PREFIX "unexpected error: " AREA " " TEST ": "

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/1-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/1-3.c
index 1f0289013..a09227d8d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/1-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/1-3.c
@@ -21,7 +21,7 @@
 #include <stdlib.h>
 #include "posixtest.h"

-#define TEST "3-1"
+#define TEST "1-3"
 #define AREA "scheduler"
 #define ERROR_PREFIX "unexpected error: " AREA " " TEST ": "

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/1-4.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/1-4.c
index 5e13ea407..ee06d4390 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/1-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setschedparam/1-4.c
@@ -21,7 +21,7 @@
 #include <stdlib.h>
 #include "posixtest.h"

-#define TEST "3-2"
+#define TEST "1-4"
 #define AREA "scheduler"
 #define ERROR_PREFIX "unexpected error: " AREA " " TEST ": "

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/6-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/6-2.c
index f957191bf..1ad0fad33 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/6-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_timedwait/6-2.c
@@ -22,7 +22,7 @@
 #include <time.h>
 #include "posixtest.h"

-#define TEST "5-1"
+#define TEST "6-2"
 #define FUNCTION "sem_timedwait"
 #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sem_wait/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/sem_wait/1-2.c
index ad2e47519..bbfe45250 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sem_wait/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sem_wait/1-2.c
@@ -20,7 +20,7 @@
 #include <signal.h>
 #include "posixtest.h"

-#define TEST "2-1"
+#define TEST "1-2"
 #define FUNCTION "sem_wait"
 #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "

diff --git a/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_1.c b/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_1.c
index 53dea8bc6..9226c50b6 100644
--- a/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_1.c
+++ b/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_1.c
@@ -27,7 +27,7 @@
 #include "posixtest.h"
 #include "safe_helpers.h"

-#define TEST "5-1"
+#define TEST "pthread_cond_wait_1"
 #define AREA "scheduler"
 #define ERROR_PREFIX "unexpected error: " AREA " " TEST ": "

diff --git a/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_2.c b/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_2.c
index 3b1af3cd7..5073e9c9d 100644
--- a/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_2.c
+++ b/testcases/open_posix_testsuite/functional/threads/condvar/pthread_cond_wait_2.c
@@ -27,7 +27,7 @@
 #include "posixtest.h"
 #include "safe_helpers.h"

-#define TEST "5-1"
+#define TEST "pthread_cond_wait_2"
 #define AREA "scheduler"
 #define ERROR_PREFIX "unexpected error: " AREA " " TEST ": "

diff --git a/testcases/open_posix_testsuite/functional/threads/schedule/1-1.c b/testcases/open_posix_testsuite/functional/threads/schedule/1-1.c
index 293a15126..b221809d9 100644
--- a/testcases/open_posix_testsuite/functional/threads/schedule/1-1.c
+++ b/testcases/open_posix_testsuite/functional/threads/schedule/1-1.c
@@ -28,7 +28,7 @@
 #include "posixtest.h"
 #include "safe_helpers.h"

-#define TEST "5-4"
+#define TEST "1-1"
 #define AREA "scheduler"
 #define ERROR_PREFIX "unexpected error: " AREA " " TEST ": "

diff --git a/testcases/open_posix_testsuite/functional/threads/schedule/1-2.c b/testcases/open_posix_testsuite/functional/threads/schedule/1-2.c
index b5b7006e2..8614d5733 100644
--- a/testcases/open_posix_testsuite/functional/threads/schedule/1-2.c
+++ b/testcases/open_posix_testsuite/functional/threads/schedule/1-2.c
@@ -27,7 +27,7 @@
 #include "posixtest.h"
 #include "safe_helpers.h"

-#define TEST "5-5"
+#define TEST "1-2"
 #define AREA "scheduler"
 #define ERROR_PREFIX "unexpected error: " AREA " " TEST ": "

--
2.17.1

