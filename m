Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 540C6109C033
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 15:26:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E27CF3E552F
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 16:26:12 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0EEC93E5780
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 16:25:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6DC7C1400962
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 16:25:41 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 37B014D23D;
 Wed, 25 Mar 2026 15:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774452335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFWkWRQOsmxAq8xuR5rREiChaXymsSVAfXqh4hVRIoE=;
 b=s3U3C7sOj1UA/0wBHII8OwgGeN93Oy3tO5F66aEBqwFeXIfyKrEJyDwBw85oL7LVO42c1m
 evdnEEwtobbVYjyY7bicg6fFORT3KomhC1DqCNjvfUbMjawwyiJP+AgoJYEbk/ojuOHxhF
 P+JyGxPmq0gIu4aYpT4S7y5GRE/IDYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774452335;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFWkWRQOsmxAq8xuR5rREiChaXymsSVAfXqh4hVRIoE=;
 b=u/mdZtNhIl2stzjOMzcdsKQh9hxgc4GufPduyNTfFYLmeXdb2z/mk5StFPEmGLxafiVypg
 g2iuLBsIcmlpFTDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=s3U3C7sO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="u/mdZtNh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774452335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFWkWRQOsmxAq8xuR5rREiChaXymsSVAfXqh4hVRIoE=;
 b=s3U3C7sOj1UA/0wBHII8OwgGeN93Oy3tO5F66aEBqwFeXIfyKrEJyDwBw85oL7LVO42c1m
 evdnEEwtobbVYjyY7bicg6fFORT3KomhC1DqCNjvfUbMjawwyiJP+AgoJYEbk/ojuOHxhF
 P+JyGxPmq0gIu4aYpT4S7y5GRE/IDYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774452335;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFWkWRQOsmxAq8xuR5rREiChaXymsSVAfXqh4hVRIoE=;
 b=u/mdZtNhIl2stzjOMzcdsKQh9hxgc4GufPduyNTfFYLmeXdb2z/mk5StFPEmGLxafiVypg
 g2iuLBsIcmlpFTDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C46944482;
 Wed, 25 Mar 2026 15:25:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uH8iBW/+w2nhBAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 25 Mar 2026 15:25:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 25 Mar 2026 16:25:34 +0100
MIME-Version: 1.0
Message-Id: <20260325-infiniband_rdma-v1-1-9c1bd3e69d29@suse.com>
References: <20260325-infiniband_rdma-v1-0-9c1bd3e69d29@suse.com>
In-Reply-To: <20260325-infiniband_rdma-v1-0-9c1bd3e69d29@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774452334; l=2420;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=IqfvXw2z9P3+X8yckUR/hLntVUnGz8n6clwtzDEcvdI=;
 b=UOMCVbSBLQ+NEJ4R0CTmA9z0Ocn+LtO76os8fIXm0xY7IbVj7z2QUYJiWYJ8bYZTb4u68agtq
 wO8wFK4Vf7KAZWDMLXliSXrFjHfoOjtlCPtmZhR7BIerkdzGRM1z3IC
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 37B014D23D
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lapi: Add fallback rdma_user_cm.h definitions
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Add LAPI header with fallback definitions for RDMA user CM structures
and command enums, used when <rdma/rdma_user_cm.h> is not available.

Add the corresponding configure check for rdma/rdma_user_cm.h.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 configure.ac                |  1 +
 include/lapi/rdma_user_cm.h | 72 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/configure.ac b/configure.ac
index 9d6ec7f13ad421aa35840ebc65745c962b11e1db..8f67018dc692685d88acfb51232446659c1eeb3d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -85,6 +85,7 @@ AC_CHECK_HEADERS_ONCE([ \
     linux/userfaultfd.h \
     netinet/sctp.h \
     pthread.h \
+    rdma/rdma_user_cm.h \
     sys/epoll.h \
     sys/fanotify.h \
     sys/inotify.h \
diff --git a/include/lapi/rdma_user_cm.h b/include/lapi/rdma_user_cm.h
new file mode 100644
index 0000000000000000000000000000000000000000..801dd83ec0df215901a86855bc51ad2b416d9855
--- /dev/null
+++ b/include/lapi/rdma_user_cm.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2026 Linux Test Project
+ */
+
+#ifndef LAPI_RDMA_USER_CM_H__
+#define LAPI_RDMA_USER_CM_H__
+
+#include "config.h"
+
+#ifdef HAVE_RDMA_RDMA_USER_CM_H
+# include <rdma/rdma_user_cm.h>
+#endif
+
+#include <netinet/in.h>
+#include <stdint.h>
+
+#ifndef RDMA_USER_CM_ABI_VERSION
+
+enum {
+	RDMA_USER_CM_CMD_CREATE_ID,
+	RDMA_USER_CM_CMD_DESTROY_ID,
+	RDMA_USER_CM_CMD_BIND_IP,
+	RDMA_USER_CM_CMD_RESOLVE_IP,
+	RDMA_USER_CM_CMD_RESOLVE_ROUTE,
+	RDMA_USER_CM_CMD_QUERY_ROUTE,
+	RDMA_USER_CM_CMD_CONNECT,
+	RDMA_USER_CM_CMD_LISTEN,
+};
+
+enum rdma_ucm_port_space {
+	RDMA_PS_IPOIB = 0x0002,
+};
+
+struct rdma_ucm_cmd_hdr {
+	uint32_t cmd;
+	uint16_t in;
+	uint16_t out;
+};
+
+struct rdma_ucm_create_id {
+	uint64_t uid;
+	uint64_t response;
+	uint16_t ps;
+	uint8_t  qp_type;
+	uint8_t  reserved[5];
+};
+
+struct rdma_ucm_create_id_resp {
+	uint32_t id;
+};
+
+struct rdma_ucm_destroy_id {
+	uint64_t response;
+	uint32_t id;
+	uint32_t reserved;
+};
+
+struct rdma_ucm_bind_ip {
+	uint64_t response;
+	struct sockaddr_in6 addr;
+	uint32_t id;
+};
+
+struct rdma_ucm_listen {
+	uint32_t id;
+	uint32_t backlog;
+};
+
+#endif /* RDMA_USER_CM_ABI_VERSION */
+
+#endif /* LAPI_RDMA_USER_CM_H__ */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
