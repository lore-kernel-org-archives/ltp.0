Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCD9C433F5
	for <ltp@archiver.kernel.org>; Tue,  5 Apr 2022 14:07:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82D993CA460
	for <ltp@archiver.kernel.org>; Tue,  5 Apr 2022 16:07:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AA3D3C08E2
 for <ltp@lists.linux.it>; Tue,  5 Apr 2022 16:07:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9941A1400DC9
 for <ltp@lists.linux.it>; Tue,  5 Apr 2022 16:07:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A6D101F38D;
 Tue,  5 Apr 2022 14:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1649167650;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ht3HCCNN8rLuyMVfrchL+Anx/CUyR13jtiY1e0MAFk=;
 b=GiWGL6RB9q4cPAh7oYquZsYhV7UNOvqQT11/c4FvR1ZtuT0CYTCnnDFDnW86LN+FB9iLUq
 tP3ZbJyt+I3KGOC83qcTlVLtxK5lmf+ovslAsDB9Gunue+6QB+MLhAJHzrR/cU+Qyf8Q71
 SysdjoaUOoBYZPSQk/E8/HfxpMLZrfk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1649167650;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7ht3HCCNN8rLuyMVfrchL+Anx/CUyR13jtiY1e0MAFk=;
 b=VBXx+Gj1ocyJrC2U7Dkt1uEkh9iJJDf25xm4SnTQw8why1Z8btxB31My08bj5QddIodObq
 CjMeqoHaujlK73Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A116B13522;
 Tue,  5 Apr 2022 14:07:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KRv/HSBNTGLKRAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 05 Apr 2022 14:07:28 +0000
Date: Tue, 5 Apr 2022 16:07:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <YkxNEjvaLAsWZSaq@pevik>
References: <20220328114921.182315-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220328114921.182315-1-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: viresh.kumar@linaro.org, Martin Doucha <martin.doucha@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> For io_submit01, add io_destroy before test return, or the test
> would fail and report EAGAIN.
> For io_submit02, move the io_destroy to the suitable location, or
> the test would fail and report EAGAIN.

$ ./io_submit01 -i150
...
io_submit01.c:122: TPASS: io_submit() with NULL iocb pointers failed with EFAULT
io_submit01.c:127: TFAIL: io_submit() returned -11(EAGAIN/EWOULDBLOCK), expected EBADF(-9)
io_submit01.c:127: TFAIL: io_submit() returned -11(EAGAIN/EWOULDBLOCK), expected EBADF(-9)
io_submit01.c:127: TFAIL: io_submit() returned -11(EAGAIN/EWOULDBLOCK), expected EBADF(-9)
io_submit01.c:127: TFAIL: io_submit() returned -11(EAGAIN/EWOULDBLOCK), expected SUCCESS(1)

$ ./io_submit02 -i150
...
io_submit02.c:76: TPASS: io_submit() returns 0 if nr is zero
io_submit02.c:78: TFAIL: io_submit() returns -1, expected 1

@Cyril, Li, Martin, Viresh: while this fix is valid using memset() (which is required)
slows down testing a lot. Any idea whether this can be avoid to keep the speed?

Kind regards,
Petr

> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  .../kernel/syscalls/io_submit/io_submit01.c    | 18 ++++++++++++------
>  .../kernel/syscalls/io_submit/io_submit02.c    |  9 ++++++---
>  2 files changed, 18 insertions(+), 9 deletions(-)

> diff --git a/testcases/kernel/syscalls/io_submit/io_submit01.c b/testcases/kernel/syscalls/io_submit/io_submit01.c
> index 28d93d7f1..7931c583b 100644
> --- a/testcases/kernel/syscalls/io_submit/io_submit01.c
> +++ b/testcases/kernel/syscalls/io_submit/io_submit01.c
> @@ -77,12 +77,6 @@ static struct tcase {

>  static void setup(void)
>  {
> -	TEST(io_setup(1, &ctx));
> -	if (TST_RET == -ENOSYS)
> -		tst_brk(TCONF | TRERRNO, "io_setup(): AIO not supported by kernel");
> -	else if (TST_RET)
> -		tst_brk(TBROK | TRERRNO, "io_setup() failed");
> -
>  	io_prep_pread(&inv_fd_iocb, -1, buf, sizeof(buf), 0);

>  	rdonly_fd = SAFE_OPEN("rdonly_file", O_RDONLY | O_CREAT, 0777);
> @@ -116,8 +110,20 @@ static void verify_io_submit(unsigned int n)
>  	struct tcase *t = &tcases[n];
>  	int ret;

> +	memset(&ctx, 0, sizeof(ctx));
> +	TEST(io_setup(1, &ctx));
> +	if (TST_RET == -ENOSYS)
> +		tst_brk(TCONF | TRERRNO, "io_setup(): AIO not supported by kernel");
> +	else if (TST_RET)
> +		tst_brk(TBROK | TRERRNO, "io_setup() failed");
> +
>  	ret = io_submit(*t->ctx, t->nr, t->iocbs);

> +	TEST(io_destroy(ctx));
> +	if (TST_RET) {
> +		tst_brk(TBROK | TRERRNO, "io_destroy() failed");
> +	}
> +
>  	if (ret == t->exp_errno) {
>  		tst_res(TPASS, "io_submit() with %s failed with %s",
>  			t->desc, errno_name(t->exp_errno));
> diff --git a/testcases/kernel/syscalls/io_submit/io_submit02.c b/testcases/kernel/syscalls/io_submit/io_submit02.c
> index acb42cb8f..ac32d254e 100644
> --- a/testcases/kernel/syscalls/io_submit/io_submit02.c
> +++ b/testcases/kernel/syscalls/io_submit/io_submit02.c
> @@ -54,7 +54,6 @@ static inline void io_prep_option(struct iocb *cb, int fd, void *buf,

>  static void setup(void)
>  {
> -	TST_EXP_PASS_SILENT(tst_syscall(__NR_io_setup, 1, &ctx));
>  	fd = SAFE_OPEN(TEST_FILE, O_RDONLY | O_CREAT, MODE);
>  	io_prep_option(&iocb, fd, buf, 0, 0, IOCB_CMD_PREAD);
>  }
> @@ -64,18 +63,22 @@ static void cleanup(void)
>  	if (fd > 0)
>  		SAFE_CLOSE(fd);

> -	if (tst_syscall(__NR_io_destroy, ctx))
> -		tst_brk(TBROK | TERRNO, "io_destroy() failed");
>  }

>  static void run(unsigned int i)
>  {
> +	memset(tc[i].ctx, 0, sizeof(aio_context_t));
> +	TST_EXP_PASS_SILENT(tst_syscall(__NR_io_setup, 1, &ctx));
> +
>  	TEST(tst_syscall(__NR_io_submit, *tc[i].ctx, tc[i].nr, tc[i].iocbs));

>  	if (TST_RET == tc[i].nr)
>  		tst_res(TPASS, "io_submit() %s", tc[i].desc);
>  	else
>  		tst_res(TFAIL, "io_submit() returns %ld, expected %ld", TST_RET, tc[i].nr);
> +
> +	if (tst_syscall(__NR_io_destroy, ctx))
> +		tst_brk(TBROK | TERRNO, "io_destroy() failed");
>  }

>  static struct tst_test test = {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
