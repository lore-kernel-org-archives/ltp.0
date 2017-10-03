From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 17:40:53 +0200
Subject: [LTP] [COMMITTED] [PATCH 06/13] Make use of SAFE_LINK()
In-Reply-To: <20171003154100.807-1-chrubis@suse.cz>
References: <20171003154100.807-1-chrubis@suse.cz>
Message-ID: <20171003154100.807-6-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/open/open11.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open11.c b/testcases/kernel/syscalls/open/open11.c
index 6fa21b0bd..b8cf7eb14 100644
--- a/testcases/kernel/syscalls/open/open11.c
+++ b/testcases/kernel/syscalls/open/open11.c
@@ -384,10 +384,7 @@ static void setup(void)
 	fd = SAFE_CREAT(cleanup, T_REG_EMPTY, 0644);
 	close(fd);
 
-	ret = link(T_REG, T_LINK_REG);
-	if (ret == -1)
-		tst_brkm(TBROK | TERRNO, cleanup, "Hard link %s -> %s failed",
-			 T_REG, T_LINK_REG);
+	ret = SAFE_LINK(cleanup, T_REG, T_LINK_REG);
 
 	ret = symlink(T_REG, T_SYMLINK_REG);
 	if (ret == -1)
-- 
2.13.5

