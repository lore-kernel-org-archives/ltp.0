Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F8E5C02180
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 11:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736939345; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=YPvcm+5FGVYKXGVyyjROWfZwy6clK5/sFr2PEaYqp14=;
 b=fwfUfTME6F3vfMXHUabsaiCVA0ULUIfnpdQyleCj6bRAKxJ57oEPzQgsRZXtpn53CawbP
 8EFlpfsEzUwh2SjLb8bbNI6MPv2UFRMxu2Zvzy+z2l2Hu2pjsq/3AfZzCSmQ2QwYdU3gfat
 3vpe8TgQNtAdz5lawWvataM4Gd0VnAo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E34C3C7B75
	for <ltp@archiver.kernel.org>; Wed, 15 Jan 2025 12:09:05 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 82EB53C7A70
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 12:08:45 +0100 (CET)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 87E021BDB43A
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 12:08:44 +0100 (CET)
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so5703951f8f.0
 for <ltp@lists.linux.it>; Wed, 15 Jan 2025 03:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736939324; x=1737544124; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/QmyOBdZIMaB18JKLFcK84yZo8tGvnawakHomce1YyM=;
 b=EbN1eN9SFMGAPm5EbGNEiW/eAtpwJxJn1k4Jp7pFyef35eVJ6aKT9+fMD5xKxZqHt+
 VWAIujeCJ5isQwNiNx+c3u6DqB9BKdBN88qBPmHHrr5Oq3Fc9KDgI1w046RQTyKgroeY
 o7iaI/rTYrnznrP9dmmEz5Tt+eoewbxkZdUgSVHkyZfMKPAjHVYQ74nOwQnmqYCvmYqq
 EP8bvDAU+DNwmSI2D0NsI2m7A7VlWvMuIkgRBgm38kHhUgbb8a59V8pwwvSAXPkzeSFr
 WmeGg3MrkTp3IUeaJ33oh1TEuR8NolfWjEz+evtQkmifH6Q1DAwq8EEG/9fqW2jcR06v
 69aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736939324; x=1737544124;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/QmyOBdZIMaB18JKLFcK84yZo8tGvnawakHomce1YyM=;
 b=aMIw5YDNNmvTB1Z6ulZiVP4PLjKyeVc26lopgyss4y6E1ch0Wb+EEw+FngIHFHrpSb
 G2hPSXEpdbgThQiL+5vJlwDK+uzbysoTIClu5FqK3bTxmkflb5sW7SE/6uuUa97gwWrK
 lAsYOgZR53GFeVRMHZAzitq+id8+I7JkEjHTtkGwK4krPDMPzyg9tFzmSskfK3qA9oNC
 ovGAfIJlApiIZeK3iGLhDJ4q99E7pZXLMKfQo01bCFxzpHMlXF4eRhDqV5Lsq4hgzjoj
 h9799DcWF/ea2RtM8OT0zm2d7UfcXYrHUNAD29i5xbYDOXbTuPXRDGqbbuDqJKt3qKoM
 kHwA==
X-Gm-Message-State: AOJu0YyCYerSgz2Ib/mGKY4TEWW66S7rQSrHxThTg4nv88niDe8dWNJt
 sPLKJe06O4sTnkTwbEOyO4cxhY+FsJCUOcJ7q9EYMm5GuNLEamvg9obVo+CPMaETFP36ExJWBBc
 bdvHpkl7k
X-Gm-Gg: ASbGncuJcNyIbJB99yYhg9uSJNfuTzwjD/yhoF7eX9y3YNp1sOO7KCbQOdKLLIXwqof
 eanGv8Aiua4NvkRzNgBlnd+t+WF4W6Qgp4e6D9mkkRqF6uKyM2CS28/7uQ83rn7YKwCGqvJtfj+
 6KOha/4fsocyqMwv3r+TzQ6LDYYtRvwA3vQBZJDlA0VWmDU/r5azU311HHrtb7xHtnVHywF8MjA
 g+GTlT207adXG2cRCMcoSS2AsmfZkWshEcQUyFwsmyOGeTF0jyAG32v918zTc9Fq7DEno/Lf9/Z
 9qLSFugimK429oBbXJfsYid71J9fJJZl/34nXOaQYKU0s3ocq412ORSjqAnSt9VjJW0yxJ0m2gb
 /Foh6vzUWA/4t16V28T8=
X-Google-Smtp-Source: AGHT+IEv9+QxUs+Oy4csZXtKZEvaubDRn01eWx84TGrtncz4ST58qlXdHQW3d1dhXQZ+esDjyC9DfA==
X-Received: by 2002:a5d:6da3:0:b0:38b:669d:4dd4 with SMTP id
 ffacd0b85a97d-38b669d5112mr9996312f8f.11.1736939323762; 
 Wed, 15 Jan 2025 03:08:43 -0800 (PST)
Received: from ?IPV6:2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4?
 (p200300ef2f2b3f007ee622e7e7efafd4.dip0.t-ipconnect.de.
 [2003:ef:2f2b:3f00:7ee6:22e7:e7ef:afd4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c74e59ecsm19315005e9.35.2025.01.15.03.08.43
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2025 03:08:43 -0800 (PST)
Message-ID: <29864db8-1642-4734-b11a-f5ba0ee6f0e7@suse.com>
Date: Wed, 15 Jan 2025 12:08:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
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

pushed with FILE_PATH_CHANGES in the ignore list.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

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
