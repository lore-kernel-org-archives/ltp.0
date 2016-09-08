From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  8 Sep 2016 10:34:17 +0300
Subject: [LTP] [PATCH 2/3] network/ping01: use ROD_SILENT and report test
	result
In-Reply-To: <1473320058-13205-1-git-send-email-alexey.kodanev@oracle.com>
References: <1473320058-13205-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1473320058-13205-2-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/tcp_cmds/ping/ping01.sh |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/testcases/network/tcp_cmds/ping/ping01.sh b/testcases/network/tcp_cmds/ping/ping01.sh
index e188c3a..5dd3369 100755
--- a/testcases/network/tcp_cmds/ping/ping01.sh
+++ b/testcases/network/tcp_cmds/ping/ping01.sh
@@ -1,5 +1,5 @@
 #! /bin/sh
-# Copyright (c) 2014 Oracle and/or its affiliates. All Rights Reserved.
+# Copyright (c) 2014-2016 Oracle and/or its affiliates. All Rights Reserved.
 # Copyright (c) International Business Machines  Corp., 2000
 #
 # This program is free software; you can redistribute it and/or
@@ -13,8 +13,7 @@
 # GNU General Public License for more details.
 #
 # You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+# along with this program. If not, see <http://www.gnu.org/licenses/>.
 #
 #  PURPOSE: To test the basic functionality of the `ping` command.
 #
@@ -47,12 +46,10 @@ do_test()
 	local ipaddr=$(tst_ipaddr rhost)
 	for packetsize in $PACKETSIZES; do
 		tst_resm TINFO "call $PING_CMD with packet size = $packetsize"
-		$PING_CMD -c $COUNT -s $packetsize $ipaddr > /dev/null 2>&1
-		if [ $? -ne 0 ]; then
-			tst_resm TFAIL "$PING_CMD -c $COUNT -s $packetsize $ipaddr"
-			return
-		fi
+		ROD_SILENT $PING_CMD -c $COUNT -s $packetsize $ipaddr
 	done
+
+	tst_resm TPASS "$PING_CMD test completed"
 }
 
 do_setup
-- 
1.7.1

