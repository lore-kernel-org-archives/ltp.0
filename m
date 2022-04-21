Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E53C433EF
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 12:14:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF3ED3CA6D4
	for <ltp@archiver.kernel.org>; Thu, 21 Apr 2022 14:14:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57CC13CA6A9
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 14:14:38 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A66B060084E
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 14:14:37 +0200 (CEST)
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Kkbxs3LTBzFqVG
 for <ltp@lists.linux.it>; Thu, 21 Apr 2022 20:12:01 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500007.china.huawei.com (7.192.104.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Apr 2022 20:14:33 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.024; 
 Thu, 21 Apr 2022 20:14:33 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] syscalls/io_submit: Add TTERRNO/TERRNO when test
 fail
Thread-Index: AdhVeP/hrM1nKnobTziHDdDLHwHM/g==
Date: Thu, 21 Apr 2022 12:14:32 +0000
Message-ID: <08dc2928b8de42b39a86789c2ff98dcd@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/io_submit: Add TTERRNO/TERRNO when test
 fail
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
From: zhaogongyi via ltp <ltp@lists.linux.it>
Reply-To: zhaogongyi <zhaogongyi@huawei.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

Thans for your review!

I have resubmit a patch, please see: https://patchwork.ozlabs.org/project/ltp/patch/20220421121016.26958-1-zhaogongyi@huawei.com/

Best wishes!

Gongyi

 
> Hi!
> > >
> > > NACK.
> > >
> > > As far as I can tell the io_submit() calls returns negative error
> > > instead of setting errno, at least that's what libaio documentation
> states.
> >
> > Yes, according to linux manual, libaio interface don't set errno when
> calling failed, so, do we also need to remove the TREENO here?
> >
> > 80         TEST(io_setup(1, &ctx));
> > 81         if (TST_RET == -ENOSYS)
> > 82                 tst_brk(TCONF | TRERRNO, "io_setup(): AIO not
> supported by kernel");
> > 83         else if (TST_RET)
> > 84                 tst_brk(TBROK | TRERRNO, "io_setup() failed");
> 
> Yes please, this should be replaced by manually printing
> tst_strerrno(-TST_RET).
> 
> > > > diff --git a/testcases/kernel/syscalls/io_submit/io_submit02.c
> > > > b/testcases/kernel/syscalls/io_submit/io_submit02.c
> > > > index 38b8555d8..6ba4d99a5 100644
> > > > --- a/testcases/kernel/syscalls/io_submit/io_submit02.c
> > > > +++ b/testcases/kernel/syscalls/io_submit/io_submit02.c
> > > > @@ -79,7 +79,7 @@ static void run(unsigned int i)
> > > >  	if (TST_RET == tc[i].nr)
> > > >  		tst_res(TPASS, "io_submit() %s", tc[i].desc);
> > > >  	else
> > > > -		tst_res(TFAIL, "io_submit() returns %ld, expected %ld",
> TST_RET,
> > > tc[i].nr);
> > > > +		tst_res(TFAIL | TTERRNO, "io_submit() returns %ld,
> > > expected %ld",
> > > > +TST_RET, tc[i].nr);
> > >
> > > The best we can do here is to use tst_strerrno() to print the error
> > > as we do in the io_submit().
> >
> > According to linux manual, call io_submit through syscall, it will set
> errno:
> > 	"If the system call is invoked via syscall(2), then the return value
> follows the usual conventions for indicating an error: -1, with  errno  set
> to  a
> >     (positive) value that indicates the error."
> 
> Ah right, as long as we use the syscall() wrapper the negative error return
> value will be moved to the errno variable by the wrapper, so this part is
> correct.
> 
> --
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
