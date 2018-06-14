From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu, 14 Jun 2018 19:04:54 +0300
Subject: [LTP] [PATCH 1/4] network/busy_poll: use smaller packets and a
	single thread
Message-ID: <1528992297-23920-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This should make the results more stable for better performance
comparison with/without busy polling.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---

Tested on ixgbe NIC

 testcases/network/busy_poll/busy_poll01.sh   |    2 +-
 testcases/network/busy_poll/busy_poll02.sh   |    2 +-
 testcases/network/busy_poll/busy_poll03.sh   |    3 ++-
 testcases/network/busy_poll/busy_poll_lib.sh |    3 +++
 4 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/testcases/network/busy_poll/busy_poll01.sh b/testcases/network/busy_poll/busy_poll01.sh
index 12d3cb5..a9c8cbd 100755
--- a/testcases/network/busy_poll/busy_poll01.sh
+++ b/testcases/network/busy_poll/busy_poll01.sh
@@ -58,7 +58,7 @@ trap "tst_brkm TBROK 'test interrupted'" INT
 for x in 50 0; do
 	tst_resm TINFO "set low latency busy poll to $x"
 	set_busy_poll $x
-	tst_netload -H $(tst_ipaddr rhost) -d res_$x
+	tst_netload -H $(tst_ipaddr rhost) -n 10 -N 10 -d res_$x
 done
 
 poll_cmp=$(( 100 - ($(cat res_50) * 100) / $(cat res_0) ))
diff --git a/testcases/network/busy_poll/busy_poll02.sh b/testcases/network/busy_poll/busy_poll02.sh
index 4873dc3..95eeee3 100755
--- a/testcases/network/busy_poll/busy_poll02.sh
+++ b/testcases/network/busy_poll/busy_poll02.sh
@@ -49,7 +49,7 @@ trap "tst_brkm TBROK 'test interrupted'" INT
 for x in 50 0; do
 	tst_resm TINFO "set low latency busy poll to $x per socket"
 	set_busy_poll $x
-	tst_netload -H $(tst_ipaddr rhost) -d res_$x -b $x
+	tst_netload -H $(tst_ipaddr rhost) -n 10 -N 10 -d res_$x -b $x
 done
 
 poll_cmp=$(( 100 - ($(cat res_50) * 100) / $(cat res_0) ))
diff --git a/testcases/network/busy_poll/busy_poll03.sh b/testcases/network/busy_poll/busy_poll03.sh
index 0144465..699bee2 100755
--- a/testcases/network/busy_poll/busy_poll03.sh
+++ b/testcases/network/busy_poll/busy_poll03.sh
@@ -51,7 +51,8 @@ do_test()
 	for x in 50 0; do
 		tst_resm TINFO "set low latency busy poll to $x per $1 socket"
 		set_busy_poll $x
-		tst_netload -H $(tst_ipaddr rhost) -d res_$x -b $x -T $1
+		tst_netload -H $(tst_ipaddr rhost) -n 10 -N 10 -d res_$x \
+			    -b $x -T $1
 	done
 
 	poll_cmp=$(( 100 - ($(cat res_50) * 100) / $(cat res_0) ))
diff --git a/testcases/network/busy_poll/busy_poll_lib.sh b/testcases/network/busy_poll/busy_poll_lib.sh
index a00c74d..271c01b 100755
--- a/testcases/network/busy_poll/busy_poll_lib.sh
+++ b/testcases/network/busy_poll/busy_poll_lib.sh
@@ -14,6 +14,9 @@
 # You should have received a copy of the GNU General Public License
 # along with this program. If not, see <http://www.gnu.org/licenses/>.
 
+# for more stable results set to a single thread
+TST_NETLOAD_CLN_NUMBER=1
+
 if tst_kvcmp -lt "3.11"; then
 	tst_brkm TCONF "test must be run with kernel 3.11 or newer"
 fi
-- 
1.7.1

