Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3A6E77173
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 05:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733723617; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=gAllJ6TSb7jCe0yflIERoyCPQsaHElER6Pb8KTK7rsA=;
 b=f7CviQqUpPU3FjbkbnsnJS32Ni+ztiXrjl2xmOU6ZlcV7xtmzNYzxuQEe1JCVP8g+n/bi
 pmwX557FsIr7WhbCo/i7GusGuB8nORjGRskThqkYx+swt6yUpNAgZd/eZ4gJyBrez61QFbb
 KC8qB/XiALH9/7r7OOe3zv58cmLPX/A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C605B3E2CF6
	for <ltp@archiver.kernel.org>; Mon,  9 Dec 2024 06:53:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CD8B3D3B82
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 06:53:16 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=zlang@kernel.org; receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 467F9644A3C
 for <ltp@lists.linux.it>; Mon,  9 Dec 2024 06:53:15 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2D4DC5C55BC;
 Mon,  9 Dec 2024 05:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E8ABC4CED1;
 Mon,  9 Dec 2024 05:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733723593;
 bh=JUx61LlOuh9JRe8p7MKPL6/7r0KR3CL3nxGdz3IBBmE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k04TNpYR4YFTvXA50Vbb6N8hYwPg6BnLdrpbwckF0iU7MgsMc8GePEP/TDFcwhtKZ
 5cM8EFfnmmoIrbbmhjsOHiTZFt9ld7LMn6Ea1QZ7Trn/wCBlxWtudGpMkTKv/nrsnW
 Zv+mWjZT6BAW0ATn+6HH8X2cDQGXPzzcyHT81E1Fl91JbCp+bkgK12k4WbHaz5OD8R
 I5A6KuGutcV81IkqyY5OfvSztkHwR8g7ZQp7Dbz4YtWbc5LNwnf/jr5wFGQoAJdZad
 Q8DhGGXrlgYZLwRI3IVkMkb3mP1E930XI2G9DFcdEk5g9XdqdPjLI+/QxhWwHLE/vK
 3VtMrneLOCKXg==
Date: Mon, 9 Dec 2024 13:53:09 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20241209055309.54x5ngu3nikr3tce@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241201093606.68993-1-zlang@kernel.org>
 <20241201093606.68993-2-zlang@kernel.org>
 <Z02337yqxrfeZxIn@yuki.lan> <Z029S0wgjrsv9qHL@yuki.lan>
 <20241202144208.GB321427@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241202144208.GB321427@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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
From: Zorro Lang via ltp <ltp@lists.linux.it>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: ltp@lists.linux.it, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Dec 02, 2024 at 03:42:08PM +0100, Petr Vorel wrote:
> > Hi!
> > > The code to skip filesystems in the case of all filesystems is in the
> > > run_tcase_per_fs() function:
> 
> > > static int run_tcases_per_fs(void)
> > > {
> > >         int ret = 0;
> > >         unsigned int i;
> > >         const char *const *filesystems = tst_get_supported_fs_types(tst_test->skip_filesystems);
> 
> > > The skip_filesystems array is passed to the tst_get_supporte_fs_types()
> > > function which filters out them.
> 
> > Perhaps you mean that the skiplist does not work with .all_filesystems
> > _and_ the LTP_SINGLE_FS_TYPE environment variable?
> 
> > I guess that we need:
> 
> > diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> > index bbbb8df19..49b1d7205 100644
> > --- a/lib/tst_supported_fs_types.c
> > +++ b/lib/tst_supported_fs_types.c
> > @@ -159,6 +159,10 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)
> 
> >         if (only_fs) {
> >                 tst_res(TINFO, "WARNING: testing only %s", only_fs);
> > +
> > +               if (tst_fs_in_skiplist(only_fs, skiplist))
> > +                       tst_brk(TCONF, "Requested filesystems is in test skiplist");
> > +
> 
> It's a nice feature to be able to force testing on filesystem even it's set to
> be skipped without need to manually enable the filesystem and recompile.
> (It helps testing with LTP compiled as a package without need to compile LTP.)
> Therefore I would avoid this.
> 
> @Zorro Lang or are you testing whole syscalls on particular filesystem via
> LTP_SINGLE_FS_TYPE=xfs ?

Oh, yes, I always use LTP with different LTP_SINGLE_FS_TYPE. So that's might be
the problem?

Thanks,
Zorro

> 
> Kind regards,
> Petr
> 
> >                 if (tst_fs_is_supported(only_fs))
> >                         fs_types[0] = only_fs;
> >                 return fs_types;
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
