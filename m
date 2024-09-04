Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9209CD4847
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 09:47:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31D4F3C1C89
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 11:47:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 748823C1B71
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 11:47:17 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7BFA410089A4
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 11:47:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8BDFB1F7B4;
 Wed,  4 Sep 2024 09:47:16 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 639B8139D2;
 Wed,  4 Sep 2024 09:47:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dGHQFqQs2Gb3GwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 04 Sep 2024 09:47:16 +0000
Date: Wed, 4 Sep 2024 11:47:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Message-ID: <20240904094714.GA849136@pevik>
References: <20240830130003.3245531-1-wozizhi@huawei.com>
 <20240903140807.GA762653@pevik>
 <20240904090721.lpsk3tajtriffp3j@quack3>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240904090721.lpsk3tajtriffp3j@quack3>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 8BDFB1F7B4
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify10: Calling drop_cache twice to ensure
 the inode is evicted
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
Cc: yangerkun@huawei.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> On Tue 03-09-24 16:08:07, Petr Vorel wrote:
> > Hi all,

> > > In this test case, some scenarios are designed to verify whether the
> > > FANOTIFY_EVICTABLE flag takes effect: by verifying that information cannot
> > > be obtained from the corresponding inode after drop_cache, as this flag
> > > does not ping the inode.

> > > However, drop_cache is only performed once here, which may result in the
> > > inode not being released in NUMA scenarios. Suppose the inode is located
> > > on NUMA0 and the dentry is located on NUMA1; the first drop_cache can only
> > > ensure that the inode is added to the LRU list, but does not guarantee that
> > > evict() can been called because dispose_list does not yet include this
> > > inode when traversing NUMA0, which causes the testcase execution fail.

> > I wonder if there can be some detection that inode is evicted.
> > Or, can it happen that even 2x drop is not enough?

> > > For the single-file scenario in this testcase, executing drop_cache twice
> > > is necessary to ensure the inode is evicted, thus allowing the testcase to
> > > pass.

> > Acked-by: Petr Vorel <pvorel@suse.cz>

> > @Amir, Jan, could you please have a look?

> Yeah, as Amir wrote, I've ended up doing similar thing for fanotify23 so:

My bad memory (8ccf5b45cc), thanks for reminder and your review.
I checked only these two fanotify tests are dropping caches.

Merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
