Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2EA8C433F5
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 09:57:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E26363C920D
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 10:57:51 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 132A83C8EE8
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 10:57:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D9E1A1A004EE
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 10:57:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0F9121F388;
 Tue, 21 Dec 2021 09:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640080661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ytTL8sqzr8Mw3T3sE9XEFbdhkMJ+htNAgQkwpypRUww=;
 b=fkLFwKd5/2dMDAPOfopmPUIzju9vQSc6EG/Q7kbfNvgsqTwUItEEtlz8fc8Tic4rw90REP
 wxVIG/8Gvr6kOxzFaqgV2WepoYxZ1nPmBJRrFsjI7JIUfOdyTlrFGmQMfEGWGFyCS5sNIC
 T6+1cKI94U1o7VfGQIriTdceVQuRBjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640080661;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ytTL8sqzr8Mw3T3sE9XEFbdhkMJ+htNAgQkwpypRUww=;
 b=lIMXV7wS04b3x6QkJszxODa4w/aSK2+DOTZrHKYZfEaxvk4IXAo6Tt9FXrTzsvTg1FT+p+
 kcJnQibBq6ScNFAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F03AC13A5F;
 Tue, 21 Dec 2021 09:57:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7pulORSlwWEJUQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 21 Dec 2021 09:57:40 +0000
Date: Tue, 21 Dec 2021 10:59:11 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YcGlb4NoDGSP4ZkU@yuki>
References: <20211220095416.583323-1-liwang@redhat.com>
 <YcDMnDRgsac/q8D9@pevik>
 <CAEemH2d6PPi94q3PhMyR1Js_Rqr1dpfvch=ex3HpuHfQKJYTnw@mail.gmail.com>
 <YcGb5abUqe8PNKoM@yuki>
 <CAEemH2dDEM30-fM89LDZq1E7YN8rf44doGgnkPXuce0ttP67OA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dDEM30-fM89LDZq1E7YN8rf44doGgnkPXuce0ttP67OA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] lib: add functions to adjust oom score
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Not exactly, if someone gives a wrong PID, that also cannot find
> the score_path. So we shouldn't skip OOM adjustment only
> with printing the TFINO.

Right, we would have to check if the /proc/$PID/ directory exists
first.

> > if (access(score_path, F_OK)) {
> >         tst_res(TINFO,
> >                 "'%s' does not exist, skipping OOM score adjustement",
> >                 score_path);
> >         return;
> > }
> >
> > if (access(score_path, W_OK)) {
> >         tst_res(TWARN, "'%s' not writeable, are you root?", score_path);
> >         return;
> > }
> >
> 
> As Petr points out, only root user can set a negative value to
> oom_score_adj,
> this W_OK is not enough for ordinary users.

Ah, right this makes it even more complex.

> Consider about situation, I'd suggest go with non-safe macros and add
> additional check in the last.
> 
> e.g.
> 
> --- a/lib/tst_memutils.c
> +++ b/lib/tst_memutils.c
> @@ -108,17 +108,21 @@ static void set_oom_score_adj(pid_t pid, int value)
>         else
>                 sprintf(score_path, "/proc/%d/oom_score_adj", pid);
> 
> -       if (access(score_path, R_OK | W_OK) == -1) {
> -               tst_res(TINFO, "Warning: %s cannot be accessed for
> reading/writing,
> -                       please check if test run with root user.",
> -                       score_path);
> -               return
> -       }
> -
> -       SAFE_FILE_PRINTF(score_path, "%d", value);
> -       SAFE_FILE_SCANF(score_path, "%d", &val);
> -       if (val != value)
> +       if (access(score_path, F_OK) == -1)
> +               tst_brk(TBROK, "%s does not exist, please check if PID is
> valid");

Maybe we should print the pid in the message here as well.

> +
> +       FILE_PRINTF(score_path, "%d", value);
> +       FILE_SCANF(score_path, "%d", &val);
> +
> +       if (val != value) {
> +               if (value < 0) {
> +                       tst_res(TINFO, "Warning: %s cannot be set to
> negative value,
> +                               please check if test run with root user.",

I would say that we TBROK here, otherwise it could be silently ignored.
Also I would shorten the message to something as:

	"'%s' cannot be set to %i, are you root?", score_path, value);

> +                               score_path);
> +                       return
> +               }
>                 tst_brk(TBROK, "oom_score_adj = %d, but expect %d.", val,
> value);
> +       }
>  }
> 
> 
> -- 
> Regards,
> Li Wang

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
