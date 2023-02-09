Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 294D3C61DA4
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 14:51:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F3AC93CC0A1
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 15:51:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41BE53CB0EA
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 15:51:09 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6C55410000D3
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 15:51:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C54095C953;
 Thu,  9 Feb 2023 14:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675954267; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vl0gy+u/gx4yjuoQOVEyQLzW6MkVzb5h1xtZ6q5COws=;
 b=Q49xy+wLMXZuvEGlLAuIg/mR3YW2hUa4/nD4J1ZOXE5voIAw5AmAHsJGhBMhKa830Spqxt
 KiuFqvjdxyf9Zu+galSJop841Nl+AMAJYIUQBPEMzf6JQVWdgNMjqm81ysJmd3Cyfecgy3
 sxckS0CvUxJkFIi1RL5bk7xZYKwKhRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675954267;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vl0gy+u/gx4yjuoQOVEyQLzW6MkVzb5h1xtZ6q5COws=;
 b=FhD0YkmpmuwnM3vaXFgsWJrilVCYAnzqA7PX8cVTe8N8iv/cKHcR2xlYSXJ7fXz2DN+0QJ
 icuacy1SlXOggoDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3713138E4;
 Thu,  9 Feb 2023 14:51:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SWD9KlsI5WP/IgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 09 Feb 2023 14:51:07 +0000
Date: Thu, 9 Feb 2023 15:52:37 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y+UItbp4v2WKZedL@yuki>
References: <20230129115021.25778-1-wegao@suse.com>
 <20230209131902.12260-1-wegao@suse.com> <Y+UAENJVDUSDPAay@pevik>
 <Y+UEqNtUTNaGVwXT@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+UEqNtUTNaGVwXT@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fsconfig: New case cover CVE-2022-0185
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I guess something like this should be used:
> 
> 	for (unsigned int i = 0; i < 5000; i++) {
> 		TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
> 							EINVAL);

It doesn't fail on older kernels, or did I misinterpret something? There
are three stable kernel trees based on kernels that are supposedly
affected, we do want to run this test for them too.

> 		if (!TST_PASS)
> 			return;
> 	}
> 
> 	tst_res(TPASS, "fsconfig() overflow on %s haven't triggerred crash",
> 			tst_device->fs_type);
> 
> but that fails on Btrfs.
> 
> > > +}
> > > +
> > > +static struct tst_test test = {
> > > +	.test_all = run,
> > > +	.setup = setup,
> > > +	.cleanup = cleanup,
> > > +	.needs_root = 1,
> > > +	.format_device = 1,
> > > +	.mntpoint = MNTPOINT,
> > > +	.all_filesystems = 1,
> > > +	.min_kver = "5.17",
> > You probably add it because 722d94847de29 comes from 5.17-rc1, but that should
> > go away, because this fix has been backported to (at least) sles kernels (which
> > are older).
> 
> > > +	.tags = (const struct tst_tag[]) {
> > > +		{"linux-git", "722d94847de29"},
> > > +		{"CVE", "2020-29373"},
> > IMHO CVE-2020-29373 is about io_uring
> > https://nvd.nist.gov/vuln/detail/CVE-2020-29373
> > Does it really belong to this test? If yes, it has another kernel fix.
> > And you don't mention it in docparse description.
> 
> > > +		{"CVE", "2022-0185"},
> > > +		{}
> > > +	}
> 
> Results on my machine (6.2.0-rc6)
> 
> tst_test.c:1634: TINFO: === Testing on ext2 ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
> mke2fs 1.46.5 (30-Dec-2021)
> note ext2 is *not* using new mount API
> fsconfig03.c:50: TPASS: fsconfig() overflow on ext2 haven't triggerred crash
> tst_test.c:1634: TINFO: === Testing on ext3 ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
> mke2fs 1.46.5 (30-Dec-2021)
> fsconfig03.c:50: TPASS: fsconfig() overflow on ext3 haven't triggerred crash
> tst_test.c:1634: TINFO: === Testing on ext4 ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
> mke2fs 1.46.5 (30-Dec-2021)
> fsconfig03.c:50: TPASS: fsconfig() overflow on ext4 haven't triggerred crash
> tst_test.c:1634: TINFO: === Testing on xfs ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
> fsconfig03.c:50: TPASS: fsconfig() overflow on xfs haven't triggerred crash
> tst_test.c:1634: TINFO: === Testing on btrfs ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
> fsconfig03.c:44: TFAIL: fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0) succeeded
> Btrfs should be investigated (IMHO btrfs is using new mount API).
> 
> tst_test.c:1634: TINFO: === Testing on vfat ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> fsconfig03.c:44: TFAIL: fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0) succeeded
> 
> tst_test.c:1634: TINFO: === Testing on exfat ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with exfat opts='' extra opts=''
> fsconfig03.c:50: TPASS: fsconfig() overflow on exfat haven't triggerred crash
> Interesting, exfat works :) It also uses new mount API.
> 
> tst_test.c:1634: TINFO: === Testing on ntfs ===
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ntfs opts='' extra opts=''
> The partition start sector was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
> The number of sectors per track was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
> The number of heads was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
> To boot from a device, Windows needs the 'partition start sector', the 'sectors per track' and the 'number of heads' to be set.
> Windows will not be able to boot from this device.
> fsconfig03.c:29: TBROK: fsopen() failed: ENODEV (19)
> Hm, that's strange

ENODEV means that filesystem is not compiled in kernel, that's strage,
that would mean that you have a broken system, e.g. kernel modules that
support these filesystems are not installed properly or something like
that.

If you look at fs/filesystems.c the get_fs_type() function called from
the fsopen() uses the very same array that is used by the
/proc/filesystems we parse in LTP to get list of supported filesystems.

This is the place where you can get ENODEV:

https://elixir.bootlin.com/linux/latest/source/fs/fsopen.c#L132

And this is the place where it can fail:

https://elixir.bootlin.com/linux/latest/source/fs/filesystems.c#L261

> Due above, I suggest this:
> 	.skip_filesystems = (const char *const []){"ntfs", "vfat", NULL},


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
