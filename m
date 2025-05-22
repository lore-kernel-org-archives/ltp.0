Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B98C54E65
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 19:52:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2930C3CC8BF
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 21:52:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 011C53C68A4
 for <ltp@lists.linux.it>; Thu, 22 May 2025 21:52:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C9C19600476
 for <ltp@lists.linux.it>; Thu, 22 May 2025 21:52:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E53701F899;
 Thu, 22 May 2025 19:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747943542;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=24T+ViPwsJNralWBHA26BI4ofiVb3KlS1cpxZa1VTX8=;
 b=W3YEhpoouInaQzG6SlKEKgW5k5lNw/SUlFpmxt8P3zwuTjAZJxOA1xlspTAYzrhSPmoPci
 5K7qjr7NNJq4NZo7SUP6rI5HPgV9WyFHpKGjPT0oYnLlZuFEdkCmN1a6nEfGnIvoaHg0hM
 A6y/T7tmxq9X36nWrz/fRBP/UsJPEl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747943542;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=24T+ViPwsJNralWBHA26BI4ofiVb3KlS1cpxZa1VTX8=;
 b=b11YDPnoTZKy9rju53TlaQUrGYROGWY41UK3Spj+PogQUjV9UVAFi8bG4LqJ/j4aQ8C/gZ
 O1Z5OLizgn/GmsDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=VIWEwfK0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="T/RSOaoU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747943541;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=24T+ViPwsJNralWBHA26BI4ofiVb3KlS1cpxZa1VTX8=;
 b=VIWEwfK0Ms1OuVMw9MAuVDfQEKjhE63PyoxqA1b++mvcTslb1fyIxpwUPUF2chVw/I25zr
 /gaWOJtOAVZ2k5dCxb6VME4VPWCnhD8iRVCOeBxlBRiE7f6iYbUz6YyqW2qk3TN05HJ9dA
 9MpLsrO1hszHwMwfjCxO7d7ob9cJJGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747943541;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=24T+ViPwsJNralWBHA26BI4ofiVb3KlS1cpxZa1VTX8=;
 b=T/RSOaoU0S7d5gGsPzF/2IR/essk2WNgvncc4Z2zg0Ou7MlE1+QrxU2mue+5yAQW8JzO6m
 XDRExBAl3jjVfcAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86B9913433;
 Thu, 22 May 2025 19:52:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UViKHXWAL2jWcAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 22 May 2025 19:52:21 +0000
Date: Thu, 22 May 2025 21:52:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250522195215.GA30761@pevik>
References: <20250520202429.577890-1-luizcap@redhat.com>
 <CAEemH2cdN6mcYJk06ksp7nyzz5qOmmRM=sR_SAqLtquD=8ya3g@mail.gmail.com>
 <ae7ee313-21f4-4f82-b522-4028947c8a1c@redhat.com>
 <CAEemH2dccNNvuEE_GNLxd3eR1_uiVX+UhmFBaNXTPU7sRYg29w@mail.gmail.com>
 <CAEemH2f33e0287pfngF+dczQ_AS0Yvt6YxNQOnrpSGHuqODRbQ@mail.gmail.com>
 <72dcba43-6d27-40e9-a110-3db7990e58d1@redhat.com>
 <CAEemH2dx1HFd1jxjtujA3JHAQBER4RrW_xiW0tS5xb5M2pkhiw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dx1HFd1jxjtujA3JHAQBER4RrW_xiW0tS5xb5M2pkhiw@mail.gmail.com>
X-Spamd-Bar: /
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E53701F899
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.71 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ksm: fix segfault on s390
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
Cc: ltp@lists.linux.it, Luiz Capitulino <luizcap@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Luiz,

> Luiz Capitulino <luizcap@redhat.com> wrote:

> > > I might be a bit too picky:). So I compared the two approaches on a
> > > 2 CPUs, KVM, x86_64 system:

> > > Per-block checking cost time:
> > >     real 0m5.862s
> > >     user 0m1.098s
> > >     sys 0m1.505s

> > > Per-byte checking cost time:
> > >    real    0m6.819s
> > >    user    0m2.498s
> > >    sys     0m1.495s

> > >  From the data, block-by-block checking can reduce the total execution
> > > time by about 14% and reduce CPU usage by more than 35%, especially
> > > in user-space calculations. This number may not be large, but considering
> > > that tests are frequently run in CI, I think it would be a good thing if we can
> > > reduce 1 second each time :).

> > Just to make sure I understand: you measured total test run-time, correct?
> > How many times did you run it?

> > In any case, I'm not sure a 1 second run-time (or even CPU utilization) matters
> > that much. You're running test code, you shouldn't expect otherwise unless you
> > hit a very bad case (say something taking several hours to complete).

> > The trade off is more complex code with bugs that can hide for 10+ years and
> > take developer time to debug. Also, higher memory utilization: 's' doubles
> > memory utilization per child only to do that check.

> Ture, that's why the problem not been find so many years!


> > So, I suggest we stick to the simpler code. Or, get it merged now (since it's
> > fixing a bug and possibly making the code _faster_) and then you can optimize
> > on top later if you like.

> Ok, sounds reasonable.

> Reviewed-by: Li Wang <liwang@redhat.com>

> @Cyril, @Petr, I vote to merge this one (as it is) before our May release.

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
