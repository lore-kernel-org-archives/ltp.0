From: Petr Vorel <pvorel@suse.cz>
Date: Fri,  7 Dec 2018 13:35:12 +0100
Subject: [LTP] [PATCH v2 2/6] net/dhcp: Use paths allowed by AppArmor for
	dnsmasq
In-Reply-To: <20181207123516.30867-1-pvorel@suse.cz>
References: <20181207123516.30867-1-pvorel@suse.cz>
Message-ID: <20181207123516.30867-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes for --log-facility and --dhcp-leasefile.

Path for log file expects AppArmor commit
025c7dc6 ("dnsmasq: Add permission to open log files").

dnsmasq uses directory for /var/lib/misc/ lease file.
Fedora/RHEL/CentOS/Oracle Linux (RHEL*) use specific directory
/var/lib/dnsmasq/ [1] (since 2.41 [2]). /var/lib/misc/ also exists on
RHEL* in filesystem package (which is on every RHEL* system), but check
in case it isn't.

NOTE: AppArmor optimization isn't needed for dhcpd.

[1] https://src.fedoraproject.org/cgit/rpms/dnsmasq.git/tree/dnsmasq.spec#n67
[2] https://src.fedoraproject.org/cgit/rpms/dnsmasq.git/commit/?id=91d4b30e7b55bbb561547312e83ce4d709e505e2

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes:
removing Lease file (and directory if needed).

Kind regards,
Petr
---
 testcases/network/dhcp/dnsmasq_tests.sh | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/testcases/network/dhcp/dnsmasq_tests.sh b/testcases/network/dhcp/dnsmasq_tests.sh
index ad5885c84..24368fd33 100755
--- a/testcases/network/dhcp/dnsmasq_tests.sh
+++ b/testcases/network/dhcp/dnsmasq_tests.sh
@@ -8,10 +8,25 @@
 dhcp_name="dnsmasq"
 
 . dhcp_lib.sh
+TST_SETUP="setup"
+
+log="/var/log/tst_dnsmasq.log"
+
+lease_dir="/var/lib/misc"
+lease_file="$lease_dir/dnsmasq.tst.leases"
 
 common_opt="--no-hosts --no-resolv --dhcp-authoritative \
-	--log-facility=./tst_dnsmasq.log --interface=$iface0 \
-	--dhcp-leasefile=tst_dnsmasq.lease --port=0 --conf-file= "
+	--log-facility=$log --interface=$iface0 \
+	--dhcp-leasefile=$lease_file --port=0 --conf-file= "
+
+setup()
+{
+	dhcp_lib_setup
+	if [ ! -d "$lease_dir" ]; then
+		mkdir -p $lease_dir
+		remove_lease_dir=1
+	fi
+}
 
 start_dhcp()
 {
@@ -33,12 +48,13 @@ start_dhcp6()
 
 cleanup_dhcp()
 {
-	rm -f tst_dnsmasq.log
+	rm -f $log $lease_file
+	[ "$remove_lease_dir" = 1 ] && rm -r $lease_dir
 }
 
 print_dhcp_log()
 {
-	cat tst_dnsmasq.log
+	cat $log
 }
 
 print_dhcp_version()
-- 
2.19.2

