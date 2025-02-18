Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994A3C02198
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 15:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739891813; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=OHvkXWI76M6mjdqzg94TVu+Ger66PPmjlKXiWahbnjc=;
 b=rmDpajauhcbrKy7qeqCDEHmCPnIQn+3TaZoo7OJfjoMzIY8cc5Hg/dmy3kHea+8LeD8kz
 1sXC3/MHNLr2m4dmzglhMPZO74ldt0Ne2MTe5/+h3wW9UrCQoCGb3sYXp6ZojYeU7pjyHHQ
 Sljv549X5BycZy219nndhjyWLgoMgv0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 013FC3C9C70
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 16:16:53 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 828653C0722
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 16:16:30 +0100 (CET)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AB52D102E44E
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 16:16:29 +0100 (CET)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5dec817f453so9672718a12.2
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 07:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739891789; x=1740496589; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DDKYfWll8J6a1OTPIJ8oS/6gdBDe8uPmi406yf8cTrk=;
 b=YVKKhUAOiubTI0uLJzgCQFPjfGwijZOxIb78ahRqb8+vqetJ2TkMoaTA2VelNbZNGX
 Vf/pp0THcAqAJgyuizRwBnUAkri5A2ulGnEnRxEFj5yb9WRBm3YdyNPdlOkZn3S5V0XE
 D/VqhSLz36nIGvLYCmLlvtqBWbL834fkkHWbGFP19X4Bqxmij3otsmjLpYFVYGTUuSSl
 p5on/GG0Y4m9tOnuCna/1pHKK8mxibvSbTpzO/hmctaHbosCWVMlNoMI0HNIjPPoVL+S
 mJSVY44vD23uoT4qxzcMaYWY2I9PXwN5naGIwgWD5qp1Kg95lFZJpwsfBZOvfpfO/HKG
 93wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739891789; x=1740496589;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DDKYfWll8J6a1OTPIJ8oS/6gdBDe8uPmi406yf8cTrk=;
 b=ia8equdrdFe8nHUIfwXNkrVYghxADe5vc5jRJdCNmblXVA8/z9Q5fFQQAuUyfje9vu
 kXW94cscXY4MktH5dWxtfPIqnvck54B4HDW+VgGiakF3kc0+FS6AoSsfJnVnA0hz3QXa
 5HOlrFoZTmPEWoph+4Z0w/GKBl7eQyQFtfLYAq4D75rwuUTRnm1vgJ1We7O5tlNj3xED
 n1MgBE2rJEOmpcyOpJI0WOWNEnlCPPlbbc/lMl/pZxDkweco5+xl6ZQ3xRUsbJOANRwD
 neQHPHQpn/YY6Rfa57fQb1s7EQUJfzR/hUDAlUncTV1sjarPyKKgbV7htbAYF1uT5V5f
 Ww6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXFIMM82xA1QQ1RltuD5RFTb11zxBu3yzsEP2QPKuE2Th6ejl4Z0NdJ8NEtaOOZIEHBw0=@lists.linux.it
X-Gm-Message-State: AOJu0YzLfNKN9TL3FK3apB8jRNPxkeBnbKrZIo8krKRvFpbaOgpKpvJ7
 I8oaS+I2Vh0PA4uUF8iTiWvcOCIIdf2TsxGAUiIzytmo3rOPSj4QnLwuFC20Ao0=
X-Gm-Gg: ASbGncuhopzsZSNUUWwk2Njy2b8aQ64BKsa6yqrF0WD4KagoX/SvZuDlOjOMfvBcPQM
 96sc4NLm+rsQ+cNSd03daGtRQXeEadd+fekxtICbTehpZwliD04R+s3H2aT9DgNcpbimSKHYo5b
 gwVKsudGqgPCcqzEEHLzvmbGI5KqEcEuT5+bWEhVobQayF7RI67cpkYPNHILHbUns9975UEOpPO
 ddcru+NM5R8aZ7S9R/bmR9CBVXN5vs87ZDfCJLfxHveMq1N7441FnSfXSmiphiLO84m92wAmMUq
 1xmQuq8Y7h7eP95pZierCSGJQw==
X-Google-Smtp-Source: AGHT+IGO8U/9X++4vAwWgXvKQuHL9U1Y72haW3klV9xXpxoLizmVRUvTDjdXS7fjqbdETC0zlqCeSw==
X-Received: by 2002:a05:6402:2753:b0:5cf:e9d6:cc8a with SMTP id
 4fb4d7f45d1cf-5e036216f84mr14085243a12.20.1739891788950; 
 Tue, 18 Feb 2025 07:16:28 -0800 (PST)
Received: from [10.232.133.75] ([88.128.90.10])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece1d367dsm9027452a12.44.2025.02.18.07.16.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 07:16:27 -0800 (PST)
Message-ID: <f78329b1-2320-418a-8fe4-c47b37d3dbec@suse.com>
Date: Tue, 18 Feb 2025 16:16:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Dorinda Bassey <dbassey@redhat.com>, ltp@lists.linux.it
References: <20250217124804.143890-2-dbassey@redhat.com>
Content-Language: en-US
In-Reply-To: <20250217124804.143890-2-dbassey@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] kcmp03: Add check for KCMP_SYSVSEM before
 running test
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
Cc: sbertram@redhat.com, javierm@redhat.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

there are still a couple of issues we can fix.

On 2/17/25 13:43, Dorinda Bassey wrote:
> This commit introduces a new function
> `is_kcmp_supported()` to check if the kernel supports the
> `KCMP_SYSVSEM` operation. In the `verify_kcmp()` function,
> we add logic to detect when the kernel does not support
> `KCMP_SYSVSEM` and skip the test for that case with a TCONF
> result. This ensures that the test does not fail when the
> Kconfig that supports `KCMP_SYSVSEM` is unavailable.
The commit message can be simplified, reducing implementation details 
which might change in the future (such as functions names). We can use 
an imperative text as well:

Skip the test case verifying KCMP_SYSVSEM support if it's not enabled by 
the kernel configuration.

> Signed-off-by: Dorinda Bassey <dbassey@redhat.com>
> ---
> v2 changes
> fix coding style
> use `kcmp()` instead of `syscall()`
> do `is_kcmp_supported()` check in the setup and
> cache result
> use `tst_res` instead of `tst_brk`
>
>   testcases/kernel/syscalls/kcmp/kcmp03.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/testcases/kernel/syscalls/kcmp/kcmp03.c b/testcases/kernel/syscalls/kcmp/kcmp03.c
> index 37d5118d5..8610cea46 100644
> --- a/testcases/kernel/syscalls/kcmp/kcmp03.c
> +++ b/testcases/kernel/syscalls/kcmp/kcmp03.c
> @@ -42,9 +42,19 @@ static struct tcase {
>   	{ARGS(CLONE_SYSVSEM, KCMP_SYSVSEM)}
>   };
>   
> +static int is_kcmp_supported_flag = -1;
We don't need to initialize this flag.
> +
> +static int is_kcmp_supported(void)
> +{
> +	return kcmp(getpid(), getpid(), KCMP_SYSVSEM, 0, 0) == 0;
> +}
> +
>   static void setup(void)
>   {
>   	stack = SAFE_MALLOC(STACK_SIZE);
> +
> +	if (is_kcmp_supported_flag == -1)
This statement is not needed. We can simply store the variable because 
in the case malloc() will fail, we will never reach verify_kcmp() 
function anyway. setup() is called once, unless we use tst_variant, 
which is not our case here.
> +		is_kcmp_supported_flag = is_kcmp_supported();
>   }
>   
>   static void cleanup(void)
> @@ -64,6 +74,14 @@ static void verify_kcmp(unsigned int n)
>   	int res;
>   	struct tcase *tc = &tcases[n];
>   
> +    // Handle the case for KCMP_SYSVSEM specifically
This comment is not needed. Also, please run "make check" on the test 
before sending the patch so you will have the chance to verify errors.
> +	if (tc->kcmp_type == KCMP_SYSVSEM) {
> +		if (is_kcmp_supported_flag == 0) {
nit: in LTP we commonly use "!is_kcmp_supported_flag" format.
> +			tst_res(TCONF, "Kernel does not support KCMP_SYSVSEM, skipping test.");
> +			return;
> +		}
> +	}
> +
>   	pid1 = getpid();
>   	tst_res(TINFO, "Testing %s", tc->desc);
>   

Kind regards,
Andrea Cervesato


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
