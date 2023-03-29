Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A58C74A5B
	for <ltp@archiver.kernel.org>; Wed, 29 Mar 2023 13:38:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 64CA43CDC58
	for <ltp@archiver.kernel.org>; Wed, 29 Mar 2023 15:38:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3FB43CCA23
 for <ltp@lists.linux.it>; Wed, 29 Mar 2023 15:38:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AF0C110009CB
 for <ltp@lists.linux.it>; Wed, 29 Mar 2023 15:38:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7C52E219E1;
 Wed, 29 Mar 2023 13:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680097100;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gjBSaIuOLj22b1b0qJI30VAMGyN82BvMvjjJhDVLScs=;
 b=YM4HEUAkTTCoNNVy+ozt22Lb/HbY6MIDV1vCrAdMjKnngp8mW3dfFIM3+5PxJtn4SZtmzW
 Aeu7qFBPuwOWA2ZvA7l6yPD8b6QjCJ9AOfBhvxIOv7mN0lwt0IKXwcn9289TUXCfDMTihu
 Xx1s06Io+Hkt2ZIfo8K9G0pfPuTrXpg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680097100;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gjBSaIuOLj22b1b0qJI30VAMGyN82BvMvjjJhDVLScs=;
 b=S59qrdGmvZbcuJmGHiHqqdztRM6LTGFw0Di3jpynzf4IFjjdB+9XJONPioOwQDwnDuuuio
 +I+RXtwqFv07LiCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 63A69138FF;
 Wed, 29 Mar 2023 13:38:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /Z4TF0w/JGQYGQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 29 Mar 2023 13:38:20 +0000
Date: Wed, 29 Mar 2023 15:38:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230329133818.GA847898@pevik>
References: <20230328144031.791212-1-pvorel@suse.cz>
 <20230329115850.GA28443@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230329115850.GA28443@localhost>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] fsconfig03: Skip on FUSE
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Tue, Mar 28, 2023 at 04:40:31PM +0200, Petr Vorel wrote:
> > fsconfig03 is broken not only on vfat and ntfs, but also over FUSE:

> > tst_supported_fs_types.c:120: TINFO: FUSE does support exfat

> I have a question on function has_kernel_support.

> If has_kernel_support start check exfat file system, if exfat not exist then start
> check fuse, i have no idea why we still need check fuse, i suppose directly
> return "exfat not support" instead of "FUSE does support exfat".

Because some filesystems can be supported by both Linux kernel or by FUSE
(userspace). IMHO only NTFS and exfat are supported by both. We first check
kernel implementation, but if it's not supported (e.g. kernel configured to
support particular filesystem, but kernel module not being installed),
we try to check if FUSE does support that filesystem.

> static enum tst_fs_impl has_kernel_support(const char *fs_type)
> {
> ...
>         snprintf(template, sizeof(template), "%s/mountXXXXXX", tmpdir);
>         if (!mkdtemp(template))
>                 tst_brk(TBROK | TERRNO, "mkdtemp(%s) failed", template);

>         ret = mount("/dev/zero", template, fs_type, 0, NULL);
>         if ((ret && errno != ENODEV) || !ret) {
>                 if (!ret)
>                         tst_umount(template);
>                 tst_res(TINFO, "Kernel supports %s", fs_type);
>                 SAFE_RMDIR(template);
>                 return TST_FS_KERNEL;
>         }

>         SAFE_RMDIR(template);

>         /* Is FUSE supported by kernel? */  /////////start check fuse???
>         if (fuse_supported == -1) {
>                 ret = open("/dev/fuse", O_RDWR);
>                 if (ret < 0) {
>                         fuse_supported = 0;
>                 } else {
>                         fuse_supported = 1;
>                         SAFE_CLOSE(ret);



...
> > +++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> > @@ -88,7 +88,7 @@ static struct tst_test test = {
> >  	.mntpoint = MNTPOINT,
> >  	.all_filesystems = 1,
> >  	.taint_check = TST_TAINT_W | TST_TAINT_D,
> > -	.skip_filesystems = (const char *const []){"ntfs", "vfat", NULL},
> > +	.skip_filesystems = (const char *const []){"fuse", NULL},

> I feel you can not skip fuse system since i found following list in LTP:
> static const char *const fs_type_whitelist[] = {
>         "ext2",
>         "ext3",
>         "ext4",
>         "xfs",
>         "btrfs",
>         "vfat",
>         "exfat",
>         "ntfs",
>         "tmpfs",
>         NULL
> };

This array name is quite confusing, that I even once proposed to rename it :) [1].
It's used for .all_filesystems = 1 (if you don't define .skip_filesystems, all
filesystems defined in fs_type_whitelist will be running. Therefore only
filesystems defined in it makes sense to whitelist.

But on tests without .all_filesystems = 1, any filesystem can be defined in
.skip_filesystems (see testcases/kernel/syscalls/fcntl/fcntl33.c, it has "ramfs"
and "nfs"). In this case filesystem in $TMPDIR is checked and if the same as any
member in .skip_filesystems, test is being skipped (see the beginning of
do_test_setup()). I put some effort to document it, but mainly due
"ext2/ext3/ext4" (when .all_filesystems = 1, is *not defined*) vs. using these
separately (e.g..skip_filesystems = (const char *const []){"ext2", "ext3", NULL} ).

Back to your question, fuse is somehow special, see functions in lib/safe_macros.c
Also, note, we don't even use kernel's NTFS driver, see lib/safe_macros.c:

int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
	       const char *source, const char *target,
	       const char *filesystemtype, unsigned long mountflags,
	       const void *data)
{
	int rval = -1;

	/*
	 * Don't try using the kernel's NTFS driver when mounting NTFS, since
	 * the kernel's NTFS driver doesn't have proper write support.
	 */
	if (!filesystemtype || strcmp(filesystemtype, "ntfs")) {
		rval = mount(source, target, filesystemtype, mountflags, data);
		if (!rval)
			return 0;
	}

	/*
	 * The FUSE filesystem executes mount.fuse helper, which tries to
	 * execute corresponding binary name which is encoded at the start of
	 * the source string and separated by # from the device name.
         *
	 * The mount helpers are called mount.$fs_type.
	 */
	if (possibly_fuse(filesystemtype)) {
		char buf[1024];

		tst_resm_(file, lineno, TINFO, "Trying FUSE...");
		snprintf(buf, sizeof(buf), "mount.%s '%s' '%s'",
			filesystemtype, source, target);

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20220126141152.6428-1-pvorel@suse.cz/
[2] https://github.com/linux-test-project/ltp/wiki/C-Test-API#113-filesystem-type-detection-and-skiplist

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
