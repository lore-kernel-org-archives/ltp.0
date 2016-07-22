From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Jul 2016 21:26:42 -0700
Subject: [LTP] [PATCH V3 09/23] mc_gethost: Use unsigned char instead of
	u_char
In-Reply-To: <20160722042656.22346-1-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
Message-ID: <20160722042656.22346-9-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fix build on musl
error: unknown type name 'u_char'

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/network/multicast/mc_gethost/mc_gethost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/multicast/mc_gethost/mc_gethost.c b/testcases/network/multicast/mc_gethost/mc_gethost.c
index 5b9a790..a5c5d01 100644
--- a/testcases/network/multicast/mc_gethost/mc_gethost.c
+++ b/testcases/network/multicast/mc_gethost/mc_gethost.c
@@ -25,7 +25,7 @@ int main(argc, argv)
 int argc;
 char **argv;
 {
-	u_char b_addr[IN6ADDRSZ];
+	unsigned char b_addr[IN6ADDRSZ];
 	struct hostent *host;
 	char **ap, **cp, *arg;
 	const char *prog = "amnesia";
-- 
2.9.0

