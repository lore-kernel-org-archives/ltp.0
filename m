From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 24 May 2017 15:08:01 +0300
Subject: [LTP] [COMMITTED][PATCH] rup01: fix test for hostname length > 24
Message-ID: <1495627681-30087-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

'rup' limits the length of host name in output:

  from rup.c:
  ...
  #define HOST_WIDTH 24
  ...
  printf("%-*.*s", HOST_WIDTH, HOST_WIDTH, host);

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/rpc/basic_tests/rup/rup01 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/network/rpc/basic_tests/rup/rup01 b/testcases/network/rpc/basic_tests/rup/rup01
index 99916d4..ed99040 100755
--- a/testcases/network/rpc/basic_tests/rup/rup01
+++ b/testcases/network/rpc/basic_tests/rup/rup01
@@ -94,7 +94,7 @@ echo "Test rusers with options set...please be patient"
 # Go through matrix of rup options:
 
 echo "rup $RHOST"
-rup $RHOST | grep $RHOST
+rup $RHOST
 [ $? -eq 0 ] || end_testcase "rup $RHOST - failed"
 
 echo "rup -d"
-- 
1.7.1

