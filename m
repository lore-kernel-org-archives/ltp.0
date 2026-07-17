Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B933C4451C
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 12:34:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38A423E24D6
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 14:34:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4AD43E569C
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 14:33:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 50CD61000A2F
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 14:33:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DB70578DBA;
 Fri, 17 Jul 2026 12:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784291599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X8JWp+d2UklsdEoB+pozNPnGJrDjAry7CqnCg5xS4SM=;
 b=G4uKYsKG1MJrSNpZWant4vuX2HsQktzuYr4xElTK76q4NAZAah0bzwsgprV4NJk27QTR/M
 1G/wsbdyL0NS3GkIrWBvrpfg8Zke9U3mhJ1H3KrwTXARoKrhlHM6zLYn5MgMmuBeIgHoE7
 fPqEJTsfWoKHm/ZACptX35mJag+VbUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784291599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X8JWp+d2UklsdEoB+pozNPnGJrDjAry7CqnCg5xS4SM=;
 b=nAyfFYivNlCqDd1j0oWLlED9exOh8L0p1P2/SitmxkSjYSqM6fGUViuVv34kyl4/BqbQYF
 cxv0ZZ2EYAcjLoDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784291599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X8JWp+d2UklsdEoB+pozNPnGJrDjAry7CqnCg5xS4SM=;
 b=G4uKYsKG1MJrSNpZWant4vuX2HsQktzuYr4xElTK76q4NAZAah0bzwsgprV4NJk27QTR/M
 1G/wsbdyL0NS3GkIrWBvrpfg8Zke9U3mhJ1H3KrwTXARoKrhlHM6zLYn5MgMmuBeIgHoE7
 fPqEJTsfWoKHm/ZACptX35mJag+VbUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784291599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X8JWp+d2UklsdEoB+pozNPnGJrDjAry7CqnCg5xS4SM=;
 b=nAyfFYivNlCqDd1j0oWLlED9exOh8L0p1P2/SitmxkSjYSqM6fGUViuVv34kyl4/BqbQYF
 cxv0ZZ2EYAcjLoDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0978779AA;
 Fri, 17 Jul 2026 12:33:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QOceLQ8hWmr7LgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 17 Jul 2026 12:33:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 17 Jul 2026 14:33:20 +0200
MIME-Version: 1.0
Message-Id: <20260717-fix_core_library-v1-3-c575fcbb2cb3@suse.com>
References: <20260717-fix_core_library-v1-0-c575fcbb2cb3@suse.com>
In-Reply-To: <20260717-fix_core_library-v1-0-c575fcbb2cb3@suse.com>
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784291599; l=698;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=V0YPQkYDYTyyVv+4GJPS0bQ3I9+GLIsa+XvrQl3uA8A=;
 b=w6ZcbOCmJ1FkSXmgOjgh2WqjZZddVczNWXIAVntX3Fq5IJfz6AtJE86SPTC8cCDhjNFkCSxN1
 Ni3/0g9EsyuBCrrFuWbMIVRt3nboXdCNI0NiQeThxJ6sa9k2JqT9ka0
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] lib: Fix wrong field in tst_iovec_alloc
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

The zero-size branch assigned iov_base twice and left iov_len unset,
clearly a copy-paste typo. Set iov_len to 0 as intended.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 lib/tst_buffers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_buffers.c b/lib/tst_buffers.c
index ac76a784bb7060ad46815310b56b2a4229bfd395..048b322457c3173df61e0617ad0bc190581c78a7 100644
--- a/lib/tst_buffers.c
+++ b/lib/tst_buffers.c
@@ -123,7 +123,7 @@ struct iovec *tst_iovec_alloc(int sizes[])
 			iovec[i].iov_len = sizes[i];
 		} else {
 			iovec[i].iov_base = NULL;
-			iovec[i].iov_base = 0;
+			iovec[i].iov_len = 0;
 		}
 	}
 

-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
