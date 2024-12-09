Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ECEDE7717D
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 10:42:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 71A1E3E7941
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 11:42:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7768E3E793C
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 11:42:31 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C9C2F100C693
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 11:42:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D3C6521179;
 Mon,  9 Dec 2024 10:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733740950;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GW+Dkkgm7L4g+Nk2Ar8D7qfMMYCWAseErdvIE19DMKY=;
 b=cD8AKbWt04hznP3VmYium8RYjk69lS02YLA73zyS1XtBrEMkp13++/yICB07RRIduWRdC0
 q0b8JsR81lSiecZDNC3MT3Ta4aa8/UTonPXu3BXddxonSi5V6cSp2eu2bxlZ6volvGe5jj
 4z9RcF1neJvbF1TglZK4W/pr4PukJu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733740950;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GW+Dkkgm7L4g+Nk2Ar8D7qfMMYCWAseErdvIE19DMKY=;
 b=8+VJdus8lVOZkshjRhd4W1N2KvxZqFisJJVq9zMz2BcoiEEV1aeNEq2tSa6zsbrhLZG+WD
 YjCszCes0bPm4gAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LCtZ8PU+;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=d7oMu7aU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733740949;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GW+Dkkgm7L4g+Nk2Ar8D7qfMMYCWAseErdvIE19DMKY=;
 b=LCtZ8PU+U0u1rMAFci0WUrmr+bvshGHq3qMIBGR+zehXXeqKKeVP47Sz5kgZlMuI8RZsbC
 FNQctLmHsid2H3jjeYrPkUODQB6qSiUhleIpEykQaJ2a5rUTdoYYnTvPrLiTbgGIoXqMuJ
 FTHcpoVZV1PWCxdxXL+lr7TACnZsyQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733740949;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GW+Dkkgm7L4g+Nk2Ar8D7qfMMYCWAseErdvIE19DMKY=;
 b=d7oMu7aULQwUjAKQSVa6D5zxpCyzed5mht8g1xoFRTJsk9mHEUaURB7QgKYn3e1AY+Tyeq
 0yVOI+RYG9MzT3Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACF5B13983;
 Mon,  9 Dec 2024 10:42:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id piHMKJXJVme2OAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 09 Dec 2024 10:42:29 +0000
Date: Mon, 9 Dec 2024 11:42:28 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Zorro Lang <zlang@kernel.org>
Message-ID: <20241209104228.GA208755@pevik>
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
X-Rspamd-Queue-Id: D3C6521179
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

> I do this to test each filesystem in different test jobs. Each test job test one fs.
> I think that might make sure all system calls/IOs test on same filesystem, no matter
> on TMPDIR or someone device. Am I right? Or I missunderstand something?

IMHO we intended slightly different behavior:

point TMPDIR to the filesystem you are interested in (e.g. /var/tmp for openSUSE
to test Btrfs instead of tmpfs).
Most of the tests are filesystem agnostic (not related to file/filesystem or
using common VFS code), thus this setup is ok (just to avoid testing tmpfs which
is in RAM instead of real block device). Running these tests "manually" for all
filesystems should be waste of time. If you see different results, it might mean
that some system should use .all_filesystems = 1.

These tests where filesystem matters should use .all_filesystems = 1 setup, thus
they run on all available filesystems. You just need to make sure that SUT has
required dependencies (mkfs.* binary and filesystem configured in kernel).

Kind regards,
Petr

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
