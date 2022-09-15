Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22937ECAAD3
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 09:47:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 388083CAC28
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 11:47:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07D133CAB9C
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 11:47:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5E28860054C
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 11:47:27 +0200 (CEST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 20BEA21C5F;
 Thu, 15 Sep 2022 09:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663235247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I1WyijWK0Txaixyv2WtLU7S2L8oAjrXljdeMgs9NLLQ=;
 b=uSSYrBSDPjBA0aCdvwGHqPtjKQimMMgDQbEbifGr/JhHcv/SYKGNoPrnqtCOQ8EuRJ1Oe7
 0OFP5VUv9zBqRjpWVH0pPSqCLlKWH1FZLzB1+AfGrTQ6CHgMH9AyBmfzUP6HUAOfIJsgPr
 hQBz0fVK9/3ldOp0qEumqwPbKXLlswY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663235247;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I1WyijWK0Txaixyv2WtLU7S2L8oAjrXljdeMgs9NLLQ=;
 b=klHcy70YRyvivKxzw5iu5GwoGfVoBvNPzd0CRFxD6coK2JhqBaCcyPzn9Cvar7ROjxsEdc
 H0prkiTFWZ+74bBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id F420613310;
 Thu, 15 Sep 2022 09:47:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id 3lXXOq70ImOZJwAAGKfGzw
 (envelope-from <chrubis@suse.cz>); Thu, 15 Sep 2022 09:47:26 +0000
Date: Thu, 15 Sep 2022 11:49:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <YyL1JKnf/tnapqN2@yuki>
References: <20220915062715.233884-1-zhaogongyi@huawei.com>
 <20220915062715.233884-2-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220915062715.233884-2-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/io_uring: Add .needs_kconfigs
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
> Add .needs_kconfigs for io_uring01.c/io_uring02.c.

We do call io_uring_supported_by_kernel() in the setup() of these tests
so this shouldn't be needed at all. What is the problem you are trying
to fix?

> Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> ---
>  testcases/kernel/syscalls/io_uring/io_uring01.c | 4 ++++
>  testcases/kernel/syscalls/io_uring/io_uring02.c | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/io_uring/io_uring01.c b/testcases/kernel/syscalls/io_uring/io_uring01.c
> index 70151bb85..cb1cabcb7 100644
> --- a/testcases/kernel/syscalls/io_uring/io_uring01.c
> +++ b/testcases/kernel/syscalls/io_uring/io_uring01.c
> @@ -261,6 +261,10 @@ static struct tst_test test = {
>  	.test = run,
>  	.needs_tmpdir = 1,
>  	.tcnt = ARRAY_SIZE(tcases),
> +	.needs_kconfigs = (const char *const[]){
> +		"CONFIG_IO_URING=y",
> +		NULL
> +	},
>  	.bufs = (struct tst_buffers []) {
>  		{&iov, .iov_sizes = (int[]){BLOCK_SZ, -1}},
>  		{}
> diff --git a/testcases/kernel/syscalls/io_uring/io_uring02.c b/testcases/kernel/syscalls/io_uring/io_uring02.c
> index c5c770074..c7ea87ae5 100644
> --- a/testcases/kernel/syscalls/io_uring/io_uring02.c
> +++ b/testcases/kernel/syscalls/io_uring/io_uring02.c
> @@ -255,6 +255,10 @@ static struct tst_test test = {
>  		TST_CAP(TST_CAP_REQ, CAP_SYS_CHROOT),
>  		{}
>  	},
> +	.needs_kconfigs = (const char *const[]){
> +		"CONFIG_IO_URING=y",
> +		NULL
> +	},
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "9392a27d88b9"},
>  		{"linux-git", "ff002b30181d"},
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
