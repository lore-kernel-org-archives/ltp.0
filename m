Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E5BCD8CA8
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 08:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781253083; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=tTVyttE0Bww9aXH4R+RWLF1JHeJIFFMC7GHA/8jF1Y8=;
 b=k1d+C337QbdiLM8ICX3XVjw3xPo5V7n16qRqXy6wcSeGUYDP8fm1YQgTnW6c8ff7ULZFn
 9PYQCKhoeRyZe/xiX62xYimgBSm7EUEIbt5ZceF/po9k8le3FM8qvfuAb/LURShzmcAi8vM
 o9zSANtNdlVPm6Laz7XHbnlpUZug1uM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 614803E526D
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 10:31:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E6C63C22A5
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:31:03 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B24BB1400967
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:31:02 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-490b613a17bso5396055e9.3
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 01:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781253062; x=1781857862; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SPBph18nmyfDz43tK4J8UGQ+Kg76hBnzf52Mk08ckms=;
 b=TunqH8eDZAZevRIV7xUvH0Bw2S3FyZUBSD4mNGH4j4ZL1oyvnEOmB1GdCw0LzI72h8
 jaIis1Aki4RV1N+Ege8VwvndtdR7s/qEs373rrPjixcm/H7x9Hy/KqAVbBAq2E2k6bMp
 SJXMNWQu83VdpV8WhuK4dj1tzpocxVTgMItVrv2QsflCftzFz670zYU4bP4kYu3D8sJm
 lFIfMxTQx3ZQmWXEgnB2C27uZq9CQWgkVwoa03kNagcORud4lD+G3nDdkWeO1HDZUQ96
 /B0v1xiYD+s5hLSIH05MtSsKsbN6+6v2zvv/g5608oJAOMqefwXdwyaW/YEB+8HgV21E
 ISEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781253062; x=1781857862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SPBph18nmyfDz43tK4J8UGQ+Kg76hBnzf52Mk08ckms=;
 b=NTQURwAaZZf6UbWkpziAmoUupxrA+Gr/FOkmvDKKETQvEYEK0ifjUbMm72dDK8wfyE
 R5b9JMiQ74iDf0EFyBcdM0FFBih0J8Csu+n9yLnObyA3egfVwTXP5imDPHwcU1BRykln
 c/3TeN7OBpHt7Ke1X9WW+6eeWvYk8Hq03tYdiTW1VWZJVBERQrGlPLGmyA4pLQorgr97
 IP+7+M2LQhSyxoHLwxPg5MH+sn4yHLcVScWlE3hpyWi7C/8xjWeclVAOjdWa33gGi6c6
 RRmXUwiJxU48U+SjgYWH/s5xjYSCNuoE0rs2E/4jO/eyw6wuDvZey82qWMJKgLkVMMFK
 1xsg==
X-Gm-Message-State: AOJu0Yw+SMbrK1T0aXEPXb8/LyDrIV4CbeNPOXDGGt5Wr4eOVfNNOiI7
 QlYUupWamXppXBlT8CLqVYUl//6mNqYDTHhhSqhemdGcyvV7UkBsOCx6zbyHEbz96g==
X-Gm-Gg: Acq92OHhlzBjBByakDoq6G7br9S2RF+C/NRpISYgNzZuUkHsd6eKdlr3oZbd2VrSS4r
 49D0k32CNUxPAS1I3+OO0/cMExKzAOZoyn4C6YPqMRIzbxkiRqn36oYy83h0IwtCRhfHL+OX79C
 hv1WpJ5UowV1887UdQAag6OHU476O73Gp/dJ2VZ/jQG0aIyCXLK87IiZLR7Xlyoo0YRPMzkVcPE
 kIoGKDYTtfk7RmhzY91L4ezCSd08qdbVcnhVAlwyei/7mwB0FMQgQIRygVEi8qyCFxv8Qkery7l
 xPB+WFwNyESCTHY+T3F427LHSFT2XMH/26XuK81jIG9PVlkaieWiracR2lO4IUEY9LDGgtgBf9Y
 fnLrUC2QaQl1nyl1C9wQDTyaP4B2VsFGwb7iXOSQjftzkzYWeme2M1vdRGLzbdKmei5Cv30t4cI
 2jFX1ZU1WwxCyXcGwwGfaJNa99RFuFVk5qVKKyLRvR
X-Received: by 2002:a05:600d:6444:20b0:490:48b7:c1ff with SMTP id
 5b1f17b1804b1-490ec501c82mr14891735e9.17.1781253061731; 
 Fri, 12 Jun 2026 01:31:01 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2e6a8fsm3617213f8f.37.2026.06.12.01.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 01:31:01 -0700 (PDT)
Date: Fri, 12 Jun 2026 08:31:00 +0000
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aivDxMGOaKOwmKQ2@autotest-wegao.qe.prg2.suse.org>
References: <20260611-fix_clone11_min_kver-v1-1-264fba2b01b4@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260611-fix_clone11_min_kver-v1-1-264fba2b01b4@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] clone11: skip CLONE_NEWCGROUP on kernels < 4.6
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jun 11, 2026 at 04:03:15PM +0200, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> CLONE_NEWCGROUP was added in kernel v4.6. On older kernels such as
> v4.4, the flag is unknown and clone() returns EINVAL instead of the
> expected EPERM, causing a spurious test failure.
> 
> Add a per-test-case minimum kernel version check so that the
> CLONE_NEWCGROUP case reports TCONF on kernels older than 4.6.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/syscalls/clone/clone11.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/clone/clone11.c b/testcases/kernel/syscalls/clone/clone11.c
> index 028da778158de6867a71ac3974f9c2263481d3a3..607e42585fad41784be9104be01f504218559342 100644
> --- a/testcases/kernel/syscalls/clone/clone11.c
> +++ b/testcases/kernel/syscalls/clone/clone11.c
> @@ -21,9 +21,10 @@ static int *child_pid;
>  static struct tcase {
>  	uint64_t flags;
>  	const char *sflags;
> +	int min_kver[3];
>  } tcases[] = {
>  	{ DESC(CLONE_NEWPID) },
> -	{ DESC(CLONE_NEWCGROUP) },
> +	{ DESC(CLONE_NEWCGROUP), .min_kver = {4, 6, 0} },
>  	{ DESC(CLONE_NEWIPC) },
>  	{ DESC(CLONE_NEWNET) },
>  	{ DESC(CLONE_NEWNS) },
> @@ -40,6 +41,13 @@ static void run(unsigned int n)
>  {
>  	struct tcase *tc = &tcases[n];
>  
> +	if (tc->min_kver[0] &&
> +	    tst_kvercmp(tc->min_kver[0], tc->min_kver[1], tc->min_kver[2]) < 0) {
> +		tst_res(TCONF, "clone(%s) needs kernel %d.%d+",
> +			tc->sflags, tc->min_kver[0], tc->min_kver[1]);
> +		return;
> +	}
> +
>  	TST_EXP_FAIL(ltp_clone(tc->flags, child_fn, NULL, CHILD_STACK_SIZE, child_stack),
>  		EPERM, "clone(%s) should fail with EPERM",
>  		tc->sflags);
> 
> ---
> base-commit: a375e8deed471723f5a0114c56eb48fe6f6f45d3
> change-id: 20260611-fix_clone11_min_kver-394cf499c2c7
> 
> Best regards,
> -- 
> Andrea Cervesato <andrea.cervesato@suse.com>
> 
Reviewed-by: Wei Gao <wegao@suse.com>
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
