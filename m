Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F995C369D3
	for <ltp@archiver.kernel.org>; Mon, 28 Apr 2025 11:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745839806; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=HCiddeiFq9tgDgrf+in+JOn6cp9k/ht+SkpK5/cqfEU=;
 b=XK9W1knMIeMLly/uHLz6+ixn0M/ymtpRi3rZCeeB743pH4RuFHeo4Z5XIiSDkKqbvLa9N
 B04YJmYQO6eRJTYfmkarxrqRV641n8a9k+z72mP9VyAgzG7Ny382MOOGYC0JooT4zN6X+7Y
 ljH5JbctMx3D9azb4pIgPl7HnsHHFN4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E42A13CBA0E
	for <ltp@archiver.kernel.org>; Mon, 28 Apr 2025 13:30:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65A173C2F88
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 13:29:45 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 209CF600BB8
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 13:29:44 +0200 (CEST)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5efe8d9eb1eso4186975a12.0
 for <ltp@lists.linux.it>; Mon, 28 Apr 2025 04:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1745839783; x=1746444583; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jsFf+Paig/2XNahzpL82LShTQKgYQwKnS8/4vIyPxng=;
 b=MiZn0uwn+1cLIJxvdLcJv+hMMDxhYiMg6HZmNB2zfcfYdtWvhguzwiGA23XiwP4ON7
 vWyXXLJZVa2Ct4vDhWlE5/lSAnl+06SWe/Egq8NX+zNupr8QPC6JnKB6bOgmhq9ymrPx
 KMCd47udpb2eS36p9ic8xPsw6WaAL6Z82JSTE1QOSa7rUh3cyStV7SZ9ySnDoK0sNUH4
 CGLfB6cW4Veh/nlLCUXAed7x0zngaW7Zl9WcMCrOATH1sdmcBtkXBOKViLuXhZkDS18b
 icv23lSscKxIDQrXTon8D+mHJkvv5d8VzqBE2qOCBlBv/0EVRDZyPMvI6sLGHyWdYYT6
 QSVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745839783; x=1746444583;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jsFf+Paig/2XNahzpL82LShTQKgYQwKnS8/4vIyPxng=;
 b=BYKytcb4qagw4I8RhjwzFVkr5Fd531/LOFjZRoeaamWWRuRuWeLs+niytDAmBW13Vl
 AHZEU+Zy3IZy9KfkLEAdHLsmw9g1kJKQn62eYxi6Q3C8FnATCFrIkkntzv1ZT32V8u99
 29rIx95MbAVQYsLMQmU08N7Ivc924GuAdwGYX3YrOEjy6i0bOu1em6ozIIilbQ/IU709
 +zoKRsxBeDgvdlvx64dFgL3AO2m3mh1aRegw1zSC96+R1d2lc3YcfDBfLwiBJEZVKzGn
 26uoBjFrtbCWNCR6G89oi/OMqPGII8pfPSpt/YLj5doN7WJAEK8LbVZBbOG5pvzlsG3l
 DAuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCBNT3BQU4ZzwtfsMURmDrq5uEc52c+GYhFmuWvSQIshqItBhsMNoF+oPTkp0XjZ3nTwI=@lists.linux.it
X-Gm-Message-State: AOJu0Yx0e1BDHMH1DPfE13yD04JT1B+YVtr1RB2P3+X/GbeWpEbIVeKe
 xzB7UDlsAnslsxfyQ5GY4ex2JfvVeFQCLPFMsP46ppl0rfVJEFa5Mf15PgzpuD//XwSlscEzcxy
 I
X-Gm-Gg: ASbGncuAb5lYFQYqKkfv9lbW01YaFCuoHAMO3oHRmA7E6y93O7/BMJpWZjtkwdAo8xz
 PLk4t3ayxqS6wOl30CQFvWCnIRz511W/AiidxZCuElgw0iKwFTxzonevHB2IHZV+kqqAJrbal5/
 U09sEUqD8Nzxvc950rh97HvLzBZVS3uGNqDnUDudFj5HTTPgswgYUX9Q0taXTI0t3LpkHu4sz6f
 eq/c5hBk5iZMhJYGtnMRl0X3DVQjrn1L4CrldjfE8AtuMuoKi9RAWKh6II10TjYiUdA7Ml/KzeA
 gwgRUEqupZb2HNlyAvvDwmmM3r+IZSekS/TV09a55DsOQRNE9Q8WIbAD4TRjWw==
X-Google-Smtp-Source: AGHT+IFgh+sCEwhynipZQGpztUb9Trs0E97yxz63kgTh5sDW6kBFUmooOOrU8nI7HOOxtLdZG1dz3w==
X-Received: by 2002:a05:6000:290d:b0:39f:d0a:5b23 with SMTP id
 ffacd0b85a97d-3a074d08a7emr7681500f8f.17.1745839375706; 
 Mon, 28 Apr 2025 04:22:55 -0700 (PDT)
Received: from [10.232.133.16] ([88.128.90.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e46a54sm11069311f8f.67.2025.04.28.04.22.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 04:22:55 -0700 (PDT)
Message-ID: <15d23710-86f7-41d2-ad37-814662c434c0@suse.com>
Date: Mon, 28 Apr 2025 13:22:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250425153046.63853-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250425153046.63853-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/4] Workaround broken openSUSE repositories
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

Hi Petr,

thanks for fixing this. I think it's a good idea. Feel free to merge

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 4/25/25 17:30, Petr Vorel wrote:
> Hi,
>
> patchwork.sh tested manually - see the last "ltpci/opensuse-leap_latest"
> line in:
> https://patchwork.ozlabs.org/project/ltp/patch/20250425125057.38992-1-pvorel@suse.cz/
>
> Kind regards,
> Petr
>
> Petr Vorel (4):
>    ci: patchwork.sh: Add check for number of parameters
>    ci: patchwork.sh: Add optional 5th parameter
>    ci/tumbleweed.sh: Retry on broken repos
>    ci: Skip openSUSE builds on broken repositories
>
>   .github/workflows/ci-docker-build.yml | 10 +++-
>   ci/tools/patchwork.sh                 | 24 ++++++++--
>   ci/tumbleweed.sh                      | 67 ++++++++++++++++-----------
>   3 files changed, 71 insertions(+), 30 deletions(-)
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
