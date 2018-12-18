From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 18 Dec 2018 02:02:17 +0100
Subject: [LTP] [PATCH v3 3/6] net/dhcp: Use for allowed by AppArmor and
	SELinux
In-Reply-To: <20181218010220.2446-1-pvorel@suse.cz>
References: <20181218010220.2446-1-pvorel@suse.cz>
Message-ID: <20181218010220.2446-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

TL;DR: fix paths for --log-facility and --dhcp-leasefile.

Path for log file expects AppArmor commit
7dce58987 ("dnsmasq: Adjust pattern for log files to comply SELinux")
Path is also suitable for SELinux.

dnsmasq uses /var/lib/misc/dnsmasq.leases path for lease file [1].
Fedora/RHEL/CentOS/Oracle Linux (RHEL*) use specific directory
/var/lib/dnsmasq/ [2] (since 2.41 [3]). /var/lib/misc/ also exists on
RHEL* in filesystem package (which is on every RHEL* system).

AppArmor allows us to use different log file in the directory /var/lib/misc/.
This path is not allowed by SELinux, which until now uses RHEL* default
path /var/lib/misc/, so use it when SELinux enabled.

Used directory is created in case it does not exist (and deleted
afterwards).

[1] http://thekelleys.org.uk/gitweb/?p=dnsmasq.git;a=blob;f=src/config.h;h=762c49b586bb26fb05d0eceac87d28f939693a6f;hb=HEAD#l191
[2] https://src.fedoraproject.org/cgit/rpms/dnsmasq.git/tree/dnsmasq.spec#n67
[3] https://src.fedoraproject.org/cgit/rpms/dnsmasq.git/commit/?id=91d4b30e7b55bbb561547312e83ce4d709e505e2

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/dhcp/dhcp_lib.sh      |  8 ++++++++
 testcases/network/dhcp/dhcpd_tests.sh   | 14 ++++++++++++--
 testcases/network/dhcp/dnsmasq_tests.sh | 14 ++++++++++----
 3 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/testcases/network/dhcp/dhcp_lib.sh b/testcases/network/dhcp/dhcp_lib.sh
index 08838a479..b8611f49d 100755
--- a/testcases/network/dhcp/dhcp_lib.sh
+++ b/testcases/network/dhcp/dhcp_lib.sh
@@ -67,12 +67,20 @@ dhcp_lib_setup()
 	tst_res TINFO "add $ip_addr to $iface0"
 	ip addr add $ip_addr dev $iface0 || \
 		tst_brk TBROK "failed to add ip address"
+
+	if [ ! -d "$lease_dir" ]; then
+		mkdir -p $lease_dir
+		lease_dir_added=1
+	fi
 }
 
 dhcp_lib_cleanup()
 {
 	[ -z "$veth_loaded" ] && return
 
+	[ "$lease_dir_added" = 1 ] && rm -rf $lease_dir
+	rm -f $lease_file
+
 	stop_dhcp
 
 	pkill -f "dhclient -$TST_IPVER $iface1"
diff --git a/testcases/network/dhcp/dhcpd_tests.sh b/testcases/network/dhcp/dhcpd_tests.sh
index ff46b825d..5d695bf24 100755
--- a/testcases/network/dhcp/dhcpd_tests.sh
+++ b/testcases/network/dhcp/dhcpd_tests.sh
@@ -10,6 +10,15 @@
 dhcp_name="dhcpd"
 
 . dhcp_lib.sh
+TST_SETUP="setup_dhcp"
+lease_dir="/var/lib/misc"
+lease_file="$lease_dir/dhcpd.leases_tst"
+
+setup_dhcp()
+{
+	[ "$TST_IPV6" ] && lease="$lease_dir/dhcpd6.leases_tst"
+	dhcp_lib_setup
+}
 
 setup_dhcpd_conf()
 {
@@ -30,8 +39,8 @@ setup_dhcpd_conf()
 
 start_dhcpd()
 {
-	touch tst_hdcpd.lease
-	dhcpd -lf tst_hdcpd.lease -$TST_IPVER $iface0 > tst_dhcpd.err 2>&1
+	touch $lease_file
+	dhcpd -lf $lease_file -$TST_IPVER $iface0 > tst_dhcpd.err 2>&1
 }
 
 start_dhcp()
@@ -67,6 +76,7 @@ start_dhcp6()
 cleanup_dhcp()
 {
 	[ -f dhcpd.conf ] && mv dhcpd.conf $DHCPD_CONF
+	rm -f $lease_file
 }
 
 print_dhcp_log()
diff --git a/testcases/network/dhcp/dnsmasq_tests.sh b/testcases/network/dhcp/dnsmasq_tests.sh
index ad5885c84..8e466dafe 100755
--- a/testcases/network/dhcp/dnsmasq_tests.sh
+++ b/testcases/network/dhcp/dnsmasq_tests.sh
@@ -9,9 +9,15 @@ dhcp_name="dnsmasq"
 
 . dhcp_lib.sh
 
+log="/var/log/dnsmasq.tst.log"
+
+lease_dir="/var/lib/misc"
+tst_selinux_enabled && lease_dir="/var/lib/dnsmasq"
+lease_file="$lease_dir/dnsmasq.tst.leases"
+
 common_opt="--no-hosts --no-resolv --dhcp-authoritative \
-	--log-facility=./tst_dnsmasq.log --interface=$iface0 \
-	--dhcp-leasefile=tst_dnsmasq.lease --port=0 --conf-file= "
+	--log-facility=$log --interface=$iface0 \
+	--dhcp-leasefile=$lease_file --port=0 --conf-file= "
 
 start_dhcp()
 {
@@ -33,12 +39,12 @@ start_dhcp6()
 
 cleanup_dhcp()
 {
-	rm -f tst_dnsmasq.log
+	rm -f $log
 }
 
 print_dhcp_log()
 {
-	cat tst_dnsmasq.log
+	cat $log
 }
 
 print_dhcp_version()
-- 
2.19.2

