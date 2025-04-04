Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 201FAC36010
	for <ltp@archiver.kernel.org>; Fri,  4 Apr 2025 12:55:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3CBE33C8EE0
	for <ltp@archiver.kernel.org>; Fri,  4 Apr 2025 14:55:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B19D3CB2E0
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 14:55:24 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1E99C1400069
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 14:55:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 404A721171;
 Fri,  4 Apr 2025 12:55:23 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 269D013691;
 Fri,  4 Apr 2025 12:55:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ik9tCLvW72egUQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 04 Apr 2025 12:55:23 +0000
Date: Fri, 4 Apr 2025 14:55:17 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250404125517.GA527835@pevik>
References: <20250403113053.20040-1-chrubis@suse.cz>
 <20250403123610.GA465253@pevik> <Z-6XSwc9Rbu2RIzm@yuki.lan>
 <Z-_K0zj30GOhxYS8@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z-_K0zj30GOhxYS8@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 404A721171
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib/tst_test.c: Fix tst_brk() handling
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
> > diff --git a/lib/tst_test.c b/lib/tst_test.c
> > index c6395a5eb..6b1100b09 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -407,7 +407,8 @@ void tst_vbrk_(const char *file, const int lineno, int ttype, const char *fmt,
> >          * current process.
> >          */
> >         if (TTYPE_RESULT(ttype) == TBROK) {
> > -               tst_atomic_inc(&results->abort_flag);
> > +               if (results)
> > +                       tst_atomic_inc(&results->abort_flag);

> >                 /*
> >                  * If TBROK was called from one of the child processes we kill


> And it's a bit more complex we also need to make sure to exit properly
> when tst_brk() was called before the library was initialized, so we also

+1

> need:

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 758e62823..d19908d94 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -386,6 +386,14 @@ void tst_vbrk_(const char *file, const int lineno, int ttype, const char *fmt,
>                va_list va)
>  {
>         print_result(file, lineno, ttype, fmt, va);
> +
> +       /*
> +        * If tst_brk() is called from some of the C helpers even before the
> +        * library was initialized, just exit.
> +        */
> +       if (!lib_pid)
> +               exit(TTYPE_RESULT(ttype));

Interesting, I never noticed lib_pid :). It's assigned in tst_run_tcases() -
library gets initialized there. As that's the very first call in main(), this
really applies for helpers in testcases/lib/ which define TST_NO_DEFAULT_MAIN.

I suppose this is the part of the fix for core dumped helpers.

> +
>         update_results(TTYPE_RESULT(ttype));

>         /*
> @@ -415,7 +423,7 @@ void tst_vbrk_(const char *file, const int lineno, int ttype, const char *fmt,
>                  * the main test process. That in turn triggers the code that
>                  * kills leftover children once the main test process did exit.
>                  */
> -               if (tst_getpid() != main_pid) {
> +               if (main_pid && tst_getpid() != main_pid) {
>                         tst_res(TINFO, "Child process reported TBROK killing the test");
>                         kill(main_pid, SIGKILL);
>                 }


> I will send v2 later on.

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
