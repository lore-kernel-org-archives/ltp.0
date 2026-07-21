Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6ADC44520
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 02:38:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD4F93E961D
	for <ltp@archiver.kernel.org>; Tue, 21 Jul 2026 04:38:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19B723C0571
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 04:38:16 +0200 (CEST)
Received: from mail-pj2-x01.google.com (mail-pj2-x01.google.com
 [IPv6:2607:f8b0:4864:39::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4CC9860006E
 for <ltp@lists.linux.it>; Tue, 21 Jul 2026 04:38:13 +0200 (CEST)
Received: by mail-pj2-x01.google.com with SMTP id
 98e67ed59e1d1-37fb1883fbfso2747469a91.0
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 19:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784601491; x=1785206291; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w33+8/RWSTMloZWn5FTjPtwF6h8MViPcrPKK2jTCLG8=;
 b=Fae8dvoHLfRAWQ1lhY8EOpo6mV9HDoUAovcVgScY287eTHPXG0kT0owKlOSInVVRdV
 TMJHaYvF99ESkzSysWOOpAoyMoBxbQpIN/lPMuUzIYpK/A56v5cD7ZMJbXtZsSOAdP/y
 iHmenOkg3hg6pXpQk1GjOXZO0aWAS8FsBiYsTVn9Ew2jCfY3uSQGYUxqyEXwx6xSgfZ0
 ddJdSAz5weee4qGKVKyiMKeM/Sm4a9kgQ2jIhhlg0e+CCO7aWW4vmDzr3y6ToLoiENo/
 cW7HCYBRHoYLxvla4gRAB5HQnD9J92H8TvcTJupyqvTGZlHrPrnEgFHA/upJBNcWXwNj
 VE8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784601491; x=1785206291;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w33+8/RWSTMloZWn5FTjPtwF6h8MViPcrPKK2jTCLG8=;
 b=ATAE5qkxX7aH6YxZJR403+UIbkrxRmD8JYzMrYK6zOMSkqF0Gdvec7jKE22hDdYELA
 t+fe8UHpCGdtm6k/FtWax/d+37BR/6WPd4Uoh8fi4IfQOW6DUOT+IR9rDwNWAI4zlPKO
 XrB6qJniAWw7lblZXyxdB769QNElpXZfqnbT0CIh+E+iS/g0puTbQFCjCOEp0FGrid8D
 Z0/OoYgKbF07BWdmKCG9Qbqbc87PkFzvsK259XsGL20ASvP1CM6G/t3PTmau+BqOZ45k
 BS+YoZd37ZxW5tG4Q4ZRDxgAJYDU4yzIadv2iFs3safbPXl1Jniw8AX7SLrbtJb14DCf
 1LEA==
X-Gm-Message-State: AOJu0YyiWEXbQ+wtB62dzJ07AcpopXldHzUkJvAPQEwnRkRdO5KXgjrc
 AJvR6Cax3u/XadlK5a3FkL3wWSze4criI5vBIykfT/uglyG+igfZMKYp
X-Gm-Gg: AR+sD10wW98kjnfA3GXr31HOpOLXo5zpa7Bh0josutr74yToduhvvQSzxiVKkMnh/c9
 0jOqOrhfdFu0CDArLAR75717moktk1+O8Y4zB+8uD8aGqZo8y03hJItm6bkn5lufuNxh61awtN7
 pD3ZVaoOnWl7HDqhbuAopGhN6TbLuPCLsRAcLQteTEqpVWNYEMcAYW7fQ233d8ois2Qtc6Bh369
 na+NQGv+MfJNiXqHrkvLwolvtYXJwjsONYoJVPcrsO6xtPTxj6q5Z92iL4d9p0nHPmjUecdENSC
 mG1Br/x269z8YeTdsg6r3WfNuEKycccJbBJSskrZvCoULzM9aSkP6nHnm8GSQV5hJpkJi5nnS6U
 tRqctulp4AxHp0QrMC4H6o3MNOai7ta+jA0yuTTTi19Y1965ToY8qMk1/tHdVQKohGJMPGfWQtT
 gxQmD5pr3igx41Hyo992NWY+XSxl6JydiUEqUrY1H0iklooy98rixvIn8d/8tH0hNZTs7V6PQgu
 1pziQYG2Le99quM
X-Received: by 2002:a17:90a:d008:b0:387:e0db:bc26 with SMTP id
 98e67ed59e1d1-38e4b578fe9mr14367125a91.38.1784601491524; 
 Mon, 20 Jul 2026 19:38:11 -0700 (PDT)
Received: from
 runnervm3jd5f.jt1qxkone0mujmjzcjj5sxexvh.xx.internal.cloudapp.net
 ([4.242.44.209]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38e923741fbsm581271a91.13.2026.07.20.19.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 19:38:11 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Tue, 21 Jul 2026 02:38:10 +0000
Message-ID: <20260721023810.4094-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260720235649.2783420-1-sbertram@redhat.com>
References: <20260720235649.2783420-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] semctl01: tolerate SEM_STAT races under parallel LTP runs
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

Hi Stephen,

On Mon Jul 20 19:56:47 2026, Stephen Bertram wrote:
> semctl01: tolerate SEM_STAT races under parallel LTP runs

> +static int do_sem_stat(union semun arg)
> +{
> +	int idx, rval;
> +	unsigned int retries = 5;
> +
> +	do {
> +		int info_id = 0;
> +
> +		idx = SAFE_SEMCTL(info_id, 0, IPC_INFO, (union semun)&ipc_buf);
> +		rval = semctl(idx, 0, SEM_STAT, arg);
> +		if (rval >= 0)
> +			return rval;
> +		if (errno != EIDRM && errno != EINVAL)
> +			tst_brk(TBROK | TERRNO, "semctl(SEM_STAT)");
> +	} while (--retries);

semctl() is the subject syscall of this test. The rule for subject
syscalls is: skip SAFE_* (done correctly), but wrap the call in TEST()
or a TST_EXP_* macro -- never call it bare. Something like:

    TEST(semctl(idx, 0, SEM_STAT, arg));
    if (TST_RET >= 0)
        return TST_RET;
    if (TST_ERR != EIDRM && TST_ERR != EINVAL)
        tst_brk(TBROK | TERRNO, "semctl(SEM_STAT)");

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
