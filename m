Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FABC433EF
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 11:55:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54DA03C985F
	for <ltp@archiver.kernel.org>; Mon, 28 Mar 2022 13:55:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EC7E3C0325
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 13:55:34 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 81419600859
 for <ltp@lists.linux.it>; Mon, 28 Mar 2022 13:55:33 +0200 (CEST)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.53])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KRrjY4VR7z1GD94;
 Mon, 28 Mar 2022 19:55:13 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (7.185.36.93) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Mar 2022 19:55:28 +0800
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 28 Mar 2022 19:55:28 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2308.021; 
 Mon, 28 Mar 2022 19:55:28 +0800
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Thread-Topic: [LTP][PATCH] io_submit01/io_submit02: Bugfix for running with
 the option "-i"
Thread-Index: AdhCmqCyvAmIBsQaRE2cDLEpKKCCEw==
Date: Mon, 28 Mar 2022 11:55:28 +0000
Message-ID: <a24213d10b3c4c2793453e3e2e010bfe@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] io_submit01/io_submit02: Bugfix for running with
 the option "-i"
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
Cc: "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi, 

I am so sorry, the patch is submitted by mistake, please ignore it.

Best regards!

GONGYI

> 
> For io_submit01, add io_destroy before test return, or the test would fail
> and report EAGAIN.
> For io_submit02, move the io_destroy to the suitable location, or the test
> would fail and report EAGAIN.
> 
> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  .../kernel/syscalls/io_submit/io_submit01.c    | 18 ++++++++++++------
>  .../kernel/syscalls/io_submit/io_submit02.c    |  9 ++++++---
>  2 files changed, 18 insertions(+), 9 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/io_submit/io_submit01.c
> b/testcases/kernel/syscalls/io_submit/io_submit01.c
> index 28d93d7f1..7931c583b 100644
> --- a/testcases/kernel/syscalls/io_submit/io_submit01.c
> +++ b/testcases/kernel/syscalls/io_submit/io_submit01.c
> @@ -77,12 +77,6 @@ static struct tcase {
> 
>  static void setup(void)
>  {
> -	TEST(io_setup(1, &ctx));
> -	if (TST_RET == -ENOSYS)
> -		tst_brk(TCONF | TRERRNO, "io_setup(): AIO not supported by
> kernel");
> -	else if (TST_RET)
> -		tst_brk(TBROK | TRERRNO, "io_setup() failed");
> -
>  	io_prep_pread(&inv_fd_iocb, -1, buf, sizeof(buf), 0);
> 
>  	rdonly_fd = SAFE_OPEN("rdonly_file", O_RDONLY | O_CREAT, 0777);
> @@ -116,8 +110,20 @@ static void verify_io_submit(unsigned int n)
>  	struct tcase *t = &tcases[n];
>  	int ret;
> 
> +	memset(&ctx, 0, sizeof(ctx));
> +	TEST(io_setup(1, &ctx));
> +	if (TST_RET == -ENOSYS)
> +		tst_brk(TCONF | TRERRNO, "io_setup(): AIO not supported by
> kernel");
> +	else if (TST_RET)
> +		tst_brk(TBROK | TRERRNO, "io_setup() failed");
> +
>  	ret = io_submit(*t->ctx, t->nr, t->iocbs);
> 
> +	TEST(io_destroy(ctx));
> +	if (TST_RET) {
> +		tst_brk(TBROK | TRERRNO, "io_destroy() failed");
> +	}
> +
>  	if (ret == t->exp_errno) {
>  		tst_res(TPASS, "io_submit() with %s failed with %s",
>  			t->desc, errno_name(t->exp_errno));
> diff --git a/testcases/kernel/syscalls/io_submit/io_submit02.c
> b/testcases/kernel/syscalls/io_submit/io_submit02.c
> index acb42cb8f..ac32d254e 100644
> --- a/testcases/kernel/syscalls/io_submit/io_submit02.c
> +++ b/testcases/kernel/syscalls/io_submit/io_submit02.c
> @@ -54,7 +54,6 @@ static inline void io_prep_option(struct iocb *cb, int
> fd, void *buf,
> 
>  static void setup(void)
>  {
> -	TST_EXP_PASS_SILENT(tst_syscall(__NR_io_setup, 1, &ctx));
>  	fd = SAFE_OPEN(TEST_FILE, O_RDONLY | O_CREAT, MODE);
>  	io_prep_option(&iocb, fd, buf, 0, 0, IOCB_CMD_PREAD);  } @@
> -64,18 +63,22 @@ static void cleanup(void)
>  	if (fd > 0)
>  		SAFE_CLOSE(fd);
> 
> -	if (tst_syscall(__NR_io_destroy, ctx))
> -		tst_brk(TBROK | TERRNO, "io_destroy() failed");
>  }
> 
>  static void run(unsigned int i)
>  {
> +	memset(tc[i].ctx, 0, sizeof(aio_context_t));
> +	TST_EXP_PASS_SILENT(tst_syscall(__NR_io_setup, 1, &ctx));
> +
>  	TEST(tst_syscall(__NR_io_submit, *tc[i].ctx, tc[i].nr, tc[i].iocbs));
> 
>  	if (TST_RET == tc[i].nr)
>  		tst_res(TPASS, "io_submit() %s", tc[i].desc);
>  	else
>  		tst_res(TFAIL, "io_submit() returns %ld, expected %ld", TST_RET,
> tc[i].nr);
> +
> +	if (tst_syscall(__NR_io_destroy, ctx))
> +		tst_brk(TBROK | TERRNO, "io_destroy() failed");
>  }
> 
>  static struct tst_test test = {
> --
> 2.17.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
