Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EB3C87FCB
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 10:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754996179; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=xkX6vZyWSo//afF/1tnoq9mlJcm6IfK0tCO5koc2RpY=;
 b=pAz6V507oQW4/RpiDyaOTw9xJPYZZkf4AUY5a9QVdsGZWRA97sAAwUCVMWP4tZCkGaPo9
 AjaCaDHMSZ4ofzUD9woncQCkh4cSLCTbTOtfmv4pRhn+oELXO/kV0Qt5GhDlftgxmIszJ8r
 xKxrxFm8Ne9YacjX8q08V+iXAPi64Fs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCD453CB2F7
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 12:56:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70BAD3C0639
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 12:55:59 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 471D360029C
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 12:55:58 +0200 (CEST)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-61521cd7be2so7400511a12.3
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 03:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754996157; x=1755600957; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NHA6Cx9yjTqsiDL0ejaX5OtJX9b8M6v9TNEXT88U+2s=;
 b=bfUC27ojL2QTV43TRAhdg6hg0sBlvhKx6fhGNShcaVuFUK+PALTZL1s9UggZhJSas/
 la1ERn+aASv7BPRo+zPXVP7gz1V+jaIa+BsVifWTt+JpT47GNHIhUpw+N7ZkXKcrNis3
 QWET8i1pdPWuvsp3ioLqr0vHv9yMVjWc+TM7Y2dM8KnxLF0g+5ZUZ2grpOkfTpc9FFbP
 ItcMqLhqjDprOINXU1S84yPapokx9enfvVHmeAkKdLNaIUQnfOGuGwNGsxAsXcKm1Q41
 v3nmX0QiSdn0JIR+BdhUKdjrA1Mi0wWfQmOInEJiLUfAwjG6uisHrcNi0eVlXe3x/YwS
 b7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754996157; x=1755600957;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NHA6Cx9yjTqsiDL0ejaX5OtJX9b8M6v9TNEXT88U+2s=;
 b=FSzDfO+rQsZuyR7YZ+FaxBfrUjRgWEeV9I/0pz7kJliEh+9cF4mdhbfskdV6LognQh
 sBI14vtTQCv4VwPc+kfMWt6acYTv2IToSwRNPVH3CdoyF4Rd6J0ahKZtI1Q3bcq4WAG4
 IfSnxUCj4m/a9jiTjuF698Q+SjMwBREHu5Z7xa3Gh1xRmlKreLyqDIBg1YgtQZbSGTgI
 zxZZykyyft+MepmRWFsthdAxeLg61R8ZJQiP/wHoWh3nNHk2PIvl1pBJpoIORr3YJmt4
 P64mTCIqpeWMK5GPZPDB3a1xIoRPgfx7uXGtSfhWrm1BCUS4NHiZpzOpW0RM1e1wB8X/
 Du+A==
X-Gm-Message-State: AOJu0YyS552emCU04jJ4QlxF/em3AIe4X4Kppmxp7xTR8i2fAMZNA3X+
 IJCmiyM7IxxwYVKGNBeDVjzaajb3Uh0qlbGF3PWhibaOY80RB2q/vx+oSgnF8GaA3y4=
X-Gm-Gg: ASbGncsVxmZ865j6w/HfpBkcHkg1j6WA3pH8NSNslt9ywIq0Q+xK57a2bXYuiqRgGSm
 xLO0o31vKGVcX2NRvxA2E6lOd/GRPwjG67GLAI6yuRoy4mTfBXkLtO4Es2T1w+tdhC+6R79Umq8
 fguKN7F1RUXxoYFuYiNBaFK6KIv3aRHjaXmqWaz9Y5Dcl1lmXZglgxJyF4jLSIGeTfSVWRTAbei
 ViYXss6/Lan361Y6cASDKR4I+Cg/JooqgIJ53y4XOTP1AJB7xHtm+pSy9z1LTq8wcgTF1FLRiNX
 i6+ZPfMCp7DUmtRjt7+tNmyHEhS+vPDIaQtZ0SxYelJYXGgExC+edeYR43Nyl91vExH8iQge9+r
 o4jseXE36Y5ScC/VMdcODYwF8WvnWlAio/w==
X-Google-Smtp-Source: AGHT+IFJzY4LICr3CU4BB8MPMiqsj9sN1nlsESzPsgcAsSlu6lAmcSsgNxr+8KZuA6pD64WXJNFdVw==
X-Received: by 2002:a05:6402:5216:b0:617:d98c:3fa4 with SMTP id
 4fb4d7f45d1cf-617e2c4bbeemr13129645a12.20.1754996157414; 
 Tue, 12 Aug 2025 03:55:57 -0700 (PDT)
Received: from [192.168.1.91] ([151.71.217.151])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61836f324c6sm2890701a12.18.2025.08.12.03.55.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Aug 2025 03:55:57 -0700 (PDT)
Message-ID: <8a13181b-5fbc-4a10-9904-24fd26cb1ebe@suse.com>
Date: Tue, 12 Aug 2025 12:55:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20250812-cve_2025_38236-v1-1-e3617ada69c6@suse.com>
 <20250812105127.GB835467@pevik>
Content-Language: en-US
In-Reply-To: <20250812105127.GB835467@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 8/12/25 12:51 PM, Petr Vorel wrote:
> Hi Andrea,
>
>> +++ b/testcases/cve/cve-2025-38236.c
>> @@ -0,0 +1,101 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>> + */
>> +
>> +/*\
>> + * Test for CVE-2025-38236 fixed in kernel v6.16-rc4:
>> + * af_unix: Don't leave consecutive consumed OOB skbs.
>> + *
>> + * The bug is triggered by sending multiple out-of-band data to a socket and
>> + * reading it back from it. According to the MSG_OOB implementation, this
>> + * shouldn't be possible. When system is affected by CVE-2025-38236, instead,
>> + * skb queue holds MSG_OOB data, breaking recv() and causing a use-after-free
>> + * condition.
>> + *
>> + * Even if MSG_OOB is mostly used inside Oracle's product, it is enabled by
>> + * default in linux kernel via CONFIG_AF_UNIX_OOB. This is accessible via
>> + * Chrome's renderer sandbox, which might cause an attacker to escalate and to
>> + * obtain privileges in the system.
> Maybe mention it's based on the reproducer from
> https://project-zero.issues.chromium.org/issues/423023990
>
> (That adds both background info + kind of credit of the author of the patch who
> was the author of the initial reproducer).
>
>> + */
>> +
>> +#include "tst_test.h"
>> +
>> +static const struct timeval sock_timeout = {
>> +	.tv_sec = 1,
>> +};
>> +
>> +static char dummy;
>> +static int sock[2];
>> +
>> +static void run(void)
>> +{
>> +	int ret;
>> +
>> +	dummy = '\0';
>> +
>> +	tst_res(TINFO, "#1 send and receive out-of-band data");
>> +	SAFE_SEND(0, sock[1], "A", 1, MSG_OOB);
>> +	SAFE_RECV(0, sock[0], &dummy, 1, MSG_OOB);
>> +
>> +	tst_res(TINFO, "#2 send and receive out-of-band data");
>> +	SAFE_SEND(0, sock[1], "A", 1, MSG_OOB);
>> +	SAFE_RECV(0, sock[0], &dummy, 1, MSG_OOB);
>> +
>> +	tst_res(TINFO, "Send out-of-band data");
>> +	SAFE_SEND(0, sock[1], "A", 1, MSG_OOB);
>> +
>> +	tst_res(TINFO, "Receive data from normal stream");
>> +
>> +	ret = recv(sock[0], &dummy, 1, 0);
> +1 the core part from the original verifier.
>
>> +	if (ret == -1) {
>> +		if (errno == EWOULDBLOCK)
>> +			tst_res(TPASS, "Can't read out-of-band data from normal stream");
>> +		else
>> +			tst_brk(TBROK | TERRNO, "recv error");
>> +	} else {
> very nit: using 'if' with return is more readable than short 'if' part and long
> 'else' part:
>
> if (...) {
> 	...
> 	return;
> }
>
> const char *msg = "We are able to read out-of-band data from normal stream";
> ...
>
>
>> +		const char *msg = "We are able to read out-of-band data from normal stream";
>> +
>> +		if (dummy == 'A') {
>> +			tst_res(TFAIL, "%s", msg);
>> +		} else {
>> +			tst_res(TFAIL, "%s, but data doesn't match: '%c' != 'A'",
>> +				msg, dummy);
>> +		}
>> +
>> +		SAFE_RECV(0, sock[0], &dummy, 1, MSG_OOB);
> FYI: on vulnerable kernel with SELinux I get (nothing to be fixed):
> cve-2025-38236.c:48: TINFO: Receive data from normal stream
> cve-2025-38236.c:60: TFAIL: We are able to read out-of-band data from normal stream
> cve-2025-38236.c:66: TBROK: recv(3, 0x4391d8, 1, 1) failed: EFAULT (14)
Maybe we can verify at the beginning is SELinux is enabled. I don't know...
>> +
>> +		tst_res(TFAIL, "We are able to access data from skb queue (use-after-free)");
>> +	}
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	SAFE_SOCKETPAIR(AF_UNIX, SOCK_STREAM, 0, sock);
>> +	SAFE_SETSOCKOPT(sock[0], SOL_SOCKET, SO_RCVTIMEO,
>> +		 &sock_timeout, sizeof(struct timeval));
>> +}
> Why is struct timeval needed? I haven't found that in
> https://project-zero.issues.chromium.org/issues/423023990
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=32ca245464e1
>
> and test works as a verifier without it. If really not needed please remove it
> before merge.
We need to set a timeout for recv(), otherwise it will stuck on systems 
which are not bugged.
>> +
>> +static void cleanup(void)
>> +{
>> +	if (sock[0] != -1)
>> +		SAFE_CLOSE(sock[0]);
>> +
>> +	if (sock[1] != -1)
>> +		SAFE_CLOSE(sock[1]);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.needs_kconfigs = (const char *[]) {
>> +		"CONFIG_AF_UNIX_OOB=y",
> Although this is true I wonder if we should limit the reproducer to this.
> If one day config silently renames / is removed (but OOB kept) the reproducer
> will be lost.
That's valid in general, I can remove it but I don't know if it makes 
much sense, considering that feature something which is nowadays 
disabled in many systems due to this bug.
>
> LGTM, thanks for a quickly porting the reproducer!
>
> With added entry to runtest/cve you may add:
Forgot, thanks
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr
>
>> +		NULL
>> +	},
>> +	.tags = (const struct tst_tag[]) {
>> +		{"linux-git", "32ca245464e1"},
>> +		{"CVE", "2025-38236"},
>> +		{}
>> +	}
>> +};
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
