Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9516BD2ECF7
	for <ltp@archiver.kernel.org>; Tue, 20 Jan 2026 13:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768915387; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=BPM9iAo0JlBo8egztE9m6KcrP83ZqBCruN3lym6YQog=;
 b=Bu2V546vqpRocBU3/utokf8wHWectd8G0iyN9jM7PSS5K6bzeDBQlfqSYQYDDCXTa5ity
 KHC3qrycOlg3SgyomZkwNp6gX9XUaMWxWIN32gaSHCDLJXFgFfpzINwRSm+j5Q97pHo+MOC
 s8jq1DVS4oxQAU0mD9IcdbhP+z/iUSk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 255243CAF08
	for <ltp@archiver.kernel.org>; Tue, 20 Jan 2026 14:23:07 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E64653CAF01
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 14:22:43 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0B22D140042E
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 14:22:42 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4801c1ad878so42411815e9.1
 for <ltp@lists.linux.it>; Tue, 20 Jan 2026 05:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768915362; x=1769520162; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cxmMXDbz3zNYIZtXBVOt4ztB3aQWVm3vWqJWlfTNRkM=;
 b=Z+ml6aXxmLBJtuKsA5/trWbcq8GI/kfD3i0eIXBC7INdYXoqOfmdwtHwVDB/I9xHtf
 IPy9ulOaJDWZC6Lbkp/ypbMGm21Slv+K3pvk/7znVVjnMwV+sMedO/Y6DhkpqUIyCPi4
 jX4IOqen9fXbF9JvIw9tPgG57v1b7kcg5ccmOMGwbnCYaxC5+yAWD3A+wq8wY4ZCeis1
 tOTDgEClzGEyZjPLVWe4SpJn66ncNVwWVp4pZcH1whcC7KtSrA+msBnks+IqZMLijZqn
 wx2VEqZJor0KrgLmsgTVh8Wb4RTaO45+IVDvmZMkc092w+tekLm4AgtkiOMR+5Vefx9e
 beTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768915362; x=1769520162;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cxmMXDbz3zNYIZtXBVOt4ztB3aQWVm3vWqJWlfTNRkM=;
 b=WzwxoHr54x7C/08NghHheAxwTW9MByi8Neuo8fWb2FF+h/gpoRk7xWXhHjWnaWCaLu
 mnOAq+l72KgwbwCVP56DPQviH4XtpLLeW20WQUu/80BY2eat/JUy4j3Gi0+FzuKsjlnU
 ipsvjN74eArdkJ3J3pXhV41lNTtGcdohKZAwl04q4XBhJ4VlBW3X0JRnYRmmywSK+uHM
 S8rGLyeFPkJc8nTJ/06pqriYV8QUXVeAHsnw2TjLUO3aTRaXYvMn/TabqLY8Lu4bTJS5
 6bQUXh11mPMPGK9g8Q2bgB7CiAwQexq7bevrCgaWWQLiCgEoWlOggvgWtSasBiHvM2Z0
 Qbaw==
X-Gm-Message-State: AOJu0Yx29xXQolIXPM9sc/U9kTnif0/D4r2cC14ajDEcFg+128p/1dDC
 aAqtsSGlv8dkK4FSavHGxeiBREEiEgyIY7MezHCx+vGghpjMmXB7+r4MsvwBY397Dnw=
X-Gm-Gg: AY/fxX5oVClTBesKah17KdDEvQ6trEPdTG0LZI9DwlDtz3NUONLFq7wrNWAKB/ELx11
 q2sY5YIemB9k9zn4gzEJn/mVa5i8GddNeCehifFpNTw1gOOzZ3nlxzLq2ns8y1x29ohegzGVxAI
 mYF6GHvnzQ0nKcuWaKeGhn7yhSgg74IRkaNsWInxSixXfjRqHbsGpOz5/QsUcDEyu0YR3IJqlyq
 9vvZ9cwRZjSnljOnimmDd+jvB2IYFRZ8HMeIW0SAag3IsWH3A0oVtqF73ZZzq03LnDKGkU8U6Df
 XLfIBGxQ8EKpNp9dP0WRfr8MezdSb4ih+TgLlcpxdJEqtG4ZRSR0KJLDE1xalrGbj5WneJnw59m
 law+HTq8XFC8ovromZTKWraCa+gp9p4zVYaxe8IBrq1QkNsLy80tV1jqIpo2EKQuwSZdT0twQv3
 Ro1hnAdfpW/lRREfwFrAUOhSQJRs/WoewgMLR6G6LJip4rh8/siknbnMfs/o9M3Z8DuofYDg5JJ
 Jno1vlLdW25VGY=
X-Received: by 2002:a05:600c:608b:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-4803e7a2cc0mr27080095e9.10.1768915362130; 
 Tue, 20 Jan 2026 05:22:42 -0800 (PST)
Received: from localhost
 (p200300ff0f0b7b017e458f16f8082810.dip0.t-ipconnect.de.
 [2003:ff:f0b:7b01:7e45:8f16:f808:2810])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe3b01csm109468465e9.5.2026.01.20.05.22.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 05:22:41 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 20 Jan 2026 14:22:41 +0100
Message-Id: <DFTG5UGY0U63.3DAYYGFYK110X@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.de>
X-Mailer: aerc 0.18.2
References: <20260120-file_attr05-v3-1-c3fd9fc0fcce@suse.com>
 <20260120124323.GA39038@pevik>
In-Reply-To: <20260120124323.GA39038@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls: add file_attr05 test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue Jan 20, 2026 at 1:43 PM CET, Petr Vorel wrote:
> Hi Andrea,
>
> > From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> > Verify that `file_setattr` is correctly raising EOPNOTSUPP when
> > filesystem doesn't support FSX operations.
>
> > Regression test for "474b155adf39 - fs: make vfs_fileattr_[get|set]
> > return -EOPNOTSUPP".
>
> Reason for changing approach in v3:
> https://lore.kernel.org/ltp/DFTCS1EEBMDD.21X779ISM0MTF@suse.com/
>
> > +++ b/testcases/kernel/syscalls/file_attr/file_attr05.c
> > @@ -0,0 +1,63 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> > + */
> > +
> > +/*\
> > + * Verify that `file_setattr` is correctly raising EOPNOTSUPP when filesystem
> > + * doesn't support FSX operations.
> > + *
> > + * Regression test for "474b155adf39 - fs: make vfs_fileattr_[get|set] return
> > + * -EOPNOTSUPP".
> Why not added into .tags?
> nit: Also the usual way of referring commits is:
> 474b155adf392 ("fs: make vfs_fileattr_[get|set] return -EOPNOTSUPP")
>
> > + */
> > +
> > +#include "tst_test.h"
> > +#include "lapi/fs.h"
> > +
> > +#define MNTPOINT "mntpoint"
> > +#define FILEPATH (MNTPOINT "/ltp_file")
> > +#define BLOCKS 128
> > +#define PROJID 16
> > +
> > +static struct file_attr *attr_set;
> > +
> > +static void run(void)
> > +{
> > +	TST_EXP_FAIL(file_setattr(AT_FDCWD, FILEPATH,
> > +			   attr_set, FILE_ATTR_SIZE_LATEST, 0), EOPNOTSUPP);
> > +}
> > +
> > +static void setup(void)
> > +{
> > +	struct stat statbuf;
> > +
> > +	SAFE_TOUCH(FILEPATH, 0777, NULL);
> > +
> > +	SAFE_STAT(MNTPOINT, &statbuf);
> > +
> > +	attr_set->fa_xflags |= FS_XFLAG_EXTSIZE;
> > +	attr_set->fa_xflags |= FS_XFLAG_COWEXTSIZE;
> > +	attr_set->fa_extsize = BLOCKS * statbuf.st_blksize;
> > +	attr_set->fa_cowextsize = BLOCKS * statbuf.st_blksize;
> > +	attr_set->fa_projid = PROJID;
> > +}
> > +
> > +static struct tst_test test = {
> > +	.test_all = run,
> > +	.setup = setup,
> > +	.mntpoint = MNTPOINT,
> > +	.needs_root = 1,
> > +	.mount_device = 1,
> > +	.all_filesystems = 1,
> > +	.format_device = 1,
> > +	.skip_filesystems = (const char *const []) {
> > +		"xfs",
> > +		"fuse", /* EINVAL is raised before EOPNOTSUPP */
> > +		"vfat", /* vfat is not implementing file_[set|get]attr */
>
> Hm, funny, vfat not implementing also raises EOPNOTSUPP. I wonder if we should
> keep it as well.

It makes sense from the point of view of the results, but it doesn't
make sense from the point of view of the test's meaning. EOPNOTSUPP in
case of vfat is raised for other reasons.

>
> > +		NULL,
> > +	},
> > +	.bufs = (struct tst_buffers []) {
> > +		{&attr_set, .size = sizeof(struct file_attr)},
> Again, I'd put 474b155adf392 into tags. It's IMHO enough (no need for mentioning
> it in the docs.

Sorry I forgot, I'm going to send a v4.


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
