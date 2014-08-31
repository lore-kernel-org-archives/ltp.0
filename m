Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1XO2RC-0005cv-BZ
	for ltp-list@lists.sourceforge.net; Sun, 31 Aug 2014 10:32:46 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XO2RA-0007th-08
	for ltp-list@lists.sourceforge.net; Sun, 31 Aug 2014 10:32:46 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s7VAWY73013026
	for <ltp-list@lists.sourceforge.net>; Sun, 31 Aug 2014 18:32:34 +0800
Message-ID: <1409481052.6575.3.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Sun, 31 Aug 2014 18:30:52 +0800
In-Reply-To: <1409480940.6575.1.camel@G08JYZSD130126>
References: <1409480940.6575.1.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: [LTP] [PATCH 3/4] multicast/mc_member: Some cleanup
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
 testcases/network/multicast/mc_member/mc_member | 237 +++++++++---------------
 testcases/network/multicast/mc_member/member.c  |  21 +--
 2 files changed, 94 insertions(+), 164 deletions(-)

diff --git a/testcases/network/multicast/mc_member/mc_member b/testcases/network/multicast/mc_member/mc_member
index 3ffdc99..2034e6a 100755
--- a/testcases/network/multicast/mc_member/mc_member
+++ b/testcases/network/multicast/mc_member/mc_member
@@ -33,17 +33,11 @@ unset LIBPATH
 #      -Ported
 #
 #******************************************************************************
-#Uncomment the line below for debug output
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
 
 TC=mc_member
 TCsrc=${TCsrc:-`pwd`}
 TCtmp=${TCtmp:-$TCsrc/$TC$$}
-CLEANUP=${CLEANUP:-ON}
 
-EXECUTABLES=${EXECUTABLES:-"member"}
-NUMLOOPS=${NUMLOOPS:-2}
 INTERFACE=${INTERFACE:-$(mc_gethost `hostname`| grep address |awk '{ print $2 }')}
 GLIST=${GLIST:-$TCsrc/ManyGroups}
 TooManyGLIST=${TooManyGLIST:-$TCsrc/TooManyGroups}
@@ -53,168 +47,107 @@ export TCID=$TC
 export TST_TOTAL=1
 export TST_COUNT=1
 
-this_file=${0##*/}
-trap "interrupt_test" 2
+. test.sh
 
 setup()
 {
-  mkdir -p $TCtmp
+	mkdir -p $TCtmp
 }
 
 get_address()
 {
-  DIGIT=`ps -ef | grep mc_member | grep -v grep | wc -l`
-  ADDRESS=$DIGIT.$DIGIT.$DIGIT.$DIGIT
+	DIGIT=`ps -ef | grep mc_member | grep -v grep | wc -l`
+	ADDRESS=$DIGIT.$DIGIT.$DIGIT.$DIGIT
 }
 
-#******************************************************************************
-#
-# FUNCTION:  do_test
-# PURPOSE:   Executes the testcases.
-# INPUT:     Number of iterations
-# OUTPUT:    Error messages are logged when any verification test
-#            fails.
-#
-#-----------------------------------------------------------------------
-
 do_test()
 {
-   $trace_logic
-   echo "$this_file: doing $0."
-
-   COUNT=1
-   while [ $COUNT -le $NUMLOOPS ]
-   do
-      # Run setsockopt test with bogus network
-      get_address
-      echo "Running mc_member_e on $ADDRESS"
-      $TCsrc/$EXECUTABLES -j -g $GLIST -s 30 -i $ADDRESS >/dev/null 2>&1
-
-      # Run setsockopt/getsockopt test
-
-      $TCsrc/$EXECUTABLES -g $GLIST -s 80 -i $INTERFACE > $ERRFILE 2>&1 &
-
-      # Join twice and leave once and see if the groups are still joined on
-      # all specified interfaces.
-
-      for agroup in `cat $GLIST`
-      do
-         echo "Running (1st) member on $INTERFACE"
-         $TCsrc/$EXECUTABLES -j -g $GLIST -s 30 -i $INTERFACE > $ERRFILE 2>&1 &
-         sleep 5
-         grep "cannot join group" $ERRFILE
-         [ $? = 0 ] && end_testcase "MC group could NOT join $INTERFACE"
-
-         echo "Running (2nd) member on  $INTERFACE"
-         $TCsrc/$EXECUTABLES -g $GLIST -s 60 -i $INTERFACE > $ERRFILE 2>&1 &
-         sleep 5
-         grep "cannot join group" $ERRFILE
-         [ $? = 0 ] && end_testcase "MC group could NOT join $INTERFACE"
-      done
-
-      # See if the groups are joined
-
-      for agroup in `cat $GLIST`
-      do
-	 netstat -gn | grep $agroup
-         [ $? = 0 ] || end_testcase "$agroup NOT joined to $INTERFACE"
-
-         # See if they respond to a ping.
-	 #ping -c 3 -I $INTERFACE $agroup
-	 #[ $? != 0 ] && { echo "Error - $TC: $agroup NOT responding over $INTERFACE" ;}
-
-      done
-
-      echo "Waiting 60 seconds! Do not interrupt!"
-      sleep 60 # Make sure the first process has stopped
-
-      for agroup in `cat $GLIST`
-      do
-	netstat -gn | grep $agroup
-        if [ $? != 1 ]; then
-	   end_testcase "$agroup still joined on $INTERFACE"
-	fi
-      done
-
-      # Test the membership boundaries
-
-      echo "Running member on too many groups over $INTERFACE"
-      $TCsrc/$EXECUTABLES -j -g $TooManyGLIST -i $INTERFACE > $ERRFILE 2>&1 &
-
-      count=`grep 105 $ERRFILE | wc -l`
-
-      [ $count -gt 3 ] && end_testcase "Could not join members!"
-
-      COUNT=$(( $COUNT + 1 ))
-
-   done   # end of while numloop
+	echo "doing test."
+
+	COUNT=1
+	while [ $COUNT -le 2 ]
+	do
+		# Run setsockopt test with bogus network
+		get_address
+		echo "Running mc_member_e on $ADDRESS"
+		member -j -g $GLIST -s 30 -i $ADDRESS >/dev/null 2>&1
+
+		# Run setsockopt/getsockopt test
+		member -g $GLIST -s 80 -i $INTERFACE > $ERRFILE 2>&1 &
+
+		# Join twice and leave once and see if the groups are still
+		# joined on all specified interfaces.
+		for agroup in `cat $GLIST`
+		do
+			echo "Running (1st) member on $INTERFACE"
+			member -j -g $GLIST -s 30 -i $INTERFACE \
+			       > $ERRFILE 2>&1 &
+			sleep 5
+			grep "cannot join group" $ERRFILE
+			if [ $? -eq 0 ]; then
+				tst_brkm FAIL "MC group could NOT join "\
+					      "$INTERFACE"
+			fi
+
+			echo "Running (2nd) member on $INTERFACE"
+			member -g $GLIST -s 60 -i $INTERFACE > $ERRFILE 2>&1 &
+			sleep 5
+			grep "cannot join group" $ERRFILE
+			if [ $? -eq 0 ]; then
+				tst_brkm FAIL "MC group could NOT join "\
+					      "$INTERFACE"
+			fi
+		done
+
+		# See if the groups are joined
+		for agroup in `cat $GLIST`
+		do
+			netstat -gn | grep $agroup
+			if [ $? -ne 0 ]; then
+				tst_brkm FAIL "$agroup NOT joined to $INTERFACE"
+			fi
+		done
+
+		echo "Waiting 60 seconds! Do not interrupt!"
+		sleep 60 # Make sure the first process has stopped
+
+		for agroup in `cat $GLIST`
+		do
+			netstat -gn | grep $agroup
+			if [ $? -ne 1 ]; then
+				tst_brkm FAIL "$agroup still joined on "\
+					      "$INTERFACE"
+			fi
+		done
+
+		# Test the membership boundaries
+		echo "Running member on too many groups over $INTERFACE"
+		member -j -g $TooManyGLIST -i $INTERFACE > $ERRFILE 2>&1 &
+
+		count=`grep 105 $ERRFILE | wc -l`
+		if [ $count -gt 3 ]; then
+			tst_brkm FAIL "Could not join members!"
+		fi
+
+		COUNT=$(( $COUNT + 1 ))
+
+	done   # end of while numloop
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
 do_cleanup()
 {
-   $trace_logic
-   echo "$this_file: doing $0."
-
-   rm -rf $TCtmp
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
+	echo "doing cleanup."
+	rm -rf $TCtmp
 }
 
-#******************************************************************************
-#
-# FUNCTION:  MAIN
-# PURPOSE:   To invoke functions that perform the tasks as described in
-#            the design in the prolog above.
-# INPUT:     See SETUP in the prolog above.
-# OUTPUT:    Logged run results written to testcase run log
-#
-#******************************************************************************
 setup
+TST_CLEANUP=do_cleanup
+
 do_test
-end_testcase
+if [ $? -ne 0 ]; then
+	tst_resm TFAIL "Test Failed"
+else
+	tst_resm TPASS "Test Successful"
+fi
+
+tst_exit
diff --git a/testcases/network/multicast/mc_member/member.c b/testcases/network/multicast/mc_member/member.c
index 5b51dbe..810b786 100644
--- a/testcases/network/multicast/mc_member/member.c
+++ b/testcases/network/multicast/mc_member/member.c
@@ -9,17 +9,14 @@
 #include <netdb.h>
 #include <unistd.h>
 
-char *prog;
-int errors = 0;
-int ttl_no = 255;
+static char *prog;
+static int errors;
 
-int join_group(int, char *, struct ip_mreq *);
-int leave_group(int, char *, struct ip_mreq *);
-void usage(void);
+static int join_group(int, char *, struct ip_mreq *);
+static int leave_group(int, char *, struct ip_mreq *);
+static void usage(void);
 
-int main(argc, argv)
-int argc;
-char *argv[];
+int main(int argc, char *argv[])
 {
 	int s;
 	struct ip_mreq imr;
@@ -111,7 +108,7 @@ char *argv[];
 	return (0);
 }
 
-int join_group(int s, char *glist, struct ip_mreq *imr)
+static int join_group(int s, char *glist, struct ip_mreq *imr)
 {
 	char buf[40];
 	unsigned g1, g2, g3, g4;
@@ -145,7 +142,7 @@ int join_group(int s, char *glist, struct ip_mreq *imr)
 	return (0);
 }
 
-int leave_group(int s, char *glist, struct ip_mreq *imr)
+static int leave_group(int s, char *glist, struct ip_mreq *imr)
 {
 	char buf[40];
 	unsigned g1, g2, g3, g4;
@@ -178,7 +175,7 @@ int leave_group(int s, char *glist, struct ip_mreq *imr)
 	return (0);
 }
 
-void usage()
+static void usage(void)
 {
 	fprintf(stderr,
 		"usage: %s [ -j -l ] -g group_list [-s time_to_sleep] -i interface_name (or i.i.i.i)\n",
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
