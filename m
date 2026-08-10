Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95550C5AD7B
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 16:29:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A43B3D02EF
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 18:29:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1319E3CFF65
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:28:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 842C4600114
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:28:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 10C0280E89;
 Mon, 10 Aug 2026 16:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786379314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jSNpHmioUPqL0nydM10Hmn0IJTaTzeC28HzouFkG4Ls=;
 b=V59pyXMQF7tCi5hPUpSvxZVJVIz/H9ITJV6Imv0LsWREQJ7m/5KDM2/Cn5r3Lu/PQfwQ0N
 0fD9+IgIeJiJCvcoh5VkG0pot8ugbnWgKJjIch+O+l6AeFhqKLEVkUwjwsE/EPSDnXjium
 oC3zHD1PH0iHeof4zBtt8UGKqgtm7K0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786379314;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jSNpHmioUPqL0nydM10Hmn0IJTaTzeC28HzouFkG4Ls=;
 b=veNoTPUsaQOjoazl61KD7KXfF8+blLHdnQqqLdyusJfv/Fklm1i3bPBbFsyjVhwuDlsyrv
 JYQpYj76vNOIRjCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Uv4+xfOh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="HOie/x//"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786379310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jSNpHmioUPqL0nydM10Hmn0IJTaTzeC28HzouFkG4Ls=;
 b=Uv4+xfOhWoRtkVgljqPaRRgsFfWNkN2vQ5LOg5x239uwfn1vkEGa8xysNRGGYHC5FzTAp4
 RJoqttpcT2mHWLChnMQeVUu/XKXnKXmvdaUBXZ8OwsUfY8XBd2itpZ4Vl4dcOSTkyNFnCL
 QWl8qrbd3lu/ZN3EHmePvHvvG4IhkeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786379310;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jSNpHmioUPqL0nydM10Hmn0IJTaTzeC28HzouFkG4Ls=;
 b=HOie/x//uZt2JnRlaxS6731VVxvRryoaJAaZdQslnaLTFpuQX6m2NXYhpcgdxdBhF0sssJ
 HyqwKnGRw3csj8Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7BB1779B6;
 Mon, 10 Aug 2026 16:28:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KNzEMS38eWrHRgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 10 Aug 2026 16:28:29 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 10 Aug 2026 18:28:28 +0200
MIME-Version: 1.0
Message-Id: <20260810-sctphantom-v1-1-f8e9ee72a648@suse.com>
References: <20260810-sctphantom-v1-0-f8e9ee72a648@suse.com>
In-Reply-To: <20260810-sctphantom-v1-0-f8e9ee72a648@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786379309; l=1683;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=CDcFhOCv89gbgn3eTk13h0ba+HFf5Mk1LlI92rfH4EI=;
 b=xol0ePIQmJ99e8+RKwaiNC4rqUTEVqHC6Yh6ebLhXDW4FO6R9RKtLt7vgBYztqTow3dGExw/t
 RhtCRBqcjfNCEBSUu3TYRQrm8KpB58qE7ZFQaZ70FYqDd5wVUhWgRor
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 10C0280E89
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:email,suse.com:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] sctp: add lapi fallback definitions
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/lapi/sctp.h | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/include/lapi/sctp.h b/include/lapi/sctp.h
index c4c1cc91f..67c4d9e09 100644
--- a/include/lapi/sctp.h
+++ b/include/lapi/sctp.h
@@ -14,4 +14,69 @@
 # define SCTP_SOCKOPT_BINDX_ADD	100
 #endif
 
+#ifndef IPPROTO_SCTP
+# define IPPROTO_SCTP	132
+#endif
+
+#ifndef SCTP_PEER_ADDR_PARAMS
+# define SCTP_PEER_ADDR_PARAMS	9
+#endif
+
+#ifndef SCTP_STATUS
+# define SCTP_STATUS	14
+#endif
+
+#ifndef SCTP_GET_PEER_ADDR_INFO
+# define SCTP_GET_PEER_ADDR_INFO	15
+#endif
+
+#ifndef SPP_HB_ENABLE
+# define SPP_HB_ENABLE	(1 << 0)
+#endif
+
+#ifndef SPP_HB_DISABLE
+# define SPP_HB_DISABLE	(1 << 1)
+#endif
+
+#ifndef SPP_HB_DEMAND
+# define SPP_HB_DEMAND	(1 << 2)
+#endif
+
+#ifndef SCTP_ACTIVE
+# define SCTP_ACTIVE	2
+#endif
+
+/* SCTP wire format values, see include/linux/sctp.h in the kernel */
+#ifndef SCTP_CID_INIT
+# define SCTP_CID_INIT		1
+#endif
+
+#ifndef SCTP_CID_INIT_ACK
+# define SCTP_CID_INIT_ACK	2
+#endif
+
+#ifndef SCTP_CID_ASCONF_ACK
+# define SCTP_CID_ASCONF_ACK	0x80
+#endif
+
+#ifndef SCTP_CID_ASCONF
+# define SCTP_CID_ASCONF		0xc1
+#endif
+
+#ifndef SCTP_PARAM_IPV4_ADDRESS
+# define SCTP_PARAM_IPV4_ADDRESS	5
+#endif
+
+#ifndef SCTP_PARAM_DEL_IP
+# define SCTP_PARAM_DEL_IP	0xc002
+#endif
+
+#ifndef SCTP_PARAM_ERR_CAUSE
+# define SCTP_PARAM_ERR_CAUSE	0xc003
+#endif
+
+#ifndef SCTP_ERROR_REQ_REFUSED
+# define SCTP_ERROR_REQ_REFUSED	0x00a4
+#endif
+
 #endif	/* LAPI_SCTP_H__ */

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
