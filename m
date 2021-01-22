From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 22 Jan 2021 15:54:58 +0100
Subject: [LTP] [PATCH v5 3/3] tst_net.sh: Require veth for netns (again)
In-Reply-To: <20210122145458.27964-1-pvorel@suse.cz>
References: <20210122145458.27964-1-pvorel@suse.cz>
Message-ID: <20210122145458.27964-4-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

new error message is more informative:
tcp_fastopen_run 1 TCONF: veth driver not available

then the old one:
Error: Unknown device type.
tcp_fastopen_run 1 TBROK: ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2 failed

NOTE: originally added in 305a78e4c and temporarily reverted in
7fe2ad11d due problems which were fixed in commit
"lib: Fix kernel module detection on BusyBox".

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index ef9354903..1ddef2fea 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -106,6 +106,7 @@ init_ltp_netspace()
 		tst_require_cmds ip
 		tst_require_root
 
+		tst_require_drivers veth
 		ROD ip li add name ltp_ns_veth1 type veth peer name ltp_ns_veth2
 		pid="$(ROD ns_create net,mnt)"
 		mkdir -p /var/run/netns
-- 
2.30.0

