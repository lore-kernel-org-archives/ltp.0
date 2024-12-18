Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29687E77187
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 19:01:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B09C63ED633
	for <ltp@archiver.kernel.org>; Wed, 18 Dec 2024 20:01:05 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 651AC3ED634
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:00:36 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7C25E652037
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 20:00:34 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E8F891F396;
 Wed, 18 Dec 2024 19:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K4ADxfyqkWbPhh0urBwTCsSEI0Fu5MAPQbZLA80xYV8=;
 b=iEAkmMtlb/7mpb7+APc8jJvuTyOmDADh+CuYxTk3MlBbZOpMFrF6KIo4z1+HgkJZO5bT5w
 c8PkVcIVqEJPsg2tZfDay3wgAFsjP6CkMumfC3xnoQQCIogmIpihklQpDy4uJBj/GtHnTJ
 gLshHplsE5zf2CmsR7/oJgh1m6PIdmU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548434;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K4ADxfyqkWbPhh0urBwTCsSEI0Fu5MAPQbZLA80xYV8=;
 b=tZz8tMod5EBhux4Oq9jTpkwFYqhIkSYwS7SrprxN/Ou+KojO6VUsNIAJNHgDMGS16pals7
 zHA86gQhmboR9TCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Qsl8zHnh;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=U9KOPBh+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734548433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K4ADxfyqkWbPhh0urBwTCsSEI0Fu5MAPQbZLA80xYV8=;
 b=Qsl8zHnhqJoetQ/tR6M3cMapNj+d1oRvORHz1i2GlTywSUQQdgg+0EoA5KDNV9kkfShZ00
 F/51NU4SP282vuu3CC72/oYZkYgFte/rgMJFUqQE+pptgtgAFSGGaFFEB0Jv99ck9vxOOY
 XWxg88UWmQpu/3Op5oQF9eTl2pREjW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734548433;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K4ADxfyqkWbPhh0urBwTCsSEI0Fu5MAPQbZLA80xYV8=;
 b=U9KOPBh+VKHXX62PNqBJ7twb7uKBdyZs5kFmFy+J4EL6C3M876jaWzO9GcPIRNtb6+P9tB
 90Q059QtLVNSpSDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9F84132EA;
 Wed, 18 Dec 2024 19:00:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tYUjNNEbY2fDdQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 18 Dec 2024 19:00:33 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Dec 2024 20:00:21 +0100
Message-ID: <20241218190029.15015-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218190029.15015-1-chrubis@suse.cz>
References: <20241218190029.15015-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: E8F891F396
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/9] metadata: metaparse: Parse operators *, +,
 and | properly
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

This is needed for cases where we assing integer values to tst_test
structure members such as:

TST_SR_SKIP_MISSING|TST_SR_TCONF flags in .save_restore
(1*TST_MB) in .min_swap_avail
[N+1, "TST_NEEDS"] in .hugepages

etc.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 metadata/metaparse.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/metadata/metaparse.c b/metadata/metaparse.c
index 2384c73c8..bf9559712 100644
--- a/metadata/metaparse.c
+++ b/metadata/metaparse.c
@@ -173,6 +173,9 @@ static char *next_token2(FILE *f, char *buf, size_t buf_len, struct data_node *d
 		case '[':
 		case ']':
 		case '#':
+		case '|':
+		case '+':
+		case '*':
 			if (i) {
 				ungetc(c, f);
 				goto exit;
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
