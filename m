From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Tue,  6 Jun 2017 14:21:56 +0300
Subject: [LTP] [COMMITTED][PATCH 1/6] lib/test_net.sh: add
	EXPECT_RHOST_PASS/FAIL functions
Message-ID: <1496748121-10782-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/test_net.sh |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/testcases/lib/test_net.sh b/testcases/lib/test_net.sh
index 753a061..9d6e6cb 100644
--- a/testcases/lib/test_net.sh
+++ b/testcases/lib/test_net.sh
@@ -113,6 +113,26 @@ tst_rhost_run()
 	return $ret
 }
 
+EXPECT_RHOST_PASS()
+{
+	tst_rhost_run -c "$*" > /dev/null
+	if [ $? -eq 0 ]; then
+		tst_resm TPASS "$* passed as expected"
+	else
+		tst_resm TFAIL "$* failed unexpectedly"
+	fi
+}
+
+EXPECT_RHOST_FAIL()
+{
+	tst_rhost_run -c "$* 2> /dev/null"
+	if [ $? -ne 0 ]; then
+		tst_resm TPASS "$* failed as expected"
+	else
+		tst_resm TFAIL "$* passed unexpectedly"
+	fi
+}
+
 # Get test interface names for local/remote host.
 # tst_get_ifaces [TYPE]
 # TYPE: { lhost | rhost }; Default value is 'lhost'.
-- 
1.7.1

