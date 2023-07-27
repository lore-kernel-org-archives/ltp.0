Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC0E0C0015E
	for <ltp@archiver.kernel.org>; Thu, 27 Jul 2023 15:00:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E03D93CE6CB
	for <ltp@archiver.kernel.org>; Thu, 27 Jul 2023 17:00:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A3003CD6C7
 for <ltp@lists.linux.it>; Thu, 27 Jul 2023 17:00:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5A5C31A0238C
 for <ltp@lists.linux.it>; Thu, 27 Jul 2023 17:00:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7902B1F86C
 for <ltp@lists.linux.it>; Thu, 27 Jul 2023 15:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1690470014; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DBeEGDbGN2CHLlzW1eA3fGD9UOexPmhzEP57cdIEm9w=;
 b=PEvhWoDEUmNRALkoNSkWZ207vfXwDGfFFrkVpFoP5Delt2YNCQfX7eAnXjGMNUQmlnz5vD
 uY8117r8AzRhGtMOv+32eX4D1Rkf4s29B4mrLcxbc3ZjU/LD6PdYgpEEbQIxKcV0x828QJ
 p+3Jbhs6qmK+WamQHHEqHrXxOqveIEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1690470014;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DBeEGDbGN2CHLlzW1eA3fGD9UOexPmhzEP57cdIEm9w=;
 b=nNMHiOQS/zqWyZUal2d1NvSyq8t91N8ruacgW+4Z0E8rAwsHzJw1js0i6mwTZVWCDtycLQ
 QMZJAH6y5PH6X1Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 68F7513902
 for <ltp@lists.linux.it>; Thu, 27 Jul 2023 15:00:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EBxXGH6GwmQMHwAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Jul 2023 15:00:14 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Jul 2023 17:00:11 +0200
Message-ID: <20230727150013.31835-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230727150013.31835-1-mdoucha@suse.cz>
References: <20230727150013.31835-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] tst_netdevice: Add helper functions for qdisc and
 filter management
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

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 include/tst_netdevice.h |  62 ++++++++++++++++++++++
 lib/tst_netdevice.c     | 114 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+)

diff --git a/include/tst_netdevice.h b/include/tst_netdevice.h
index f02661208..95544814e 100644
--- a/include/tst_netdevice.h
+++ b/include/tst_netdevice.h
@@ -5,6 +5,8 @@
 #ifndef TST_NETDEVICE_H
 #define TST_NETDEVICE_H
 
+#include "tst_rtnetlink.h"
+
 /* Find device index for given network interface name. */
 int tst_netdev_index_by_name(const char *file, const int lineno,
 	const char *ifname);
@@ -122,4 +124,64 @@ int tst_netdev_remove_route_inet(const char *file, const int lineno,
 	tst_netdev_remove_route_inet(__FILE__, __LINE__, (ifname), (srcaddr), \
 		(srcprefix), (dstaddr), (dstprefix), (gateway))
 
+/*
+ * Add queueing discipline. Network interface name is optional.
+ */
+int tst_netdev_add_qdisc(const char *file, const int lineno,
+	const char *ifname, unsigned int family, unsigned int parent,
+	unsigned int handle, const char *qd_kind,
+	const struct tst_rtnl_attr_list *config);
+#define NETDEV_ADD_QDISC(ifname, family, parent, handle, qd_kind, config) \
+	tst_netdev_add_qdisc(__FILE__, __LINE__, (ifname), (family), \
+		(parent), (handle), (qd_kind), (config))
+
+/*
+ * Remove queueing discipline.
+ */
+int tst_netdev_remove_qdisc(const char *file, const int lineno,
+	const char *ifname, unsigned int family, unsigned int parent,
+	unsigned int handle, const char *qd_kind);
+#define NETDEV_REMOVE_QDISC(ifname, family, parent, handle, qd_kind) \
+	tst_netdev_remove_qdisc(__FILE__, __LINE__, (ifname), (family), \
+		(parent), (handle), (qd_kind))
+
+/*
+ * Add traffic class to queueing discipline. Network interface name is
+ * optional.
+ */
+int tst_netdev_add_traffic_class(const char *file, const int lineno,
+	const char *ifname, unsigned int parent, unsigned int handle,
+	const char *qd_kind, const struct tst_rtnl_attr_list *config);
+#define NETDEV_ADD_TRAFFIC_CLASS(ifname, parent, handle, qd_kind, config) \
+	tst_netdev_add_traffic_class(__FILE__, __LINE__, (ifname), (parent), \
+		(handle), (qd_kind), (config))
+
+int tst_netdev_remove_traffic_class(const char *file, const int lineno,
+	const char *ifname, unsigned int parent, unsigned int handle,
+	const char *qd_kind);
+#define NETDEV_REMOVE_TRAFFIC_CLASS(ifname, parent, handle, qd_kind) \
+	tst_netdev_remove_traffic_class(__FILE__, __LINE__, (ifname), \
+		(parent), (handle), (qd_kind))
+
+/*
+ * Add traffic filter to queueing discipline. Protocol should be en ETH_P_*
+ * constant in host byte order. Network interface name is optional.
+ */
+int tst_netdev_add_traffic_filter(const char *file, const int lineno,
+	const char *ifname, unsigned int parent, unsigned int handle,
+	unsigned int protocol, unsigned int priority, const char *f_kind,
+	const struct tst_rtnl_attr_list *config);
+#define NETDEV_ADD_TRAFFIC_FILTER(ifname, parent, handle, protocol, priority, \
+	f_kind, config) \
+	tst_netdev_add_traffic_filter(__FILE__, __LINE__, (ifname), (parent), \
+		(handle), (protocol), (priority), (f_kind), (config))
+
+int tst_netdev_remove_traffic_filter(const char *file, const int lineno,
+	const char *ifname, unsigned int parent, unsigned int handle,
+	unsigned int protocol, unsigned int priority, const char *f_kind);
+#define NETDEV_REMOVE_TRAFFIC_FILTER(ifname, parent, handle, protocol, \
+	priority, f_kind) \
+	tst_netdev_remove_traffic_filter(__FILE__, __LINE__, (ifname), \
+		(parent), (handle), (protocol), (priority), (f_kind))
+
 #endif /* TST_NETDEVICE_H */
diff --git a/lib/tst_netdevice.c b/lib/tst_netdevice.c
index a57f506e9..9701110a4 100644
--- a/lib/tst_netdevice.c
+++ b/lib/tst_netdevice.c
@@ -7,6 +7,7 @@
 #include <linux/veth.h>
 #include <sys/socket.h>
 #include <net/if.h>
+#include <linux/pkt_sched.h>
 #include "lapi/rtnetlink.h"
 
 #define TST_NO_DEFAULT_MAIN
@@ -518,3 +519,116 @@ int tst_netdev_remove_route_inet(const char *file, const int lineno,
 	return modify_route_inet(file, lineno, RTM_DELROUTE, 0, ifname,
 		srcaddr, srcprefix, dstaddr, dstprefix, gateway);
 }
+
+static int modify_qdisc(const char *file, const int lineno, const char *object,
+	unsigned int action, unsigned int nl_flags, const char *ifname,
+	unsigned int family, unsigned int parent, unsigned int handle,
+	unsigned int info, const char *qd_kind,
+	const struct tst_rtnl_attr_list *config)
+{
+	struct tst_rtnl_context *ctx;
+	int ret;
+	struct tcmsg msg = {
+		.tcm_family = family,
+		.tcm_handle = handle,
+		.tcm_parent = parent,
+		.tcm_info = info
+	};
+
+	if (!qd_kind) {
+		tst_brk_(file, lineno, TBROK,
+			"Queueing discipline name required");
+		return 0;
+	}
+
+	if (ifname) {
+		msg.tcm_ifindex = tst_netdev_index_by_name(file, lineno,
+			ifname);
+
+		if (msg.tcm_ifindex < 0) {
+			tst_brk_(file, lineno, TBROK, "Interface %s not found",
+				ifname);
+			return 0;
+		}
+	}
+
+	ctx = create_request(file, lineno, action, nl_flags, &msg, sizeof(msg));
+
+	if (!ctx)
+		return 0;
+
+	if (!tst_rtnl_add_attr_string(file, lineno, ctx, TCA_KIND, qd_kind)) {
+		tst_rtnl_destroy_context(file, lineno, ctx);
+		return 0;
+	}
+
+	if (config && !tst_rtnl_add_attr_list(file, lineno, ctx, config)) {
+		tst_rtnl_destroy_context(file, lineno, ctx);
+		return 0;
+	}
+
+	ret = tst_rtnl_send_validate(file, lineno, ctx);
+	tst_rtnl_destroy_context(file, lineno, ctx);
+
+	if (!ret) {
+		tst_brk_(file, lineno, TBROK,
+			"Failed to modify %s: %s", object,
+			tst_strerrno(tst_rtnl_errno));
+	}
+
+	return ret;
+}
+
+int tst_netdev_add_qdisc(const char *file, const int lineno,
+	const char *ifname, unsigned int family, unsigned int parent,
+	unsigned int handle, const char *qd_kind,
+	const struct tst_rtnl_attr_list *config)
+{
+	return modify_qdisc(file, lineno, "queueing discipline", RTM_NEWQDISC,
+		NLM_F_CREATE | NLM_F_EXCL, ifname, family, parent, handle, 0,
+		qd_kind, config);
+}
+
+int tst_netdev_remove_qdisc(const char *file, const int lineno,
+	const char *ifname, unsigned int family, unsigned int parent,
+	unsigned int handle, const char *qd_kind)
+{
+	return modify_qdisc(file, lineno, "queueing discipline", RTM_DELQDISC,
+		0, ifname, family, parent, handle, 0, qd_kind, NULL);
+}
+
+int tst_netdev_add_traffic_class(const char *file, const int lineno,
+	const char *ifname, unsigned int parent, unsigned int handle,
+	const char *qd_kind, const struct tst_rtnl_attr_list *config)
+{
+	return modify_qdisc(file, lineno, "traffic class", RTM_NEWTCLASS,
+		NLM_F_CREATE | NLM_F_EXCL, ifname, AF_UNSPEC, parent, handle,
+		0, qd_kind, config);
+}
+
+int tst_netdev_remove_traffic_class(const char *file, const int lineno,
+	const char *ifname, unsigned int parent, unsigned int handle,
+	const char *qd_kind)
+{
+	return modify_qdisc(file, lineno, "traffic class", RTM_DELTCLASS, 0,
+		ifname, AF_UNSPEC, parent, handle, 0, qd_kind, NULL);
+}
+
+int tst_netdev_add_traffic_filter(const char *file, const int lineno,
+	const char *ifname, unsigned int parent, unsigned int handle,
+	unsigned int protocol, unsigned int priority, const char *f_kind,
+	const struct tst_rtnl_attr_list *config)
+{
+	return modify_qdisc(file, lineno, "traffic filter", RTM_NEWTFILTER,
+		NLM_F_CREATE | NLM_F_EXCL, ifname, AF_UNSPEC, parent, handle,
+		TC_H_MAKE(priority << 16, htons(protocol)), f_kind, config);
+}
+
+int tst_netdev_remove_traffic_filter(const char *file, const int lineno,
+	const char *ifname, unsigned int parent, unsigned int handle,
+	unsigned int protocol, unsigned int priority, const char *f_kind)
+{
+	return modify_qdisc(file, lineno, "traffic filter", RTM_DELTFILTER,
+		0, ifname, AF_UNSPEC, parent, handle,
+		TC_H_MAKE(priority << 16, htons(protocol)), f_kind, NULL);
+}
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
