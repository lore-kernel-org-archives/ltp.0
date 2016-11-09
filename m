From: Petr Vorel <pvorel@suse.cz>
Date: Wed,  9 Nov 2016 15:35:39 +0100
Subject: [LTP] [PATCH 1/1] network: load test_net.sh after getopts
Message-ID: <20161109143539.29310-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We shouldn't ask rsh/ssh password or require having set ssh pub keys
just for displaying help.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Alexey, thanks a lot for your point, I overlooked the comment in the
code.

v2: reset TST_TOTAL and TCID variables after loading test_net.sh
Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testscripts/network.sh | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/testscripts/network.sh b/testscripts/network.sh
index 66bacef..6b81823 100755
--- a/testscripts/network.sh
+++ b/testscripts/network.sh
@@ -1,8 +1,5 @@
 #!/bin/sh
 
-TST_TOTAL=1
-TCID="network_settings"
-
 cd $(dirname $0)
 export LTPROOT=${LTPROOT:-"$PWD"}
 echo $LTPROOT | grep -q testscripts
@@ -11,8 +8,6 @@ if [ $? -eq 0 ]; then
 	export LTPROOT=${PWD}
 fi
 
-. test_net.sh
-
 export TMPDIR=/tmp/netpan-$$
 mkdir -p $TMPDIR
 CMDFILE=${TMPDIR}/network.tests
@@ -20,11 +15,6 @@ VERBOSE="no"
 
 export PATH="${PATH}:${LTPROOT}/testcases/bin"
 
-# Reset variables.
-# Don't break the tests which are using 'testcases/lib/cmdlib.sh'
-export TCID=
-export TST_LIB_LOADED=
-
 usage()
 {
 	echo "Usage: $0 OPTIONS"
@@ -81,6 +71,16 @@ if [ "$OPTIND" -eq 1 ]; then
 	exit 1
 fi
 
+TST_TOTAL=1
+TCID="network_settings"
+
+. test_net.sh
+
+# Reset variables.
+# Don't break the tests which are using 'testcases/lib/cmdlib.sh'
+export TCID=
+export TST_LIB_LOADED=
+
 rm -f $CMDFILE
 
 for t in $TEST_CASES; do
-- 
2.10.2

