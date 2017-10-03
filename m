From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 17:40:54 +0200
Subject: [LTP] [COMMITTED] [PATCH 07/13] Make use of SAFE_SYMLINK()
In-Reply-To: <20171003154100.807-1-chrubis@suse.cz>
References: <20171003154100.807-1-chrubis@suse.cz>
Message-ID: <20171003154100.807-7-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/open/open11.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open11.c b/testcases/kernel/syscalls/open/open11.c
index b8cf7eb14..e56ef8203 100644
--- a/testcases/kernel/syscalls/open/open11.c
+++ b/testcases/kernel/syscalls/open/open11.c
@@ -386,17 +386,11 @@ static void setup(void)
 
 	ret = SAFE_LINK(cleanup, T_REG, T_LINK_REG);
 
-	ret = symlink(T_REG, T_SYMLINK_REG);
-	if (ret == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Symlink %s -> %s failed",
-			 T_REG, T_SYMLINK_REG);
+	ret = SAFE_SYMLINK(cleanup, T_REG, T_SYMLINK_REG);
 
 	ret = SAFE_MKDIR(cleanup, T_DIR, 0755);
 
-	ret = symlink(T_DIR, T_SYMLINK_DIR);
-	if (ret == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Symlink %s -> %s failed",
-			 T_DIR, T_SYMLINK_DIR);
+	ret = SAFE_SYMLINK(cleanup, T_DIR, T_SYMLINK_DIR);
 
 	ret = mknod(T_DEV, S_IFCHR, makedev(1, 5));
 	if (ret == -1)
-- 
2.13.5

