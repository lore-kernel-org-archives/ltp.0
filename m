Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E7ECA9EBE
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 22:23:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B61433EAA4B
	for <ltp@archiver.kernel.org>; Sat, 10 Oct 2026 00:23:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BF413E5C1D
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 00:23:06 +0200 (CEST)
Received: from mail-oo2-x06.google.com (mail-oo2-x06.google.com
 [IPv6:2607:f8b0:4864:31::6])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E8F981A010AE
 for <ltp@lists.linux.it>; Sat, 10 Oct 2026 00:23:05 +0200 (CEST)
Received: by mail-oo2-x06.google.com with SMTP id
 006d021491bc7-6ddeba3e85dso95894eaf.0
 for <ltp@lists.linux.it>; Fri, 09 Oct 2026 15:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791584584; x=1792189384; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v3xCi042EqhmATUmFvMUy09kqyOIF1j+LPUouZgD9lE=;
 b=oeKSoCeBZi0wUF36TuTYNOXS3P4a8cOUpaRfbWn4wkdTgyDqLP0qCLO4nruHdXBZEb
 h2xHeFINBdwVJmkeFjqmMV7g7KfSFLIOnMnakmz9B2LS4EH4GAIOEakXC4EMn3wjvEFS
 Nw+1TYJplJtjyb2ANYeWb+cpF2WTWDsftj7cWdzAaWJDV3dehTkT+KT+9++hA+4osb6E
 sRrs34NyC7CiRKH38BRxqLAgOkFAahZn5lKoxomFGdA022VnEqtLLd4IJY8ygXCkVnlq
 UpFPZWJDG1QLfaMBqDfkW3CnzzIAsGLfMLljR5gekYRuQvXC4WLAO9NDrn6tQp7qTSWy
 q8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791584584; x=1792189384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v3xCi042EqhmATUmFvMUy09kqyOIF1j+LPUouZgD9lE=;
 b=xT5RST2TFAx3eug+xLBWkcLu0/CPz37fUgExLJXL4/MQAAmHWIXoC/XOT+88r54GZk
 YnOpa9zbBz09CTvnDbpKIm3IZrJ8M8FxbUNb+NRODYSdgTphk5HcvTNFG5mQrQSwOlT2
 GHhJFTStt0//ahqw5dwhhG+3uNGHk9jnxi+C3UKjUh1rZL+RWmVL5YXJwKEXd/GaM+Ch
 755hXqcdAqYkrob1/SJJ6+u/uEVYER2JDlMpKyOCGHqON2NGc916yeIHWgTy1ll+/2Nc
 0LcFIBakd37jF2Sx8DP14a8faxIGGTfXsNFAzlGJxh87vKuZdDRSorPJGCUXgPGP39Yz
 n0rw==
X-Gm-Message-State: AFuF++lmyYGmdFpbqEQkpBcwAhpaRHhlTwcOfjR1Wop3LXXu68qW+A/+
 Rpz9Qf1675ihrKzv34Ry9Fe3ajg9O9217HxNXaPuaT4hr5X9+e02YKKB
X-Gm-Gg: AYBFou3bjkJm7aRP7wSkNy47FyBDyBJp3/zNBk9YZSaNnBsVHum5ghpPrHkFfxXWWTD
 Rtrl1OWzDyOaWQY1Vsid6CqoKwr/AAJwjy/dPpbWga9+60IabsaSg/hshmuWQ+OrWehuxqvzzhP
 87RV4riVl4n+LBEDW+v1bcZCQJeP0t3NRADF7ulif7hwJmOhzV2Ye9P7WapGTDVNogzqTS2ptRc
 upDZDhnZ90Gpkd3ZbRbkn5Ec99ChDjFTNfz1frKozXKKGMbKPHk/qLjcY5ugkpRYJ4zmEcPoY0G
 ZV6xFB0YMxsu3j4dIFY5OtdGdvVAoVwmSq6A011iD2CeFCmSJgXuNhXYxZoWn79y0jMWr78+52u
 gkdJvL7eAkgYzqzWlBdB5fwIQzM09YBr6TCFDD6cC461O1cXRmM42E/ZSz9cfcAaWeVo3T+oC9j
 C8Af4zqD1rqqe1Mja7ADoGNsFxUatTKbPHgyOaSluWf48SUEwrLnu3jymUyY2R0wouR1ke4B/F8
 PpjMc/I/Wk5d8Nr3x2Qq4QXMGuK2nYQdWP2EO7pmGiZQSJG5q4lReYF4Aa0x5S3F6ngm7VyPKTe
 G937lyuvzGPCiQ==
X-Received: by 2002:a05:6820:c98:b0:6b1:2f12:6c0c with SMTP id
 006d021491bc7-6ef0f7afe9fmr2504910eaf.34.1791584584497; 
 Fri, 09 Oct 2026 15:23:04 -0700 (PDT)
Received: from
 runnervmmprz5.bud053t52tnuhdprn10wdjgwhf.gx.internal.cloudapp.net
 ([132.196.81.228]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4a2a85132bcsm3296596fac.10.2026.10.09.15.23.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 15:23:03 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: dm.chestnykh@gmail.com
Date: Fri,  9 Oct 2026 22:23:02 +0000
Message-ID: <20261009222302.8971-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009183530.3114-1-dm.chestnykh@gmail.com>
References: <20261009183530.3114-1-dm.chestnykh@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] arch_prctl: add ARCH_GET_FS, ARCH_GET_GS tests
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Dmitry,

On 2026-10-09, Dmitry Chestnykh wrote:
> arch_prctl: add ARCH_GET_FS, ARCH_GET_GS tests

> diff --git a/testcases/kernel/syscalls/arch_prctl/arch_prctl02.c b/testcases/kernel/syscalls/arch_prctl/arch_prctl02.c
> +static int arch_prctl_get(int code, unsigned long *out)
> +{
> +	return tst_syscall(__NR_arch_prctl, code, out);
> +}

High: On x32, unsigned long is four bytes, but these raw GET operations
write eight bytes, overflowing fs_prctl and gs_prctl. Both __x86_64__ and
the framework's x86_64 architecture check admit x32; glibc's x32
arch_prctl wrapper uses a uint64_t temporary, but tst_syscall bypasses it.
Use uint64_t for the output pointer, both output objects, and comparison
values.

> +	if (gs == 0) {
> +		unsigned long test_gs = 0xabababab;
> +		TST_EXP_PASS_SILENT(set_gs(test_gs));
> +		if (TST_PASS) {
> +			TEST_GS_BASE();
> +		}
> +	}

Low: GS remains nonzero after the first iteration, so subsequent -i
iterations skip the zero-base comparison and ARCH_SET_GS branch; -i 3
produces seven comparisons rather than repeating all three each time.
Restore the original GS base after the changed-base comparison.

> +	unsigned long long __res_fs;                       \
> +	unsigned long long __res_gs;                       \
> +		if (TST_PASS) {
> +			TEST_GS_BASE();
> +		}
> +	unsigned idx;
> +static void run(unsigned index)

Low: check-arch_prctl02 reports missing blank lines after declarations,
unnecessary single-statement braces, an unnecessary blank line before a
closing brace, and bare unsigned declarations; fix these and use unsigned
int. Rename __res_fs and __res_gs to avoid reserved identifiers.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
