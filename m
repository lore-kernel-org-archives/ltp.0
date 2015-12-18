From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Fri, 18 Dec 2015 17:35:34 +0300
Subject: [LTP] [PATCH 6/7] pi_test: remove unused arguments from main()
In-Reply-To: <1450449335-18223-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1450449335-18223-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1450449335-18223-7-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../functional/threads/pi_test/pitest-1.c          |    2 +-
 .../functional/threads/pi_test/pitest-2.c          |    2 +-
 .../functional/threads/pi_test/pitest-3.c          |    2 +-
 .../functional/threads/pi_test/pitest-4.c          |    2 +-
 .../functional/threads/pi_test/pitest-5.c          |    2 +-
 .../functional/threads/pi_test/pitest-6.c          |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
index 2c65ad9..3b4b360 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-1.c
@@ -82,7 +82,7 @@ void *thread_tb(void *arg)
 	    return NULL;
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	pthread_mutexattr_t mutex_attr;
 	pthread_attr_t threadattr;
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
index e1bbe43..76716f4 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-2.c
@@ -110,7 +110,7 @@ void *thread_tb2(void *arg)
 	return NULL;
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	pthread_mutexattr_t mutex_attr;
 	pthread_attr_t threadattr;
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
index 809fbb8..17cc43d 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-3.c
@@ -111,7 +111,7 @@ void *thread_tb2(void *arg)
 	return NULL;
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	pthread_mutexattr_t mutex_attr;
 	pthread_attr_t threadattr;
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
index 13c34ef..84f9878 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-4.c
@@ -159,7 +159,7 @@ void *thread_tb2(void *arg)
 	return NULL;
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	pthread_mutexattr_t mutex_attr;
 	pthread_attr_t threadattr;
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c
index d180e1a..3ba3a94 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-5.c
@@ -133,7 +133,7 @@ void *thread_tb(void *arg)
 	return NULL;
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	pthread_mutexattr_t mutex_attr;
 	pthread_attr_t threadattr;
diff --git a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
index 1789a61..46b36f7 100644
--- a/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
+++ b/testcases/open_posix_testsuite/functional/threads/pi_test/pitest-6.c
@@ -81,7 +81,7 @@ void *thread_tb(void *arg)
 	return NULL;
 }
 
-int main(int argc, char **argv)
+int main(void)
 {
 	cpus = sysconf(_SC_NPROCESSORS_ONLN);
 	pthread_mutexattr_t mutex_attr;
-- 
1.7.1

