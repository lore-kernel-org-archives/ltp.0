Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893CDC61DA4
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 14:35:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F12233CC0A8
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 15:35:34 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C3E63C1047
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 15:35:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 44FDC6009D4
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 15:35:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3A61F37264;
 Thu,  9 Feb 2023 14:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675953322;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B0Yi5BTnnbuv+Mk/rB7X5mpKp0SIdzqCEvJaFAiv+Ao=;
 b=EYO5NPxyvoQizcQKWhY9/e8Ik1kPO/CCD2hnq+T8GpotaSM5nskVDlMNtCXbbLviyCWy8t
 B0B1hmbZe1GpWEL5ADnfjxBIei1hnHwoOnwgy32wWdAoBUdLWzmAZ2D/6qssfDZnSwnNeM
 UE8ih9PAwhEbUizKA5Sfk0yvb97wO4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675953322;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B0Yi5BTnnbuv+Mk/rB7X5mpKp0SIdzqCEvJaFAiv+Ao=;
 b=gt7VklvlQQTLE51x4AcFZkFKeYXt9cPaWCuLNK7Euh3IlhFkls7zbmsTCCOXecFypRnOnp
 t6MuaT+U9ms/exDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C5A12138E4;
 Thu,  9 Feb 2023 14:35:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VDTVLKkE5WPsGQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Feb 2023 14:35:21 +0000
Date: Thu, 9 Feb 2023 15:35:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>, Richard Palethorpe <rpalethorpe@suse.com>,
 ltp@lists.linux.it, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y+UEqNtUTNaGVwXT@pevik>
References: <20230129115021.25778-1-wegao@suse.com>
 <20230209131902.12260-1-wegao@suse.com> <Y+UAENJVDUSDPAay@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+UAENJVDUSDPAay@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

...
> > +static void cleanup(void)
> > +{
> > +	if (fd != -1)
> > +		SAFE_CLOSE(fd);
> > +}
> > +
> > +static void run(void)
> > +{
> > +	char *val = "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA";
> > +
> > +	for (unsigned int i = 0; i < 5000; i++)
> > +		TEST(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
TEST() itself does nothing.

> > +
> > +	tst_res(TPASS | TTERRNO, "Try fsconfig overflow on %s done! Failed as expected", tst_device->fs_type);
TTERRNO should not be used with TPASS, TPASS does not analyze anything.

I guess something like this should be used:

	for (unsigned int i = 0; i < 5000; i++) {
		TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
							EINVAL);
		if (!TST_PASS)
			return;
	}

	tst_res(TPASS, "fsconfig() overflow on %s haven't triggerred crash",
			tst_device->fs_type);

but that fails on Btrfs.

> > +}
> > +
> > +static struct tst_test test = {
> > +	.test_all = run,
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +	.needs_root = 1,
> > +	.format_device = 1,
> > +	.mntpoint = MNTPOINT,
> > +	.all_filesystems = 1,
> > +	.min_kver = "5.17",
> You probably add it because 722d94847de29 comes from 5.17-rc1, but that should
> go away, because this fix has been backported to (at least) sles kernels (which
> are older).

> > +	.tags = (const struct tst_tag[]) {
> > +		{"linux-git", "722d94847de29"},
> > +		{"CVE", "2020-29373"},
> IMHO CVE-2020-29373 is about io_uring
> https://nvd.nist.gov/vuln/detail/CVE-2020-29373
> Does it really belong to this test? If yes, it has another kernel fix.
> And you don't mention it in docparse description.

> > +		{"CVE", "2022-0185"},
> > +		{}
> > +	}

Results on my machine (6.2.0-rc6)

tst_test.c:1634: TINFO: === Testing on ext2 ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.46.5 (30-Dec-2021)
note ext2 is *not* using new mount API
fsconfig03.c:50: TPASS: fsconfig() overflow on ext2 haven't triggerred crash
tst_test.c:1634: TINFO: === Testing on ext3 ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
mke2fs 1.46.5 (30-Dec-2021)
fsconfig03.c:50: TPASS: fsconfig() overflow on ext3 haven't triggerred crash
tst_test.c:1634: TINFO: === Testing on ext4 ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
mke2fs 1.46.5 (30-Dec-2021)
fsconfig03.c:50: TPASS: fsconfig() overflow on ext4 haven't triggerred crash
tst_test.c:1634: TINFO: === Testing on xfs ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with xfs opts='' extra opts=''
fsconfig03.c:50: TPASS: fsconfig() overflow on xfs haven't triggerred crash
tst_test.c:1634: TINFO: === Testing on btrfs ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
fsconfig03.c:44: TFAIL: fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0) succeeded
Btrfs should be investigated (IMHO btrfs is using new mount API).

tst_test.c:1634: TINFO: === Testing on vfat ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
fsconfig03.c:44: TFAIL: fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0) succeeded

tst_test.c:1634: TINFO: === Testing on exfat ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with exfat opts='' extra opts=''
fsconfig03.c:50: TPASS: fsconfig() overflow on exfat haven't triggerred crash
Interesting, exfat works :) It also uses new mount API.

tst_test.c:1634: TINFO: === Testing on ntfs ===
tst_test.c:1093: TINFO: Formatting /dev/loop0 with ntfs opts='' extra opts=''
The partition start sector was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the 'sectors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
fsconfig03.c:29: TBROK: fsopen() failed: ENODEV (19)
Hm, that's strange

Due above, I suggest this:
	.skip_filesystems = (const char *const []){"ntfs", "vfat", NULL},

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
