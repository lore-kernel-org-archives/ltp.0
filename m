From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Wed, 21 Mar 2018 14:39:09 +0300
Subject: [LTP] [PATCH COMMITTED] lib/tst_net_iface_prefix: export correct
	env variable for interface
Message-ID: <1521632349-12990-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This is fixing setups with different interface names between local
and remote host. netns setup is not affected because interface names
are set explicitly before the exports with tst_net_iface_prefix.

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/lib/tst_net_iface_prefix.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/testcases/lib/tst_net_iface_prefix.c b/testcases/lib/tst_net_iface_prefix.c
index 3868d36..a9e3882 100644
--- a/testcases/lib/tst_net_iface_prefix.c
+++ b/testcases/lib/tst_net_iface_prefix.c
@@ -152,13 +152,11 @@ int main(int argc, char *argv[])
 	else
 		get_in_addr(ip_str, &ip);
 
-	if (is_ipv6) {
-		print_svar_change("LHOST_IFACES", iface);
+	print_svar_change(is_rhost ? "RHOST_IFACES" : "LHOST_IFACES", iface);
+	if (is_ipv6)
 		print_ivar(is_rhost ? "IPV6_RPREFIX" : "IPV6_LPREFIX", prefix);
-	} else {
-		print_svar_change("RHOST_IFACES", iface);
+	else
 		print_ivar(is_rhost ? "IPV4_RPREFIX" : "IPV4_LPREFIX", prefix);
-	}
 
 	exit(EXIT_SUCCESS);
 }
-- 
1.7.1

