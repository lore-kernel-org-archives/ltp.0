From: Martin Doucha <mdoucha@suse.cz>
Date: Wed,  5 May 2021 10:18:44 +0200
Subject: [LTP] [PATCH v3 5/6] Add helper functions for managing network
 interfaces
In-Reply-To: <20210505081845.7024-1-mdoucha@suse.cz>
References: <20210505081845.7024-1-mdoucha@suse.cz>
Message-ID: <20210505081845.7024-5-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The library currently supports:
- creating a virtual ethernet device pair
- removing network interfaces
- enabling or disabling a network interface
- managing interface addresses
- managing routing table entries
- moving network interfaces between network namespaces

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- renamed tst_netdevice_index() to tst_netdev_index_by_name()
- renamed tst_netdevice_activate() to tst_netdev_set_state()
- shortened tst_netdevice_*() to tst_netdev_*()
- use inline struct initialization where possible
- use SAFE_IOCTL_()
- added modify_route_inet() internal helper function

Changes I've decided not to do:
- moving *_address_inet() and *_route_inet() functions to header file
- breaking long lines like if(foo & tst_rtnl_add_attr(...)) before the function
  call instead of in the argument list, the result would be too long

 include/tst_netdevice.h | 118 ++++++++++
 lib/tst_netdevice.c     | 463 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 581 insertions(+)
 create mode 100644 include/tst_netdevice.h
 create mode 100644 lib/tst_netdevice.c

diff --git a/include/tst_netdevice.h b/include/tst_netdevice.h
new file mode 100644
index 000000000..3a6698731
--- /dev/null
+++ b/include/tst_netdevice.h
@@ -0,0 +1,118 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ * Copyright (c) 2021 Linux Test Project
+ */
+
+#ifndef TST_NETDEVICE_H
+#define TST_NETDEVICE_H
+
+/* Find device index for given network interface name. */
+int tst_netdev_index_by_name(const char *file, const int lineno,
+	const char *ifname);
+#define NETDEV_INDEX_BY_NAME(ifname) \
+	tst_netdev_index_by_name(__FILE__, __LINE__, (ifname))
+
+/* Activate or deactivate network interface */
+int tst_netdev_set_state(const char *file, const int lineno,
+	const char *ifname, int up);
+#define NETDEV_SET_STATE(ifname, up) \
+	tst_netdev_set_state(__FILE__, __LINE__, (ifname), (up))
+
+/* Create a connected pair of virtual network devices */
+int tst_create_veth_pair(const char *file, const int lineno,
+	const char *ifname1, const char *ifname2);
+#define CREATE_VETH_PAIR(ifname1, ifname2) \
+	tst_create_veth_pair(__FILE__, __LINE__, (ifname1), (ifname2))
+
+int tst_remove_netdev(const char *file, const int lineno, const char *ifname);
+#define REMOVE_NETDEV(ifname) tst_remove_netdev(__FILE__, __LINE__, (ifname))
+
+int tst_netdev_add_address(const char *file, const int lineno,
+	const char *ifname, unsigned int family, const void *address,
+	unsigned int prefix, size_t addrlen, unsigned int flags);
+#define NETDEV_ADD_ADDRESS(ifname, family, address, prefix, addrlen, flags) \
+	tst_netdev_add_address(__FILE__, __LINE__, (ifname), (family), \
+		(address), (prefix), (addrlen), (flags))
+
+int tst_netdev_add_address_inet(const char *file, const int lineno,
+	const char *ifname, in_addr_t address, unsigned int prefix,
+	unsigned int flags);
+#define NETDEV_ADD_ADDRESS_INET(ifname, address, prefix, flags) \
+	tst_netdev_add_address_inet(__FILE__, __LINE__, (ifname), (address), \
+		(prefix), (flags))
+
+int tst_netdev_remove_address(const char *file, const int lineno,
+	const char *ifname, unsigned int family, const void *address,
+	size_t addrlen);
+#define NETDEV_REMOVE_ADDRESS(ifname, family, address, addrlen) \
+	tst_netdev_remove_address(__FILE__, __LINE__, (ifname), (family), \
+		(address), (addrlen))
+
+int tst_netdev_remove_address_inet(const char *file, const int lineno,
+	const char *ifname, in_addr_t address);
+#define NETDEV_REMOVE_ADDRESS_INET(ifname, address) \
+	tst_netdev_remove_address_inet(__FILE__, __LINE__, (ifname), (address))
+
+int tst_netdev_change_ns_fd(const char *file, const int lineno,
+	const char *ifname, int nsfd);
+#define NETDEV_CHANGE_NS_FD(ifname, nsfd) \
+	tst_netdev_change_ns_fd(__FILE__, __LINE__, (ifname), (nsfd))
+
+int tst_netdev_change_ns_pid(const char *file, const int lineno,
+	const char *ifname, pid_t nspid);
+#define NETDEV_CHANGE_NS_PID(ifname, nspid) \
+	tst_netdev_change_ns_pid(__FILE__, __LINE__, (ifname), (nspid))
+
+/*
+ * Add new static entry to main routing table. If you specify gateway address,
+ * the interface name is optional.
+ */
+int tst_netdev_add_route(const char *file, const int lineno,
+	const char *ifname, unsigned int family, const void *srcaddr,
+	unsigned int srcprefix, size_t srclen, const void *dstaddr,
+	unsigned int dstprefix, size_t dstlen, const void *gateway,
+	size_t gatewaylen);
+#define NETDEV_ADD_ROUTE(ifname, family, srcaddr, srcprefix, srclen, dstaddr, \
+	dstprefix, dstlen, gateway, gatewaylen) \
+	tst_netdev_add_route(__FILE__, __LINE__, (ifname), (family), \
+		(srcaddr), (srcprefix), (srclen), (dstaddr), (dstprefix), \
+		(dstlen), (gateway), (gatewaylen))
+
+/*
+ * Simplified function for adding IPv4 static route. If you set srcprefix
+ * or dstprefix to 0, the corresponding address will be ignored. Interface
+ * name is optional if gateway address is non-zero.
+ */
+int tst_netdev_add_route_inet(const char *file, const int lineno,
+	const char *ifname, in_addr_t srcaddr, unsigned int srcprefix,
+	in_addr_t dstaddr, unsigned int dstprefix, in_addr_t gateway);
+#define NETDEV_ADD_ROUTE_INET(ifname, srcaddr, srcprefix, dstaddr, dstprefix, \
+	gateway) \
+	tst_netdev_add_route_inet(__FILE__, __LINE__, (ifname), (srcaddr), \
+		(srcprefix), (dstaddr), (dstprefix), (gateway))
+
+/*
+ * Remove static entry from main routing table.
+ */
+int tst_netdev_remove_route(const char *file, const int lineno,
+	const char *ifname, unsigned int family, const void *srcaddr,
+	unsigned int srcprefix, size_t srclen, const void *dstaddr,
+	unsigned int dstprefix, size_t dstlen, const void *gateway,
+	size_t gatewaylen);
+#define NETDEV_REMOVE_ROUTE(ifname, family, srcaddr, srcprefix, srclen, \
+	dstaddr, dstprefix, dstlen, gateway, gatewaylen) \
+	tst_netdev_remove_route(__FILE__, __LINE__, (ifname), (family), \
+		(srcaddr), (srcprefix), (srclen), (dstaddr), (dstprefix), \
+		(dstlen), (gateway), (gatewaylen))
+
+/*
+ * Simplified function for removing IPv4 static route.
+ */
+int tst_netdev_remove_route_inet(const char *file, const int lineno,
+	const char *ifname, in_addr_t srcaddr, unsigned int srcprefix,
+	in_addr_t dstaddr, unsigned int dstprefix, in_addr_t gateway);
+#define NETDEV_REMOVE_ROUTE_INET(ifname, srcaddr, srcprefix, dstaddr, \
+	dstprefix, gateway) \
+	tst_netdev_remove_route_inet(__FILE__, __LINE__, (ifname), (srcaddr), \
+		(srcprefix), (dstaddr), (dstprefix), (gateway))
+
+#endif /* TST_NETDEVICE_H */
diff --git a/lib/tst_netdevice.c b/lib/tst_netdevice.c
new file mode 100644
index 000000000..93019a140
--- /dev/null
+++ b/lib/tst_netdevice.c
@@ -0,0 +1,463 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2021 Linux Test Project
+ */
+
+#include <asm/types.h>
+#include <linux/netlink.h>
+#include <linux/rtnetlink.h>
+#include <linux/veth.h>
+#include <sys/socket.h>
+#include <net/if.h>
+#define TST_NO_DEFAULT_MAIN
+#include "tst_test.h"
+#include "tst_rtnetlink.h"
+#include "tst_netdevice.h"
+
+static struct tst_rtnl_context *create_request(const char *file,
+	const int lineno, unsigned int type, unsigned int flags,
+	const void *payload, size_t psize)
+{
+	struct tst_rtnl_context *ctx;
+	struct nlmsghdr header = {
+		.nlmsg_type = type,
+		.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | flags,
+	};
+
+	ctx = tst_rtnl_create_context(file, lineno);
+
+	if (!ctx)
+		return NULL;
+
+	if (!tst_rtnl_add_message(file, lineno, ctx, &header, payload, psize)) {
+		tst_rtnl_destroy_context(file, lineno, ctx);
+		return NULL;
+	}
+
+	return ctx;
+}
+
+int tst_netdev_index_by_name(const char *file, const int lineno,
+	const char *ifname)
+{
+	struct ifreq ifr;
+	int sock, ret;
+
+	if (strlen(ifname) >= IFNAMSIZ) {
+		tst_brk_(file, lineno, TBROK,
+			"Network device name \"%s\" too long", ifname);
+		return -1;
+	}
+
+	sock = safe_socket(file, lineno, NULL, AF_INET, SOCK_DGRAM, 0);
+
+	if (sock < 0)
+		return -1;
+
+	strcpy(ifr.ifr_name, ifname);
+	ret = SAFE_IOCTL_(file, lineno, sock, SIOCGIFINDEX, &ifr);
+	safe_close(file, lineno, NULL, sock);
+	return ret ? -1 : ifr.ifr_ifindex;
+}
+
+int tst_netdev_set_state(const char *file, const int lineno,
+	const char *ifname, int up)
+{
+	struct ifreq ifr;
+	int sock, ret;
+
+	if (strlen(ifname) >= IFNAMSIZ) {
+		tst_brk_(file, lineno, TBROK,
+			"Network device name \"%s\" too long", ifname);
+		return -1;
+	}
+
+	sock = safe_socket(file, lineno, NULL, AF_INET, SOCK_DGRAM, 0);
+
+	if (sock < 0)
+		return -1;
+
+	strcpy(ifr.ifr_name, ifname);
+	ret = SAFE_IOCTL_(file, lineno, sock, SIOCGIFFLAGS, &ifr);
+
+	if (ret) {
+		safe_close(file, lineno, NULL, sock);
+		return ret;
+	}
+
+	if (up)
+		ifr.ifr_flags |= IFF_UP;
+	else
+		ifr.ifr_flags &= ~IFF_UP;
+
+	ret = SAFE_IOCTL_(file, lineno, sock, SIOCSIFFLAGS, &ifr);
+	safe_close(file, lineno, NULL, sock);
+	return ret;
+}
+
+int tst_create_veth_pair(const char *file, const int lineno,
+	const char *ifname1, const char *ifname2)
+{
+	int ret;
+	struct ifinfomsg info = { .ifi_family = AF_UNSPEC };
+	struct tst_rtnl_context *ctx;
+	struct tst_rtnl_attr_list peerinfo[] = {
+		{IFLA_IFNAME, ifname2, strlen(ifname2) + 1, NULL},
+		{0, NULL, -1, NULL}
+	};
+	struct tst_rtnl_attr_list peerdata[] = {
+		{VETH_INFO_PEER, &info, sizeof(info), peerinfo},
+		{0, NULL, -1, NULL}
+	};
+	struct tst_rtnl_attr_list attrs[] = {
+		{IFLA_IFNAME, ifname1, strlen(ifname1) + 1, NULL},
+		{IFLA_LINKINFO, NULL, 0, (const struct tst_rtnl_attr_list[]){
+			{IFLA_INFO_KIND, "veth", 4, NULL},
+			{IFLA_INFO_DATA, NULL, 0, peerdata},
+			{0, NULL, -1, NULL}
+		}},
+		{0, NULL, -1, NULL}
+	};
+
+	if (strlen(ifname1) >= IFNAMSIZ) {
+		tst_brk_(file, lineno, TBROK,
+			"Network device name \"%s\" too long", ifname1);
+		return 0;
+	}
+
+	if (strlen(ifname2) >= IFNAMSIZ) {
+		tst_brk_(file, lineno, TBROK,
+			"Network device name \"%s\" too long", ifname2);
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
+		tst_brk_(file, lineno, TBROK | TTERRNO,
+			"Failed to create veth interfaces %s+%s", ifname1,
+			ifname2);
+	}
+
+	return ret;
+}
+
+int tst_remove_netdev(const char *file, const int lineno, const char *ifname)
+{
+	struct ifinfomsg info = { .ifi_family = AF_UNSPEC };
+	struct tst_rtnl_context *ctx;
+	int ret;
+
+	if (strlen(ifname) >= IFNAMSIZ) {
+		tst_brk_(file, lineno, TBROK,
+			"Network device name \"%s\" too long", ifname);
+		return 0;
+	}
+
+	ctx = create_request(file, lineno, RTM_DELLINK, 0, &info, sizeof(info));
+
+	if (!ctx)
+		return 0;
+
+	if (!tst_rtnl_add_attr_string(file, lineno, ctx, IFLA_IFNAME, ifname)) {
+		tst_rtnl_destroy_context(file, lineno, ctx);
+		return 0;
+	}
+
+	ret = tst_rtnl_send_validate(file, lineno, ctx);
+	tst_rtnl_destroy_context(file, lineno, ctx);
+
+	if (!ret) {
+		tst_brk_(file, lineno, TBROK | TTERRNO,
+			"Failed to remove netdevice %s", ifname);
+	}
+
+	return ret;
+}
+
+static int modify_address(const char *file, const int lineno,
+	unsigned int action, unsigned int nl_flags, const char *ifname,
+	unsigned int family, const void *address, unsigned int prefix,
+	size_t addrlen, uint32_t addr_flags)
+{
+	struct tst_rtnl_context *ctx;
+	int index, ret;
+	struct ifaddrmsg info = {
+		.ifa_family = family,
+		.ifa_prefixlen = prefix
+	};
+
+	index = tst_netdev_index_by_name(file, lineno, ifname);
+
+	if (index < 0) {
+		tst_brk_(file, lineno, TBROK, "Interface %s not found", ifname);
+		return 0;
+	}
+
+	info.ifa_index = index;
+	ctx = create_request(file, lineno, action, nl_flags, &info,
+		sizeof(info));
+
+	if (!ctx)
+		return 0;
+
+	if (!tst_rtnl_add_attr(file, lineno, ctx, IFA_FLAGS, &addr_flags,
+		sizeof(uint32_t))) {
+		tst_rtnl_destroy_context(file, lineno, ctx);
+		return 0;
+	}
+
+	if (!tst_rtnl_add_attr(file, lineno, ctx, IFA_LOCAL, address,
+		addrlen)) {
+		tst_rtnl_destroy_context(file, lineno, ctx);
+		return 0;
+	}
+
+	ret = tst_rtnl_send_validate(file, lineno, ctx);
+	tst_rtnl_destroy_context(file, lineno, ctx);
+
+	if (!ret) {
+		tst_brk_(file, lineno, TBROK | TTERRNO,
+			"Failed to modify %s network address", ifname);
+	}
+
+	return ret;
+}
+
+int tst_netdev_add_address(const char *file, const int lineno,
+	const char *ifname, unsigned int family, const void *address,
+	unsigned int prefix, size_t addrlen, unsigned int flags)
+{
+	return modify_address(file, lineno, RTM_NEWADDR,
+		NLM_F_CREATE | NLM_F_EXCL, ifname, family, address, prefix,
+		addrlen, flags);
+}
+
+int tst_netdev_add_address_inet(const char *file, const int lineno,
+	const char *ifname, in_addr_t address, unsigned int prefix,
+	unsigned int flags)
+{
+	return tst_netdev_add_address(file, lineno, ifname, AF_INET,
+		&address, prefix, sizeof(address), flags);
+}
+
+int tst_netdev_remove_address(const char *file, const int lineno,
+	const char *ifname, unsigned int family, const void *address,
+	size_t addrlen)
+{
+	return modify_address(file, lineno, RTM_DELADDR, 0, ifname, family,
+		address, 0, addrlen, 0);
+}
+
+int tst_netdev_remove_address_inet(const char *file, const int lineno,
+	const char *ifname, in_addr_t address)
+{
+	return tst_netdev_remove_address(file, lineno, ifname, AF_INET,
+		&address, sizeof(address));
+}
+
+static int change_ns(const char *file, const int lineno, const char *ifname,
+	unsigned short attr, uint32_t value)
+{
+	struct ifinfomsg info = { .ifi_family = AF_UNSPEC };
+	struct tst_rtnl_context *ctx;
+	int ret;
+
+	if (strlen(ifname) >= IFNAMSIZ) {
+		tst_brk_(file, lineno, TBROK,
+			"Network device name \"%s\" too long", ifname);
+		return 0;
+	}
+
+	ctx = create_request(file, lineno, RTM_NEWLINK, 0, &info, sizeof(info));
+
+	if (!tst_rtnl_add_attr_string(file, lineno, ctx, IFLA_IFNAME, ifname)) {
+		tst_rtnl_destroy_context(file, lineno, ctx);
+		return 0;
+	}
+
+	if (!tst_rtnl_add_attr(file, lineno, ctx, attr, &value,
+		sizeof(uint32_t))) {
+		tst_rtnl_destroy_context(file, lineno, ctx);
+		return 0;
+	}
+
+	ret = tst_rtnl_send_validate(file, lineno, ctx);
+	tst_rtnl_destroy_context(file, lineno, ctx);
+
+	if (!ret) {
+		tst_brk_(file, lineno, TBROK | TTERRNO,
+			"Failed to move %s to another namespace", ifname);
+	}
+
+	return ret;
+}
+
+int tst_netdev_change_ns_fd(const char *file, const int lineno,
+	const char *ifname, int nsfd)
+{
+	return change_ns(file, lineno, ifname, IFLA_NET_NS_FD, nsfd);
+}
+
+int tst_netdev_change_ns_pid(const char *file, const int lineno,
+	const char *ifname, pid_t nspid)
+{
+	return change_ns(file, lineno, ifname, IFLA_NET_NS_PID, nspid);
+}
+
+static int modify_route(const char *file, const int lineno, unsigned int action,
+	unsigned int flags, const char *ifname, unsigned int family,
+	const void *srcaddr, unsigned int srcprefix, size_t srclen,
+	const void *dstaddr, unsigned int dstprefix, size_t dstlen,
+	const void *gateway, size_t gatewaylen)
+{
+	struct tst_rtnl_context *ctx;
+	int ret;
+	int32_t index;
+	struct rtmsg info = {
+		.rtm_family = family,
+		.rtm_dst_len = dstprefix,
+		.rtm_src_len = srcprefix,
+		.rtm_table = RT_TABLE_MAIN,
+		.rtm_protocol = RTPROT_STATIC,
+		.rtm_type = RTN_UNICAST
+	};
+
+	if (!ifname && !gateway) {
+		tst_brk_(file, lineno, TBROK,
+			"Interface name or gateway address required");
+		return 0;
+	}
+
+	if (ifname && strlen(ifname) >= IFNAMSIZ) {
+		tst_brk_(file, lineno, TBROK,
+			"Network device name \"%s\" too long", ifname);
+		return 0;
+	}
+
+	if (ifname) {
+		index = tst_netdev_index_by_name(file, lineno, ifname);
+
+		if (index < 0)
+			return 0;
+	}
+
+	if (action == RTM_DELROUTE)
+		info.rtm_scope = RT_SCOPE_NOWHERE;
+	else
+		info.rtm_scope = RT_SCOPE_UNIVERSE;
+
+	ctx = create_request(file, lineno, action, flags, &info, sizeof(info));
+
+	if (srcaddr && !tst_rtnl_add_attr(file, lineno, ctx, RTA_SRC, srcaddr,
+		srclen)) {
+		tst_rtnl_destroy_context(file, lineno, ctx);
+		return 0;
+	}
+
+	if (dstaddr && !tst_rtnl_add_attr(file, lineno, ctx, RTA_DST, dstaddr,
+		dstlen)) {
+		tst_rtnl_destroy_context(file, lineno, ctx);
+		return 0;
+	}
+
+	if (gateway && !tst_rtnl_add_attr(file, lineno, ctx, RTA_GATEWAY,
+		gateway, gatewaylen)) {
+		tst_rtnl_destroy_context(file, lineno, ctx);
+		return 0;
+	}
+
+	if (ifname && !tst_rtnl_add_attr(file, lineno, ctx, RTA_OIF, &index,
+		sizeof(index))) {
+		tst_rtnl_destroy_context(file, lineno, ctx);
+		return 0;
+	}
+
+	ret = tst_rtnl_send_validate(file, lineno, ctx);
+	tst_rtnl_destroy_context(file, lineno, ctx);
+
+	if (!ret) {
+		tst_brk_(file, lineno, TBROK | TTERRNO,
+			"Failed to modify network route");
+	}
+
+	return ret;
+}
+
+static int modify_route_inet(const char *file, const int lineno,
+	unsigned int action, unsigned int flags, const char *ifname,
+	in_addr_t srcaddr, unsigned int srcprefix, in_addr_t dstaddr,
+	unsigned int dstprefix, in_addr_t gateway)
+{
+	void *src = NULL, *dst = NULL, *gw = NULL;
+	size_t srclen = 0, dstlen = 0, gwlen = 0;
+
+	if (srcprefix) {
+		src = &srcaddr;
+		srclen = sizeof(srcaddr);
+	}
+
+	if (dstprefix) {
+		dst = &dstaddr;
+		dstlen = sizeof(dstaddr);
+	}
+
+	if (gateway) {
+		gw = &gateway;
+		gwlen = sizeof(gateway);
+	}
+
+	return modify_route(file, lineno, action, flags, ifname, AF_INET, src,
+		srcprefix, srclen, dst, dstprefix, dstlen, gw, gwlen);
+}
+
+int tst_netdev_add_route(const char *file, const int lineno,
+	const char *ifname, unsigned int family, const void *srcaddr,
+	unsigned int srcprefix, size_t srclen, const void *dstaddr,
+	unsigned int dstprefix, size_t dstlen, const void *gateway,
+	size_t gatewaylen)
+{
+	return modify_route(file, lineno, RTM_NEWROUTE,
+		NLM_F_CREATE | NLM_F_EXCL, ifname, family, srcaddr, srcprefix,
+		srclen, dstaddr, dstprefix, dstlen, gateway, gatewaylen);
+}
+
+int tst_netdev_add_route_inet(const char *file, const int lineno,
+	const char *ifname, in_addr_t srcaddr, unsigned int srcprefix,
+	in_addr_t dstaddr, unsigned int dstprefix, in_addr_t gateway)
+{
+	return modify_route_inet(file, lineno, RTM_NEWROUTE,
+		NLM_F_CREATE | NLM_F_EXCL, ifname, srcaddr, srcprefix, dstaddr,
+		dstprefix, gateway);
+}
+
+int tst_netdev_remove_route(const char *file, const int lineno,
+	const char *ifname, unsigned int family, const void *srcaddr,
+	unsigned int srcprefix, size_t srclen, const void *dstaddr,
+	unsigned int dstprefix, size_t dstlen, const void *gateway,
+	size_t gatewaylen)
+{
+	return modify_route(file, lineno, RTM_DELROUTE, 0, ifname, family,
+		srcaddr, srcprefix, srclen, dstaddr, dstprefix, dstlen,
+		gateway, gatewaylen);
+}
+
+int tst_netdev_remove_route_inet(const char *file, const int lineno,
+	const char *ifname, in_addr_t srcaddr, unsigned int srcprefix,
+	in_addr_t dstaddr, unsigned int dstprefix, in_addr_t gateway)
+{
+	return modify_route_inet(file, lineno, RTM_DELROUTE, 0, ifname,
+		srcaddr, srcprefix, dstaddr, dstprefix, gateway);
+}
-- 
2.31.1

