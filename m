From: Hangbin Liu <haliu@redhat.com>
Date: Fri, 29 Apr 2016 21:45:40 +0800
Subject: [LTP] [PATCH 2/2] network/xinetd: tst_xinetd.exp.2 want get both
	standard and error output
In-Reply-To: <1461937540-568-1-git-send-email-haliu@redhat.com>
References: <1461937540-568-1-git-send-email-haliu@redhat.com>
Message-ID: <1461937540-568-2-git-send-email-haliu@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

tst_xinetd.exp.2 want get both standard and error output, like
Trying 127.0.0.1...
Connected to 127.0.0.1.
Escape character is '^]'.
Connection closed by foreign host.

We will get nothing if use like 2>log 2>&1, fix this by use &>log.

Also fix a tst_retry typo.

Signed-off-by: Hangbin Liu <haliu@redhat.com>
---
 testcases/network/xinetd/xinetd_tests.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
index 58fb98e..0bf3bec 100755
--- a/testcases/network/xinetd/xinetd_tests.sh
+++ b/testcases/network/xinetd/xinetd_tests.sh
@@ -388,7 +388,7 @@ test01()
     # not terminated by the test gracefully.
     if [ $IPV6_ENABLED -eq 1 ]
     then
-        tst_retry "echo '' | $TELNET_COMM ::1 2>$LTPTMP/tst_xinetd.out.ipv6 2>&1"
+        tst_retry "echo '' | $TELNET_COMM ::1 &> $LTPTMP/tst_xinetd.out.ipv6"
         diff -iwB $LTPTMP/tst_xinetd.out.ipv6  $LTPTMP/tst_xinetd.exp.2.ipv6 \
             > $LTPTMP/tst_xinetd.err.ipv6 2>&1
         RC=$?
@@ -403,7 +403,7 @@ test01()
         fi
     fi
 
-    test_retry "echo '' | $TELNET_COMM 127.0.0.1 2>$LTPTMP/tst_xinetd.out 2>&1"
+    tst_retry "echo '' | $TELNET_COMM 127.0.0.1 &> $LTPTMP/tst_xinetd.out"
 
     diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.2 \
         > $LTPTMP/tst_xinetd.err 2>&1
-- 
2.5.5

