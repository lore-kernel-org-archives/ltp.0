From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Thu,  2 Aug 2018 16:12:51 +0200
Subject: [LTP] [PATCH 2/2] testcases: netns: Handle "Operation not
	supported" error
In-Reply-To: <20180802141251.1571-1-mylene.josserand@bootlin.com>
References: <20180802141251.1571-1-mylene.josserand@bootlin.com>
Message-ID: <20180802141251.1571-2-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

If there is no support for "dummy" or "veth", the tests will fail
with errors:
   RTNETLINK answers: Operation not supported
   netns_sysfs 1 TBROK: failed to add a new (host) dummy device
and
   RTNETLINK answers: Operation not supported
   netns_comm_ip_ipv6_ioctl 1 TBROK: unable to create veth pair devices
   Cannot find device "veth0"

This commit is storing the output of the commands and verifies
if there is any reference to "Operation not supported".
This code is based on what it is already done in "ipsec_lib.sh"
stress test.

Signed-off-by: Myl=C3=A8ne Josserand <mylene.josserand@bootlin.com>
---
 testcases/kernel/containers/netns/netns_helper.sh | 16 ++++++++++++++--
 testcases/kernel/containers/netns/netns_sysfs.sh  |  6 +++++-
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/containers/netns/netns_helper.sh b/testcases/=
kernel/containers/netns/netns_helper.sh
index 6aea10b47..58be60148 100755
--- a/testcases/kernel/containers/netns/netns_helper.sh
+++ b/testcases/kernel/containers/netns/netns_helper.sh
@@ -199,8 +199,14 @@ netns_ns_exec_setup()
 		tst_brkm TBROK "unable to create a new network namespace"
 	fi
=20
-	$NS_EXEC $NS_HANDLE0 $NS_TYPE ip link add veth0 type veth peer name veth1=
 || \
+	local output=3D$($NS_EXEC $NS_HANDLE0 $NS_TYPE ip link add veth0 type \
+				veth peer name veth1 2>&1 || echo 'TERR')
+	if echo "$output" | grep -q "TERR"; then
+		echo "$output" | grep -q \
+			'RTNETLINK answers: Operation not supported' && \
+			tst_brkm TCONF "Command not supported (maybe missing 'veth' support)"
 		tst_brkm TBROK "unable to create veth pair devices"
+	fi
=20
 	$NS_EXEC $NS_HANDLE0 $NS_TYPE ns_ifmove veth1 $NS_HANDLE1
 	ret=3D$?
@@ -235,8 +241,14 @@ netns_ip_setup()
 	ip netns add $NS_HANDLE1 || \
 		tst_brkm TBROK "unable to create a new network namespace"
=20
-	$NS_EXEC $NS_HANDLE0 ip link add veth0 type veth peer name veth1 || \
+	local output=3D$($NS_EXEC $NS_HANDLE0 ip link add veth0 type \
+				veth peer name veth1 2>&1 || echo 'TERR')
+	if echo "$output" | grep -q "TERR"; then
+		echo "$output" | grep -q \
+			'RTNETLINK answers: Operation not supported' && \
+			tst_brkm TCONF "Command not supported (maybe missing 'veth' support)"
 		tst_brkm TBROK "unable to create veth pair devices"
+	fi
=20
 	$NS_EXEC $NS_HANDLE0 ip link set veth1 netns $NS_HANDLE1 || \
 		tst_brkm TBROK "unable to add device veth1 to the separate network names=
pace"
diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/k=
ernel/containers/netns/netns_sysfs.sh
index 944a4c152..138d11402 100644
--- a/testcases/kernel/containers/netns/netns_sysfs.sh
+++ b/testcases/kernel/containers/netns/netns_sysfs.sh
@@ -54,8 +54,12 @@ if [ $? -eq 1 ]; then
 fi
 TST_CLEANUP=3Dcleanup
=20
-ip link add $DUMMYDEV_HOST type dummy || \
+output=3D$(ip link add $DUMMYDEV_HOST type dummy 2>&1 || echo 'TERR')
+if echo "$output" | grep -q "TERR"; then
+	echo "$output" | grep -q 'RTNETLINK answers: Operation not supported' && \
+		tst_brkm TCONF "Command not supported (maybe missing 'dummy' support)"
 	tst_brkm TBROK "failed to add a new (host) dummy device"
+fi
=20
 ns_exec $NS_HANDLE $NS_TYPE mount --make-rprivate /sys
 ns_exec $NS_HANDLE $NS_TYPE ip link add $DUMMYDEV type dummy || \
--=20
2.11.0

