From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  8 Dec 2016 10:54:07 +0100
Subject: [LTP] [PATCH v2 2/2] network: cleanup duplicity + other minor
	cleanup
In-Reply-To: <20161208095407.9948-1-pvorel@suse.cz>
References: <20161208095407.9948-1-pvorel@suse.cz>
Message-ID: <20161208095407.9948-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testscripts/network.sh | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/testscripts/network.sh b/testscripts/network.sh
index 2d2c6762c..0736bf1e3 100755
--- a/testscripts/network.sh
+++ b/testscripts/network.sh
@@ -11,7 +11,7 @@ fi
 export TMPDIR=/tmp/netpan-$$
 mkdir -p $TMPDIR
 CMDFILE=${TMPDIR}/network.tests
-VERBOSE="no"
+VERBOSE=
 
 export PATH="${PATH}:${LTPROOT}/testcases/bin"
 
@@ -89,20 +89,23 @@ done
 
 cd $TMPDIR
 
-if [ ${VERBOSE} = "yes" ]; then
-	echo "Network parameters:"
-	echo " - ${LHOST_IFACES} local interface (MAC address: ${LHOST_HWADDRS})"
-	echo " - ${RHOST_IFACES} remote interface (MAC address: ${RHOST_HWADDRS})"
+COMMAND="$LTPROOT/bin/ltp-pan -e -l /tmp/netpan.log -S -a ltpnet -n ltpnet -f $CMDFILE"
+if [ "$VERBOSE" = "yes" ]; then
+cat << EOF
+Network parameters:
+ - ${LHOST_IFACES} local interface (MAC address: ${LHOST_HWADDRS})
+ - ${RHOST_IFACES} remote interface (MAC address: ${RHOST_HWADDRS})
 
-	cat $CMDFILE
-	${LTPROOT}/ver_linux
-	echo ""
-	echo ${LTPROOT}/bin/ltp-pan -e -l /tmp/netpan.log -S -a ltpnet -n ltpnet -f $CMDFILE
+`cat $CMDFILE`
+`${LTPROOT}/ver_linux`
+
+$COMMAND
+EOF
 fi
 
-${LTPROOT}/bin/ltp-pan -e -l /tmp/netpan.log -S -a ltpnet -n ltpnet -f $CMDFILE
+$COMMAND
 
-if [ $? -eq "0" ]; then
+if [ $? -eq 0 ]; then
 	echo ltp-pan reported PASS
 else
 	echo ltp-pan reported FAIL
-- 
2.11.0

