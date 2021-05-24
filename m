From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Mon, 24 May 2021 15:47:45 +0100
Subject: [LTP] [RFC PATCH 4/4] API: Removal of TST_ERR usage
In-Reply-To: <20210524144745.10887-1-rpalethorpe@suse.com>
References: <20210524144745.10887-1-rpalethorpe@suse.com>
Message-ID: <20210524144745.10887-5-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use errno instead to stop Coccinelle test from failing.
---
 lib/tst_netdevice.c | 10 +++++-----
 lib/tst_rtnetlink.c |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/tst_netdevice.c b/lib/tst_netdevice.c
index d098173d5..cc2766be8 100644
--- a/lib/tst_netdevice.c
+++ b/lib/tst_netdevice.c
@@ -149,7 +149,7 @@ int tst_create_veth_pair(const char *file, const int lineno,
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
 	if (!ret) {
-		tst_brk_(file, lineno, TBROK | TTERRNO,
+		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Failed to create veth interfaces %s+%s", ifname1,
 			ifname2);
 	}
@@ -183,7 +183,7 @@ int tst_remove_netdev(const char *file, const int lineno, const char *ifname)
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
 	if (!ret) {
-		tst_brk_(file, lineno, TBROK | TTERRNO,
+		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Failed to remove netdevice %s", ifname);
 	}
 
@@ -232,7 +232,7 @@ static int modify_address(const char *file, const int lineno,
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
 	if (!ret) {
-		tst_brk_(file, lineno, TBROK | TTERRNO,
+		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Failed to modify %s network address", ifname);
 	}
 
@@ -301,7 +301,7 @@ static int change_ns(const char *file, const int lineno, const char *ifname,
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
 	if (!ret) {
-		tst_brk_(file, lineno, TBROK | TTERRNO,
+		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Failed to move %s to another namespace", ifname);
 	}
 
@@ -392,7 +392,7 @@ static int modify_route(const char *file, const int lineno, unsigned int action,
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
 	if (!ret) {
-		tst_brk_(file, lineno, TBROK | TTERRNO,
+		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Failed to modify network route");
 	}
 
diff --git a/lib/tst_rtnetlink.c b/lib/tst_rtnetlink.c
index 1ecda3a9f..d93f7e18d 100644
--- a/lib/tst_rtnetlink.c
+++ b/lib/tst_rtnetlink.c
@@ -380,7 +380,7 @@ int tst_rtnl_check_acks(const char *file, const int lineno,
 		}
 
 		if (res->err->error) {
-			TST_ERR = -res->err->error;
+			errno = -res->err->error;
 			return 0;
 		}
 	}
@@ -394,7 +394,7 @@ int tst_rtnl_send_validate(const char *file, const int lineno,
 	struct tst_rtnl_message *response;
 	int ret;
 
-	TST_ERR = 0;
+	errno = 0;
 
 	if (tst_rtnl_send(file, lineno, ctx) <= 0)
 		return 0;
-- 
2.31.1

