From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 21 Mar 2018 15:39:25 +0100
Subject: [LTP] [PATCH v2 1/3] lib: Check received message was not truncated
In-Reply-To: <20180321143927.12156-1-rpalethorpe@suse.com>
References: <20180321143927.12156-1-rpalethorpe@suse.com>
Message-ID: <20180321143927.12156-2-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/safe_net.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/safe_net.c b/lib/safe_net.c
index 64e2cbcf6..ba38fc08e 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -240,8 +240,19 @@ ssize_t safe_recvmsg(const char *file, const int lineno, size_t len,
 			 file, lineno, sockfd, msg, flags, rval, len);
 	}
 
-	return rval;
+	if (msg->msg_flags & MSG_TRUNC) {
+		tst_brkm(TBROK, NULL,
+			 "%s:%d: recvmsg(%d, %p, %d): buffer is too small",
+			 file, lineno, sockfd, msg, flags);
+	}
 
+	if (msg->msg_flags & MSG_CTRUNC) {
+		tst_brkm(TBROK, NULL,
+			 "%s:%d: recvmsg(%d, %p, %d): control buffer is too small",
+			 file, lineno, sockfd, msg, flags);
+	}
+
+	return rval;
 }
 
 int safe_bind(const char *file, const int lineno, void (cleanup_fn)(void),
-- 
2.16.2

