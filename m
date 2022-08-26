Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A38AC0502A
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 22:09:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E3BD3CA378
	for <ltp@archiver.kernel.org>; Sat, 27 Aug 2022 00:09:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B44D83CA2E6
 for <ltp@lists.linux.it>; Sat, 27 Aug 2022 00:09:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E0088100037E
 for <ltp@lists.linux.it>; Sat, 27 Aug 2022 00:09:04 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 40DCC1F900;
 Fri, 26 Aug 2022 22:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661551743;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kEIHuVe5htPig9Nu4OXIo3m7tnpV/vAo8UuUZKrtqUI=;
 b=JisLRtD2kUTRlhtIyrUuAZILXI8LOvgdL3EkYU/qqID0fycl535ujoy7oqPhXIYXY811P+
 iSJBma36qvB9tt/spwrlw9pD3kZTffs0MaTI0eogBucIb8aBdEYfEX7sZeJb7XAFdinxvJ
 MYonpb7jGo3igK0KN1ibDcp0o+TxyTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661551743;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kEIHuVe5htPig9Nu4OXIo3m7tnpV/vAo8UuUZKrtqUI=;
 b=eAnacFSuLqlp3LJHBn7HXJZMWeO2De6+8VBqa1PxaCEz9nZUzdftMzgqoxKFMi88W2EQlJ
 fg6O1txijnRLAtCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0D9C13A7E;
 Fri, 26 Aug 2022 22:09:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5FfCOH5ECWPRXwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 26 Aug 2022 22:09:02 +0000
Date: Sat, 27 Aug 2022 00:09:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YwlEfZ7FuU2jIPKC@pevik>
References: <20220825140306.7150-1-jack@suse.cz> <YwjGrvqYEv4cn+/A@pevik>
 <20220826141933.fiy7mohz4ca6s5se@quack3>
 <CAOQ4uxgH+Q+R=YdnjkBAytB3GLwCEZzg3MYuqpwTyAuShBnw2g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgH+Q+R=YdnjkBAytB3GLwCEZzg3MYuqpwTyAuShBnw2g@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fanotify10: Make evictable marks test
 more reliable
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
Cc: Matthew Bobrowski <repnop@google.com>,
 Dominique Leuenberger <dimstar@opensuse.org>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Fri, Aug 26, 2022 at 5:19 PM Jan Kara <jack@suse.cz> wrote:

> > On Fri 26-08-22 15:12:14, Petr Vorel wrote:
> > > Hi Jan, all,

> > > > In some setups evictable marks tests are failing because the inode with
> > > > evictable mark does not get evicted. Make sure we sync the filesystem
> > > > before we try to drop caches to increase likelyhood the inode will get
> > > > evicted.

> > > Merged with minor changes to keep checkpatch.pl happy.

> > Thanks!

> > > Given on previous discussion the behavior on ext2 vs. xfs:
> > > would it make sense to transform the test to use .all_filesystems = 1 ?

> On the contrary.
> We want the inode reclaim to be as predictable as possible.
> That is why I suggested to force the test to use ext2
> because xfs has some specialized inode reclaim

Ah right! Could you please send a patch with .dev_fs_type = "ext2"
That should be enough I guess.


> > Well, I don't think it would improve test coverage in any interesting way.
> > This test tests stuff in fsnotify layer & VFS. The differences in
> > filesystem inode reclaim are not target of this test - we are just trying
> > to check that fsnotify does not block inode reclaim by holding inode
> > references and for that any filesystem works. Or did you mean something
> > else?


> Agree. I see no reason to change that.

Thank you both for info!

Kind regards,
Petr

> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
