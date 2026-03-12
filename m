Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C13105A594
	for <ltp@archiver.kernel.org>; Thu, 12 Mar 2026 12:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773319951; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=94QoIPbK6xDO004P/MH2Ddwk8QCwuxgbjV48CFkIGgw=;
 b=BjDkEsfvFjdapcKTcunZ81XNFh83oD4um2MbEqZsKtDZYhFw5g0jtZDe4HIDIYLCL7lo7
 aePu26/ZG1oHsB+6SQyyjFOSxreUpzqIbuoPFcVnIKxkFrponpkPJnVFbeCp3/eZYQfcIU9
 Si1kXpr+CcfX2hJ89fTpO8/I9PWUknI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3DE633E4904
	for <ltp@archiver.kernel.org>; Thu, 12 Mar 2026 13:52:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42E633CBF42
 for <ltp@lists.linux.it>; Thu, 12 Mar 2026 13:52:07 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 54C75601F63
 for <ltp@lists.linux.it>; Thu, 12 Mar 2026 13:52:07 +0100 (CET)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48532925a4bso5211595e9.1
 for <ltp@lists.linux.it>; Thu, 12 Mar 2026 05:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773319927; x=1773924727; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=A06dZlzr53OyebV5snosqJPbuIjGq8VvsZAgMkSizJ8=;
 b=VxuLrYnSmG3Uft/3/pSGN9Q4+hmuGDEb+xIfq5GmuHIAm8wWHA9eVSuJu1+uBMAbKx
 ED6RX3sdTjjOEQzF5T+ulWHJ7ZkDyz2qZDl8j74/5DejhcPCZmDa6pGm6Wff15+rG/Nb
 84iprvRvOyedFkHK6XidxnT9XjI69PMX9GZuS9M3MO58H8igGk2ueTU1w1PPr6he3qka
 iUMFbrUPyjKFNWNS0HmMYLkbSb3I95ZPY3819jEAOpAToCgWTljmhHIPjLuEy77v57l3
 Z8ygq3k4N8QXjjyN7KJb/a5zD7sPqsxxSaa44d9jCNg5FtdE1iwEn6lyRp0UECDGAtXo
 QkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773319927; x=1773924727;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A06dZlzr53OyebV5snosqJPbuIjGq8VvsZAgMkSizJ8=;
 b=wpb8+XAcyFmw/RelnWANSuDY1laW/KwhmJAKWIuOJKcvF6uXGQJxUZQSC8BcYcCuSD
 MKpcNW9qypM4qmxHZov5+5QwPO4OBmEURbckcj3S0Mi2uqLLPC0W2FvGJvZi4YCqQTIP
 fmBSUg7Jypsv+4d3XOFeTk/BFPg+xJYyDusHAOwCoSnibA7Jm5f0P1DzGsjRSlAVfCPj
 2R8EPKJf9X70kNo4sr5Wl5l+8Dt31drWjPLEwBmzYpfTsDc0WLhZDp8XESK5DqnqVxf6
 X0SS2kIlanthzAK5wEH5bj9WiKKwqAea0korCR5RZIBB9qxyiTy+h9wflX0Hu+79WlbV
 8s6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu4J26bnIJbDKymAAPxmitWhh7mHOTtXCvl4vLd72Z5h60v4+XzvFKm5tXXb+fwkRtPRw=@lists.linux.it
X-Gm-Message-State: AOJu0YwF1cOlu46/yynK7Xp+nrT2X1av1K6y5NMyK3dv3qZArII4T26u
 iKIhW/R4a9t+TTNWvhIf1r5oAfZbt+8SsrWZ9KqeV7YhYjOQVaq1d/ah2Ae2wAUu7EE=
X-Gm-Gg: ATEYQzxw08Hz+v1sQm9qFaK6WzwKbfEKVrzwLcgKlOnT06sIWzeib1/GhdEChCQtadE
 0DDpH+b5VDRvMB42bNNKOMY3bpXsIVKFmk70ku5uSMEg+jOkCUQG5qFb30xLwEZtY1RGpBfjjUq
 dcJKoxLqet25UNJ+RFjyJjndeE0JwW2/v9TpxtJ+Y6UsXzkps35H1aJztF78AmUHOY2t/ceQe/8
 y1wqt1VqUcXeRtmV0M50kaEAtdmG29z4/geYlafmjnvmYvv/ZtcmKLUoPMRdTTGCWKQfAShi/Xf
 wigWo5yQjf+BrB280yEhZJWXAUOs0cqeV/Bt1Se4TXt8ymGb1woDu8mIVRvjljW+lSmurpaVrYb
 T8xh4S4nyE7XkMMHmk/nOPqNjCInfIry3tVDx10w3inJ9GllAM7YZtmnuDpnESZ1Nw3Wf2BQQoh
 +Jrj9w6lzRc6b0WT8tts1A/S7Yvmcv1mAA1Ep7EnOQ
X-Received: by 2002:a05:600c:444e:b0:485:2fc5:39e with SMTP id
 5b1f17b1804b1-4854b117cdbmr106285165e9.27.1773319926566; 
 Thu, 12 Mar 2026 05:52:06 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.60])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854b0dc8d7sm40441695e9.25.2026.03.12.05.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 05:52:06 -0700 (PDT)
Message-ID: <69b2b6f6.050a0220.2bf2a2.e73f@mx.google.com>
To: =?utf-8?b?5oiQ5rit5ruo?= <chengweibin@uniontech.com>, ltp@lists.linux.it
In-Reply-To: <20260305062347.449223-1-chengweibin@uniontech.com>
Date: Thu, 12 Mar 2026 12:52:04 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Change the fd validity check to < 0
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
Cc: =?utf-8?b?5oiQ5rit5ruo?= <chengweibin@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

> ---
>  testcases/kernel/controllers/cgroup/cgroup_core02.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/controllers/cgroup/cgroup_core02.c b/testcases/kernel/controllers/cgroup/cgroup_core02.c
> index aba387197..a5c8c9684 100644
> --- a/testcases/kernel/controllers/cgroup/cgroup_core02.c
> +++ b/testcases/kernel/controllers/cgroup/cgroup_core02.c
> @@ -77,8 +77,8 @@ static void test_lesser_ns_open(void)
>  		SAFE_MUNMAP(stack, STACK_SIZE);
>  
>  		for (i = 0; i < targ.loops; i++) {
> -			if (targ.fds[i] < 1) {
> -				tst_res(TFAIL, "unexpected negative fd %d", targ.fds[i]);
> +			if (targ.fds[i] < 0) {
> +				tst_res(TFAIL, "unexpected invalid fd %d", targ.fds[i]);
>  				exit(1);
>  			}
>  
> -- 
> 2.20.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

Technically, the message is not matching the logic, but is there a particular
case why you think this patch is needed?

Kind regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
