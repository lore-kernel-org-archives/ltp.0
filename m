From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:49 +0200
Subject: [LTP] [COMMITTED] [PATCH 16/40] Make use of SAFE_FCHMOD()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-16-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/chown/chown03.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/chown/chown03.c b/testcases/kernel/syscalls/chown/chown03.c
index 0ca1428b2..b88b6699a 100644
--- a/testcases/kernel/syscalls/chown/chown03.c
+++ b/testcases/kernel/syscalls/chown/chown03.c
@@ -184,8 +184,7 @@ void setup(void)
 	if (fchown(fd, -1, 0) < 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "fchown failed");
 
-	if (fchmod(fd, NEW_PERMS) < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "fchmod failed");
+	SAFE_FCHMOD(cleanup, fd, NEW_PERMS);
 
 	SAFE_SETEUID(cleanup, ltpuser->pw_uid);
 
-- 
2.13.5

