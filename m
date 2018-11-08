From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  8 Nov 2018 14:58:04 +0100
Subject: [LTP] [RFC PATCH 2/2] net/ipsec: Add check for xfrm_user
In-Reply-To: <20181108135804.32448-1-pvorel@suse.cz>
References: <20181108135804.32448-1-pvorel@suse.cz>
Message-ID: <20181108135804.32448-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

which is required by ip xfrm command.
As ipsec_lib.sh is used for other commands than it,
check it only when used. Call in cleanup function could trigger infinite
loop, therefore check only once.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/ipsec/ipsec_lib.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/testcases/network/stress/ipsec/ipsec_lib.sh b/testcases/network/stress/ipsec/ipsec_lib.sh
index b099fdeaf..a9ac5bc50 100644
--- a/testcases/network/stress/ipsec/ipsec_lib.sh
+++ b/testcases/network/stress/ipsec/ipsec_lib.sh
@@ -89,6 +89,14 @@ TST_SETUP=${TST_SETUP:-ipsec_lib_setup}
 TST_USAGE=ipsec_lib_usage
 . tst_net.sh
 
+tst_ipsec_check_driver()
+{
+	if [ -z "$ipsec_driver_checked" ]; then
+		export ipsec_driver_checked=1
+		tst_net_run "tst_test_drivers xfrm_user"
+	fi
+}
+
 get_key()
 {
 	local bits=$1
@@ -110,6 +118,7 @@ tst_ipsec_setup()
 # tst_ipsec_cleanup: flush ipsec state and policy rules
 tst_ipsec_cleanup()
 {
+	tst_ipsec_check_driver
 	ip xfrm state flush
 	ip xfrm policy flush
 	tst_rhost_run -c "ip xfrm state flush && ip xfrm policy flush"
@@ -175,6 +184,7 @@ tst_ipsec()
 	local p="proto $IPSEC_PROTO"
 	[ "$IPSEC_PROTO" = "esp_aead" ] && p="proto esp"
 
+	tst_ipsec_check_driver
 	ipsec_set_algoline
 
 	if [ $target = lhost ]; then
@@ -234,6 +244,7 @@ tst_ipsec_vti()
 		tst_brk TCONF "iproute doesn't support 'vti'"
 
 	ipsec_set_algoline
+	tst_ipsec_check_driver
 
 	local o_dir="src $src dst $dst"
 	local i_dir="src $dst dst $src"
-- 
2.19.1

