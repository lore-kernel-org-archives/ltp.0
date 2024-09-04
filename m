Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FACECD3431
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 09:07:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9920B3C1B71
	for <ltp@archiver.kernel.org>; Wed,  4 Sep 2024 11:07:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2C793C0CCD
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 11:07:27 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=jack@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 28EF920D1AE
 for <ltp@lists.linux.it>; Wed,  4 Sep 2024 11:07:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 81B722122C;
 Wed,  4 Sep 2024 09:07:25 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7890D139E2;
 Wed,  4 Sep 2024 09:07:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id V+xdHU0j2GYWDwAAD6G6ig
 (envelope-from <jack@suse.cz>); Wed, 04 Sep 2024 09:07:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 104C5A0962; Wed,  4 Sep 2024 11:07:21 +0200 (CEST)
Date: Wed, 4 Sep 2024 11:07:21 +0200
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20240904090721.lpsk3tajtriffp3j@quack3>
References: <20240830130003.3245531-1-wozizhi@huawei.com>
 <20240903140807.GA762653@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240903140807.GA762653@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 81B722122C
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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
Cc: yangerkun@huawei.com, jack@suse.cz, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue 03-09-24 16:08:07, Petr Vorel wrote:
> Hi all,
> 
> > In this test case, some scenarios are designed to verify whether the
> > FANOTIFY_EVICTABLE flag takes effect: by verifying that information cannot
> > be obtained from the corresponding inode after drop_cache, as this flag
> > does not ping the inode.
> 
> > However, drop_cache is only performed once here, which may result in the
> > inode not being released in NUMA scenarios. Suppose the inode is located
> > on NUMA0 and the dentry is located on NUMA1; the first drop_cache can only
> > ensure that the inode is added to the LRU list, but does not guarantee that
> > evict() can been called because dispose_list does not yet include this
> > inode when traversing NUMA0, which causes the testcase execution fail.
> 
> I wonder if there can be some detection that inode is evicted.
> Or, can it happen that even 2x drop is not enough?
> 
> > For the single-file scenario in this testcase, executing drop_cache twice
> > is necessary to ensure the inode is evicted, thus allowing the testcase to
> > pass.
> 
> Acked-by: Petr Vorel <pvorel@suse.cz>
> 
> @Amir, Jan, could you please have a look?

Yeah, as Amir wrote, I've ended up doing similar thing for fanotify23 so:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> > Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> > ---
> >  testcases/kernel/syscalls/fanotify/fanotify10.c | 2 ++
> >  1 file changed, 2 insertions(+)
> 
> > diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > index c6d8ec922..42018de0d 100644
> > --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> > +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> > @@ -515,6 +515,8 @@ static void drop_caches(void)
> >  	if (syncfs(fd_syncfs) < 0)
> >  		tst_brk(TBROK | TERRNO, "Unexpected error when syncing filesystem");
> 
> > +	/* Need to drop twice to ensure the inode is evicted. */
> > +	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
> >  	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
> >  }
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
