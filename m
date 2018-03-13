From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Mar 2018 16:01:09 +0100
Subject: [LTP] [PATCH v2 1/3] netstress: TCONF if modprobe dccp fails
Message-ID: <20180313150111.16501-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

commit 22d43a959 ("netstress: load dccp module manually") added
functionality to trying to load dccp module. It's actually better to
exit with TCONF as unsuccessful modprobe means that dccp module is
missing.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
LianWen, hope TCONF is ok for you:
http://lists.linux.it/pipermail/ltp/2018-February/007200.html
---
 testcases/network/netstress/netstress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
index 4754bacf6..369a5eeb8 100644
--- a/testcases/network/netstress/netstress.c
+++ b/testcases/network/netstress/netstress.c
@@ -941,7 +941,7 @@ static void setup(void)
 		static const char * const argv[] = {"modprobe", "dccp", NULL};
 
 		if (tst_run_cmd(argv, NULL, NULL, 1))
-			tst_res(TWARN, "Failed to load DCCP module");
+			tst_brk(TCONF, "Failed to load DCCP module");
 
 		tst_res(TINFO, "DCCP %s", (client_mode) ? "client" : "server");
 		fastopen_api = fastopen_sapi = NULL;
-- 
2.16.2

