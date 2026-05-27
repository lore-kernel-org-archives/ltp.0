Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B76CD5BD0
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 11:48:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 781843CB6D1
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 13:48:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6383D3CC6A7
 for <ltp@lists.linux.it>; Wed, 27 May 2026 13:47:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D9A5F600257
 for <ltp@lists.linux.it>; Wed, 27 May 2026 13:47:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 81A1866E9B
 for <ltp@lists.linux.it>; Wed, 27 May 2026 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779882429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ByhA/6FGdH5JP7XkiPJhTimqDO6EfGpUVvl8dGUtwXs=;
 b=q4p55MRBivkvvYfvwUcykanVI55oKpK3m2IBmVVXakpMRFKdcM2gidT9tpwbUOuzB2kD1X
 iG1XAkJbVGtC+SgTZAQd/LlfCxbpBCLcUaqdKy19j7DIEKYPv6PaPePEtlbOw+cPVeDcuf
 Pfpk7WQku7D9hP27b926IzlhMriCIo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779882429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ByhA/6FGdH5JP7XkiPJhTimqDO6EfGpUVvl8dGUtwXs=;
 b=q/A4PrZb9ELfL7geKHAl53y24Pav+8kzcXQTHU1SC9r/d04ntrckLDRR7dfAgB3OCecB/r
 hCVuKcn5JHNn27Dg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=q4p55MRB;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="q/A4PrZb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779882429; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ByhA/6FGdH5JP7XkiPJhTimqDO6EfGpUVvl8dGUtwXs=;
 b=q4p55MRBivkvvYfvwUcykanVI55oKpK3m2IBmVVXakpMRFKdcM2gidT9tpwbUOuzB2kD1X
 iG1XAkJbVGtC+SgTZAQd/LlfCxbpBCLcUaqdKy19j7DIEKYPv6PaPePEtlbOw+cPVeDcuf
 Pfpk7WQku7D9hP27b926IzlhMriCIo0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779882429;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ByhA/6FGdH5JP7XkiPJhTimqDO6EfGpUVvl8dGUtwXs=;
 b=q/A4PrZb9ELfL7geKHAl53y24Pav+8kzcXQTHU1SC9r/d04ntrckLDRR7dfAgB3OCecB/r
 hCVuKcn5JHNn27Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 673275A7FE
 for <ltp@lists.linux.it>; Wed, 27 May 2026 11:47:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QB/nGL3ZFmptPQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 27 May 2026 11:47:09 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 27 May 2026 13:47:04 +0200
Message-ID: <20260527114708.16896-5-mdoucha@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527114708.16896-1-mdoucha@suse.cz>
References: <20260527114708.16896-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 81A1866E9B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_ONE(0.00)[1];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/6] xfrm02: Configure xfrm using direct netlink
 request
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

Some kernels may not support ESP-in-TCP even though the necessary
modules are enabled in kernel config. Rewrite the xfrm setup using
direct netlink request so that the test can check errno and exit
with TCONF if the support is missing.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/network/sockets/xfrm02.c | 87 ++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 23 deletions(-)

diff --git a/testcases/network/sockets/xfrm02.c b/testcases/network/sockets/xfrm02.c
index 86110bf4e..35c4dee52 100644
--- a/testcases/network/sockets/xfrm02.c
+++ b/testcases/network/sockets/xfrm02.c
@@ -26,9 +26,11 @@
 
 #define _GNU_SOURCE
 
+#include "lapi/xfrm.h"
 #include "tst_test.h"
 #include "tst_net.h"
 #include "tst_netdevice.h"
+#include "lapi/udp.h"
 #include "lapi/tcp.h"
 #include "lapi/splice.h"
 
@@ -46,6 +48,45 @@
 /* ESP-in-TCP frame prefix: 2-byte length + ESP header */
 #define PREFIX_SIZE (2 + ESP_HDR_SIZE)
 
+static struct xfrm_usersa_info xs_payload = {
+	.family = AF_INET6,
+	.mode = XFRM_MODE_TRANSPORT,
+	.reqid = 1,
+	.saddr.in6 = IN6ADDR_LOOPBACK_INIT,
+	.id = {
+		.proto = (uint8_t)IPPROTO_ESP,
+		.daddr.in6 = IN6ADDR_LOOPBACK_INIT
+	},
+	.lft = {
+		.soft_byte_limit = XFRM_INF,
+		.hard_byte_limit = XFRM_INF,
+		.soft_packet_limit = XFRM_INF,
+		.hard_packet_limit = XFRM_INF,
+	},
+};
+
+static struct xfrm_encap_tmpl esp_encap = {
+	.encap_type = TCP_ENCAP_ESPINTCP
+};
+
+static struct {
+	struct xfrm_algo_aead alg;
+	char buf[KEYTOTAL];
+} aead_alg_info = {
+	.alg = {
+		.alg_name = "rfc4106(gcm(aes))",
+		.alg_key_len = KEYTOTAL * 8,
+		.alg_icv_len = 128
+	}
+};
+
+static const struct tst_netlink_attr_list alg_config[] = {
+	{XFRMA_ENCAP, &esp_encap, sizeof(esp_encap), NULL},
+	{XFRMA_ALG_AEAD, &aead_alg_info, sizeof(aead_alg_info.alg) + KEYTOTAL,
+		NULL},
+	{0, NULL, -1, NULL}
+};
+
 static const uint8_t aead_key[KEYTOTAL] = {
 	0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77,
 	0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff,
@@ -58,35 +99,35 @@ static int srv_fd = -1;
 
 static void setup(void)
 {
-	char keyhex[KEYTOTAL * 2 + 3];
-	char spihex[16];
-	char port_str[8];
 	int i, ret;
+	struct tst_netlink_context *ctx;
+	struct nlmsghdr header = {
+		.nlmsg_type = XFRM_MSG_NEWSA,
+		.nlmsg_flags = NLM_F_REQUEST | NLM_F_CREATE | NLM_F_EXCL |
+			NLM_F_ACK
+	};
 
 	tst_setup_netns();
 	NETDEV_SET_STATE("lo", 1);
 
-	keyhex[0] = '0';
-	keyhex[1] = 'x';
-	for (i = 0; i < KEYTOTAL; i++)
-		sprintf(keyhex + 2 + i * 2, "%02x", aead_key[i]);
-
-	snprintf(spihex, sizeof(spihex), "0x%08x", SPI);
-	snprintf(port_str, sizeof(port_str), "%d", TCP_PORT);
-
-	const char *const xfrm_cmd[] = {
-		"ip", "xfrm", "state", "add",
-		"src", "::1", "dst", "::1",
-		"proto", "esp", "spi", spihex,
-		"encap", "espintcp", port_str, port_str, "::",
-		"aead", "rfc4106(gcm(aes))", keyhex, "128",
-		"mode", "transport",
-		NULL
-	};
+	memcpy(aead_alg_info.alg.alg_key, aead_key, KEYTOTAL);
+	xs_payload.id.spi = htonl(SPI);
+	esp_encap.encap_sport = htons(TCP_PORT);
+	esp_encap.encap_dport = htons(TCP_PORT);
+
+	ctx = NETLINK_CREATE_CONTEXT(NETLINK_XFRM);
+	NETLINK_ADD_MESSAGE(ctx, &header, &xs_payload, sizeof(xs_payload));
+	NETLINK_ADD_ATTR_LIST(ctx, alg_config);
+	ret = NETLINK_SEND_VALIDATE(ctx);
+	TST_ERR = tst_netlink_errno;
+	NETLINK_DESTROY_CONTEXT(ctx);
 
-	ret = tst_cmd(xfrm_cmd, NULL, NULL, TST_CMD_PASS_RETVAL);
-	if (ret)
-		tst_brk(TBROK, "Failed to install xfrm ESP-in-TCP state");
+	if (!ret) {
+		if (TST_ERR == EPROTONOSUPPORT)
+			tst_brk(TCONF, "xfrm ESP is not supported by kernel");
+
+		tst_brk(TBROK | TTERRNO, "Failed to install xfrm ESP state");
+	}
 
 	for (i = 0; i < DATA_SIZE; i++)
 		original[i] = (uint8_t)(i & 0xff);
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
