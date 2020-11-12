From: Kory Maincent <kory.maincent@bootlin.com>
Date: Thu, 12 Nov 2020 15:56:36 +0100
Subject: [LTP] [PATCH] network/traceroute01: make it compatible with Busybox
Message-ID: <20201112145636.31091-1-kory.maincent@bootlin.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Busybox has not "-T" parameter, return TCONF in that case.

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 testcases/network/traceroute/traceroute01.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/network/traceroute/traceroute01.sh b/testcases/network/traceroute/traceroute01.sh
index 821853f0e..5b4a6d5a2 100755
--- a/testcases/network/traceroute/traceroute01.sh
+++ b/testcases/network/traceroute/traceroute01.sh
@@ -56,7 +56,11 @@ test1()
 test2()
 {
 	tst_res TINFO "run traceroute with TCP SYN"
-	run_trace -T
+	if traceroute -T 2>&1 | grep -q "invalid option"; then
+		tst_res TCONF "Wrong version of traceroute, traceroute from busybox can not use TCP SYN"
+	else
+		run_trace -T
+	fi
 }
 
 tst_run
-- 
2.17.1

