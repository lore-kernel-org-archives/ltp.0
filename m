From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  4 May 2021 14:50:46 +0200
Subject: [LTP] [PATCH 1/1] dhcp: TCONF for wicked on IPv6
Message-ID: <20210504125046.12621-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

wicked requires proper radvd setup. which is beyond DHCP tests.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/dhcp/dhcp_lib.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/testcases/network/dhcp/dhcp_lib.sh b/testcases/network/dhcp/dhcp_lib.sh
index 634d6ab43..730bdad87 100755
--- a/testcases/network/dhcp/dhcp_lib.sh
+++ b/testcases/network/dhcp/dhcp_lib.sh
@@ -37,6 +37,12 @@ stop_dhcp()
 
 dhcp_lib_setup()
 {
+	if [ $HAVE_SYSTEMCTL -eq 1 ] && \
+		systemctl --no-pager -p Id show network.service | grep -q Id=wicked.service; then
+		[ $TST_IPV6 ] && tst_brk TCONF "wicked not supported on IPv6"
+		is_wicked=1
+	fi
+
 	[ -z "$log" ] && log="$PWD/$(basename $0 '.sh').log"
 
 	if [ $TST_IPV6 ]; then
@@ -129,8 +135,7 @@ test01()
 		tst_brk TBROK "Failed to start $dhcp_name"
 	fi
 
-	if [ $HAVE_SYSTEMCTL -eq 1 ] && \
-		systemctl --no-pager -p Id show network.service | grep -q Id=wicked.service; then
+	if [ "$is_wicked" ]; then
 		tst_res TINFO "wicked is running, don't start dhclient"
 		if [ ! -f "$wicked_cfg" ]; then
 			cat <<EOF > $wicked_cfg
-- 
2.31.1

