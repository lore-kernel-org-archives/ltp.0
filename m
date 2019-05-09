From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  9 May 2019 18:41:24 +0200
Subject: [LTP] [PATCH 1/2] tst_net_vars.c: Fix size for IPv4 address buffer
Message-ID: <20190509164125.619-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

INET_ADDRSTRLEN is maximum IPv4 length including the terminating null
byte, thus removing + 1 from buffer size.

Fixes: d18e135d0 ("network: Add tools for setup IP related environment
variables")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net_vars.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/lib/tst_net_vars.c b/testcases/lib/tst_net_vars.c
index fc63f1395..da9a4e64c 100644
--- a/testcases/lib/tst_net_vars.c
+++ b/testcases/lib/tst_net_vars.c
@@ -153,7 +153,7 @@ static int is_in_subnet_ipv6(const struct in6_addr *network,
  */
 static char *get_ipv4_netmask(unsigned int prefix)
 {
-	char buf[INET_ADDRSTRLEN + 1];
+	char buf[INET_ADDRSTRLEN];
 	struct in_addr mask = prefix2mask(prefix);
 
 	if (prefix > MAX_IPV4_PREFIX)
@@ -200,7 +200,7 @@ static char *get_ipv4_broadcast(struct in_addr ip, unsigned int prefix)
 {
 	struct in_addr mask = prefix2mask(prefix);
 	struct in_addr broadcast;
-	char buf[INET_ADDRSTRLEN + 1];
+	char buf[INET_ADDRSTRLEN];
 
 	memset(&broadcast, 0, sizeof(broadcast));
 	broadcast.s_addr = (ip.s_addr & mask.s_addr) | ~mask.s_addr;
@@ -471,7 +471,7 @@ static void check_prefix_range(unsigned int prefix, int is_ipv6, int is_lhost)
 
 static char *get_ipv4_network(int ip, unsigned int prefix)
 {
-	char buf[INET_ADDRSTRLEN + 1];
+	char buf[INET_ADDRSTRLEN];
 	char *p_buf = buf;
 	unsigned char byte;
 	unsigned int i;
-- 
2.21.0

