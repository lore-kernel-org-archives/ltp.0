Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E5B5C6FD1F
	for <ltp@archiver.kernel.org>; Fri, 29 Mar 2024 08:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1711700946; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=73Z0fp2MWNvhA9biK/BcqJmLCZtWsTsdoRqcbtT7QSg=;
 b=ckf/lKmhsJd3/VdVzFt97zZyQfi19p2+4Kro5Vq41jsp9bN9583UP+FoDT7A3SNaae/eC
 +JVLuzXhbJAhFK9WnwsHnc64gJBaLP8m4lp9s4EFPUjyZ3fDMOu1YeXVCZWspKCY3wO1LU/
 9ETB+nm6emr22zpcJ0l52C4SA09lW4k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C255E3C4E99
	for <ltp@archiver.kernel.org>; Fri, 29 Mar 2024 09:29:06 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE36A3C21A0
 for <ltp@lists.linux.it>; Fri, 29 Mar 2024 09:28:43 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 675FA60310B
 for <ltp@lists.linux.it>; Fri, 29 Mar 2024 09:28:42 +0100 (CET)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a466a27d30aso217780066b.1
 for <ltp@lists.linux.it>; Fri, 29 Mar 2024 01:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1711700922; x=1712305722; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fVVUVKPyFUdRwjH2t8dacVQ2xs9O+79wB8S/QTR47kI=;
 b=dn2P6YDgYHrj24LQmU6rD5xB3hfIU+lsgKthXlG+2lQM5O9CfGRdR30bgYsfj6a+v4
 4WKQKLqY4OOBqnOtoI9Uu9jyZqqfFWXbDGXCCqWt8LyA89fxhl76nb+MMm9KJfYnxy0/
 oEv5IUHGX5vqO8BeYb/wEwcHV7ls1NLf9Ggr9WAr8f2y/t1fdGaKFIU6i1MAvWGfne9p
 Cm4s9DAYyJ1vtGkF226lACxPtQjg5rsKBzxKKMm/jCyu9YfQ0TcA5GujsrcfEFZg9T5H
 4weeBXHCiY6FHWroUv9AefgsqjPJaGfh3qZmFMvj57RbUX1+8eFDz0ldAJiYPfv9NBPs
 17HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711700922; x=1712305722;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fVVUVKPyFUdRwjH2t8dacVQ2xs9O+79wB8S/QTR47kI=;
 b=ffc/6+nXlwv1ssk4JhQvswDwrzYIOUZQWnZfArb+BDAYxjhEBEDfgemrQ2vbgWdCAU
 BjvnKtmySl5lGLBNAjdZ0ljL2QIwwWwTp5kNf0u6LtoGWNqwQeshp+nbaNcj7yGfrRNx
 Fe4Ji6TfEmodT+HrQ5goUzIb6Fl6UEVEmyR5cQU23ZZDfMcbGZM9FWDo98ua/7EXyhPa
 /jONqhw5AboF9mU2pYerQKEjf+jjazLfvI1eXYwsuqcqK5QU2NBFG+fYOPhSKqcVQeYQ
 o32MYJaezh2WQVRqclPUgLzgxClqzjtm2YyVZZvHQA5QPFDirr7mUYa4cpWx1TXKwMjq
 CHUQ==
X-Gm-Message-State: AOJu0Yy7XeMR7IxDsu/Fh9yS4hlt3NC1VaXIeXxVLsHZgVlDonYcGS1e
 LKRNIkC3dYUFbuM210HCnQGv4q2tc2Gr3OFSvVGvlz/c5RBc8dpybnR3WN6EyD5o1XmNO4anzcM
 =
X-Google-Smtp-Source: AGHT+IGEBuQAc5i79UpNhLvq+D4wvSrg2REzaQEvNkwdOF+j7wAlSVqO79S6IP+AcvcWFQ99tPGd1w==
X-Received: by 2002:a17:906:7245:b0:a4e:2269:bc21 with SMTP id
 n5-20020a170906724500b00a4e2269bc21mr1014976ejk.1.1711700921707; 
 Fri, 29 Mar 2024 01:28:41 -0700 (PDT)
Received: from wegao.21.28.32 ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 ga13-20020a1709070c0d00b00a473f5ac943sm1657657ejc.37.2024.03.29.01.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 01:28:41 -0700 (PDT)
Date: Fri, 29 Mar 2024 04:28:35 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZgZ7swC75rxF9hFq@wegao.21.28.32>
References: <20231018054357.29035-1-wegao@suse.com>
 <20240118073215.10026-1-wegao@suse.com>
 <20240228170729.GA1618063@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240228170729.GA1618063@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ioctl_fiemap01: New test for fiemap ioctl()
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

On Wed, Feb 28, 2024 at 06:07:29PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> > Fixes: #535
> 
> > diff --git a/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c b/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
> > new file mode 100644
> > index 000000000..a626bb03c
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
> > @@ -0,0 +1,116 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> > + */
> > +
> > +/*\
> > + * [Description]
> > + *
> > + * Verify basic fiemap ioctl
> > + *
> nit: missing space and dot at the end.
> > + */
> > +
> > +#include <linux/fs.h>
> > +#include <linux/fiemap.h>
> > +#include <stdlib.h>
> > +
> > +#include "tst_test.h"
> > +
> > +#define TESTFILE "testfile"
> > +#define NUM_EXTENT 2
> > +#define FILE_OFFSET ((rand() % 8 + 2) * getpagesize())
> > +
> > +static char *buf;
> > +
> > +static void print_extens(struct fiemap *fiemap)
> > +{
> > +
> nit: please no space above.
> > +	tst_res(TDEBUG, "File extent count: %u", fiemap->fm_mapped_extents);
> nit: please add space here (readability)
> > +	for (unsigned int i = 0; i < fiemap->fm_mapped_extents; ++i) {
> > +		tst_res(TDEBUG, "Extent %u: Logical offset: %llu, Physical offset: %llu, flags: %u, Length: %llu",
> > +				i + 1,
> > +				fiemap->fm_extents[i].fe_logical,
> > +				fiemap->fm_extents[i].fe_physical,
> > +				fiemap->fm_extents[i].fe_flags,
> > +				fiemap->fm_extents[i].fe_length);
> > +	}
> > +}
> > +
> > +static void verify_ioctl(void)
> > +{
> > +	int fd;
> > +	struct fiemap *fiemap;
> > +
> > +	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
> > +
> > +	fiemap = SAFE_MALLOC(sizeof(struct fiemap) + sizeof(struct fiemap_extent) * NUM_EXTENT);
> > +	fiemap->fm_start = 0;
> > +	fiemap->fm_length = ~0ULL;
> > +	fiemap->fm_extent_count = 1;
> > +
> > +	fiemap->fm_flags =  -1;
> > +	TST_EXP_FAIL(ioctl(fd, FS_IOC_FIEMAP, fiemap), EBADR);
> 
> I get on Tumbleweed with 6.8.0-rc4-1.g9b23bf2-default EOPNOTSUPP:
> ioctl_fiemap01.c:52: TFAIL: ioctl(fd, FS_IOC_FIEMAP, fiemap) expected EBADR: EOPNOTSUPP (95)
> What is the missing dependency for FS_IOC_FIEMAP? Or is there wrong fiemap use
> which causes that?
Thanks for your test and i also reproduce this issue.
This is caused by Tumbleweed mount tmpfs on /tmp and tmpfs seems not support fiemap action.
tmpfs on /tmp type tmpfs (rw,nosuid,nodev,size=494452k,nr_inodes=1048576,inode64)

I will sent new patch for cover all supported filesystem.
> 
> > +
> > +	fiemap->fm_flags =  0;
> > +	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
> And on the same kernel another EOPNOTSUPP:
> 
> ioctl_fiemap01.c:55: TBROK: ioctl(3,((((2U|1U) << (((0+8)+8)+14)) | ((('f')) << (0+8)) | (((11)) << 0) | ((((sizeof(struct fiemap)))) << ((0+8)+8)))),...) failed: EOPNOTSUPP (95)
> > +	print_extens(fiemap);
> > +	if (fiemap->fm_mapped_extents == 0)
> > +		tst_res(TPASS, "Check fiemap iotct zero fm_mapped_extents pass");
> s/iotct/ioctl/
> 
> > +	else
> > +		tst_res(TFAIL, "Check fiemap iotct zero fm_mapped_extents failed");
> s/iotct/ioctl/
> > +
> > +	SAFE_WRITE(SAFE_WRITE_ANY, fd, buf, getpagesize());
> > +	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
> > +	print_extens(fiemap);
> Maybe print only on failure?
> > +	if ((fiemap->fm_mapped_extents == 1) && (fiemap->fm_extents[0].fe_physical == 0))
> NOTE: brackets are not needed (== has higher precedence than &&), thus:
> 	if (fiemap->fm_mapped_extents == 1 && fiemap->fm_extents[0].fe_physical == 0)
> 
> > +		tst_res(TPASS, "Check fiemap iotct one fm_mapped_extents pass");
> s/iotct/ioctl/
> > +	else
> > +		tst_res(TFAIL, "Check fiemap iotct one fm_mapped_extents failed");
> s/iotct/ioctl/
> > +
> > +	fiemap->fm_flags = FIEMAP_FLAG_SYNC;
> > +	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
> > +	print_extens(fiemap);
> > +	if ((fiemap->fm_mapped_extents == 1) &&
> nit: again == does not need to be in ()
> > +		(fiemap->fm_extents[0].fe_flags == FIEMAP_EXTENT_LAST) &&
> > +		(fiemap->fm_extents[0].fe_physical > 0) &&
> > +		(fiemap->fm_extents[0].fe_length == (__u64)getpagesize()))
> > +		tst_res(TPASS, "Check fiemap iotct FIEMAP_FLAG_SYNC fm_flags pass");
> s/iotct/ioctl/
> > +	else
> > +		tst_res(TFAIL, "Check fiemap iotct FIEMAP_FLAG_SYNC fm_flags failed");
> s/iotct/ioctl/
> There are 4x checks, I guess instead it would be worth to write what exactly failed.
> 
> > +
> > +	fiemap->fm_extent_count = NUM_EXTENT;
> > +	srand(time(NULL));
> > +	SAFE_LSEEK(fd, FILE_OFFSET, SEEK_SET);
> > +	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, getpagesize());
> > +	SAFE_IOCTL(fd, FS_IOC_FIEMAP, fiemap);
> > +	print_extens(fiemap);
> > +	if ((fiemap->fm_mapped_extents == NUM_EXTENT) &&
> nit: If this check was repeated more than twice, I would put it into separate
> function.
> > +		(fiemap->fm_extents[NUM_EXTENT - 1].fe_flags == FIEMAP_EXTENT_LAST) &&
> > +		(fiemap->fm_extents[NUM_EXTENT - 1].fe_physical > 0) &&
> > +		(fiemap->fm_extents[NUM_EXTENT - 1].fe_length == (__u64)getpagesize()))
> > +		tst_res(TPASS, "Check fiemap iotct multiple fm_mapped_extents pass");
> > +	else
> > +		tst_res(TFAIL, "Check fiemap iotct multiple fm_mapped_extents failed");
> > +
> > +	free(fiemap);
> > +	SAFE_CLOSE(fd);
> > +	unlink(TESTFILE);
> > +}
> ...
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
