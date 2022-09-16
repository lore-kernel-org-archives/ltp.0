Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E691C32771
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 02:08:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FC023CAC43
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 04:08:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87C2B3CA493
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 04:08:38 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C75981A011D6
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 04:08:36 +0200 (CEST)
Received: from canpemm100008.china.huawei.com (unknown [172.30.72.56])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MTHVr6JwPzBsPQ
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 10:06:28 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm100008.china.huawei.com (7.192.104.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 16 Sep 2022 10:08:32 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Fri, 16 Sep 2022 10:08:32 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH 2/2] io_uring.h: Remove
 io_uring_setup_supported_by_kernel()
Thread-Index: AdjJcJEWmDtKxLTaT46Yw7yjjUQLfA==
Date: Fri, 16 Sep 2022 02:08:32 +0000
Message-ID: <bd217dfee38d4c4ebdf9589e20b0613a@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] io_uring.h: Remove
 io_uring_setup_supported_by_kernel()
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

> Hi!
> > diff --git a/include/lapi/io_uring.h b/include/lapi/io_uring.h index
> > 397324511..43d28f74a 100644
> > --- a/include/lapi/io_uring.h
> > +++ b/include/lapi/io_uring.h
> > @@ -297,14 +297,22 @@ static inline int io_uring_enter(int fd,
> > unsigned int to_submit,  static inline void
> > io_uring_setup_supported_by_kernel(void)
> >  {
> >         long ret;
> > +
> > +       ret = syscall(__NR_io_uring_setup, NULL, 0);
> > +
> > +       if (ret != -1) {
> > +               SAFE_CLOSE(ret);
> > +               return;
> > +       }
> > +
> >         if ((tst_kvercmp(5, 1, 0)) < 0) {
> > -               ret = syscall(__NR_io_uring_setup, NULL, 0);
> > -               if (ret != -1)
> > -                       SAFE_CLOSE(ret);
> > -               else if (errno == ENOSYS)
> > +               if (errno == ENOSYS)
> >                         tst_brk(TCONF,
> >                                 "Test not supported on kernel
> version < v5.1");
> >         }
> > +
> > +       if (errno == ENOSYS)
> 
> Based on your latest reply this should be EOPNOTSUPP.

The errno is ENOSYS when CONFIG_IO_URING is not set. My system is different with the linux upstream. 

Thanks, I have resubmit a new patch as your suggestion, please see: https://patchwork.ozlabs.org/project/ltp/patch/20220916015948.156798-1-zhaogongyi@huawei.com/


> 
> > +               tst_brk(TCONF, "CONFIG_IO_URING not set?");
> >  }
> >
> >
> > --
> > Cyril Hrubis
> > chrubis@suse.cz
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> --
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
