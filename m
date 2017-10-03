From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:40 +0200
Subject: [LTP] [COMMITTED] [PATCH 07/40] Make use of SAFE_SETEGID()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-7-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/chown/chown03.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/chown/chown03.c b/testcases/kernel/syscalls/chown/chown03.c
index 6188315df..4dba6c6f3 100644
--- a/testcases/kernel/syscalls/chown/chown03.c
+++ b/testcases/kernel/syscalls/chown/chown03.c
@@ -170,9 +170,7 @@ void setup(void)
 	ltpuser = getpwnam(nobody_uid);
 	if (ltpuser == NULL)
 		tst_brkm(TBROK | TERRNO, NULL, "getpwnam(\"nobody\") failed");
-	if (setegid(ltpuser->pw_gid) == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "setegid(%d) failed",
-			 ltpuser->pw_gid);
+	SAFE_SETEGID(NULL, ltpuser->pw_gid);
 	if (seteuid(ltpuser->pw_uid) == -1)
 		tst_brkm(TBROK | TERRNO, NULL, "seteuid(%d) failed",
 			 ltpuser->pw_uid);
-- 
2.13.5

