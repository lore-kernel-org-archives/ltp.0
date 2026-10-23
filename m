Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D1A606A31A
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 07:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=fyU11lQS;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=Rig7VEPV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792741892; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=WvZgLS1YmK6z1yg/KDDcKDISAkGzFPj3B/jaH3hEtHw=;
 b=fyU11lQS67Fi6Fo3Nnv5RPNVo1KnmNT3rtqBFo+r2eo+p7v8zTwDXgHSoGK6cJwuPUpbQ
 djSxTJhP6dJLmi+X99ioBlLN0wc/BjOYPQ/wZPdEEEJoCE6d6dw2IAnCPyCpFklP9pgShxL
 9mCc2/5165EqiWxtmMycEmjF/foadbQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 049BD3E6086
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 09:51:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2A883D2600
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 09:51:11 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F00391A0123F
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 09:51:10 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso365664f8f.1
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 00:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792741870; x=1793346670; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GDqmUlsQWCrH4olb1dArvOwBBfUr7k4ft+u0R4NdpnU=;
 b=Rig7VEPVR9cpb3hMfiSaOjbXoa0aML+MTJB7knDx8YAeXc5HE+UKdQQG1qzWxWO2Bp
 Fg897lx2y7pta+RS23UcivdG8Ntqj4ZWTQxHgngPjojuv9OIUSz3sjof8sWR35MFengV
 f0UyCmfwBdk4wHuU1s77LnM23op2pIJIwD6ywb4kgx8GR7ifGOph4V9lah3f6TL3lFJP
 cOn/nYIYleMRDLD8lfIMvbcS44UYpqkIv3xruRtMvTVOGYDlWpdsBhsxJGolbTSPF2Pa
 pn/kCf6TcYoe0URu6Ik1PBjekf/DlgF5Uk0NEMHXoo39Ey4ledGAvCDqYIfmrISCHKGR
 dj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792741870; x=1793346670;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GDqmUlsQWCrH4olb1dArvOwBBfUr7k4ft+u0R4NdpnU=;
 b=r/uSO7NFh/0JHo53BIM7Tye6IBhA4ZeYHt4AN1rLaWaQ93a0XAJqE/2/D7BHyAuioe
 qpHlW//oJfyTqqyAdBHdgeACY6kE9yXhN75zsatM20VWLE64hdiSxEEUbiI+vqALMnXI
 sXM2XHH+aFgzpijGAGCkKCCRhjGHVSjwYFec45skBQ/3OIv9EuHfQjCOavf496nrqBlB
 hQDiAEy3uwhLMzS4WJGLcqsWbV5SRWuzFbLzPrQhMZNUzF5jJ1aXNMzSrhHaUL6KgeG9
 asN2feWyLKYgATMUk3sxtNGnxkTdTLvnKhv9TgRZMLaG5dySH0k/Epof9/RJTO1bGxkH
 ikKw==
X-Gm-Message-State: AFq9FYKY1i/40LkX/ILu8aSBSeDJmcx/2CCXi8l4qGDsVT884HNNhUdR
 45iCCjqpYQQMitmiw9DkEDIAZYOiXuu5bZeBNWCXxACj7sWVk4XUxDgCZLivzwjiiLjnZ0hvH34
 Eq10=
X-Gm-Gg: AYBFou1QHgG1neSKHD+X8gNUHvuEea2sE0CYwmBC4qrSUNknfCbTwsV8f+kGhIABhw/
 d12iFrBz9vn3hx6oS4cg363UNOAMBnZztyTm3sfcgr+l6laLvn3I1oxjAMlHvd+3BROeHWgnfkd
 9J2wPzhuA8MDipOWppgLvJadfmJ/i8grIZ9OpghsihchHhtN6gm9NjFXpm5LA1srtoxOrAxy0nO
 XhUkLLrjyePyZ5sa4aq0i5FiuUmEe9Pvqz025wYFSwxbkqV3DTyRC7r2gpQlFBJgyqufyoD4NAS
 aYQgF/2DeeSDclLug8eO7H8VVxeKAjTeiVHC94lrfHExYgmcF+Z542J6NunP5t6JPt0II9KbmIf
 r9Jx4iA79+ClI887dJFqrcijIhYRJVwjqGdCwUPFhqwBkeXRMo5Y0Cz3hGzTolzR/S50vnzOrYp
 AyTvoETMZ8mtLUh5r4kfBkqTdzxo1VEZPDcy2NaCADHiUUACm4yzyExMyW55JgDZJCNZ+n5MgZP
 PQlStTwPV55I6to73lcpMs7JfFMVHRkMx4hwXQBhpru06YZmQOO/kVjAY5hMYQHOm5zsOkbS9cF
 74mFaxd1GEUceSg/x930q7NOiutpMp9juwVyrvdkpbZtHPM7sYBG8hILaLXIkfw/PiGpQhhp70U
 =
X-Received: by 2002:a05:6000:2085:b0:487:15a3:1cab with SMTP id
 ffacd0b85a97d-48e3858b1cemr2255433f8f.18.1792741870246; 
 Fri, 23 Oct 2026 00:51:10 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e380314aesm3061914f8f.28.2026.10.23.00.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 00:51:09 -0700 (PDT)
Date: Fri, 23 Oct 2026 07:51:07 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <atsR69ZkDkg5B2yx@autotest-wegao.qe.prg2.suse.org>
References: <20260917024609.20527-1-wegao@suse.com>
 <20261021084933.19097-1-wegao@suse.com> <atoJhAJSqByxqdeQ@yuki.lan>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <atoJhAJSqByxqdeQ@yuki.lan>
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v17] fsconfig04: Check FSCONFIG_SET_PATH
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
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
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Oct 22, 2026 at 03:03:00PM +0200, Cyril Hrubis wrote:
> On Wed, Oct 21, 2026 at 08:49:12AM +0000, Wei Gao via ltp wrote:
> > The fsconfig01.c does not test if FSCONFIG_SET_PATH has any effect;
> > most of the calls there just set a dummy "sync" parameter. This test
> > case aims to verify if the FSCONFIG_SET_PATH operation can be used
> > to dynamically change the external journal device of an ext3 or ext4
> > filesystem.
> > 
> > Closes: https://github.com/linux-test-project/ltp/issues/1169
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  runtest/syscalls                              |   1 +
> >  testcases/kernel/syscalls/fsconfig/.gitignore |   1 +
> >  .../kernel/syscalls/fsconfig/fsconfig04.c     | 169 ++++++++++++++++++
> >  3 files changed, 171 insertions(+)
> >  create mode 100644 testcases/kernel/syscalls/fsconfig/fsconfig04.c
> > 
> > diff --git a/runtest/syscalls b/runtest/syscalls
> > index 2bdb4a9a2..1903f1ac6 100644
> > --- a/runtest/syscalls
> > +++ b/runtest/syscalls
> > @@ -452,6 +452,7 @@ fremovexattr02 fremovexattr02
> >  fsconfig01 fsconfig01
> >  fsconfig02 fsconfig02
> >  fsconfig03 fsconfig03
> > +fsconfig04 fsconfig04
> >  
> >  fsmount01 fsmount01
> >  fsmount02 fsmount02
> > diff --git a/testcases/kernel/syscalls/fsconfig/.gitignore b/testcases/kernel/syscalls/fsconfig/.gitignore
> > index cfedae5f7..bd3754c34 100644
> > --- a/testcases/kernel/syscalls/fsconfig/.gitignore
> > +++ b/testcases/kernel/syscalls/fsconfig/.gitignore
> > @@ -1,3 +1,4 @@
> >  /fsconfig01
> >  /fsconfig02
> >  /fsconfig03
> > +/fsconfig04
> > diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig04.c b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
> > new file mode 100644
> > index 000000000..bd649717e
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/fsconfig/fsconfig04.c
> > @@ -0,0 +1,169 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2026 Wei Gao <wegao@suse.com>
> > + */
> > +
> > +/*\
> > + * This test aims to validate :manpage:`fsconfig(2)` with the
> > + * ``FSCONFIG_SET_PATH`` operation in dynamically altering the external
> > + * journal device of an ext3 or ext4 filesystem.
> > + *
> > + * Root privileges are required because the test creates and formats loop
> > + * devices, and configures filesystems.
> > + *
> > + * [Algorithm]
> > + *
> > + * - Acquire three loop devices (``tst_device->dev`` from framework, ``dev1``, ``dev2``).
> > + * - Format ``dev1`` and ``dev2`` as external journal devices with the same UUID
> > + *   (``-O journal_dev -U <uuid>``).
> > + * - Format ``tst_device->dev`` three times to cycle journal associations:
> > + *   ``dev1`` -> ``dev2`` -> ``dev1``, so both journal superblocks are consistent.
> > + * - Open ``tst_device->dev`` via :manpage:`fsopen(2)` and set the source and journal_path using
> > + *   :manpage:`fsconfig(2)` (``FSCONFIG_SET_STRING``) and
> > + *   :manpage:`fsconfig(2)` (``FSCONFIG_SET_PATH``).
> > + * - Apply ``FSCONFIG_CMD_CREATE`` and verify with ``tune2fs`` that ``tst_device->dev``'s
> > + *   journal device is now ``dev2``.
> > + *
> > + * Implementation notes:
> > + *
> > + * - To avoid ``journal UUID does not match`` error when switching external
> > + *   journal device, we have to assign the same UUID to ``dev1``/``dev2``.
> > + * - Before the :manpage:`fsconfig(2)` test, we have to format ``tst_device->dev`` associating to
> > + *   ``dev1`` -> ``dev2`` -> ``dev1``. This ensures that both ``dev1``/``dev2`` superblocks contain
> > + *   correct content. Otherwise, you will encounter errors such as
> > + *   ``EXT4-fs (loop0): External journal has more than one user (unsupported)``
> > + *   when switching the external journal device using :manpage:`fsconfig(2)`.
> > + */
> > +
> > +
...
> > +static void run(void)
> > +{
> > +	/* Reset dev1, dev2 and tst_device->dev superblocks before each test run iteration */
> > +	SAFE_MKFS(dev1, tst_device->fs_type, mkfs_opts_set_UUID, NULL);
> > +	SAFE_MKFS(dev2, tst_device->fs_type, mkfs_opts_set_UUID, NULL);
> > +	format_journal_device(tst_device->dev, dev1);
> > +	format_journal_device(tst_device->dev, dev2);
> > +	format_journal_device(tst_device->dev, dev1);
> 
> I do not get why we have the dev1 and what errors are we working around
> here. The dev1 is not used for anything, just formatted again and again.

dev1 serves as the initial baseline journal, cycling through dev1 -> dev2 -> dev1 
leaves tst_device->dev pointing to dev1 by default while ensuring both dev1 and dev2 
superblocks are properly initialized so fsconfig() can successfully perform the dynamic 
swap from dev1 to dev2.

Cycling format_journal_device() three times pre-conditions the disk state:
- Pass 1 (dev1): Registers tst_device->dev's UUID into dev1's superblock.
- Pass 2 (dev2): Registers tst_device->dev's UUID into dev2's superblock.
- Pass 3 (dev1): Resets tst_device->dev's default disk state back to dev1.
This leaves both dev1 and dev2 superblocks populated with matching, valid UUID entries for tst_device->dev.

> 
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
