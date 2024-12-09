Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17570E77180
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 11:34:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85FBF3E7F2F
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 12:34:22 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 844E73E7CC7
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 12:34:06 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A5AD210343D1
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 12:34:04 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3146D1F45B;
 Mon,  9 Dec 2024 11:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733744042;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+N9LfOfWUriv1v+yrXCIUmI4yPNceGqJ/dTLXMLlGLE=;
 b=LB4EUktU1s9s/Hbpjxmq87c5sRXKh1iAaU/IxHWOEGlO9hC/kdkWgfP6nhkG1YxL0mUwRK
 g1pV6hAPFbGlY5KiXnE+fWqVq9tIIi7AhUBW0l1T64g6TYKDk/Y56yCzm9Be9CHoWBcXX8
 rKv/m+6xc/EjsxwOTtRW1rtYTcYj6fY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733744042;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+N9LfOfWUriv1v+yrXCIUmI4yPNceGqJ/dTLXMLlGLE=;
 b=M9m5q3xJX0oef51sHda4Q6CVycLnyOlpWSbAOX6TkrHwPnqM+rDvVr1rftWR5c2jO8mxI/
 Lc2CQ29uMxyB+ICg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733744042;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+N9LfOfWUriv1v+yrXCIUmI4yPNceGqJ/dTLXMLlGLE=;
 b=LB4EUktU1s9s/Hbpjxmq87c5sRXKh1iAaU/IxHWOEGlO9hC/kdkWgfP6nhkG1YxL0mUwRK
 g1pV6hAPFbGlY5KiXnE+fWqVq9tIIi7AhUBW0l1T64g6TYKDk/Y56yCzm9Be9CHoWBcXX8
 rKv/m+6xc/EjsxwOTtRW1rtYTcYj6fY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733744042;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+N9LfOfWUriv1v+yrXCIUmI4yPNceGqJ/dTLXMLlGLE=;
 b=M9m5q3xJX0oef51sHda4Q6CVycLnyOlpWSbAOX6TkrHwPnqM+rDvVr1rftWR5c2jO8mxI/
 Lc2CQ29uMxyB+ICg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 192DF138D2;
 Mon,  9 Dec 2024 11:34:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kWN5BKrVVme4SAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 09 Dec 2024 11:34:02 +0000
Date: Mon, 9 Dec 2024 12:34:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Zorro Lang <zlang@kernel.org>
Message-ID: <20241209113400.GA210779@pevik>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-2-zlang@kernel.org>
 <Z02337yqxrfeZxIn@yuki.lan> <Z029S0wgjrsv9qHL@yuki.lan>
 <20241202144208.GB321427@pevik>
 <20241209055309.54x5ngu3nikr3tce@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241209061416.GB180329@pevik>
 <20241209094911.ugpcoshtuj5l2n25@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241209094911.ugpcoshtuj5l2n25@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,linux.it:url];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] ioctl_ficlone02.c: set all_filesystems to zero
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

> On Mon, Dec 09, 2024 at 07:14:16AM +0100, Petr Vorel wrote:
> > > On Mon, Dec 02, 2024 at 03:42:08PM +0100, Petr Vorel wrote:
> > > > > Hi!
> > > > > > The code to skip filesystems in the case of all filesystems is in the
> > > > > > run_tcase_per_fs() function:

> > > > > > static int run_tcases_per_fs(void)
> > > > > > {
> > > > > >         int ret = 0;
> > > > > >         unsigned int i;
> > > > > >         const char *const *filesystems = tst_get_supported_fs_types(tst_test->skip_filesystems);

> > > > > > The skip_filesystems array is passed to the tst_get_supporte_fs_types()
> > > > > > function which filters out them.

> > > > > Perhaps you mean that the skiplist does not work with .all_filesystems
> > > > > _and_ the LTP_SINGLE_FS_TYPE environment variable?

> > > > > I guess that we need:

> > > > > diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> > > > > index bbbb8df19..49b1d7205 100644
> > > > > --- a/lib/tst_supported_fs_types.c
> > > > > +++ b/lib/tst_supported_fs_types.c
> > > > > @@ -159,6 +159,10 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)

> > > > >         if (only_fs) {
> > > > >                 tst_res(TINFO, "WARNING: testing only %s", only_fs);
> > > > > +
> > > > > +               if (tst_fs_in_skiplist(only_fs, skiplist))
> > > > > +                       tst_brk(TCONF, "Requested filesystems is in test skiplist");
> > > > > +

> > > > It's a nice feature to be able to force testing on filesystem even it's set to
> > > > be skipped without need to manually enable the filesystem and recompile.
> > > > (It helps testing with LTP compiled as a package without need to compile LTP.)
> > > > Therefore I would avoid this.

> > > > @Zorro Lang or are you testing whole syscalls on particular filesystem via
> > > > LTP_SINGLE_FS_TYPE=xfs ?

> > > Oh, yes, I always use LTP with different LTP_SINGLE_FS_TYPE. So that's might be
> > > the problem?

> > Thanks for confirming your use case.

> > Well, "Testing only" in the help (-h) was added there to suggest it's for
> > testing/debugging LTP, not a production testing. But newer mind, I'll implement
> > Cyril's suggestion, real usage justify it. + I'll add LTP_FORCE_SINGLE_FS_TYPE.

> > We could allow more filesystems, e.g.  instead of running LTP few times with
> > different LTP_SINGLE_FS_TYPE value: e.g.

> > for fs in ext4 xfs btrfs; do LTP_SINGLE_FS_TYPE=fs ioctl_ficlone02; done

> > we could introduce support for particular filesystems
> > LTP_FILESYSTEMS="ext4,xfs,btrfs" ioctl_ficlone02

> > (Probably define new variable because "SINGLE" is misleading when supporting
> > more filesystems. Also when we touch it, I would consider renaming variable
> > FILESYSTEMS is more obvious for newcomers than "FS_TYPE".)

> > WDYT?

> I generally mount a known filesystem on /mnt/ltpdir, and specify "-d /mnt/ltpdir"
> (to be TMPDIR). Then set (export)
>   LTP_SINGLE_FS_TYPE
>   LTP_DEV_FS_TYPE
>   LTP_BIG_DEV_FS_TYPE
> to be the same fs with the one mounted on $TMPDIR. Then run ltp more likes:

>   for cmdfile in fs fs_perms_simple syscalls fs_bind fsx mm commands fcntl-locktests fs_readonly ipc io containers cve smoketest syscalls-ipc dio ltp-aiodio.part1 ltp-aiodio.part2 ltp-aiodio.part3 ltp-aiodio.part4 ltp-aio-stress; do
> 	runltp  -p -d /mnt/ltpdir -b /dev/loop0 -B xfs -z /dev/loop1 -Z xfs -f $cmdfile ...
>   done

NOTE: I recommend you to test kirk [1], the runltp replacement. Output is in
JSON, which is much easier to parse. It also has more features. We should add
some documentation about kirk into LTP documentation.

Kind regards,
Petr

[1] https://github.com/linux-test-project/kirk

> I do this to test each filesystem in different test jobs. Each test job test one fs.
> I think that might make sure all system calls/IOs test on same filesystem, no matter
> on TMPDIR or someone device. Am I right? Or I missunderstand something?

> Thanks,
> Zorro


> > Kind regards,
> > Petr

> > > Thanks,
> > > Zorro

> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
