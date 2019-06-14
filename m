From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 14 Jun 2019 14:27:16 +0200
Subject: [LTP] [PATCH] net/tst_net_vars: Fix IPv4 network computing on big
	endianness
Message-ID: <20190614122716.2383-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

by converting IP to network byte order and adjust printing.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/lib/tst_net_vars.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/testcases/lib/tst_net_vars.c b/testcases/lib/tst_net_vars.c
index 43cd92bcf..b1ea99df6 100644
--- a/testcases/lib/tst_net_vars.c
+++ b/testcases/lib/tst_net_vars.c
@@ -476,23 +476,19 @@ static char *get_ipv4_network(int ip, unsigned int prefix)
 	unsigned char byte;
 	unsigned int i;
 
+	ip = htonl(ip);
+
 	if (prefix > MAX_IPV4_PREFIX)
 		return NULL;
 
 	if (prefix == MAX_IPV4_PREFIX)
 		return strdup("\0");
 
-	prefix &= 0x18;
+	prefix &= MAX_IPV4_PREFIX - 8;
 
-	for (i = 0; i < MAX_IPV4_PREFIX && (prefix == 0 || i < prefix);
-	     i += 8) {
-		if (i == 0) {
-			byte = ip & 0xff;
-			sprintf(p_buf, "%d", byte);
-		} else {
-			byte = (ip >> i) & 0xff;
-			sprintf(p_buf, ".%d", byte);
-		}
+	for (i = prefix; i > 0; i -= 8) {
+		byte = (ip >> i) & 0xff;
+		sprintf(p_buf, i < prefix ? ".%d" : "%d", byte);
 		p_buf += strlen(p_buf);
 	}
 
-- 
2.21.0

