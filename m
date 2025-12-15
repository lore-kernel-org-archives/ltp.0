Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85D1D5B16C
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 15:56:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38CED3D022E
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 16:56:06 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BA113C1817
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 16:55:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 47D87647850
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 16:55:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C32DF33773;
 Mon, 15 Dec 2025 15:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765814142;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DeW51cWPekNROo9O0XN6nistK6BGsP39emBeaAwgoQc=;
 b=zt8JnuPXLAVj5LkBgSADWjiRqjS9FgRwtUWs2epABvCfXTIEdskH/oO+r505tImnR396+e
 tXglze97dsrllq6x4+qEaOipBArh347k2lWSUEPFzg4K3DPTkNnfe4xbD+BYV/NDd3Ra3v
 43e2nN+rmLb7iRr7VtLy4ZX4zGeo9TA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765814142;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DeW51cWPekNROo9O0XN6nistK6BGsP39emBeaAwgoQc=;
 b=dSjGDKKRJp/146pvkAkLXHlktaa9ACC7Wfn1pVcR6RyF4a6MygWWvLNeazdlqeouQLKv54
 xjfkizqdylL5l4BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765814141;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DeW51cWPekNROo9O0XN6nistK6BGsP39emBeaAwgoQc=;
 b=B9Nwd3vVkTUQTAh/rzhG5qnyBy0yEKRnOzZjog40tLZRTvihHT18avlRbP8pcbHYe+FJDL
 8O/bY5AdCcxSuuka2ssuiCRYB+LJuKeMS8vy/T5AHm+ERnpO1lo7U1KGlWl67Bz16A6q8Y
 k+0dg4e2ly1hABmsarkLgWpriy05RZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765814141;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DeW51cWPekNROo9O0XN6nistK6BGsP39emBeaAwgoQc=;
 b=suKt2w9+1b8iYRS1mttmrMpf26PvWF1yLBgIMoO0HdgLdWgZtMvbFbSrWsJGbcJ73Gj1xT
 iMF6CEqshH5I+XBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 961CA3EA63;
 Mon, 15 Dec 2025 15:55:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SLW9IX0vQGkbbwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 15 Dec 2025 15:55:41 +0000
Date: Mon, 15 Dec 2025 16:55:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20251215155532.GD272695@pevik>
References: <20251215-fix_ci-v1-1-792d418fc240@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251215-fix_ci-v1-1-792d418fc240@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
 TO_DN_ALL(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ci: fix patch download when using curl
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> curl started to fail on CI after bots have been introduced to verify
> that a human is interacting with patchwork. This creates an issue when
> we need to download patches, since at the very first redirection we will
> miss the server hosting our patches. By using `--location-trusted`, we
> trust the bots redirection and we make sure that it's possible to
> download the patch which is going to be applied via `git am`.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  .github/workflows/ci-docker-build.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/.github/workflows/ci-docker-build.yml b/.github/workflows/ci-docker-build.yml
> index 09eb8bb6d446b3e7100f43844942a5dd3976badb..408eb9a69f5cbebf725751633db46169be288bb8 100644
> --- a/.github/workflows/ci-docker-build.yml
> +++ b/.github/workflows/ci-docker-build.yml
> @@ -155,7 +155,7 @@ jobs:
>          git config --global --add safe.directory "$GITHUB_WORKSPACE"

>          git checkout -b review_patch_series_"${{ inputs.SERIES_ID }}"
> -        curl -k "${{ inputs.SERIES_MBOX }}" | git am
> +        curl -k -L --max-redirs 1 --location-trusted "${{ inputs.SERIES_MBOX }}" | git am

Hopefully --max-redirs 1 is enough.
Thanks for looking into this!

Acked-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
