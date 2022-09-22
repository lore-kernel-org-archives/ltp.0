Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DE4C54EE9
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 20:23:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 172813CAD6A
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 22:23:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F95D3CAD4A
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 22:22:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 788C0100117E
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 22:22:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8AA0A219E0;
 Thu, 22 Sep 2022 20:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663878173;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nGUF566vzGAokPxDFkFWGqgPBOuXXakZgLZc1QFvzbc=;
 b=OHVx0O2uouSSRioDISSw7XvvtZ/yQBJOwUtDRCppf6AvPuNccCb0orLBowpclbJDxqQ9ke
 8FofnP9ORZ5ws2ofqU8gaqDDu+LezT7dMpCpYlpHClDHd/usQgzj40yFbRJhLmbV1WNDCt
 PuO6OWfxTxGcmVaGIa2WlkvI8X/yHPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663878173;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nGUF566vzGAokPxDFkFWGqgPBOuXXakZgLZc1QFvzbc=;
 b=helBuIDhUHgdOsqxfrcrZXCGurvvmlw1/QloX9CxAAF6WxVg7pxZBnxpgrs0WoQg/psDI+
 NcPnmLqztO6xhzBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB72713AA5;
 Thu, 22 Sep 2022 20:22:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id y+QYJhzELGP0GQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 22 Sep 2022 20:22:52 +0000
Date: Thu, 22 Sep 2022 22:22:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YyzEGqlTfH6hJBU7@pevik>
References: <20220921155006.13360-1-mdoucha@suse.cz>
 <CAEemH2eoxjDha9Ldu9shqO6MUUFfvT3dkFExAHGyH-38E5drVg@mail.gmail.com>
 <YywknXj4nL48PaR6@pevik>
 <CAEemH2fy8zK1ABe5PrqFM=0J6s6oyPPva8pN9MF=2OrXEPcT2A@mail.gmail.com>
 <Yyw7osX47bnvNFr2@pevik> <Yyw/CYzZ2XjbQdxu@rei>
 <5541d648-f9ba-16c1-6767-4d8838863a25@suse.cz>
 <YyxE7yEZH+E9UXoE@pevik> <Yyx0TWLM9vOROtUw@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yyx0TWLM9vOROtUw@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_supported_fs: Implement checking paths
 against skiplist
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > Should I understand this that you don't trust /proc/self/mountinfo output?
> > (show_mountinfo() in fs/proc_namespace.c in kernel git)?

> Not much as I wouldn't trust it, it's just that the ext2/ext3/ext4 names
> are just short names for a subset of additional functionality.

> Consider this:

> $ dd if=/dev/zero of=fsimage.img bs=1024 count=32768
> $ mkfs.ext3 fsimage.img
> $ tune2fs -O ^has_journal fsimage.img
> $ mount -o loop fsimage.img /mntpoint
> $ cat /proc/self/mountinfo
> 43 19 7:0 / /mntpoint rw,relatime - ext3 /dev/loop0 rw

> Now we have mounted ext3 without journaling, is that really ext3?

> $ umount /mntpoint
> $ mount -t ext2 -o loop fsimage.img /mntpoint
> $ cat /proc/self/mountinfo
> 43 19 7:0 / /mntpoint rw,relatime - ext2 /dev/loop0 rw

> Now we mounted the same filesystem as ext2.

> And in both cases this is handled by the ext4 kernel driver anyways:

> $ dmesg
> ...
> EXT4-fs (loop0): mounting ext3 file system using the ext4 subsystem
> ...
> EXT4-fs (loop0): mounting ext2 file system using the ext4 subsystem
> ...

Thanks a lot for a nice example to document the problem.

> So I would argue that these are not three different filesystems, but
> just one that can turn on and off various features. And if you look at
> 'man ext4' you will see that the set of supported features for any extX
> variant does change with kernel version.

Makes sense.

> The question is if we really need to be able to distinguish them or if
> we can keep calling them by a common name.

As I noted before, using Martin's patch require to use ext2/ext3/ext4 for
.skip_filesystems and $TST_SKIP_FILESYSTEMS. I'm OK with it, although it's
a bit misleading.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
