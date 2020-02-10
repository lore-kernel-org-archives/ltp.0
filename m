From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 10 Feb 2020 13:40:43 +0100
Subject: [LTP] [PATCH v2 2/3] safe_macros: Use tst_umount() in safe_umount()
In-Reply-To: <20200210124043.14425-1-pvorel@suse.cz>
References: <20200210124043.14425-1-pvorel@suse.cz>
Message-ID: <20200210124043.14425-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To get retry workaround for gvfsd-trash background daemon.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 lib/safe_macros.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 41fa4ca83..deb19d2df 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -772,7 +772,7 @@ int safe_umount(const char *file, const int lineno, void (*cleanup_fn)(void),
 {
 	int rval;
 
-	rval = umount(target);
+	rval = tst_umount(target);
 
 	if (rval == -1) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-- 
2.24.1

