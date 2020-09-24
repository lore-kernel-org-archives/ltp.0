From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 24 Sep 2020 16:42:45 +0200
Subject: [LTP] [PATCH 1/2] Fix formatting signal name in tst_strstatus()
Message-ID: <20200924144246.12750-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 lib/tst_status.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/tst_status.c b/lib/tst_status.c
index f1affeac5..9124faaa3 100644
--- a/lib/tst_status.c
+++ b/lib/tst_status.c
@@ -20,7 +20,8 @@ const char *exited(int status)
 
 const char *signaled(int status)
 {
-	snprintf(buf, sizeof(buf), "killed by %s", tst_strsig(status));
+	snprintf(buf, sizeof(buf), "killed by %s",
+		tst_strsig(WTERMSIG(status)));
 
 	return buf;
 }
-- 
2.28.0

