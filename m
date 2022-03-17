Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE6DCC433EF
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 20:38:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 713F63C948F
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 21:38:42 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB7CF3C6D9E
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 21:38:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 92EB81A0070B
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 21:38:30 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A4AA01F37F;
 Thu, 17 Mar 2022 20:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647549509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=74lwdKIvwqGlz3JKStuWrhCEtymdSwcboFZAop10ib4=;
 b=xXCQiOttHz6ld0hVV4vg3HwLLG04+TWKfPwDO0t9rzplUTZ1PCD7eKhVSdiwTPAuprIeeJ
 ttrGEGDWs92J9/8uQRkXS8w8VtfP8HKFSWZsDi8efgHvW5nL0XpFao69PPKQCZIhzJiDyg
 qT21KZFd++GPXcJbFQP1LvzqR2+3cNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647549509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=74lwdKIvwqGlz3JKStuWrhCEtymdSwcboFZAop10ib4=;
 b=G/2ECm/o7nY9+tFj3b+PUTeq/MwVG5FP6hAJ+Dtrc10ZFjq5hsVsNgWQOZZ0kxMVJXY4bk
 t9IbNRutxW+PbUAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6030C132BE;
 Thu, 17 Mar 2022 20:38:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id W+O8FUWcM2K6TQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 17 Mar 2022 20:38:29 +0000
Date: Thu, 17 Mar 2022 21:38:30 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yael Tzur <yaelt@google.com>
Message-ID: <YjOcRn1qx0LHlO/j@pevik>
References: <20220223200731.1859670-1-yaelt@google.com> <Yh+S7JD2q8oalRoM@yuki>
 <YiBcyvtqTX1CerM4@pevik> <YiC4Pj1sH8UIHY7k@yuki>
 <YiDB7wO3Se/vN15+@pevik> <YiDGvzETiI/nxwW/@yuki>
 <YiDLn3GMNFu482XG@pevik>
 <CAKoutNsc-JWQd1MOTFk7Hd_MgsFKj=6qi=uusKez2HgatTNCdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAKoutNsc-JWQd1MOTFk7Hd_MgsFKj=6qi=uusKez2HgatTNCdQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/keyctl09: test encrypted keys with
 provided decrypted data.
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Thu, Mar 3, 2022 at 9:07 AM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Cyril,

> > [ Cc Richie, Li, Jan ]

> > > Hi!
> > > > > > > I this case I guess that in this case the change is so minimal that we
> > > > > > > can add this test into LTP once it reaches Linus tree.
> > > > > > Cyril, maybe we could finally merge our policy (waiting ack for you):
> > > > > > https://patchwork.ozlabs.org/project/ltp/patch/20220203101803.10204-1-rpalethorpe@suse.com/
> > > > > > and put keyctl09 into runtest/staging now.

> > > > > I guess that we still did not agree on exactly how this should be
> > > > > handled or did we?

> > > > Isn't it enough "Once a feature is part of the stable kernel ABI the associated
> > > > test must be moved out of staging." ?

> > > The main problem is that someone has to make sure that it happens and
> > > the process would be prone to errors. What I proposed instead was a flag
> > > that would set a kernel version in which the ABI is going to be merged
> > > and put the test right into the final runtest files. Then we can simply
> > > skip the test on older kernels or do anything else we see as a
> > > reasonable solution. At the same time we can easily add automatic
> > > checker that would look for these flags in metadata into the CI which
> > > would, for instance, send email to the ML once the flag is supposed to
> > > be removed.
> > OK, you're missing that kernel version. OTOH things get sometimes backported,
> > thus it's not error prone (if we forget to leave that flag after kernel being
> > released).

> > Also version is hard to say if you use maintainer tree (which applies patches on
> > previous rc1 than what is being in Linus tree). Thus maintainer's tree would be
> > left, also IMHO next tree has no specific version in uname, thus we'd only
> > support rc from Linus' tree.

> > But anyway, if all agree that this is better than both solutions Richie
> > implemented I'd try to find time to implement it so that we have finally a
> > solution.

> > > In this case it does not actually matter, since the test is guarded by a
> > > kernel config option that is introduced by the patchset and the change
> > > is fairly miniminal, so I do not think that there would be any changes
> > > to the ABI anyways.
> > Correct. At this stage IMHO we can dare to merge it.

> > Kind regards,
> > Petr

> Hi Petr and Cyril,

> I wanted to check whether there is pending action left on my end?
@Yael nothing needed from you.

@Cyril cd3bc044af48 ("KEYS: encrypted: Instantiate key with user-provided
decrypted data") is in Mimi Zohar's git tree and in next tree, going to be
merged in next merge window. Can we merge it now as is?

Kind regards,
Petr


> Thanks,
> Yael

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
