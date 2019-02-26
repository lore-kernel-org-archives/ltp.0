From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Feb 2019 16:45:54 +0100
Subject: [LTP] [PATCH] [COMMITTED] syscalls/fanotify12: Fix typo.
Message-ID: <20190226154554.8627-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

TST_TEST_CONF -> TST_TEST_TCONF.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fanotify/fanotify12.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
index e2ae3576a..fcb7ec0d3 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify12.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
@@ -278,5 +278,5 @@ static struct tst_test test = {
 	.resource_files = resource_files
 };
 #else
-	TST_TEST_CONF("System does not contain required fanotify support");
+	TST_TEST_TCONF("System does not contain required fanotify support");
 #endif
-- 
2.19.2

