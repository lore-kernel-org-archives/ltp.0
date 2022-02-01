Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5350C433F5
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 17:39:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52F6E3C9872
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 18:39:14 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E480F3C957B
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 18:39:04 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 924991000798
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 18:39:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9DCA71F3A8;
 Tue,  1 Feb 2022 17:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643737142;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AjcE01wSodrKebGKezaeLhVWVA1h3Z/vylREeRayTNo=;
 b=y42g+cqDLxn2yi0ATW2KdgVqFQ2hHslzhpD9S7oSgiYgX7zzmpaRg+3lj/fVGhUNON9nJp
 eTQ6T+Az7hA+/mIbGvT2xE7QSQGUQDkxwnA/B+kPV95b6HV+sjipCihjFtighrhBxzlcMg
 1nOIGG4pShICxeyoW/xZHfMAQyFydhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643737142;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AjcE01wSodrKebGKezaeLhVWVA1h3Z/vylREeRayTNo=;
 b=tWKZtd08HEkgOpGdnZ/0Qmypknh9dgZBKxXHSlNp+wckkuLCy6EzK/0aOU1MgnuDBj4Uez
 GKWFdlfP6md/w/CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71E3F13B66;
 Tue,  1 Feb 2022 17:39:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QudoGjZw+WGEcwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 01 Feb 2022 17:39:02 +0000
Date: Tue, 1 Feb 2022 18:39:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YflwND3aDJ1lg0ps@pevik>
References: <20220127171455.9809-1-pvorel@suse.cz>
 <61F609C7.1080803@fujitsu.com> <YfeN6fG28AVNC44n@pevik>
 <CAEemH2fRtV+OqrW+x49RosgpyOYqCZ1ULxvZvqwypK8HQn6EQA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fRtV+OqrW+x49RosgpyOYqCZ1ULxvZvqwypK8HQn6EQA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] lib: Print in summary also tests not run
 at all
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

...
> Yes, I understand. So how about this way:

> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -785,6 +785,8 @@ static void print_failure_hints(void)
>         print_failure_hint("known-fail", "hit by known kernel failures", NULL);
>  }

> +static unsigned int test_variants = 1;
> +
>  static void do_exit(int ret)
>  {
>         if (results) {
> @@ -811,9 +813,11 @@ static void do_exit(int ret)
>                 fprintf(stderr, "broken   %d\n", results->broken);
>                 fprintf(stderr, "skipped  %d\n", results->skipped);
>                 fprintf(stderr, "warnings %d\n", results->warnings);
> -               fprintf(stderr, "not run  %d\n", tst_test->tcnt -
> -                               results->passed - results->failed -
> results->broken -
> -                               results->skipped - results->warnings);
> +               if (tst_test->tcnt) {
> +                       fprintf(stderr, "not-run  %d\n",
> (tst_test->tcnt * test_variants) -
> +                                       results->passed -
> results->failed - results->broken -
> +                                       results->skipped - results->warnings);
> +               }
>         }

>         do_cleanup();
> @@ -1529,7 +1533,6 @@ unsigned int tst_variant;
>  void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>  {
>         int ret = 0;
> -       unsigned int test_variants = 1;

>         lib_pid = getpid();
>         tst_test = self;

Yep, ack this one, works well. Will you please send a proper patch?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
