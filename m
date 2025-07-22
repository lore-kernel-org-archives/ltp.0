Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E702BC83F1A
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 11:41:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C0533CCCCA
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 13:41:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C9533C6CFE
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 13:41:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BD93A600C8C
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 13:41:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A657321A64;
 Tue, 22 Jul 2025 11:41:35 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AB6B13A32;
 Tue, 22 Jul 2025 11:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nau/Je94f2jDSgAAD6G6ig
 (envelope-from <jack@suse.cz>); Tue, 22 Jul 2025 11:41:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 0EDFAA0A69; Tue, 22 Jul 2025 13:41:35 +0200 (CEST)
Date: Tue, 22 Jul 2025 13:41:35 +0200
From: Jan Kara <jack@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <azo7y22pblcngf6y5xkzda5cew4p3kxylfse7i32hixjtld2mh@ml2bonivmpbe>
References: <20250326142259.50981-1-pvorel@suse.cz> <aHEccDO8lJiTzbEs@yuki.lan>
 <20250722102346.GA6890@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250722102346.GA6890@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A657321A64
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ioctl_ficlone03.c: Support test on more
 filesystems
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
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Tue 22-07-25 12:23:46, Petr Vorel wrote:
> ...
> > >  static void setup(void)
> 
> > I find it strange that we manage to set the FS_IMMUTABLE_FL in the setup
> > with the FS_IOC_SETFLAGS without any error. Maybe it would make sense to
> > check with ext devs what is going on here.
> 
> > > @@ -117,6 +123,10 @@ static struct tst_test test = {
> > >  			.mkfs_ver = "mkfs.xfs >= 1.5.0",
> > >  			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
> > >  		},
> > > +		{.type = "ext2"},
> > > +		{.type = "ext3"},
> > > +		{.type = "ext4"},
> > > +		{.type = "tmpfs"},
> > >  		{}
> 
> While I was working on extending [1] LTP ioctl_ficlone03.c to run on more
> filesystems [2], I found that ext[2-4] don't support FS_IMMUTABLE_FL.

Why do you think FS_IMMUTABLE_FL is unsupported? ext2 was the filesystem
actually introducing it to the kernel ;)

> 	immut_fd = open(MNTPOINT"/immutable", O_CREAT | O_RDWR, 0640);
> 	mnt_file = open(MNTPOINT"/file", O_CREAT | O_RDWR, 0640);
> 	int attr = FS_IMMUTABLE_FL;
> 	ioctl(immut_fd, FS_IOC_SETFLAGS, &attr);
> 	...
> 
> 	struct file_clone_range *clone_range;
> 	ioctl(immut_fd, FICLONE, mnt_file),
> 	ioctl(immut_fd, FICLONERANGE, clone_range),
> 
> The last two ioctl() with FICLONE and FICLONERANGE get errno EOPNOTSUPP
> (instead of EPERM as on other fs). Cyril raised concern [3], why first
> ioctl() FS_IOC_SETFLAGS even works. Shouldn't it also gets EINVAL as
> vfat, exfat and ntfs get?

Unlink FICLONE and FICLONERANGE which are indeed unsupported on any ext?
based filesystem so EOPNOTSUPP seems like a correct answer to me.
So I'm confused where you see a problem.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
