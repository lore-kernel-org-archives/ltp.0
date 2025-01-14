Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35EC4E77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 14:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736865647; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=plGTPuoBnTDmtaT5eGGSsbeVRz8dozUEZar3ueUsgJM=;
 b=QyFNZ3UkBiw4B6WRREdYJZ2madIXr1r8XK9b59Ki26yPkwLuEf5E+YdejsraiEIK1Qo1o
 HZSLjKopLgV2VWzr3XPqgGdyOuC6SBZC2HF95U7pDrg9qkrQob4jGrno3go1ht4zjXht/nQ
 F4ntOHxctignJ5Z51GpuX0VIs4dFE+k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62AC93C7B03
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 15:40:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6AF7D3C7A24
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 15:40:25 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A741127BDE9
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 15:40:24 +0100 (CET)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d0d32cd31aso7869442a12.0
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 06:40:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1736865624; x=1737470424; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0jTScgJF4jB7IKamsGFhW3b4BV1/wBpBKJcg0E2V7Bc=;
 b=PcU0OsejKbJ61Z00QeByoy1r0wDLlxY6Jddz5TUzqVpWdJ04TzuKOFGLWZNZB1bisS
 QZTYVdDZxqb+XK/lsoqNg1KvxtMFDTerEPlNp3eW5UwTnBkVasTb4oi4bncjY9M21Mto
 HyEAqBFNVVRtjy/1X5XyW5B2T42wrlihkCekO9QoYra8+BDfWkpp2aaaVX7FZN5FCmi6
 cSCotGA6SnGY53iALz8OCkLkbg0aFZUBTn9mjjeSDNbR+ycQG+BjGMjZhShmkq8XtyXj
 s3fPffXakBfZroos7WIGmXDS9ev9GZwQFO7UggalClEyMfteDbqDjdifENu/39um7ojM
 FlGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736865624; x=1737470424;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0jTScgJF4jB7IKamsGFhW3b4BV1/wBpBKJcg0E2V7Bc=;
 b=iPjhm7Uh/rXmKWijx4qdI/N1McRgl/lV82HSVye9bDXaf9BE5v2fdGwpO3zXddR4hd
 XvuyXtpQYaLzTgxEyUJ/AYlVwPv8JvWJYL2/07Hjkp87Oxy/qB1/oQcs9ghVVAs6D6VO
 Xk/zDRcjthSOE6vCcURkRl0F0iYrz+4QvuS7o2AQfE3lOyhL1GIVGaCNAWKbN1wBYzLY
 xGpcuXdVL3OIxy+ZQ6hV7ttkSQpflkAqbtY7Dz2mx3B+i+k4ru+kuM7NfQ3UGQ3XQXRl
 n6+J7zjxPg8i9xYQ+jxzKZ9IKFD0/Is3aM1+VdtWMMEF0IElhAcypwnZYWZCr9lIJSpi
 gXPw==
X-Gm-Message-State: AOJu0Yxqv5LpRdqZVx9Olrsd+i8H52tdV629GGhu20zkxcOHttVBtKOW
 lTVD2dvTXKdzpVW0mh3qd6EG2kb1mLLzcnIzVNsb0f1EQwwO9t7z3g7sXuT8mY7WXGA/8s7jaCu
 XBlY=
X-Gm-Gg: ASbGncs39R8sSUFwaaFCM9yJ3fOblNFBEzZXd8zfA/1VX2wG3t5Hfc3JBtyZFhe9ENC
 reyFVP8CdBXf5Yl97VvJ7bQdG+4GSYSpe7RUNbMnL768qellAN2J8Bb1MS1XUh//NQXPrMP2Me0
 y4n4H/wUkquiH/3GCqcHvwR3zKWj2lAAaIXj57AISd7huvGJPiJSIXTA09eHhNB8ciu9Ycpn3cB
 udETf69WtzVvzkMB1ZYDkQ9CSgkN+ebFOWHPsZJOIfb5gvy77TXZFTzlgu72GxGajE=
X-Google-Smtp-Source: AGHT+IGyJfqpcgtDVmjOMXtCz+0oLDtf0dzCOusgxBZqblHq/1JCpSWiFudvf9BUou9rxWIjou2mLg==
X-Received: by 2002:a05:6402:3549:b0:5d0:e73c:b7f0 with SMTP id
 4fb4d7f45d1cf-5d972e70945mr59582216a12.28.1736865623743; 
 Tue, 14 Jan 2025 06:40:23 -0800 (PST)
Received: from [10.232.133.36] ([88.128.90.43])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5d99008c371sm6377890a12.11.2025.01.14.06.40.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 06:40:23 -0800 (PST)
Message-ID: <bf40253d-f4ca-4044-8d6a-a6a9eab995c4@suse.com>
Date: Tue, 14 Jan 2025 15:40:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it, lufei@uniontech.com
References: <20240814101104.1098-1-lufei@uniontech.com>
Content-Language: en-US
In-Reply-To: <20240814101104.1098-1-lufei@uniontech.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] fix make check errors: replace space with
 tabs, remove unecessary spaces.
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

Thanks, pushed.

Kind regards,
Andrea Cervesato

On 8/14/24 12:11, lufei wrote:
> replace space with tabs, remove unecessary spaces.
>
> Signed-off-by: lufei <lufei@uniontech.com>
> ---
>   testcases/kernel/syscalls/acct/acct01.c | 6 +++---
>   testcases/kernel/syscalls/acct/acct02.c | 2 +-
>   2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
> index 60cf4681e..b9b08ef67 100644
> --- a/testcases/kernel/syscalls/acct/acct01.c
> +++ b/testcases/kernel/syscalls/acct/acct01.c
> @@ -73,8 +73,8 @@ static struct test_case {
>   	char **filename;
>   	char *desc;
>   	int exp_errno;
> -	void (*setupfunc) ();
> -	void (*cleanfunc) ();
> +	void (*setupfunc)();
> +	void (*cleanfunc)();
>   } tcases[] = {
>   	{&file_eisdir,  FILE_EISDIR,  EISDIR,  NULL,   NULL},
>   	{&file_eaccess, FILE_EACCESS, EACCES,  NULL,   NULL},
> @@ -126,7 +126,7 @@ static void verify_acct(unsigned int nr)
>   		tcase->setupfunc();
>   
>   	TST_EXP_FAIL(acct(*tcase->filename), tcase->exp_errno,
> -	             "acct(%s)", tcase->desc);
> +		"acct(%s)", tcase->desc);
>   
>   	if (tcase->cleanfunc)
>   		tcase->cleanfunc();
> diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
> index d3f3d9d04..74019f430 100644
> --- a/testcases/kernel/syscalls/acct/acct02.c
> +++ b/testcases/kernel/syscalls/acct/acct02.c
> @@ -186,7 +186,7 @@ static void run(void)
>   
>   		if (read_bytes != acct_size) {
>   			tst_res(TFAIL, "incomplete read %i bytes, expected %i",
> -			        read_bytes, acct_size);
> +					read_bytes, acct_size);
>   			goto exit;
>   		}
>   

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
