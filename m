From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 15 Jun 2021 08:40:45 +0100
Subject: [LTP] [PATCH v4 3/3] API: Remove TST_ERR usage from
 rtnetlink/netdevice
In-Reply-To: <20210615074045.23974-1-rpalethorpe@suse.com>
References: <20210615074045.23974-1-rpalethorpe@suse.com>
Message-ID: <20210615074045.23974-3-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The test author is guaranteed that the library will not set TST_ERR
except via the TEST macro and similar.

Currently the rtnetlink & netdevice API returns 0 on fail and 1 on
success. Either TST_ERR or errno is used to store the error
number. The commit stays with this scheme except that we only use
errno. This means that we have to temporarily save errno when it would
be overwritten by a less important operation.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

Possibly the API should be redesigned so that we are not juggling
errno. We could return the errno instead of just a boolean. However I
then think this should be done for all network functions for
consistency. Even if that is done, I still don't like it.

In most cases though, the issue is caused by tst_brk_ not
returning. Instead we could print the error immediately, but defer
cleanup. E.g. have tst_brk_defer_ which prints the error and sets a
flag, then call tst_sync_ which exits if the brk flag is set.

In any case these are quite big changes. So I have just submitted this
errno patch.

 lib/tst_netdevice.c | 30 ++++++++++++++++++++----------
 lib/tst_rtnetlink.c |  9 +++++----
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/lib/tst_netdevice.c b/lib/tst_netdevice.c
index d098173d5..214a6f500 100644
--- a/lib/tst_netdevice.c
+++ b/lib/tst_netdevice.c
@@ -101,7 +101,7 @@ int tst_netdev_set_state(const char *file, const int lineno,
 int tst_create_veth_pair(const char *file, const int lineno,
 	const char *ifname1, const char *ifname2)
 {
-	int ret;
+	int ret, save_errno;
 	struct ifinfomsg info = { .ifi_family = AF_UNSPEC };
 	struct tst_rtnl_context *ctx;
 	struct tst_rtnl_attr_list peerinfo[] = {
@@ -146,10 +146,12 @@ int tst_create_veth_pair(const char *file, const int lineno,
 	}
 
 	ret = tst_rtnl_send_validate(file, lineno, ctx);
+	save_errno = errno;
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
 	if (!ret) {
-		tst_brk_(file, lineno, TBROK | TTERRNO,
+		errno = save_errno;
+		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Failed to create veth interfaces %s+%s", ifname1,
 			ifname2);
 	}
@@ -161,7 +163,7 @@ int tst_remove_netdev(const char *file, const int lineno, const char *ifname)
 {
 	struct ifinfomsg info = { .ifi_family = AF_UNSPEC };
 	struct tst_rtnl_context *ctx;
-	int ret;
+	int ret, save_errno;
 
 	if (strlen(ifname) >= IFNAMSIZ) {
 		tst_brk_(file, lineno, TBROK,
@@ -180,10 +182,12 @@ int tst_remove_netdev(const char *file, const int lineno, const char *ifname)
 	}
 
 	ret = tst_rtnl_send_validate(file, lineno, ctx);
+	save_errno = errno;
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
 	if (!ret) {
-		tst_brk_(file, lineno, TBROK | TTERRNO,
+		errno = save_errno;
+		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Failed to remove netdevice %s", ifname);
 	}
 
@@ -196,7 +200,7 @@ static int modify_address(const char *file, const int lineno,
 	size_t addrlen, uint32_t addr_flags)
 {
 	struct tst_rtnl_context *ctx;
-	int index, ret;
+	int index, ret, save_errno;
 	struct ifaddrmsg info = {
 		.ifa_family = family,
 		.ifa_prefixlen = prefix
@@ -229,10 +233,12 @@ static int modify_address(const char *file, const int lineno,
 	}
 
 	ret = tst_rtnl_send_validate(file, lineno, ctx);
+	save_errno = errno;
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
 	if (!ret) {
-		tst_brk_(file, lineno, TBROK | TTERRNO,
+		errno = save_errno;
+		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Failed to modify %s network address", ifname);
 	}
 
@@ -276,7 +282,7 @@ static int change_ns(const char *file, const int lineno, const char *ifname,
 {
 	struct ifinfomsg info = { .ifi_family = AF_UNSPEC };
 	struct tst_rtnl_context *ctx;
-	int ret;
+	int ret, save_errno;
 
 	if (strlen(ifname) >= IFNAMSIZ) {
 		tst_brk_(file, lineno, TBROK,
@@ -298,10 +304,12 @@ static int change_ns(const char *file, const int lineno, const char *ifname,
 	}
 
 	ret = tst_rtnl_send_validate(file, lineno, ctx);
+	save_errno = errno;
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
 	if (!ret) {
-		tst_brk_(file, lineno, TBROK | TTERRNO,
+		errno = save_errno;
+		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Failed to move %s to another namespace", ifname);
 	}
 
@@ -327,7 +335,7 @@ static int modify_route(const char *file, const int lineno, unsigned int action,
 	const void *gateway, size_t gatewaylen)
 {
 	struct tst_rtnl_context *ctx;
-	int ret;
+	int ret, save_errno;
 	int32_t index;
 	struct rtmsg info = {
 		.rtm_family = family,
@@ -389,10 +397,12 @@ static int modify_route(const char *file, const int lineno, unsigned int action,
 	}
 
 	ret = tst_rtnl_send_validate(file, lineno, ctx);
+	save_errno = errno;
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
 	if (!ret) {
-		tst_brk_(file, lineno, TBROK | TTERRNO,
+		errno = save_errno;
+		tst_brk_(file, lineno, TBROK | TERRNO,
 			"Failed to modify network route");
 	}
 
diff --git a/lib/tst_rtnetlink.c b/lib/tst_rtnetlink.c
index 1ecda3a9f..627695c80 100644
--- a/lib/tst_rtnetlink.c
+++ b/lib/tst_rtnetlink.c
@@ -376,11 +376,12 @@ int tst_rtnl_check_acks(const char *file, const int lineno,
 			tst_brk_(file, lineno, TBROK,
 				"No ACK found for Netlink message %u",
 				msg->nlmsg_seq);
+			errno = ENOMSG;
 			return 0;
 		}
 
 		if (res->err->error) {
-			TST_ERR = -res->err->error;
+			errno = -res->err->error;
 			return 0;
 		}
 	}
@@ -392,9 +393,7 @@ int tst_rtnl_send_validate(const char *file, const int lineno,
 	struct tst_rtnl_context *ctx)
 {
 	struct tst_rtnl_message *response;
-	int ret;
-
-	TST_ERR = 0;
+	int ret, save_errno;
 
 	if (tst_rtnl_send(file, lineno, ctx) <= 0)
 		return 0;
@@ -406,7 +405,9 @@ int tst_rtnl_send_validate(const char *file, const int lineno,
 		return 0;
 
 	ret = tst_rtnl_check_acks(file, lineno, ctx, response);
+	save_errno = errno;
 	tst_rtnl_free_message(response);
+	errno = save_errno;
 
 	return ret;
 }
-- 
2.31.1

