From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 4 Sep 2018 08:58:10 +0800
Subject: [LTP] [PATCH] change the default command file of network
In-Reply-To: <1536022690-17612-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1536022690-17612-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <1536022690-17612-2-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>

The options -N of runltp means "Run all the networking tests", and when
exec  runltp -N and no command files were provied, the cmmand file of
"$LTPROOT/scenario_groups/network" should execute, so the the "$LTPROOT/
scenario_groups/network" should include the all the networking tests.

Signed-off-by: Sun Lianwen <sunlw.fnst@cn.fujitsu.com>
---
 scenario_groups/network | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/scenario_groups/network b/scenario_groups/network
index bf857b09e..d447daf88 100644
--- a/scenario_groups/network
+++ b/scenario_groups/network
@@ -1,4 +1,22 @@
+can
+net.features
+net.ipv6
+net.ipv6_lib
 net.tcp_cmds
 net.multicast
 net.rpc
 net.nfs
+net.rpc_tests
+net.tirpc_tests
+net.sctp
+network_commands
+net_stress.appl
+net_stress.broken_ip
+net_stress.interface
+net_stress.ipsec_dccp
+net_stress.ipsec_icmp
+net_stress.ipsec_sctp
+net_stress.ipsec_tcp
+net_stress.ipsec_udp
+net_stress.multicast
+net_stress.route
-- 
2.18.0



