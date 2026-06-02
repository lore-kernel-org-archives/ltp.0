Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1B2CD6E57
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 11:27:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74FA13E23C4
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 13:27:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DA1A3E1DBC
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 13:26:59 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A22B11A00438
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 13:26:58 +0200 (CEST)
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-9154ca1aa1dso309295485a.0
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 04:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780399617; x=1781004417; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qJSxytXS5CmNpiShiLFladLsvXYPEo8v45/C4sg3nV0=;
 b=pbyOJcCMFZa3pLu5+XFKdMrxMFODV8uYnsUmISm6g6FopoX9zVJoRKfskIZgOE8Ohk
 KHZbSjr9A7jzapq4OHsHxCUXMALrsJpnjmsIKMbH6rq//H9p5F/we+5/b5CCSwi8NIwo
 FofNCTlXVju87c5o3lKYa7up+HnLNscxbdW9A1LaK8cnTi1G3v3Mn2yYIT2MGM271g8K
 m2CbsczLxzn3P0DEq9NOXuvAboSexo3BiWsPREXK0Z9mGAouG8NaWnl7j8+cwPeUZArj
 s/7WlSJRsYl2TzrPELVE+ERr6RDdpPyvJymWbLHS60VTVZYZGsdBt18k9mOmtnzoCgbB
 pFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780399617; x=1781004417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qJSxytXS5CmNpiShiLFladLsvXYPEo8v45/C4sg3nV0=;
 b=LtYZzzfSSUU8rl17E5nTdgoDDfD9orF30ZfdO6wutd7QamU3UQOQ+OIsWCqG+IwCsS
 dE+kO6UhzawiVYkahFwAAH/OfvTqVa3zx0Tc0Oruh/db2SqAGn12kGuaDHH2OIg+ZaNv
 fUpvyja8H+kNXaryIhGCVrAfpklepE5tywoF6hLu1fx8e/9FVzpizddm+b4yfQSCvTW7
 x/G8yASLP1KCTfagNqAaADHcB5yDx6IIvUHDsUEQPuDcYKUDyIAgvg1ppTs4mxWhd1Ix
 M4kwc0biU/OK3vf1AOcTMnEmabWHO+Gdquu99Ys+wkUrus2RCmzcnu4SoyPfj7AhWUfH
 KvEg==
X-Gm-Message-State: AOJu0YxnRN6oWRRR3a/xr5tUhcTYcyj11joHoSfJPgJ2+dS5ryHJFWaY
 x5wsPV2gCCEoj2s7CWBZ5Axr8fchRCPItut56rXYtfyej6jOEESwcHnAmeHWzkh/yxg=
X-Gm-Gg: Acq92OFQWBV3Gal9zvjgAJYX2mqIw9wwhHvc5hVT7w0GPDjXxEWnwJ192wjeYKEmyl/
 0+Q8uiEPb0Ct1hokw+1Z+86bEs9RHS/DFPmQKJuAQfAZnkMoz4NjUKagqyElFgaOzfHyr938O/X
 hfvvzbbFBSgY+F5Pi1WNRmaQGCM4M0NUavoybGJZyIQu49QicUuSRNIOECyeRtCvzsdZ8QQqxK4
 i/M+/7xu/LIgJyxofjoMIDHtGtmAg+fkOwDA7mb5CbMGtdLFaWsFG2/FFYXAyL+l2FI0+g1cD0F
 Fa0lrvFMyIJvujOEmpbfm0HvmbcG6oBceAxt0oelIRo/kGgI4YYSF4VfvQwNociWFimXFyEIwVy
 S8way7CNx4gMYsGRTdh6GV0KToZLc3AcF5BAq7uWm68PQtUL7Dp66WTCGLWPNzxnYPK2dlQfHgQ
 fU507DGRINU7JSibd8MeCfPLeGh5SJLV0XNsn31lXF2Oc3/gVQe90VIdwy5JKx19dxJ5b5LJixB
 0eKN9HjzuLbC9IDT/dbpl211X/Iwv8vJkd/XWeUVPRj+OUB6XQ=
X-Received: by 2002:a05:620a:4081:b0:915:7787:200c with SMTP id
 af79cd13be357-91577f1fd3amr459559485a.23.1780399617394; 
 Tue, 02 Jun 2026 04:26:57 -0700 (PDT)
Received: from
 runnervm3jyl0.ysas3otiowhuxowhhblauwz2td.bx.internal.cloudapp.net
 ([172.203.213.80]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-91583668ebdsm41473685a.33.2026.06.02.04.26.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 04:26:56 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: panzhe <panzhe@kylinos.cn>
Date: Tue,  2 Jun 2026 11:26:56 +0000
Message-ID: <20260602112656.4143-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602090214.252840-1-panzhe@kylinos.cn>
References: <20260602090214.252840-1-panzhe@kylinos.cn>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] gethostname02: Accept EOVERFLOW on alpha
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
Cc: LTP AI Reviewer <ltp-ai-reviewer@lists.linux.it>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi panzhe,

On Tue, 2026-06-02 at 17:02 +0800, panzhe wrote:
> gethostname02: Accept EOVERFLOW on alpha
>
> On alpha glibc's gethostname() directly calls the kernel
> syscall and sets errno to EOVERFLOW when the buffer is
> too small, because the kernel truncates silently and the
> string is not null terminated.
>
> On the other hand, the generic posix implementation used
> on x86_64 sets ENAMETOOLONG in this case.
>
> Fix this by accepting both errnos.
>
> Closes: https://github.com/linux-test-project/ltp/issues/1319
> Signed-off-by: panzhe <panzhe@kylinos.cn>

Commit message: OK.  The alpha-specific behaviour is confirmed by glibc's
sysdeps/unix/sysv/linux/alpha/gethostname.c:

    result = INLINE_SYSCALL(gethostname, 2, name, len);
    if (result == 0 && memchr(name, '\0', len) == NULL) {
        __set_errno(EOVERFLOW);
        result = -1;
    }

When the kernel truncates the hostname to exactly `len` bytes (no null
terminator), glibc detects the missing '\0' and raises EOVERFLOW.  The
commit message accurately describes this.

> -	TST_EXP_FAIL(gethostname(hostname, real_length - 1), ENAMETOOLONG,
> +	const int exp_errnos[] = {ENAMETOOLONG, EOVERFLOW};
> +	TST_EXP_FAIL_ARR(gethostname(hostname, real_length - 1),
> +		exp_errnos, ARRAY_SIZE(exp_errnos),
> +		"len is smaller than the actual size");

TST_EXP_FAIL_ARR usage is correct.  The array is passed as const int *,
matching the tst_errno_in_set() signature.  ARRAY_SIZE is preferred over a
hardcoded count.  EOVERFLOW is available via <errno.h>, which tst_test.h
already includes.

Note: ltp-linter was not available in the review environment and could not
be run.

Verdict: Reviewed

Reviewed-by: LTP AI Reviewer <ltp-ai-reviewer@lists.linux.it>

LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
