From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 18 Aug 2017 18:44:35 +0200
Subject: [LTP] [RFC PATCH v8 09/11] network/stress: Further enhancements for
	route4-rmmod
In-Reply-To: <20170818164437.13556-1-pvorel@suse.cz>
References: <20170818164437.13556-1-pvorel@suse.cz>
Message-ID: <20170818164437.13556-10-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Remove dependency to ifconfig.
* Use TCONF when test would break other interface.
* Raise TCONF only if the other device is in different than 'down' mode.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/stress/route/route4-rmmod | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/network/stress/route/route4-rmmod b/testcases/network/stress/route/route4-rmmod
index 9c1eade81..8cba6a9c1 100644
--- a/testcases/network/stress/route/route4-rmmod
+++ b/testcases/network/stress/route/route4-rmmod
@@ -41,20 +41,24 @@ do_setup()
 
 	route_setup
 
+	# NOTE: we have to use ethtool as
+	# /sys/class/net/<iface>/device/driver/module doesn't exist
+	# for virtual drivers (e.g. veth)
 	tst_check_cmds ethtool
 
 	tst_add_ipaddr_stress
 
 	# module driver of tested interface
 	MODULE="$(ethtool -i $(tst_iface) | grep driver | sed 's/driver:[[:blank:]]*//')"
+	[ -z "$MODULE" ] && tst_resm TBROK "module for interface '$(tst_iface)' not found"
 
 	# Check the other active interface uses the same driver
-	for ifname in $(ifconfig | grep ^eth | awk '{ print $1}'); do
+	for ifname in $(basename -a /sys/class/net/*); do
 		[ "$(tst_iface)" = "$ifname" ] && continue
 		[ "$ifname" = 'lo' ] && continue
 
 		module="$(ethtool -i $ifname | grep driver | sed 's/driver:[[:blank:]]*//')"
-		[ "$module" = "$MODULE" ] && \
+		[ "$module" = "$MODULE" -a "$(cat /sys/class/net/$ifname/operstate)" != "down" ] && \
 			tst_brkm TCONF "an active interface '$ifname' uses the same network driver '$MODULE' with the test interface '$(tst_iface)'"
 	done
 }
-- 
2.13.2

