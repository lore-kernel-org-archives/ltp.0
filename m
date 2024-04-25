Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BADFFC4345F
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 15:39:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24B4A3CFE15
	for <ltp@archiver.kernel.org>; Thu, 25 Apr 2024 17:39:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25AC73CE530
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 17:38:51 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8D31260012A
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 17:38:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C94433ED4;
 Thu, 25 Apr 2024 15:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714059529;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mX9+2vclahPhh2FF2qfDNt8PCqoQAV1qzWgnaS00jkw=;
 b=yRuJOcvp7mjnebTkZq20nwLsZP9sHD92zQ3ovCHr+EsgkAFL2hELVuhXy2rWhJUglqjf3G
 vhMNbWnKLuiqX6F3WiS0yDZAZS8xPLM56wfcZYEk9aHAL3h7AXeaql3JkVCLwjmBA7nNnG
 +cg+mH/Hy0bVDmjuOkEY3DQWXBnwDh4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714059529;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mX9+2vclahPhh2FF2qfDNt8PCqoQAV1qzWgnaS00jkw=;
 b=2v0Gc8qlt1ac2axZo2X3k+UtmUMCUjLhrMQ/XLQCwdfd7OXuVQ1bogsZ55CnfMzj93yT7W
 O1B8M18c+NKyUaBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=q8cY1wkg;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0JQibhW8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1714059528;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mX9+2vclahPhh2FF2qfDNt8PCqoQAV1qzWgnaS00jkw=;
 b=q8cY1wkgcBW86yE2fhqWHo1uXbv+WJC59fBF1vDAMU1vZz1PEs+YYTv6a5pPILKH0lojba
 rLbbnVprF5n9NAAxJG6Liy6zSjb6BCu7b1bMr+WDMN8s8GpbYhsSYbdh2pFM82FLKbOKj8
 6uyVmFNeK4cQ5m1waEZn7Po7AgEQHQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1714059528;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mX9+2vclahPhh2FF2qfDNt8PCqoQAV1qzWgnaS00jkw=;
 b=0JQibhW8EZxh07godydxe4bH4iUeah2ekWARsTPw9IEMYAA4U11DT2t89wU/Ks+ujNqm7H
 onD206xy4SxJoxAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F0A51393C;
 Thu, 25 Apr 2024 15:38:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qUUOAwh5KmaQFQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 25 Apr 2024 15:38:48 +0000
Date: Thu, 25 Apr 2024 17:38:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20240425153846.GA291548@pevik>
References: <20240423132823.194179-1-pvorel@suse.cz>
 <20240423132823.194179-2-pvorel@suse.cz>
 <CAASaF6wWtdmG6nWpWcTv=AnzJn8vSe71RQsSkcF-1wHbPb_Mjw@mail.gmail.com>
 <20240424121740.GA227922@pevik>
 <CAASaF6yfGK5zHMW0wQxWM+r+6=dT_sT+5HSqJPLadhQ1O85KZw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6yfGK5zHMW0wQxWM+r+6=dT_sT+5HSqJPLadhQ1O85KZw@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 2C94433ED4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:replyto];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lapi/fs: Include lapi/fcntl.h + define
 _GNU_SOURCE
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

Hi Jan, all,

...
> > OK, this will work, just lapi/fs.h must be loaded before tst_test.h,
> > othewise it would fail on Alpine:

> So this is essentially:
> ------------------------------------------
> #include <fcntl.h> // from tst_test.h include chain
> #define _GNU_SOURCE // from lapi/fs.h
> #include <fcntl.h>

> int main(void)
> {
>         loff_t asd;
>         return 0;
> }
> ------------------------------------------

> and it doesn't compile. And same applies if you include first any of
> these first:
> include/lapi/fcntl.h:#include <fcntl.h>
> include/lapi/io_uring.h:#include <fcntl.h>
> include/lapi/pidfd.h:#include <fcntl.h>
> include/safe_macros_fn.h:#include <fcntl.h>
> include/tst_safe_macros.h:#include <fcntl.h>

> Do we really need for tst_max_lfs_filesize() to return loff_t? If we
> changed it to "long long",
> we'd avoid lot of issues with includes and _GNU_SOURCE for just single
> user of this function.

+1. We might get extra warning when there is 32 bit, but it would make things
much easier => I'll send another version.

Kind regards,
Petr


> > In file included from unlink09.c:20:
> > ../../../../include/lapi/fs.h:61:15: error: unknown type name 'loff_t'
> >    61 | static inline loff_t tst_max_lfs_filesize(void)
> >       |               ^~~~~~
> > ../../../../include/lapi/fs.h: In function 'tst_max_lfs_filesize':
> > ../../../../include/lapi/fs.h:64:17: error: 'loff_t' undeclared (first use in this function); did you mean 'off_t'?
> >    64 |         return (loff_t)LLONG_MAX;
> >       |                 ^~~~~~
> >       |                 off_t
> > ../../../../include/lapi/fs.h:64:17: note: each undeclared identifier is reported only once for each function it appears in
> > ../../../../include/lapi/fs.h:64:24: error: expected ';' before numeric constant
> >    64 |         return (loff_t)LLONG_MAX;
> >       |                        ^
> >       |                        ;
> > make: *** [../../../../include/mk/rules.mk:45: unlink09] Error 1

> > (glibc hides loff_t behind __USE_MISC, which I thought it it's in the end
> > _GNU_SOURCE, but obviously not).
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
