From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Mon, 27 Jun 2016 19:30:57 +0300
Subject: [LTP] [PATCH] network/busy_poll: make test results more stable
Message-ID: <1467045057-19618-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Changing tcp network load from 'connect/request/response/close'
to 'request/response'. Results will be more stable as we aren't
closing/establishing tcp connection after 3 requests from client.

There're other tests that do such stress testing so such test-case
won't be removed.

It'll also decrease test time by several times.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/busy_poll/busy_poll01.sh |    4 +++-
 testcases/network/busy_poll/busy_poll02.sh |    6 ++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/testcases/network/busy_poll/busy_poll01.sh b/testcases/network/busy_poll/busy_poll01.sh
index ecb34d7..ffa344b 100755
--- a/testcases/network/busy_poll/busy_poll01.sh
+++ b/testcases/network/busy_poll/busy_poll01.sh
@@ -21,9 +21,11 @@
 TST_TOTAL=1
 TCID="busy_poll01"
 
+# tst_netload() parameters
 clients_num=2
 client_requests=500000
-max_requests=3
+# num of requests after server closing connection
+max_requests=500000
 
 . test_net.sh
 
diff --git a/testcases/network/busy_poll/busy_poll02.sh b/testcases/network/busy_poll/busy_poll02.sh
index d4dd052..18dead5 100755
--- a/testcases/network/busy_poll/busy_poll02.sh
+++ b/testcases/network/busy_poll/busy_poll02.sh
@@ -21,6 +21,12 @@
 TST_TOTAL=1
 TCID="busy_poll02"
 
+# tst_netload() parameters
+clients_num=2
+client_requests=500000
+# num of requests after server closing connection
+max_requests=500000
+
 . test_net.sh
 
 cleanup()
-- 
1.7.1

