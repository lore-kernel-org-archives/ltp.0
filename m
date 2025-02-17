Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47B4C021A9
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 13:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739798820; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=h5vtvlen8/hcGl98oaTvv1EEDIQeiz6wah0IAljSI5g=;
 b=YdttToEl/o9XidXcC9PLZV7jBEW+YAOe5kzoe/1P18FgGLBqdJqOH/xUXjEYbsKGV/2y0
 M8ieOOw1UWQ1Hnfs1mQTjMRtcNK4quNfQ0A4jEaJ8MuXh1svLElv4n9XS2gwvd46MsHLe8y
 Ahko99ZHNJ+7qAQE6cTTn2GiXAh7D7I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1875B3C9C65
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 14:27:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3137F3C99E9
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 14:26:31 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D0AAA62CB91
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 14:26:30 +0100 (CET)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-abb86beea8cso283492266b.1
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 05:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739798790; x=1740403590; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r7ROHAK7yXG4Vb6b4hAz1EWLFsgJ5WjZ8YXHo26HyT0=;
 b=T/ffzBTeVen76jAQgLjj+dIHNK6DE6MIrs7tdibTsyyxmP2pWGV5aT170WtTntP8yj
 3Q4XylLwWTBfIlydajyJM2fBhhdwfguklSaaYW/v3H1KPUDbv6Gp4Nm8uNrVUgPgPwyY
 Tqvegyr8vDghi6FS1GQ5G7OXlTHRPqJTaDYQ/36oXCaSewpTZIEAE6c708Vyi+OQoXM9
 DTgJBrKcA56B85T0EOjwrsmGwVAKJYap/21EXw0rw+sVN4tmcc+gD3rT5ChV2xN+KiBw
 AD8BZVC5aMEigc8hs7zgFiWtzgwVAVAlAiaefEr+9w8gC2Kvj3RNJv6fvOavZalXkkby
 XcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739798790; x=1740403590;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r7ROHAK7yXG4Vb6b4hAz1EWLFsgJ5WjZ8YXHo26HyT0=;
 b=XoANRGAU/zm1OUXVKb32OtSVxSVUAixkbsOjyw85mL4owJ4I3NRKUALdHh02UZMMrJ
 YQ3IrvxrC7lHpA49bhB3L8oIEiosNjhmtIuk/pCK23QP15CdJ6GLGkgLnF+RZgD8qHaY
 YWBqZ8J4XNikwbdAjq0xQF4NNHdgWJROMHiVnPQ5K19H79DznQaFc7RarHb6YscKd1Xw
 swK4AcoIelZnVgAZin9pharkNVPgadI3BazQacyQFWxqq2JQ0+0KMAkVABgQh14/6orq
 TFLz4C4Cqf3REd2a2EFPMTalZgnGOyvRvzVdRhyTLmgxkWsI6+OUX3s8gEQdZAzEG/lr
 V56g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkyfvnUB9q49A9EQlY4puYN2jf0WnTTOE/GyH/TA8FIH17LW/xkqJibwTyhMwQzKSZHKY=@lists.linux.it
X-Gm-Message-State: AOJu0Yx4b8bnZ7xuanfG8gOeiMLaRFdEq/RlkjV2DVteenLg9pzvp/lD
 q0Neg+pwP8gMWk5pvJ20P9YPgiC89Fq4r+3b+cWz4mZgKwkCgzkDcvvoYeQ9IHfGmpvv2vIyaj7
 4
X-Gm-Gg: ASbGnctlMuNSHNFzEv6lA43kXgu5Qv4dAI8CpZ4JCtmv0of5cwUtF/BJRWBANheWVfm
 QhlPZCoyjoIU0h2zSCL9qMYUf2r5HDLIFz7ZlO66uXNkcIAqWFIFFi59BJ8p/57VyWoX8edMqQZ
 sFluhVUHZShmL2HuK7SsrB/mBhSX6HpX+SYIKtHWBKvWXP6z3hJthUHDFuzWlc4h+uKCQ96dvrk
 LaEhdrgrAE+lEvjdmXqcKtD44dPLIViZAY/CpPPm17WWE1JBELSj4pOuAnNcwv7ggsk+B4SegbA
 TZKzV39n3GLfvHPoOIHgE1+u+Jt+vl1GWClQUHTNq56WUX9H0Py0TmbdD8wXf7GvLvTAH2xIJJG
 yeVMh5FlBz+lGIwNbRw4bpYkcUEn4ReuvsGkXKlnpFIA7UukLpDI=
X-Google-Smtp-Source: AGHT+IFprS7CS7mKbxQr4OZmOm4tdTlHWdD2l79TcBF9a94QmOW2xYYjoZu3wVFpVnlTl/3VVf6YHg==
X-Received: by 2002:a17:906:3290:b0:aba:f6ff:d38a with SMTP id
 a640c23a62f3a-abb70dce3bbmr948943666b.29.1739798790057; 
 Mon, 17 Feb 2025 05:26:30 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399?
 (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de.
 [2003:ef:2f02:800:9162:c8ad:3b21:a399])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aba53376bccsm884875766b.116.2025.02.17.05.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 05:26:29 -0800 (PST)
Message-ID: <ea6764ea-db92-4f49-ba5a-650f62bcfa23@suse.com>
Date: Mon, 17 Feb 2025 14:26:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250217130839.2392666-1-pvorel@suse.cz>
 <20250217130839.2392666-2-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250217130839.2392666-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] ima_selinux.sh: Detect SELinux before loading
 policy
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
Cc: linux-integrity@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 2/17/25 14:08, Petr Vorel wrote:
> Adding TST_SETUP_EARLY to run test specific setup before loading policy.
> That allows to avoid loading IMA policy (which usually request reboot)
> if the test would be skipped anyway.
>
> Fixes: aac97cca96 ("ima_setup.sh: Allow to load predefined policy")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/kernel/security/integrity/ima/tests/ima_selinux.sh | 3 ++-
>   testcases/kernel/security/integrity/ima/tests/ima_setup.sh   | 2 ++
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> index 97c5d64ec5..577f7c2aca 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> @@ -13,9 +13,10 @@
>   
>   TST_NEEDS_CMDS="awk cut grep tail"
>   TST_CNT=2
> -TST_SETUP="setup"
>   TST_MIN_KVER="5.12"
>   
> +TST_SETUP_EARLY="setup"
> +
>   REQUIRED_POLICY_CONTENT='selinux.policy'
>   
>   setup()
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index 1f1c267c4b..2a9f64978e 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -265,6 +265,8 @@ ima_setup()
>   		cd "$TST_MNTPOINT"
>   	fi
>   
> +	[ -n "$TST_SETUP_EARLY" ] && $TST_SETUP_EARLY
> +
Why not doing ". ima_setup.sh" at the end of setup() ?
>   	if ! verify_ima_policy; then
>   		load_ima_policy
>   	fi
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
