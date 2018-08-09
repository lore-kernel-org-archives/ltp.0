From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Thu,  9 Aug 2018 18:23:45 +0300
Subject: [LTP] [PATCH RFC 3/4] lib/tst_test.sh: add TST_RTNL_CHK() helper
	function
In-Reply-To: <1533828226-24753-1-git-send-email-alexey.kodanev@oracle.com>
References: <1533828226-24753-1-git-send-email-alexey.kodanev@oracle.com>
Message-ID: <1533828226-24753-3-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It should parse iproute commands output and exit the test with TCONF
if there are certain messages returned from iproute/RTNETLINK.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/tst_test.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 30f75b5..73dcdfb 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -202,6 +202,22 @@ TST_RETRY_FUNC()
 	return $2
 }
 
+TST_RTNL_CHK()
+{
+	local msg1="RTNETLINK answers: Function not implemented"
+	local msg2="RTNETLINK answers: Operation not supported"
+	local output="$($@ 2>&1 || echo 'LTP_ERR')"
+	local msg
+
+	echo "$output" | grep -q "LTP_ERR" || return 0
+
+	for msg in "$msg1" "$msg2"; do
+		echo "$output" | grep -q "$msg" && tst_brk TCONF "'$@': $msg"
+	done
+
+	tst_brk TBROK "$@ failed: $output"
+}
+
 tst_umount()
 {
 	local device="$1"
-- 
1.7.1

