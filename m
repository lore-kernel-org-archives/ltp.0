Return-Path: <SRS0=8di7=P4=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D861C433EF
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 16:22:50 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BDCD6103C
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 16:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6BDCD6103C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF1C03C1B0B
	for <ltp@archiver.kernel.org>; Tue,  9 Nov 2021 17:22:46 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52A5B3C0612
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 17:22:33 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EF6E91A00147
 for <ltp@lists.linux.it>; Tue,  9 Nov 2021 17:22:32 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F3B801FD34;
 Tue,  9 Nov 2021 16:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636474951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sKIup5AYEH6TfDrRNI7dU0gT8mcN5DRLGPm8cs4CHIU=;
 b=ZEXMMhW54oRnt2SHaY4BVDfUZ5tIjXUyzB2qiUOqeGUZyu6fU5QTwKjDG8zbE/e78kXkJF
 PyG1YlbjotEk6yOkWQapCjkyZfxSeO8W1Ru3Y1sARny+UjvJpw0cog6Ny7ZnhJ3lX4VSeO
 anjs3n9+ObMzVelLZICxqnLQVnOMhVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636474951;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sKIup5AYEH6TfDrRNI7dU0gT8mcN5DRLGPm8cs4CHIU=;
 b=R5qzuDMTG0GpZdqI+mEXQbCzCHjRlHpW/cy0ewRaTFuOuOPCsYrU/GOmLsu55v89XuRz1d
 PsKH4ZDNVz1X6qBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB43513A63;
 Tue,  9 Nov 2021 16:22:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ylw1NUegimGwMgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 09 Nov 2021 16:22:31 +0000
Date: Tue, 9 Nov 2021 17:23:33 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YYqghWs62gwfQZqR@yuki>
References: <20211109130910.1583233-1-liwang@redhat.com>
 <20211109130910.1583233-2-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211109130910.1583233-2-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/3] testcase: make use of .supported_archs
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
>  static void run(void)
> @@ -58,6 +50,11 @@ static void run(void)
>  	register long mode __asm__("r3");
>  	register long node_mask_ptr __asm__("r4");
>  	register long node_mask_sz __asm__("r5");
> +#else
> +	static const int sys_num = 276;
> +	static const int mode;
> +	static const int node_mask_ptr = UINT_MAX;
> +	static const int node_mask_sz = UINT_MAX;

These shouldn't be static anymore.

>  #endif
>  	char stack_pattern[0x400];
>  
> @@ -78,7 +75,8 @@ static void run(void)
>  		:
>  		"memory", "cr0", "r6", "r7", "r8", "r9", "r10", "r11", "r12");
>  	sys_ret = mode;
> -#else /* __i386__ */
> +#endif
> +#ifdef __i386__
>  	asm volatile (
>  		"add $0x400, %%esp\n\t"
>  		"int $0x80\n\t"
> @@ -114,15 +112,14 @@ static void run(void)
>  
>  static struct tst_test test = {
>  	.test_all = run,
> +	.supported_archs = (const char *const []) {
> +		"i386",
> +		"ppc",

And we should add "ppc64" here as well, right? 

> +		NULL
> +	},
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "cf01fb9985e8"},
>  		{"CVE", "CVE-2017-7616"},
>  		{}
>  	}
>  };

Other than these two:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
