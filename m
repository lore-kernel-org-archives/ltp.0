From: sunlianwen <sunlw.fnst@cn.fujitsu.com>
Date: Mon, 19 Mar 2018 16:18:21 +0800
Subject: [LTP] [PATCH] busy_poll* : revise poll_cmp
Message-ID: <c999a175-d02b-beda-7418-95a5b0f2d432@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

set low latency busy poll to 50 per socket will
spent more time than set low latency busy poll
to 0 per socket. that mean the value of res_50
is bigger than res_0, so the value of poll_comp
always less than zero and  test fail.

Signed-off-by: Lianwen Sun <sunlw.fnst@cn.fujitsu.com>
---
  testcases/network/busy_poll/busy_poll01.sh | 2 +-
  testcases/network/busy_poll/busy_poll02.sh | 2 +-
  2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/busy_poll/busy_poll01.sh 
b/testcases/network/busy_poll/busy_poll01.sh
index 3c3035600..119ae0176 100755
--- a/testcases/network/busy_poll/busy_poll01.sh
+++ b/testcases/network/busy_poll/busy_poll01.sh
@@ -60,7 +60,7 @@ for x in 50 0; do
         tst_netload -H $(tst_ipaddr rhost) -d res_$x
  done

-poll_cmp=$(( 100 - ($(cat res_50) * 100) / $(cat res_0) ))
+poll_cmp=$(( 100 - ($(cat res_0) * 100) / $(cat res_50) ))

  if [ "$poll_cmp" -lt 1 ]; then
         tst_resm TFAIL "busy poll result is '$poll_cmp' %"
diff --git a/testcases/network/busy_poll/busy_poll02.sh 
b/testcases/network/busy_poll/busy_poll02.sh
index 427857996..05b5cf8c4 100755
--- a/testcases/network/busy_poll/busy_poll02.sh
+++ b/testcases/network/busy_poll/busy_poll02.sh
@@ -51,7 +51,7 @@ for x in 50 0; do
         tst_netload -H $(tst_ipaddr rhost) -d res_$x -b $x
  done

-poll_cmp=$(( 100 - ($(cat res_50) * 100) / $(cat res_0) ))
+poll_cmp=$(( 100 - ($(cat res_0) * 100) / $(cat res_50) ))

  if [ "$poll_cmp" -lt 1 ]; then
         tst_resm TFAIL "busy poll result is '$poll_cmp' %"
-- 
2.16.2




-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180319/4f9f0282/attachment.html>
