From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 21 Jul 2017 06:04:05 +0200
Subject: [LTP] [RFC PATCH v7 09/11] network/stress: Further enhancements for
	route4-rmmod
In-Reply-To: <20170721040407.868-1-pvorel@suse.cz>
References: <20170721040407.868-1-pvorel@suse.cz>
Message-ID: <20170721040407.868-10-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Remove dependency to ifconfig
* Use TCONF when test would break other interface
* Don't raise TCONF only if the other device is in 'down' mode

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/route/route4-rmmod | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/testcases/network/stress/route/route4-rmmod b/testcases/network/stress/route/route4-rmmod
index 70a6e3745..a089d6712 100644
--- a/testcases/network/stress/route/route4-rmmod
+++ b/testcases/network/stress/route/route4-rmmod
@@ -35,28 +35,29 @@ do_cleanup()
 	restore_ipaddr
 }
 
-
 do_setup()
 {
 	route_setup
+
+	# NOTE: we have to use ethtool as
+	# /sys/class/net/<iface>/device/driver/module doesn't exist
+	# for virtual drivers (e.g. veth)
 	tst_check_cmds ethtool
 
 	tst_add_ipaddr_stress
 
 	# Get the module name of the interface at the local host
 	lhost_module=$(ethtool -i $(tst_iface) | grep driver | sed "s/driver:[[:blank:]]*//")
+	[ -z "$lhost_module" ] && tst_resm TBROK "module for interface '$(tst_iface)' not found"
 
 	# Check the other active interface uses the same driver
-	for ifname in $(ifconfig | grep ^eth | awk '{ print $1}'); do
-		if [ "$(tst_iface)" = "$ifname" ]; then
-			continue
-		fi
+	for ifname in $(basename -a /sys/class/net/*); do
+		[ "$(tst_iface)" = "$ifname" ] && continue
 
 		module=$(ethtool -i $ifname | grep driver | sed "s/driver:[[:blank:]]*//")
-		if [ $lhost_module = $module ]; then
-			tst_resm TBROK "an active interface '$ifname' uses the same network driver '$module' with the test intreface"
-			return
-		fi
+
+		[ "$lhost_module" = "$module" -a "$(cat /sys/class/net/$ifname/operstate)" != "down" ] && \
+			tst_brkm TCONF "an active interface '$ifname' uses the same network driver '$module' with the test interface '$(tst_iface)'"
 	done
 }
 
-- 
2.13.2

