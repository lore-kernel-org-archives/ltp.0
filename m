Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1YD1va-0006l7-KE
	for ltp-list@lists.sourceforge.net; Mon, 19 Jan 2015 02:18:54 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YD1vW-0004GX-Ec
	for ltp-list@lists.sourceforge.net; Mon, 19 Jan 2015 02:18:54 +0000
Received: from G08CNEXCHPEKD03.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id t0J2I2RP020949
	for <ltp-list@lists.sourceforge.net>; Mon, 19 Jan 2015 10:18:02 +0800
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Mon, 19 Jan 2015 10:17:48 +0800
Message-ID: <1421633868-14030-3-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1421633868-14030-1-git-send-email-zenglg.jy@cn.fujitsu.com>
References: <1421633868-14030-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v2 3/3] iptables_tests.sh: Cleanup
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
To: ltp-list@lists.sourceforge.net

* Use 'test.sh'.
* Use 'tst_*' which defined in 'test.sh'.
* Delete some useless comment.
* Delete 'RC' and 'TFAILCNT'.
* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 testcases/network/iptables/iptables_tests.sh | 675 +++++++++------------------
 1 file changed, 224 insertions(+), 451 deletions(-)

diff --git a/testcases/network/iptables/iptables_tests.sh b/testcases/network/iptables/iptables_tests.sh
index 77ee29b..66e98bd 100755
--- a/testcases/network/iptables/iptables_tests.sh
+++ b/testcases/network/iptables/iptables_tests.sh
@@ -14,576 +14,349 @@
 ## for more details.                                                          ##
 ##                                                                            ##
 ## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
+## along with this program;  if not, write to the Free Software Foundation,   ##
+## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
 ##                                                                            ##
 ################################################################################
-#
-# File :        iptables_tests.sh
-#
-# Description:  Test basic functionality of iptables (firewall administration)
-#		- Test #1:  iptables -L -t <table> will list all rules in the
-#		  selected table.
-#		- Test #2:  Test iptables DROP packets from particular IP.
-#		- Test #3:  Test iptables REJECT ping request.
-#		- Test #4:  Test iptables log packets to single port.
-#		- Test #5:  Test iptables log packets to multiple ports.
-#		- Test #6:  Test limit matched logging for ping request.
-#
-#
-# History:
-#		Jan 20 2004 Hubert Lin <linux02NOSPAAAM@tw.ibm.com or hubertNOSPAAAM@symbio.com.tw>
-#		  - Ported test01, test02 from Manoj Iyer's ipchains_tests.sh
-#		  - Added test03, test04, test05, test06
-#
-# Function:	init
-#
-# Description:	- Check if command iptables is available.
-# Description:	- Check if iptables kernel support is available.
-#               - Initialize environment variables.
-#
-# Return	- zero on success
-#               - non zero on failure. return value from commands ($RC)
-init()
-{
+#  Author:	Jan 20 2004 Hubert Lin <linux02NOSPAAAM@tw.ibm.com>
+#				       <hubertNOSPAAAM@symbio.com.tw>
 
-	export RC=0			# Return code from commands.
-	export TST_TOTAL=6		# total numner of tests in this file.
-	export TCID="iptables"		# Test case identifier
-	export TST_COUNT=0		# init identifier
-
-	if [ -z $TMP ]; then
-		LTPTMP=/tmp
-	else
-		LTPTMP=$TMP
-	fi
+export TCID="iptables"
+export TST_TOTAL=6
 
-	# Initialize cleanup function.
-	trap "cleanup" 0
+. test.sh
 
-	which tst_resm  > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_brkm TBROK \
-			"Test INIT: USCTEST commands not found, set PATH correctly."
-		return $RC
-	fi
+init()
+{
+	tst_tmpdir
 
 	tst_resm TINFO "INIT: Inititalizing tests."
-	which iptables > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_brk TBROK $LTPTMP/tst_iptables.out NULL \
-			"Test INIT: iptables command does not exist. Reason:"
-		return $RC
-	fi
 
-	modprobe ip_tables > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		RC=0
-		iptables -L > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-		if [ $RC -ne 0 ]; then
-			tst_brk TBROK $LTPTMP/tst_iptables.out NULL \
-				"Test INIT: no iptables support in kenrel. Reason:"
-			return $RC
+	modprobe ip_tables > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		iptables -L > tst_iptables.out 2>&1
+		if [ $? -ne 0 ]; then
+			tst_brkm TBROK "no iptables support in kenrel."
 		fi
 	fi
 
 	tst_resm TINFO "INIT: Flushing all rules."
-	iptables -F -t filter > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	iptables -F -t nat > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	iptables -F -t mangle > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	return $RC
+	iptables -F -t filter > tst_iptables.out 2>&1
+	iptables -F -t nat > tst_iptables.out 2>&1
+	iptables -F -t mangle > tst_iptables.out 2>&1
 }
 
-
-# Function:	cleanup
-#
-# Description	- remove temporary files and directories.
-#
-# Return	- zero on success
-#               - non zero on failure. return value from commands ($RC)
 cleanup()
 {
-	TCID=iptables
-	TST_COUNT=0
-	RC=0
-
-	lsmod | grep "ip_tables" > $LTPTMP/tst_iptables.out 2>&1 || RC=0
-	if [ $RC -eq 0 ]; then
-		iptables -F -t filter > $LTPTMP/tst_iptables.out 2>&1
-		iptables -F -t nat > $LTPTMP/tst_iptables.out 2>&1
-		iptables -F -t mangle > $LTPTMP/tst_iptables.out 2>&1
-		rmmod -v ipt_limit ipt_multiport ipt_LOG ipt_REJECT iptable_mangle iptable_nat ip_conntrack iptable_filter ip_tables > $LTPTMP/tst_iptables.out 2>&1
+	lsmod | grep "ip_tables" > tst_iptables.out 2>&1
+	if [ $? -eq 0 ]; then
+		iptables -F -t filter > tst_iptables.out 2>&1
+		iptables -F -t nat > tst_iptables.out 2>&1
+		iptables -F -t mangle > tst_iptables.out 2>&1
+		rmmod -v ipt_limit ipt_multiport ipt_LOG ipt_REJECT \
+			 iptable_mangle iptable_nat ip_conntrack \
+			 iptable_filter ip_tables > tst_iptables.out 2>&1
 	fi
-	rm -fr $LTPTMP/tst_iptables.*
-	return $RC
+	tst_rmdir
 }
 
-
-# Function:	test01
-#
-# Description	- Test basic functionality of iptables (firewall administration)
-#               - Test #1:  iptables -L -t <table> will list all rules in the
-#                 selected table.
-#
-# Return	- zero on success
-#               - non zero on failure. return value from commands ($RC)
-
 test01()
 {
-	RC=0			# Return value from commands.
-	TCID=iptables01		# Name of the test case.
-	TST_COUNT=1		# Test number.
-
-	local chaincnt=0	# chain counter
+	local chaincnt=0
 
 	local cmd="iptables -L -t filter"
-	tst_resm TINFO \
-		"$TCID: $cmd will list all rules in table filter."
-	$cmd > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_res TFAIL $LTPTMP/tst_iptables.out \
-			"$TCID: $cmd failed to list rules. Reason:"
-		return $RC
+	tst_resm TINFO "$cmd will list all rules in table filter."
+	$cmd > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "$cmd failed to list rules."
+		return
 	else
-		chaincnt=$(grep -c Chain $LTPTMP/tst_iptables.out)
+		chaincnt=$(grep -c Chain tst_iptables.out)
 		if [ $chaincnt -lt 3 ]; then
-			tst_res TFAIL $LTPTMP/tst_iptables.out \
-				"$TCID: $cmd failed to list rules. Reason:"
-			return $chaincnt
+			tst_resm TFAIL "$cmd failed to list rules."
+			return
 		else
-			tst_resm TINFO "$TCID: $cmd lists rules."
+			tst_resm TINFO "$cmd lists rules."
 		fi
 	fi
 
 	local cmd="iptables -L -t nat"
-	tst_resm TINFO \
-		"$TCID: $cmd will list all rules in table nat."
-	$cmd > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_res TFAIL $LTPTMP/tst_iptables.out \
-			"$TCID: $cmd failed to list rules. Reason:"
-		return $RC
+	tst_resm TINFO "$cmd will list all rules in table nat."
+	$cmd > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "$cmd failed to list rules."
+		return
 	else
-		chaincnt=$(grep -c Chain $LTPTMP/tst_iptables.out)
+		chaincnt=$(grep -c Chain tst_iptables.out)
 		if [ $chaincnt -ne 3 ] && [ $chaincnt -ne 4 ]; then
-			tst_res TFAIL $LTPTMP/tst_iptables.out \
-				"$TCID: $cmd failed to list rules. Reason:"
-			return $chaincnt
+			tst_resm TFAIL "$cmd failed to list rules."
+			return
 		else
-			tst_resm TINFO "$TCID: $cmd lists rules."
+			tst_resm TINFO "$cmd lists rules."
 		fi
 	fi
 
 	local cmd="iptables -L -t mangle"
-	tst_resm TINFO \
-		"$TCID: $cmd will list all rules in table mangle."
-	$cmd > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_res TFAIL $LTPTMP/tst_iptables.out \
-			"$TCID: $cmd failed to list rules. Reason:"
-		return $RC
+	tst_resm TINFO "$cmd will list all rules in table mangle."
+	$cmd > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "$cmd failed to list rules."
+		return
 	else
-		chaincnt=$(grep -c Chain $LTPTMP/tst_iptables.out)
+		chaincnt=$(grep -c Chain tst_iptables.out)
 		if [ $chaincnt -ne 5 ]; then
-			tst_res TFAIL $LTPTMP/tst_iptables.out \
-				"$TCID: $cmd failed to list rules. Reason:"
-			return $chaincnt
+			tst_resm TFAIL "$cmd failed to list rules."
 		else
-			tst_resm TINFO "$TCID: $cmd lists rules."
+			tst_resm TINFO "$cmd lists rules."
 		fi
 	fi
 
-	tst_resm TPASS "$TCID: iptables -L lists rules."
-	return $RC
+	tst_resm TPASS "iptables -L lists rules."
 }
 
-
-# Function:	test02
-#
-# Description	- Test basic functionality of iptables (firewall administration)
-#               - Test #2:  Test iptables DROP packets from particular IP.
-#               - Append new rule to block all packets from loopback.
-#				- ping -c 2 loopback, this should fail.
-#				- remove rule, and ping -c loopback, this should work.
-#
-# Return	- zero on success
-#               - non zero on failure. return value from commands ($RC)
 test02()
 {
-	RC=0			# Return value from commands.
-	TCID=iptables02		# Name of the test case.
-	TST_COUNT=2		# Test number.
-
-	tst_resm TINFO \
-		"$TCID: Use iptables to DROP packets from particular IP"
-	tst_resm TINFO "$TCID: Rule to block icmp from 127.0.0.1"
-
-	iptables -A INPUT -s 127.0.0.1 -p icmp -j DROP \
-		> $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_brk TBROK $LTPTMP/tst_iptables.out NULL \
-			"$TCID: iptables command failed to append new rule. Reason:"
-		return $RC
+	tst_resm TINFO "Use iptables to DROP packets from particular IP"
+	tst_resm TINFO "Rule to block icmp from 127.0.0.1"
+
+	iptables -A INPUT -s 127.0.0.1 -p icmp -j DROP > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "iptables command failed to append new rule."
+		return
 	fi
 
-	tst_resm TINFO "$TCID: Pinging 127.0.0.1"
-	ping -c 2 127.0.0.1 > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		RC=0
-		grep "100% packet loss" $LTPTMP/tst_iptables.out \
-			> $LTPTMP/tst_iptables.err 2>&1 || RC=$?
-		if [ $RC -ne 0 ]; then
-			tst_res TFAIL $LTPTMP/tst_iptables.out \
-				"$TCID: iptables did not block packets from loopback"
-			return $RC
+	tst_resm TINFO "Pinging 127.0.0.1"
+	ping -c 2 127.0.0.1 > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		grep "100% packet loss" tst_iptables.out > tst_iptables.err 2>&1
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL \
+				 "iptables did not block packets from loopback"
+			return
 		else
-			tst_resm TINFO "$TCID: Ping 127.0.0.1 not successful."
+			tst_resm TINFO "Ping 127.0.0.1 not successful."
 		fi
 	else
-		tst_res TFAIL $LTPTMP/tst_iptables.out \
-			"$TCID: iptables did not block icmp from 127.0.0.1"
-		return $RC
+		tst_resm TFAIL "iptables did not block icmp from 127.0.0.1"
+		return
 	fi
 
-	tst_resm TINFO "$TCID: Deleting icmp DROP from 127.0.0.1 rule."
-	iptables -D INPUT 1 > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_res TFAIL $LTPTMP/tst_iptables.out \
-			"$TCID: iptables did not remove the rule. Reason:"
-		return $RC
+	tst_resm TINFO "Deleting icmp DROP from 127.0.0.1 rule."
+	iptables -D INPUT 1 > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "iptables did not remove the rule."
+		return
 	fi
-	tst_resm TINFO "$TCID: Pinging 127.0.0.1 again"
-	ping -c 2 127.0.0.1 > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_res TFAIL $LTPTMP/tst_iptables.out \
-			"$TCID: iptables blocking loopback. This is expected behaviour on certain distributions where enabling firewall drops all packets by default."
-		return $RC
+	tst_resm TINFO "Pinging 127.0.0.1 again"
+	ping -c 2 127.0.0.1 > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "iptables blocking loopback. This is expected" \
+			       "behaviour on certain distributions where" \
+			       "enabling firewall drops all packets by default."
+		return
 	else
-		tst_resm TINFO "$TCID: Ping succsess"
-		tst_resm TPASS "$TCID: iptables can DROP packets from particular IP."
+		tst_resm TINFO "Ping succsess"
+		tst_resm TPASS "iptables can DROP packets from particular IP."
 	fi
-
-	return $RC
 }
 
-
-# Function:	test03
-#
-# Description	- Test basic functionality of iptables (firewall administration)
-#               - Test #3:  Test iptables REJECT ping request.
-#               - Append new rule to block all packets from loopback.
-#				- ping -c 2 loopback, this should fail.
-#				- remove rule, and ping -c loopback, this should work.
-#
-# Return	- zero on success
-#               - non zero on failure. return value from commands ($RC)
 test03()
 {
-	RC=0			# Return value from commands.
-	TCID=iptables03		# Name of the test case.
-	TST_COUNT=3		# Test number.
-
-	tst_resm TINFO \
-		"$TCID: Use iptables to REJECT ping request."
-	tst_resm TINFO "$TCID: Rule to reject ping request."
-
-	iptables -A INPUT -p icmp --icmp-type echo-request -d 127.0.0.1 -j REJECT \
-		> $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_brk TBROK $LTPTMP/tst_iptables.out NULL \
-			"$TCID: iptables command failed to append new rule. Reason:"
-		return $RC
+	tst_resm TINFO "Use iptables to REJECT ping request."
+	tst_resm TINFO "Rule to reject ping request."
+
+	iptables -A INPUT -p icmp --icmp-type echo-request -d 127.0.0.1 -j \
+		 REJECT > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "iptables command failed to append new rule."
+		return
 	fi
 
-	tst_resm TINFO "$TCID: Pinging 127.0.0.1"
-	ping -c 2 127.0.0.1 > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		RC=0
-		grep "100% packet loss" $LTPTMP/tst_iptables.out \
-			> $LTPTMP/tst_iptables.err 2>&1 || RC=$?
-		if [ $RC -ne 0 ]; then
-			tst_res TFAIL $LTPTMP/tst_iptables.out \
-				"$TCID: iptables did not block ping request."
-			return $RC
+	tst_resm TINFO "Pinging 127.0.0.1"
+	ping -c 2 127.0.0.1 > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		grep "100% packet loss" tst_iptables.out > tst_iptables.err 2>&1
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL "iptables did not block ping request."
+			return
 		else
-			tst_resm TINFO "$TCID: Ping 127.0.0.1 not successful."
+			tst_resm TINFO "Ping 127.0.0.1 not successful."
 		fi
 	else
-		tst_res TFAIL $LTPTMP/tst_iptables.out \
-			"$TCID: iptables did not reject ping request."
-		return $RC
+		tst_resm TFAIL "iptables did not reject ping request."
+		return
 	fi
 
-	tst_resm TINFO "$TCID: Deleting icmp request REJECT rule."
-	iptables -D INPUT 1 > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_res TFAIL $LTPTMP/tst_iptables.out \
-			"$TCID: iptables did not remove the rule. Reason:"
-		return $RC
+	tst_resm TINFO "Deleting icmp request REJECT rule."
+	iptables -D INPUT 1 > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "iptables did not remove the rule."
+		return
 	fi
-	tst_resm TINFO "$TCID: Pinging 127.0.0.1 again"
-	ping -c 2 127.0.0.1 > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_res TFAIL $LTPTMP/tst_iptables.out \
-			"$TCID: iptables blocking ping requests. This is expected behaviour on certain distributions where enabling firewall drops all packets by default."
-		return $RC
+	tst_resm TINFO "Pinging 127.0.0.1 again"
+	ping -c 2 127.0.0.1 > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "iptables blocking ping requests. This is" \
+			       "expected behaviour on certain distributions" \
+			       "where enabling firewall drops all packets by" \
+			       "default."
+		return
 	else
-		tst_resm TINFO "$TCID: Ping succsess"
-		tst_resm TPASS "$TCID: iptables can REJECT ping requests."
+		tst_resm TINFO "Ping succsess"
+		tst_resm TPASS "iptables can REJECT ping requests."
 	fi
-
-	return $RC
 }
 
-
-# Function:	test04
-#
-# Description	- Test basic functionality of iptables (firewall administration)
-#               - Test #4:  Test iptables log packets to single port
-#               - Append new rule to log tcp packets to localhost:45886
-#		- telnet localhost 45886, this should be logged.
-#		- remove rule.
-#
-# Return	- zero on success
-#               - non zero on failure. return value from commands ($RC)
 test04()
 {
-	RC=0			# Return value from commands.
-	TCID=iptables04		# Name of the test case.
-	TST_COUNT=4		# Test number.
-	local dport=45886				# destination port
-	local logprefix="$TCID-$(date +%m%d%H%M%S):"	# log-prefix used by iptables
-
-	tst_resm TINFO \
-		"$TCID: Use iptables to log packets to particular port."
-	tst_resm TINFO "$TCID: Rule to log tcp packets to particular port."
-
-	iptables -A INPUT -p tcp -d 127.0.0.1 --dport $dport -j LOG --log-prefix "$logprefix" \
-		> $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_brk TBROK $LTPTMP/tst_iptables.out NULL \
-			"$TCID: iptables command failed to append new rule. Reason:"
-		return $RC
+	local dport=45886
+	local logprefix="$TCID-$(date +%m%d%H%M%S):"
+
+	tst_resm TINFO "Use iptables to log packets to particular port."
+	tst_resm TINFO "Rule to log tcp packets to particular port."
+
+	iptables -A INPUT -p tcp -d 127.0.0.1 --dport $dport -j LOG \
+		 --log-prefix "$logprefix" > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "iptables command failed to append new rule."
+		return
 	fi
 
-	tst_resm TINFO "$TCID: telnet 127.0.0.1 $dport"
-	telnet 127.0.0.1 $dport > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		RC=0
+	tst_resm TINFO "telnet 127.0.0.1 $dport"
+	telnet 127.0.0.1 $dport > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
 		sleep 2
-		dmesg | grep "$logprefix" \
-			> $LTPTMP/tst_iptables.err 2>&1 || RC=$?
-		if [ $RC -ne 0 ]; then
-			tst_res TFAIL $LTPTMP/tst_iptables.out \
-				"$TCID: iptables did not log packets to port $dport"
-			return $RC
+		dmesg | grep "$logprefix" > tst_iptables.err 2>&1
+		if [ $? -ne 0 ]; then
+			tst_resm TFAIL \
+				 "iptables did not log packets to port $dport"
+			return
 		else
-			tst_resm TINFO "$TCID: Packets to port $dport logged."
+			tst_resm TINFO "Packets to port $dport logged."
 		fi
 	else
-		tst_res TFAIL $LTPTMP/tst_iptables.out \
-			"$TCID: telnet to 127.0.0.1 $dport should fail."
-		return $RC
+		tst_resm TFAIL "telnet to 127.0.0.1 $dport should fail."
+		return
 	fi
 
-	tst_resm TINFO "$TCID: Deleting the rule to log."
-	iptables -D INPUT 1 > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_res TFAIL $LTPTMP/tst_iptables.out \
-			"$TCID: iptables did not remove the rule. Reason:"
-		return $RC
+	tst_resm TINFO "Deleting the rule to log."
+	iptables -D INPUT 1 > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "iptables did not remove the rule."
+		return
 	else
-		tst_resm TINFO "$TCID: iptables logging succsess"
-		tst_resm TPASS "$TCID: iptables can log packets to particular port."
+		tst_resm TINFO "iptables logging succsess"
+		tst_resm TPASS "iptables can log packets to particular port."
 	fi
-
-	return $RC
 }
 
-
-# Function:	test05
-#
-# Description	- Test basic functionality of iptables (firewall administration)
-#               - Test #5:  Test iptables log packets to multiple ports
-#               - Append new rule to log tcp packets to localhost port 45801 - 45803
-#               - Append new rule to log tcp packets to localhost port 45804 - 45806 (ipt_multiport introduced)
-#		- telnet localhost port 45801 - 45806, this should be logged.
-#		- flush rules.
-#
-# Return	- zero on success
-#               - non zero on failure. return value from commands ($RC)
 test05()
 {
-	RC=0			# Return value from commands.
-	TCID=iptables05		# Name of the test case.
-	TST_COUNT=5		# Test number.
-	local dport=0					# destination port
-	local logprefix="$TCID-$(date +%m%d%H%M%S):"	# log-prefix used by iptables
-
-	tst_resm TINFO \
-		"$TCID: Use iptables to log packets to multiple ports."
-	tst_resm TINFO "$TCID: Rule to log tcp packets to port 45801 - 45803."
-	iptables -A INPUT -p tcp -d 127.0.0.1 --dport 45801:45803 -j LOG --log-prefix "$logprefix" \
-		> $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_brk TBROK $LTPTMP/tst_iptables.out NULL \
-			"$TCID: iptables command failed to append new rule. Reason:"
-		return $RC
+	local dport=0
+	local logprefix="$TCID-$(date +%m%d%H%M%S):"
+
+	tst_resm TINFO "Use iptables to log packets to multiple ports."
+	tst_resm TINFO "Rule to log tcp packets to port 45801 - 45803."
+	iptables -A INPUT -p tcp -d 127.0.0.1 --dport 45801:45803 -j LOG \
+		 --log-prefix "$logprefix" > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "iptables command failed to append new rule."
+		return
 	fi
 
-	tst_resm TINFO "$TCID: Rule to log tcp packets to port 45804 - 45806."
-	iptables -A INPUT -p tcp -d 127.0.0.1 -m multiport --dports 45804,45806,45805 -j LOG --log-prefix "$logprefix" \
-		> $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_brk TBROK $LTPTMP/tst_iptables.out NULL \
-			"$TCID: iptables command failed to append new rule. Reason:"
-		return $RC
+	tst_resm TINFO "Rule to log tcp packets to port 45804 - 45806."
+	iptables -A INPUT -p tcp -d 127.0.0.1 -m multiport --dports \
+		 45804,45806,45805 -j LOG --log-prefix "$logprefix" \
+		 > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "iptables command failed to append new rule."
+		return
 	fi
 
 	for dport in 45801 45802 45803 45804 45805 45806; do
-		tst_resm TINFO "$TCID: telnet 127.0.0.1 $dport"
-		telnet 127.0.0.1 $dport > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-		if [ $RC -ne 0 ]; then
-			RC=0
+		tst_resm TINFO "telnet 127.0.0.1 $dport"
+		telnet 127.0.0.1 $dport > tst_iptables.out 2>&1
+		if [ $? -ne 0 ]; then
 			sleep 2
 			dmesg | grep "$logprefix" | grep "=$dport " \
-				> $LTPTMP/tst_iptables.err 2>&1 || RC=$?
-			if [ $RC -ne 0 ]; then
-				tst_res TFAIL $LTPTMP/tst_iptables.out \
-					"$TCID: iptables did not log packets to port $dport"
-				return $RC
+				> tst_iptables.err 2>&1
+			if [ $? -ne 0 ]; then
+				tst_resm TFAIL "iptables did not log packets" \
+					       "to port $dport"
+				return
 			else
-				tst_resm TINFO "$TCID: Packets to port $dport logged."
+				tst_resm TINFO "Packets to port $dport logged."
 			fi
 		else
-			tst_res TFAIL $LTPTMP/tst_iptables.out \
-				"$TCID: telnet to 127.0.0.1 $dport should fail."
-			return $RC
+			tst_res TFAIL "telnet to 127.0.0.1 $dport should fail."
+			return
 		fi
 	done
 
-	tst_resm TINFO "$TCID: Flushing all rules."
-	iptables -F > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_res TFAIL $LTPTMP/tst_iptables.out \
-			"$TCID: iptables did not flush all rules. Reason:"
-		return $RC
+	tst_resm TINFO "Flushing all rules."
+	iptables -F > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "iptables did not flush all rules."
+		return
 	else
-		tst_resm TINFO "$TCID: iptables logging succsess"
-		tst_resm TPASS "$TCID: iptables can log packets to multiple ports."
+		tst_resm TINFO "iptables logging succsess"
+		tst_resm TPASS "iptables can log packets to multiple ports."
 	fi
-
-	return $RC
 }
 
-
-# Function:	test06
-#
-# Description	- Test basic functionality of iptables (firewall administration)
-#               - Test #6:  Test limit matched logging for ping request.
-#               - Append new rule to log ping request with rate of 3/hour, burst 5
-#		- ping localhost 10 times, only the first 5 will be logged.
-#		- remove rule.
-#
-# Return	- zero on success
-#               - non zero on failure. return value from commands ($RC)
 test06()
 {
-	RC=0			# Return value from commands.
-	TCID=iptables06		# Name of the test case.
-	TST_COUNT=6		# Test number.
-	local logcnt=0		# log counter
-	local logprefix="$TCID-$(date +%m%d%H%M%S):"	# log-prefix used by iptables
-
-	tst_resm TINFO \
-		"$TCID: Use iptables to log ping request with limited rate."
-	tst_resm TINFO "$TCID: Rule to log ping request."
-
-	iptables -A INPUT -p icmp --icmp-type echo-request -d 127.0.0.1 -m limit -j LOG --log-prefix "$logprefix" \
-		> $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_brk TBROK $LTPTMP/tst_iptables.out NULL \
-			"$TCID: iptables command failed to append new rule. Reason:"
-		return $RC
+	local logcnt=0
+	local logprefix="$TCID-$(date +%m%d%H%M%S):"
+
+	tst_resm TINFO "Use iptables to log ping request with limited rate."
+	tst_resm TINFO "Rule to log ping request."
+
+	iptables -A INPUT -p icmp --icmp-type echo-request -d 127.0.0.1 -m \
+		 limit -j LOG --log-prefix "$logprefix" > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "iptables command failed to append new rule."
+		return
 	fi
 
-	tst_resm TINFO "$TCID: ping 127.0.0.1"
-	ping -c 10 127.0.0.1 > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -eq 0 ]; then
-		RC=0
+	tst_resm TINFO "ping 127.0.0.1"
+	ping -c 10 127.0.0.1 > tst_iptables.out 2>&1
+	if [ $? -eq 0 ]; then
 		sleep 2
 		logcnt=$(dmesg | grep -c "$logprefix")
 		if [ $logcnt -ne 5 ]; then
-			tst_res TFAIL $LTPTMP/tst_iptables.out \
-				"$TCID: iptables did not log packets with limited rate."
-			return $logcnt
+			tst_resm TFAIL "iptables did not log packets with" \
+				       "limited rate."
+			return
 		else
-			tst_resm TINFO "$TCID: ping requests logged with limited rate."
+			tst_resm TINFO "ping requests logged with limited rate."
 		fi
 	else
-		tst_res TFAIL $LTPTMP/tst_iptables.out \
-			"$TCID: ping to 127.0.0.1 failed. This is expected behaviour on certain distributions where enabling firewall drops all packets by default."
-		return $RC
+		tst_resm TFAIL "ping to 127.0.0.1 failed. This is expected" \
+			       "behaviour on certain distributions where" \
+			       "enabling firewall drops all packets by default."
+		return
 	fi
 
-	tst_resm TINFO "$TCID: Deleting the rule to log."
-	iptables -D INPUT 1 > $LTPTMP/tst_iptables.out 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_res TFAIL $LTPTMP/tst_iptables.out \
-			"$TCID: iptables did not remove the rule. Reason:"
-		return $RC
+	tst_resm TINFO "Deleting the rule to log."
+	iptables -D INPUT 1 > tst_iptables.out 2>&1
+	if [ $? -ne 0 ]; then
+		tst_resm TFAIL "iptables did not remove the rule."
+		return
 	else
-		tst_resm TINFO "$TCID: iptables limited logging succsess"
-		tst_resm TPASS "$TCID: iptables can log packets with limited rate."
+		tst_resm TINFO "iptables limited logging succsess"
+		tst_resm TPASS "iptables can log packets with limited rate."
 	fi
-
-	return $RC
 }
 
-# Function:	main
-#
-# Description:	- Execute all tests, report results.
-#
-# Exit:		- zero on success
-# 		- non-zero on failure.
-TFAILCNT=0	# Set TFAILCNT to 0, increment on failure.
-RC=0		# Return code from test.
-
-init || exit $RC # Exit if initializing testcases fails.
-
-test01 || RC=$?
-if [ $RC -ne 0 ]; then
-	TFAILCNT=$(($TFAILCNT+1))
-fi
-
-RC=0		# Return code from test.
-test02 || RC=$?
-if [ $RC -ne 0 ]; then
-	TFAILCNT=$(($TFAILCNT+1))
-fi
-
-RC=0		# Return code from test.
-test03 || RC=$?
-if [ $RC -ne 0 ]; then
-	TFAILCNT=$(($TFAILCNT+1))
-fi
-
-RC=0		# Return code from test.
-test04 || RC=$?
-if [ $RC -ne 0 ]; then
-	TFAILCNT=$(($TFAILCNT+1))
-fi
-
-RC=0		# Return code from test.
-test05 || RC=$?
-if [ $RC -ne 0 ]; then
-	TFAILCNT=$(($TFAILCNT+1))
-fi
-
-RC=0		# Return code from test.
-test06 || RC=$?
-if [ $RC -ne 0 ]; then
-	TFAILCNT=$(($TFAILCNT+1))
-fi
-
-exit $TFAILCNT
+init
+TST_CLEANUP=cleanup
+
+test01
+test02
+test03
+test04
+test05
+test06
+
+tst_exit
-- 
1.9.3


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
