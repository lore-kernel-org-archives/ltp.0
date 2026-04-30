Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57010FF8873
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 13:30:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 046E63E200D
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 15:30:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 211413E1CB7
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 15:30:22 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C5369200CF8
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 15:30:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EC0575BD78;
 Thu, 30 Apr 2026 13:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777555820; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jyu7xHKMneipXBUU8MQfxTye4KOFSMClAOx8yeyYuao=;
 b=FMCqhzu8cHB0Ke1ZIv064G3msMa1qN0KkAfYHkikc4nAvEU2e9Cmcg6NR1oAfF5RuAWrtR
 B7xCX9VJa1u1KV/lsPlm5jHMKPNPzYszb2R/EykU1spb3wcFr5AMgydQlFmS/aLXZbu13K
 pFAum2/9EQKvJ9106uR7DMfyUs5FT1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777555820;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jyu7xHKMneipXBUU8MQfxTye4KOFSMClAOx8yeyYuao=;
 b=pxygbW+8p58BdQ42NAEVIbtdVwswRJ23bF368qdw2u8WUFeiin68kIQv1A1snGiUeWnKtX
 CWxHIhkp/PeW/mCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Aqq4JZOT;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DeUIpnDJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777555819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jyu7xHKMneipXBUU8MQfxTye4KOFSMClAOx8yeyYuao=;
 b=Aqq4JZOToEbBIu718T1npPGPVzHDyhhk4B44q3JYzSU/0F/N60Msvp97/BHVP3OgZg5eRe
 S0fDe82bMfabsrQajKiUNcHhTsKnDRRUyXrd1/CJcyOx2yUrswZqvrO7F3bQvIW/2+xP5W
 pulcVm9AqmS9qZr2Su/4UXdYVqj0Q74=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777555819;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jyu7xHKMneipXBUU8MQfxTye4KOFSMClAOx8yeyYuao=;
 b=DeUIpnDJh4U6ktNBI3sKbwrkEf5p0areVoEqlC2lYu2WSn7dtRb9Fe4SjHE5VGe3QMjxc4
 OD8euc6RKU+4UvCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CC5F8593B1;
 Thu, 30 Apr 2026 13:30:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +DVqMGtZ82luOAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 30 Apr 2026 13:30:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 30 Apr 2026 15:30:16 +0200
MIME-Version: 1.0
Message-Id: <20260430-cve-2026-31431-v2-1-1136c09ca67b@suse.com>
References: <20260430-cve-2026-31431-v2-0-1136c09ca67b@suse.com>
In-Reply-To: <20260430-cve-2026-31431-v2-0-1136c09ca67b@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777555819; l=1339;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=hrx3NrI75+PaFY8t3iMNHqPI0DGXp7PpXYBxfKYjYwk=;
 b=9vNIBzXYGSREdJdhYaqA2MzU7++rz1FyH/b0XIvDzneO9RYRy/ZSZ0W84GKqgdjdBj7dPgx2N
 OFhtK4cJ4+wBYOmOunHWc7d3FIjNVYM/xsSsX7xUz2hO10S+JOFTGAb
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: EC0575BD78
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] tst_af_alg: fixed msg_flags to be the
 sendmsg() flags
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
 include/tst_af_alg.h | 2 +-
 lib/tst_af_alg.c     | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/tst_af_alg.h b/include/tst_af_alg.h
index 5c307ed0695103e67aac2f56d7ef6ecbd0a0b704..34f32e1d7755fa2dbd53d8bd76280cc730a6115a 100644
--- a/include/tst_af_alg.h
+++ b/include/tst_af_alg.h
@@ -167,7 +167,7 @@ struct tst_alg_sendmsg_params {
 	/** If assoclen != 0, send ALG_SET_AEAD_ASSOCLEN */
 	unsigned int assoclen;
 
-	/* Value to use as msghdr::msg_flags */
+	/** Flags to pass to sendmsg() (e.g. MSG_MORE) */
 	uint32_t msg_flags;
 };
 
diff --git a/lib/tst_af_alg.c b/lib/tst_af_alg.c
index a14f9865c9a4efef70e82485448c8dfccdec37ed..93757278f1d299edd1aefa232644cc060b801a74 100644
--- a/lib/tst_af_alg.c
+++ b/lib/tst_af_alg.c
@@ -198,7 +198,6 @@ void tst_alg_sendmsg(int reqfd, const void *data, size_t datalen,
 	struct msghdr msg = {
 		.msg_iov = &iov,
 		.msg_iovlen = 1,
-		.msg_flags = params->msg_flags,
 	};
 	size_t controllen;
 	uint8_t *control;
@@ -249,5 +248,5 @@ void tst_alg_sendmsg(int reqfd, const void *data, size_t datalen,
 		cmsg = CMSG_NXTHDR(&msg, cmsg);
 	}
 
-	SAFE_SENDMSG(datalen, reqfd, &msg, 0);
+	SAFE_SENDMSG(datalen, reqfd, &msg, params->msg_flags);
 }

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
