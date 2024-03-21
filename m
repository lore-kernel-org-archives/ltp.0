Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D83EC54E68
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 12:42:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC7EE3C997B
	for <ltp@archiver.kernel.org>; Thu, 21 Mar 2024 13:42:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B163D3C997B
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 13:41:51 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C92F22009A1
 for <ltp@lists.linux.it>; Thu, 21 Mar 2024 13:41:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE2EF5CE4B;
 Thu, 21 Mar 2024 12:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711024906;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SG0LwTBKlAKmo3hosE/mz/AYTAAo2idjVk/Zbtw8jlA=;
 b=tyLfbmWX0mkpcFSxzT8prYY5kHFPj5zlbmk9PpQGxkfDbpJwpqIC5w5BizQr4/76il4XFh
 QCv+kjYs9Aa4ms1CVfRFEXBGn9zbJRs/T/YKzpNLJuIjKJnugtOo606m/uzilBz4OjpkLl
 j0BJtVxUeOs13AlxiNRsm2OYQ2eMEe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711024906;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SG0LwTBKlAKmo3hosE/mz/AYTAAo2idjVk/Zbtw8jlA=;
 b=kfPCdQPofidmUb6Lstc8IbMIW4q/bEiv2eB4N0+3EfuOCdwwKckfcT8MkxnfhGP4Xu+d/t
 RYrizV8OeTWrb+Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711024906;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SG0LwTBKlAKmo3hosE/mz/AYTAAo2idjVk/Zbtw8jlA=;
 b=tyLfbmWX0mkpcFSxzT8prYY5kHFPj5zlbmk9PpQGxkfDbpJwpqIC5w5BizQr4/76il4XFh
 QCv+kjYs9Aa4ms1CVfRFEXBGn9zbJRs/T/YKzpNLJuIjKJnugtOo606m/uzilBz4OjpkLl
 j0BJtVxUeOs13AlxiNRsm2OYQ2eMEe4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711024906;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SG0LwTBKlAKmo3hosE/mz/AYTAAo2idjVk/Zbtw8jlA=;
 b=kfPCdQPofidmUb6Lstc8IbMIW4q/bEiv2eB4N0+3EfuOCdwwKckfcT8MkxnfhGP4Xu+d/t
 RYrizV8OeTWrb+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA84E136AD;
 Thu, 21 Mar 2024 12:41:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3l6LMAor/GUZSwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 21 Mar 2024 12:41:46 +0000
Date: Thu, 21 Mar 2024 13:41:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240321124141.GA551159@pevik>
References: <20240319100822.3243785-1-liwang@redhat.com>
 <20240319100822.3243785-2-liwang@redhat.com>
 <20240320073116.GA452876@pevik>
 <CAEemH2ebMOLj+uco1JCr-bhqk-OF87YXG1rH0VjdPLe_PUpwfg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ebMOLj+uco1JCr-bhqk-OF87YXG1rH0VjdPLe_PUpwfg@mail.gmail.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tyLfbmWX;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kfPCdQPo
X-Spamd-Bar: /
X-Spamd-Result: default: False [-0.85 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.14)[68.10%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DE2EF5CE4B
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] libswap: add two methods to create swapfile
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

...
> > > -int make_swapfile(const char *swapfile, int blocks, int safe);
> > > +int make_swapfile(const char *swapfile, unsigned int num,
> > > +                     int safe, enum swapfile_method method);
> > I wonder if it would help to add const char *file, const int lineno here.

> > > +
> > > +#define MAKE_SWAPFILE_SIZE(swapfile, size, safe) \
> > > +    make_swapfile(swapfile, size, safe, SWAPFILE_BY_SIZE)
> > nit: I like the name but one have to search which units (kB vs. MB vs. GB)
> > are used.


> Maybe we can add code comments like:

> +/**
> + * Macro to create swapfile size in megabytes (MB)
> + */
>  #define MAKE_SWAPFILE_SIZE(swapfile, size, safe) \
>     ...

> +/**
> + * Macro to create swapfile size in block numbers
> + */
>  #define MAKE_SWAPFILE_BLKS(swapfile, blocks, safe) \
>       ...

Sure, that's enough.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
