From: Li Wang <liwang@redhat.com>
Date: Tue,  7 Sep 2021 10:52:58 +0800
Subject: [LTP] [PATCH] openposix: make use of tst_process_state_wait3
Message-ID: <20210907025258.3294914-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Replaces that sleep 1 sec with a wait until child process state
changes to 'S' (sleeping).

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../conformance/interfaces/clock_nanosleep/1-3.c               | 3 ++-
 .../conformance/interfaces/clock_nanosleep/1-4.c               | 3 ++-
 .../conformance/interfaces/clock_nanosleep/1-5.c               | 3 ++-
 .../conformance/interfaces/clock_nanosleep/10-1.c              | 3 ++-
 .../conformance/interfaces/clock_nanosleep/2-2.c               | 3 ++-
 .../conformance/interfaces/clock_nanosleep/2-3.c               | 3 ++-
 .../conformance/interfaces/clock_nanosleep/9-1.c               | 3 ++-
 7 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-3.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-3.c
index 98de93a9e..e2fdc4c37 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-3.c
@@ -22,6 +22,7 @@
 #include <unistd.h>
 #include <sys/wait.h>
 #include "posixtest.h"
+#include "proc.h"
 
 #define SLEEPSEC 30
 
@@ -63,7 +64,7 @@ int main(void)
 		/* parent here */
 		int i;
 
-		sleep(1);
+		tst_process_state_wait3(pid, 'S', 1);
 
 		if (kill(pid, SIGABRT) != 0) {
 			printf("Could not raise signal being tested\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-4.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-4.c
index 9808c5c4f..ca3d0798f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-4.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-4.c
@@ -14,6 +14,7 @@
 #include <unistd.h>
 #include <sys/wait.h>
 #include "posixtest.h"
+#include "proc.h"
 
 #define SLEEPSEC 30
 
@@ -36,7 +37,7 @@ int main(void)
 		/* parent here */
 		int i;
 
-		sleep(1);
+		tst_process_state_wait3(pid, 'S', 1);
 
 		if (kill(pid, SIGABRT) != 0) {
 			printf("Could not raise signal being tested\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-5.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-5.c
index 46f26163d..263d98a08 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-5.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-5.c
@@ -18,6 +18,7 @@
 #include <sys/wait.h>
 #include <stdlib.h>
 #include "posixtest.h"
+#include "proc.h"
 
 #define SLEEPSEC 5
 
@@ -52,7 +53,7 @@ int main(void)
 		/* parent here */
 		int i;
 
-		sleep(1);
+		tst_process_state_wait3(pid, 'S', 1);
 
 		if (kill(pid, SIGSTOP) != 0) {
 			printf("Could not raise SIGSTOP\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/10-1.c
index f6adcc938..9fae578b4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/10-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/10-1.c
@@ -15,6 +15,7 @@
 #include <sys/wait.h>
 #include <errno.h>
 #include "posixtest.h"
+#include "proc.h"
 
 #define SLEEPSEC 30
 
@@ -59,7 +60,7 @@ int main(void)
 		/* parent here */
 		int i;
 
-		sleep(1);
+		tst_process_state_wait3(pid, 'S', 1);
 
 		if (kill(pid, SIGABRT) != 0) {
 			printf("Could not raise signal being tested\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/2-2.c
index 330618877..8cafb3bf0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/2-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/2-2.c
@@ -23,6 +23,7 @@
 #include <unistd.h>
 #include <sys/wait.h>
 #include "posixtest.h"
+#include "proc.h"
 
 #define SLEEPSEC 30
 
@@ -71,7 +72,7 @@ int main(void)
 		/* parent here */
 		int i;
 
-		sleep(1);
+		tst_process_state_wait3(pid, 'S', 1);
 
 		if (kill(pid, SIGABRT) != 0) {
 			printf("Could not raise signal being tested\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/2-3.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/2-3.c
index 06a79a96d..3938f44b7 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/2-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/2-3.c
@@ -16,6 +16,7 @@
 #include <unistd.h>
 #include <sys/wait.h>
 #include "posixtest.h"
+#include "proc.h"
 
 #define SLEEPSEC 30
 
@@ -45,7 +46,7 @@ int main(void)
 		/* parent here */
 		int i;
 
-		sleep(1);
+		tst_process_state_wait3(pid, 'S', 1);
 
 		if (kill(pid, SIGABRT) != 0) {
 			printf("Could not raise signal being tested\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c
index 04ef0a2cc..554714695 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c
@@ -17,6 +17,7 @@
 #include <stdlib.h>
 #include <errno.h>
 #include "posixtest.h"
+#include "proc.h"
 
 #define SLEEPSEC 30
 
@@ -88,7 +89,7 @@ int main(void)
 		/* parent here */
 		int i;
 
-		sleep(1);
+		tst_process_state_wait3(pid, 'S', 1);
 
 		if (kill(pid, SIGABRT) != 0) {
 			printf("Could not raise signal being tested\n");
-- 
2.31.1

