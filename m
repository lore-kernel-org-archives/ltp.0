From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 30 Nov 2018 21:37:53 +0100
Subject: [LTP] [PATCH v5 3/3] network/mpls: Use tst_net_run()
In-Reply-To: <20181130203753.19765-1-pvorel@suse.cz>
References: <20181130203753.19765-1-pvorel@suse.cz>
Message-ID: <20181130203753.19765-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New commit.
---
 testcases/network/mpls/mpls_lib.sh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/testcases/network/mpls/mpls_lib.sh b/testcases/network/mpls/mpls_lib.sh
index 43ec16a6e..c64b46c9d 100755
--- a/testcases/network/mpls/mpls_lib.sh
+++ b/testcases/network/mpls/mpls_lib.sh
@@ -37,8 +37,7 @@ mpls_setup()
 {
 	local label="$1"
 
-	ROD modprobe -a $TST_NEEDS_DRIVERS
-	tst_rhost_run -s -c "modprobe -a $TST_NEEDS_DRIVERS"
+	tst_net_run -s "modprobe -a $TST_NEEDS_DRIVERS"
 
 	ROD sysctl -q net.mpls.conf.$(tst_iface).input=1
 	tst_set_sysctl net.mpls.conf.lo.input 1 safe
-- 
2.19.1

