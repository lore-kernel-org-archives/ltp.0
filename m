From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 14 Mar 2018 11:40:59 +0100
Subject: [LTP] [PATCH] lib: fix length check in safe_sendmsg
Message-ID: <20180314104059.28051-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It appears that we only check the len parameter against the return value if
the len parameter is zero.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 lib/safe_net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/safe_net.c b/lib/safe_net.c
index 9ea9d2b42..96216ee69 100644
--- a/lib/safe_net.c
+++ b/lib/safe_net.c
@@ -200,7 +200,7 @@ ssize_t safe_sendmsg(const char *file, const int lineno, size_t len,
 			 file, lineno, sockfd, msg, flags);
 	}
 
-	if (!len && (size_t)rval != len) {
+	if (len && (size_t)rval != len) {
 		tst_brkm(TBROK, NULL,
 			 "%s:%d: sendmsg(%d, %p, %d) ret(%zd) != len(%zu)",
 			 file, lineno, sockfd, msg, flags, rval, len);
-- 
2.16.2

