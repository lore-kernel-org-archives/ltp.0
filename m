From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 22 Jun 2021 17:48:04 +0200
Subject: [LTP] [PATCH] tst_rtnetlink: pass error codes using rtnl_errno
 variable
Message-ID: <20210622154804.19946-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_rtnetlink.h |  2 ++
 lib/tst_netdevice.c     | 26 +++++++++++++++-----------
 lib/tst_rtnetlink.c     |  6 ++++--
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/tst_rtnetlink.h b/include/tst_rtnetlink.h
index 12ec258f2..7c28f795d 100644
--- a/include/tst_rtnetlink.h
+++ b/include/tst_rtnetlink.h
@@ -21,6 +21,8 @@ struct tst_rtnl_message {
 	size_t payload_size;
 };
 
+extern int rtnl_errno;
+
 /* Open a netlink socket */
 struct tst_rtnl_context *tst_rtnl_create_context(const char *file,
 	const int lineno);
diff --git a/lib/tst_netdevice.c b/lib/tst_netdevice.c
index d098173d5..af57fba1e 100644
--- a/lib/tst_netdevice.c
+++ b/lib/tst_netdevice.c
@@ -149,9 +149,9 @@ int tst_create_veth_pair(const char *file, const int lineno,
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
 	if (!ret) {
-		tst_brk_(file, lineno, TBROK | TTERRNO,
-			"Failed to create veth interfaces %s+%s", ifname1,
-			ifname2);
+		tst_brk_(file, lineno, TBROK,
+			"Failed to create veth interfaces %s+%s: %s", ifname1,
+			ifname2, tst_strerrno(rtnl_errno));
 	}
 
 	return ret;
@@ -183,8 +183,9 @@ int tst_remove_netdev(const char *file, const int lineno, const char *ifname)
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
 	if (!ret) {
-		tst_brk_(file, lineno, TBROK | TTERRNO,
-			"Failed to remove netdevice %s", ifname);
+		tst_brk_(file, lineno, TBROK,
+			"Failed to remove netdevice %s: %s", ifname,
+			tst_strerrno(rtnl_errno));
 	}
 
 	return ret;
@@ -232,8 +233,9 @@ static int modify_address(const char *file, const int lineno,
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
 	if (!ret) {
-		tst_brk_(file, lineno, TBROK | TTERRNO,
-			"Failed to modify %s network address", ifname);
+		tst_brk_(file, lineno, TBROK,
+			"Failed to modify %s network address: %s", ifname,
+			tst_strerrno(rtnl_errno));
 	}
 
 	return ret;
@@ -301,8 +303,9 @@ static int change_ns(const char *file, const int lineno, const char *ifname,
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
 	if (!ret) {
-		tst_brk_(file, lineno, TBROK | TTERRNO,
-			"Failed to move %s to another namespace", ifname);
+		tst_brk_(file, lineno, TBROK,
+			"Failed to move %s to another namespace: %s", ifname,
+			tst_strerrno(rtnl_errno));
 	}
 
 	return ret;
@@ -392,8 +395,9 @@ static int modify_route(const char *file, const int lineno, unsigned int action,
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
 	if (!ret) {
-		tst_brk_(file, lineno, TBROK | TTERRNO,
-			"Failed to modify network route");
+		tst_brk_(file, lineno, TBROK,
+			"Failed to modify network route: %s",
+			tst_strerrno(rtnl_errno));
 	}
 
 	return ret;
diff --git a/lib/tst_rtnetlink.c b/lib/tst_rtnetlink.c
index 1ecda3a9f..6f24b89fe 100644
--- a/lib/tst_rtnetlink.c
+++ b/lib/tst_rtnetlink.c
@@ -24,6 +24,8 @@ struct tst_rtnl_context {
 	struct nlmsghdr *curmsg;
 };
 
+int rtnl_errno;
+
 static int tst_rtnl_grow_buffer(const char *file, const int lineno,
 	struct tst_rtnl_context *ctx, size_t size)
 {
@@ -380,7 +382,7 @@ int tst_rtnl_check_acks(const char *file, const int lineno,
 		}
 
 		if (res->err->error) {
-			TST_ERR = -res->err->error;
+			rtnl_errno = -res->err->error;
 			return 0;
 		}
 	}
@@ -394,7 +396,7 @@ int tst_rtnl_send_validate(const char *file, const int lineno,
 	struct tst_rtnl_message *response;
 	int ret;
 
-	TST_ERR = 0;
+	rtnl_errno = 0;
 
 	if (tst_rtnl_send(file, lineno, ctx) <= 0)
 		return 0;
-- 
2.32.0

