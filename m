Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E42EDEC05
	for <ltp@archiver.kernel.org>; Thu,  5 Mar 2026 04:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772685731; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=z2pdeqSXZJQz1Q4McUwHRuirvPdEKam+DFiXixrIQkA=;
 b=KeRl1cg0hPJb2uFhqCpEbWW2RgIPPE1kw2VxcR3CyeCBSFdu0+fIS7RT1Gc0g5bgF1OYk
 ZZEoFxmEK4eC0+4T2bhvJgBS3l7uhKOOJU49XaDrExbDVGMVDHqSyzD1+10aMbJHoLZoa3u
 jLMZtGFk2uE0qqPzdtDLytezHYBpxbw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FC413C7831
	for <ltp@archiver.kernel.org>; Thu,  5 Mar 2026 05:42:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 50DE23C7831
 for <ltp@lists.linux.it>; Thu,  5 Mar 2026 05:41:47 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5F7241400E5D
 for <ltp@lists.linux.it>; Thu,  5 Mar 2026 05:41:46 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-439b8a3f2bcso3141263f8f.3
 for <ltp@lists.linux.it>; Wed, 04 Mar 2026 20:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772685706; x=1773290506; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zv6wQZ6xhEwfY5ox3q88l7kLB4KZDIr3jjq3kERuvGo=;
 b=GdgFA/o03ELZ5W0aKo/qo/37b6nH/zXr8d40qMqcmVvYcCbPlx9LvwtHhHgKCsO3KX
 zdoogH/4SIrOUHG+915lVMbvOUmxOZD2t+nYYpiOe4nTEASvLsE18tDlHxgMrrertDl3
 /KW9n0WFAEXRoEuIbPb4VBRYggios/ZcGCYUuH/dTyEAXrU169B3iAVQux6eis2nKcDb
 768X2xMWwYmZDZAWchrkjPMGjKG1Db5soLExRMXppAAFxfrzOb9e/JEMPkjHCX4eIDlQ
 LbT2U9DYg/2a2ghLC+rviKJjYgPv7q68Y5TemHr4zZDUDp8q26ykAW3rNRZ3Ff/1vML1
 Sirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772685706; x=1773290506;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zv6wQZ6xhEwfY5ox3q88l7kLB4KZDIr3jjq3kERuvGo=;
 b=eTKTjGEcUVcYHX8tx3PforPLt3QQnnTRlTDEzqnanQg+JN7YjTt9CtVXRUosOBwAgE
 NX5exfLVMVeUCdRCXZPoXeUwoPf+7vj7SErj560bge561kKUZu72imxLOFSwfcLKrcWn
 Y9cHkejZJHczgjU5G2PJmtQ7z7es5dTxxQ9gC3ICNmDgsuaPUuaTY7q58dIN9bTYFsq8
 wvUuyPaWS/+D7d68dW1CmveflymbqTtrcR1Y0KGV2R345lTQ4yH1JGZdKHf1fQe6Fj81
 6JapqiFajokFywgXTbQQJ4t5Y9pzLO5eCp2mUznk+nRSyjbdWNaS+iYdG5avNHO+ERBX
 sOrA==
X-Gm-Message-State: AOJu0YzAhnlVSs4iHAcoQYa6lsHqE9u9M1WCHp8dC+2FWOZHqw736myi
 7fcjBytB/6Rrw+PrKqmlSOkc4WZH3zz6FxexcrX8Ykozrkt/gcPinZ/QlfN0iR0V6NSCLbeGZ+M
 MQlk=
X-Gm-Gg: ATEYQzw9090mP7bKFgTVPPe9HDuRdL5O5638ZGo3Oh6dR52Ge1puOH+nPEJXX7D+1Sg
 ne25eyTC/PWG4pKXdD9t7En1zMQ5DyGp2XV+jAKn1Dc9OTbxI2cun6HHZeNKkWrI/HEmBC77hyZ
 +MlZY4TuItKYjvqt0UX7dhN/A3ytpmNeYCkaf0z4kkZK3UOjzi8tEv9boneXa4CD5kMKAwfrZWj
 FnppIzO3mi6HmcOkEMtAm1Bt3/1FzvgJCOLSqSLDYw5QMptqD0cT8xwWZ4Wa2YdMBR3shGsCuBv
 tGlQowCvmAbJz6QwrBN6HtcWhwMQ9cIPn3vmsKrJ1qSpEAM2jNOJgw9GMFqgGAAGSN4ZDIRpCaa
 kL9VmmIg+jv3fJDG2vrSv/G321n7wgIIsh+vwdVB1+QyROlPp2H+4pO8v3ZPybQLwNpeqiYfnxD
 Xfl52znJCxoY5yt3xAibYUlK7Sg/0cbngoshmht0al
X-Received: by 2002:a05:6000:144f:b0:439:afd8:621c with SMTP id
 ffacd0b85a97d-439c801fb47mr7592322f8f.55.1772685705666; 
 Wed, 04 Mar 2026 20:41:45 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b503425asm30388712f8f.25.2026.03.04.20.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Mar 2026 20:41:45 -0800 (PST)
Date: Thu, 5 Mar 2026 04:41:43 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aakJh4g-gq0PZ4Vc@autotest-wegao.qe.prg2.suse.org>
References: <20251224085004.10267-1-wegao@suse.com>
 <20260107061008.18971-1-wegao@suse.com>
 <DGI3103QL3WD.19RTIBPXXCGXI@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DGI3103QL3WD.19RTIBPXXCGXI@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] io_submit04: Add test case for RWF_NOWAIT flag
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

On Wed, Feb 18, 2026 at 01:21:46PM +0100, Andrea Cervesato wrote:
> Hi!
> 
> On Wed Jan 7, 2026 at 7:10 AM CET, Wei Gao wrote:
> > Fixes: #467
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> 
> > +
> > +#ifndef HAVE_STRUCT_IOCB_AIO_RW_FLAGS
> > +typedef struct iocb_fallback iocb;
> 
> Why not just define here the iocb, instead of having iocb_fallback
> defined before?
This way can avoid complie failure on old system such as:
https://github.com/coolgw/ltp/actions/runs/22699554704/job/65813365426
make[4]: *** [io_submit04] Error 1
make[4]: *** Waiting for unfinished jobs....
../../../../include/mk/rules.mk:48: recipe for target 'io_submit04' failed
CC testcases/kernel/syscalls/io_submit/io_submit01
CC testcases/kernel/syscalls/io_submit/io_submit02
CC testcases/kernel/syscalls/io_submit/io_submit03
make[3]: *** [all] Error 2
../../../include/mk/generic_trunk_target.inc:92: recipe for target 'all' failed
make[2]: *** [all] Error 2
../../include/mk/generic_trunk_target.inc:92: recipe for target 'all' failed
make[1]: *** [all] Error 2
../include/mk/generic_trunk_target.inc:92: recipe for target 'all' failed
make[1]: Leaving directory '/__w/ltp/ltp/testcases'
Makefile:85: recipe for target 'testcases-all' failed
make: *** [testcases-all] Error 2
Error: Process completed with exit code 2

This kind of fallback also mentioned/used in following patch:
https://patchwork.ozlabs.org/project/ltp/patch/20251211015915.1086-1-wegao@suse.com/

> 
> > +#else
> > +typedef struct iocb iocb;
> 
> And this would not be needed then.
> 
> > +#endif
> > +
> > +#endif /* LAPI_AIO_ABI_H__ */
> > diff --git a/runtest/syscalls b/runtest/syscalls
> > index a1ef7548b..18182a2d6 100644
> > --- a/runtest/syscalls
> > +++ b/runtest/syscalls
> > @@ -696,6 +696,7 @@ io_setup02 io_setup02
> >  io_submit01 io_submit01
> >  io_submit02 io_submit02
> >  io_submit03 io_submit03
> > +io_submit04 io_submit04
> >  
> >  keyctl01 keyctl01
> >  keyctl02 keyctl02
> > diff --git a/testcases/kernel/syscalls/io_submit/.gitignore b/testcases/kernel/syscalls/io_submit/.gitignore
> > index 60b07970a..abe962e1c 100644
> > --- a/testcases/kernel/syscalls/io_submit/.gitignore
> > +++ b/testcases/kernel/syscalls/io_submit/.gitignore
> > @@ -1,3 +1,4 @@
> >  /io_submit01
> >  /io_submit02
> >  /io_submit03
> > +/io_submit04
> > diff --git a/testcases/kernel/syscalls/io_submit/io_submit04.c b/testcases/kernel/syscalls/io_submit/io_submit04.c
> > new file mode 100644
> > index 000000000..d085d3238
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/io_submit/io_submit04.c
> > @@ -0,0 +1,94 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2025 Wei Gao <wegao@suse.com>
> > + */
> > +
> > +/*\
> > + * Test RWF_NOWAIT support in io_submit(), verifying that an
> > + * asynchronous read operation on a blocking resource (empty pipe)
> > + * will cause -EAGAIN. This is done by checking that io_getevents()
> > + * syscall returns immediately and io_event.res is equal to -EAGAIN.
> > + */
> > +
> > +#include "config.h"
> > +#include "tst_test.h"
> > +#include "lapi/syscalls.h"
> > +#include "lapi/aio_abi.h"
> > +
> > +
> 
> nit: double blank-line is not needed.
> 
> > +#define BUF_SIZE 100
> > +
> > +static int fd[2];
> 
> fd should be initialized to -1 and compared to this value in the
> cleanup() before closing. zero is a valid value for file descriptors
> (stdin).
> 
> > +
> > +static aio_context_t ctx;
> > +static char *buf;
> > +static iocb *cb;
> > +static iocb **iocbs;
> > +
> > +static void setup(void)
> > +{
> > +	TST_EXP_PASS_SILENT(tst_syscall(__NR_io_setup, 1, &ctx));
> 
> We need to break the test here if io_setup fails. Silently failing it
> will keep test running.
> 
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
> > +	if (fd[0])
> > +		SAFE_CLOSE(fd[0]);
> > +
> > +	if (fd[1])
> > +		SAFE_CLOSE(fd[1]);
> > +
> > +	if (ctx)
> > +		if (tst_syscall(__NR_io_destroy, ctx))
> > +			tst_brk(TBROK | TERRNO, "io_destroy() failed");
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
> > +	if (TST_RET == -1 && errno == EOPNOTSUPP) {
> > +		tst_brk(TCONF, "RWF_NOWAIT not supported by kernel");
> > +	} else if (TST_RET != nr) {
> > +		tst_brk(TBROK | TTERRNO, "io_submit() returns %ld, expected %ld",
> > +				TST_RET, nr);
> > +	}
> > +
> > +	tst_syscall(__NR_io_getevents, ctx, 1, 1, &evbuf, &timeout);
> 
> Return value is ignored.
> 
> > +
> > +	if (evbuf.res == -EAGAIN)
> > +		tst_res(TPASS, "io_getevents() returned EAGAIN on read event");
> > +	else
> > +		tst_res(TFAIL | TTERRNO, "io_getevents() returned with %s instead of EAGAIN",
> 
> TTERRNO is not needed.
> 
> > +			strerror(-evbuf.res));
> > +}
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
> 
> 
> 
> 
> -- 
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
