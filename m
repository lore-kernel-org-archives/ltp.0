From: =?unknown-8bit?q?Myl=C3=A8ne?= Josserand <mylene.josserand@bootlin.com>
Date: Fri, 13 Jul 2018 15:21:37 +0200
Subject: [LTP] [PATCH] testcases: cve-2016-7117: decrease the number of
	attempts
Message-ID: <20180713132137.22059-1-mylene.josserand@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

If the system is slow, it would take too much time to run the test.
Decrease the number of attempts to be able to run this test
in a reasonable time.

Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
---
Hello,

For this test, I tried it with a LTP_TIMEOUT_MUL variable equals to 10.
The test runs over 50min and still fails because of a timeout.
It is certainly because my system is slow so I thought we could reduce
the number of attempts.

Let me know if you have a better idea on how to implement that.

Thank you in advance,
Best regards,
Mylène

 testcases/cve/cve-2016-7117.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/cve/cve-2016-7117.c b/testcases/cve/cve-2016-7117.c
index 3cb7efcdf..9dabef90f 100644
--- a/testcases/cve/cve-2016-7117.c
+++ b/testcases/cve/cve-2016-7117.c
@@ -62,7 +62,7 @@
 
 #define MSG "abcdefghijklmnop"
 #define RECV_TIMEOUT 1
-#define ATTEMPTS 0x1FFFFF
+#define ATTEMPTS 0x1FFFF
 
 #ifndef HAVE_STRUCT_MMSGHDR
 struct mmsghdr {
-- 
2.11.0

