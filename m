Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F091DC87FCB
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 09:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754991834; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=hGLU9RjhxrW5iQ/2jzRIyNYtTm7qFeXAkVcC/atO1pk=;
 b=FcWcew2dj3cYt4BybQwEIQYaS5+bZihusFv4FswHLGBSHuxgAUnrqYRoI0nAbNgYolWEH
 TuRLxoGKBDN8+6tALcD7DbbWb73bFyvSORQLplkNVzLZ9Kzn+KijpVy+XIeQUbJ2WrgrkAQ
 LB3NJFdsRP/wFoVENh3x/afQ0kq/8ZA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D8993C06B5
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 11:43:54 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5F0A3C06B5
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 11:43:32 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DCD271400070
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 11:43:31 +0200 (CEST)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-6155e75a9acso8280686a12.0
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 02:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754991811; x=1755596611; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fGqcQgYNreqwDYg9+brhYEHuxvxzhNm6dp+KXyfqDDc=;
 b=Vh54ZOE1VwojFrliR3islCgVDZ9id+peyrc3AKiaybPYVr2MBSEyd1z+wkQdaEfJjd
 BTdTt7tLvy0WMxqBlYMpChS3KqSd4CdnHaTAd89hXPT8FxiTdoiLm505JRmX2yvX7qZb
 m0nHOijxrAF3BdYsHXNkEq9BPQFbGA1PZ31CAmYoGAvhJ6AC/f0zbqcVlvJ5CkjeJBg+
 MxfmhEbP7KcmparaKzYfjToygY9fIr91ImZiYIutAh/3P3Y1+Lpxs7pjYuuKmMoft5ar
 UGM2uDAmHDoww0FXCPKy1ODeKzQbRhlCOvN2YRD/YjuldMD/wELUtyPFuPBfYX4vf8i2
 ATqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754991811; x=1755596611;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fGqcQgYNreqwDYg9+brhYEHuxvxzhNm6dp+KXyfqDDc=;
 b=vac47ex2OYQcBqY4RrZSUgLXpjvcmijeUWLqRcyuPJWzMmaowuSG3fGAy+7EEB5CEv
 5VXCsQRnIP3XN1ZR+KTqV9jd6vX9WGkctJSLFetKCgiqPhdvKbNpND2HWiX/0rtrFnWZ
 QlTRxVEk4WnrbSyNlfoaduv5oJk4joNU7OdIIsL4gav60nNofubV3v8pV/TJ8VxPZFDg
 ry1eYuVcO0kQ2LgDEdEDooLv6lTn9vPKFFecJrJY0ZtGSAIqF+lTXfSYG9g/Z+OC9rbd
 tXzcz5gAxS0BYXV3iPNXdrITGTL0XOsE4u1uK2+D+NBFx+DFOOdq41NK8tAt4rUBv8Tt
 BgcQ==
X-Gm-Message-State: AOJu0YyTKLC8Rz/n3p+MY14ccYAYA8tu+APqnC1FdhPaKwVES9T4QyTr
 7ihWJuYlirEOXpiBCIYXZf2RVlgwQscLzTfACS6LO0m0a52u4ZviGUZ2v5nkJ3H33dIfh0O0pOn
 pt0jPaA==
X-Gm-Gg: ASbGncv2zCJKSNbiy1rupRuXINQBcepOru8bCCLmsLUINr4zac8WeqFsXCQURH3r6fh
 kCt1iHClL9otLc4xjyxZ6Rpf6NZlzh1S7nSy0pCEkdhx+mZwttuPHhDSqJh+Y96dZcpwmoWCETZ
 k16Di/NIvobrhHKgcsk+zkYmt4JtOGzFqWQHO4L31TQJlGRpSMPnSmK59Mu0DePmxFxGfz27Wgm
 jS0VjoPkHIf/7qnxn+kpFhK4Mh4HFilZrbQ7jaPGcwZjWi7dGLIO4U9Ja/D2r2r4pVL/4Dt8n0A
 N5U0bzBgDnAlhDZlLd7EVGWCqvqGacWe44vDA8dQgKMnAU2Vnyeozs83we+XXgDPeMxfCClkvgP
 FRaW1qn8bANA=
X-Google-Smtp-Source: AGHT+IFQmwKpUuJaLjlcwL2LIUdiP71cXM4PeHMG1loAlWVu1pC7nVycoYMlJsxwdnaGIWLWUlh3xQ==
X-Received: by 2002:a17:907:7e9a:b0:af9:8688:42de with SMTP id
 a640c23a62f3a-afa1e128dabmr231005966b.41.1754991810946; 
 Tue, 12 Aug 2025 02:43:30 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-af91a076aecsm2164028266b.9.2025.08.12.02.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 02:43:30 -0700 (PDT)
Date: Tue, 12 Aug 2025 09:43:29 +0000
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aJsMwaWb2kIQKEtF@localhost>
References: <20250812-cve_2025_38236-v1-1-e3617ada69c6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250812-cve_2025_38236-v1-1-e3617ada69c6@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve: add CVE-2025-38236 test
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

On Tue, Aug 12, 2025 at 10:45:59AM +0200, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Test for CVE-2025-38236 fixed in kernel v6.16-rc4:
> af_unix: Don't leave consecutive consumed OOB skbs.
> 
> The bug is triggered by sending multiple out-of-band data to a socket and
> reading it back from it. According to the MSG_OOB implementation, this
> shouldn't be possible. When system is affected by CVE-2025-38236, instead,
> skb queue holds MSG_OOB data, breaking recv() and causing a use-after-free
> condition.
> 
> Even if MSG_OOB is mostly used inside Oracle's product, it is enabled by
> default in linux kernel via CONFIG_AF_UNIX_OOB. This is accessible via
> Chrome's renderer sandbox, which might cause an attacker to escalate and to
> obtain privileges in the system.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/cve/.gitignore       |   1 +
>  testcases/cve/cve-2025-38236.c | 101 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 102 insertions(+)
> 
> diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
> index 3a2b2bed619c99a592f51afe50b7196c593f1f45..8eb17ce56b01070e47917f9bb44cf146c0c5b338 100644
> --- a/testcases/cve/.gitignore
> +++ b/testcases/cve/.gitignore
> @@ -13,3 +13,4 @@ cve-2017-17053
>  cve-2022-4378
>  icmp_rate_limit01
>  tcindex01
> +cve-2025-38236
> diff --git a/testcases/cve/cve-2025-38236.c b/testcases/cve/cve-2025-38236.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..68cb3d3ee2b624df2a6de2ce07da1d1e3efc8bb8
> --- /dev/null
> +++ b/testcases/cve/cve-2025-38236.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Test for CVE-2025-38236 fixed in kernel v6.16-rc4:
> + * af_unix: Don't leave consecutive consumed OOB skbs.
> + *
> + * The bug is triggered by sending multiple out-of-band data to a socket and
> + * reading it back from it. According to the MSG_OOB implementation, this
> + * shouldn't be possible. When system is affected by CVE-2025-38236, instead,
> + * skb queue holds MSG_OOB data, breaking recv() and causing a use-after-free
> + * condition.
> + *
> + * Even if MSG_OOB is mostly used inside Oracle's product, it is enabled by
> + * default in linux kernel via CONFIG_AF_UNIX_OOB. This is accessible via
> + * Chrome's renderer sandbox, which might cause an attacker to escalate and to
> + * obtain privileges in the system.
> + */
> +
> +#include "tst_test.h"
> +
> +static const struct timeval sock_timeout = {
> +	.tv_sec = 1,
> +};
> +
> +static char dummy;
> +static int sock[2];
> +
> +static void run(void)
> +{
> +	int ret;
> +
> +	dummy = '\0';
> +
> +	tst_res(TINFO, "#1 send and receive out-of-band data");
> +	SAFE_SEND(0, sock[1], "A", 1, MSG_OOB);
> +	SAFE_RECV(0, sock[0], &dummy, 1, MSG_OOB);
> +
> +	tst_res(TINFO, "#2 send and receive out-of-band data");
> +	SAFE_SEND(0, sock[1], "A", 1, MSG_OOB);
> +	SAFE_RECV(0, sock[0], &dummy, 1, MSG_OOB);
> +
> +	tst_res(TINFO, "Send out-of-band data");
> +	SAFE_SEND(0, sock[1], "A", 1, MSG_OOB);
Thanks for your patch. I have some minor comments:
1) I suggest check dummy value after each SAFE_RECV above also
2) Better send different char for different sent such as A,B,C
3) Is the second send operation necessary?
> +
> +	tst_res(TINFO, "Receive data from normal stream");
> +
> +	ret = recv(sock[0], &dummy, 1, 0);
> +	if (ret == -1) {
> +		if (errno == EWOULDBLOCK)
> +			tst_res(TPASS, "Can't read out-of-band data from normal stream");
> +		else
> +			tst_brk(TBROK | TERRNO, "recv error");
> +	} else {
> +		const char *msg = "We are able to read out-of-band data from normal stream";
> +
> +		if (dummy == 'A') {
> +			tst_res(TFAIL, "%s", msg);
> +		} else {
> +			tst_res(TFAIL, "%s, but data doesn't match: '%c' != 'A'",
> +				msg, dummy);
> +		}
> +
> +		SAFE_RECV(0, sock[0], &dummy, 1, MSG_OOB);
4) I think we need check dummy == 'A' here and then report TFAIL with
use-after-free
> +
> +		tst_res(TFAIL, "We are able to access data from skb queue (use-after-free)");
> +	}
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_SOCKETPAIR(AF_UNIX, SOCK_STREAM, 0, sock);
> +	SAFE_SETSOCKOPT(sock[0], SOL_SOCKET, SO_RCVTIMEO,
> +		 &sock_timeout, sizeof(struct timeval));
> +}
> +
> +static void cleanup(void)
> +{
> +	if (sock[0] != -1)
> +		SAFE_CLOSE(sock[0]);
> +
> +	if (sock[1] != -1)
> +		SAFE_CLOSE(sock[1]);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_AF_UNIX_OOB=y",
> +		NULL
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "32ca245464e1"},
> +		{"CVE", "2025-38236"},
> +		{}
> +	}
> +};
> 
> ---
> base-commit: e2c58cfcb82be0b376098a67c8f45264282be67a
> change-id: 20250812-cve_2025_38236-7cb0cd4fdbf5
> 
> Best regards,
> -- 
> Andrea Cervesato <andrea.cervesato@suse.com>
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
