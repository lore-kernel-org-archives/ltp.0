Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCBDC433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 05:26:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0AFA03CA592
	for <ltp@archiver.kernel.org>; Mon, 11 Jul 2022 07:26:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8543A3CA4F7
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 07:25:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B23941A006B0
 for <ltp@lists.linux.it>; Mon, 11 Jul 2022 07:25:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA9FF1FE2C;
 Mon, 11 Jul 2022 05:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1657517151;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HQqbKY9ceR5uk5DV2weUfgEpaGf3q/Ch21QIonAzGs8=;
 b=C4VikmOr/muz38rHeW2RB78GAy6Dq3oFFCGY3GFcmQXXXIIgEj82KWCvO+gTDyjvfMUV66
 sYSlbZaTTik9cPGPISJ3S1C+f/xp1nor7GVyLJvCy5qD8RrfYBtoH43CLvtWRZF+v+ZdoO
 VOOIfQ2lawvQvaDC+CRDKfd6sJ7vJSM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1657517151;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HQqbKY9ceR5uk5DV2weUfgEpaGf3q/Ch21QIonAzGs8=;
 b=hNInhrlkntlbYOjjwD2NplM6Ib9WyNmEN+9pAnLvbHxjP1TjYHejGap6SUqfbp46kP4GXS
 kheJx46mpNqE3CBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9AF0113524;
 Mon, 11 Jul 2022 05:25:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id V/aBJF+0y2LIXQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 11 Jul 2022 05:25:51 +0000
Date: Mon, 11 Jul 2022 07:25:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Message-ID: <Ysu0XlNGy2F+uInC@pevik>
References: <20220314191234.12382-1-pvorel@suse.cz>
 <62C5663C.2060009@fujitsu.com> <YscgIvZauxbArm7i@pevik>
 <20220708143728.r655waixwr3x7xtg@wittgenstein>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220708143728.r655waixwr3x7xtg@wittgenstein>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] creat09: Fix on more restrictive umask
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
Cc: Martin Doucha <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Thu, Jul 07, 2022 at 08:04:18PM +0200, Petr Vorel wrote:
> > Hi Xu,

> > > Hi Petr

> > > Share some process with you...

> > > I have rejected this patch and a kernel patchset[1] is plan to fix this 
> > > but doesn't merged to upstream kernel due to none continue to review 
> > > this(It is about one month since v9...)

> > > TBH, this case only tests simple creat file with open but miss
> > > open with O_TMPFILE[2]
> > > mknodat[3]

> > > setgid strip logic is not only affected by umask but also include acl 
> > > operations[4].

> > Thanks a lot for an update.
> > Al, Christian, Amir, could you please have look on v9?

> Afaict, I reviewed v9 and left comments and had pointed out things that
> needed to be changed. So I'd wait for v10 (I'm on vacation next week
> though.).

Thanks a lot, sorry for overlooking your change requests!

Kind regards,
Petr

> Christian

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
