From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed,  9 Oct 2019 08:23:00 +0200
Subject: [LTP] [PATCH] tst_net.sh: Allow execution if xfrm is disabled
Message-ID: <20191009062300.50219-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

If the kernel is configured without xfrm support, the setup of the
interfaces for communication between local and remote host fails,
because it tries to flush xfrm state and policy.
There is no need to flush, if the system doesn't even support xfrm.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 testcases/lib/tst_net.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index 6c3ae708d..3aaf21cb5 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -430,8 +430,10 @@ tst_init_iface()
 	tst_res_ TINFO "initialize '$type' '$iface' interface"
 
 	if [ "$type" = "lhost" ]; then
-		ip xfrm policy flush || return $?
-		ip xfrm state flush || return $?
+		if ip xfrm state 1>/dev/null 2>&1; then
+			ip xfrm policy flush || return $?
+			ip xfrm state flush || return $?
+		fi
 		ip link set $iface down || return $?
 		ip route flush dev $iface || return $?
 		ip addr flush dev $iface || return $?
@@ -439,8 +441,10 @@ tst_init_iface()
 		return $?
 	fi
 
-	tst_rhost_run -c "ip xfrm policy flush" || return $?
-	tst_rhost_run -c "ip xfrm state flush" || return $?
+	if tst_rhost_run -c "ip xfrm state 1>/dev/null 2>&1"; then
+		tst_rhost_run -c "ip xfrm policy flush" || return $?
+		tst_rhost_run -c "ip xfrm state flush" || return $?
+	fi
 	tst_rhost_run -c "ip link set $iface down" || return $?
 	tst_rhost_run -c "ip route flush dev $iface" || return $?
 	tst_rhost_run -c "ip addr flush dev $iface" || return $?
-- 
2.20.1

