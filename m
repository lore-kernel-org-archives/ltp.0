Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC203C3DA61
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 16:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1721838688; h=message-id :
 to : date : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=gwISe/WWDfI726pilOESg+4KOZ0i1VMZhrWUK5FONLs=;
 b=hauxs2y1pKEsJluXZBGisw1QgStNJu3iQo449/E/zm5iS4R0tOf1vJF6CTKQKlfyqZ0dS
 gIiq19URMfOgNlATZdyjePS74rBuEE6RJB5LMyo2MHwID3x8eyunTytnAkOxsIXmSrBawDd
 RiBywtG1wvzNifr/G2IYQGJUiYS69HU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 704503D1C3E
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 18:31:28 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CECA3D0FA8
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 18:29:21 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=gmx.de
 (client-ip=212.227.17.21; helo=mout.gmx.net; envelope-from=efault@gmx.de;
 receiver=lists.linux.it)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F35C51A00E08
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 18:29:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1721838555; x=1722443355; i=efault@gmx.de;
 bh=BYZjEGc4YVudcgENM058UCy6tfpRPmI4j7O72IWha4A=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=GNvjCnR+JCF6N019EuyhqS7GZJiqw7uI/WKHdu7OeitiiAlnPSpS84ai86Qkg5cI
 9kV0VjlBd/dKiF0SIHXv2TXbgWCNC8T6TlnO+k5twJ1JGQfxG0AkHkT7dN6uuvGb8
 GZehGSPho95lNhXipBnF/28lg51a6lhhLMDaFb+JdioDXY/zdzy/uyMwADJNah1J5
 eRGRHIz6vUyGuznJZdNTdv1ikJhhK9I43E8gcTePdlKLjTQ4ENBwoC3igl8xlEFTY
 kwbKG3XHmhzLfredYsnRWHC53UcCXZe53DGThUv0RsRUxBZ9M6SiGI5lUp7pfexqq
 gyAxanys1DiMtE8mkA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.221.149.162]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2mFY-1s9j6N2Sy4-00v2W4; Wed, 24
 Jul 2024 18:29:15 +0200
Message-ID: <684a1811297c210c6efd46c4e3c7b35e26b03b19.camel@gmx.de>
To: Petr Vorel <pvorel@suse.cz>, Jan Kara <jack@suse.cz>
Date: Wed, 24 Jul 2024 18:29:12 +0200
In-Reply-To: <20240724131816.GA950793@pevik>
References: <20240719174325.GA775414@pevik>
 <20240722090012.mlvkaenuxar2x3vr@quack3> <20240724131816.GA950793@pevik>
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
X-Provags-ID: V03:K1:UWBOdxjNJyiHG2TMf8ox0PHfBtgY/mgi9HVdGVCVaJ6bAC2k80K
 pJX+y2qWZIMkIrApXkmlHL43njiMk1SVnqwxHjR1mD6s2CHI4CYeAWedhJsoj9N/TsKqKIA
 /o+NP34ZIctcH8qSVkRTCL8jD3myGESZWtJYStR9jfaZYoSh2uWVLUpNF6QOc34v1hPkaAP
 rlhhj3zSmQb/XRHBskIhg==
UI-OutboundReport: notjunk:1;M01:P0:w/bY2nrEeWs=;AiIwYn2wc/FW9jI/FqFfCpdARMX
 iqoRMTZi0UIEylmBl1YaRGGgPFmdn2SCXblzuV7oMvTzAKZ/kvcjPNGMONGQgv1hxfJyr+4Mo
 muDAcszKsTb2gi4E+fRsRExATUhgvw/dglYk6yTrzntZX5WzkEzS3yY8wRCvH4yBYz+dPv6td
 rqlqAeLj/iXUk3U1S46ur/yeDNAEdw2YcBNksl4FjjMKS4FuwtGYSageoV/aJcirrknlRGsLr
 f4kDKLCwhj4K5A/tz7DeKjYvbksXCHqASW0aSBAibZO/2df9CpEelRRlwXjRetMZ+xIXKJPDU
 ThqJr5UDC2NGZYnf47zhPuyvyDOaJBYzkfaracARc+LfVFolWob5aM5YF2T5Xcg1t+8sQh79A
 j5Kf6QEZFnr8j5ZAJxaDNRn9AXMCXfFMhWLSg0JLyBFlunHzlKrmuYf6069W5ZQJm4LGbYwL2
 k5FfrlwZe3LTU2/TsWfy90muX416/VIYHp8JAkD9m2h3jLuKlG6Qd8FQSarRV5ndC+GPfyVqo
 C1SOb9yIp+tvDxjHgPEIujGd3PBZE1yolF+zJbsVL5HI1SGBEP7bbWKzObzS41eX5M1+LYXD6
 dJe0w9S/Ps0A8sFdOGFqsb18yj63DsN/1AAfYmMKREdM0Ozl6S31Bowklcij9EaymWOJX8U/l
 3djLfIQTZFO1SJTxR3Ub/DggNZXf9nNKJBjiftM2fNQg5u3q4HH/viKd52zYtH7Kxerh5R/vG
 6DPIN2PfAsJsRtibe8zhiAhuvSdKgmZ0z52ZvVG52qf9icwwHgiu695mdhQu+KUQhxAqvxwF5
 +ZgeF1LO/BWulqYdRMbx+ErA==
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 24 Jul 2024 18:31:07 +0200
Subject: Re: [LTP] [RFC] Slow down of LTP tests aiodio_sparse.c and
 dio_sparse.c in kernel 6.6
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
From: Mike Galbraith via ltp <ltp@lists.linux.it>
Reply-To: Mike Galbraith <efault@gmx.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-xfs@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, fstests@vger.kernel.org,
 linux-block@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
 ltp@lists.linux.it, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 2024-07-24 at 15:18 +0200, Petr Vorel wrote:
> Hi all,
>
>
> [ Cc Peter and Mike ]
> > Hi!
>
> > On Fri 19-07-24 19:43:25, Petr Vorel wrote:
> > > LTP AIO DIO tests aiodio_sparse.c [1] and dio_sparse.c [2] (using [3])
> > > slowed down on kernel 6.6 on Btrfs and XFS, when run with default
> > > parameters. These tests create 100 MB sparse file and write zeros (using
> > > libaio or O_DIRECT) while 16 other processes reads the buffer and check
> > > only zero is there.
>
> > So the performance of this test is irrelevant because combining buffered
> > reads with direct IO writes was always in "better don't do it" territory.
> > Definitely not if you care about perfomance.
>
> > > Runtime of this particular setup (i.e. 100 MB file) on Btrfs and XFS on the
> > > same system slowed down 9x (6.5: ~1 min 6.6: ~9 min). Ext4 is not affected.
> > > (Non default parameter creates much smaller file, thus the change is not that
> > > obvious).
>
> > But still it's kind of curious what caused the 9x slow down. So I'd be
> > curious to know the result of the bisection :). Thanks for report!
>
> It looks to be the slowdown was introduced by commit 63304558ba5d
> ("sched/eevdf: Curb wakeup-preemption") [1] from v6.6-rc1.

That's not good, I'd rather not have over-zealous preemption back, my
box doesn't miss that one tiny bit.

Hrm... have you tried Peter's eevdf queue?  The DELAY_DEQUEUE feature
therein does good things for tbench, restoring pre-eevdf throughput.

	-Mike


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
