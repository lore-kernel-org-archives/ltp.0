Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D1AC433EF
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 10:51:23 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57F3261214
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 10:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 57F3261214
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F24183C8A2B
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 11:51:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 127E13C1824
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 11:51:10 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0E5E31001450
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 11:51:09 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 294B4212CC;
 Fri, 19 Nov 2021 10:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637319069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LUG39Goqk4t0TE/OBmZH5rbLfGAwgMdR5ChwCZpCFXE=;
 b=1O7NIHWMfIGZMsFapktdhvroTGUAYEneg1YJlvkndzd91f6iPfI6E8tg68JMXC5sJWaRoI
 XTszQ4UPUFVvgKeFEsSvBxVumWBz/leudXMcTn4j7DG4lEy8LKRBIL2+Xd6arJ2ktah33S
 NCkn6Sz83+fiRSDwulBANFYi0S2XSTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637319069;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LUG39Goqk4t0TE/OBmZH5rbLfGAwgMdR5ChwCZpCFXE=;
 b=SguPkmS7D/eY4VjswtAUtvhAk07rWYucOEZds2hMjBX7P/a68oIm3FQhUI0QP+84pTdFB2
 Nfme+W87l95eRtBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DBEFB13A8A;
 Fri, 19 Nov 2021 10:51:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OyRnNJyBl2EOGgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 19 Nov 2021 10:51:08 +0000
Date: Fri, 19 Nov 2021 11:52:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YZeB3uZAXqz0Phkk@yuki>
References: <1637310522-19620-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1637310522-19620-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/statx01: Fix compiler warning
 because of PRIu64
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
> warning: format ???%lu??? expects argument of type ???long unsigned int???,
> but argument 5 has type ???__u64??? {aka ???long long unsigned int???}

This is strange, the stx_size is either defined as uint64_t in our
fallback code or as __u64 in the system headers. It should really match
the PRIu64.

I see the warnings on my system as well, it looks like
/usr/include/asm-generic/int-ll64.h is used even on 64bit system e.g.
x86_64 that does not make any sense.

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/statx/statx01.c | 8 ++++----
>  testcases/kernel/syscalls/statx/statx02.c | 4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/statx/statx01.c b/testcases/kernel/syscalls/statx/statx01.c
> index 2358dd7bc..1289366b9 100644
> --- a/testcases/kernel/syscalls/statx/statx01.c
> +++ b/testcases/kernel/syscalls/statx/statx01.c
> @@ -79,11 +79,11 @@ static void test_normal_file(void)
>  
>  	if (buff.stx_size == SIZE)
>  		tst_res(TPASS,
> -			"stx_size(%"PRIu64") is correct", buff.stx_size);
> +			"stx_size(%"PRIu64") is correct", (uint64_t)buff.stx_size);
>  	else
>  		tst_res(TFAIL,
>  			"stx_size(%"PRIu64") is different from expected(%u)",
> -			buff.stx_size, SIZE);
> +			(uint64_t)buff.stx_size, SIZE);
>  
>  	if ((buff.stx_mode & ~(S_IFMT)) == MODE)
>  		tst_res(TPASS, "stx_mode(%u) is correct", buff.stx_mode);
> @@ -94,10 +94,10 @@ static void test_normal_file(void)
>  
>  	if (buff.stx_blocks <= buff.stx_blksize/512 * 2)
>  		tst_res(TPASS, "stx_blocks(%"PRIu64") is valid",
> -			buff.stx_blocks);
> +			(uint64_t)buff.stx_blocks);
>  	else
>  		tst_res(TFAIL, "stx_blocks(%"PRIu64") is invalid",
> -			buff.stx_blocks);
> +			(uint64_t)buff.stx_blocks);
>  
>  }
>  
> diff --git a/testcases/kernel/syscalls/statx/statx02.c b/testcases/kernel/syscalls/statx/statx02.c
> index 08ea940cb..63133a3b7 100644
> --- a/testcases/kernel/syscalls/statx/statx02.c
> +++ b/testcases/kernel/syscalls/statx/statx02.c
> @@ -50,11 +50,11 @@ static void test_empty_path(void)
>  
>  	if (buf.stx_size == SIZE)
>  		tst_res(TPASS,
> -			"stx_size(%"PRIu64") is correct", buf.stx_size);
> +			"stx_size(%"PRIu64") is correct", (uint64_t)buf.stx_size);
>  	else
>  		tst_res(TFAIL,
>  			"stx_size(%"PRIu64") is not same as expected(%u)",
> -			buf.stx_size, SIZE);
> +			(uint64_t)buf.stx_size, SIZE);
>  
>  }
>  
> -- 
> 2.23.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
