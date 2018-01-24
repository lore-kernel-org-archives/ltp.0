From: Michael Moese <mmoese@suse.de>
Date: Wed, 24 Jan 2018 14:02:57 +0100
Subject: [LTP] [PATCH 04/19] fix old style definition in mc_gethost.c
In-Reply-To: <20180124130312.7665-1-mmoese@suse.de>
References: <20180124130312.7665-1-mmoese@suse.de>
Message-ID: <20180124130312.7665-5-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/network/multicast/mc_gethost/mc_gethost.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/testcases/network/multicast/mc_gethost/mc_gethost.c b/testcases/network/multicast/mc_gethost/mc_gethost.c
index a5c5d014c..9cc15d086 100644
--- a/testcases/network/multicast/mc_gethost/mc_gethost.c
+++ b/testcases/network/multicast/mc_gethost/mc_gethost.c
@@ -21,9 +21,7 @@
 #define LOG_PERROR 0
 #endif
 
-int main(argc, argv)
-int argc;
-char **argv;
+int main(int argc, char **argv)
 {
 	unsigned char b_addr[IN6ADDRSZ];
 	struct hostent *host;
-- 
2.13.6

