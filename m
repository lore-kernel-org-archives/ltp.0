Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1WpeaN-0007GU-6U
	for ltp-list@lists.sourceforge.net; Wed, 28 May 2014 14:12:07 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WpeaM-0006Mu-A3
	for ltp-list@lists.sourceforge.net; Wed, 28 May 2014 14:12:07 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s4SEBxtf023391
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 28 May 2014 14:12:00 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s4SEBxNr026066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 28 May 2014 14:11:59 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s4SEBwMk025979
	for <ltp-list@lists.sourceforge.net>; Wed, 28 May 2014 14:11:58 GMT
From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 28 May 2014 18:12:03 +0400
Message-Id: <1401286323-7364-1-git-send-email-alexey.kodanev@oracle.com>
Subject: [LTP] [PATCH RFC] testscripts/network: uniform network parameters
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

Move networktests.sh and networkstress.sh parameters to network.sh.
Both network scripts have the same settings (e.g. RHOST), and
some of the stress test parameters can be used by other net-tests,
such as LHOST_INTERFACE and RHOST_INTERFACE variables.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testscripts/network.sh       |   53 ++++++++++++++++++++++++++++++++++++++++++
 testscripts/networkstress.sh |   36 ++++++----------------------
 testscripts/networktests.sh  |   10 +-------
 3 files changed, 62 insertions(+), 37 deletions(-)
 create mode 100755 testscripts/network.sh

diff --git a/testscripts/network.sh b/testscripts/network.sh
new file mode 100755
index 0000000..0b89c8e
--- /dev/null
+++ b/testscripts/network.sh
@@ -0,0 +1,53 @@
+#!/bin/sh
+
+# Network Test Parameters
+#
+# ---***** THESE MUST BE SET FOR CORRECT OPERATION *****---
+
+export RHOST=
+export PASSWD=
+
+# ---***************************************************---
+
+LTP_RSH=
+
+# Set names for test interfaces
+LHOST_INTERFACE=
+RHOST_INTERFACE=
+
+# Set first three octets of the network address
+IPV4_NETWORK=
+# Set local host last octet
+LHOST_IPV4_HOST=
+# Set remote host last octet
+RHOST_IPV4_HOST=
+# Set the reverse of IPV4_NETWORK
+IPV4_NETWORK_REVERSE=
+# Set firt three octets of the network address
+IPV6_NETWORK=
+# Set local host last octet
+LHOST_IPV6_HOST=
+# Set remote host last octet
+RHOST_IPV6_HOST=
+
+export HTTP_DOWNLOAD_DIR=
+export FTP_DOWNLOAD_DIR=
+export FTP_UPLOAD_DIR=
+export FTP_UPLOAD_URLDIR=
+
+# Set default parameters
+export LTP_RSH=${LTP_RSH:-"rsh -n"}
+export LHOST_INTERFACE=${LHOST_INTERFACE:-"eth0"}
+export RHOST_INTERFACE=${RHOST_INTERFACE:-"eth0"}
+export IPV4_NETWORK=${IPV4_NETWORK:-"10.0.0"}
+export IPV6_NETWORK=${IPV6_NETWORK:-"fd00:1:1:1"}
+export LHOST_IPV4_HOST=${LHOST_IPV4_HOST:-"2"}
+export RHOST_IPV4_HOST=${RHOST_IPV4_HOST:-"1"}
+export LHOST_IPV6_HOST=${LHOST_IPV6_HOST:-":2"}
+export RHOST_IPV6_HOST=${RHOST_IPV6_HOST:-":1"}
+export IPV4_NETWORK_REVERSE=${IPV4_NETWORK_REVERSE:-"0.0.10"}
+
+export TMPDIR=/tmp/netpan-$$
+mkdir -p $TMPDIR
+CMDFILE=${TMPDIR}/network.tests
+VERBOSE="no"
diff --git a/testscripts/networkstress.sh b/testscripts/networkstress.sh
index b40af72..7536d3f 100755
--- a/testscripts/networkstress.sh
+++ b/testscripts/networkstress.sh
@@ -12,32 +12,10 @@ if [ $? -eq 0 ]; then
  export LTPROOT=${PWD}
 fi
 
-export TMPDIR=/tmp/netst-$$
-mkdir $TMPDIR
-VERBOSE="no"
-INTERFACE="eth0"
-
-#===========================================================================
-# Network parameters
-export RHOST=
-export RHOST_HWADDRS=
-export HTTP_DOWNLOAD_DIR=
-export FTP_DOWNLOAD_DIR=
-export FTP_UPLOAD_DIR=
-export FTP_UPLOAD_URLDIR=
-
-# Set firt three octets of the network address, by default 10.0.0
-export IPV4_NETWORK=
-# Set local host last octet, by default 2
-export LHOST_IPV4_HOST=
-# Set remote host last octet, by default 1
-export RHOST_IPV4_HOST=
-# Set the reverse of IPV4_NETWORK, by default 0.0.10
-export IPV4_NETWORK_REVERSE=
+. $LTPROOT/testscripts/network.sh $0
 
 #===========================================================================
 # Default Test Settings
-# export LTP_RSH=rsh
 # export NS_DURATION=3600	# 1 hour
 # export NS_TIMES=10000
 # export CONNECTION_TOTAL=4000
@@ -102,8 +80,6 @@ if [ -z ${TEST_CASE} ]; then
 	usage
 fi
 
-export LHOST_HWADDRS=`ifconfig | grep ${INTERFACE} | grep HWaddr |awk '{print $5}'`
-
 if [ -z ${RHOST} ]; then
 	## Just a silly check
 	echo "Error: pay attention to configure"
@@ -111,6 +87,11 @@ if [ -z ${RHOST} ]; then
 	exit 1
 fi
 
+export LHOST_HWADDRS=$(/sbin/ifconfig | grep $LHOST_INTERFACE |\
+	grep HWaddr | awk '{print $5}')
+export RHOST_HWADDRS=$($LTP_RSH $RHOST /sbin/ifconfig |\
+	grep $RHOST_INTERFACE | grep HWaddr | awk '{print $5}')
+
 cat ${LTPROOT}/runtest/${TEST_CASE} > $TMPDIR/network_stress.tests
 
 cd $TMPDIR
@@ -119,9 +100,8 @@ export PATH="${PATH}:${LTPROOT}/testcases/bin"
 
 if [ ${VERBOSE} = "yes" ]; then
 	echo "Network parameters:"
-	echo " - ${INTERFACE} local interface (MAC address: ${LHOST_HWADDRS})"
-	echo " - Remote IP address: ${RHOST}"
-	echo " - Remote MAC address: ${RHOST_HWADDRS}"
+	echo " - ${LHOST_INTERFACE} local interface (MAC address: ${LHOST_HWADDRS})"
+	echo " - ${RHOST_INTERFACE} remote interface (MAC address: ${RHOST_HWADDRS})"
 
 	cat $TMPDIR/network_stress.tests
 	${LTPROOT}/ver_linux
diff --git a/testscripts/networktests.sh b/testscripts/networktests.sh
index b136749..507b7e3 100755
--- a/testscripts/networktests.sh
+++ b/testscripts/networktests.sh
@@ -1,11 +1,6 @@
 #!/bin/sh
 # This will run all the network tests, with the status logged in /tmp/netpan.log
 
-# ---***** THESE MUST BE SET FOR CORRECT OPERATION *****---
-export RHOST=
-export PASSWD=
-# ---***************************************************---
-
 cd `dirname $0`
 export LTPROOT=${PWD}
 echo $LTPROOT | grep testscripts > /dev/null 2>&1
@@ -14,10 +9,7 @@ if [ $? -eq 0 ]; then
  export LTPROOT=${PWD}
 fi
 
-export TMPDIR=/tmp/netpan-$$
-mkdir -p $TMPDIR
-CMDFILE=${TMPDIR}/network.tests
-VERBOSE="no"
+. $LTPROOT/testscripts/network.sh $0
 
 # For bitwise operation to determine which testsets run
 CMD_IPV6=1		# 0x0001
-- 
1.7.1


------------------------------------------------------------------------------
Time is money. Stop wasting it! Get your web API in 5 minutes.
www.restlet.com/download
http://p.sf.net/sfu/restlet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
