From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 13 Mar 2018 16:01:11 +0100
Subject: [LTP] [PATCH v2 3/3] tst_netload: Exit with TCONF when netstress
	exit with CONF
In-Reply-To: <20180313150111.16501-1-pvorel@suse.cz>
References: <20180313150111.16501-1-pvorel@suse.cz>
Message-ID: <20180313150111.16501-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

as some issues are configuration issues.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Alexey, I kept grepping as in v1, see:
http://lists.linux.it/pipermail/ltp/2018-March/007240.html
---
 testcases/lib/test_net.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 0e78dfd8b..203464f0d 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -459,7 +459,9 @@ tst_netload()
 	tst_rhost_run -c "netstress $s_opts" > tst_netload.log 2>&1
 	if [ $? -ne 0 ]; then
 		cat tst_netload.log
-		tst_brkm TFAIL "server failed"
+		local ttype="TFAIL"
+		grep -e 'CONF:' tst_netload.log && ttype="TCONF"
+		tst_brkm $ttype "server failed"
 	fi
 
 	local port=$(tst_rhost_run -s -c "cat $TST_TMPDIR/netstress_port")
-- 
2.16.2

