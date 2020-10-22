From: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Date: Thu, 22 Oct 2020 06:12:28 -0400
Subject: [LTP] [PATCH] route{4,6}-rmmod: Filter out ":" and fix typos
Message-ID: <1603361548-1534-1-git-send-email-zhufy.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Reported-by: Jin Cao <caoj.fnst@cn.fujitsu.com>
Signed-off-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
---
 testcases/network/stress/route/route4-rmmod | 4 ++--
 testcases/network/stress/route/route6-rmmod | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/network/stress/route/route4-rmmod b/testcases/network/stress/route/route4-rmmod
index 7aa1958..1ba255e 100644
--- a/testcases/network/stress/route/route4-rmmod
+++ b/testcases/network/stress/route/route4-rmmod
@@ -164,14 +164,14 @@ do_setup()
     lhost_module=`ethtool -i $lhost_ifname | grep driver | sed "s/driver:[[:blank:]]*//"`
 
     # Chack the other active interface uses the same driver
-    for ifname in `ifconfig | grep ^eth | awk '{ print $1}'`; do
+    for ifname in `ifconfig | grep ^eth | awk '{print $1}' | sed "s/://"`; do
 	if [ $lhost_ifname = $ifname ]; then
 	    continue
 	fi
 
 	module=`ethtool -i $ifname | grep driver | sed "s/driver:[[:blank:]]*//"`
 	if [ $lhost_module = $module ]; then
-	    tst_resm TBROK "An active interface $ifname uses the same network deriver $module with the test intreface."
+	    tst_resm TBROK "An active interface $ifname uses the same network driver $module with the test interface."
 	    exit $TST_TOTAL
 	fi
     done
diff --git a/testcases/network/stress/route/route6-rmmod b/testcases/network/stress/route/route6-rmmod
index 765a57a..146fa77 100644
--- a/testcases/network/stress/route/route6-rmmod
+++ b/testcases/network/stress/route/route6-rmmod
@@ -160,14 +160,14 @@ do_setup()
     lhost_module=`ethtool -i $lhost_ifname | grep driver | sed "s/driver:[[:blank:]]*//"`
 
     # Chack the other active interface uses the same driver
-    for ifname in `ifconfig | grep ^eth | awk '{ print $1}'`; do
+    for ifname in `ifconfig | grep ^eth | awk '{print $1}' | sed "s/://"`; do
 	if [ $lhost_ifname = $ifname ]; then
 	    continue
 	fi
 
 	module=`ethtool -i $ifname | grep driver | sed "s/driver:[[:blank:]]*//"`
 	if [ $lhost_module = $module ]; then
-	    tst_resm TBROK "An active interface $ifname uses the same network deriver $module with the test intreface."
+	    tst_resm TBROK "An active interface $ifname uses the same network driver $module with the test interface."
 	    exit $TST_TOTAL
 	fi
     done
-- 
1.8.3.1



