From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 25 Aug 2021 12:42:59 +0200
Subject: [LTP] [PATCH 2/3] Rename REMOVE_NETDEV() to NETDEV_REMOVE_DEVICE()
In-Reply-To: <20210825104300.15255-1-mdoucha@suse.cz>
References: <20210825104300.15255-1-mdoucha@suse.cz>
Message-ID: <20210825104300.15255-2-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Use the same naming style as in the rest of netdevice library.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 doc/network-c-api.txt   | 4 ++--
 include/tst_netdevice.h | 6 ++++--
 lib/tst_netdevice.c     | 3 ++-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/doc/network-c-api.txt b/doc/network-c-api.txt
index f24614fd8..e910d159f 100644
--- a/doc/network-c-api.txt
+++ b/doc/network-c-api.txt
@@ -166,8 +166,8 @@ stage.
   a new network device named +ifname+ of specified device type. Returns 1 on
   success, 0 on error.
 
-- +int REMOVE_NETDEV(const char *ifname)+ ? Removes network device +ifname+.
-  Returns 1 on success, 0 on error.
+- +int NETDEV_REMOVE_DEVICE(const char *ifname)+ ? Removes network device
+  +ifname+. Returns 1 on success, 0 on error.
 
 2.2 Network address management
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/include/tst_netdevice.h b/include/tst_netdevice.h
index 0bd33765b..f02661208 100644
--- a/include/tst_netdevice.h
+++ b/include/tst_netdevice.h
@@ -28,8 +28,10 @@ int tst_netdev_add_device(const char *file, const int lineno,
 #define NETDEV_ADD_DEVICE(ifname, devtype) \
 	tst_netdev_add_device(__FILE__, __LINE__, (ifname), (devtype))
 
-int tst_remove_netdev(const char *file, const int lineno, const char *ifname);
-#define REMOVE_NETDEV(ifname) tst_remove_netdev(__FILE__, __LINE__, (ifname))
+int tst_netdev_remove_device(const char *file, const int lineno,
+	const char *ifname);
+#define NETDEV_REMOVE_DEVICE(ifname) \
+	tst_netdev_remove_device(__FILE__, __LINE__, (ifname))
 
 int tst_netdev_add_address(const char *file, const int lineno,
 	const char *ifname, unsigned int family, const void *address,
diff --git a/lib/tst_netdevice.c b/lib/tst_netdevice.c
index 9a8c622e2..ba9a55b70 100644
--- a/lib/tst_netdevice.c
+++ b/lib/tst_netdevice.c
@@ -201,7 +201,8 @@ int tst_netdev_add_device(const char *file, const int lineno,
 	return ret;
 }
 
-int tst_remove_netdev(const char *file, const int lineno, const char *ifname)
+int tst_netdev_remove_device(const char *file, const int lineno,
+	const char *ifname)
 {
 	struct ifinfomsg info = { .ifi_family = AF_UNSPEC };
 	struct tst_rtnl_context *ctx;
-- 
2.32.0

