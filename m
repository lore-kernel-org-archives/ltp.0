Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B19CD98D2
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 05:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781241316; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=pjllCHjeak+ZzRnZuztAzj9UN7o2h8D7Vd0O1kVOL7w=;
 b=d09Kzfor6SmxlmJsxPUbdkNWGXaYO5unm7HsEi2pBgivC6OcOmsg5dGI1h56FzyOx2h4V
 nFGNcM9pJ6O1aTw0EQfMT4hE5/eANo4qhMhU1hrmCv+QXfgwWX6N/H+k5Tojs90TTvtYoyj
 ntdmSMFLHV7oF7CO+LcmgAe1qEWux/E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4F7E3E2776
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 07:15:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F2553C19F0
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 07:14:55 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9DB416008B0
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 07:14:49 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490abf12f0fso2930895e9.0
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 22:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781241289; x=1781846089; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ICS11ZI6XVGD74+7hYSXf04wLZbCykfOfalfUCaJFqw=;
 b=IQ4pRGzCXCo8m3lLnNBA9bi6xCnjj0Id2hEZeKyhHJ2AzIrxPjNqKhvkE+avIRcvTF
 /r7vtTVYkbJHgjZZ4jEe3zzFynbAYROdaIRdaVNxoMEarJRVA0XR22caJsguaR1XVjFs
 yrNhfsQnEPYmJQkdfcfUhdtwOv7NP+dSyzLGXxvDA64+GfpQJziAmmbI5fdm0pgn7lG4
 k3e80M0dsoixwFPJkCX6fMhjlZ3mSI+0lL8otKXJYh5yPq+oPp7ExCMipAE4cfDXjhw/
 fZ/kWq/1UlXiqBfcXdRLJeUXsxAu6V5wrn/0hMWwx4Wk9V3CHLqoMBn/14XHMwG8vVkE
 oweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781241289; x=1781846089;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ICS11ZI6XVGD74+7hYSXf04wLZbCykfOfalfUCaJFqw=;
 b=dYg3fx05H4K6g7OyW1USs4yICN/ySUraa8AEuHlNBAeeBMXiVW6g2GloX7MmieSMNe
 HiV/oewNxpyJAwcrpk35Qw6xvIW0uP9D1bE/6YXmWIV3mhrbK0Q5TYrajM1zvJUxEzeL
 oEtnnnfz5xOXHH/cHSPaaNQ7SQ8RPVER4JziB7zSiVSvUlKKn104qmjJwYzZs9GI62H8
 8HdRlnR17uC1iAq3pj4wqFXCrPzmwHnvYo6035bD4dc2VahOEhnItxkDuyojpAfiu8xC
 C0HEXfyj0fSUS3REAAYKBbk4o9j52XXO1ELP7MNTavSLInv2anCt56rRncgu/DTWimC7
 LONA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8VfxfvHwE62uJnk9RtT/xW6vIQvwVgvNzbSNHU+Ghm5Rgf/OJ/eDYv/QrX5np7+lq47Mg=@lists.linux.it
X-Gm-Message-State: AOJu0Yw1x+FWbl8aERMIE31Ntq54BG+VQFeYu8CWkRFh5oIWz7/fuwmi
 4EgghBRPQ0BvOwDXa885eADl5C+MhTCEg3UPqd279WjL0d6PE8hSDwRy91J7n7mMKvsDTs69HuV
 wzcLSFts=
X-Gm-Gg: Acq92OGkyrwcU6WD+2+jMytj9H0B+Gh6+3Pqv4nfTBPM50ga/VvQxr9cRXT5zX5WNbC
 zMiofHwNVjzo6KGvzVwAb98zNpS0NQOeKia2vuniMuGrReSKBfj+ZHq+EhMwMiYhKp2uPZs4TLQ
 UyTveofqaB2KgODfIassqPDByNMwwN0OI2nLPG0d/enfK3MyAN7ndILFCfWKLiqUe2hmTIfd96U
 xw8JIUh7MN+mV1NH3XQXI38+j72Exuwdey0TZQL0Nyk8/gtJcTHprUf1+zZ5vpoi3WuWO2VMI+K
 deuH3sBHO+hCmGe2NxGD0vBmXPYeSkj8M9l7pvpC46iVmntUHjofUEMqpnWjPPPsRN36aL3hU3u
 3atNMe/zpEKIw79Fwpeh3FmA+68dx8WNLTU4jg5/Y5mt5h+VEWyOXbs+4KQJ4kyWGE2WM5kdblm
 lbbltOtGO8oukX3ErgGScGNK2j8H8xzXPzXBmIQEBH
X-Received: by 2002:a05:600c:4512:b0:490:b26c:64ad with SMTP id
 5b1f17b1804b1-490ec491e93mr9062585e9.5.1781241288950; 
 Thu, 11 Jun 2026 22:14:48 -0700 (PDT)
Received: from ?IPV6:2a07:b241:1004:8300::1000? ([2a07:b241:1004:8300::1000])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea7db9c6sm37033555e9.8.2026.06.11.22.14.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2026 22:14:48 -0700 (PDT)
Message-ID: <201c8991-f58e-4f00-abc2-e03633ed3e1b@suse.com>
Date: Fri, 12 Jun 2026 07:14:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260611-fix_clone11_min_kver-v1-1-264fba2b01b4@suse.com>
Content-Language: en-US
In-Reply-To: <20260611-fix_clone11_min_kver-v1-1-264fba2b01b4@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] clone11: skip CLONE_NEWCGROUP on kernels < 4.6
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>


On 6/11/26 4:03 PM, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> CLONE_NEWCGROUP was added in kernel v4.6. On older kernels such as
> v4.4, the flag is unknown and clone() returns EINVAL instead of the
> expected EPERM, causing a spurious test failure.
> 
> Add a per-test-case minimum kernel version check so that the
> CLONE_NEWCGROUP case reports TCONF on kernels older than 4.6.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   testcases/kernel/syscalls/clone/clone11.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/clone/clone11.c b/testcases/kernel/syscalls/clone/clone11.c
> index 028da778158de6867a71ac3974f9c2263481d3a3..607e42585fad41784be9104be01f504218559342 100644
> --- a/testcases/kernel/syscalls/clone/clone11.c
> +++ b/testcases/kernel/syscalls/clone/clone11.c
> @@ -21,9 +21,10 @@ static int *child_pid;
>   static struct tcase {
>   	uint64_t flags;
>   	const char *sflags;
> +	int min_kver[3];
>   } tcases[] = {
>   	{ DESC(CLONE_NEWPID) },
> -	{ DESC(CLONE_NEWCGROUP) },
> +	{ DESC(CLONE_NEWCGROUP), .min_kver = {4, 6, 0} },
>   	{ DESC(CLONE_NEWIPC) },
>   	{ DESC(CLONE_NEWNET) },
>   	{ DESC(CLONE_NEWNS) },
> @@ -40,6 +41,13 @@ static void run(unsigned int n)
>   {
>   	struct tcase *tc = &tcases[n];
>   
> +	if (tc->min_kver[0] &&
> +	    tst_kvercmp(tc->min_kver[0], tc->min_kver[1], tc->min_kver[2]) < 0) {
> +		tst_res(TCONF, "clone(%s) needs kernel %d.%d+",
> +			tc->sflags, tc->min_kver[0], tc->min_kver[1]);
> +		return;
> +	}
> +
>   	TST_EXP_FAIL(ltp_clone(tc->flags, child_fn, NULL, CHILD_STACK_SIZE, child_stack),
>   		EPERM, "clone(%s) should fail with EPERM",
>   		tc->sflags);
> 
> ---
> base-commit: a375e8deed471723f5a0114c56eb48fe6f6f45d3
> change-id: 20260611-fix_clone11_min_kver-394cf499c2c7
> 
> Best regards,

Regards,
Avinesh


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
