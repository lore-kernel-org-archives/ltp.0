Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7397FF495F
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 08:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774858158; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=nnF/wmk1HQY9WPRyWEohnib73ZxWEkHrf6R1NKwnAvQ=;
 b=VE2qXmf4/TwMP2OMQxGm+KtZGhDE6XiDyqcgzqoKbp8WxNPU+mAHGTVjpdHYe/aGBYwlT
 vWS25JIfFDg0uEfSMysDKnw/v5jJEf5WBPsddUUGyUeDoGaTg0yBfw6W5zx68fc3aapQuw3
 /G399Nt4CWfC7hYu3EC4if2ReHAoOj4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D48F3E4F01
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 10:09:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 455153E2402
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 10:08:55 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1EAC1140007E
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 10:08:53 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43b9d3ebed5so2805347f8f.1
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 01:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774858133; x=1775462933; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zA6p/DQNZZ0HHOF3cb9LkvgpVTL0/oRzmmoOALyYf8w=;
 b=b84d1cjspfmR9hPaRMjVpid6YX6QZAezVVFcV7do8b4M5OzBlSPMylIEWKXLupu8YZ
 rZRjJyKI9Ffj7lSBEBozTG2nvtrzNtfZ9kYx3uskesAi9hNJRSpx5qgTeH8M2YMIHXBo
 Ir25tXw0AjDVezAEMiqEtCU6F0wRqxRezwe0XtXXcppRJzgZPm1vwhT+4iNMEEWdXpJd
 C+nlJ8jRAkQNQevoOfe2XOIw7QroNh1vVcHvRzBc8QZ1sHLyb3FDE58g1ty5FkSVqgNo
 d9eVkh6ZXYxMnFhW12d1HQHCOHCgLq4rV1uzQrY5wi21wfQtI7X4bvoxD6qNsECMbcn3
 2vdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774858133; x=1775462933;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zA6p/DQNZZ0HHOF3cb9LkvgpVTL0/oRzmmoOALyYf8w=;
 b=pd8VRzzZxCth8DLMtYz9JC9L0PsQWzhzXOTR8y6HQmipmrQX1meAGb09I3zHaXtU+L
 1xUiL7zQmCnt51PtyyqAPIxbVp83T5ffnugksnZVlUIrb4Euo9UNuyK7b63HjjpVR4yj
 SVkEsQm0Df/9s4sMHtRsK+ji2KOFWV6L6ud+AJqCf6mABbsgXxmxOKAMA2q6oWmEYr/x
 w6ZRNINaA6ei3bgnrZjnjqO+UjGJd9D5uQFWLQMqOB0+8dnWyILxA8/LFn3BrpOM4lYc
 lRfN7yi8HQq1xnDRerjgIRUAImZIoSCpwIb8ngi2UOiX9a6l8ekgAkzXhDxg8fe2hvgC
 CXUg==
X-Gm-Message-State: AOJu0YzPzBM0RxLXnP+eGgMg1m6lVa9S0eZXX3usMSSg2hPuFRBhIh+k
 M6Tx6B9dNFjT0ShDwxMn+OllzH49Fv3FY8kMoWhcb+0FpwBizULCVp/4y+mSnJUa5SiVVxcUshW
 29nQ=
X-Gm-Gg: ATEYQzwmNBy8h5jzxvLVhGvx/TVcoaipvlyjkVKhD4to/HFvlisH2dteEWoR5aopZxc
 yiHbS1JGzQzJKz6PYQz+9nJQ66D9VdNzIu+iwN16Bu337K4gYGeJRNqWdaJkD+v/6sPuRjAe4CR
 ac79SJxk7O+CkQLGNJmYLCh8AKBiSsquch1FBCNz4yJCIElPxzaoYQ93ofae1HvUxyx9RASbyb2
 Cb+N0eO2uFW5OitLDjLTo5cmTdw1WSu9Xsj862zhtxw5JHLYoDj4xaoPmKfVeHa7cx1kiT+XUJt
 JrNwgPbMfI7orG21W9lGWRpEdm8jAFFCSfUzTthtUGF5tmtcD68xUzHpFD639qDrSAhqbVr5Ljq
 MPKEiNmjQB6ifgMajqI2UmqNGIVnCAAB6+tVZHT++mXDz907XKXx+sMKq7wn/pFWnqHywEnPRjJ
 rrAx1cOL/7muPTvF4I1O9XjW8bFBcISggTBo9YMG0d
X-Received: by 2002:a05:6000:4310:b0:439:c62a:6dc2 with SMTP id
 ffacd0b85a97d-43b9eaaee91mr20593780f8f.41.1774858133245; 
 Mon, 30 Mar 2026 01:08:53 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf2570b18sm19708783f8f.31.2026.03.30.01.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 01:08:52 -0700 (PDT)
Date: Mon, 30 Mar 2026 08:08:51 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <acovk1Naj5B136q-@autotest-wegao.qe.prg2.suse.org>
References: <20260317074340.589-1-wegao@suse.com>
 <20260317114635.944-1-wegao@suse.com>
 <20260327181710.GC1097030@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260327181710.GC1097030@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] io_submit04: Add test case for RWF_NOWAIT flag
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

On Fri, Mar 27, 2026 at 07:17:10PM +0100, Petr Vorel wrote:
> Hi Wei, all,
> 
> > +++ b/configure.ac
> > @@ -172,6 +172,7 @@ AC_CHECK_FUNCS_ONCE([ \
> >  ])
> >  AC_CHECK_FUNCS(mkdtemp,[],AC_MSG_ERROR(mkdtemp() not found!))
> 
> > +AC_CHECK_MEMBERS([struct iocb.aio_rw_flags],,,[#include <linux/aio_abi.h>])
> FYI I double checked this is from 4.13
> 9830f4be159b2 ("fs: Use RWF_* flags for AIO operations")
> 
> So we need it, but it'd be worth to double check how the test run on 4.4 (if it
> TCONF).  Also maybe add a comment in the code or at least mention it in the
> commit message.  When we drop old SLES we will be able to remove this.
I found a 12-SP5 JeOS old img with kernel 4.12, the test result show TCONF, i think
4.4 also can show TCONF.
https://download.opensuse.org/repositories/SUSE:/Templates:/Images:/SLE-12-SP5/images/SLES12-SP5-JeOS.x86_64-12.5-kvm-and-xen-Build1.614.qcow2

linux:~/ltp/testcases/kernel/syscalls/io_submit # uname -r
4.12.14-122.231-default
linux:~/ltp/testcases/kernel/syscalls/io_submit # cat /etc/os-release
NAME="SLES"
VERSION="12-SP5"
VERSION_ID="12.5"
PRETTY_NAME="SUSE Linux Enterprise Server 12 SP5"
ID="sles"
ANSI_COLOR="0;32"
CPE_NAME="cpe:/o:suse:sles:12:sp5"
linux:~/ltp/testcases/kernel/syscalls/io_submit # ./io_submit04 
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_test.c:2059: TINFO: LTP version: 20260130
tst_test.c:2062: TINFO: Tested kernel: 4.12.14-122.231-default #1 SMP Wed Oct 2 17:30:21 UTC 2024 (5f0ddca) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:678: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
tst_test.c:1889: TINFO: Overall timeout per run is 0h 02m 00s
io_submit04.c:65: TCONF: RWF_NOWAIT not supported by kernel

> 
> @Andrea: any hint for your agents to check supported versions
> https://linux-test-project.readthedocs.io/en/latest/users/supported_systems.html#kernel-version
> and whether it needs to have fallback in lapi and configure.ac?
> Also we may ask not to add .min_kver which would be too old.
> 
> >  AC_CHECK_MEMBERS([struct fanotify_event_info_fid.fsid.__val],,,[#include <sys/fanotify.h>])
> >  AC_CHECK_MEMBERS([struct perf_event_mmap_page.aux_head],,,[#include <linux/perf_event.h>])
> >  AC_CHECK_MEMBERS([struct sigaction.sa_sigaction],[],[],[#include <signal.h>])
> > diff --git a/include/lapi/aio_abi.h b/include/lapi/aio_abi.h
> > new file mode 100644
> > index 000000000..ac78e5500
> > --- /dev/null
> > +++ b/include/lapi/aio_abi.h
> > @@ -0,0 +1,44 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2025 Wei Gao <wegao@suse.com>
> > + */
> > +
> > +#ifndef LAPI_AIO_ABI_H__
> > +#define LAPI_AIO_ABI_H__
> > +
> > +#include <endian.h>
> > +#include <linux/aio_abi.h>
> > +
> > +#ifndef RWF_NOWAIT
> > +# define RWF_NOWAIT 0x00000008
> And this as well.
> b745fafaf70c0 ("fs: Introduce RWF_NOWAIT and FMODE_AIO_NOWAIT")
> 
> > +#endif
> > +
> > +struct iocb_fallback {
> > +	uint64_t aio_data;
> > +#if __BYTE_ORDER == __LITTLE_ENDIAN
> > +	uint32_t   aio_key;
> > +	uint32_t aio_rw_flags;
> > +#elif __BYTE_ORDER == __BIG_ENDIAN
> > +	uint32_t aio_rw_flags;
> > +	uint32_t   aio_key;
> > +#else
> > +#error edit for your odd byteorder.
> > +#endif
> > +	uint16_t   aio_lio_opcode;
> > +	int16_t   aio_reqprio;
> > +	uint32_t   aio_fildes;
> > +	uint64_t   aio_buf;
> > +	uint64_t   aio_nbytes;
> > +	int64_t   aio_offset;
> > +	uint64_t   aio_reserved2;
> > +	uint32_t   aio_flags;
> > +	uint32_t   aio_resfd;
> > +};
> > +
> > +#ifndef HAVE_STRUCT_IOCB_AIO_RW_FLAGS
> > +typedef struct iocb_fallback iocb;
> > +#else
> > +typedef struct iocb iocb;
> > +#endif
> > +
> > +#endif /* LAPI_AIO_ABI_H__ */
> ...
> 
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
> Please :manpage:`io_getevents(2)`
> (to have link to https://man7.org/linux/man-pages/man2/io_getevents.2.html in
> docs).
> 
> @Andrea: ^ to agents?
> 
> > + * syscall returns immediately and io_event.res is equal to -EAGAIN.
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
> nit: Andrea (I guess you asked for it), because we hardly close STDOUT in the
> test 0 is always used. I see it a bit overkill using -1 (using 0 as the default
> would almost always work).
> 

Though is nit, i need final decision, @Petr @Andrea

> > +static aio_context_t ctx;
> > +static char *buf;
> > +static iocb *cb;
> > +static iocb **iocbs;
> > +
> > +static void setup(void)
> > +{
> > +	if (tst_syscall(__NR_io_setup, 1, &ctx))
> > +		tst_brk(TBROK | TERRNO, "io_setup failed");
> > +
> > +	SAFE_PIPE(fd);
> > +
> > +	cb->aio_fildes = fd[0];
> > +	cb->aio_lio_opcode = IOCB_CMD_PREAD;
> > +	cb->aio_buf = (uint64_t)buf;
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
> > +	if (ctx)
> > +		if (tst_syscall(__NR_io_destroy, ctx))
> > +			tst_brk(TBROK | TERRNO, "io_destroy() failed");
> Upper if would require { } brackets, but let's simplify:
> 
> 	if (ctx && tst_syscall(__NR_io_destroy, ctx))
> 		tst_brk(TBROK | TERRNO, "io_destroy() failed");
> 
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
> 
> Maybe move this to setup()?
> 
> > +
> > +	TEST(tst_syscall(__NR_io_getevents, ctx, 1, 1, &evbuf, &timeout));
> > +
> > +	if (TST_RET != 1) {
> > +		tst_res(TFAIL | TTERRNO, "io_getevents() failed to get 1 event");
> > +		return;
> > +	}
> > +
> > +	if (evbuf.res == -EAGAIN)
> Did you please check this on 32bit?

Test on 32bit compat mode show error, this need further invetigation why
root@wintermute:~/ltp32/testcases/kernel/syscalls/io_submit# ./io_submit04
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_test.c:2025: TINFO: LTP version: 20250130-546-g13dbd838c
tst_test.c:2028: TINFO: Tested kernel: 7.0.0-rc2-g5ee8dbf54602 #32 SMP PREEMPT_DYNAMIC Tue Mar 24 17:42:54 CST 2026 x86_64
tst_kconfig.c:71: TINFO: Couldn't locate kernel config!
tst_test.c:1846: TINFO: Overall timeout per run is 0h 00m 30s
io_submit04.c:67: TBROK: io_submit() returns -1, expected 1: EFAULT (14)

> 
> > +		tst_res(TPASS, "io_getevents() returned EAGAIN on read event");
> > +	else
> > +		tst_res(TFAIL, "io_getevents() returned with %s instead of EAGAIN",
> > +			strerror(-evbuf.res));
> > +}
> 
> The rest LGTM.
> 
> Kind regards,
> Petr
> 
> > +
> > +static struct tst_test test = {
> > +	.test_all = run,
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +	.needs_kconfigs = (const char *[]) {
> > +		"CONFIG_AIO=y",
> > +		NULL
> > +	},
> > +	.bufs = (struct tst_buffers []) {
> > +		{&buf, .size = BUF_SIZE},
> > +		{&cb, .size = sizeof(iocb)},
> > +		{&iocbs, .size = sizeof(iocb *)},
> > +		{},
> > +	}
> > +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
