Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18678CCFA18
	for <ltp@archiver.kernel.org>; Sat,  8 Nov 2025 07:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762586425; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=x0VzL/A/YfeAblchJNQzgYLV+xjPsuB1c/GvEk/DeUM=;
 b=F/8YKIhrf4R8WNOE2/v9Rb3TrBHWfCttFQ036CdNLma2KMRQs/UoHu71Bb2+k1yc8Rbk9
 I8yxC3TqFs6CKm7lBKJjDN29//RUqMjthfiaDO2ObxMAeZ9w3j8e/+B/XSjGBti+9M7gCrq
 555uPXTUjRSNlffxeIl+ZCGxWxQobuI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3252E3CF1B4
	for <ltp@archiver.kernel.org>; Sat,  8 Nov 2025 08:20:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1567F3CC427
 for <ltp@lists.linux.it>; Sat,  8 Nov 2025 08:20:03 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 59A812003B0
 for <ltp@lists.linux.it>; Sat,  8 Nov 2025 08:20:02 +0100 (CET)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-640b2a51750so2842538a12.0
 for <ltp@lists.linux.it>; Fri, 07 Nov 2025 23:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762586402; x=1763191202; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2VCF6zqW7wx41GAsRy+BeJKyPdpKCGPqcPiJ0gpUqr8=;
 b=fL2t/P1MENYO4dvr4gyLqeuSgLpeJWLKKJ8jqmRCLINlRXLUbBZ9zeGCfWDsmFPNg4
 dxh92NEstKoZUzx4DAppAEfJzBZOg5BXkbwOOom4/cpkFJbLvz03h+THyz0mvxi5TMIy
 yO/cVQkBAjWOyDW0MPo/4fSGRzcVfpXs/izyFTkWdWoZp4y5NFyKYL8uvkUa6WttgyAz
 K1UqWygekAxCo3i4R7VahWsGyutqDp5pXeL96BQF14YHxapINKWMforTvNy9UW+V/lpy
 vXo8FJ9qNKoBNotlgfJ/4ZoRIz1QQJ1ieCJHvdu4kpzwau98QE1AZcoFGBSLuoMcXLGV
 j9XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762586402; x=1763191202;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2VCF6zqW7wx41GAsRy+BeJKyPdpKCGPqcPiJ0gpUqr8=;
 b=G2EByt4oEVY1b7IXdB+yom9u3Ol7mQyccN6UsMIotSeBpvJgse/wiXqgWEbcvu/f+O
 7w0IJQxmEOIV2/bKf3Qhed3s8D30bKN1sFVnuJvrmH3Bai1P02SRx8nFwhQQCHgebDHe
 UmN/6VQcdypl0xGhUyzQhcbWQPWQdgZDzlXrmHcINkXQNjRN3llnXzXY46aBhD6vnHPE
 Ucoi3C7r2buL1lNycq1fQVTWPJpWvgQcrzmk9VzGWka4N3C9ANxgxuB0vA7f6RZ3vtwg
 f27MFGhV2+t0wok2m6foM2WToL2eHnZz8FDADIbTEmvXH5UyXgb//vrN1YEPd8B4kS61
 3JYA==
X-Gm-Message-State: AOJu0YyVeNSLRHKogbCDHiTZ9b1ZRburlgf7IiTqHSdUgP4mSZPElQBm
 gmexwrIY08Ge02wid0Vb9ZByVEh4iVQFZQCIhOpNXudBZgMezGMgDxphSl3A7glI3FYEeWnwN/E
 yEvM=
X-Gm-Gg: ASbGncsy9/6kIcmkia8ZGnYcGwgg0CJDn2sSjQajTpTo0BcZwqu6bRTNrR60jjDU4Ga
 4bJ0gjmXBrAAhSN4GaYX1xSOKQ3ZAOEOPjLfL5U+gawj40Se30uN67fVjjhJHgcXQPm/xteJ0tc
 O2FWam7V5UCcndM7gwRfkxRDDEeyjXdImH9ZByIVyHb+LaWuCY/hdCfqdKjdRJpYow00KtbZcMl
 zYX2TAukT/LuuWIiMY2AvpO0J7Ow7D86s7aU1ysdd3Qj70NtXzKC8wqHvjGk9u6io4k7y4o0MNh
 QkBGmHfDCRkwQ/uN4mN4WMIvaYLzXmcCVOHJvgnR98qB0NNbcReb52umnmc9hHfSsNWU48QEeRM
 PGmlnawDaa3qe/dMleSvVPGWX3UfJnf3UXS/LYA1y86bih1G56JhMGwOxKr8+MRfhF7kEQEckQW
 RtrPbV3hg05aZtr4yY/MZMJ/k+fYA0q5WL0bImYrs=
X-Google-Smtp-Source: AGHT+IEeG/iuEJigcHxx/XQZDB4JQMTOaFdZD6M8ix/aSqOHiIUWBhntZP+i/gPH3ncmkFzFf/+iYQ==
X-Received: by 2002:a17:907:3c91:b0:b3c:193:820e with SMTP id
 a640c23a62f3a-b72e02ca102mr193218266b.13.1762586401696; 
 Fri, 07 Nov 2025 23:20:01 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b72bf97d3c0sm471919966b.36.2025.11.07.23.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 23:20:01 -0800 (PST)
Date: Sat, 8 Nov 2025 07:20:00 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aQ7vIAZMFlDJMdZ8@autotest-wegao.qe.prg2.suse.org>
References: <20251107102939.1111074-1-pvorel@suse.cz>
 <20251107102939.1111074-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251107102939.1111074-3-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/8] tst_cmd.c: Check brk_nosupp when tst_get_path
 failed
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Nov 07, 2025 at 11:29:33AM +0100, Petr Vorel wrote:
> From: Wei Gao <wegao@suse.com>
> 
> Fixes: 257394e4e3 ("Filter mkfs version in tst_fs")
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Wei Gao <wegao@suse.com>
> [ pvorel: fix return value: 1 => false ]
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> NOTE: this replaces Wei's patch
> https://patchwork.ozlabs.org/project/ltp/patch/20251107003041.28929-2-wegao@suse.com/
> https://lore.kernel.org/ltp/20251107003041.28929-2-wegao@suse.com/
> 
>  lib/tst_cmd.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/tst_cmd.c b/lib/tst_cmd.c
> index 2faf7c7430..79f547ab5d 100644
> --- a/lib/tst_cmd.c
> +++ b/lib/tst_cmd.c
> @@ -265,8 +265,14 @@ bool tst_check_cmd(const char *cmd, const int brk_nosupp)
>  	version_token = strtok_r(NULL, " ", &next);
>  	str = strtok_r(NULL, " ", &next);
>  
> -	if (tst_get_path(cmd_token, path, sizeof(path)))
> -		tst_brkm(TCONF, NULL, "Couldn't find '%s' in $PATH", cmd_token);
> +	if (tst_get_path(cmd_token, path, sizeof(path))) {
> +		if (brk_nosupp) {
> +			tst_brkm(TCONF, NULL, "Couldn't find '%s' in $PATH", cmd_token);
> +		} else {
> +			tst_resm(TCONF, "Couldn't find '%s' in $PATH", cmd_token);
> +			return false;
> +		}
> +	}
>  
>  	if (!op_token)
>  		return true;
Reviewed-by: Wei Gao <wegao@suse.com>
> -- 
> 2.51.0
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
