From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  1 Jun 2018 13:49:54 +0200
Subject: [LTP] [PATCH 5/7] net/http: Replace $ipver by $TST_IPVER from
	tst_net.sh
In-Reply-To: <20180601114956.17265-1-pvorel@suse.cz>
References: <20180601114956.17265-1-pvorel@suse.cz>
Message-ID: <20180601114956.17265-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/http/http-stress | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/network/stress/http/http-stress b/testcases/network/stress/http/http-stress
index 211cd90aa..ff617a212 100644
--- a/testcases/network/stress/http/http-stress
+++ b/testcases/network/stress/http/http-stress
@@ -35,8 +35,7 @@ setup()
 {
 	tst_require_root
 
-	ipver=${TST_IPV6:-'4'}
-	tst_resm TINFO "run over IPv$ipver"
+	tst_resm TINFO "run over IPv$TST_IPVER"
 
 	trap "tst_brkm TBROK 'test interrupted'" INT
 
-- 
2.16.3

