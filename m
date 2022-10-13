Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EDFC433FE
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 07:46:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7B323CAECF
	for <ltp@archiver.kernel.org>; Thu, 13 Oct 2022 09:46:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57E723CA9C7
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 09:45:56 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A9DEB600713
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 09:45:54 +0200 (CEST)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mp1fc38fqzmV5w
 for <ltp@lists.linux.it>; Thu, 13 Oct 2022 15:41:12 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 15:45:48 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Thu, 13 Oct 2022 15:45:48 +0800
To: Petr Vorel <pvorel@suse.cz>
Thread-Topic: [LTP] [PATCH 2/2] needs_root: Add setting of needs_root
Thread-Index: Adje14jwnnXUZkrLTke9bcwq+JEUKQ==
Date: Thu, 13 Oct 2022 07:45:48 +0000
Message-ID: <04dbdaf51ae940289775353f0535c4a4@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] needs_root: Add setting of needs_root
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

Hi Petr,

It is failed on my system:

sh-4.4$ ./msgget03
tst_test.c:1535: TINFO: Timeout per run is 0h 00m 30s
msgget03.c:42: TINFO: Current environment 0 message queues are already in use
msgget03.c:45: TBROK: Failed to open FILE '/proc/sys/kernel/msgmni' for writing: EACCES (13)

Summary:
passed   0
failed   0
broken   1
skipped  0
warnings 0
tst_sys_conf.c:118: TWARN: Failed to open FILE '/proc/sys/kernel/msgmni'

> > Add setting of  needs_root, otherwise run the test without root will
> > fail and report EACCESS or EPERM.
> ...
> >  testcases/kernel/syscalls/bind/bind06.c                       | 1 +
> >  testcases/kernel/syscalls/cma/process_vm_readv02.c            | 1
> +
> >  testcases/kernel/syscalls/cma/process_vm_readv03.c            | 1
> +
> >  testcases/kernel/syscalls/cma/process_vm_writev02.c           | 1
> +
> >  testcases/kernel/syscalls/copy_file_range/copy_file_range01.c | 1 +
> >  testcases/kernel/syscalls/ipc/msgget/msgget03.c               | 1 +
> >  testcases/kernel/syscalls/preadv/preadv03.c                   | 1 +
> >  testcases/kernel/syscalls/pwritev/pwritev03.c                 | 1 +
> >  testcases/kernel/syscalls/sendto/sendto03.c                   | 1 +
> >  testcases/kernel/syscalls/setsockopt/setsockopt05.c           | 1 +
> >  testcases/kernel/syscalls/setsockopt/setsockopt06.c           | 1 +
> >  testcases/kernel/syscalls/setsockopt/setsockopt07.c           | 1 +
> >  testcases/kernel/syscalls/setsockopt/setsockopt08.c           | 1 +
> >  testcases/kernel/syscalls/setsockopt/setsockopt09.c           | 1 +
> >  testcases/kernel/syscalls/swapon/swapon01.c                   | 1
> +
> >  15 files changed, 15 insertions(+)
> ...
> > +++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
> > @@ -72,6 +72,7 @@ static void cleanup(void)
> 
> >  static struct tst_test test = {
> >  	.needs_tmpdir = 1,
> > +	.needs_root = 1,
> >  	.setup = setup,
> >  	.cleanup = cleanup,
> >  	.test_all = verify_msgget,
> 
> At least this one is working without root:
> 
> $ ./testcases/kernel/syscalls/ipc/msgget/msgget03
> tst_test.c:1526: TINFO: Timeout per run is 0h 00m 30s
> msgget03.c:41: TINFO: Current environment 0 message queues are
> already in use
> msgget03.c:55: TINFO: The maximum number of message queues (32000)
> reached
> msgget03.c:30: TPASS: msgget(1629588886, 1536) : ENOSPC (28)
> 
> Summary:
> passed   1
> failed   0
> broken   0
> skipped  0
> warnings 0
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
