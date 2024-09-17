Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F4C9C36018
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 12:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1726575822; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=4VBupQCUf8DgPxnLw9iSeH0Dl3h9w/W9qx/q7qnM4bo=;
 b=V9tRoPejKWE69ybfbLJ/L7+uSjsZ9zr0uqK7+ct3d/rnL3j7Z5hzJe+oMDgvBIVpX2zNu
 Dj4OzTHhR8pNFQpxTd7VCbwksPTrQ2MiIvLkSk8xsBKIQ6t5SksuksrMcDEHuIaYgI5jfS2
 0H0cDBaQDdJIMoa1OPSQQWdTNy7oa40=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 97D713C2E20
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 14:23:42 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E6CA3C2E0A
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 14:23:10 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6C3D960FB56
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 14:23:09 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-42cbc22e1c4so35735475e9.2
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 05:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1726575788; x=1727180588; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HKrTKeTU5vxuXxASKcsgnsyPknPdYl8nGmHFFU7/mAw=;
 b=SPEFD3hfiY9Sc41+vOCPcfrjVvAjYLipMaZbT7xvjja+dzitiEUdX8ZRZ+YFF4EaEJ
 cMCnXUxJK5vE6K8cb9q7kwzjG1R3h8LcO9q+E7686bTSyjH9jYMpmObZ5JDprCHiqqlm
 yK/H2cAWLQl8v3nLL7L+wYIuhSD7hiuCz7qqyvTwwBsRe/36w1Hbu45xWHacJ8xoInUM
 1pjaAAqRXmWm/smoxZy5mD0v/vXaxQnPa9w9QfpMegMuuF8cYLL9SyzUnAeyJ0brxU2B
 pdgwzPaGDPg+HAAYKSNN+YgLD5q8q+AypdHz8OuBwSxtNwzXoMVLHTTO7aDfrtQXo7f0
 MkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726575788; x=1727180588;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HKrTKeTU5vxuXxASKcsgnsyPknPdYl8nGmHFFU7/mAw=;
 b=Ks8H+Ukr6tOJ8VOTEfv++9+i7HCeFBloAGzTMHiVNIQ/IEWNlvoPE7X3alw2xh9Cuz
 k/37TKgsqkIJaypOVQxDoiANJ2vVcqVXn5y9n8OjDM+gwzXxIETJ+Xto3RjjggcOetGh
 iXXYDaNYVx2jOrKnvwPqfEiYlPXD3ReIYwa0Reqzhiqk3fN/nv5v9iCA/gU9FBmvgpOe
 k2gcWJIPaeXr9YQQeFIorglZXM5nZz4ItlR7/6qdGtGZbX0U8GbVflmrB4f14Yfi6cJv
 wLnBKUWWaklbYXBIOOlFPpSSIusMJVKiUsSPImfhm+J3vhDFHCkW9uLyxs8lbuN2ubBl
 N1Qw==
X-Gm-Message-State: AOJu0Yx234g2Cd45dH5RGhS2dh9Miga2yq0X66V/BYv9pLi+7pwKcAJ9
 8E06luYNUEfI75g1ywRtG/1FGZDhLH8DXx2+e+6GreC78DDgKsyRJJKFClcrWoiqf9h4PzLSZhc
 1zU8=
X-Google-Smtp-Source: AGHT+IHqbox8sNOELe1siy0TLUEBu2D22n/A/PDoGGTcFHZ9FOkzemAH6l0zrCMxrBD1U+8mZevrFg==
X-Received: by 2002:a05:6000:1bca:b0:374:c847:85c with SMTP id
 ffacd0b85a97d-378d61e2c1fmr7335475f8f.24.1726575788110; 
 Tue, 17 Sep 2024 05:23:08 -0700 (PDT)
Received: from [10.232.133.5] ([88.128.90.60])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dbb9d5c9e7sm9288455a91.45.2024.09.17.05.23.05
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2024 05:23:07 -0700 (PDT)
Message-ID: <b13bde4a-a33a-4f5b-b03c-a68ec3da94c8@suse.com>
Date: Tue, 17 Sep 2024 14:23:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240917082543.27125-1-chrubis@suse.cz>
Content-Language: en-US
In-Reply-To: <20240917082543.27125-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Disable failure hints before we actually run the
 test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

LGTM

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 9/17/24 10:25, Cyril Hrubis wrote:
> This is patch based on a suggestion from Peter Vorel:
>
> http://patchwork.ozlabs.org/project/ltp/patch/20240527202858.350200-2-pvorel@suse.cz/
>
> Peter proposed not to print failure hints (the tags) if we fail to
> acquire the device. This patch extends it for the whole test library
> intialization and enables the failure hints right before we jump into
> the test function.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>   lib/tst_test.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 918bee2a1..3a71330b8 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -899,6 +899,8 @@ static void print_failure_hint(const char *tag, const char *hint,
>   	}
>   }
>   
> +static int show_failure_hints;
> +
>   /* update also docparse/testinfo.pl */
>   static void print_failure_hints(void)
>   {
> @@ -919,7 +921,8 @@ static void do_exit(int ret)
>   
>   		if (results->failed) {
>   			ret |= TFAIL;
> -			print_failure_hints();
> +			if (show_failure_hints)
> +				print_failure_hints();
>   		}
>   
>   		if (results->skipped && !results->passed)
> @@ -930,7 +933,8 @@ static void do_exit(int ret)
>   
>   		if (results->broken) {
>   			ret |= TBROK;
> -			print_failure_hints();
> +			if (show_failure_hints)
> +				print_failure_hints();
>   		}
>   
>   		fprintf(stderr, "\nSummary:\n");
> @@ -1871,6 +1875,8 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>   	if (tst_test->test_variants)
>   		test_variants = tst_test->test_variants;
>   
> +	show_failure_hints = 1;
> +
>   	for (tst_variant = 0; tst_variant < test_variants; tst_variant++) {
>   		if (tst_test->all_filesystems || count_fs_descs() > 1)
>   			ret |= run_tcases_per_fs();

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
