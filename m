Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC53C27C53
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 23:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1717630813; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=HQoPF95LY5089YWwNOcXKOAh8hSxcMgGaVJXOGSbcXs=;
 b=XLfQib2s8ysredmYm+RBvamtKcneifvTnDMToznKU/VI6NglKJeEV5fePNZRgIvj4Hsf5
 ke4WL82rpEI3qF6UYXS4noHzbq2jDX4t9lYdKNiUZvfAfP1Ze1dGvnaBzpzGCjG4rpe7JvD
 B3CWvwlwBBsovio2UhH5GeYh0/e69MM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8213D3D09CD
	for <ltp@archiver.kernel.org>; Thu,  6 Jun 2024 01:40:13 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30DD73D07E8
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 01:39:49 +0200 (CEST)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 925B1600C98
 for <ltp@lists.linux.it>; Thu,  6 Jun 2024 01:39:48 +0200 (CEST)
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2e78fe9fc2bso5103351fa.3
 for <ltp@lists.linux.it>; Wed, 05 Jun 2024 16:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1717630788; x=1718235588; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vhQcHebs8OzBt2ZKrKjK9d9Zg4nzoIZt1LctReUq5b0=;
 b=CFIm6Cid7zXd4bchCl45OjckLDgKcip3HRKi0cbcuGo4se7CczSr2sKEAtjSYleW5c
 g79ZZgU0bt7eQa+Zj0UL9EHpba5uhVlbyVkcNMND1V+p6FCyN/L33aYF0rCiX+VcDd+b
 acrecLi1xoTVMwjKyhAk7wg/+/13M8x8UDghmKfC0Ork15XmEwrgxyWC8VqNn1tr9hBT
 Mlwuf8VIJ0zMnxT0pdsEttjBPKRxF3YH0tgh9FsAfY/Mede1gIDG+ZdpuYZem1k65Yv6
 4sGg0NxsVakBSBQsJaynuR1t1Yqu6NG4CMLQntVpOvyOZ8L67+5d2CiZSXfcZ8EtjblE
 TmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630788; x=1718235588;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vhQcHebs8OzBt2ZKrKjK9d9Zg4nzoIZt1LctReUq5b0=;
 b=hUMhUJJNrIvUmjukk3PrfT5mGQGbMQW8v8OPpz4/C0sMbxqmz811YeXa9ij+fiIBbI
 +VOSy8BQp5Nsx6GmL/zZZFpaNmdliLSGNCv5lkV7Ka4Y8SIAMvU7zn3UnRbOs7Ooto49
 CmfuRTry4eywWj81h+2Hvl2Sn9RSb8AFtVrPnHZ5XVz/o4Rg1SqwxO6CIi/c4OinK+pF
 noPbxAZ8g2cjNnlzsCrizT0fsFMWGPCp4dFDZNpQGEgpUYgUSiSJrSwPYUu6wCNIE9S7
 yChXAtI40wz6IrWpX0RZKqoyaICKny94pDyIfnJWXHYoBXKgtagFzIscxk9ah8XR69JI
 tmMw==
X-Gm-Message-State: AOJu0YxitsdhkxcT0eIMAadN3qxtlQUE9frvv/1fh5hExll/0mCwaPap
 pbOTomLxCTEzULMycvanYS5TPNB5H7kvZ7W+yc/X8C7n/0YlO0FtJn97vRucgg==
X-Google-Smtp-Source: AGHT+IFdS9KZ7ko8AqnhWF/svYqtWhMjgJ8e9sloL80rptMqGt60pkEo3ExEanc7eps3SRgvSrWjpg==
X-Received: by 2002:a2e:854c:0:b0:2ea:8174:231b with SMTP id
 38308e7fff4ca-2eac79ba392mr19906801fa.2.1717630787656; 
 Wed, 05 Jun 2024 16:39:47 -0700 (PDT)
Received: from wegao.102.90.21 ([2a07:de40:b240:0:dc1a:df90:dc1a:df90])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd76ab9bsm1057655ad.71.2024.06.05.16.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:39:47 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:39:31 -0400
To: Edward Liaw <edliaw@google.com>
Message-ID: <ZmD3MwUF0gckTlo8@wegao.102.90.21>
References: <20240605180536.1288027-1-edliaw@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240605180536.1288027-1-edliaw@google.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched/starvation: Choose from available cpus
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
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jun 05, 2024 at 06:05:36PM +0000, Edward Liaw via ltp wrote:
> Use the first available cpu in the sched_getaffinity set.
> 
> This test was failing as a 32bit test for some arm architectures where
> cpu 0 does not support 32bit applications.
> 
> Signed-off-by: Edward Liaw <edliaw@google.com>
> ---
>  .../kernel/sched/cfs-scheduler/starvation.c     | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
> index eb9fd6ff5..e0ea30d19 100644
> --- a/testcases/kernel/sched/cfs-scheduler/starvation.c
> +++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
> @@ -49,13 +49,28 @@ again:
>  static void setup(void)
>  {
>  	cpu_set_t mask;
> +	int cpu = 0;
> +	long ncpus = tst_ncpus_conf();
>  
>  	CPU_ZERO(&mask);
>  
> -	CPU_SET(0, &mask);
> +	/* Restrict test to a single cpu */
> +	TST_EXP_POSITIVE(sched_getaffinity(0, sizeof(mask), &mask));
s/TST_EXP_POSITIVE/TST_EXP_PASS
> +
> +	if (CPU_COUNT(&mask) == 0)
> +		tst_brk(TCONF, "No cpus available");
I suppose this should a bug happen if cpu count is 0, so i suggest
s/TCONF/TBROK. What do you think?

> +
> +	while (CPU_ISSET(cpu, &mask) == 0 && cpu < ncpus)
> +		cpu++;
> +
> +	CPU_ZERO(&mask);
> +
> +	CPU_SET(cpu, &mask);
>  
>  	TST_EXP_POSITIVE(sched_setaffinity(0, sizeof(mask), &mask));
s/TST_EXP_POSITIVE/TST_EXP_PASS
>  
> +	tst_res(TINFO, "Set affinity to CPU %d", cpu);
> +
>  	if (tst_parse_long(str_loop, &loop, 1, LONG_MAX))
>  		tst_brk(TBROK, "Invalid number of loop number '%s'", str_loop);
>  
Others LGTM. Thanks for your nice patch!
> -- 
> 2.45.1.467.gbab1589fc0-goog
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
