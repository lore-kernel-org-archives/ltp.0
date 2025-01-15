Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B4FC02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 08:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736931307; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=TlBb3ND0sCKGsRjbMRijM7RcIvEJVurYs4Ium22TH3Q=;
 b=PHo0x/Aga8j8YT5rmoSWmU8HpqRVDJyYUQhi54ANCI3pzzIQKHFx2TZYZMhBv76SIPu2L
 BA0Y+PkdS3ZXX0TWINIlqREpFHKy9O8Tf/sjPj4ZHnCMyrLdN7JEsAyXIhAaKCsNR1FuuZE
 pUAkAyqwgEX1TRyTopo8Re71x3zUoww=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6282B3C7B46
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 09:55:07 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 824983C7B26
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 09:54:46 +0100 (CET)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1A7F01BBBB6A
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 09:54:45 +0100 (CET)
Received: by mail-wr1-x442.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso5390710f8f.1
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 00:54:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736931284; x=1737536084; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VIWIyh9g7GQo5vOrMvGVuxQAzPQVVXlWuM8stHS1B9Y=;
 b=F0f5sfDVESd/54yr9HpF964y6JmlKa53XCT6lh+Ldr6U2JzAnyN1MKC2whtxItDKO/
 t4B2MVsGgZRpUqdxi58D3XFVtkzYKlhf2/cxz4LKYi94eU2kHB3mHeKEIu79ZOFsS+GA
 +L+kKZvIgwsO8IOYiQwwxS5UaNmuP0uvJ+JVjFTg9ozsSNzOpWeawdZbnQUpxboanXQd
 bT76/Kx7HRChdkoJILVKl67CwjhQZCkkNFo5v5ScsNRtFXaGSN8auRZYW5AkEMMM64X2
 r98rqEsqRkPzIty+uvpjzhCJqQiq8LAfoaV3lL7VKxBIDyKMFGp+u6ZLuCQ8mDD5DLyQ
 Q4iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736931284; x=1737536084;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VIWIyh9g7GQo5vOrMvGVuxQAzPQVVXlWuM8stHS1B9Y=;
 b=qey4SDyApnvnYq2JpRR/0h3wsadihXrcrcRvfH7F7OsbYxbU4fckdrPiI5AColUC5i
 YobsXsthARmHZmEbBxPoHtyxVKM3umwxAVvhdvNg5mCVKsTHpt1b6l8CXA2iVhf66FiZ
 fNumUtzemGuONujrpP0E3rSkQL78Paveh8og29BPfQsIgPHwJvGr2r6xr81C1mOjdrf0
 TWdoNVEKvrGBG43PUPF4c/n1nNSSoB/pK8U0fmWkOVUoF52DIyFFQpJm7ZZ5GUaaGU0W
 6zT8mJlcTPZw32AWDGUzo1j4jcT4aKs6flCNwTNWQtNZ36Zy2CuVvgvYyaD4+VGoQEzi
 t8nA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYD7/y3NCF9LwsKncineoSyrhS7VLPu8hG/houJ/Oy+xgoZGPzN3haUeUJQw+5WAQht+k=@lists.linux.it
X-Gm-Message-State: AOJu0Yw5XEUYH4JFgM9yKZI+kAw/z6enn0OXIN+THnEZI8dU0QvTfV3d
 l6eu/+OZn5nZcUtdjuGVnjwQ+xeiKksqNXvH3jH80gSBCsE9CS1jUgsyCJJ4AwU=
X-Gm-Gg: ASbGncu1WcczvtZ1Wy8rsPpQ7d7d8ZjtiGYiVeL+hHQsLLWVGfqdrhGZATBk0GbSEO1
 SwEqcBeD8Pngzf/Y4O3+tA/BMS2YYAzJ3rLZDU1s+cHKR67Koeywtd+u+B9s3rLaLffVvBhjBJN
 2ciFUN58VYxy69b87ZbJYLc4rWlytalNh7NJHtSTDhRB/ZAaHslH0JCmUxNErlgUtY/t5+SQuSZ
 vC8K7GwLT6qxnUF/8xdMNjVm1Sy86kpuNYNiHiECa8ir/XvDfcM57Fb6ikifShoL3VxRlsjKtit
 IaILftF+m9iVTM30VsfrCoG8Awcqu9IATZY+5P2EiZmBSC20K4rxaVf6xtNOtU1VrLvEzkvwVTH
 ETpxzgHJinw1grtPOPR8=
X-Google-Smtp-Source: AGHT+IHEv6am5FYB40gqA9eiiutwUPggy6ICmEOjzd2vJb5k3KbyH0i7w1eYQ4KVfQ4TE5LT5ZjqQQ==
X-Received: by 2002:a05:6000:2a9:b0:385:e394:37ed with SMTP id
 ffacd0b85a97d-38a87305463mr23718454f8f.18.1736931284498; 
 Wed, 15 Jan 2025 00:54:44 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38c697sm17358555f8f.52.2025.01.15.00.54.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 00:54:44 -0800 (PST)
Message-ID: <7b366388-6a0b-45de-95fe-08beb7528062@suse.com>
Date: Wed, 15 Jan 2025 09:54:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Ricardo B. Marliere" <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250114-fix_b4-config-v1-1-e03eff794599@suse.com>
Content-Language: en-US
In-Reply-To: <20250114-fix_b4-config-v1-1-e03eff794599@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] .b4-config: Add checkpatch.pl default commands
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

Hi,

thanks for this patch. I was using something similar, but the output 
here seems more reliable. What I don't really understand is the 
following error for many of the commits in the patch-set:

WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?

Andrea

On 1/14/25 23:43, Ricardo B. Marliere via ltp wrote:
> From: Ricardo B. Marliere <rbm@suse.com>
>
> Blend b4 default checkpatch.pl flags with the ones defined in
> include/mk/env_post.mk in .b4-config so that a contributor may use `b4 prep
> --check` and `b4 am --check` in his workflow.
>
> Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
> ---
>   .b4-config | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/.b4-config b/.b4-config
> index 2efdf2273240dcf57bd5cab174ff6c7a1952dd5b..5a16bd64ec98b91e17386c0eadc7ef0de54d86f3 100644
> --- a/.b4-config
> +++ b/.b4-config
> @@ -4,3 +4,6 @@
>       send-series-to = Linux Test Project <ltp@lists.linux.it>
>       pw-url = https://patchwork.ozlabs.org/
>       pw-project = ltp
> +    prep-perpatch-check-cmd = ./scripts/checkpatch.pl -q --terse --no-summary --mailback --showfile --no-tree --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING
> +    am-perpatch-check-cmd = ./scripts/checkpatch.pl -q --terse --no-summary --mailback --no-tree --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING
> +
>
> ---
> base-commit: 6fe8aa186559784f0394cd449cba6c53342790ec
> change-id: 20250114-fix_b4-config-1ab84320000a
>
> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
