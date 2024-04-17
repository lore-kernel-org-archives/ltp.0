Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB583C4345F
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 12:24:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DBC93CFB93
	for <ltp@archiver.kernel.org>; Wed, 17 Apr 2024 14:24:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E5103CFB81
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 14:24:22 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A24F3140119E
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 14:24:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 57159208AD;
 Wed, 17 Apr 2024 12:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713356660;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5BLC4mFwenPCebPijH0m61YjkWTF3Nx1VMUc4+5VC1w=;
 b=PJEa4IdWtCn42f71EjvO6BUnk3jmTmZpKktKsqVN82o1DnAo6yJ9IDJu9DTdaRda+gsCCN
 bmeTAX/T8aGzGUy5l/4Qu2MgFK7erxWjrRqOEOZlmBfdiPOiBeCjqr9iadGri4EsTzIFMn
 UiyY4y74gte0nyOC5eyPnAqOsJhcfrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713356660;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5BLC4mFwenPCebPijH0m61YjkWTF3Nx1VMUc4+5VC1w=;
 b=tXJcK1OEuNQcoFWevIqR1VEH3ot0//RyQdZfXoC7L1vQ1BLf1uuZHXyhXvBVsXw7Fk2jUU
 I4EnsYsl/xR2MaCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PJEa4IdW;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tXJcK1OE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713356660;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5BLC4mFwenPCebPijH0m61YjkWTF3Nx1VMUc4+5VC1w=;
 b=PJEa4IdWtCn42f71EjvO6BUnk3jmTmZpKktKsqVN82o1DnAo6yJ9IDJu9DTdaRda+gsCCN
 bmeTAX/T8aGzGUy5l/4Qu2MgFK7erxWjrRqOEOZlmBfdiPOiBeCjqr9iadGri4EsTzIFMn
 UiyY4y74gte0nyOC5eyPnAqOsJhcfrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713356660;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5BLC4mFwenPCebPijH0m61YjkWTF3Nx1VMUc4+5VC1w=;
 b=tXJcK1OEuNQcoFWevIqR1VEH3ot0//RyQdZfXoC7L1vQ1BLf1uuZHXyhXvBVsXw7Fk2jUU
 I4EnsYsl/xR2MaCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 389F01384C;
 Wed, 17 Apr 2024 12:24:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PwnaDHS/H2bGGwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 17 Apr 2024 12:24:20 +0000
Date: Wed, 17 Apr 2024 14:24:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240417122418.GB727397@pevik>
References: <20240417090222.707302-1-pvorel@suse.cz> <Zh-eIg51K9UtdQuj@yuki>
 <20240417100611.GA713385@pevik> <Zh-lGL4tU5Z2dSLi@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zh-lGL4tU5Z2dSLi@yuki>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 57159208AD
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] libswap: Change TWARN message to TINFO
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> Looking at the patches we get the warning from the is_swap_supported()
> because we create only 10 blocks worth of swapfile there, right?

> So the easiest fix is to make sure we create big enough swapfile there
> as well, what about?

> diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
> index 313a15f24..36b5af483 100644
> --- a/libs/libltpswap/libswap.c
> +++ b/libs/libltpswap/libswap.c
> @@ -192,7 +192,7 @@ int make_swapfile_(const char *file, const int lineno,
>  bool is_swap_supported(const char *filename)
>  {
>         int i, sw_support = 0;
> -       int ret = SAFE_MAKE_SWAPFILE_BLKS(filename, 10);
> +       int ret = SAFE_MAKE_SWAPFILE_SIZE(filename, 1);
Let me first check where it's needed, because SAFE_MAKE_SWAPFILE_BLKS() is
called on more places.

Also, first is needed to move __FILE__, __LINE__ in macros (from function),
sending patch...

Kind regards,
Petr

>         int fi_contiguous = file_is_contiguous(filename);
>         long fs_type = tst_fs_type(filename);
>         const char *fstype = tst_fs_type_name(fs_type);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
