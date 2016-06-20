From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 20 Jun 2016 17:28:51 +0300
Subject: [LTP] [PATCH 3/8] network/nfs_lib.sh: add options,
	socket type and NFS ver
In-Reply-To: <1466432936-3099-1-git-send-email-alexey.kodanev@oracle.com>
References: <1466432936-3099-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1466432936-3099-4-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Additionally, add more configurations including NFSv4.2.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 runtest/net.nfs                             |   62 ++++++++++++++++++---------
 testcases/network/nfs/nfs_stress/nfs_lib.sh |   32 ++++++++++++--
 2 files changed, 68 insertions(+), 26 deletions(-)

diff --git a/runtest/net.nfs b/runtest/net.nfs
index 43cf504..7208a3b 100644
--- a/runtest/net.nfs
+++ b/runtest/net.nfs
@@ -1,31 +1,51 @@
 #DESCRIPTION:Network filesystem stress
 #
-# PLEASE READ THE README FILE IN /nfs BEFORE RUNNING THESE.
+# PLEASE READ THE README FILE network/README.md BEFORE RUNNING THESE.
 #
-nfs3_01 export VERSION=3 SOCKET_TYPE=udp; nfs01
-nfs4_01 export VERSION=4 SOCKET_TYPE=tcp; nfs01
-nfs3_ipv6_01 export VERSION=3 SOCKET_TYPE=udp; nfs01 -6
-nfs4_ipv6_01 export VERSION=4 SOCKET_TYPE=tcp; nfs01 -6
+nfs3_01 nfs01 -v 3 -t udp
+nfs4_01 nfs01 -v 3 -t tcp
+nfs41_01 nfs01 -v 4.1 -t tcp
+nfs42_01 nfs01 -v 4.2 -t tcp
+nfs3_ipv6_01 nfs01 -6 -v 3 -t udp
+nfs4_ipv6_01 nfs01 -6 -v 4 -t tcp
+nfs41_ipv6_01 nfs01 -6 -v 4.1 -t tcp
+nfs42_ipv6_01 nfs01 -6 -v 4.2 -t tcp
 
-nfs3_02 export VERSION=3 SOCKET_TYPE=udp; nfs02
-nfs4_02 export VERSION=4 SOCKET_TYPE=tcp; nfs02
-nfs3_ipv6_02 export VERSION=3 SOCKET_TYPE=udp; nfs02 -6
-nfs4_ipv6_02 export VERSION=4 SOCKET_TYPE=tcp; nfs02 -6
+nfs3_02 nfs02 -v 3 -t udp
+nfs4_02 nfs02 -v 3 -t tcp
+nfs41_02 nfs02 -v 4.1 -t tcp
+nfs42_02 nfs02 -v 4.2 -t tcp
+nfs3_ipv6_02 nfs02 -6 -v 3 -t udp
+nfs4_ipv6_02 nfs02 -6 -v 4 -t tcp
+nfs41_ipv6_02 nfs02 -6 -v 4.1 -t tcp
+nfs42_ipv6_02 nfs02 -6 -v 4.2 -t tcp
 
-nfs3_03 export VERSION=3 SOCKET_TYPE=udp; nfs03
-nfs4_03 export VERSION=4 SOCKET_TYPE=tcp; nfs03
-nfs3_ipv6_03 export VERSION=3 SOCKET_TYPE=udp; nfs03 -6
-nfs4_ipv6_03 export VERSION=4 SOCKET_TYPE=tcp; nfs03 -6
+nfs3_03 nfs03 -v 3 -t udp
+nfs4_03 nfs03 -v 3 -t tcp
+nfs41_03 nfs03 -v 4.1 -t tcp
+nfs42_03 nfs03 -v 4.2 -t tcp
+nfs3_ipv6_03 nfs03 -6 -v 3 -t udp
+nfs4_ipv6_03 nfs03 -6 -v 4 -t tcp
+nfs41_ipv6_03 nfs03 -6 -v 4.1 -t tcp
+nfs42_ipv6_03 nfs03 -6 -v 4.2 -t tcp
 
-nfs3_04 export VERSION=3 SOCKET_TYPE=udp; nfs04
-nfs4_04 export VERSION=4 SOCKET_TYPE=tcp; nfs04
-nfs3_ipv6_04 export VERSION=3 SOCKET_TYPE=udp; nfs04 -6
-nfs4_ipv6_04 export VERSION=4 SOCKET_TYPE=tcp; nfs04 -6
+nfs3_04 nfs04 -v 3 -t udp
+nfs4_04 nfs04 -v 3 -t tcp
+nfs41_04 nfs04 -v 4.1 -t tcp
+nfs42_04 nfs04 -v 4.2 -t tcp
+nfs3_ipv6_04 nfs04 -6 -v 3 -t udp
+nfs4_ipv6_04 nfs04 -6 -v 4 -t tcp
+nfs41_ipv6_04 nfs04 -6 -v 4.1 -t tcp
+nfs42_ipv6_04 nfs04 -6 -v 4.2 -t tcp
 
-nfs3_05 export VERSION=3 SOCKET_TYPE=udp; nfs05
-nfs4_05 export VERSION=4 SOCKET_TYPE=tcp; nfs05
-nfs3_ipv6_05 export VERSION=3 SOCKET_TYPE=udp; nfs05 -6
-nfs4_ipv6_05 export VERSION=4 SOCKET_TYPE=tcp; nfs05 -6
+nfs3_05 nfs05 -v 3 -t udp
+nfs4_05 nfs05 -v 4 -t tcp
+nfs41_05 nfs05 -v 4.1 -t tcp
+nfs42_05 nfs05 -v 4.2 -t tcp
+nfs3_ipv6_05 nfs05 -6 -v 3 -t udp
+nfs4_ipv6_05 nfs05 -6 -v 4 -t tcp
+nfs41_ipv6_05 nfs05 -6 -v 4.1 -t tcp
+nfs42_ipv6_05 nfs05 -6 -v 4.2 -t tcp
 
 nfslock01 export VERSION; TCbin=$LTPROOT/testcases/bin nfslock01
 
diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 38fec05..aca150d 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -1,4 +1,4 @@
-# Copyright (c) 2015 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2015-2016 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2001
 #
 # This program is free software; you can redistribute it and/or
@@ -14,12 +14,34 @@
 # You should have received a copy of the GNU General Public License
 # along with this program. If not, see <http://www.gnu.org/licenses/>.
 
+VERSION=${VERSION:=3}
+NFILES=${NFILES:=1000}
+SOCKET_TYPE="${SOCKET_TYPE:-udp}"
+NFS_TYPE=${NFS_TYPE:=nfs}
+
+while getopts :ht:v:6 opt; do
+	case "$opt" in
+	h)
+		echo "Usage:"
+		echo "h        help"
+		echo "t x      socket type, tcp or udp, default is udp"
+		echo "v x      NFS version, default is '3'"
+		echo "6        run over IPv6"
+		exit 0
+	;;
+	v) VERSION=$OPTARG ;;
+	t) SOCKET_TYPE=$OPTARG ;;
+	6) # skip, test_net library already processed it
+	;;
+	*)
+		tst_brkm TBROK "unknown option: $opt"
+	;;
+	esac
+done
+
 nfs_setup()
 {
-	VERSION=${VERSION:=3}
-	NFILES=${NFILES:=1000}
-	SOCKET_TYPE="${SOCKET_TYPE:=udp}${TST_IPV6}"
-	NFS_TYPE=${NFS_TYPE:=nfs}
+	SOCKET_TYPE="${SOCKET_TYPE}${TST_IPV6}"
 
 	tst_check_cmds mount exportfs
 
-- 
1.7.1

