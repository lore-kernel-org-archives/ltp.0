Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45DCC761A6
	for <ltp@archiver.kernel.org>; Thu, 30 Mar 2023 14:15:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20C973CC9A1
	for <ltp@archiver.kernel.org>; Thu, 30 Mar 2023 16:15:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F2EF3CC990
 for <ltp@lists.linux.it>; Thu, 30 Mar 2023 16:14:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 39ADD600C22
 for <ltp@lists.linux.it>; Thu, 30 Mar 2023 16:14:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 68E5C1FE28;
 Thu, 30 Mar 2023 14:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1680185693; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lHcrxAP4pvfumxApAuvnQ6guIOptfrSXDn7gTkGI5FE=;
 b=K/Z0q86giGM2kVbyuPFIep6dAw8ClnBRykkh0DXCgmdvUjb75Jd/OIOTiN5Q7fWoLzvD5/
 IAjHKQ71AbAdfqMLLor2CvZ6tC9TahTkUbY+O1bBmY5IPDffmRNc8dneiNSn4DyCHHWRrU
 doQ5F+/qZV5orz1Q7+4FDRLh28LarF8=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA24C133E0;
 Thu, 30 Mar 2023 14:14:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id VXLMHlyZJWQHJAAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 30 Mar 2023 14:14:52 +0000
Date: Thu, 30 Mar 2023 10:14:49 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20230330141449.GA23902@localhost>
References: <20230328144031.791212-1-pvorel@suse.cz>
 <20230329115850.GA28443@localhost> <20230329133818.GA847898@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230329133818.GA847898@pevik>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Mar 29, 2023 at 03:38:18PM +0200, Petr Vorel wrote:
> > On Tue, Mar 28, 2023 at 04:40:31PM +0200, Petr Vorel wrote:
> > > fsconfig03 is broken not only on vfat and ntfs, but also over FUSE:
> 
> > > tst_supported_fs_types.c:120: TINFO: FUSE does support exfat
> 
> > I have a question on function has_kernel_support.
> 
> > If has_kernel_support start check exfat file system, if exfat not exist then start
> > check fuse, i have no idea why we still need check fuse, i suppose directly
> > return "exfat not support" instead of "FUSE does support exfat".
> 
> Because some filesystems can be supported by both Linux kernel or by FUSE
> (userspace). IMHO only NTFS and exfat are supported by both. We first check
> kernel implementation, but if it's not supported (e.g. kernel configured to
> support particular filesystem, but kernel module not being installed),
> we try to check if FUSE does support that filesystem.
> 
My opinion is has_kernel_support need ONLY check exfat implementation in kernel, this
can better match the name of function. Use for example has_fuse_support return exfat-fuse
or ntfs-3g support.

> > > +++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
> > > @@ -88,7 +88,7 @@ static struct tst_test test = {
> > >  	.mntpoint = MNTPOINT,
> > >  	.all_filesystems = 1,
> > >  	.taint_check = TST_TAINT_W | TST_TAINT_D,
> > > -	.skip_filesystems = (const char *const []){"ntfs", "vfat", NULL},
> > > +	.skip_filesystems = (const char *const []){"fuse", NULL},
> 
> > I feel you can not skip fuse system since i found following list in LTP:
> > static const char *const fs_type_whitelist[] = {
> >         "ext2",
> >         "ext3",
> >         "ext4",
> >         "xfs",
> >         "btrfs",
> >         "vfat",
> >         "exfat",
> >         "ntfs",
> >         "tmpfs",
> >         NULL
> > };
> 
> This array name is quite confusing, that I even once proposed to rename it :) [1].
> It's used for .all_filesystems = 1 (if you don't define .skip_filesystems, all
> filesystems defined in fs_type_whitelist will be running. Therefore only
> filesystems defined in it makes sense to whitelist.
> 

I prefer replace .all_filesystems to .def_filesystems_check if we keep current logic.

> But on tests without .all_filesystems = 1, any filesystem can be defined in
> .skip_filesystems (see testcases/kernel/syscalls/fcntl/fcntl33.c, it has "ramfs"
> and "nfs"). In this case filesystem in $TMPDIR is checked and if the same as any
> member in .skip_filesystems, test is being skipped (see the beginning of
> do_test_setup()). I put some effort to document it, but mainly due
> "ext2/ext3/ext4" (when .all_filesystems = 1, is *not defined*) vs. using these
> separately (e.g..skip_filesystems = (const char *const []){"ext2", "ext3", NULL} ).

I have some difficult to understand above logic.

> 
> Back to your question, fuse is somehow special, see functions in lib/safe_macros.c
> Also, note, we don't even use kernel's NTFS driver, see lib/safe_macros.c:
> 

I prefer using more clear word describe fuse or non-fuse filesystem for white list/skip_filesystems such as:
*exfat // means we check exfat kernel version
*exfat-fuse //fuse version, we can add this into current white list
*ntfs // check ntfs kernel version
*ntfs-3g //fuse userspace implemen, we can add this into current white list

> int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
> 	       const char *source, const char *target,
> 	       const char *filesystemtype, unsigned long mountflags,
> 	       const void *data)
> {
> 	int rval = -1;
> 
> 	/*
> 	 * Don't try using the kernel's NTFS driver when mounting NTFS, since
> 	 * the kernel's NTFS driver doesn't have proper write support.
> 	 */
> 	if (!filesystemtype || strcmp(filesystemtype, "ntfs")) {
> 		rval = mount(source, target, filesystemtype, mountflags, data);
> 		if (!rval)
> 			return 0;
> 	}
> 
> 	/*
> 	 * The FUSE filesystem executes mount.fuse helper, which tries to
> 	 * execute corresponding binary name which is encoded at the start of
> 	 * the source string and separated by # from the device name.
>          *
> 	 * The mount helpers are called mount.$fs_type.
> 	 */
> 	if (possibly_fuse(filesystemtype)) {
> 		char buf[1024];
> 
> 		tst_resm_(file, lineno, TINFO, "Trying FUSE...");
> 		snprintf(buf, sizeof(buf), "mount.%s '%s' '%s'",
> 			filesystemtype, source, target);
> 
> Kind regards,
> Petr
> 
> [1] https://lore.kernel.org/ltp/20220126141152.6428-1-pvorel@suse.cz/
> [2] https://github.com/linux-test-project/ltp/wiki/C-Test-API#113-filesystem-type-detection-and-skiplist
Thanks again for support so much detail backgroud information!

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
