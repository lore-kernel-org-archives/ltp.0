Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43F9CA0EF3
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 12:50:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 917B43CE73E
	for <ltp@archiver.kernel.org>; Thu, 14 Sep 2023 14:50:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 942163CB235
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 14:50:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 10B89601B30
 for <ltp@lists.linux.it>; Thu, 14 Sep 2023 14:50:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4F4D721845;
 Thu, 14 Sep 2023 12:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694695802; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4tWBG6w7DsT4mzL8xXvTKBiExdXnHTjhpoFdzvOLnow=;
 b=u5Sx6u+TSUyrj+s7vG+hbxRnH6B/1uI5xGzFOWwzmcMTACkmQ1GaGDthMDR5CZSd+tQq15
 5hOP7UQS96JMSIpKMhuAdNO1SyZMYHZ0kNS3DxlUm4zzFX/GqdXkGd+o0fk9ZBi6b4eMbt
 yZazEmqZ2oc2KGBM4Nbxh8cxnL+tjF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694695802;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4tWBG6w7DsT4mzL8xXvTKBiExdXnHTjhpoFdzvOLnow=;
 b=3jC0+VmYm4NwEpDBVvW7UBexs/al1Yk8j+wuMR5VpLp9IWPoyKukovSstRfa7GuDwoCYLd
 24n4LshnqkoeOIBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A21413580;
 Thu, 14 Sep 2023 12:50:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hw5iDXoBA2UIPgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 14 Sep 2023 12:50:02 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>,
	ltp@lists.linux.it
Date: Thu, 14 Sep 2023 14:49:28 +0200
Message-ID: <20230914125001.21803-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] tst_netdevice: Add strict parameter to
 netdevice helper functions
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The strict parameter controls whether errors reported through
rtnetlink ack messages will terminate the test. All convenience
macros for netdevice helper functions are automatically strict.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: New patch

 include/tst_netdevice.h | 100 +++++++++++++-------------
 lib/tst_netdevice.c     | 155 +++++++++++++++++++++-------------------
 2 files changed, 133 insertions(+), 122 deletions(-)

diff --git a/include/tst_netdevice.h b/include/tst_netdevice.h
index 95544814e..5e62ba065 100644
--- a/include/tst_netdevice.h
+++ b/include/tst_netdevice.h
@@ -20,69 +20,70 @@ int tst_netdev_set_state(const char *file, const int lineno,
 	tst_netdev_set_state(__FILE__, __LINE__, (ifname), (up))
 
 /* Create a connected pair of virtual network devices */
-int tst_create_veth_pair(const char *file, const int lineno,
+int tst_create_veth_pair(const char *file, const int lineno, int strict,
 	const char *ifname1, const char *ifname2);
 #define CREATE_VETH_PAIR(ifname1, ifname2) \
-	tst_create_veth_pair(__FILE__, __LINE__, (ifname1), (ifname2))
+	tst_create_veth_pair(__FILE__, __LINE__, 1, (ifname1), (ifname2))
 
-int tst_netdev_add_device(const char *file, const int lineno,
+int tst_netdev_add_device(const char *file, const int lineno, int strict,
 	const char *ifname, const char *devtype);
 #define NETDEV_ADD_DEVICE(ifname, devtype) \
-	tst_netdev_add_device(__FILE__, __LINE__, (ifname), (devtype))
+	tst_netdev_add_device(__FILE__, __LINE__, 1, (ifname), (devtype))
 
-int tst_netdev_remove_device(const char *file, const int lineno,
+int tst_netdev_remove_device(const char *file, const int lineno, int strict,
 	const char *ifname);
 #define NETDEV_REMOVE_DEVICE(ifname) \
-	tst_netdev_remove_device(__FILE__, __LINE__, (ifname))
+	tst_netdev_remove_device(__FILE__, __LINE__, 1, (ifname))
 
-int tst_netdev_add_address(const char *file, const int lineno,
+int tst_netdev_add_address(const char *file, const int lineno, int strict,
 	const char *ifname, unsigned int family, const void *address,
 	unsigned int prefix, size_t addrlen, unsigned int flags);
 #define NETDEV_ADD_ADDRESS(ifname, family, address, prefix, addrlen, flags) \
-	tst_netdev_add_address(__FILE__, __LINE__, (ifname), (family), \
+	tst_netdev_add_address(__FILE__, __LINE__, 1, (ifname), (family), \
 		(address), (prefix), (addrlen), (flags))
 
-int tst_netdev_add_address_inet(const char *file, const int lineno,
+int tst_netdev_add_address_inet(const char *file, const int lineno, int strict,
 	const char *ifname, in_addr_t address, unsigned int prefix,
 	unsigned int flags);
 #define NETDEV_ADD_ADDRESS_INET(ifname, address, prefix, flags) \
-	tst_netdev_add_address_inet(__FILE__, __LINE__, (ifname), (address), \
-		(prefix), (flags))
+	tst_netdev_add_address_inet(__FILE__, __LINE__, 1, (ifname), \
+		(address), (prefix), (flags))
 
-int tst_netdev_remove_address(const char *file, const int lineno,
+int tst_netdev_remove_address(const char *file, const int lineno, int strict,
 	const char *ifname, unsigned int family, const void *address,
 	size_t addrlen);
 #define NETDEV_REMOVE_ADDRESS(ifname, family, address, addrlen) \
-	tst_netdev_remove_address(__FILE__, __LINE__, (ifname), (family), \
+	tst_netdev_remove_address(__FILE__, __LINE__, 1, (ifname), (family), \
 		(address), (addrlen))
 
 int tst_netdev_remove_address_inet(const char *file, const int lineno,
-	const char *ifname, in_addr_t address);
+	int strict, const char *ifname, in_addr_t address);
 #define NETDEV_REMOVE_ADDRESS_INET(ifname, address) \
-	tst_netdev_remove_address_inet(__FILE__, __LINE__, (ifname), (address))
+	tst_netdev_remove_address_inet(__FILE__, __LINE__, 1, (ifname), \
+		(address))
 
-int tst_netdev_change_ns_fd(const char *file, const int lineno,
+int tst_netdev_change_ns_fd(const char *file, const int lineno, int strict,
 	const char *ifname, int nsfd);
 #define NETDEV_CHANGE_NS_FD(ifname, nsfd) \
-	tst_netdev_change_ns_fd(__FILE__, __LINE__, (ifname), (nsfd))
+	tst_netdev_change_ns_fd(__FILE__, __LINE__, 1, (ifname), (nsfd))
 
-int tst_netdev_change_ns_pid(const char *file, const int lineno,
+int tst_netdev_change_ns_pid(const char *file, const int lineno, int strict,
 	const char *ifname, pid_t nspid);
 #define NETDEV_CHANGE_NS_PID(ifname, nspid) \
-	tst_netdev_change_ns_pid(__FILE__, __LINE__, (ifname), (nspid))
+	tst_netdev_change_ns_pid(__FILE__, __LINE__, 1, (ifname), (nspid))
 
 /*
  * Add new static entry to main routing table. If you specify gateway address,
  * the interface name is optional.
  */
-int tst_netdev_add_route(const char *file, const int lineno,
+int tst_netdev_add_route(const char *file, const int lineno, int strict,
 	const char *ifname, unsigned int family, const void *srcaddr,
 	unsigned int srcprefix, size_t srclen, const void *dstaddr,
 	unsigned int dstprefix, size_t dstlen, const void *gateway,
 	size_t gatewaylen);
 #define NETDEV_ADD_ROUTE(ifname, family, srcaddr, srcprefix, srclen, dstaddr, \
 	dstprefix, dstlen, gateway, gatewaylen) \
-	tst_netdev_add_route(__FILE__, __LINE__, (ifname), (family), \
+	tst_netdev_add_route(__FILE__, __LINE__, 1, (ifname), (family), \
 		(srcaddr), (srcprefix), (srclen), (dstaddr), (dstprefix), \
 		(dstlen), (gateway), (gatewaylen))
 
@@ -91,25 +92,25 @@ int tst_netdev_add_route(const char *file, const int lineno,
  * or dstprefix to 0, the corresponding address will be ignored. Interface
  * name is optional if gateway address is non-zero.
  */
-int tst_netdev_add_route_inet(const char *file, const int lineno,
+int tst_netdev_add_route_inet(const char *file, const int lineno, int strict,
 	const char *ifname, in_addr_t srcaddr, unsigned int srcprefix,
 	in_addr_t dstaddr, unsigned int dstprefix, in_addr_t gateway);
 #define NETDEV_ADD_ROUTE_INET(ifname, srcaddr, srcprefix, dstaddr, dstprefix, \
 	gateway) \
-	tst_netdev_add_route_inet(__FILE__, __LINE__, (ifname), (srcaddr), \
+	tst_netdev_add_route_inet(__FILE__, __LINE__, 1, (ifname), (srcaddr), \
 		(srcprefix), (dstaddr), (dstprefix), (gateway))
 
 /*
  * Remove static entry from main routing table.
  */
-int tst_netdev_remove_route(const char *file, const int lineno,
+int tst_netdev_remove_route(const char *file, const int lineno, int strict,
 	const char *ifname, unsigned int family, const void *srcaddr,
 	unsigned int srcprefix, size_t srclen, const void *dstaddr,
 	unsigned int dstprefix, size_t dstlen, const void *gateway,
 	size_t gatewaylen);
 #define NETDEV_REMOVE_ROUTE(ifname, family, srcaddr, srcprefix, srclen, \
 	dstaddr, dstprefix, dstlen, gateway, gatewaylen) \
-	tst_netdev_remove_route(__FILE__, __LINE__, (ifname), (family), \
+	tst_netdev_remove_route(__FILE__, __LINE__, 1, (ifname), (family), \
 		(srcaddr), (srcprefix), (srclen), (dstaddr), (dstprefix), \
 		(dstlen), (gateway), (gatewaylen))
 
@@ -117,32 +118,33 @@ int tst_netdev_remove_route(const char *file, const int lineno,
  * Simplified function for removing IPv4 static route.
  */
 int tst_netdev_remove_route_inet(const char *file, const int lineno,
-	const char *ifname, in_addr_t srcaddr, unsigned int srcprefix,
-	in_addr_t dstaddr, unsigned int dstprefix, in_addr_t gateway);
+	int strict, const char *ifname, in_addr_t srcaddr,
+	unsigned int srcprefix, in_addr_t dstaddr, unsigned int dstprefix,
+	in_addr_t gateway);
 #define NETDEV_REMOVE_ROUTE_INET(ifname, srcaddr, srcprefix, dstaddr, \
 	dstprefix, gateway) \
-	tst_netdev_remove_route_inet(__FILE__, __LINE__, (ifname), (srcaddr), \
-		(srcprefix), (dstaddr), (dstprefix), (gateway))
+	tst_netdev_remove_route_inet(__FILE__, __LINE__, 1, (ifname), \
+		(srcaddr), (srcprefix), (dstaddr), (dstprefix), (gateway))
 
 /*
  * Add queueing discipline. Network interface name is optional.
  */
-int tst_netdev_add_qdisc(const char *file, const int lineno,
+int tst_netdev_add_qdisc(const char *file, const int lineno, int strict,
 	const char *ifname, unsigned int family, unsigned int parent,
 	unsigned int handle, const char *qd_kind,
 	const struct tst_rtnl_attr_list *config);
 #define NETDEV_ADD_QDISC(ifname, family, parent, handle, qd_kind, config) \
-	tst_netdev_add_qdisc(__FILE__, __LINE__, (ifname), (family), \
+	tst_netdev_add_qdisc(__FILE__, __LINE__, 1, (ifname), (family), \
 		(parent), (handle), (qd_kind), (config))
 
 /*
  * Remove queueing discipline.
  */
-int tst_netdev_remove_qdisc(const char *file, const int lineno,
+int tst_netdev_remove_qdisc(const char *file, const int lineno, int strict,
 	const char *ifname, unsigned int family, unsigned int parent,
 	unsigned int handle, const char *qd_kind);
 #define NETDEV_REMOVE_QDISC(ifname, family, parent, handle, qd_kind) \
-	tst_netdev_remove_qdisc(__FILE__, __LINE__, (ifname), (family), \
+	tst_netdev_remove_qdisc(__FILE__, __LINE__, 1, (ifname), (family), \
 		(parent), (handle), (qd_kind))
 
 /*
@@ -150,17 +152,18 @@ int tst_netdev_remove_qdisc(const char *file, const int lineno,
  * optional.
  */
 int tst_netdev_add_traffic_class(const char *file, const int lineno,
-	const char *ifname, unsigned int parent, unsigned int handle,
-	const char *qd_kind, const struct tst_rtnl_attr_list *config);
+	int strict, const char *ifname, unsigned int parent,
+	unsigned int handle, const char *qd_kind,
+	const struct tst_rtnl_attr_list *config);
 #define NETDEV_ADD_TRAFFIC_CLASS(ifname, parent, handle, qd_kind, config) \
-	tst_netdev_add_traffic_class(__FILE__, __LINE__, (ifname), (parent), \
-		(handle), (qd_kind), (config))
+	tst_netdev_add_traffic_class(__FILE__, __LINE__, 1, (ifname), \
+		(parent), (handle), (qd_kind), (config))
 
 int tst_netdev_remove_traffic_class(const char *file, const int lineno,
-	const char *ifname, unsigned int parent, unsigned int handle,
-	const char *qd_kind);
+	int strict, const char *ifname, unsigned int parent,
+	unsigned int handle, const char *qd_kind);
 #define NETDEV_REMOVE_TRAFFIC_CLASS(ifname, parent, handle, qd_kind) \
-	tst_netdev_remove_traffic_class(__FILE__, __LINE__, (ifname), \
+	tst_netdev_remove_traffic_class(__FILE__, __LINE__, 1, (ifname), \
 		(parent), (handle), (qd_kind))
 
 /*
@@ -168,20 +171,21 @@ int tst_netdev_remove_traffic_class(const char *file, const int lineno,
  * constant in host byte order. Network interface name is optional.
  */
 int tst_netdev_add_traffic_filter(const char *file, const int lineno,
-	const char *ifname, unsigned int parent, unsigned int handle,
-	unsigned int protocol, unsigned int priority, const char *f_kind,
-	const struct tst_rtnl_attr_list *config);
+	int strict, const char *ifname, unsigned int parent,
+	unsigned int handle, unsigned int protocol, unsigned int priority,
+	const char *f_kind, const struct tst_rtnl_attr_list *config);
 #define NETDEV_ADD_TRAFFIC_FILTER(ifname, parent, handle, protocol, priority, \
 	f_kind, config) \
-	tst_netdev_add_traffic_filter(__FILE__, __LINE__, (ifname), (parent), \
-		(handle), (protocol), (priority), (f_kind), (config))
+	tst_netdev_add_traffic_filter(__FILE__, __LINE__, 1, (ifname), \
+		(parent), (handle), (protocol), (priority), (f_kind), (config))
 
 int tst_netdev_remove_traffic_filter(const char *file, const int lineno,
-	const char *ifname, unsigned int parent, unsigned int handle,
-	unsigned int protocol, unsigned int priority, const char *f_kind);
+	int strict, const char *ifname, unsigned int parent,
+	unsigned int handle, unsigned int protocol, unsigned int priority,
+	const char *f_kind);
 #define NETDEV_REMOVE_TRAFFIC_FILTER(ifname, parent, handle, protocol, \
 	priority, f_kind) \
-	tst_netdev_remove_traffic_filter(__FILE__, __LINE__, (ifname), \
+	tst_netdev_remove_traffic_filter(__FILE__, __LINE__, 1, (ifname), \
 		(parent), (handle), (protocol), (priority), (f_kind))
 
 #endif /* TST_NETDEVICE_H */
diff --git a/lib/tst_netdevice.c b/lib/tst_netdevice.c
index 9701110a4..dba44c623 100644
--- a/lib/tst_netdevice.c
+++ b/lib/tst_netdevice.c
@@ -98,7 +98,7 @@ int tst_netdev_set_state(const char *file, const int lineno,
 	return ret;
 }
 
-int tst_create_veth_pair(const char *file, const int lineno,
+int tst_create_veth_pair(const char *file, const int lineno, int strict,
 	const char *ifname1, const char *ifname2)
 {
 	int ret;
@@ -148,7 +148,7 @@ int tst_create_veth_pair(const char *file, const int lineno,
 	ret = tst_rtnl_send_validate(file, lineno, ctx);
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
-	if (!ret) {
+	if (strict && !ret) {
 		tst_brk_(file, lineno, TBROK,
 			"Failed to create veth interfaces %s+%s: %s", ifname1,
 			ifname2, tst_strerrno(tst_rtnl_errno));
@@ -157,7 +157,7 @@ int tst_create_veth_pair(const char *file, const int lineno,
 	return ret;
 }
 
-int tst_netdev_add_device(const char *file, const int lineno,
+int tst_netdev_add_device(const char *file, const int lineno, int strict,
 	const char *ifname, const char *devtype)
 {
 	int ret;
@@ -192,7 +192,7 @@ int tst_netdev_add_device(const char *file, const int lineno,
 	ret = tst_rtnl_send_validate(file, lineno, ctx);
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
-	if (!ret) {
+	if (strict && !ret) {
 		tst_brk_(file, lineno, TBROK,
 			"Failed to create %s device %s: %s", devtype, ifname,
 			tst_strerrno(tst_rtnl_errno));
@@ -201,7 +201,7 @@ int tst_netdev_add_device(const char *file, const int lineno,
 	return ret;
 }
 
-int tst_netdev_remove_device(const char *file, const int lineno,
+int tst_netdev_remove_device(const char *file, const int lineno, int strict,
 	const char *ifname)
 {
 	struct ifinfomsg info = { .ifi_family = AF_UNSPEC };
@@ -227,7 +227,7 @@ int tst_netdev_remove_device(const char *file, const int lineno,
 	ret = tst_rtnl_send_validate(file, lineno, ctx);
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
-	if (!ret) {
+	if (strict && !ret) {
 		tst_brk_(file, lineno, TBROK,
 			"Failed to remove netdevice %s: %s", ifname,
 			tst_strerrno(tst_rtnl_errno));
@@ -236,7 +236,7 @@ int tst_netdev_remove_device(const char *file, const int lineno,
 	return ret;
 }
 
-static int modify_address(const char *file, const int lineno,
+static int modify_address(const char *file, const int lineno, int strict,
 	unsigned int action, unsigned int nl_flags, const char *ifname,
 	unsigned int family, const void *address, unsigned int prefix,
 	size_t addrlen, uint32_t addr_flags)
@@ -277,7 +277,7 @@ static int modify_address(const char *file, const int lineno,
 	ret = tst_rtnl_send_validate(file, lineno, ctx);
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
-	if (!ret) {
+	if (strict && !ret) {
 		tst_brk_(file, lineno, TBROK,
 			"Failed to modify %s network address: %s", ifname,
 			tst_strerrno(tst_rtnl_errno));
@@ -286,40 +286,40 @@ static int modify_address(const char *file, const int lineno,
 	return ret;
 }
 
-int tst_netdev_add_address(const char *file, const int lineno,
+int tst_netdev_add_address(const char *file, const int lineno, int strict,
 	const char *ifname, unsigned int family, const void *address,
 	unsigned int prefix, size_t addrlen, unsigned int flags)
 {
-	return modify_address(file, lineno, RTM_NEWADDR,
+	return modify_address(file, lineno, strict, RTM_NEWADDR,
 		NLM_F_CREATE | NLM_F_EXCL, ifname, family, address, prefix,
 		addrlen, flags);
 }
 
-int tst_netdev_add_address_inet(const char *file, const int lineno,
+int tst_netdev_add_address_inet(const char *file, const int lineno, int strict,
 	const char *ifname, in_addr_t address, unsigned int prefix,
 	unsigned int flags)
 {
-	return tst_netdev_add_address(file, lineno, ifname, AF_INET,
+	return tst_netdev_add_address(file, lineno, strict, ifname, AF_INET,
 		&address, prefix, sizeof(address), flags);
 }
 
-int tst_netdev_remove_address(const char *file, const int lineno,
+int tst_netdev_remove_address(const char *file, const int lineno, int strict,
 	const char *ifname, unsigned int family, const void *address,
 	size_t addrlen)
 {
-	return modify_address(file, lineno, RTM_DELADDR, 0, ifname, family,
-		address, 0, addrlen, 0);
+	return modify_address(file, lineno, strict, RTM_DELADDR, 0, ifname,
+		family, address, 0, addrlen, 0);
 }
 
 int tst_netdev_remove_address_inet(const char *file, const int lineno,
-	const char *ifname, in_addr_t address)
+	int strict, const char *ifname, in_addr_t address)
 {
-	return tst_netdev_remove_address(file, lineno, ifname, AF_INET,
+	return tst_netdev_remove_address(file, lineno, strict, ifname, AF_INET,
 		&address, sizeof(address));
 }
 
-static int change_ns(const char *file, const int lineno, const char *ifname,
-	unsigned short attr, uint32_t value)
+static int change_ns(const char *file, const int lineno, int strict,
+	const char *ifname, unsigned short attr, uint32_t value)
 {
 	struct ifinfomsg info = { .ifi_family = AF_UNSPEC };
 	struct tst_rtnl_context *ctx;
@@ -350,7 +350,7 @@ static int change_ns(const char *file, const int lineno, const char *ifname,
 	ret = tst_rtnl_send_validate(file, lineno, ctx);
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
-	if (!ret) {
+	if (strict && !ret) {
 		tst_brk_(file, lineno, TBROK,
 			"Failed to move %s to another namespace: %s", ifname,
 			tst_strerrno(tst_rtnl_errno));
@@ -359,23 +359,23 @@ static int change_ns(const char *file, const int lineno, const char *ifname,
 	return ret;
 }
 
-int tst_netdev_change_ns_fd(const char *file, const int lineno,
+int tst_netdev_change_ns_fd(const char *file, const int lineno, int strict,
 	const char *ifname, int nsfd)
 {
-	return change_ns(file, lineno, ifname, IFLA_NET_NS_FD, nsfd);
+	return change_ns(file, lineno, strict, ifname, IFLA_NET_NS_FD, nsfd);
 }
 
-int tst_netdev_change_ns_pid(const char *file, const int lineno,
+int tst_netdev_change_ns_pid(const char *file, const int lineno, int strict,
 	const char *ifname, pid_t nspid)
 {
-	return change_ns(file, lineno, ifname, IFLA_NET_NS_PID, nspid);
+	return change_ns(file, lineno, strict, ifname, IFLA_NET_NS_PID, nspid);
 }
 
-static int modify_route(const char *file, const int lineno, unsigned int action,
-	unsigned int flags, const char *ifname, unsigned int family,
-	const void *srcaddr, unsigned int srcprefix, size_t srclen,
-	const void *dstaddr, unsigned int dstprefix, size_t dstlen,
-	const void *gateway, size_t gatewaylen)
+static int modify_route(const char *file, const int lineno, int strict,
+	unsigned int action, unsigned int flags, const char *ifname,
+	unsigned int family, const void *srcaddr, unsigned int srcprefix,
+	size_t srclen, const void *dstaddr, unsigned int dstprefix,
+	size_t dstlen, const void *gateway, size_t gatewaylen)
 {
 	struct tst_rtnl_context *ctx;
 	int ret;
@@ -445,7 +445,7 @@ static int modify_route(const char *file, const int lineno, unsigned int action,
 	ret = tst_rtnl_send_validate(file, lineno, ctx);
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
-	if (!ret) {
+	if (strict && !ret) {
 		tst_brk_(file, lineno, TBROK,
 			"Failed to modify network route: %s",
 			tst_strerrno(tst_rtnl_errno));
@@ -454,7 +454,7 @@ static int modify_route(const char *file, const int lineno, unsigned int action,
 	return ret;
 }
 
-static int modify_route_inet(const char *file, const int lineno,
+static int modify_route_inet(const char *file, const int lineno, int strict,
 	unsigned int action, unsigned int flags, const char *ifname,
 	in_addr_t srcaddr, unsigned int srcprefix, in_addr_t dstaddr,
 	unsigned int dstprefix, in_addr_t gateway)
@@ -477,53 +477,55 @@ static int modify_route_inet(const char *file, const int lineno,
 		gwlen = sizeof(gateway);
 	}
 
-	return modify_route(file, lineno, action, flags, ifname, AF_INET, src,
-		srcprefix, srclen, dst, dstprefix, dstlen, gw, gwlen);
+	return modify_route(file, lineno, strict, action, flags, ifname,
+		AF_INET, src, srcprefix, srclen, dst, dstprefix, dstlen, gw,
+		gwlen);
 }
 
-int tst_netdev_add_route(const char *file, const int lineno,
+int tst_netdev_add_route(const char *file, const int lineno, int strict,
 	const char *ifname, unsigned int family, const void *srcaddr,
 	unsigned int srcprefix, size_t srclen, const void *dstaddr,
 	unsigned int dstprefix, size_t dstlen, const void *gateway,
 	size_t gatewaylen)
 {
-	return modify_route(file, lineno, RTM_NEWROUTE,
+	return modify_route(file, lineno, strict, RTM_NEWROUTE,
 		NLM_F_CREATE | NLM_F_EXCL, ifname, family, srcaddr, srcprefix,
 		srclen, dstaddr, dstprefix, dstlen, gateway, gatewaylen);
 }
 
-int tst_netdev_add_route_inet(const char *file, const int lineno,
+int tst_netdev_add_route_inet(const char *file, const int lineno, int strict,
 	const char *ifname, in_addr_t srcaddr, unsigned int srcprefix,
 	in_addr_t dstaddr, unsigned int dstprefix, in_addr_t gateway)
 {
-	return modify_route_inet(file, lineno, RTM_NEWROUTE,
+	return modify_route_inet(file, lineno, strict, RTM_NEWROUTE,
 		NLM_F_CREATE | NLM_F_EXCL, ifname, srcaddr, srcprefix, dstaddr,
 		dstprefix, gateway);
 }
 
-int tst_netdev_remove_route(const char *file, const int lineno,
+int tst_netdev_remove_route(const char *file, const int lineno, int strict,
 	const char *ifname, unsigned int family, const void *srcaddr,
 	unsigned int srcprefix, size_t srclen, const void *dstaddr,
 	unsigned int dstprefix, size_t dstlen, const void *gateway,
 	size_t gatewaylen)
 {
-	return modify_route(file, lineno, RTM_DELROUTE, 0, ifname, family,
-		srcaddr, srcprefix, srclen, dstaddr, dstprefix, dstlen,
+	return modify_route(file, lineno, strict, RTM_DELROUTE, 0, ifname,
+		family, srcaddr, srcprefix, srclen, dstaddr, dstprefix, dstlen,
 		gateway, gatewaylen);
 }
 
 int tst_netdev_remove_route_inet(const char *file, const int lineno,
-	const char *ifname, in_addr_t srcaddr, unsigned int srcprefix,
-	in_addr_t dstaddr, unsigned int dstprefix, in_addr_t gateway)
+	int strict, const char *ifname, in_addr_t srcaddr,
+	unsigned int srcprefix, in_addr_t dstaddr, unsigned int dstprefix,
+	in_addr_t gateway)
 {
-	return modify_route_inet(file, lineno, RTM_DELROUTE, 0, ifname,
+	return modify_route_inet(file, lineno, strict, RTM_DELROUTE, 0, ifname,
 		srcaddr, srcprefix, dstaddr, dstprefix, gateway);
 }
 
-static int modify_qdisc(const char *file, const int lineno, const char *object,
-	unsigned int action, unsigned int nl_flags, const char *ifname,
-	unsigned int family, unsigned int parent, unsigned int handle,
-	unsigned int info, const char *qd_kind,
+static int modify_qdisc(const char *file, const int lineno, int strict,
+	const char *object, unsigned int action, unsigned int nl_flags,
+	const char *ifname, unsigned int family, unsigned int parent,
+	unsigned int handle, unsigned int info, const char *qd_kind,
 	const struct tst_rtnl_attr_list *config)
 {
 	struct tst_rtnl_context *ctx;
@@ -570,7 +572,7 @@ static int modify_qdisc(const char *file, const int lineno, const char *object,
 	ret = tst_rtnl_send_validate(file, lineno, ctx);
 	tst_rtnl_destroy_context(file, lineno, ctx);
 
-	if (!ret) {
+	if (strict && !ret) {
 		tst_brk_(file, lineno, TBROK,
 			"Failed to modify %s: %s", object,
 			tst_strerrno(tst_rtnl_errno));
@@ -579,56 +581,61 @@ static int modify_qdisc(const char *file, const int lineno, const char *object,
 	return ret;
 }
 
-int tst_netdev_add_qdisc(const char *file, const int lineno,
+int tst_netdev_add_qdisc(const char *file, const int lineno, int strict,
 	const char *ifname, unsigned int family, unsigned int parent,
 	unsigned int handle, const char *qd_kind,
 	const struct tst_rtnl_attr_list *config)
 {
-	return modify_qdisc(file, lineno, "queueing discipline", RTM_NEWQDISC,
-		NLM_F_CREATE | NLM_F_EXCL, ifname, family, parent, handle, 0,
-		qd_kind, config);
+	return modify_qdisc(file, lineno, strict, "queueing discipline",
+		RTM_NEWQDISC, NLM_F_CREATE | NLM_F_EXCL, ifname, family,
+		parent, handle, 0, qd_kind, config);
 }
 
-int tst_netdev_remove_qdisc(const char *file, const int lineno,
+int tst_netdev_remove_qdisc(const char *file, const int lineno, int strict,
 	const char *ifname, unsigned int family, unsigned int parent,
 	unsigned int handle, const char *qd_kind)
 {
-	return modify_qdisc(file, lineno, "queueing discipline", RTM_DELQDISC,
-		0, ifname, family, parent, handle, 0, qd_kind, NULL);
+	return modify_qdisc(file, lineno, strict, "queueing discipline",
+		RTM_DELQDISC, 0, ifname, family, parent, handle, 0, qd_kind,
+		NULL);
 }
 
 int tst_netdev_add_traffic_class(const char *file, const int lineno,
-	const char *ifname, unsigned int parent, unsigned int handle,
-	const char *qd_kind, const struct tst_rtnl_attr_list *config)
+	int strict, const char *ifname, unsigned int parent,
+	unsigned int handle, const char *qd_kind,
+	const struct tst_rtnl_attr_list *config)
 {
-	return modify_qdisc(file, lineno, "traffic class", RTM_NEWTCLASS,
-		NLM_F_CREATE | NLM_F_EXCL, ifname, AF_UNSPEC, parent, handle,
-		0, qd_kind, config);
+	return modify_qdisc(file, lineno, strict, "traffic class",
+		RTM_NEWTCLASS, NLM_F_CREATE | NLM_F_EXCL, ifname, AF_UNSPEC,
+		parent, handle, 0, qd_kind, config);
 }
 
 int tst_netdev_remove_traffic_class(const char *file, const int lineno,
-	const char *ifname, unsigned int parent, unsigned int handle,
-	const char *qd_kind)
+	int strict, const char *ifname, unsigned int parent,
+	unsigned int handle, const char *qd_kind)
 {
-	return modify_qdisc(file, lineno, "traffic class", RTM_DELTCLASS, 0,
-		ifname, AF_UNSPEC, parent, handle, 0, qd_kind, NULL);
+	return modify_qdisc(file, lineno, strict, "traffic class",
+		RTM_DELTCLASS, 0, ifname, AF_UNSPEC, parent, handle, 0,
+		qd_kind, NULL);
 }
 
 int tst_netdev_add_traffic_filter(const char *file, const int lineno,
-	const char *ifname, unsigned int parent, unsigned int handle,
-	unsigned int protocol, unsigned int priority, const char *f_kind,
-	const struct tst_rtnl_attr_list *config)
+	int strict, const char *ifname, unsigned int parent,
+	unsigned int handle, unsigned int protocol, unsigned int priority,
+	const char *f_kind, const struct tst_rtnl_attr_list *config)
 {
-	return modify_qdisc(file, lineno, "traffic filter", RTM_NEWTFILTER,
-		NLM_F_CREATE | NLM_F_EXCL, ifname, AF_UNSPEC, parent, handle,
-		TC_H_MAKE(priority << 16, htons(protocol)), f_kind, config);
+	return modify_qdisc(file, lineno, strict, "traffic filter",
+		RTM_NEWTFILTER, NLM_F_CREATE | NLM_F_EXCL, ifname, AF_UNSPEC,
+		parent, handle, TC_H_MAKE(priority << 16, htons(protocol)),
+		f_kind, config);
 }
 
 int tst_netdev_remove_traffic_filter(const char *file, const int lineno,
-	const char *ifname, unsigned int parent, unsigned int handle,
-	unsigned int protocol, unsigned int priority, const char *f_kind)
+	int strict, const char *ifname, unsigned int parent,
+	unsigned int handle, unsigned int protocol, unsigned int priority,
+	const char *f_kind)
 {
-	return modify_qdisc(file, lineno, "traffic filter", RTM_DELTFILTER,
-		0, ifname, AF_UNSPEC, parent, handle,
+	return modify_qdisc(file, lineno, strict, "traffic filter",
+		RTM_DELTFILTER, 0, ifname, AF_UNSPEC, parent, handle,
 		TC_H_MAKE(priority << 16, htons(protocol)), f_kind, NULL);
 }
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
