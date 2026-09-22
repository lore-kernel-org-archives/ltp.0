Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8C5C982FA
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 10:02:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B3213E6CAB
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 12:02:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 08BA93C1E1C
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 12:02:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 35CB310009EA
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 12:02:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5888921AC6;
 Tue, 22 Sep 2026 10:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790071350;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d9a8keKzpJvkQvhWjucJdGks6h6BVXTbsR8GH9bj4xs=;
 b=xIKCyvHjhPghNF90nc3aA6kAtn1nWowf0mz/t8fHZWQpaHzBjTe0dWN7NA2ohLHmy91cJd
 MTlJync6QzC5l2pe6iATiYQU25JxSBUkJhvER9dn5Qyu+Nq6Csn0NEgDsKl3c+myHtDXGb
 OPB4tDcy85PbTzIk5H5kt6LH5fSalfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790071350;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d9a8keKzpJvkQvhWjucJdGks6h6BVXTbsR8GH9bj4xs=;
 b=kYWKFgRF9BFQVNNMgsiKUh/KlblHXD8AzDXYqyoVIAbDdYz/awWJUztAW5na4oefSqAMg/
 16GDcxfXGZFstqBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ULruc/0l";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ODkjB3Qs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790071346;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d9a8keKzpJvkQvhWjucJdGks6h6BVXTbsR8GH9bj4xs=;
 b=ULruc/0lAMi1anWY0L+8BBPtKDqezXuSeVkObFULi8LTPbyfHaFTQLdNM22S7KYvYNMa2N
 NGBG7Fxi/BOwooCT0XCkqGts2PUSWPSiaVGwvFC1Ac3Q7dV3R7ispD7aRdbcpiVG8mYvgG
 i/6ciXs/F+Y9+YyTdrHEx919vQu4tUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790071346;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d9a8keKzpJvkQvhWjucJdGks6h6BVXTbsR8GH9bj4xs=;
 b=ODkjB3QsK0KdTuCjYxQzMfX+A/Xi1BWNl7mNERJPOhFtqeT+SzSTqvH2B71d4k0y2BPeXA
 uhCillL+94VQ/KBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1D7F7136D9;
 Tue, 22 Sep 2026 10:02:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cJ6GOTFSsmofDAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Sep 2026 10:02:26 +0000
Date: Tue, 22 Sep 2026 12:02:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260922100220.GA2170537@pevik>
References: <20260919015329.22042-1-wegao@suse.com>
 <20260919015329.22042-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260919015329.22042-2-wegao@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5888921AC6
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v15 1/3] lib/tst_uid: Remove spurious TERRNO from
 tst_get_free_gid success path
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> tst_get_free_gid_() prints the found GID when it succeeds, but it
> incorrectly includes TERRNO in tst_res_(). This prints whatever value
> happens to be in errno (often 0 or a stale value) which is confusing in
> a success path.

> Remove the spurious TERRNO flag from the tst_res_() success message.

> Signed-off-by: Wei Gao <wegao@suse.com>
> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Martin might done it intentionally (had a reason for printing it).
If not, I'd merge this simple improvement before the release.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Fixes: 68f0a7fedf ("Add verbose setup to creat08, creat09 and open10")

Kind regards,
Petr

> ---
>  lib/tst_uid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/lib/tst_uid.c b/lib/tst_uid.c
> index af4ef8cf7..b0b087362 100644
> --- a/lib/tst_uid.c
> +++ b/lib/tst_uid.c
> @@ -24,7 +24,7 @@ gid_t tst_get_free_gid_(const char *file, const int lineno, gid_t skip)
>  			continue;

>  		if (errno == 0 || errno == ENOENT || errno == ESRCH) {
> -			tst_res_(file, lineno, TINFO | TERRNO,
> +			tst_res_(file, lineno, TINFO,
>  				"Found unused GID %d", (int)ret);
>  			return ret;
>  		}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
