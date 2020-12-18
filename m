From: Kory Maincent <kory.maincent@bootlin.com>
Date: Fri, 18 Dec 2020 15:41:56 +0100
Subject: [LTP] [PATCH v2] ipsec_lib: make tst_net_run "tst_check_driver"
 quiet
Message-ID: <20201218144156.29866-1-kory.maincent@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Make tst_net_run quiet when using tst_check_drivers to avoid wrong TWARN message

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Change since v1:
  Considered Alexey's review
  http://lists.linux.it/pipermail/ltp/2020-December/020285.html

 testcases/network/stress/ipsec/ipsec_lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index 198c9315d..e395e1ff3 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -83,7 +83,7 @@ ipsec_lib_setup()
 	ALGR=
 
 	if [ -n "$IPSEC_MODE" ]; then
-		tst_net_run "tst_check_drivers xfrm_user" || \
+		tst_net_run -q "tst_check_drivers xfrm_user" || \
 			tst_brk TCONF "xfrm_user driver not available on lhost or rhost"
 		cleanup_xfrm=1
 	fi
-- 
2.17.1

