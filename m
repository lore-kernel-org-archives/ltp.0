Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C81C83F03
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 14:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751551643; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=x/rrAEybKVI+HU1RqimIq0msW5jpzds4vkyFMIZhBmA=;
 b=WzCRe4VlVgcUk7OEMaxGLVBMOOqtFa04tQnCSSxgfD/sdb3T7O3g2dZqEE0AXWxtG7fHA
 D8Ey39j7tj3zVw39WxayMrJev+o5nZD/QjMUmJ5K3L/jLw/4yq4KQttwmZkzuoUdU7V24vX
 6duPcIOIStTHH2kLZuWhsPyR/eRiFUw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CAF763C98F6
	for <ltp@archiver.kernel.org>; Thu,  3 Jul 2025 16:07:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E9BC3C312D
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 16:07:02 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 32F7D1A009AE
 for <ltp@lists.linux.it>; Thu,  3 Jul 2025 16:07:01 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso3713965f8f.0
 for <ltp@lists.linux.it>; Thu, 03 Jul 2025 07:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751551620; x=1752156420; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ls2f6CMFrYFvQXBc+Z5BvhhzmAsSnelFzv6AhMTqlH4=;
 b=S8qWY7yVY0JkPHkpvz60FQcCdm033DoiclT7pcHUa5L6Y4PFfILp2n/BXWf5+T9y3R
 SKtWlewoE7demvr610ACNC+BT9qF9pL+Ja0mqc9WMfJPDIv5BZ6XOXJZrnFvxgoIUM3i
 A4Zm3RpawFlEo58PSOOtnXrzpuHB5SUBjoag3dc3kLuhqI1b2AjQW4SM8o3+GmFBnW7H
 FetzaO4I5WOAoxvsTGRlIIA+uUhaUhoCopQLcowBLhGe935ZLQK2ut6bo+8KubAs/qjY
 JBi+pAh131o8fBcdK6aHxUm30J1vlGkHioYoEnstp8THg5efSbBZptolM3hpTU7f9UTQ
 OvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751551620; x=1752156420;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ls2f6CMFrYFvQXBc+Z5BvhhzmAsSnelFzv6AhMTqlH4=;
 b=aF2lsBS9ETjBCm6GMnUbyqDrzrEhQxUJ5nyQpMezX655GTE7230OjtW7ZKvWQ5Y4l+
 CT87xp98U/nMevSAtuzFQAt5/ib0khg5feZTr5S6krm5+qw6PYT6QCCX1DP3mSqAEg0q
 Yagp4OFzYj3Jry9YTejSyrVAwBG4HquIRxRgsP0KZky9pSVPl0sYMaSGg2LL+zzLajhH
 J3vOxWnzs4y4iTlhLgxzQZv37H9K2vZgPAHIG4jQZOMwSFf6rTSgiC9yrcoyEHys0ysf
 8y8DFPjWAqhFqrVfhtjsdKX4+oDSeQZ85+qCrYNluvRmjGiUqdBKTvh9IE5lowLoqZRN
 8idA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2kbEsPJMY/ZCpVJjjQn+l+8TCYarRmtcfE6sRw6Ge2vbTQ4KInTdPxurAiQx7iOqpY6Q=@lists.linux.it
X-Gm-Message-State: AOJu0YzvqlCn2zSPx7bOcfI+KFQfoi5MRJnDNQaLRoBPNn1Xme8/G1hO
 cKOlNJ4j5R4vKWLw88DuH6tPgKLy4chIx6iPxS03x/LP5htbu/X4eZh6RMlltDQIgvI=
X-Gm-Gg: ASbGncuiSVPYG3WcD0bbw2EG9YdKA2L+t+YU5r9652taPwnXkI16tujGjn8jXBuyfUL
 q7293EvESUhDQ4VQnU4Gx6pwt+nEUidRzsRVa8hzXNC+bwAPO2EAbDKvjzEsgv7twkLldM1GJw1
 iwzd/gi7YwmovhJYfw4kFn6FJO4dek7ZDUb0WH3Tk2GYz/0QH3twFz2gGtHp1Jz7QHnnUX6rilU
 OEZ30/eWUl98HBj3q8ZL/BCaUdEbOvrN9njGPxKNq4eOKh0AY4VB5y4Mepomih+De3jHLnT4avQ
 Ve0imHgQ462eaYQ3AhnMHe694cU2E06oiC1o7/Df94HKHLO02hIpXdhF2f6wvqE5zkIMwuwu
X-Google-Smtp-Source: AGHT+IH/Gz+d4w3f+p5SzOFDbHATdK/ampb4rDl/dnt5le7DmZ1vgLWILaxxvcPkUuONlUAR9plfWw==
X-Received: by 2002:a05:6000:2f81:b0:3a3:7593:818b with SMTP id
 ffacd0b85a97d-3b1fe1e699dmr6642089f8f.21.1751551620367; 
 Thu, 03 Jul 2025 07:07:00 -0700 (PDT)
Received: from [10.232.133.64] ([88.128.90.23])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23acb2f21fesm156475715ad.73.2025.07.03.07.06.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 07:06:59 -0700 (PDT)
Message-ID: <2a582858-a57f-437f-b30a-0821b9c07727@suse.com>
Date: Thu, 3 Jul 2025 16:06:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20250703180201.3384905-1-wegao@suse.com>
Content-Language: en-US
In-Reply-To: <20250703180201.3384905-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] du01.sh: Read the actual filesystem blocksize
 instead of pagesize
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

Hi!

On 7/3/25 8:01 PM, Wei Gao via ltp wrote:
> On PPC systems, the page size doesn't always equal the size of a symlink.
> Therefore, we need to update the test to read the actual filesystem blocksize
> instead of assuming it's equal to the page size.
>
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>   testcases/commands/du/du01.sh | 10 ++++------
>   1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/testcases/commands/du/du01.sh b/testcases/commands/du/du01.sh
> index 7977fd461..68099de9e 100755
> --- a/testcases/commands/du/du01.sh
> +++ b/testcases/commands/du/du01.sh
> @@ -60,18 +60,16 @@ du_test()
>   }
>   
>   block_size=512
> -page_size=$(tst_getconf PAGESIZE)
> -if [ "$page_size" -lt 1024 ]; then
> -	tst_brk TBROK "Page size < 1024"
> -fi
> -page_size=$((page_size / 1024))
> +
> +FS_BLOCK_SIZE_BYTES=$(stat -f --format="%s" .)
> +FS_BLOCK_SIZE_KB=$((FS_BLOCK_SIZE_BYTES / 1024))
>   
>   # The output could be different in some systems, if we use du to
>   # estimate file space usage with the same filesystem and the same size.
>   # So we use the approximate value to check.
>   check1="^10[2-3][0-9][0-9][[:space:]]\."
>   check2="^10[2-3][0-9][0-9][[:space:]]testfile"
> -check3="^\(0\|${page_size}\)[[:space:]]\.\/testdir\/testsymlink"
> +check3="^\(0\|${FS_BLOCK_SIZE_KB}\)[[:space:]]\.\/testdir\/testsymlink"
>   check5="^20[4-6][0-9][0-9][[:space:]]\."
>   check7="^10[4-5][0-9][0-9]\{4\}[[:space:]]\."
>   check9="^10[2-3][0-9][0-9][[:space:]]total"

we can just:

block_size_default=512
block_size=$(stat -f --format="%s" .)
block_size=$((block_size / 1024))
....

And then we use "block_size_default" inside do_test().

- Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
