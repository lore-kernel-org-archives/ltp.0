From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue, 29 Nov 2016 13:52:46 +0300
Subject: [LTP] [PATCH v2] network: test_net.sh: allow to run network tests
	on a single machine
Message-ID: <1480416766-13245-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

When 'RHOST' environment variable is not defined, test_net.sh will
setup 'ltp_ns' netns and configure veth pair according to other LTP
network variables. Then, each tst_rhost_run() call will be executed
in the new netns on the same host.

Usage:
./network.sh -i

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
v2: * Made it default configuration if RHOST not set;
    * Changed network/README.md documentation;
    * Removed outdated NFS setup section from the doc.

 testcases/lib/test_net.sh   |   49 ++++++++++++++++++++++++++++++--------
 testcases/network/README.md |   55 ++++++++++++++++++++++--------------------
 2 files changed, 68 insertions(+), 36 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index dc52d95..f5321d7 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -20,6 +20,31 @@
 
 [ -z "$TST_LIB_LOADED" ] && . test.sh
 
+init_ltp_netspace()
+{
+	if [ ! -f /var/run/netns/ltp_ns ]; then
+		ROD ip net add ltp_ns
+		ROD ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2
+		ROD ip li set dev ltp_ns_veth1 netns ltp_ns
+	fi
+
+	LHOST_IFACES=${LHOST_IFACES:-"ltp_ns_veth2"}
+	RHOST_IFACES=${RHOST_IFACES:-"ltp_ns_veth1"}
+
+	export TST_INIT_NETNS="no"
+	export LTP_NETNS=${LTP_NETNS:-"ip netns exec ltp_ns"}
+
+	tst_init_iface
+	tst_init_iface rhost
+
+	tst_add_ipaddr
+	tst_add_ipaddr rhost
+
+	TST_IPV6=6 tst_add_ipaddr
+	TST_IPV6=6 tst_add_ipaddr rhost
+
+}
+
 # Run command on remote host.
 # Options:
 # -b run in background
@@ -67,6 +92,9 @@ tst_rhost_run()
 	if [ -n "$TST_USE_SSH" ]; then
 		output=`ssh -n -q $user@$RHOST "sh -c \
 			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
+	elif [ -n "$TST_USE_NETNS" ]; then
+		output=`$LTP_NETNS sh -c \
+			"$pre_cmd $cmd $post_cmd" $out 2>&1 || echo 'RTERR'`
 	else
 		output=`rsh -n -l $user $RHOST "sh -c \
 			'$pre_cmd $cmd $post_cmd'" $out 2>&1 || echo 'RTERR'`
@@ -346,22 +374,13 @@ tst_ping()
 }
 
 # Management Link
-[ -z "$RHOST" ] && tst_brkm TBROK "RHOST variable not defined"
+[ -z "$RHOST" ] && TST_USE_NETNS="yes"
 export RHOST="$RHOST"
 export PASSWD=${PASSWD:-""}
 # Don't use it in new tests, use tst_rhost_run() from test_net.sh instead.
 export LTP_RSH=${LTP_RSH:-"rsh -n"}
 
 # Test Links
-# Warning: make sure to set valid interface names and IP addresses below.
-# Set names for test interfaces, e.g. "eth0 eth1"
-export LHOST_IFACES=${LHOST_IFACES:-"eth0"}
-export RHOST_IFACES=${RHOST_IFACES:-"eth0"}
-
-# Set corresponding HW addresses, e.g. "00:00:00:00:00:01 00:00:00:00:00:02"
-export LHOST_HWADDRS=${LHOST_HWADDRS:-"$(tst_get_hwaddrs lhost)"}
-export RHOST_HWADDRS=${RHOST_HWADDRS:-"$(tst_get_hwaddrs rhost)"}
-
 # Set first three octets of the network address, default is '10.0.0'
 export IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
 # Set local host last octet, default is '2'
@@ -408,5 +427,15 @@ export UPLOAD_REGFILESIZE=${UPLOAD_REGFILESIZE:-"1024"}
 export MCASTNUM_NORMAL=${MCASTNUM_NORMAL:-"20"}
 export MCASTNUM_HEAVY=${MCASTNUM_HEAVY:-"40000"}
 
+[ -n "$TST_USE_NETNS" -a "$TST_INIT_NETNS" != "no" ] && init_ltp_netspace
+
+# Warning: make sure to set valid interface names and IP addresses below.
+# Set names for test interfaces, e.g. "eth0 eth1"
+export LHOST_IFACES=${LHOST_IFACES:-"eth0"}
+export RHOST_IFACES=${RHOST_IFACES:-"eth0"}
+# Set corresponding HW addresses, e.g. "00:00:00:00:00:01 00:00:00:00:00:02"
+export LHOST_HWADDRS=${LHOST_HWADDRS:-"$(tst_get_hwaddrs lhost)"}
+export RHOST_HWADDRS=${RHOST_HWADDRS:-"$(tst_get_hwaddrs rhost)"}
+
 # More information about network parameters can be found
 # in the following document: testcases/network/stress/README
diff --git a/testcases/network/README.md b/testcases/network/README.md
index 4ddba31..ebaab99 100644
--- a/testcases/network/README.md
+++ b/testcases/network/README.md
@@ -1,17 +1,24 @@
 # LTP Network Tests
 
 ## Pre-requisites
-Enable all the networking services on both client and server machines:
-rshd, nfsd, fingerd.
+Enable all the networking services on test machine(s): rshd, nfsd, fingerd.
 
-## Server Configuration
-* Verify that the below daemon services are running. If not, please install
-and start them:
-rsh-server, telnet-server, finger-server, rdist, rsync, dhcp-server, http-server.
+## Single Host Configuration
 
-Note: If any of the above daemon is not running on server, the test related to
-that service running from client will fail.
+It is a default configuration ('RHOST' is not defined). LTP adds 'ltp_ns'
+network namespace and auto-configure 'veth' pair according to LTP network
+environment variables.
 
+## Two Host Configuration
+
+This setup requires 'RHOST' environment variable to be set properly and
+configured SSH or RSH (default) access to a remote host.
+
+The 'RHOST' variable name must be set to the hostname of the server
+(test management link) and PASSWD should be set to the root password
+of the remote server.
+
+In order to have RSH access:
 * Edit the "/root/.rhosts" file. Please note that the file may not exist,
 so you must create one if it does not. You must add the fully qualified
 hostname of the machine you are testing on to this file. By adding the test
@@ -34,7 +41,15 @@ You may need to re-label '.rhost' file to make sure rlogind will have access to
 for i in rlogin rsh rexec; do echo $i >> /etc/securetty; done
 ```
 
-## FTP setup
+## Server Services Configuration
+Verify that the below daemon services are running. If not, please install
+and start them:
+rsh-server, telnet-server, finger-server, rdist, rsync, dhcp-server, http-server.
+
+Note: If any of the above daemon is not running on server, the test related to
+that service running from client will fail.
+
+### FTP setup
 * In “/etc/ftpusers” [or vi /etc/vsftpd.ftpusers], comment the line containing
 “root” string. This file lists all those users who are not given access to do ftp
 on the current system.
@@ -44,28 +59,16 @@ machine <remote_server_name> login root password <remote_root_password>.
 Otherwise, ftp,rlogin & telnet fails for ‘root’ user & hence needs to be
 executed using ‘test’ user to get successful results.
 
-## NFS setup
-* In “/etc/exports“, add the following:
-
-```
-/ <local_machine_ip>/255.255.255.0(rw,no_root_squash,sync)
-```
-
-* Then run “exportfs” to get a list of exported file system.
-
 ## LTP setup
-Install LTP testsuite on both client and server machines.
-Make sure testcases and network tools are in PATH, e.g.:
+Install LTP testsuite. In case of two hosts configuration, make sure LTP is installed
+on both client and server machines.
+
+Testcases and network tools must be in PATH, e.g.:
 
 ```sh
 export PATH=/opt/ltp/testcases/bin:/usr/bin:$PATH
 ```
-
-The RHOST variable name should be set to the hostname of the server
-(test management link) and PASSWD should be set to the root password
-of the remote server.
-
-Default values for all network variables are set in testcases/lib/test_net.sh.
+Default values for all LTP network variables are set in testcases/lib/test_net.sh.
 If you need to override some parameters please export them before test run or
 specify them when running ltp-pan or testscripts/network.sh.
 
-- 
1.7.1

