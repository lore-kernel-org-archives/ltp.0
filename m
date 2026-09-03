Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0696CC61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 13:05:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B224E3C198F
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 15:05:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A4C93EAD42
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:04:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4F84C1A0107E
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 15:04:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C85B71FE51;
 Thu,  3 Sep 2026 13:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788440656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hgDMX2DjmAJ4rY6z6kCrdNbLFhVXMoXrAfq+ZLbA170=;
 b=XwrKfLTgtdLC/DeZ5AThwar2K4N/7VFXztOPnb0jbhn3ZkXcZa9knAiZyA3mBcbj++oNRm
 D8NwyQSsSeNJqdRP/XxPcp67zva4280tomJBiRpKcBCPDxN/6iokKHmE339NIUv4asKl1H
 MO2Hy0RasWEAg7ysOIAeQaDmWbhddkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788440656;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hgDMX2DjmAJ4rY6z6kCrdNbLFhVXMoXrAfq+ZLbA170=;
 b=hdoS96Q0TpE1B8/hNtS9b2hCESonbyI3HaAojUo/W1clUnxult2SFCgwBXxZP1cGIRRIx2
 qyLM7IlcPrrtrWBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="fQ/jl0mQ";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qCa8hO6B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788440652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hgDMX2DjmAJ4rY6z6kCrdNbLFhVXMoXrAfq+ZLbA170=;
 b=fQ/jl0mQ5O9ELz78BKW5Bx3W7pasvLAXlYRpd084o8Z312LyNbFGkx7tk8dfCMQ0JGOXyL
 y29X1CrLE+cUj0VC/YIZD92Bxk3r2VUESXC/vi6pF9AKBYH+6P6kHuRHJaxwFOo4JPXLDg
 tBxWWCStK3xrf6D8qZ0FKxnQWYz38AQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788440652;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hgDMX2DjmAJ4rY6z6kCrdNbLFhVXMoXrAfq+ZLbA170=;
 b=qCa8hO6B6ZlpHFHGa1Dh00V1jslQk5h2M26bfxcNzWxuX6i6Y08dn2MuJUh84fxTtA0+ix
 xoOvufDzY2ZRqVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F19013736;
 Thu,  3 Sep 2026 13:04:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8B9bHExwmWojPwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 03 Sep 2026 13:04:12 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 03 Sep 2026 15:04:11 +0200
MIME-Version: 1.0
Message-Id: <20260903-swapon_discard_coverage-v4-1-2a9f721ad954@suse.com>
References: <20260903-swapon_discard_coverage-v4-0-2a9f721ad954@suse.com>
In-Reply-To: <20260903-swapon_discard_coverage-v4-0-2a9f721ad954@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788440652; l=1064;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=v38xlknsT66sg9uSy+U4jl6hn0R0h7xrrK3k3+fQ+k0=;
 b=7VX+wyWOb5fgd2tVR+3mt+MY6iMHj6s56ScGQR+muaEGeP/Dg7kVpogNCTAJGFCPKxxnSGcNT
 PUpuFYwSJBLBFCQ83YCcJPazd4Dc79PkiICQa2ljOFhTFzw7yoL97X5
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Queue-Id: C85B71FE51
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,linux.dev:email];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/3] tse_swap: Add fallback definitions for swapon
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

Introduce fallback definitions inside include/tse_swap.h for:

- SWAP_FLAG_PREFER
- SWAP_FLAG_PRIO_MASK
- SWAP_FLAG_DISCARD
- SWAP_FLAG_DISCARD_ONCE
- SWAP_FLAG_DISCARD_PAGES

Reviewed-by: Li Wang <li.wang@linux.dev>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tse_swap.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/tse_swap.h b/include/tse_swap.h
index c4979b3e5..25fe4ad77 100644
--- a/include/tse_swap.h
+++ b/include/tse_swap.h
@@ -14,6 +14,22 @@
 #ifndef TSE_SWAP_H__
 #define TSE_SWAP_H__
 
+#ifndef SWAP_FLAG_PREFER
+# define SWAP_FLAG_PREFER	0x8000
+#endif
+#ifndef SWAP_FLAG_PRIO_MASK
+# define SWAP_FLAG_PRIO_MASK	0x7fff
+#endif
+#ifndef SWAP_FLAG_DISCARD
+# define SWAP_FLAG_DISCARD	0x10000
+#endif
+#ifndef SWAP_FLAG_DISCARD_ONCE
+# define SWAP_FLAG_DISCARD_ONCE	0x20000
+#endif
+#ifndef SWAP_FLAG_DISCARD_PAGES
+# define SWAP_FLAG_DISCARD_PAGES 0x40000
+#endif
+
 enum swapfile_method {
     SWAPFILE_BY_SIZE,
     SWAPFILE_BY_BLKS

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
