From: Petr Vorel <pvorel@suse.cz>
Date: Thu,  7 Sep 2017 13:25:21 +0200
Subject: [LTP] [PATCH v2 2/2] lib6/in6_01: Fix compiler warning 'set but not
	used variable'
In-Reply-To: <20170907112521.23881-1-pvorel@suse.cz>
References: <20170907112521.23881-1-pvorel@suse.cz>
Message-ID: <20170907112521.23881-2-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/lib6/in6_01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/network/lib6/in6_01.c b/testcases/network/lib6/in6_01.c
index 70e771357..0b279dd10 100644
--- a/testcases/network/lib6/in6_01.c
+++ b/testcases/network/lib6/in6_01.c
@@ -117,7 +117,7 @@ static void test_sockaddr_in6(void)
 	uint32_t ui16 = 2;
 	uint32_t ui32 = 3;
 	struct in6_addr in6;
-	struct sockaddr_in6 sin6;
+	LTP_ATTRIBUTE_UNUSED struct sockaddr_in6 sin6;
 
 	in6.s6_addr[0] = ui8;
 	sin6.sin6_family = AF_INET6;
-- 
2.14.0

