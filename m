From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  9 Jan 2020 15:26:45 +0100
Subject: [LTP] [PATCH] [COMMITTED] syscalls/quotactl06: Missing binary is
 not TBROK
Message-ID: <20200109142645.29728-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It should always result in TCONF.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/quotactl/quotactl06.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/quotactl/quotactl06.c b/testcases/kernel/syscalls/quotactl/quotactl06.c
index 446831ba8..a3b4517e0 100644
--- a/testcases/kernel/syscalls/quotactl/quotactl06.c
+++ b/testcases/kernel/syscalls/quotactl/quotactl06.c
@@ -154,7 +154,7 @@ static void setup(void)
 	case 0:
 		break;
 	case 255:
-		tst_brk(TBROK, "quotacheck binary not installed");
+		tst_brk(TCONF, "quotacheck binary not installed");
 		break;
 	default:
 		tst_brk(TBROK, "quotacheck exited with %i", ret);
-- 
2.23.0

