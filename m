Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1XqLbS-0005T5-VV
	for ltp-list@lists.sourceforge.net; Mon, 17 Nov 2014 12:40:23 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XqLbR-0003mR-Jm
	for ltp-list@lists.sourceforge.net; Mon, 17 Nov 2014 12:40:22 +0000
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (localhost.localdomain
	[127.0.0.1])
	by edo.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id sAHCdtdL022830
	for <ltp-list@lists.sourceforge.net>; Mon, 17 Nov 2014 20:39:55 +0800
Message-ID: <1416227892.10929.1.camel@G08JYZSD130126.localdomain>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Mon, 17 Nov 2014 20:38:12 +0800
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/5] ima_setup.sh: Some cleanup
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

* Use 'test.sh'.

* Use 'test_brkm' instead of 'tst_resm TBROK'.

* Use 'tst_tmpdir' and 'tst_rmdir'.

* Delete some unuseful comments.

* Some cleanup.

Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
---
 .../security/integrity/ima/tests/ima_setup.sh      | 85 +++-------------------
 1 file changed, 12 insertions(+), 73 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 4013e1f..0ff38d2 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -14,8 +14,8 @@
 ## for more details.                                                          ##
 ##                                                                            ##
 ## You should have received a copy of the GNU General Public License          ##
-## along with this program;  if not, write to the Free Software               ##
-## Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA    ##
+## along with this program;  if not, write to the Free Software Foundation,   ##
+## Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA           ##
 ##                                                                            ##
 ################################################################################
 #
@@ -24,13 +24,10 @@
 # Description:  setup/cleanup routines for the integrity tests.
 #
 # Author:       Mimi Zohar, zohar@ibm.vnet.ibm.com
-#
-# Return        - zero on success
-#               - non zero on failure. return value from commands ($RC)
 ################################################################################
+. test.sh
 mount_sysfs()
 {
-
 	SYSFS=$(mount 2>/dev/null | awk '$5 == "sysfs" { print $3 }')
 	if [ "x$SYSFS" = x ] ; then
 
@@ -38,22 +35,17 @@ mount_sysfs()
 
 		test -d $SYSFS || mkdir -p $SYSFS 2>/dev/null
 		if [ $? -ne 0 ] ; then
-			tst_resm TBROK "Failed to mkdir $SYSFS"
-			return 1
+			tst_brkm TBROK "Failed to mkdir $SYSFS"
 		fi
 		if ! mount -t sysfs sysfs $SYSFS 2>/dev/null ; then
-			tst_resm TBROK "Failed to mount $SYSFS"
-			return 1
+			tst_brkm TBROK "Failed to mount $SYSFS"
 		fi
 
 	fi
-
-	return 0
 }
 
 mount_securityfs()
 {
-
 	SECURITYFS=$(mount 2>/dev/null | awk '$5 == "securityfs" { print $3 }')
 	if [ "x$SECURITYFS" = x ] ; then
 
@@ -61,87 +53,34 @@ mount_securityfs()
 
 		test -d $SECURITYFS || mkdir -p $SECURITYFS 2>/dev/null
 		if [ $? -ne 0 ] ; then
-			tst_resm TBROK "Failed to mkdir $SECURITYFS"
-			return 1
+			tst_brkm TBROK "Failed to mkdir $SECURITYFS"
 		fi
 		if ! mount -t securityfs securityfs $SECURITYFS 2>/dev/null ; then
-			tst_resm TBROK "Failed to mount $SECURITYFS"
-			return 1
+			tst_brkm TBROK "Failed to mount $SECURITYFS"
 		fi
 
 	fi
-
-	return 0
-
 }
 
 setup()
 {
-	export TST_TOTAL=1
-	export TCID="setup"
-        export TST_COUNT=0
-
-	LTPBIN=
-	LTPIMA=
-
-	trap "cleanup" 0
-	if [ -z "$TMPDIR" ]; then
-		LTPTMP=/tmp
-	else
-		LTPTMP=${TMPDIR}
-	fi
-	if [ -z "$LTPBIN" ]; then
-		LTPBIN=../../../../../bin
-		PATH=$PATH:$LTPBIN
-	fi
-
 	tst_require_root
 
-	# create the temporary directory used by this testcase
-	LTPIMA=$LTPTMP/ima
-	umask 077
-	mkdir $LTPIMA > /dev/null 2>&1 || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_resm TBROK "Unable to create temporary directory"
-		return $RC
-	fi
+	tst_tmpdir
 
-	# mount sysfs if it is not already mounted
-	mount_sysfs || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_resm TBROK "Cannot mount sysfs"
-		return $RC
-	fi
+	mount_sysfs
 
 	# mount securityfs if it is not already mounted
-	mount_securityfs || RC=$?
-	if [ $RC -ne 0 ]; then
-		tst_resm TBROK "Cannot mount securityfs"
-		return $RC
-	fi
-
-	mount
+	mount_securityfs
 
 	# IMA must be configured in the kernel
 	IMA_DIR=$SECURITYFS/ima
 	if [ ! -d "$IMA_DIR" ]; then
-		tst_resm TCONF "IMA not enabled in kernel"
-		RC=1
+		tst_brkm TCONF "IMA not enabled in kernel"
 	fi
-	return $RC
 }
 
-# Function:     cleanup
-#
-# Description   - remove temporary files and directories.
-#
-# Return        - zero on success
-#               - non zero on failure. return value from commands ($RC)
 cleanup()
 {
-	tst_resm TINFO "CLEAN: removing $LTPIMA"
-	rm -rf "$LTPIMA" || RC=$?
-	return $RC
+	tst_rmdir
 }
-
-. cmdlib.sh
-- 
1.8.3.1




------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
