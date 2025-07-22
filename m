Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 983D3C83F27
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 10:24:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C5A53CCCA3
	for <ltp@archiver.kernel.org>; Tue, 22 Jul 2025 12:24:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D46743C2128
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 12:23:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A2128600666
 for <ltp@lists.linux.it>; Tue, 22 Jul 2025 12:23:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5ED9621B1A;
 Tue, 22 Jul 2025 10:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753179828;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sWPuG2QuyO5WUbpb4qWDKwMgpiE6nAl4FNtaxjOC8Z0=;
 b=fIkH7yQjhZ3Dt0aKUuICB7Tz6kHf5crtu90SRfre2JXhT3Ki4kTIdfyEPCa4Qa6gJVVJkD
 0CMs8rIGKxsx0SV7AmoXEocbEV/THyh2uY1wBXZXOPoofDk95uM1Nsq4PioYghNkxZuui4
 CDMSICMwLLQ6eAWdol5tgzzo6VjNpHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753179828;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sWPuG2QuyO5WUbpb4qWDKwMgpiE6nAl4FNtaxjOC8Z0=;
 b=X04iDC++zkHsl5sEtbUr8Y1uhc56GTrLq+bltVhuTYJOgRHws8gXo6ueWGifgOi/0dW/Vp
 1RdQQKW1K41dhwDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753179828;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sWPuG2QuyO5WUbpb4qWDKwMgpiE6nAl4FNtaxjOC8Z0=;
 b=fIkH7yQjhZ3Dt0aKUuICB7Tz6kHf5crtu90SRfre2JXhT3Ki4kTIdfyEPCa4Qa6gJVVJkD
 0CMs8rIGKxsx0SV7AmoXEocbEV/THyh2uY1wBXZXOPoofDk95uM1Nsq4PioYghNkxZuui4
 CDMSICMwLLQ6eAWdol5tgzzo6VjNpHA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753179828;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sWPuG2QuyO5WUbpb4qWDKwMgpiE6nAl4FNtaxjOC8Z0=;
 b=X04iDC++zkHsl5sEtbUr8Y1uhc56GTrLq+bltVhuTYJOgRHws8gXo6ueWGifgOi/0dW/Vp
 1RdQQKW1K41dhwDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3871D132EA;
 Tue, 22 Jul 2025 10:23:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 76i8DLRmf2iQMQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Jul 2025 10:23:48 +0000
Date: Tue, 22 Jul 2025 12:23:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: linux-ext4@vger.kernel.org
Message-ID: <20250722102346.GA6890@pevik>
References: <20250326142259.50981-1-pvorel@suse.cz> <aHEccDO8lJiTzbEs@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aHEccDO8lJiTzbEs@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_HAS_DN(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, Theodore Ts'o <tytso@mit.edu>,
 ltp@lists.linux.it, Jan Kara <jack@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi ext devs,

...
> >  static void setup(void)

> I find it strange that we manage to set the FS_IMMUTABLE_FL in the setup
> with the FS_IOC_SETFLAGS without any error. Maybe it would make sense to
> check with ext devs what is going on here.

> > @@ -117,6 +123,10 @@ static struct tst_test test = {
> >  			.mkfs_ver = "mkfs.xfs >= 1.5.0",
> >  			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
> >  		},
> > +		{.type = "ext2"},
> > +		{.type = "ext3"},
> > +		{.type = "ext4"},
> > +		{.type = "tmpfs"},
> >  		{}

While I was working on extending [1] LTP ioctl_ficlone03.c to run on more
filesystems [2], I found that ext[2-4] don't support FS_IMMUTABLE_FL.

	immut_fd = open(MNTPOINT"/immutable", O_CREAT | O_RDWR, 0640);
	mnt_file = open(MNTPOINT"/file", O_CREAT | O_RDWR, 0640);
	int attr = FS_IMMUTABLE_FL;
	ioctl(immut_fd, FS_IOC_SETFLAGS, &attr);
	...

	struct file_clone_range *clone_range;
	ioctl(immut_fd, FICLONE, mnt_file),
	ioctl(immut_fd, FICLONERANGE, clone_range),

The last two ioctl() with FICLONE and FICLONERANGE get errno EOPNOTSUPP (instead
of EPERM as on other fs). Cyril raised concern [3], why first ioctl()
FS_IOC_SETFLAGS even works. Shouldn't it also gets EINVAL as vfat, exfat and
ntfs get?

There is not any info in dmesg.

Thanks for any hint.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20250326142259.50981-1-pvorel@suse.cz/
[2] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
[3] https://lore.kernel.org/ltp/aHEccDO8lJiTzbEs@yuki.lan/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
