Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC300C44506
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 09:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783933874; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=n1h44o9ZBMXoA8a+fdLAXT0B45Xmna6QWglwJkLev6E=;
 b=HP2inbXZpwzBINondZzIqqLHcb+tbWviaKtjs6ZD3fuJmqy6enNfOaj6mtsWscK3EKAi0
 +C2adMpLywkDc0t+vHko3Q32nV3dpPfg8vC/rxAXNsFtsncaN6nCvpVvqE72DywAbw73Ifo
 pv7qqH8aqXGI7rB/YabL6671FLTJaD0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 48AF73E2C62
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 11:11:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB2F63C73A9
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 11:10:53 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 11C9360028E
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 11:10:53 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493f140ca8eso18329805e9.1
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 02:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783933852; x=1784538652; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FzfNK7IwxnIK5A2z53UDZlFhtJHeU+D7vAPKbq5gt9A=;
 b=f/wWP4+WKdkJ/BnLr5XYMFlY7umlJg78v4GM9UClW7tTOQNFORap30OXIptqE0vPhU
 eJkV3A+qsXilhdera/GK4JlStaxMqAu6Igrj22Co0KOzNvoW71CQ0TOqk0ifxS6BL+Xu
 tSrSVW8sbmU7uVpRjOd/BcSA2+ywoKMbkNCvMnbtzyBisVE9ouU93vC470lr6gwZCv2v
 PNjXzJYdOGlGGOSDvugZeNCPG6rByBOuArMZ2eBtkt+eQxhdDvfdCu3kkONkvr9nzvAw
 I6Kw9IfOXagZ7Ex0PbsRdriKQISjNzsE1Qne9t05QrWx3B97IvhRLfKFFO4EeGfb68GF
 vcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783933852; x=1784538652;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FzfNK7IwxnIK5A2z53UDZlFhtJHeU+D7vAPKbq5gt9A=;
 b=U1XWbpVYHtAAZitOcIkoNRp4hExsJZEAlPJNpM9KIH8eHGXgfDkpUQ/LTh8qzZNS4z
 gwfnORi+HL3AzgayZ2jaPovd8paL27y1lfRJjxXMYu0DBqDcwTZSRfUdr0IbKA3GYNVv
 ApinTqx0ki+2n+MzTCqXNZLYj5FE4dJ41kLv5d+uda724cwEdRn3jH6AoZ7VRvaO6lFH
 s2rL7LXNyLvYwSlXuI1qGZFbI822z3jx8pO3wE5o4D7jL9OaUpNZ55F3qaV20S19PIQq
 eo0OID3pymkpnUYdgkTj9R/ajvp4MJlC/Qs9BzOFV2lF8cZyUqCLO4EIqNcEGGhZCafg
 aRXw==
X-Gm-Message-State: AOJu0Ywyr2zXae6+uWriw/DA3wV8jbCP0wNwFMGOsNjY6bBbLrf10igu
 8KmIspXeSXiF4NwHHjMztWOb6/TwzlljJn+BHXvwiVU/HQb8tpFlsnAGmzZfdXJdzHExNshGiwU
 4MflDwsE=
X-Gm-Gg: AfdE7cnVUaLrAPHSvDXreR580/DMqx7ZB968TuDr6wYzTT26LzVwEaBa1qNf4mc/f1O
 Ao9IghViG/f2kvmi3E7apXuddQ4ucrSAUTLzDDvmos8C7nEv/4Ok8FuJ2uANNPOrZ+ki8aFVLvu
 TC9XV8WSeeXqpfvHtqvNqh8C+zmjQ6PvSOf5rEYvfj3nDGp/jTotvuvA50SfuFh34THTTB+eKQa
 xF81VnWWrW2z7bOz4azZfdVxR/vVf7iRaMBVLq7iI61AnIUW35DQCcEsIU4cLSRxvC69iMhq6Oc
 ZMr10YHmmS5T3rN1OcioPhA8atzMlvBUqQfvKLxYzyOb4l+ydNtduqk6vQ0aH7nrTsuAD8GV5nG
 Y8raqJouAEBVOuQVhb1JBRC01GikbReQnvjA9CzlIU08AZnU5gHVPaMV82MUWBH4QtvYjopKAqC
 bwXyRTNV+YVeJCgjDprH1+l0CKM6uqb+gs/sez
X-Received: by 2002:a7b:ce97:0:b0:493:c2cc:aecb with SMTP id
 5b1f17b1804b1-493f8839b4bmr63406035e9.38.1783933852395; 
 Mon, 13 Jul 2026 02:10:52 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6ff6casm416800665e9.5.2026.07.13.02.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 02:10:52 -0700 (PDT)
Message-ID: <6a54ab9c.25509765.3b629d.6f12@mx.google.com>
To: "Stephen Bertram via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260710143155.588390-1-sbertram@redhat.com>
Date: Mon, 13 Jul 2026 09:10:51 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] pipe13: Scale child reap window with
 LTP_TIMEOUT_MUL
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
Cc: Stephen Bertram <sbertram@redhat.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Stephen,

> The post-close wait used a fixed 1000000 us cap on exponential backoff
> (~524 ms total). Scale that cap with tst_multiply_timeout() so debug
> kernels and LTP_TIMEOUT_MUL apply, fixing failures under parallel
> Kirk workers without changing default behavior on non-debug systems.
> 
> Before (only with case 100):
> 
> pipe13.c:50: TINFO: Creating 100 child processes
> pipe13.c:81: TINFO: pid 435007 still sleeps
> ...
> pipe13.c:81: TINFO: pid 435300 still sleeps
> pipe13.c:89: TFAIL: Closed pipe didn't wake up everyone
> The list varied but sometimes up to 20 would remained asleep.
> 
> After using tst_multiply_timeout(), test passes.
> 
> The failure before would happen, when using 4 paralell workers
> on a debug kernel, about 1 to 2 times when iterated 5 times.
> With the addition of the function, under the same conditions,
> it has not failed in 100 iterations.
> 
> Signed-off-by: Stephen Bertram <sbertram@redhat.com>
> ---
>  testcases/kernel/syscalls/pipe/pipe13.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/pipe/pipe13.c b/testcases/kernel/syscalls/pipe/pipe13.c
> index 5d76e1f00..cf1ccbcbc 100644
> --- a/testcases/kernel/syscalls/pipe/pipe13.c
> +++ b/testcases/kernel/syscalls/pipe/pipe13.c
> @@ -44,6 +44,7 @@ static void verify_pipe(unsigned int n)
>  	int ret;
>  	unsigned int i, cnt = 0, sleep_us = 1, fail = 0;
>  	unsigned int child_num = tcases[n];
> +	unsigned int sleep_us_cap = tst_multiply_timeout(1000) * 1000U;

Even better: we can create a function to reap children and verify
if they are completed while counting them.
Then we can use TST_RETRY_FN_EXP_BACKOFF() on it.

The problem is that we are waiting a fixed amount of time (~1s) that
is not enough when system is overloaded.

Most likely, when you are calling kirk parallel execution, other tests
are overloading the system and this test fails accordingly.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
