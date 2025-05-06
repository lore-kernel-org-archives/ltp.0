Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2257C3ABBE
	for <ltp@archiver.kernel.org>; Tue,  6 May 2025 08:25:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C73D73CA20F
	for <ltp@archiver.kernel.org>; Tue,  6 May 2025 10:25:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32F8F3C5502
 for <ltp@lists.linux.it>; Tue,  6 May 2025 10:25:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 29355140025A
 for <ltp@lists.linux.it>; Tue,  6 May 2025 10:25:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C09F1F387;
 Tue,  6 May 2025 08:25:40 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E507113687;
 Tue,  6 May 2025 08:25:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +nnHMoPHGWhPWgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 06 May 2025 08:25:39 +0000
Date: Tue, 6 May 2025 10:25:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250506082538.GA66237@pevik>
References: <20250429052247.GA144682@pevik> <aBSVO8uOE86UGIcp@yuki.lan>
 <20250505195003.GB137650@pevik> <aBnCSDh8eqy38mIy@rei.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aBnCSDh8eqy38mIy@rei.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 3C09F1F387
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP in valgrind :)
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
Cc: Mark Wielaard <mark@klomp.org>, Martin Cermak <mcermak@redhat.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > > It also opens some interesting questions, i.e. how do we make comparing
> > > results from two different tests easier. Currently they grep the test
> > > results for a summary, but maybe we can do better.

> > Kirk and compare json?

> That does sound like an overkill for something that is basically:

Agree. I sometimes think JSON output would be useful to be even in core LTP
(not requiring kirk), but that's something different than reproducible output.

The patch above LGTM (if you send patch please remember to update
doc/users/setup_tests.rst).

Kind regards,
Petr

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 694861d95..29d9fc1d5 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -64,6 +64,7 @@ static int mntpoint_mounted;
>  static int ovl_mounted;
>  static struct timespec tst_start_time; /* valid only for test pid */
>  static int tdebug;
> +static int reproducible_output;

>  struct results {
>         int passed;
> @@ -299,6 +300,9 @@ static void print_result(const char *file, const int lineno, int ttype,
>         str += ret;
>         size -= ret;

> +       if (reproducible_output)
> +               goto print;
> +
>         if (tst_color_enabled(STDERR_FILENO))
>                 ret = snprintf(str, size, "%s%s: %s", tst_ttype2color(ttype),
>                                res, ANSI_COLOR_RESET);
> @@ -324,6 +328,7 @@ static void print_result(const char *file, const int lineno, int ttype,
>                                 "Next message is too long and truncated:");
>         }

> +print:
>         snprintf(str, size, "\n");

>         /* we might be called from signal handler, so use write() */
> @@ -1273,6 +1278,8 @@ static void do_setup(int argc, char *argv[])
>         if (tst_test->tconf_msg)
>                 tst_brk(TCONF, "%s", tst_test->tconf_msg);

> +       reproducible_output = !!getenv("LTP_REPRODUCIBLE_OUTPUT");
> +
>         assert_test_fn();

>         TCID = tid = get_tid(argv);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
