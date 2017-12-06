From: Jan Stancek <jstancek@redhat.com>
Date: Wed,  6 Dec 2017 15:05:01 +0100
Subject: [LTP] [PATCH v2 1/2] open_posix: add SAFE_FUNC macro
Message-ID: <a79545c7338fa1e9df27b43dd37d5538360f20c5.1512568550.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Similar macro to SAFE_PFUNC, but instead checks for ret value == -1,
and prints error from 'errno'.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/open_posix_testsuite/include/safe_helpers.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

Changes in v2:
- turn it into statement expression, so that we can use return value
  For example in 2/2 patch: ret = SAFE_FUNC(fork());

diff --git a/testcases/open_posix_testsuite/include/safe_helpers.h b/testcases/open_posix_testsuite/include/safe_helpers.h
index 7f945a0280c2..966cb9221a3d 100644
--- a/testcases/open_posix_testsuite/include/safe_helpers.h
+++ b/testcases/open_posix_testsuite/include/safe_helpers.h
@@ -30,4 +30,16 @@ do {\
 	} \
 } while (0)
 
+#define SAFE_FUNC(op) \
+({ \
+	int ret = (op); \
+	if (ret == -1) { \
+		printf("Test %s unresolved: got %i (%s) on line %i\n  %s\n", \
+			__FILE__, ret, strerror(errno), __LINE__, #op); \
+		fflush(stdout); \
+		exit(PTS_UNRESOLVED); \
+	} \
+	ret; \
+})
+
 #endif
-- 
1.8.3.1

