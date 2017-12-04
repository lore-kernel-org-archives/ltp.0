From: Jan Stancek <jstancek@redhat.com>
Date: Mon,  4 Dec 2017 16:10:54 +0100
Subject: [LTP] [PATCH 1/2] open_posix: add SAFE_FUNC macro
Message-ID: <8075a8711d2f1a9e5449cd317f78ad5d312b9bca.1512397856.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Similar macro to SAFE_PFUNC, but instead checks for ret value == -1,
and prints error from 'errno'.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/open_posix_testsuite/include/safe_helpers.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/testcases/open_posix_testsuite/include/safe_helpers.h b/testcases/open_posix_testsuite/include/safe_helpers.h
index 7f945a0280c2..4537fba12263 100644
--- a/testcases/open_posix_testsuite/include/safe_helpers.h
+++ b/testcases/open_posix_testsuite/include/safe_helpers.h
@@ -30,4 +30,15 @@ do {\
 	} \
 } while (0)
 
+#define SAFE_FUNC(op) \
+do {\
+	int ret = (op); \
+	if (ret == -1) { \
+		printf("Test %s unresolved: got %i (%s) on line %i\n  %s\n", \
+			__FILE__, ret, strerror(errno), __LINE__, #op); \
+		fflush(stdout); \
+		exit(PTS_UNRESOLVED); \
+	} \
+} while (0)
+
 #endif
-- 
1.8.3.1

