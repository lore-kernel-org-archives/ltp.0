From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 25 Aug 2021 12:42:58 +0200
Subject: [LTP] [PATCH 1/3] Add NETDEV_ADD_DEVICE() helper function
Message-ID: <20210825104300.15255-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 doc/network-c-api.txt   |  4 ++++
 include/tst_netdevice.h |  5 +++++
 lib/tst_netdevice.c     | 44 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/doc/network-c-api.txt b/doc/network-c-api.txt
index 145836a81..f24614fd8 100644
--- a/doc/network-c-api.txt
+++ b/doc/network-c-api.txt
@@ -162,6 +162,10 @@ stage.
   on success, 0 on error. Add +"CONFIG_VETH"+ to +test.needs_kconfigs+ if your
   test calls this function.
 
+- +int NETDEV_ADD_DEVICE(const char *ifname, const char *devtype)+ - Creates
+  a new network device named +ifname+ of specified device type. Returns 1 on
+  success, 0 on error.
+
 - +int REMOVE_NETDEV(const char *ifname)+ ? Removes network device +ifname+.
   Returns 1 on success, 0 on error.
 
diff --git a/include/tst_netdevice.h b/include/tst_netdevice.h
index 3a6698731..0bd33765b 100644
--- a/include/tst_netdevice.h
+++ b/include/tst_netdevice.h
@@ -23,6 +23,11 @@ int tst_create_veth_pair(const char *file, const int lineno,
 #define CREATE_VETH_PAIR(ifname1, ifname2) \
 	tst_create_veth_pair(__FILE__, __LINE__, (ifname1), (ifname2))
 
+int tst_netdev_add_device(const char *file, const int lineno,
+	const char *ifname, const char *devtype);
+#define NETDEV_ADD_DEVICE(ifname, devtype) \
+	tst_netdev_add_device(__FILE__, __LINE__, (ifname), (devtype))
+
 int tst_remove_netdev(const char *file, const int lineno, const char *ifname);
 #define REMOVE_NETDEV(ifname) tst_remove_netdev(__FILE__, __LINE__, (ifname))
 
diff --git a/lib/tst_netdevice.c b/lib/tst_netdevice.c
index a4bc22635..9a8c622e2 100644
--- a/lib/tst_netdevice.c
+++ b/lib/tst_netdevice.c
@@ -157,6 +157,50 @@ int tst_create_veth_pair(const char *file, const int lineno,
 	return ret;
 }
 
+int tst_netdev_add_device(const char *file, const int lineno,
+	const char *ifname, const char *devtype)
+{
+	int ret;
+	struct ifinfomsg info = { .ifi_family = AF_UNSPEC };
+	struct tst_rtnl_context *ctx;
+	struct tst_rtnl_attr_list attrs[] = {
+		{IFLA_IFNAME, ifname, strlen(ifname) + 1, NULL},
+		{IFLA_LINKINFO, NULL, 0, (const struct tst_rtnl_attr_list[]){
+			{IFLA_INFO_KIND, devtype, strlen(devtype), NULL},
+			{0, NULL, -1, NULL}
+		}},
+		{0, NULL, -1, NULL}
+	};
+
+	if (strlen(ifname) >= IFNAMSIZ) {
+		tst_brk_(file, lineno, TBROK,
+			"Network device name \"%s\" too long", ifname);
+		return 0;
+	}
+
+	ctx = create_request(file, lineno, RTM_NEWLINK,
+		NLM_F_CREATE | NLM_F_EXCL, &info, sizeof(info));
+
+	if (!ctx)
+		return 0;
+
+	if (tst_rtnl_add_attr_list(file, lineno, ctx, attrs) != 2) {
+		tst_rtnl_destroy_context(file, lineno, ctx);
+		return 0;
+	}
+
+	ret = tst_rtnl_send_validate(file, lineno, ctx);
+	tst_rtnl_destroy_context(file, lineno, ctx);
+
+	if (!ret) {
+		tst_brk_(file, lineno, TBROK,
+			"Failed to create %s device %s: %s", devtype, ifname,
+			tst_strerrno(tst_rtnl_errno));
+	}
+
+	return ret;
+}
+
 int tst_remove_netdev(const char *file, const int lineno, const char *ifname)
 {
 	struct ifinfomsg info = { .ifi_family = AF_UNSPEC };
-- 
2.32.0

