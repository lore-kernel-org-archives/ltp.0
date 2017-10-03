From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:20:12 +0200
Subject: [LTP] [COMMITTED] [PATCH 39/40] syscalls/open08: Make use of
	SAFE_SETGID()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-39-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Coccinelle haven't caught this one because of the else branch.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/open/open08.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open08.c b/testcases/kernel/syscalls/open/open08.c
index 742771eef..6d1f37de0 100644
--- a/testcases/kernel/syscalls/open/open08.c
+++ b/testcases/kernel/syscalls/open/open08.c
@@ -141,10 +141,8 @@ static void setup(void)
 
 	/* Switch to nobody user for correct error code collection */
 	ltpuser = getpwnam(nobody_uid);
-	if (setgid(ltpuser->pw_gid) == -1) {
-		tst_brkm(TBROK | TERRNO, NULL, "setgid(%d) failed",
-			 ltpuser->pw_gid);
-	} else SAFE_SETUID(NULL, ltpuser->pw_uid);
+	SAFE_SETGID(NULL, ltpuser->pw_gid);
+	SAFE_SETUID(NULL, ltpuser->pw_uid);
 
 	tst_tmpdir();
 
-- 
2.13.5

