From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 25 Oct 2017 19:11:56 +0300
Subject: [LTP] [PATCH 1/4] tst_safe_net: add new wrapper for safe_setsockopt
Message-ID: <1508947919-3553-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 include/tst_safe_net.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/include/tst_safe_net.h b/include/tst_safe_net.h
index 1fdd5de..104184d 100644
--- a/include/tst_safe_net.h
+++ b/include/tst_safe_net.h
@@ -32,6 +32,12 @@
 #define SAFE_SETSOCKOPT(fd, level, optname, optval, optlen) \
 	safe_setsockopt(__FILE__, __LINE__, fd, level, optname, optval, optlen)
 
+#define SAFE_SETSOCKOPT_INT(fd, l, n, val) \
+	do { \
+		int v = val; \
+		safe_setsockopt(__FILE__, __LINE__, fd, l, n, &v, sizeof(v)); \
+	} while (0)
+
 #define SAFE_SEND(strict, sockfd, buf, len, flags) \
 	safe_send(__FILE__, __LINE__, strict, sockfd, buf, len, flags)
 
-- 
1.7.1

