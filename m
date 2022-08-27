Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FACFECAAD1
	for <ltp@archiver.kernel.org>; Sat, 27 Aug 2022 17:42:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56D333CA4F1
	for <ltp@archiver.kernel.org>; Sat, 27 Aug 2022 19:42:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF4113C3090
 for <ltp@lists.linux.it>; Sat, 27 Aug 2022 19:42:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1EB63600802
 for <ltp@lists.linux.it>; Sat, 27 Aug 2022 19:42:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4FF7E33E7A;
 Sat, 27 Aug 2022 17:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661622157;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qMQvjofueNPk92dvqOYQf9hRbop8fqTPWv82Wpe454o=;
 b=ZhUYk1bycomeRhX3y7XpxfMQMB0MO5XeVFtmZmiKu6iwy59WmRiTXz+5bVkWNP/g6286yF
 IdzwkopIuPf9v5rqI85J4rv0hYUaNMoa6GtM7gqmT+j+0aX7gRg4lSpUhu4t3gG467foPt
 HOk1xeyo6tJnkrJYcpBJnnUdsRZuT3M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661622157;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qMQvjofueNPk92dvqOYQf9hRbop8fqTPWv82Wpe454o=;
 b=Ein5Oilf8uNwiW08FQoFrrksLzT3IDT8rAiKQj1h2TEXsUeTH6KfSXC0oB8MpAZoRjDWkZ
 kynZRIBJTjxWIkAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0F6E1341F;
 Sat, 27 Aug 2022 17:42:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id W90rOYxXCmPvFwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sat, 27 Aug 2022 17:42:36 +0000
Date: Sat, 27 Aug 2022 19:42:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YwpXi/lLcl0Tm3f4@pevik>
References: <20220825140306.7150-1-jack@suse.cz> <YwjGrvqYEv4cn+/A@pevik>
 <20220826141933.fiy7mohz4ca6s5se@quack3>
 <CAOQ4uxgH+Q+R=YdnjkBAytB3GLwCEZzg3MYuqpwTyAuShBnw2g@mail.gmail.com>
 <YwlEfZ7FuU2jIPKC@pevik>
 <CAOQ4uxjMo-sm060G-80ic-+p1UvwUpzFJsO3ecOKVRKyoQ_wxg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjMo-sm060G-80ic-+p1UvwUpzFJsO3ecOKVRKyoQ_wxg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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

> On Sat, Aug 27, 2022 at 1:09 AM Petr Vorel <pvorel@suse.cz> wrote:

> > > On Fri, Aug 26, 2022 at 5:19 PM Jan Kara <jack@suse.cz> wrote:

> > > > On Fri 26-08-22 15:12:14, Petr Vorel wrote:
> > > > > Hi Jan, all,

> > > > > > In some setups evictable marks tests are failing because the inode with
> > > > > > evictable mark does not get evicted. Make sure we sync the filesystem
> > > > > > before we try to drop caches to increase likelyhood the inode will get
> > > > > > evicted.

> > > > > Merged with minor changes to keep checkpatch.pl happy.

> > > > Thanks!

> > > > > Given on previous discussion the behavior on ext2 vs. xfs:
> > > > > would it make sense to transform the test to use .all_filesystems = 1 ?

> > > On the contrary.
> > > We want the inode reclaim to be as predictable as possible.
> > > That is why I suggested to force the test to use ext2
> > > because xfs has some specialized inode reclaim

> > Ah right! Could you please send a patch with .dev_fs_type = "ext2"
> > That should be enough I guess.


> Petr, I don't think there is a need for that.
> I was only pointing out the different fs can have different inode
> reclaim behaviors.
> I had not encountered issues when testing fanotify10 on xfs myself.

> Jan's patch should be enough and then the test can run
> on the user's choice of filesystem, which is always better than
> unneeded restrictions.

> If we see issues on xfs we can reconsider .dev_fs_type = "ext2".

Amir, thanks for explanation. Makes sense.

Kind regards,
Petr

> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
