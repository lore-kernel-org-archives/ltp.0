From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon,  7 Nov 2016 13:19:52 +0100
Subject: [LTP] [PATCH 1/1] network: load test_net.sh after getopts
Message-ID: <20161107121952.24933-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

We shouldn't ask rsh/ssh password or require having set ssh pub keys
just for displaying help.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testscripts/network.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testscripts/network.sh b/testscripts/network.sh
index 66bacef..fea2f68 100755
--- a/testscripts/network.sh
+++ b/testscripts/network.sh
@@ -11,8 +11,6 @@ if [ $? -eq 0 ]; then
 	export LTPROOT=${PWD}
 fi
 
-. test_net.sh
-
 export TMPDIR=/tmp/netpan-$$
 mkdir -p $TMPDIR
 CMDFILE=${TMPDIR}/network.tests
@@ -81,6 +79,8 @@ if [ "$OPTIND" -eq 1 ]; then
 	exit 1
 fi
 
+. test_net.sh
+
 rm -f $CMDFILE
 
 for t in $TEST_CASES; do
-- 
2.10.2

