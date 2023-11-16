Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99AD1C197A0
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 16:47:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0A753CE3B6
	for <ltp@archiver.kernel.org>; Thu, 16 Nov 2023 17:47:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92A003CC1C9
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 17:47:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D1864600807
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 17:47:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9EB4F22940
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 16:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1700153245; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5jZ3nxU5gUAvnDmx7ryQORvCKmk5Lx7CcMEYNxomk9w=;
 b=iObvgt/BrZXutB8LUCz4R9/jF/OLY7TvmLxIZZnbiLMPB9xVKrtf22jjHBcEa98awDjm4K
 17K3rj9E/0ZUznSKwKaqX6JX3VKhn08XNleEl/eHS5PucemDxozZN0aoJDCNdSBclBNF1a
 N4rJcYY6RX5sVUGtmmBbszOOuFf2ivY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1700153245;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5jZ3nxU5gUAvnDmx7ryQORvCKmk5Lx7CcMEYNxomk9w=;
 b=4LCAYtu88m0USLMnJVH7G07FLiCwF5ldmvVTrYIMSzoXCjTJoLWTngmkipvGBCJ54dXhai
 0iN2j8s2qfft/7Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 873B213A67
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 16:47:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EKwPIJ1HVmVtAwAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 16 Nov 2023 16:47:25 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 16 Nov 2023 17:46:54 +0100
Message-ID: <20231116164723.4012-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231116164723.4012-1-mdoucha@suse.cz>
References: <20231116164723.4012-1-mdoucha@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 BROKEN_CONTENT_TYPE(1.50)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.986]; MID_CONTAINS_FROM(1.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/4] tst_netlink: Add helper functions for handling
 generic attributes
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

Refactor struct tst_rtnl_attr_list for generic use and add helper
functions for handling generic struct nlattr message attributes.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: New patch
Changes since v2: None

 include/tst_netdevice.h   |  6 +--
 include/tst_netlink.h     | 38 ++++++++++++++----
 lib/tst_netdevice.c       | 20 +++++-----
 lib/tst_netlink.c         | 82 ++++++++++++++++++++++++++++++++++++++-
 testcases/cve/tcindex01.c | 12 +++---
 5 files changed, 131 insertions(+), 27 deletions(-)

diff --git a/include/tst_netdevice.h b/include/tst_netdevice.h
index 4239d0960..8d40148a6 100644
--- a/include/tst_netdevice.h
+++ b/include/tst_netdevice.h
@@ -132,7 +132,7 @@ int tst_netdev_remove_route_inet(const char *file, const int lineno,
 int tst_netdev_add_qdisc(const char *file, const int lineno, int strict,
 	const char *ifname, unsigned int family, unsigned int parent,
 	unsigned int handle, const char *qd_kind,
-	const struct tst_rtnl_attr_list *config);
+	const struct tst_netlink_attr_list *config);
 #define NETDEV_ADD_QDISC(ifname, family, parent, handle, qd_kind, config) \
 	tst_netdev_add_qdisc(__FILE__, __LINE__, 1, (ifname), (family), \
 		(parent), (handle), (qd_kind), (config))
@@ -154,7 +154,7 @@ int tst_netdev_remove_qdisc(const char *file, const int lineno, int strict,
 int tst_netdev_add_traffic_class(const char *file, const int lineno,
 	int strict, const char *ifname, unsigned int parent,
 	unsigned int handle, const char *qd_kind,
-	const struct tst_rtnl_attr_list *config);
+	const struct tst_netlink_attr_list *config);
 #define NETDEV_ADD_TRAFFIC_CLASS(ifname, parent, handle, qd_kind, config) \
 	tst_netdev_add_traffic_class(__FILE__, __LINE__, 1, (ifname), \
 		(parent), (handle), (qd_kind), (config))
@@ -173,7 +173,7 @@ int tst_netdev_remove_traffic_class(const char *file, const int lineno,
 int tst_netdev_add_traffic_filter(const char *file, const int lineno,
 	int strict, const char *ifname, unsigned int parent,
 	unsigned int handle, unsigned int protocol, unsigned int priority,
-	const char *f_kind, const struct tst_rtnl_attr_list *config);
+	const char *f_kind, const struct tst_netlink_attr_list *config);
 #define NETDEV_ADD_TRAFFIC_FILTER(ifname, parent, handle, protocol, priority, \
 	f_kind, config) \
 	tst_netdev_add_traffic_filter(__FILE__, __LINE__, 1, (ifname), \
diff --git a/include/tst_netlink.h b/include/tst_netlink.h
index f10f1cf5d..7d96fd711 100644
--- a/include/tst_netlink.h
+++ b/include/tst_netlink.h
@@ -9,11 +9,11 @@
 
 struct tst_netlink_context;
 
-struct tst_rtnl_attr_list {
+struct tst_netlink_attr_list {
 	unsigned short type;
 	const void *data;
 	ssize_t len;
-	const struct tst_rtnl_attr_list *sublist;
+	const struct tst_netlink_attr_list *sublist;
 };
 
 struct tst_netlink_message {
@@ -72,25 +72,49 @@ int tst_netlink_add_message(const char *file, const int lineno,
 	tst_netlink_add_message(__FILE__, __LINE__, (ctx), (header), \
 		(payload), (psize))
 
-/* Add arbitrary attribute to last message */
+/* Add arbitrary nlattr attribute to last message */
+int tst_netlink_add_attr(const char *file, const int lineno,
+	struct tst_netlink_context *ctx, unsigned short type, const void *data,
+	unsigned short len);
+#define NETLINK_ADD_ATTR(ctx, type, data, len) \
+	tst_netlink_add_attr(__FILE__, __LINE__, (ctx), (type), (data), (len))
+
+/* Add string nlattr attribute to last message */
+int tst_netlink_add_attr_string(const char *file, const int lineno,
+	struct tst_netlink_context *ctx, unsigned short type, const char *data);
+#define NETLINK_ADD_ATTR_STRING(ctx, type, data) \
+	tst_netlink_add_attr_string(__FILE__, __LINE__, (ctx), (type), (data))
+
+/*
+ * Add list of arbitrary nlattr attributes to last message. The list is
+ * terminated by attribute with negative length. Nested sublists are supported.
+ */
+int tst_netlink_add_attr_list(const char *file, const int lineno,
+	struct tst_netlink_context *ctx,
+	const struct tst_netlink_attr_list *list);
+#define NETLINK_ADD_ATTR_LIST(ctx, list) \
+	tst_netlink_add_attr_list(__FILE__, __LINE__, (ctx), (list))
+
+/* Add arbitrary rtattr attribute to last message */
 int tst_rtnl_add_attr(const char *file, const int lineno,
 	struct tst_netlink_context *ctx, unsigned short type, const void *data,
 	unsigned short len);
 #define RTNL_ADD_ATTR(ctx, type, data, len) \
 	tst_rtnl_add_attr(__FILE__, __LINE__, (ctx), (type), (data), (len))
 
-/* Add string attribute to last message */
+/* Add string rtattr attribute to last message */
 int tst_rtnl_add_attr_string(const char *file, const int lineno,
 	struct tst_netlink_context *ctx, unsigned short type, const char *data);
 #define RTNL_ADD_ATTR_STRING(ctx, type, data) \
 	tst_rtnl_add_attr_string(__FILE__, __LINE__, (ctx), (type), (data))
 
 /*
- * Add list of arbitrary attributes to last message. The list is terminated
- * by attribute with negative length. Nested sublists are supported.
+ * Add list of arbitrary rtattr attributes to last message. The list is
+ * terminated by attribute with negative length. Nested sublists are supported.
  */
 int tst_rtnl_add_attr_list(const char *file, const int lineno,
-	struct tst_netlink_context *ctx, const struct tst_rtnl_attr_list *list);
+	struct tst_netlink_context *ctx,
+	const struct tst_netlink_attr_list *list);
 #define RTNL_ADD_ATTR_LIST(ctx, list) \
 	tst_rtnl_add_attr_list(__FILE__, __LINE__, (ctx), (list))
 
diff --git a/lib/tst_netdevice.c b/lib/tst_netdevice.c
index 6f86b8089..1042466bf 100644
--- a/lib/tst_netdevice.c
+++ b/lib/tst_netdevice.c
@@ -105,17 +105,17 @@ int tst_create_veth_pair(const char *file, const int lineno, int strict,
 	int ret;
 	struct ifinfomsg info = { .ifi_family = AF_UNSPEC };
 	struct tst_netlink_context *ctx;
-	struct tst_rtnl_attr_list peerinfo[] = {
+	struct tst_netlink_attr_list peerinfo[] = {
 		{IFLA_IFNAME, ifname2, strlen(ifname2) + 1, NULL},
 		{0, NULL, -1, NULL}
 	};
-	struct tst_rtnl_attr_list peerdata[] = {
+	struct tst_netlink_attr_list peerdata[] = {
 		{VETH_INFO_PEER, &info, sizeof(info), peerinfo},
 		{0, NULL, -1, NULL}
 	};
-	struct tst_rtnl_attr_list attrs[] = {
+	struct tst_netlink_attr_list attrs[] = {
 		{IFLA_IFNAME, ifname1, strlen(ifname1) + 1, NULL},
-		{IFLA_LINKINFO, NULL, 0, (const struct tst_rtnl_attr_list[]){
+		{IFLA_LINKINFO, NULL, 0, (const struct tst_netlink_attr_list[]){
 			{IFLA_INFO_KIND, "veth", 4, NULL},
 			{IFLA_INFO_DATA, NULL, 0, peerdata},
 			{0, NULL, -1, NULL}
@@ -164,9 +164,9 @@ int tst_netdev_add_device(const char *file, const int lineno, int strict,
 	int ret;
 	struct ifinfomsg info = { .ifi_family = AF_UNSPEC };
 	struct tst_netlink_context *ctx;
-	struct tst_rtnl_attr_list attrs[] = {
+	struct tst_netlink_attr_list attrs[] = {
 		{IFLA_IFNAME, ifname, strlen(ifname) + 1, NULL},
-		{IFLA_LINKINFO, NULL, 0, (const struct tst_rtnl_attr_list[]){
+		{IFLA_LINKINFO, NULL, 0, (const struct tst_netlink_attr_list[]){
 			{IFLA_INFO_KIND, devtype, strlen(devtype), NULL},
 			{0, NULL, -1, NULL}
 		}},
@@ -527,7 +527,7 @@ static int modify_qdisc(const char *file, const int lineno, int strict,
 	const char *object, unsigned int action, unsigned int nl_flags,
 	const char *ifname, unsigned int family, unsigned int parent,
 	unsigned int handle, unsigned int info, const char *qd_kind,
-	const struct tst_rtnl_attr_list *config)
+	const struct tst_netlink_attr_list *config)
 {
 	struct tst_netlink_context *ctx;
 	int ret;
@@ -585,7 +585,7 @@ static int modify_qdisc(const char *file, const int lineno, int strict,
 int tst_netdev_add_qdisc(const char *file, const int lineno, int strict,
 	const char *ifname, unsigned int family, unsigned int parent,
 	unsigned int handle, const char *qd_kind,
-	const struct tst_rtnl_attr_list *config)
+	const struct tst_netlink_attr_list *config)
 {
 	return modify_qdisc(file, lineno, strict, "queueing discipline",
 		RTM_NEWQDISC, NLM_F_CREATE | NLM_F_EXCL, ifname, family,
@@ -604,7 +604,7 @@ int tst_netdev_remove_qdisc(const char *file, const int lineno, int strict,
 int tst_netdev_add_traffic_class(const char *file, const int lineno,
 	int strict, const char *ifname, unsigned int parent,
 	unsigned int handle, const char *qd_kind,
-	const struct tst_rtnl_attr_list *config)
+	const struct tst_netlink_attr_list *config)
 {
 	return modify_qdisc(file, lineno, strict, "traffic class",
 		RTM_NEWTCLASS, NLM_F_CREATE | NLM_F_EXCL, ifname, AF_UNSPEC,
@@ -623,7 +623,7 @@ int tst_netdev_remove_traffic_class(const char *file, const int lineno,
 int tst_netdev_add_traffic_filter(const char *file, const int lineno,
 	int strict, const char *ifname, unsigned int parent,
 	unsigned int handle, unsigned int protocol, unsigned int priority,
-	const char *f_kind, const struct tst_rtnl_attr_list *config)
+	const char *f_kind, const struct tst_netlink_attr_list *config)
 {
 	return modify_qdisc(file, lineno, strict, "traffic filter",
 		RTM_NEWTFILTER, NLM_F_CREATE | NLM_F_EXCL, ifname, AF_UNSPEC,
diff --git a/lib/tst_netlink.c b/lib/tst_netlink.c
index bd05df81a..7bc98af56 100644
--- a/lib/tst_netlink.c
+++ b/lib/tst_netlink.c
@@ -283,6 +283,86 @@ int tst_netlink_add_message(const char *file, const int lineno,
 	return 1;
 }
 
+int tst_netlink_add_attr(const char *file, const int lineno,
+	struct tst_netlink_context *ctx, unsigned short type,
+	const void *data, unsigned short len)
+{
+	size_t size = NLA_HDRLEN + NLA_ALIGN(len);
+	struct nlattr *attr;
+
+	if (!ctx->curmsg) {
+		tst_brk_(file, lineno, TBROK,
+			"%s(): No message to add attributes to", __func__);
+		return 0;
+	}
+
+	if (!netlink_grow_buffer(file, lineno, ctx, size))
+		return 0;
+
+	size = NLMSG_ALIGN(ctx->curmsg->nlmsg_len);
+	attr = (struct nlattr *)(((char *)ctx->curmsg) + size);
+	attr->nla_type = type;
+	attr->nla_len = NLA_HDRLEN + len;
+	memcpy(((char *)attr) + NLA_HDRLEN, data, len);
+	ctx->curmsg->nlmsg_len = size + attr->nla_len;
+	ctx->datalen = NLMSG_ALIGN(ctx->datalen) + attr->nla_len;
+
+	return 1;
+}
+
+int tst_netlink_add_attr_string(const char *file, const int lineno,
+	struct tst_netlink_context *ctx, unsigned short type,
+	const char *data)
+{
+	return tst_netlink_add_attr(file, lineno, ctx, type, data,
+		strlen(data) + 1);
+}
+
+int tst_netlink_add_attr_list(const char *file, const int lineno,
+	struct tst_netlink_context *ctx,
+	const struct tst_netlink_attr_list *list)
+{
+	int i, ret;
+	size_t offset;
+
+	for (i = 0; list[i].len >= 0; i++) {
+		if (list[i].len > USHRT_MAX) {
+			tst_brk_(file, lineno, TBROK,
+				"%s(): Attribute value too long", __func__);
+			return -1;
+		}
+
+		offset = NLMSG_ALIGN(ctx->datalen);
+		ret = tst_netlink_add_attr(file, lineno, ctx, list[i].type,
+			list[i].data, list[i].len);
+
+		if (!ret)
+			return -1;
+
+		if (list[i].sublist) {
+			struct rtattr *attr;
+
+			ret = tst_netlink_add_attr_list(file, lineno, ctx,
+				list[i].sublist);
+
+			if (ret < 0)
+				return ret;
+
+			attr = (struct rtattr *)(ctx->buffer + offset);
+
+			if (ctx->datalen - offset > USHRT_MAX) {
+				tst_brk_(file, lineno, TBROK,
+					"%s(): Sublist too long", __func__);
+				return -1;
+			}
+
+			attr->rta_len = ctx->datalen - offset;
+		}
+	}
+
+	return i;
+}
+
 int tst_rtnl_add_attr(const char *file, const int lineno,
 	struct tst_netlink_context *ctx, unsigned short type,
 	const void *data, unsigned short len)
@@ -320,7 +400,7 @@ int tst_rtnl_add_attr_string(const char *file, const int lineno,
 
 int tst_rtnl_add_attr_list(const char *file, const int lineno,
 	struct tst_netlink_context *ctx,
-	const struct tst_rtnl_attr_list *list)
+	const struct tst_netlink_attr_list *list)
 {
 	int i, ret;
 	size_t offset;
diff --git a/testcases/cve/tcindex01.c b/testcases/cve/tcindex01.c
index d441a2449..b4f2bb01a 100644
--- a/testcases/cve/tcindex01.c
+++ b/testcases/cve/tcindex01.c
@@ -46,15 +46,15 @@ static const struct tc_htb_glob qd_opt = {
 static struct tc_htb_opt cls_opt = {};
 
 /* htb qdisc and class options */
-static const struct tst_rtnl_attr_list qd_config[] = {
-	{TCA_OPTIONS, NULL, 0, (const struct tst_rtnl_attr_list[]){
+static const struct tst_netlink_attr_list qd_config[] = {
+	{TCA_OPTIONS, NULL, 0, (const struct tst_netlink_attr_list[]){
 		{TCA_HTB_INIT, &qd_opt, sizeof(qd_opt), NULL},
 		{0, NULL, -1, NULL}
 	}},
 	{0, NULL, -1, NULL}
 };
-static const struct tst_rtnl_attr_list cls_config[] = {
-	{TCA_OPTIONS, NULL, 0, (const struct tst_rtnl_attr_list[]){
+static const struct tst_netlink_attr_list cls_config[] = {
+	{TCA_OPTIONS, NULL, 0, (const struct tst_netlink_attr_list[]){
 		{TCA_HTB_PARMS, &cls_opt, sizeof(cls_opt), NULL},
 		{0, NULL, -1, NULL}
 	}},
@@ -62,8 +62,8 @@ static const struct tst_rtnl_attr_list cls_config[] = {
 };
 
 /* tcindex filter options */
-static const struct tst_rtnl_attr_list f_config[] = {
-	{TCA_OPTIONS, NULL, 0, (const struct tst_rtnl_attr_list[]){
+static const struct tst_netlink_attr_list f_config[] = {
+	{TCA_OPTIONS, NULL, 0, (const struct tst_netlink_attr_list[]){
 		{TCA_TCINDEX_MASK, &mask, sizeof(mask), NULL},
 		{TCA_TCINDEX_SHIFT, &shift, sizeof(shift), NULL},
 		{TCA_TCINDEX_CLASSID, &clsid, sizeof(clsid), NULL},
-- 
2.42.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
