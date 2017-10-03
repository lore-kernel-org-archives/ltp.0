From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 17:40:50 +0200
Subject: [LTP] [COMMITTED] [PATCH 03/13] Make use of SAFE_MKDIR()
In-Reply-To: <20171003154100.807-1-chrubis@suse.cz>
References: <20171003154100.807-1-chrubis@suse.cz>
Message-ID: <20171003154100.807-3-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/open/open11.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open11.c b/testcases/kernel/syscalls/open/open11.c
index c9239c6b4..9593671f2 100644
--- a/testcases/kernel/syscalls/open/open11.c
+++ b/testcases/kernel/syscalls/open/open11.c
@@ -396,9 +396,7 @@ static void setup(void)
 		tst_brkm(TBROK | TERRNO, cleanup, "Symlink %s -> %s failed",
 			 T_REG, T_SYMLINK_REG);
 
-	ret = mkdir(T_DIR, 0755);
-	if (ret == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "mkdir %s failed", T_DIR);
+	ret = SAFE_MKDIR(cleanup, T_DIR, 0755);
 
 	ret = symlink(T_DIR, T_SYMLINK_DIR);
 	if (ret == -1)
-- 
2.13.5

