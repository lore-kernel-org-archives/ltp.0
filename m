From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 30 Sep 2015 16:09:24 +0300
Subject: [LTP] [PATCH 06/10] network/nfs/nfs_stress: rename library
	functions names
In-Reply-To: <1443618568-29200-1-git-send-email-alexey.kodanev@oracle.com>
References: <1443618568-29200-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1443618568-29200-6-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

setup_testcase -> nfs_setup
cleanup -> nfs_cleanup

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/nfs/nfs_stress/nfs01      |    4 ++--
 testcases/network/nfs/nfs_stress/nfs02      |    4 ++--
 testcases/network/nfs/nfs_stress/nfs_lib.sh |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs01 b/testcases/network/nfs/nfs_stress/nfs01
index 986855e..0f6877e 100755
--- a/testcases/network/nfs/nfs_stress/nfs01
+++ b/testcases/network/nfs/nfs_stress/nfs01
@@ -22,7 +22,7 @@
 
 TCID="nfs01"
 TST_TOTAL=1
-TST_CLEANUP="cleanup"
+TST_CLEANUP="nfs_cleanup"
 
 . nfs_lib.sh
 . test_net.sh
@@ -37,7 +37,7 @@ do_test()
 	tst_resm TPASS "test finished successfully"
 }
 
-setup_testcase
+nfs_setup
 do_test
 
 tst_exit
diff --git a/testcases/network/nfs/nfs_stress/nfs02 b/testcases/network/nfs/nfs_stress/nfs02
index a600034..a73e958 100755
--- a/testcases/network/nfs/nfs_stress/nfs02
+++ b/testcases/network/nfs/nfs_stress/nfs02
@@ -22,7 +22,7 @@
 
 TCID="nfs02"
 TST_TOTAL=3
-TST_CLEANUP="cleanup"
+TST_CLEANUP="nfs_cleanup"
 
 . nfs_lib.sh
 . test_net.sh
@@ -63,7 +63,7 @@ do_test3()
 
 LTP_DATAFILES="$LTPROOT/testcases/bin/datafiles"
 
-setup_testcase
+nfs_setup
 
 do_test1
 do_test2
diff --git a/testcases/network/nfs/nfs_stress/nfs_lib.sh b/testcases/network/nfs/nfs_stress/nfs_lib.sh
index 7867b17..193f8c8 100644
--- a/testcases/network/nfs/nfs_stress/nfs_lib.sh
+++ b/testcases/network/nfs/nfs_stress/nfs_lib.sh
@@ -14,7 +14,7 @@
 # You should have received a copy of the GNU General Public License
 # along with this program. If not, see <http://www.gnu.org/licenses/>.
 
-setup_testcase()
+nfs_setup()
 {
 	VERSION=${VERSION:=3}
 	NFILES=${NFILES:=1000}
@@ -59,7 +59,7 @@ setup_testcase()
 	ROD mount -t $NFS_TYPE $OPTS $REMOTE_DIR $TST_TMPDIR
 }
 
-cleanup()
+nfs_cleanup()
 {
 	tst_resm TINFO "Cleaning up testcase"
 	cd $LTPROOT
-- 
1.7.1

