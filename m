Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1XO2QQ-0005aA-Pf
	for ltp-list@lists.sourceforge.net; Sun, 31 Aug 2014 10:31:58 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XO2QN-0004V8-W4
	for ltp-list@lists.sourceforge.net; Sun, 31 Aug 2014 10:31:58 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id s7VAVkLm013009
	for <ltp-list@lists.sourceforge.net>; Sun, 31 Aug 2014 18:31:46 +0800
Message-ID: <1409481004.6575.2.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Sun, 31 Aug 2014 18:30:04 +0800
In-Reply-To: <1409480940.6575.1.camel@G08JYZSD130126>
References: <1409480940.6575.1.camel@G08JYZSD130126>
MIME-Version: 1.0
Subject: [LTP] [PATCH 2/4] multicast/mc_commo: Some cleanup
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
 testcases/network/multicast/mc_commo/mc_commo  | 283 ++++++++++---------------
 testcases/network/multicast/mc_commo/mc_recv.c |   2 +-
 testcases/network/multicast/mc_commo/mc_send.c |   8 +-
 3 files changed, 118 insertions(+), 175 deletions(-)

diff --git a/testcases/network/multicast/mc_commo/mc_commo b/testcases/network/multicast/mc_commo/mc_commo
index 44e9f7f..88cf2ba 100755
--- a/testcases/network/multicast/mc_commo/mc_commo
+++ b/testcases/network/multicast/mc_commo/mc_commo
@@ -33,199 +33,144 @@ unset LIBPATH
 #        for SLES
 #
 #******************************************************************************
-#Uncomment line below for debug output.
-#trace_logic=${trace_logic:-"set -x"}
-$trace_logic
-
 
 TC=mc_commo
 TCtmp=${TCtmp:-"/tmp/mc_commo.$$"}
-CLEANUP=${CLEANUP:-ON}
-LTPROOT=${LTPROOT:-../../../..}
 TTL=10
 PORT=3333
 RHOST=${RHOST:-`hostname`}
 OUTFILE=$TCtmp/mc_commo_out
-NUMLOOPS=${NUMLOOPS:-2}
-INTERFACE=${INTERFACE:-$(mc_gethost `hostname` | grep addresses: | awk '{print $2}')}
+INTERFACE=${INTERFACE:-$(mc_gethost `hostname` | grep addresses: | \
+			 awk '{print $2}')}
 
 export TCID=$TC
 export TST_TOTAL=1
 export TST_COUNT=1
 
-this_file=${0##*/}
-trap "interrupt_test" 2
+. test.sh
 
-do_setup() {
-  mkdir -p $TCtmp
-  OCTET=`ps -ewf | grep [m]c_commo | wc -l | awk '{print $1}'`
-  GROUP_ADDR=224.0.0.$OCTET
+do_setup()
+{
+	mkdir -p $TCtmp
+	OCTET=`ps -ewf | grep [m]c_commo | wc -l | awk '{print $1}'`
+	GROUP_ADDR=224.0.0.$OCTET
 }
 
-#*******************************************************************************
-#
-# FUNCTION:  do_test
-# PURPOSE:   Executes the testcases.
-# INPUT:     Number of iterations
-# OUTPUT:    Error messages are logged when any verification test
-#            fails.
-#
-#-----------------------------------------------------------------------
-
 do_test ()
 {
-   $trace_logic
-   echo "$this_file: doing $0."
-
-
-
-   COUNT=1
-   while [ $COUNT -le $NUMLOOPS ]
-   do
-
-      # Run setsockopt/getsockopt test
-      # Start up the recv on local host
-      echo "Starting mc_recv on $GROUP_ADDR $INTERFACE $PORT"
-
-      mc_recv $GROUP_ADDR $INTERFACE $PORT \
-	>> $OUTFILE &
-      SERVER_PID=$!
-      sleep 5
-      ps -ewf | grep mc_recv | grep -v grep
-      [ $? = 0 ] || end_testcase "Could NOT start mc_recv on `hostname`"
-
-      grep -q "cannot join group" $OUTFILE
-      [ $? = 0 ] && end_testcase "Membership NOT set"
-
-      netstat -ng | grep -q $GROUP_ADDR
-      [ $? = 0 ] || end_testcase "membership not set for $GROUP_ADDR"
-
-# This eliminates the ping test but does not compromise the execution of the
-# test
-
-#      distro_version=""
-#      distro_name=""
-#      distro_version=`cat /etc/issue | awk {'print $7'}`
-#      distro_name=`cat /etc/issue | awk {'print $3'}`
-
-#       if [ $distro_version -ge 9 -a $distro_name = SUSE ]; then
-#          echo "Ping test skipped"
-#       else
-#           echo "Running ping to verify group can be reached "
-#           ping -c5 -I $INTERFACE $GROUP_ADDR > /dev/null
-#        [ $? = 0 ] || end_testcase "failed: ping -c5 -I $INTERFACE $GROUP_ADDR"
-#       fi
-
-
-      # Flood the interface in an attempt to overload the sends and
-      # recvs to and from the host.
-      #ping -f -s 4800 -I $INTERFACE $GROUP_ADDR >$TCtmp/pingfile  2>&1 &
-      #PING_PID=$!
-      #sleep 2
-      #kill -9 $PING_PID >/dev/null 2>&1
-      #cat $TCtmp/pingfile | grep "Message too long"
-      #[ $? = 0 ] || end_testcase "ping -f -s 4088 -c 1000 -I $INTERFACE $GROUP_ADDR should return an error regarding message being too long"
-
-      for HOST in $RHOST
-      do
-         echo "Running on $HOST mc_send $GROUP_ADDR $HOST $PORT $TTL"
-
-         rsh -n -l root $HOST "$LTPROOT/testcases/bin/mc_send" $GROUP_ADDR \
-	 $HOST $PORT $TTL >/dev/null &
-         sleep 10
-	rsh -n -l root $HOST "ps -ewf | grep mc_send | grep -v grep"
-          [ $? = 0 ] || end_testcase "Could NOT start mc_send on $HOST"
-      done
-
-      echo "Waiting for 100 sec.! Do not interrupt."
-      sleep 100  #wait until datagrams are received in $STATUS
-      COUNT=$(( $COUNT + 1 ))
-   done
-
-   #test if datagrams has been sent
-   for HOST in $RHOST
-   do
-      grep -q "$HOST [0-9] [0-9]" $OUTFILE
-      [ $? = 0 ] || end_testcase "NO Datagrams received from $HOST"
-   done
+	echo "doing test."
+
+	COUNT=1
+	while [ $COUNT -le 2 ]
+	do
+
+		# Run setsockopt/getsockopt test
+		# Start up the recv on local host
+		echo "Starting mc_recv on $GROUP_ADDR $INTERFACE $PORT"
+
+		mc_recv $GROUP_ADDR $INTERFACE $PORT >> $OUTFILE &
+		SERVER_PID=$!
+		sleep 5
+		ps -ewf | grep mc_recv | grep -v grep
+		if [ $? -ne 0 ]; then
+			tst_brkm TFAIL "Could NOT start mc_recv on `hostname`"
+		fi
+
+		grep -q "cannot join group" $OUTFILE
+		if [ $? -eq 0 ]; then
+			tst_brkm TFAIL "Membership NOT set"
+		fi
+
+		netstat -ng | grep -q $GROUP_ADDR
+		if [ $? -ne 0 ]; then
+			tst_brkm TFAIL "membership not set for $GROUP_ADDR"
+		fi
+
+		# This eliminates the ping test but does not compromise the
+		# execution of the test
+
+		#distro_version=""
+		#distro_name=""
+		#distro_version=`cat /etc/issue | awk {'print $7'}`
+		#distro_name=`cat /etc/issue | awk {'print $3'}`
+
+		#if [ $distro_version -ge 9 -a $distro_name = SUSE ]; then
+		#	echo "Ping test skipped"
+		#else
+		#	echo "Running ping to verify group can be reached "
+		#	ping -c5 -I $INTERFACE $GROUP_ADDR > /dev/null
+		#	if [ $? -ne 0 ]; then
+		#		tst_brkm TFAIL "failed: ping -c5 -I "\
+		#			       "$INTERFACE $GROUP_ADDR"
+		#	fi
+		#fi
+
+		# Flood the interface in an attempt to overload the sends and
+		# recvs to and from the host.
+		#ping -f -s 4800 -I $INTERFACE $GROUP_ADDR \
+		#     > $TCtmp/pingfile 2>&1 &
+		#PING_PID=$!
+		#sleep 2
+		#kill -9 $PING_PID >/dev/null 2>&1
+		#cat $TCtmp/pingfile | grep "Message too long"
+		#if [ $? -ne 0 ]; then
+		#	tst_brkm TFAIL "ping -f -s 4088 -c 1000 -I $INTERFACE "\
+		#		 "$GROUP_ADDR should return an error "\
+		#		 "regarding message being too long"
+		#fi
+
+		for HOST in $RHOST
+		do
+			echo "Running on $HOST mc_send $GROUP_ADDR $HOST "\
+			     "$PORT $TTL"
+
+			rsh -n -l root $HOST "$LTPROOT/testcases/bin/mc_send" \
+			    $GROUP_ADDR $HOST $PORT $TTL >/dev/null &
+			sleep 10
+			rsh -n -l root $HOST "ps -ewf | grep mc_send | "\
+			    "grep -v grep"
+			if [ $? -ne 0 ]; then
+				tst_brkm TFAIL "Could NOT start mc_send on "\
+					 "$HOST"
+			fi
+		done
+
+		echo "Waiting for 100 sec.! Do not interrupt."
+		sleep 100  #wait until datagrams are received in $STATUS
+		COUNT=$(( $COUNT + 1 ))
+	done
+
+	#test if datagrams has been sent
+	for HOST in $RHOST
+	do
+		grep -q "$HOST [0-9] [0-9]" $OUTFILE
+		if [ $? -ne 0 ]; then
+			tst_brkm TFAIL "NO Datagrams received from $HOST"
+		fi
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
 do_cleanup()
 {
-   $trace_logic
-   echo "$this_file: doing $0."
-
-   # Kill all recv processes
-   echo "Killing all recv processes!!"
-   kill -9 $SERVER_PID
-
-   #PIDLIST=`ps -ef |grep "ping -f -s 4800" |awk '{print $2}'`
-   #for PID in $PIDLIST
-   #do
-   #   kill -9 $PID > /dev/null 2>>/dev/null
-   #done
-   rm -rf $TCtmp/pingfile
-   rm -rf $TCtmp/mc_commo_out
-   rm -rf $TCtmp
-}
+	echo "doing cleanup."
 
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
+	# Kill all recv processes
+	echo "Killing all recv processes!!"
+	kill -9 $SERVER_PID
 
-   # Call other cleanup functions
-   [ $CLEANUP = "ON" ] && do_cleanup
-
-   [ $# = 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
-   tst_resm TFAIL "Test Failed: $@"
-   exit 1
-}
-
-#*****************************************************************************
-#
-# FUNCTION:  interrupt_test
-# PURPOSE:   Handle process interrupts set by trap.
-# INPUT:     none
-# OUTPUT:    none
-#
-#*****************************************************************************
-
-interrupt_test()
-{
-   echo "test interrupted"
-   end_testcase
+	rm -rf $TCtmp/pingfile
+	rm -rf $TCtmp/mc_commo_out
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
 do_setup
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
diff --git a/testcases/network/multicast/mc_commo/mc_recv.c b/testcases/network/multicast/mc_commo/mc_recv.c
index 43768f2..bb25a3d 100644
--- a/testcases/network/multicast/mc_commo/mc_recv.c
+++ b/testcases/network/multicast/mc_commo/mc_recv.c
@@ -11,7 +11,7 @@
 
 #define	MAXBUFSIZ	8096
 
-char buf[MAXBUFSIZ];
+static char buf[MAXBUFSIZ];
 
 int main(int argc, char *argv[])
 {
diff --git a/testcases/network/multicast/mc_commo/mc_send.c b/testcases/network/multicast/mc_commo/mc_send.c
index 6bc5fbf..df9a263 100644
--- a/testcases/network/multicast/mc_commo/mc_send.c
+++ b/testcases/network/multicast/mc_commo/mc_send.c
@@ -12,12 +12,10 @@
 
 #define	MAXBUFSIZ	8096
 
-char buf[MAXBUFSIZ];
-int Num_Loops = 100;
+static char buf[MAXBUFSIZ];
+static int Num_Loops = 100;
 
-int main(argc, argv)
-int argc;
-char *argv[];
+int main(int argc, char *argv[])
 {
 	struct ip_mreq imr;
 	struct sockaddr_in sin, mcast_out;
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
