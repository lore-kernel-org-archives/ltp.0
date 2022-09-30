Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24663C4332F
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 14:01:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A60773CA6C2
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 16:01:03 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9CE73C092F
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 16:00:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 030D31001195
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 16:00:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 17AF41F88E;
 Fri, 30 Sep 2022 14:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664546452;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4D2F04GNAoiVtSpxvO89DdvTXlk2mdXLjGY3TUhR2QU=;
 b=kWUjVhvaa/nQUrxTN0nPnhWyhDeDnklySCzdymQ44ihWUsAkyaXG6DxkuxIUCB8X+QLJ7O
 LodsxiVlNmC4abNrPEq8XWeuS5MVeVyx8CVWQpbSy/9Mqfj+5ueHA8dVIdgLzI3dnePvs3
 lktLNLtQSdQ007+nos++iPVZaWSidgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664546452;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4D2F04GNAoiVtSpxvO89DdvTXlk2mdXLjGY3TUhR2QU=;
 b=Z5M+lCSoyAbd5UevKgqdMlaUFP/1PkRsRsoQ/HtRIAHEbLwF9VZNTOS0Pk3AHQzDOPaKmW
 Ssy59GUlxqTzV0Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 31B8213677;
 Fri, 30 Sep 2022 14:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Lr7NB5P2NmOxTgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 30 Sep 2022 14:00:51 +0000
Date: Fri, 30 Sep 2022 16:00:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Yzb2kPIErlgJVUe6@pevik>
References: <Yxr+EpKTnKQbKXTb@yuki>
 <CAEemH2eSJQ-_30_Y3A567oqBFSOo=1tt7LJMtPq_BodjVNsm8w@mail.gmail.com>
 <YxsfGUpRLAx6uIU7@yuki> <YxtPfXA6I64lS2oK@pevik>
 <CAEemH2eNjP++fxhP5ZSsX+fq5vAd6h0_qNX6Rx82AdpzN9fyGQ@mail.gmail.com>
 <YzF3wLk9cMTdU1z7@yuki>
 <CAEemH2feEgX1oiTPD=_ub0Dc-5RTyKqVhSX0QrMAJPTo-0Gdhg@mail.gmail.com>
 <CAEemH2e6Dzm1ydZt1VZvoxZN4xXyrSZua5jmfxeci8SyXNc2tw@mail.gmail.com>
 <YzKv/ClILufSy3up@pevik>
 <CAEemH2eb3EvUL7c3M1=FgPoYmYTcYDgQAM7NUxY7pSAN0xUjuw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eb3EvUL7c3M1=FgPoYmYTcYDgQAM7NUxY7pSAN0xUjuw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] September LTP release
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
Cc: LTP List <ltp@lists.linux.it>, Richard Palethorpe <rpalethorpe@suse.com>,
 Martin Doucha <martin.doucha@suse.com>,
 automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> Petr Vorel <pvorel@suse.cz> wrote:

> >    185 df01 42 TFAIL: 'df -T -P' failed, not expected.

> > This is known:
> > https://lore.kernel.org/linux-xfs/YvZTpQFinpkB06p9@pevik/

> > I've mention that yesterday, that I'll fix it after the release
> > https://lore.kernel.org/ltp/YzGDdC76DLmrJyys@pevik/
> > I'll try to send a patch soon and we can decide whether we merge it before
> > release or not.

FYI It looks like this has been fixed, it works on machine with Tumbleweed,
kernel 6.0.0-rc7-1.g74aafe0-default, mkfs.xfs version 5.19.0. It also works on
Tumbleweed with stable kernel 5.19.10-1-default. I started to bisect, but
haven't found first broken commit (too lazy to get deeper into this).

Kind regards,
Petr


> Ah, yes, I shouldn't skip reading emails so careless :).
> Thanks for the upcoming fix, let's see what it looks like and then decide
> to merge or not.

> And zram01.sh fails due XFS minimal size. I also try to send a patch soon.


> Thanks! Next, I will only investigate the io_uring failures.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
