Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B63D3DEA2
	for <ltp@archiver.kernel.org>; Fri, 18 Oct 2024 17:18:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 836993C6AD0
	for <ltp@archiver.kernel.org>; Fri, 18 Oct 2024 19:18:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F6143C1A39
 for <ltp@lists.linux.it>; Fri, 18 Oct 2024 19:18:06 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B06AB2A7C0C
 for <ltp@lists.linux.it>; Fri, 18 Oct 2024 19:18:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AB8851FF15;
 Fri, 18 Oct 2024 17:18:04 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78DB913433;
 Fri, 18 Oct 2024 17:18:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JoMOHEyYEmdeZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 18 Oct 2024 17:18:04 +0000
Date: Fri, 18 Oct 2024 19:18:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Message-ID: <20241018171802.GA333901@pevik>
References: <20241018071353.2732203-1-wozizhi@huawei.com>
 <20241018115224.jsz3rrnqpx5mwhze@quack3>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241018115224.jsz3rrnqpx5mwhze@quack3>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: AB8851FF15
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify10: Calling drop_cache three times to
 ensure the inode is evicted
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

Hi Jan, Zizhi Wo,

...
> > NUMA0: parent inode	exist		exist		free
> > NUMA1: parent dentry	exist		free		free
> > NUMA2: child inode	exist		free		free
> > NUMA3: child dentry	free		free		free

> Well, this is right but there's also the while ((freed >> shift++) > 1)
> loop in drop_slab() which should generally make us loop as long as there's
> something to reclaim. But yes, if in theory the only thing we can reclaim
> is the child dentry in the first round, then what you suggest may happen.

> > Due to the release of the dependency chain, the drop_cache cleanup also
> > takes several times. Therefore, to be safe, three drop_cache operations are
> > needed to handle the two-level directory structure.

> OK, I'm willing to give this one last try. If it doesn't work out, I'd just
> drop these tests until we can find a more reliable way of testing this.

> Feel free to add:

> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks you both for yet another fix and review, both is very much appreciated.
Hopefully this will finally work.

Kind regards,
Petr

> 								Honza
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
