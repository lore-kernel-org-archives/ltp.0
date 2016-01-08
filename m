From: Khem Raj <raj.khem@gmail.com>
Date: Fri,  8 Jan 2016 08:11:45 +0000
Subject: [LTP] [PATCH 25/31] mc_gethost: include sys/types.h
In-Reply-To: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
References: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452240711-51180-25-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fix build on musl
error: unknown type name 'u_char'

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/network/multicast/mc_gethost/mc_gethost.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/network/multicast/mc_gethost/mc_gethost.c b/testcases/network/multicast/mc_gethost/mc_gethost.c
index 5b9a790..c799e2a 100644
--- a/testcases/network/multicast/mc_gethost/mc_gethost.c
+++ b/testcases/network/multicast/mc_gethost/mc_gethost.c
@@ -6,6 +6,7 @@
 
 #include <sys/param.h>
 #include <sys/socket.h>
+#include <sys/types.h>
 #include <netinet/in.h>
 #include <arpa/inet.h>
 #include <arpa/nameser.h>
-- 
2.7.0

