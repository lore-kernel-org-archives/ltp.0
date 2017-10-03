From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:59 +0200
Subject: [LTP] [COMMITTED] [PATCH 26/40] Make use of SAFE_CLOSEDIR()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-26-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
index e165f6c9a..ad291a1eb 100644
--- a/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
+++ b/testcases/kernel/controllers/cgroup_xattr/cgroup_xattr.c
@@ -226,8 +226,7 @@ static void cleanup(void)
 
 	int i;
 	for (i = 0; i < odir_num; ++i) {
-		if (closedir(odir[i]) == -1)
-			tst_brkm(TBROK, NULL, "Failed to close dir\n");
+		SAFE_CLOSEDIR(NULL, odir[i]);
 	}
 
 	char *cwd = tst_get_tmpdir();
-- 
2.13.5

