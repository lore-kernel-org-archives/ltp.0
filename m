From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Aug 2017 15:33:48 +0200
Subject: [LTP] [PATCH v3 3/3] testscripts/network.sh: Add -Q and -q switches
	passed to ltp-pan + cleanup
In-Reply-To: <20170822133348.5377-1-pvorel@suse.cz>
References: <20170822133348.5377-1-pvorel@suse.cz>
Message-ID: <20170822133348.5377-3-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Alexey, feel free to ignore this patch if you find -q and -Q switches useless.
---
 testscripts/network.sh | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/testscripts/network.sh b/testscripts/network.sh
index a656bc258..3d09d0987 100755
--- a/testscripts/network.sh
+++ b/testscripts/network.sh
@@ -12,6 +12,9 @@ export TMPDIR=/tmp/netpan-$$
 mkdir -p $TMPDIR
 CMDFILE=${TMPDIR}/network.tests
 VERBOSE="no"
+NO_KMSG=
+QUIET_MODE=
+TEST_CASES=
 
 export PATH="${PATH}:${LTPROOT}/testcases/bin"
 
@@ -36,13 +39,14 @@ usage()
 	echo "  -M    multicast stress tests"
 	echo "  -F    network features tests (TFO, vxlan, etc.)"
 	echo "  -f x  where x is a runtest file"
+	echo "  -q    quiet mode (this implies not logging start of test"
+	echo "        in kernel log)"
+	echo "  -Q    don't log start of test in kernel log"
 	echo "  -V|v  verbose"
 	echo "  -h    print this help"
 }
 
-TEST_CASES=
-
-while getopts 6mnrstaebcdiTURMFf:Vvh OPTION
+while getopts 6mnrstaebcdiTURMFf:qQVvh OPTION
 do
 	case $OPTION in
 	6) TEST_CASES="$TEST_CASES net.ipv6 net.ipv6_lib";;
@@ -63,6 +67,8 @@ do
 	M) TEST_CASES="$TEST_CASES net_stress.multicast";;
 	F) TEST_CASES="$TEST_CASES net.features";;
 	f) TEST_CASES=${OPTARG};;
+	q) QUIET_MODE="-q";;
+	Q) NO_KMSG="-Q";;
 	V|v) VERBOSE="yes";;
 	h) usage; exit 0;;
 	*) echo "Error: invalid option..."; usage; exit 1;;
@@ -93,6 +99,8 @@ done
 
 cd $TMPDIR
 
+cmd="${LTPROOT}/bin/ltp-pan $QUIET_MODE $NO_KMSG -e -l /tmp/netpan.log -S -a ltpnet -n ltpnet -f $CMDFILE"
+
 if [ ${VERBOSE} = "yes" ]; then
 	echo "Network parameters:"
 	echo " - ${LHOST_IFACES} local interface (MAC address: ${LHOST_HWADDRS})"
@@ -101,10 +109,10 @@ if [ ${VERBOSE} = "yes" ]; then
 	cat $CMDFILE
 	${LTPROOT}/ver_linux
 	echo ""
-	echo ${LTPROOT}/bin/ltp-pan -e -l /tmp/netpan.log -S -a ltpnet -n ltpnet -f $CMDFILE
+	echo $cmd
 fi
 
-${LTPROOT}/bin/ltp-pan -e -l /tmp/netpan.log -S -a ltpnet -n ltpnet -f $CMDFILE
+$cmd
 
 if [ $? -eq "0" ]; then
 	echo ltp-pan reported PASS
-- 
2.14.0

