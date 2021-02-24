From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 24 Feb 2021 17:50:41 +0100
Subject: [LTP] [PATCH v2 1/5] lib: tst_cmd: Make tst_cmd() usable for global
 paths
In-Reply-To: <20210224165045.17738-1-chrubis@suse.cz>
References: <20210224165045.17738-1-chrubis@suse.cz>
Message-ID: <20210224165045.17738-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We need to skip the check if the path to the binary starts with '/'.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_cmd.c b/lib/tst_cmd.c
index 7446249f9..b73978e20 100644
--- a/lib/tst_cmd.c
+++ b/lib/tst_cmd.c
@@ -58,7 +58,7 @@ int tst_cmd_fds_(void (cleanup_fn)(void),
 
 	char path[PATH_MAX];
 
-	if (tst_get_path(argv[0], path, sizeof(path))) {
+	if (argv[0][0] != '/' && tst_get_path(argv[0], path, sizeof(path))) {
 		if (flags & TST_CMD_TCONF_ON_MISSING)
 			tst_brkm(TCONF, cleanup_fn, "Couldn't find '%s' in $PATH at %s:%d", argv[0],
 				 __FILE__, __LINE__);
-- 
2.26.2

