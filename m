From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 13 Nov 2020 11:44:30 +0100
Subject: [LTP] [PATCH v2 6/7] Unify error handling in lib/tst_fs_setup.c
In-Reply-To: <20201113104431.17808-1-mdoucha@suse.cz>
References: <20201113104431.17808-1-mdoucha@suse.cz>
Message-ID: <20201113104431.17808-6-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

- Properly format caller file:line location

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- Replaced the last remaining tst_brk() with tst_brk_()

 lib/tst_fs_setup.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/lib/tst_fs_setup.c b/lib/tst_fs_setup.c
index 54ea37077..6b93483de 100644
--- a/lib/tst_fs_setup.c
+++ b/lib/tst_fs_setup.c
@@ -36,14 +36,15 @@ int mount_overlay(const char *file, const int lineno, int skip)
 
 	if (errno == ENODEV) {
 		if (skip) {
-			tst_brk(TCONF, "%s:%d: " TST_FS_SETUP_OVERLAYFS_MSG,
-				file, lineno);
+			tst_brk_(file, lineno, TCONF,
+				TST_FS_SETUP_OVERLAYFS_MSG);
 		} else {
-			tst_res(TINFO, "%s:%d: " TST_FS_SETUP_OVERLAYFS_MSG,
-				file, lineno);
+			tst_res_(file, lineno, TINFO,
+				TST_FS_SETUP_OVERLAYFS_MSG);
 		}
 	} else {
-		tst_brk(TBROK | TERRNO, "overlayfs mount failed");
+		tst_brk_(file, lineno, TBROK | TERRNO,
+			"overlayfs mount failed");
 	}
 	return ret;
 }
-- 
2.28.0

