Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C6A5D6ACFB
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 12:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766061851; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=aCNfDZzZljmj8dJdhbmeBsVrgdEbTOUw4fOOBKO1ORI=;
 b=qig2OhJ8XpwL0xdsIz34ioeSsE2NzHXAaEi/l7sBk/dBKEaIMhsA5hl4SM4Op9mnmhBig
 PsRutaou+GKbg2ktKfXb/G6mqA1dh05W/tf4g7AF7hPK2GflowAwMzrAvtYQp9cb9Mlw9RE
 7mzqoLyOl6SnIS/JpsgCx1nPpSSTibo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A1B93D04B1
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 13:44:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BD583CBEC7
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 13:43:47 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 797016005D1
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 13:43:43 +0100 (CET)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6419b7b4b80so871488a12.2
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 04:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766061823; x=1766666623; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T5bnlHXPkxHNYsCk495HEdm/TYQNFBSCxUdYhmOeNj0=;
 b=a6x2IwRHjxjHgXiwra3uQpjkbuo9Xr55Fr8pR6tBepG1O9jFL9DNb+9Mo1j+DkIsml
 tg8bnH6eckVnfPTseBbVuASE6le/Ek5KpImgSQ1sfcnBtj9/NS8Ed5KIBE7mqtvgudL4
 M1HfOXTPGc8Q9j9x4xyE1jJ/qhyIdi8NHTZEGktSBrQjoQCPhaA5uXDHMrSLe0K1F+09
 iA5ZYM38LxFutrxhW0d0zEy6Uc85IbNEgh435Re3VcO44ZQDr95klIZUYqC69K98Jw/n
 7+wVW1OUkr/cpQYfzHuGqtNSwYifMaajI4KOraxLNSoV6qR6xRhQPeGwKrs22wfLzFe5
 k83w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766061823; x=1766666623;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T5bnlHXPkxHNYsCk495HEdm/TYQNFBSCxUdYhmOeNj0=;
 b=xNPZ7N0s4pJ604hI03bSGC0IHkB4s5HJ7yPi9TS8IHVAoLvTGP8gyVyR7cLkYJikyZ
 29rZ0WQEgSEtUGlCRHevV+n9xpuMRmJ+FumxnGC3c46M24r6fVFlMruat15LazTunAq5
 3tY5vDCDExcUQHQdy6kkRqxK4UDTUlqB7Hm1WvaxcslBceBBZ1EztGuP66JXmFQhejel
 T3pZZ3kC3auFbpLRhxLyoNYz1548cyfjNspm9V45PwyzQVpWhMmCMZQVfEQNjaqIXG6V
 r4OvUdA7uEM9YyfFQN3PRjFJq7m8EyRvGbIhE0IVMkeivqqSGA5sBg0VBX2jAKT7E4Md
 QOrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW58IeoQuMlysEngrIA+qfCUhdVF4R5YsAQkdL6vZKyUyzjuDRdgDB5BrD3Hdbb6idP6q4=@lists.linux.it
X-Gm-Message-State: AOJu0Yx6j7LoB0ZicAKepFsla57UwOxIwXJJ0isvjM8VOtcaqjNxTFz/
 gDVD3ylvp4XaC3hhbMZsJzZq/S8BLK+DCdiUo3qfwCSgDcVmnE/rdppZezNYO+I3VGvVVMPm6WQ
 yClX4qww=
X-Gm-Gg: AY/fxX6OIcR2oH2ZaDey357koXheKqKHPMivkOrvgi/6xa69cof6AxLlh2LUmHVJ/8R
 L11YkfUZZpXzilh3suQFxVdUH24V5yHBmhiJpRaOJRsuQLlBkKs57O3puESOPHrYbAehC6LUr6f
 2mowXDUvo5yy0sfVz97MhkmqL/IsH/Q7bPGqy/+WALi5jSPYA/IJJ2MiHnKIAs/Eno/skFVM6dS
 8vt67Xg8MfSuevcLQBBfukTR60TTW0dAj4n0gd5x/OQK4f1HsRgGmbtJ54xbPSCqxOUwrNB8x0y
 G3gmgptAn1r+1618FDH0mWi6wIyni2N6VZgVGct8h9IWkJX1c7+qVPyqRVXCmvmYRAIB+B0GuKI
 +Rs8TTbidEgu8UpEIZXPhANtaNWb7iTReD2CbRZ/1oWGM7XQZiRmO6D/rlktExKlPtrsYox3yia
 RoYxhrp3G1DAQpakY=
X-Google-Smtp-Source: AGHT+IHELsdQs5PJ4/Tvy9Xs3VXpJn/Xf8x+hFgZUVQj/YbA5kgwqVzhcHoPsZnpjd0AZHBk4Smvrg==
X-Received: by 2002:a17:906:ee81:b0:b6d:67b0:ca0b with SMTP id
 a640c23a62f3a-b7d23a7b1ffmr2210460766b.61.1766061822689; 
 Thu, 18 Dec 2025 04:43:42 -0800 (PST)
Received: from localhost ([153.19.102.214]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8022f9531asm222213766b.14.2025.12.18.04.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 04:43:42 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 18 Dec 2025 13:43:41 +0100
Message-Id: <DF1CO0LSLWLZ.36NGISAN8GB9T@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20250211205734.1932275-1-pvorel@suse.cz>
 <20250211205734.1932275-2-pvorel@suse.cz>
In-Reply-To: <20250211205734.1932275-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] tst_test.sh: Convert only TBROK/TCONF to
 TWARN in cleanup
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Tue Feb 11, 2025 at 9:57 PM CET, Petr Vorel wrote:
> Second attempt to convert only TBROK/TCONF to TWARN in cleanup().
>
> Also print original message to help find function call with wrong
> parameter.
>
> Fixes: 55bfa08e17 ("tst_test.sh/tst_brk(): Convert only TBROK to TWARN in cleanup")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> New in v2.
>
>  testcases/lib/tst_test.sh | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 5a6e34473f..0747f7aaf4 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -126,11 +126,17 @@ tst_brk()
>  	local res=$1
>  	shift
>  
> -	if [ "$res" != TBROK -a "$res" != TCONF ]; then
> -		tst_res TBROK "tst_brk can be called only with TBROK or TCONF ($res)"
> -	elif [ "$TST_TBROK_TO_TWARN" = 1 ]; then
> -		tst_res TWARN "$@"
> +	if [ "$TST_TBROK_TO_TWARN" = 1 ]; then
> +		if [ "$res" != TBROK -a "$res" != TCONF ]; then
> +			tst_res TWARN "tst_brk can be called only with TBROK or TCONF ($res, msg: '$@')"
> +		else
> +			tst_res TWARN "$@"
> +		fi
>  		return
> +	fi
> +
> +	if [ "$res" != TBROK -a "$res" != TCONF ]; then
> +		tst_res TBROK "tst_brk can be called only with TBROK or TCONF ($res, msg: '$@')"
>  	else
>  		tst_res "$res" "$@"
>  	fi

Here there's a bit of code duplication. For instance, we can save the
message inside a variable, as well as the T-flag, the use it accordingly
to TST_TBROK_TO_TWARN.


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
