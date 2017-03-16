From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 16 Mar 2017 18:01:34 +0100
Subject: [LTP] [PATCH 1/1] gitignore: Cleanup
Message-ID: <20170316170134.27191-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tools/gethost.c was moved in 743f2fcd5 ("move gethost from tools to
sendfile01")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 tools/.gitignore | 1 -
 1 file changed, 1 deletion(-)
 delete mode 100644 tools/.gitignore

diff --git a/tools/.gitignore b/tools/.gitignore
deleted file mode 100644
index 68fed60a4..000000000
--- a/tools/.gitignore
+++ /dev/null
@@ -1 +0,0 @@
-/gethost
-- 
2.12.0

