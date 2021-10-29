Return-Path: <SRS0=M8Fp=PR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19217C433F5
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 12:07:33 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66E1D60E73
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 12:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 66E1D60E73
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C8B023C6EED
	for <ltp@archiver.kernel.org>; Fri, 29 Oct 2021 14:07:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8BEE73C135F
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 14:07:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7E269140B9D2
 for <ltp@lists.linux.it>; Fri, 29 Oct 2021 14:07:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 91B861FD5C;
 Fri, 29 Oct 2021 12:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635509238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XSeMgMY2tFL1jYzxKB3seR7TSZcO+KHYIjxZ7S0uQfY=;
 b=YMj+AGoDDhVRiMokGWj7n1zBpsDjj+r9OnSkeNNPUj1Yi3Qtxd4UHs6revBHOursx0rSUb
 EqxXx+yiS0Wdb5KevvIfYvirbz1Y0qn2ueQUKlHYodFaq4XDMAeyZPSGtkBFD/nXFpLKY0
 7iqqqKyYDE9IRrxnEY0iQ/GWrRQy/Vs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635509238;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XSeMgMY2tFL1jYzxKB3seR7TSZcO+KHYIjxZ7S0uQfY=;
 b=Maj0wfl/eptplWl8vgEDnHc0sK5GKwSaEs7eND7Ag8+L7hdQMCnKTAaW/FNwTauw+i/diX
 sS8E3rYPCr2QCMCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7C52313D35;
 Fri, 29 Oct 2021 12:07:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id G3ukHPbje2EFegAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 29 Oct 2021 12:07:18 +0000
Date: Fri, 29 Oct 2021 14:08:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <YXvkKoM1VBsihn+y@yuki>
References: <20211028031422.208689-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211028031422.208689-1-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/epoll_create: Replace syscall to libc
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> For epoll_create01.c/epoll_create02.c, we should replace syscall to libc
> or the testcase will fail because of Syscall epoll_create is not support
> in some arches.

I guess that epoll_create() is emulated via epoll_create1() in these
cases right?

Does these testcases fail in these cases though? The __NR_epoll_create
should be set to -1 when the syscall is not supported and the test
should be skipped with TCONF.

The patch looks good, however it would be slightly better to add test
variants so that we call both the raw syscall, if available, and the
glibc wrapper, with something as:


static int do_epoll_create(int size)
{
	switch (tst_variant) {
	case 0:
		return tst_syscall(__NR_epoll_create, size);
	break;
	case 1:
		return epoll_create(size);
	break;
}

static void run(unsigned int n)
{
	TST_EXP_FD(do_epoll_create(tc[n]) ...);

	...
}

static void setup(void)
{
	switch (tst_variant) {
	case 0:
		tst_res(TINFO, "Testing variant: syscall __NR_epoll_create");
	break;
	case 1:
		tst_res(TINFO, "Testing variant: libc epoll_create()");
	break;
	}
}

static struct tst_test test = {
	...
	.test_variants = 2,
	...
};


> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  testcases/kernel/syscalls/epoll_create/epoll_create01.c | 2 +-
>  testcases/kernel/syscalls/epoll_create/epoll_create02.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/epoll_create/epoll_create01.c b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
> index 3ef5b5cac..b6ebe9ad7 100644
> --- a/testcases/kernel/syscalls/epoll_create/epoll_create01.c
> +++ b/testcases/kernel/syscalls/epoll_create/epoll_create01.c
> @@ -24,7 +24,7 @@ static int tc[] = {1, INT_MAX};
> 
>  static void run(unsigned int n)
>  {
> -	TST_EXP_FD(tst_syscall(__NR_epoll_create, tc[n]), "epoll_create(%d)", tc[n]);
> +	TST_EXP_FD(epoll_create(tc[n]), "epoll_create(%d)", tc[n]);
> 
>  	if (!TST_PASS)
>  		return;
> diff --git a/testcases/kernel/syscalls/epoll_create/epoll_create02.c b/testcases/kernel/syscalls/epoll_create/epoll_create02.c
> index c59ea7944..e96228983 100644
> --- a/testcases/kernel/syscalls/epoll_create/epoll_create02.c
> +++ b/testcases/kernel/syscalls/epoll_create/epoll_create02.c
> @@ -27,7 +27,7 @@ static struct test_case_t {
> 
>  static void run(unsigned int n)
>  {
> -	TST_EXP_FAIL(tst_syscall(__NR_epoll_create, tc[n].size),
> +	TST_EXP_FAIL(epoll_create(tc[n].size),
>  		     tc[n].exp_err, "create(%d)", tc[n].size);
>  }
> 
> --
> 2.17.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
