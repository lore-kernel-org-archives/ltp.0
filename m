Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5511D13C3E
	for <ltp@archiver.kernel.org>; Mon, 26 Jan 2026 15:46:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 056A33C6221
	for <ltp@archiver.kernel.org>; Mon, 26 Jan 2026 16:46:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4F8913C0322
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 16:45:48 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D5FF72001A2
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 16:45:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 557B533689;
 Mon, 26 Jan 2026 15:45:47 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CD73139E9;
 Mon, 26 Jan 2026 15:45:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ztifDSuMd2nObAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 26 Jan 2026 15:45:47 +0000
Date: Mon, 26 Jan 2026 16:47:02 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aXeMdm4QgIJQ43dk@yuki.lan>
References: <20260126-fix_dio_sparse_slow-v2-1-5dbe1622f5c1@suse.com>
 <aXdTEreda0-s6WID@yuki.lan> <DFYM56BKO470.2QDB95UE8IOVU@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DFYM56BKO470.2QDB95UE8IOVU@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 557B533689
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] io: fix really slow dio_sparse on certain
 systems
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> This is definetly a possible solution. I sent this patch by waiting for
> some feebacks in order to have other opinions. What puzzles me is that
> it's only happening in POWER10 on a random node during kernel tests.
> Other architectures seem to work fine.
> 
> kernel 6.6+ seems to be the affected one.
> 
> >
> > However the test should finish as fast as the writer finishes writing
> > the file. So slow readers shouldn't matter unless there is some serious
> > contention on the disk I/O. That's probably the reason you are aligning
> > the writer as well.
> 
> Exactly, I would expect that.
> 
> >
> > What is the difference in runtime between test before and after this
> > patch on the slow hardware?
> 
> DS009 from 4 hours to 30 seconds. I also profiled the list of syscalls
> with perf, obtaining a 63+ % of io_read() time consumption. Still, this
> patch moves the execution from ~10 secs to ~3 secs on my laptop. There's
> a big difference between 4h and 10 secs runtime, no matter the hard disk
> which is running below.

Honestly that does sound like a kernel bug. You shouldn't get several
orders of magnitude slower just because your buffer is 4 times smaller.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
