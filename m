Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D8BBC433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 14:42:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12A853CA12E
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 15:42:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 811D83CA0C0
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 15:42:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BAC0D6005C3
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 15:42:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AB2BA219A9;
 Fri, 18 Feb 2022 14:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645195328;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lUUEC+SO6CF6EC7GHlpdYjphl5mOmls1pzQYtXGa4H4=;
 b=r81YGAKspsY4iv/W1UKSbyCMj36A5LZt2blbjYYnkGNzc4rKWc8SA/7ZRw+z9WPxyM3tIO
 l7j2AOeGrTI6+G2Fp8l4mccAl5M8VaK5cDPRk6F7OBgdb4G20I9yvYnfealboFKfGEUR7k
 SeqkRpMEReLZtFp7YSqhcCIcCgzkjGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645195328;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lUUEC+SO6CF6EC7GHlpdYjphl5mOmls1pzQYtXGa4H4=;
 b=DnkAtc6g5Pcw89At3C3PnAE4zrqd512N97P81xr22AO5KzCa4dQOLozrlB3hQtYlzuGAHN
 OQdtgjJJ3FeH/uAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 57E9C13C94;
 Fri, 18 Feb 2022 14:42:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UjkEE0CwD2I8DAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 18 Feb 2022 14:42:08 +0000
Date: Fri, 18 Feb 2022 15:42:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yg+wPtDfI4+bn1ww@pevik>
References: <20220211114401.24663-1-mdoucha@suse.cz> <YgZcu4frLBaKVXL2@yuki>
 <2e218131-be2b-d6c8-51f7-f12b9091e859@suse.cz>
 <CAEemH2fqy3_t=-dbqE9Bx3VH6sZbNvM_bMon4zMukOh+rmw42Q@mail.gmail.com>
 <Yg+RXbUTOxK56iZa@pevik> <Yg+UQM+YCmNU1ShF@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yg+UQM+YCmNU1ShF@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] 72b1728674 causing regressions [ [PATCH v2] Terminate
 leftover subprocesses when main test process crashes]
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
Cc: LTP List <ltp@lists.linux.it>, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> > Sometimes it's just a warning:

> I guess that it's a race between the SETSID() and exit(0) in the
> move_to_background() function. If the main test process calls exit(0)
> before the newly forked child managed to do SETSID() it's killed by the
> test library because it's still in the old process group.

Thanks!  Yep, it'll probably be a race.

Your patch causes server being killed:
tst_test.c:1511: TBROK: Test killed by SIGUSR1!

(no big surprise)

Also netstress server remains running:
netstress -D ltp_ns_veth1 -R 10 -B /tmp/LTP_tcp_ipsec.RZ6H3Adg4e

Kind regards,
Petr

> Try this:

> diff --git a/testcases/network/netstress/netstress.c b/testcases/network/netstress/netstress.c
> index 0914c65bd..04a850134 100644
> --- a/testcases/network/netstress/netstress.c
> +++ b/testcases/network/netstress/netstress.c
> @@ -713,11 +713,15 @@ static void server_cleanup(void)

>  static void move_to_background(void)
>  {
> -       if (SAFE_FORK())
> +       if (SAFE_FORK()) {
> +               pause();
>                 exit(0);
> +       }

>         SAFE_SETSID();

> +       SAFE_KILL(getppid(), SIGUSR1);
> +
>         close(STDIN_FILENO);
>         SAFE_OPEN("/dev/null", O_RDONLY);
>         close(STDOUT_FILENO);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
