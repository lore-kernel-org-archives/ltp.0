From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Sun, 5 Sep 2021 11:11:13 +0800
Subject: [LTP] [PATCH] open_posix: Add failure handling of fork()
Message-ID: <20210905031113.2740-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

When fork() failed and transfer the return value(-1) to kill(),
kill(-1, SIGSTOP) would freeze the system, so it is very serious
in this cases and should be avoided.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 .../conformance/interfaces/clock_nanosleep/1-5.c               | 3 +++
 .../conformance/interfaces/nanosleep/3-2.c                     | 3 +++
 .../conformance/interfaces/sigaction/10-1.c                    | 3 +++
 .../conformance/interfaces/sigaction/11-1.c                    | 3 +++
 .../conformance/interfaces/sigaction/9-1.c                     | 3 +++
 5 files changed, 15 insertions(+)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-5.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-5.c
index 46f26163d..a87585884 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-5.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/1-5.c
@@ -48,6 +48,9 @@ int main(void)
 			return CHILDFAIL;
 		}
 		return CHILDFAIL;
+	} else if (pid < 0) {
+		printf("fork() did not return success\n");
+		return PTS_UNRESOLVED;
 	} else {
 		/* parent here */
 		int i;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-2.c
index 4016fb4e6..472dd48ba 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-2.c
@@ -45,6 +45,9 @@ int main(void)
 			return CHILDFAIL;
 		}
 		return CHILDFAIL;
+	} else if ( pid < 0) {
+		printf("fork() did not return success\n");
+		return PTS_UNRESOLVED;
 	} else {
 		/* parent here */
 		int i;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/10-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/10-1.c
index 02150a150..2212c98f0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/10-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/10-1.c
@@ -76,6 +76,9 @@ int main(void)
 			select(0, NULL, NULL, NULL, &tv);
 		}
 		return 0;
+	} else if (pid < 0) {
+		printf("fork() did not return success\n");
+		return PTS_UNRESOLVED;
 	} else {
 		/* parent */
 		int s;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/11-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/11-1.c
index 41db84865..a88e969dc 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/11-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/11-1.c
@@ -61,6 +61,9 @@ int main(void)
 			select(0, NULL, NULL, NULL, &tv);
 		}
 		return 0;
+	} else if (pid < 0) {
+		printf("fork() did not return success\n");
+		return PTS_UNRESOLVED;
 	} else {
 		/* parent */
 		int s;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/9-1.c
index 1d45c09c6..70df68332 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/sigaction/9-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/sigaction/9-1.c
@@ -57,6 +57,9 @@ int main(void)
 		   interrupted by a signal */
 		select(0, NULL, NULL, NULL, NULL);
 		return 0;
+	} else if (pid < 0) {
+		printf("fork() did not return success\n");
+		return PTS_UNRESOLVED;
 	} else {
 		/* parent */
 		int s;
--
2.17.1

