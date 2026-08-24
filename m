Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04438C5DF81
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 10:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787566736; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=knoYSLHdZovoJLN9uCavDrjknQangiprOYq7zAobSrE=;
 b=fJe8K/Mdo2baLybOiLxDE9EhLJAtV8XViuMcYHnY6c/Hen4mGek1IuwcwuqchUVLpvsRj
 4KP7YKemz+HCUTNd2ubg++t7bchJjjvZpQzPCka57mqzVrkvfGaPhBV/YworbFc6YmPnkh4
 tKrwU08eBcDzJw172VdxJA381cfuAmE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 762113D0438
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 12:18:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0ED353CF6C8
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 12:18:37 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 99DAB20075F
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 12:18:36 +0200 (CEST)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-c214321dc32so641844566b.0
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 03:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787566716; x=1788171516; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cff/IxGpwdzyVTUYyeTNJlJbaFIlaWna2aDHnHAs+Ro=;
 b=Ew/+aED+JSVlyVprTVQn7nzhBv1DO5ONYG931FLA9rhMgy5FpLpwd55/Caj3Gvg0nk
 /9OX5VWSCb+ov2DCSjk/DIfGY+vi5AsacCJdfMzvKsQqgsdtOR1c8ky66SiUPpgga9AD
 ebJCMftFfYn1D7MPKW6OAmLsI5NLcGvlobbZXpeHlIOSkvMu3w9rFqhB2pey2HfWtZJJ
 XWraklBrj5lP9HA2EIBDn1deYUW+i7FAY3tRltTClKI25/FIMpWTlkbRQVcxoMoGLcJM
 Gzj1+Si6gJqzgq76BTnOBglCqHfbQKX81tpa3EIVbKF7EwLKyzj3U4RHY+7jL/1k1OFp
 7HWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787566716; x=1788171516;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cff/IxGpwdzyVTUYyeTNJlJbaFIlaWna2aDHnHAs+Ro=;
 b=rewaMZQs4ByyCQLQCXsSH7H9MFveaSBdEZfZyka1flHYK5XoDzqQiN2PPOW5TMnrUT
 Y7BnY9R65LhApFTWu6EiAuySuf37AMRLNhSqoib+t2+a2PERUOEzM/Cam0C/UJgDvRMT
 aWYMb/xRVcr2Z9pSCW6k/AXVlPySt2vEx8j/PiA7Q1MuyZlYkbNsvvXPUmM4ygd7LvOB
 UBhjRY7lv1vmYvOn69gj+cgAdRfW+0TwdAuwY7DmllaXitpIAUGFhHDh3lVK2vxWJw13
 IIpza4RStFqx0MZBm8yXS1KHjIpDkTGXiO8wZO7OKYvQYHon4UzmM9LNLmQ7VUUPpfmB
 DBIA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpMdoRKD/4Rcz7wbvgUsfSd4TtJNL6WUqifHrPanwc/zRnuvvDfc42Zt98NQODEfwEwQsI=@lists.linux.it
X-Gm-Message-State: AFuF++mcEZbi0Iwu5Dxr9rE8CoRG+cAUFuMfhdoKzXf3sO6CDCInSvVN
 iNV7qP8XTLYGy0ekHCeWTK0hInVkXurZmJ4AbjIobQfVcxsq3/cmwhS3Xy9OlecQGziHn5NoLgq
 DQf7+Wt4=
X-Gm-Gg: AR+sD13/FTpS5meluV77VKH2/KbY8EnaN/YDSo/5eHZ3MDvrcSG3+8Z4GXoPWQ3IFAH
 uzcnQdkykdpz5fY2vV7C0acd8sj+L21STDcviK+x9YWsTK1qWE0jjiCS1+D3EjQrisTGx7PC+j5
 Ujdi73Hz6UyYjRit9jhlBjh5LVgD1sWqwJ1wGL/uJfG4E4YIXMU7JS41LmjWTCcZ2HfWV5Xzly9
 QJPFhlbYwJnLuGnAZqZMZPJT17cavKv4yB7QEDOikBVflk5csd2rm2AplVKPjXqNX/VgoK4VXhi
 m6gzZ+NvkcK3iEqHFtiPqc/9HVq6y8NvfgPrpqC8vcUYdgzTSL7i4fLdV8aI6sBVb6GKf6W4Bf6
 ugZuRL3RY1wbMzbTT7bFlu4/+7HkQKYWx61AZ/o7XuJbxQY9TmqaHTAxyUEwTiQRvSl7sQ3tbCb
 iMbVChzRGOA0khT1Cs0/r1fSxCLRN80I2oGQECNybX3eBdSfjAYYZ1rE8pGO4fUyDqwo56MnTkW
 VHi
X-Received: by 2002:a17:906:9fd0:b0:c20:1db7:f486 with SMTP id
 a640c23a62f3a-c246a2ef579mr2579210766b.4.1787566715899; 
 Mon, 24 Aug 2026 03:18:35 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249606b4f1sm1136724966b.3.2026.08.24.03.18.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 03:18:35 -0700 (PDT)
Message-ID: <f9ff4fd3-5d0c-4fb1-8aba-65d5f266c600@suse.com>
Date: Mon, 24 Aug 2026 12:18:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wake Liu <wakel@google.com>
References: <20260824085640.3514442-1-wakel@google.com>
Content-Language: en-US
In-Reply-To: <20260824085640.3514442-1-wakel@google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] inode01: Increase dev_min_size to prevent ENOSPC
 on exfat
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

This issue is alreday being discussed in this PR:
https://github.com/linux-test-project/ltp/pull/1340

Thanks,
Avinesh

On 8/24/26 10:56 AM, Wake Liu wrote:
> The parallel scenario concurrently spawns multiple workers (default 5),
> each creating 2,185 files and directories, totaling 10,925 objects.
> 
> On exfat, each file and directory occupies at least one cluster (default
> 32 KB for volumes > 256 MB), which requires ~350 MB of data clusters.
> With filesystem metadata (FAT, allocation bitmap, upcase table),
> directory growth, boundary alignment, and multi-worker concurrent
> allocation fragmentation, the current 512 MB device size is easily
> exhausted, leading to ENOSPC failures during write() or mkdir():
> 
>    inode01.c:61: TBROK: write(3,...) failed: ENOSPC (28)
>    inode01.c:64: TBROK: mkdir(...) failed: ENOSPC (28)
> 
> Increase dev_min_size to 1024 MB to provide sufficient headroom for the
> parallel scenario on exfat.
> 
> Fixes: ecf418722780 ("inode01: increase dev_min_size to fit the peak usage in parallel scenario")
> Signed-off-by: Wake Liu <wakel@google.com>
> ---
>   testcases/kernel/fs/inode/inode01.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/fs/inode/inode01.c b/testcases/kernel/fs/inode/inode01.c
> index d41ff2c62..87ee07612 100644
> --- a/testcases/kernel/fs/inode/inode01.c
> +++ b/testcases/kernel/fs/inode/inode01.c
> @@ -68,7 +68,7 @@ static void create_tree(const struct tcase *tc, const char *parent,
>   }
>   
>   static void record_inode(struct inode_info *inodes, unsigned int idx,
> -			 const char *path, ino_t ino)
> +			 const char *path, uint64_t ino)
>   {
>   	inodes[idx].ino = ino;
>   	snprintf(inodes[idx].path, sizeof(inodes[idx].path), "%s", path);
> @@ -256,7 +256,7 @@ static struct tst_test test = {
>   	.mount_device = 1,
>   	.all_filesystems = 1,
>   	.needs_root = 1,
> -	.dev_min_size = 512,
> +	.dev_min_size = 1024,
>   	.forks_child = 1,
>   	.needs_checkpoints = 1,
>   	.timeout = 300,


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
