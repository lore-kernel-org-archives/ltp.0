From: sunlianwen <sunlw.fnst@cn.fujitsu.com>
Date: Sun, 25 Feb 2018 10:13:59 +0800
Subject: [LTP] [PATCH] interface/if4-addr-change : NS_TIMES is not set value
Message-ID: <ae70bdfa-4129-a521-edd5-f3d1707fe018@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

$NS_TIMES is not set value which lead  run if4-addr-chage to failure.
failure message as below:
--------------------------------------------------------------------------------------------
/opt/ltp/testcases/bin/if4-addr-change: line 24: / 20: syntax error: 
operand expected (error token is "/ 20")
--------------------------------------------------------------------------------------------
Signed-off-by:  Lianwen Sun  <sunlw.fnst@cn.fujitsu.com>
---
  testcases/network/stress/interface/if4-addr-change | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/stress/interface/if4-addr-change 
b/testcases/network/stress/interface/if4-addr-change
index a665b85ff..4eaabd70c 100644
--- a/testcases/network/stress/interface/if4-addr-change
+++ b/testcases/network/stress/interface/if4-addr-change
@@ -21,12 +21,12 @@ TST_TOTAL=1
  TCID=if4-addr-change
  TST_CLEANUP="do_cleanup"

+. test_net.sh
+
  CHECK_INTERVAL=${CHECK_INTERVAL:-$(($NS_TIMES / 20))}
  # Maximum host portion of the IPv4 address on the local host
  LHOST_IPV4_HOST_MAX="254"

-. test_net.sh
-
  do_cleanup()
  {
         tst_restore_ipaddr
-- 




-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180225/e8181919/attachment.html>
