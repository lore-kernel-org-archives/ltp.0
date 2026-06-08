Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C30CD8C92
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 09:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780910460; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=nvN0Or0UfDePHF8LiEmhPMD0Y42gi1SrSL/VLAWeTSw=;
 b=UIvSdvFiYgzev4W/OM79iKkbUHXR+drdRu3zalb2HuArHdurTQHl5cYu1qbBCfYAg1DWB
 8pTodaiQVw44Oxx3F023KT4TR11zLysfN23YuPLui0qfct4QR0/9mpyB+3nyty30K0mTsq9
 9CqDAWSRuieRRGNjHv5keadegDSK4pI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 061C73E5F89
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 11:21:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 511ED3C0039
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 11:20:40 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9D1B96002AE
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 11:20:39 +0200 (CEST)
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-bec4639953dso716141666b.1
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 02:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780910439; x=1781515239; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=77c9iMnIxIk2HiLnQQRt6+FS9la8ORz2syx1LZwlJNM=;
 b=QfdgSXYPyK3aD3Yau2nUbZi+rj6tfeDmsc0esaD0h3HFcGUy/6ihAJS/7Ngb094aGi
 cJou6lV6DMigG1iko9jAowZWIVzlO8B3rtJEVSukIEZLOwPSoQhfTpeyQwK0YpTallNL
 n6gHacJxWbltYyBKkaTk6s4AP/Rp64NEqyY+0KiyDJIDZKwKLN6h1a791VUfXad156bn
 o1XF4aFFpnOTq8nFnWrUMfRt/Rk/wjxV0a3OCvYnzKQ/0RaKo9BQjHB9AAwB3OAMtsqW
 fFVNu3l4sfQNA1JJ1WW+iXyDn6931mE0Y0AMgifNtUXfog9Rr23Ljd0ifIc6I7JQazki
 wTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780910439; x=1781515239;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=77c9iMnIxIk2HiLnQQRt6+FS9la8ORz2syx1LZwlJNM=;
 b=rJIfnKS8BoV5KjVnOcVeflGARUtl0QL9JtsQmwvTCk5h2TxPpJPL36YyuEL17zhUAb
 21ejZetWoX7s0fHyuIZF4yVFrdEnKRPSyTxBB+Hi6XX6x6zMS+u0yyqaR9UCoJav/hB4
 ujPqYRs1t2XN70M3LbUWFIueIYn/iKaF7huhiDk4yPZaTz6JpSB8z4rXy5Kbp2/1y4V0
 xozdt7XqsIwLlxJtihfkp8iDu71g2kqq1+X5nJlVzSCwcTQhnXT/xH3Aw044I/yd4RTm
 BipONISVvhXHZVMkksyynylWJgVYK5C0+eN6oUHfF5H2xUMWtLweqcH4Dka3axLaU/cX
 M6XQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Qr5WrFVPjzjcc7e8J7PD09d5GMtnGhx20bC0oGrlmK6at2zH+ES+lESfqovyhUvZGJ8A=@lists.linux.it
X-Gm-Message-State: AOJu0Yx48re9wshZuPjEcdP7dkEzou0uJ1mhvrjV5dc0Xeo+aVXOPQhv
 uZ4aU27GLbMTX7TYSr8d/leFA/gL6VRHWr7fk2FzxdptnbXPFa+prAHOjAs+GyPMNZM=
X-Gm-Gg: Acq92OE50DuK3NtzvaaI1JOghBIjGmWLw3Hsj7EKCYO7boF/xgwUGwLIOb7Vcuyc7t/
 WWvKy3zcRV5NmUj9vmZnjECVyZ6l9U6Mu5RYI2UV3fFUi6Ktg0D+cwNkTlxsKroY8FQ3Wkr3nJM
 iLnXaatZMsdFy1s05dvjZTe81H8RzPETxvwV3hnsQv+B2/Va30eF42wLR4bC3eVUcAkfVy+KHly
 lnOYA3bl27dFVmTR11Qfob2A/waejFBWaxY0Jdt+q0s5L0PxQga42neMJR/NoqvXFOYWeCLtAGA
 2I3R8/9aP1jTolSfrsBlPLhs1XWxF0t6mNOXUYrknt+XIDJuCksLBG/4qzyaFnmH1BQajRZP+7x
 +IeRHC4S1E8PlcS6I0MKIQJHiPWIZwCOO2S8FLmvc5FEAJsRC3Ccl5WmsIm4OW3ctnpixw+4uVv
 q54stpf1AsFrNAyjnz2vIQ94buN0v+/rO19+HEajp38IdMtBS4OuA=
X-Received: by 2002:a17:907:6c0f:b0:bee:f402:5567 with SMTP id
 a640c23a62f3a-bf37283bdb0mr678690666b.41.1780910438814; 
 Mon, 08 Jun 2026 02:20:38 -0700 (PDT)
Received: from localhost.localdomain ([37.162.88.57])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e64c2ef2dsm6733391a12.1.2026.06.08.02.20.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 02:20:38 -0700 (PDT)
Message-ID: <6a268966.415315f7.3b149a.b50d@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <aiaI90UCa6OTP3dN@yuki.lan>
Date: Mon, 08 Jun 2026 09:20:36 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ksm: Fix sysfs path concatenation in ksm_test.h
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> @Andrea the bot still misses existing patches:
> 
> $ git log 40a366b53adc
> 
> commit 40a366b53adc477d950cc73f071b0cd4ebe25f85
> Author: Li Wang <li.wang@linux.dev>
> Date:   Thu Jun 4 17:41:59 2026 +0800
> 
>     lib: Introduce tst_path_defs.h to consolidate system paths
> 
>     We have a lot of hardcoded strings and duplicated macros for /proc
>     and /sys paths scattered throughout the testcases.
> 
>     This patch introduces a new common header, tst_path_defs.h, to centralize
>     and standardize these path definitions. By unifying these macros, we
>     reduce code duplication, improve maintainability, and ensure consistent
>     path usage across the entire LTP codebase.
> 
>     Signed-off-by: Li Wang <li.wang@linux.dev>
>     Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>
>     Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Yes I seen, this is really annoying. I will find a way to fix it,
but it's supposed to be fixed already.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
