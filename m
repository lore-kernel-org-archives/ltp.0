From: Kory Maincent <kory.maincent@bootlin.com>
Date: Wed, 16 Dec 2020 10:40:37 +0100
Subject: [LTP] [PATCH] ipsec_lib.sh: test xfrm_user driver locally before
 rhost
Message-ID: <20201216094037.5886-1-kory.maincent@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

First, test the presence of the driver locally to avoid a misleading TWARN from
tst_net_run in case of driver not present.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 testcases/network/stress/ipsec/ipsec_lib.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index 198c9315d..1db5fc6af 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -83,8 +83,9 @@ ipsec_lib_setup()
 	ALGR=
 
 	if [ -n "$IPSEC_MODE" ]; then
-		tst_net_run "tst_check_drivers xfrm_user" || \
-			tst_brk TCONF "xfrm_user driver not available on lhost or rhost"
+		tst_check_drivers xfrm_user || tst_brk TCONF "xfrm_user driver not available"
+		tst_rhost_run -c "tst_check_drivers xfrm_user" || \
+			tst_brk TCONF "xfrm_user driver not available on rhost"
 		cleanup_xfrm=1
 	fi
 }
-- 
2.17.1

