Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A902EC433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 10:34:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 472E63C9254
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 11:34:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47B923C104E
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 11:34:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C300D1401276
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 11:34:46 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D4AD91F3B9;
 Tue, 21 Dec 2021 10:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640082885; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IGlpvdwIhDKjMO6u7xNE3dfVOgKtAx/o5k/BsF/SDR0=;
 b=GonVsfEgHAeI7lIcsm0MPE+Gp2VruE5sRyBX6+FYCCB3pUSWJ5pLQ2av/uSBstnp6wHDue
 nZETkomYygm6eT7s1cayoiqXDVlWrB0yhL+kRaxZPyk++PbwAgtVtMZpOim3WIi+0dglrm
 w/H5QVwQ41E5wqg9FZanJX2ubMh03wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640082885;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IGlpvdwIhDKjMO6u7xNE3dfVOgKtAx/o5k/BsF/SDR0=;
 b=kQGDaHswRGNHKM9+GN5Q7qoDVS+Z18NKbsKS5zLlACozJxR1Dz3FqWHHI0MCwm/j2WTn0h
 Z4kP0JJPGHQ/n7BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B456813A5F;
 Tue, 21 Dec 2021 10:34:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NW4oK8WtwWHEYQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 21 Dec 2021 10:34:45 +0000
Date: Tue, 21 Dec 2021 11:36:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YcGuIJql99Row3o9@yuki>
References: <20211220095416.583323-1-liwang@redhat.com>
 <YcDMnDRgsac/q8D9@pevik>
 <CAEemH2d6PPi94q3PhMyR1Js_Rqr1dpfvch=ex3HpuHfQKJYTnw@mail.gmail.com>
 <YcGb5abUqe8PNKoM@yuki>
 <CAEemH2dDEM30-fM89LDZq1E7YN8rf44doGgnkPXuce0ttP67OA@mail.gmail.com>
 <YcGlb4NoDGSP4ZkU@yuki>
 <CAEemH2fFY_TuCEqoR9ogqUBA5mFjY-FX+tDufYs39uN0JJ9gvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2fFY_TuCEqoR9ogqUBA5mFjY-FX+tDufYs39uN0JJ9gvQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
> So, I will push (the improved) code like below, after getting
> Petr and you ack again:
> 
> +static void set_oom_score_adj(pid_t pid, int value)
> +{
> +       int val;
> +       char score_path[64];
> +
> +       if (access("/proc/self/oom_score_adj", F_OK) == -1) {
> +               tst_res(TINFO, "Warning: oom_score_adj does not exist,
> +                               skipping the adjustement");

I'm not sure about the "Warning:" in this message, I would just dully
informed the user that the interface is not available.

> +               return;`
> +       }
> +
> +       if (pid == 0) {
> +               sprintf(score_path, "/proc/self/oom_score_adj");
> +       } else {
> +               sprintf(score_path, "/proc/%d/oom_score_adj", pid);
> +               if (access(score_path, F_OK) == -1)
> +                       tst_brk(TBROK, "%s does not exist, please
> check if PID is valid", score_path);
> +       }
> +
> +       FILE_PRINTF(score_path, "%d", value);
> +       FILE_SCANF(score_path, "%d", &val);
> +
> +       if (val != value) {
> +               if (value < 0) {
> +                       tst_res(TWARN, "'%s' cannot be set to %i, are
> you root?",
> +                               score_path, value);
> +                       return
> +               }
> +               tst_brk(TBROK, "oom_score_adj = %d, but expect %d.",
> val, value);
> +       }
> +}

Anyways this version looks good to me:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
