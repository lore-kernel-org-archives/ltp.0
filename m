From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 17:41:00 +0200
Subject: [LTP] [COMMITTED] [PATCH 13/13] syscalls/open11: Manual fixup
In-Reply-To: <20171003154100.807-1-chrubis@suse.cz>
References: <20171003154100.807-1-chrubis@suse.cz>
Message-ID: <20171003154100.807-13-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The assigment to ret is not used and could be removed in this case.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/open/open11.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open11.c b/testcases/kernel/syscalls/open/open11.c
index e56ef8203..78002f37d 100644
--- a/testcases/kernel/syscalls/open/open11.c
+++ b/testcases/kernel/syscalls/open/open11.c
@@ -384,13 +384,10 @@ static void setup(void)
 	fd = SAFE_CREAT(cleanup, T_REG_EMPTY, 0644);
 	close(fd);
 
-	ret = SAFE_LINK(cleanup, T_REG, T_LINK_REG);
-
-	ret = SAFE_SYMLINK(cleanup, T_REG, T_SYMLINK_REG);
-
-	ret = SAFE_MKDIR(cleanup, T_DIR, 0755);
-
-	ret = SAFE_SYMLINK(cleanup, T_DIR, T_SYMLINK_DIR);
+	SAFE_LINK(cleanup, T_REG, T_LINK_REG);
+	SAFE_SYMLINK(cleanup, T_REG, T_SYMLINK_REG);
+	SAFE_MKDIR(cleanup, T_DIR, 0755);
+	SAFE_SYMLINK(cleanup, T_DIR, T_SYMLINK_DIR);
 
 	ret = mknod(T_DEV, S_IFCHR, makedev(1, 5));
 	if (ret == -1)
-- 
2.13.5

