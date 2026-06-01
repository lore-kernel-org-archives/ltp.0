Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 374BFCD5BD1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 14:09:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9233D3E62CF
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 16:09:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 263D63E1E6E
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 16:09:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7AC771A006B2
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 16:09:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8E9FC683EE;
 Mon,  1 Jun 2026 14:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780322942;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/7NM0MANjcbZV6jHa5EnOyS5w+40KPgaxCpBHEm/3ZY=;
 b=0IZGOYhxxOzmocjy+FnlRWWddRwvG6dU3MOyT9VZKYH3YJL8OkQyKAELgGi0n+mag/8Wda
 ll2P480nmAsrMsmTl5yIGl3Lz/0toK6XLeTMikkAK0GXlItKxN79wbb/832+HIizxL9C/o
 4TYT9Kl+/6uxGFES9d09EufFEHUCUrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780322942;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/7NM0MANjcbZV6jHa5EnOyS5w+40KPgaxCpBHEm/3ZY=;
 b=r86XnVbwMhGC1pjMHPace5fh0r4gCW/u3E7ieFoIppnnbl+nl5M+tdS5u6HiHfJtHAF5Ij
 zB/dGmJE7wTTRzBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780322942;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/7NM0MANjcbZV6jHa5EnOyS5w+40KPgaxCpBHEm/3ZY=;
 b=0IZGOYhxxOzmocjy+FnlRWWddRwvG6dU3MOyT9VZKYH3YJL8OkQyKAELgGi0n+mag/8Wda
 ll2P480nmAsrMsmTl5yIGl3Lz/0toK6XLeTMikkAK0GXlItKxN79wbb/832+HIizxL9C/o
 4TYT9Kl+/6uxGFES9d09EufFEHUCUrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780322942;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/7NM0MANjcbZV6jHa5EnOyS5w+40KPgaxCpBHEm/3ZY=;
 b=r86XnVbwMhGC1pjMHPace5fh0r4gCW/u3E7ieFoIppnnbl+nl5M+tdS5u6HiHfJtHAF5Ij
 zB/dGmJE7wTTRzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68CE4779A7;
 Mon,  1 Jun 2026 14:09:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MYLFGH6SHWqjbAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 01 Jun 2026 14:09:02 +0000
Date: Mon, 1 Jun 2026 16:09:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260601140901.GD3391768@pevik>
References: <20260601-doc_update-v1-0-b0f59834fbae@suse.com>
 <20260601-doc_update-v1-3-b0f59834fbae@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260601-doc_update-v1-3-b0f59834fbae@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] include: Fix kernel-doc warnings in header
 comments
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

> Drop :ref: cross-references to undocumented structs in tst_test.h
> and tst_kvercmp.h kernel-doc comments, replacing them with plain
> text. These produced 'undefined label' Sphinx warnings.

+1, that goes under me I guess. I checked that at the time, but I did not get it
would work without :ref:.

Fixes: b7df4320b0 ("tst_test.h: Link various structs in sphinx doc")
Fixes: 597613727a ("doc: Convert tst_kvercmp.h to RST")
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Downgrade kernel-doc comments to plain comments for struct tst_cmd
> and TST_CAP() macro to avoid name collisions with the tst_cmd()
> function and struct tst_cap respectively. The kernel-doc parser
> flattens names case-insensitively, causing 'name used several times'
> errors and duplicate target warnings.

Hm ...

...
> +++ b/include/tst_capability.h
> @@ -67,7 +67,7 @@ struct tst_cap {
>  	char *name;
>  };

> -/**
> +/*
>   * TST_CAP() - Create a struct tst_cap entry.

This is the only warning I'd prefer to stay unfixed (i.e. it was kept in the
docs). I wonder if we shouldn't jus rename struct or macro. Because TST_CAP()
should be documented. Cyril @WDYT?

>   *
>   * @action: What should we do, i.e. drop or add capability.
> diff --git a/include/tst_cmd.h b/include/tst_cmd.h
> index 831cb4da486881f9ef345b9f6ead461feb5dfd46..77fbbbc867b6edf841c5347ac612569a5b8470d1 100644
> --- a/include/tst_cmd.h
> +++ b/include/tst_cmd.h
> @@ -19,7 +19,7 @@ enum tst_cmd_flags {
>  	TST_CMD_TCONF_ON_MISSING = 2,
>  };

> -/**
> +/*
>   * struct tst_cmd - Provides details about a command struct needed by LTP test.
>   * @cmd: The name of the command.
>   * @optional: A flag indicating if the command is optional.
> diff --git a/include/tst_kvercmp.h b/include/tst_kvercmp.h
> index 7c991c746a3ab5383535b545c3025f2174d7722b..8457f7926da2022a9fcd215c9404e5cd7f566e0b 100644
> --- a/include/tst_kvercmp.h
> +++ b/include/tst_kvercmp.h
> @@ -93,7 +93,7 @@ struct tst_kern_exv {
>   * @r1: Major kernel version.
>   * @r2: Minor kernel version.
>   * @r3: Kernel patch level.
> - * @vers: A {} terminated array of :ref:`struct tst_kern_exv`.
> + * @vers: A {} terminated array of struct tst_kern_exv.

And ok, C sources and headers should not use :ref:, thanks for fixing it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
