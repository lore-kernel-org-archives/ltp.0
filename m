Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F2DCD6E55
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 13:22:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B43F3E56D1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 15:22:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCAE83E61B1
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 15:21:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5902F20076E
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 15:21:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 644BB6BB83
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 13:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780320060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OZAh6T4lQUTg+QQCTvvcJBmo5NVw+dngxIC9FoWf5oo=;
 b=tnfaM03ASDBlYhvPFhDfFKGhr6kiPzh+iak58MTk2Von04iL68eF39L28axDSRugujG3ju
 gt05CdRpI+oNRUoYFbrkXStA6WaITR8etHXjKkvaLXmP6AaGT9lxyuNW7/1D6EFk8I2hU6
 g/RZ2d+JjWd5DqfPrqi2lfzD261BylM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780320060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OZAh6T4lQUTg+QQCTvvcJBmo5NVw+dngxIC9FoWf5oo=;
 b=T+UBFp9v79S8qsvM/ptXTYPo5YjMqbYAUVDrcEjaEIeMKRW1ipdMFv2O8am086tpZipLVa
 fI+gVUiCg/3FTDAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780320060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OZAh6T4lQUTg+QQCTvvcJBmo5NVw+dngxIC9FoWf5oo=;
 b=tnfaM03ASDBlYhvPFhDfFKGhr6kiPzh+iak58MTk2Von04iL68eF39L28axDSRugujG3ju
 gt05CdRpI+oNRUoYFbrkXStA6WaITR8etHXjKkvaLXmP6AaGT9lxyuNW7/1D6EFk8I2hU6
 g/RZ2d+JjWd5DqfPrqi2lfzD261BylM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780320060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OZAh6T4lQUTg+QQCTvvcJBmo5NVw+dngxIC9FoWf5oo=;
 b=T+UBFp9v79S8qsvM/ptXTYPo5YjMqbYAUVDrcEjaEIeMKRW1ipdMFv2O8am086tpZipLVa
 fI+gVUiCg/3FTDAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56B63779AC
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 13:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eILmFDyHHWp2OwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 13:21:00 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  1 Jun 2026 15:20:51 +0200
Message-ID: <20260601132055.58728-7-mdoucha@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601132055.58728-1-mdoucha@suse.cz>
References: <20260601132055.58728-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/6] xfrm03: Configure xfrm using direct netlink
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

Changes since v1: Removed .needs_cmds

 testcases/network/sockets/xfrm03.c | 91 +++++++++++++++++++++---------
 1 file changed, 63 insertions(+), 28 deletions(-)

diff --git a/testcases/network/sockets/xfrm03.c b/testcases/network/sockets/xfrm03.c
index 5adfd6453..02ab95c6b 100644
--- a/testcases/network/sockets/xfrm03.c
+++ b/testcases/network/sockets/xfrm03.c
@@ -36,9 +36,11 @@
 #include <linux/sockios.h>
 #include <net/if.h>
 
+#include "lapi/xfrm.h"
 #include "tst_test.h"
 #include "tst_net.h"
 #include "tst_netdevice.h"
+#include "lapi/udp.h"
 #include "lapi/tcp.h"
 #include "lapi/splice.h"
 #include "lapi/sched.h"
@@ -61,6 +63,41 @@
 #define MIDDLE_ADDR2  0x0a000201 /* 10.0.2.1 */
 #define RECEIVER_ADDR 0x0a000202 /* 10.0.2.2 */
 
+static struct xfrm_usersa_info xs_payload = {
+	.family = AF_INET,
+	.id.proto = (uint8_t)IPPROTO_ESP,
+	.mode = XFRM_MODE_TRANSPORT,
+	.reqid = 1,
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
@@ -100,10 +137,13 @@ static void disable_offloads(const char *ifname)
 
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
@@ -144,27 +184,26 @@ static void setup(void)
 	NETDEV_SET_STATE("veth_r", 1);
 	NETDEV_ADD_ROUTE_INET("veth_r", 0, 0, 0, 0, htonl(MIDDLE_ADDR2));
 
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
-		"src", "10.0.2.2", "dst", "10.0.2.2",
-		"proto", "esp", "spi", spihex,
-		"encap", "espintcp", port_str, port_str, "0.0.0.0",
-		"aead", "rfc4106(gcm(aes))", keyhex, "128",
-		"mode", "transport",
-		NULL
-	};
-
-	ret = tst_cmd(xfrm_cmd, NULL, NULL, TST_CMD_PASS_RETVAL);
-	if (ret)
-		tst_brk(TCONF, "Failed to install xfrm ESP-in-TCP state");
+	memcpy(aead_alg_info.alg.alg_key, aead_key, KEYTOTAL);
+	xs_payload.id.spi = htonl(SPI);
+	xs_payload.saddr.a4 = htonl(RECEIVER_ADDR);
+	xs_payload.id.daddr.a4 = htonl(RECEIVER_ADDR);
+	esp_encap.encap_sport = htons(TCP_PORT);
+	esp_encap.encap_dport = htons(TCP_PORT);
+
+	ctx = NETLINK_CREATE_CONTEXT(NETLINK_XFRM);
+	NETLINK_ADD_MESSAGE(ctx, &header, &xs_payload, sizeof(xs_payload));
+	NETLINK_ADD_ATTR_LIST(ctx, alg_config);
+	ret = NETLINK_SEND_VALIDATE(ctx);
+	TST_ERR = tst_netlink_errno;
+	NETLINK_DESTROY_CONTEXT(ctx);
+
+	if (!ret) {
+		if (TST_ERR == EPROTONOSUPPORT)
+			tst_brk(TCONF, "xfrm ESP is not supported by kernel");
+
+		tst_brk(TBROK | TTERRNO, "Failed to install xfrm ESP state");
+	}
 
 	SAFE_SETNS(middlens, CLONE_NEWNET);
 
@@ -314,10 +353,6 @@ static struct tst_test test = {
 		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
-	.needs_cmds = (struct tst_cmd[]) {
-		{.cmd = "ip"},
-		{}
-	},
 	.tags = (const struct tst_tag[]) {
 		{"CVE", "2026-46300"},
 		{}
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
