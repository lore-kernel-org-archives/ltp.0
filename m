Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF22CD5BD1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 13:22:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 587643E48BB
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 15:22:16 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C04D3E56E0
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 15:21:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1A77C10001A3
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 15:21:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 501086BB61
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 13:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780320060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ew0mhRAb50UWJvY1F8KJiuyAVXYhfuC6LU6tp4yLexo=;
 b=uQxpDDqEKT9qV7bWiLMsijJTlGsadDPUTm8X6zVXNi5rk/fixwqy/t2XLo9uj7z/x6V86+
 kQXXoLTkdJ0S6EkfTaN6vKMChQZpf1KjlSfLdpctxlCJvNV3S/e1UzuK9uidSWb+1cE+qP
 dm/sp+fJWJH6XYar7BnllFiYqRHr0Tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780320060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ew0mhRAb50UWJvY1F8KJiuyAVXYhfuC6LU6tp4yLexo=;
 b=ae4BR1Ig8wQzV280ptakg/xmirMtDXBxOcD3op0WAIu63TpibFNZLZGj4vyMy35wS4KmyL
 2WjbTUG60RdxP+Dg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uQxpDDqE;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ae4BR1Ig
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780320060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ew0mhRAb50UWJvY1F8KJiuyAVXYhfuC6LU6tp4yLexo=;
 b=uQxpDDqEKT9qV7bWiLMsijJTlGsadDPUTm8X6zVXNi5rk/fixwqy/t2XLo9uj7z/x6V86+
 kQXXoLTkdJ0S6EkfTaN6vKMChQZpf1KjlSfLdpctxlCJvNV3S/e1UzuK9uidSWb+1cE+qP
 dm/sp+fJWJH6XYar7BnllFiYqRHr0Tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780320060;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ew0mhRAb50UWJvY1F8KJiuyAVXYhfuC6LU6tp4yLexo=;
 b=ae4BR1Ig8wQzV280ptakg/xmirMtDXBxOcD3op0WAIu63TpibFNZLZGj4vyMy35wS4KmyL
 2WjbTUG60RdxP+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39B49779AA
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 13:21:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SGWuDTyHHWp2OwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 13:21:00 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  1 Jun 2026 15:20:49 +0200
Message-ID: <20260601132055.58728-5-mdoucha@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601132055.58728-1-mdoucha@suse.cz>
References: <20260601132055.58728-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 501086BB61
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/6] lapi/udp.h: Add fallback constant for
 ESP-in-TCP
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

The system constant is defined in linux/udp.h but not in netinet/udp.h.
Define it in lapi/udp.h anyway.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: None

 include/lapi/udp.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/lapi/udp.h b/include/lapi/udp.h
index 93b24fc3e..c7023726f 100644
--- a/include/lapi/udp.h
+++ b/include/lapi/udp.h
@@ -23,4 +23,8 @@
 # define UDP_ENCAP_ESPINUDP 2
 #endif
 
+#ifndef TCP_ENCAP_ESPINTCP
+# define TCP_ENCAP_ESPINTCP 7
+#endif
+
 #endif	/* LAPI_UDP_H__ */
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
