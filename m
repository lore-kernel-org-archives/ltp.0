Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269D010FC465
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 02:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775701596; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=EzdhrAYGnQGgVVM8G/igsTo4XjQOHNnJzSt5/VuoswM=;
 b=nxw2Eh0FBPD1zyY7Xc+dEswMKPA8GY+rCAEKHtBzBdJ8UvQLVdxtHaasy//jwrG76E6Zk
 cTpIFScis8XT3CqrPYXbYHb2KR+/RV9+TGFESX2MjZtF5c5IWg7OFX6w9tRG2GeTvTc3Aji
 yrYTyXIWhCyLzDWYfeRPEEA79j2xI08=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA75B3E6194
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 04:26:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 945D53E60C0
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 04:26:11 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8CC7E14002B7
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 04:26:10 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso3575265e9.3
 for <ltp@lists.linux.it>; Wed, 08 Apr 2026 19:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1775701570; x=1776306370; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jNNymPwD0XMezgwmXs9zQpJ1ji35r3CHsoskBrmIrDQ=;
 b=Bjz5GVbbNV3RV3+PyYf0e3VD6YrjHQpSGmAm++mCmYuoHr5UA+NrA/LRePe3CY4G22
 tvcF/s0LkG6hjXUORYveSbG62LM0u7jw7FKn2298LPoqevRYu0drlcwljzN/13kyvUT1
 +qrTYrkkVW4dmqCU4KLBH4E8W0rBcLA//ifdCNeZasDWZciTaOwC/fASP3C+mDPElUr7
 SUfN9+D9PkO07bQSiJoaYduI2aBH70ArardvxU4BaRhbs74m6XiEiSBFSUs6UC5XXidk
 ASuAC8QFPN304AGBWgAiuvwpmnHmXiZLJSfTDfxwY7kymgxh0OHWA5m0NpaD1DOaOBiu
 XsfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775701570; x=1776306370;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jNNymPwD0XMezgwmXs9zQpJ1ji35r3CHsoskBrmIrDQ=;
 b=I88uOUBsi5S1VaVMqNPr9HMZVBeV+Z+E4EZI95DDbYwCR0VLb0OylxgIKPNqRE8Qfm
 UuG0DN3IMm7wo5WW3tpYMoqFSLplx1RejqTVPDx5MqhOc47AKEnxyRidWvYfEpGAC4p+
 qaDQfzLTXYKbV7F3AEZ58IU2JQDq2X0hSDHaYEetWlacl9U+4tHOle0owKrlWaPPZbKg
 GE0bh/nKk1wEcfOsyXklHaXLqAvE0czmJRAidBxolOvOxsB1+UAS62CnxV6dJAixt5AF
 ezR/Q2XOnNx2CRiDT8+fW5IwcMcG+nbfJpbykEmNd0RjA2FDP+HyGAHJ1ZXETs17BLc/
 FFag==
X-Gm-Message-State: AOJu0Yw7Vdcb/a6Q9slO2SduQJ6DecJ3SHzKs53l1sEG3hoE9y6bhiCp
 u9er+74BvCZaY/E8FGhGupTZVXkqLsKjfIma6dJSIpVVnp7jARGra/J/bhtS3YiCNaYNRJpOjOf
 FYOE=
X-Gm-Gg: AeBDietFVVUN6QMJ3BiycX0SeoxJbzWUuuZ13lp7gYN9iUWE0YXb7PInF+Ub0PUHZiU
 BR5Y4j0iiW2a1c0G6ke3WdkCRrEkYM5OR4lHzmyR3FoxSepN/PXKJ/c8amwu7udZM3t1MGu5US8
 fCZKqpiDap/ohNG1wUB/AEjtdJd/oYs8zy1rF33icw8rQBeOCq5F+S3d4z7slyumLZCpyaut8vp
 ne+mDgC5Q5Jpx946u2Z2q2CechsGGOVlSyHrsNFfYvzt3AKrOr2/pAEcEgkZu3t1/q9qEq2b7AO
 6rsauCwKCUlnkE0Qe/ctex/qcHBGZd1/V/buARLUxwp4i3gmQQLGZRuKhMuPpXHHAA4z0BCmlbX
 2wBPElY+oiM4Yfybjpu0WdAN0QY6UuO3vwFRWjxO9fTJlS0w7Y7JLIkseA1ZVgQNfq6jZ+4dH1V
 TN47DhiHp5WqasP2G93ZluRyfs+K5MCX6OZ9lMwH4f
X-Received: by 2002:a05:600c:5247:b0:488:b187:3c with SMTP id
 5b1f17b1804b1-488b1870244mr185274045e9.14.1775701569736; 
 Wed, 08 Apr 2026 19:26:09 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488cd0b4829sm22265515e9.3.2026.04.08.19.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 19:26:09 -0700 (PDT)
Date: Thu, 9 Apr 2026 02:26:07 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <adcOPxR0ZgVuRS-a@autotest-wegao.qe.prg2.suse.org>
References: <20260317114635.944-1-wegao@suse.com>
 <20260404011340.13288-1-wegao@suse.com> <adZot378W4Rg-g4V@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <adZot378W4Rg-g4V@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7] io_submit04: Add test case for RWF_NOWAIT flag
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

On Wed, Apr 08, 2026 at 05:11:03PM +0200, Cyril Hrubis wrote:
> Hi!
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/io_submit/io_submit04.c
> > @@ -0,0 +1,99 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2025 Wei Gao <wegao@suse.com>
> > + */
> > +
> > +/*\
> > + * Test RWF_NOWAIT support in io_submit(), verifying that an
> > + * asynchronous read operation on a blocking resource (empty pipe)
> > + * will cause -EAGAIN. This is done by checking that io_getevents()
> > + * :manpage:`io_getevents(2)` syscall returns immediately and
> > + * io_event.res is equal to -EAGAIN.
> > + */
> > +
> > +#include "config.h"
> > +#include "tst_test.h"
> > +#include "lapi/syscalls.h"
> > +#include "lapi/aio_abi.h"
> > +
> > +#define BUF_SIZE 100
> > +
> > +static int fd[2] = {-1, -1};
> > +static aio_context_t ctx;
> > +static char *buf;
> > +static iocb *cb;
> > +static iocb **iocbs;
> > +
> > +static void setup(void)
> > +{
> > +	if (tst_syscall(__NR_io_setup, 1, &ctx))
> > +		tst_brk(TBROK | TERRNO, "io_setup failed");
> 
> Sorry if that was asked in previous reviews. Why are we using
> tst_syscall() instead of the libaio functions like we do in the rest of
> the tests?

No one asked in previous reviews.

For io_submit0* test group, ONLY io_submit01.c use libaio function,
io_submit02.c and io_submit03.c use tst_syscall. I guess io_submit01.c is explicitly
designed to test the libaio library wrapper. Its documentation states: 
"Test io_submit() invoked via libaio".

I prefer io_submit04.c use tst_syscall instead of libaio since no dependency with libaio-devel
and makes the test more portable.

If you are agree then i will send next patch with s/strerror/tst_strerrno fix.
Thanks.

> 
> > +	SAFE_PIPE(fd);
> > +
> > +	cb->aio_fildes = fd[0];
> > +	cb->aio_lio_opcode = IOCB_CMD_PREAD;
> > +	cb->aio_buf = TST_PTR_TO_UINT(buf);
> > +	cb->aio_offset = 0;
> > +	cb->aio_nbytes = BUF_SIZE;
> > +	cb->aio_rw_flags = RWF_NOWAIT;
> > +
> > +	iocbs[0] = cb;
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +	if (fd[0] != -1)
> > +		SAFE_CLOSE(fd[0]);
> > +
> > +	if (fd[1] != -1)
> > +		SAFE_CLOSE(fd[1]);
> > +
> > +	if (ctx && tst_syscall(__NR_io_destroy, ctx))
> > +		tst_brk(TBROK | TERRNO, "io_destroy() failed");
> > +}
> > +
> > +static void run(void)
> > +{
> > +	struct io_event evbuf;
> > +	struct timespec timeout = { .tv_sec = 1 };
> > +	long nr = 1;
> > +
> > +	TEST(tst_syscall(__NR_io_submit, ctx, nr, iocbs));
> > +
> > +	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP) {
> > +		tst_brk(TCONF, "RWF_NOWAIT not supported by kernel");
> > +	} else if (TST_RET != nr) {
> > +		tst_brk(TBROK | TTERRNO, "io_submit() returns %ld, expected %ld",
> > +				TST_RET, nr);
> > +	}
> > +
> > +	TEST(tst_syscall(__NR_io_getevents, ctx, 1, 1, &evbuf, &timeout));
> > +
> > +	if (TST_RET != 1) {
> > +		tst_res(TFAIL | TTERRNO, "io_getevents() failed to get 1 event");
> > +		return;
> > +	}
> > +
> > +	if (evbuf.res == -EAGAIN)
> > +		tst_res(TPASS, "io_getevents() returned EAGAIN on read event");
> > +	else
> > +		tst_res(TFAIL, "io_getevents() returned with %s instead of EAGAIN",
> > +			strerror(-evbuf.res));
>                             ^
> 			    tst_strerrno()
> 
> Other than these two minor issues I do not see any problems in the code,
> the rest looks fine.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
