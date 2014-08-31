Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1XO2Rn-0000X8-Sn
	for ltp-list@lists.sourceforge.net; Sun, 31 Aug 2014 10:33:23 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XO2Rm-0007ut-6a
	for ltp-list@lists.sourceforge.net; Sun, 31 Aug 2014 10:33:23 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s7VAXDhJ013034
	for <ltp-list@lists.sourceforge.net>; Sun, 31 Aug 2014 18:33:13 +0800
Message-ID: <1409481091.6575.4.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Sun, 31 Aug 2014 18:31:31 +0800
In-Reply-To: <1409480940.6575.1.camel@G08JYZSD130126>
References: <1409480940.6575.1.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: [LTP] [PATCH 4/4] multicast/mc_opts: Some cleanup
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list <ltp-list@lists.sourceforge.net>

* Delete trace_logic that is used to debug.
* Use test.sh script and use tst_* instead of end_testcase.
* Delete some unuseful comments.

* Fix old-style function definition.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/network/multicast/mc_opts/mc_opts  | 161 ++++++---------------------
 testcases/network/multicast/mc_opts/opts.c   |   7 +-
 testcases/network/multicast/mc_opts/opts_e.c |   6 +-
 3 files changed, 40 insertions(+), 134 deletions(-)

diff --git a/testcases/network/multicast/mc_opts/mc_opts b/testcases/network/multicast/mc_opts/mc_opts
index f40112c..5433deb 100755
--- a/testcases/network/multicast/mc_opts/mc_opts
+++ b/testcases/network/multicast/mc_opts/mc_opts
@@ -35,142 +35,55 @@ unset LIBPATH
 #      -Ported
 #
 #******************************************************************************
-#Uncomment the line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
 
-if [ -z $LTPBIN ]; then
-  PATH=../../../bin/:./:$PATH
-fi
 TC=mc_opts
-TCtmp=${TCtmp:-$LTPROOT/bin/$TC$$}
-CLEANUP=${CLEANUP:-ON}
 EXECUTABLES=${EXECUTABLES:-"opts opts_e"}
-NUMLOOPS=${NUMLOOPS:-10}
 IPADDR=${IPADDR:-$(mc_gethost `hostname`| grep address |awk '{ print $2 }')}
 
 export TCID=$TC
 export TST_TOTAL=1
 export TST_COUNT=1
 
-this_file=${0##*/}
-trap "interrupt_test" 2
-
-setup()
-{
-  mkdir -p $TCtmp
-  for i in $EXECUTABLES
-  do
-    install -m 0755 "$LTPROOT/testcases/bin/$i" "$TCtmp/."
-  done
-}
-
-#-----------------------------------------------------------------------
-#
-# FUNCTION:  do_test
-# PURPOSE:   Executes the testcases.
-# INPUT:     Number of iterations
-# OUTPUT:    Error messages are logged when any verification test
-#            fails.
-#
-#-----------------------------------------------------------------------
+. test.sh
 
 do_test()
 {
-   $trace_logic
-   echo "$this_file: doing $0."
-
-   COUNT=1
-   while [ $COUNT -le $NUMLOOPS ]
-   do
-      # Run setsockopt/getsockopt test
-      echo "Running mc_$EXECUTABLES on $IPADDR"
-      for i in $EXECUTABLES
-      do
-        $TCtmp/$i $IPADDR
-        [ $? = 0 ] || end_testcase "$i $IPADDR failed"
-      done
-
-      echo "Running ping with bad values"
-      ping -T 777 224.0.0.1 > /dev/null 2>&1
-      [ $? = 0 ] && end_testcase "Multicast range should be out of range"
-
-      echo "Running ping on a invalid interface!"
-      ping -I 3.3.3.3 224.0.0.1 > /dev/null 2>&1
-      [ $? = 0 ] && end_testcase "ping on bogus interface should fail"
-
-      COUNT=$(( $COUNT + 1 ))
-   done
+	echo "doing test."
+
+	COUNT=1
+	while [ $COUNT -le 10 ]
+	do
+		# Run setsockopt/getsockopt test
+		echo "Running mc_$EXECUTABLES on $IPADDR"
+		for i in $EXECUTABLES
+		do
+			$i $IPADDR
+			if [ $? -ne 0 ]; then
+				tst_brkm FAIL "$i $IPADDR failed"
+			fi
+		done
+
+		echo "Running ping with bad values"
+		ping -T 777 224.0.0.1 > /dev/null 2>&1
+		if [ $? -eq 0 ]; then
+			tst_brkm FAIL "Multicast range should be out of range"
+		fi
+
+		echo "Running ping on a invalid interface!"
+		ping -I 3.3.3.3 224.0.0.1 > /dev/null 2>&1
+		if [ $? -eq 0 ]; then
+			tst_brkm FAIL "ping on bogus interface should fail"
+		fi
+
+		COUNT=$(( $COUNT + 1 ))
+	done
 }
 
-#-----------------------------------------------------------------------
-#
-# FUNCTION:     do_cleanup
-# PURPOSE:      Called when the testcase is interrupted by the user
-#               or by interrupt_testcase() when time limit expired
-# INPUT:        None.
-# OUTPUT:       None.
-#
-#-----------------------------------------------------------------------
-
-do_cleanup()
-{
-   $trace_logic
-   echo "$this_file: doing $0."
-
-   cd /
-   if [ "x$TCtmp" != "x$TCsrc" ]; then
-      rm -rf $TCtmp
-   fi
-}
-
-#=============================================================================
-# FUNCTION NAME:        end_testcase
-#
-# FUNCTION DESCRIPTION: Clean up
-#
-# PARAMETERS:           string, IF AND ONLY IF the testcase fails
-#
-# RETURNS:              None.
-#=============================================================================
-
-end_testcase()
-{
-   $trace_logic
-   echo "$this_file: doing $0."
-
-   # Call other cleanup functions
-   [ $CLEANUP = "ON" ] && do_cleanup
-
-   [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
-   tst_resm TFAIL "Test Failed: $@"
-   exit 1
-}
-
-#******************************************************************************
-#
-# FUNCTION:  interrupt_test
-# PURPOSE:   Handle process interrupts set by trap.
-# INPUT:     none
-# OUTPUT:    none
-#
-#******************************************************************************
-
-interrupt_test()
-{
-   echo "test interrupted"
-   end_testcase
-}
-
-#******************************************************************************
-#
-# FUNCTION:  MAIN
-# PURPOSE:   To invoke functions that perform the tasks as described in
-#            the design in the prolog above.
-# INPUT:     See SETUP in the prolog above.
-# OUTPUT:    Logged run results written to testcase run log
-#
-#******************************************************************************
-setup
 do_test
-end_testcase
+if [ $? -ne 0 ]; then
+	tst_resm TFAIL "Test Failed"
+else
+	tst_resm TPASS "Test Successful"
+fi
+
+tst_exit
diff --git a/testcases/network/multicast/mc_opts/opts.c b/testcases/network/multicast/mc_opts/opts.c
index 0174d91..8a1f5c8 100644
--- a/testcases/network/multicast/mc_opts/opts.c
+++ b/testcases/network/multicast/mc_opts/opts.c
@@ -11,12 +11,9 @@
 
 #define	MAXBUFSIZ	8096
 
-char buff[MAXBUFSIZ];
-int errors = 0;
+static int errors = 0;
 
-int main(argc, argv)
-int argc;
-char *argv[];
+int main(int argc, char *argv[])
 {
 	int s;
 	struct in_addr gimr;
diff --git a/testcases/network/multicast/mc_opts/opts_e.c b/testcases/network/multicast/mc_opts/opts_e.c
index f91fa93..663032a 100644
--- a/testcases/network/multicast/mc_opts/opts_e.c
+++ b/testcases/network/multicast/mc_opts/opts_e.c
@@ -10,11 +10,7 @@
 
 #define	MAXBUFSIZ	8096
 
-char buff[MAXBUFSIZ];
-
-int main(argc, argv)
-int argc;
-char *argv[];
+int main(int argc, char *argv[])
 {
 	int s;
 	struct in_addr simr, gimr;
-- 
1.9.3




------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
