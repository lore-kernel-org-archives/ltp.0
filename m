Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF39C55162
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 16:00:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 915FD3E7293
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 18:00:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FF693E282F
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 18:00:18 +0200 (CEST)
Received: from mail-pz2-x01.google.com (mail-pz2-x01.google.com
 [IPv6:2607:f8b0:4864:3b::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 03FD46008F1
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 18:00:17 +0200 (CEST)
Received: by mail-pz2-x01.google.com with SMTP id
 41be03b00d2f7-ca00ea47337so791810a12.0
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 09:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785427216; x=1786032016; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gnOaOz3lzhbAk9Tg3hwp+1frV/EutpIs1K+chlhvY3o=;
 b=Q9Z1PIq0d+q+yH0bYQRFli6hjYo/CHA4SZkKHKSjNBc8PK5owo/Iu09WYLKE74EyLx
 xShk0IIHE0k/3aUTccHAbmOhYvOe+kuT5d1yRX4qQKqgcxlSzh6YECb0oip4Y1lsydaX
 ZSrPEmoZVyOl1I7JrPp2clyi4gAirDsX2YIRHef2hgTaFyKdFqwycSxdkaaJCj0z+67s
 INndt3AukSDOJ/q9iMcKztKIhwd47srX3kwHm9Pj1os1cAIRQ0FIqKxmAsuq7HrM3z54
 YfZWdktsUQ23pyKo4NOlgemXJ19ipXWm/MQF5ppbd6wOXQpF6ifVmERclXFWFkHbsaMG
 svXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785427216; x=1786032016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gnOaOz3lzhbAk9Tg3hwp+1frV/EutpIs1K+chlhvY3o=;
 b=ieTpokrWYvlKGunHeqiU/P6oWJ+bfzJXMfvCVjcx+e0SbX0oenhCN3zzmxZoKLOjCK
 vKTaz4Xgb9z45e01FN6c/P+xN7qzGlH7hzu3s4g6gnL3b4gdqwNZVGSZPfgLI4prB2xD
 jvJiMDwMdGqrYghIxFGI7wPcglKHjjC4Sn29r35cbEGV20eJRU9UFFu7C9GU8K10H9xm
 jnXvo1dQ7TF8uTULwUwf16KAss6ctNVYgGsgk5pqw6tksdCeq/EYoksP0Hi90u1aC+a8
 01a+ejowYy8LV4hCZN/3MpIE4UlRBGIu00Gd71xqB5rPg+8rtJv7VYCYNn11MaSgNbqm
 HVvA==
X-Gm-Message-State: AOJu0YwSRH/5ejHJbUhc2/0ZWuUq6GFxfQV08EHobr6XIF1L7xbVgz6Y
 oghoWZxSDaxfDMty5ReWGw4xwAu6cVpJAUCDifBF2sjURL5GP9lNOEz5eHpa/sb6
X-Gm-Gg: AR+sD13xyTKSkt2DcAByZc0xeKOZC7hgiLSY71LJPs2W7FcgW3jb4JRZCeDEaWcFJ8V
 4k+5PSDDZypCt9BcDICg9BgOyR24N+arx+Ktvrxt8n1eWgbGBPS8DPojQ977OsIgDq3GU4sTwkU
 0vDTxP6xJVPuXgEx8vP/dsPKQoAbO/zmsYv4xlyoqaBDAbfJlmzVCRJArtzUSfcH5xs9zM+W/VA
 dGp8FOXDfCVKyUU8ZxgXx1dXz/7aWHFEZe/URFNuSUcOZSXaXn6z0WvvqjWYJ8KZ+VRrLL6rO4F
 trw3ehk6yQ12mVkyQl7CfwJCyIUOrWa/Fscjm2MUjvmwqE5JcojmdX9FgP//LtKtypBbSdmHQ6j
 HbsYEU2P38r2gUqaD7vY1lBJzmqhgMfGiYOybcXM/ryg4FQEAGYOdrBBEvTUq9DhPANOGn0u7t9
 uKB+1jI0mdMbVbiRqUJSzOy5mjUKQKd+g153CSxAQb5HmqkRCdpASeU5e6vjfaIUNk3O0ES6kxN
 UByw/HWthqEzr7bGPOuqYKCsz2/toRnKN1my9iYR/DP8QdevhjGXZ6JhwHL/Rdt0kfXdkjthGdR
 Na3Yyp2GxZQ=
X-Received: by 2002:a05:6a21:4582:b0:3c4:3321:4ff4 with SMTP id
 adf61e73a8af0-3c900914512mr2956714637.61.1785427216108; 
 Thu, 30 Jul 2026 09:00:16 -0700 (PDT)
Received: from
 runnervmvrwv9.meshoxyzvolejg1lfo2a0p1fje.dx.internal.cloudapp.net
 ([68.220.61.219]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504dab0f3sm20484495eec.27.2026.07.30.09.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 09:00:15 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Thu, 30 Jul 2026 16:00:14 +0000
Message-ID: <20260730160014.4060-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730150149.211449-1-sbertram@redhat.com>
References: <20260730150149.211449-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] semctl01: fix SEM_STAT failures under parallel LTP runs
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

On Thu, Jul 30, 2026, Stephen Bertram wrote:
> semctl01: fix SEM_STAT failures under parallel LTP runs

The functional change looks correct: looking up this test's own kernel
index instead of relying on the global high index from IPC_INFO is the
right fix, the shared get_ipc_idx_from_id() helper faithfully preserves
the old shmctl01 loop, and the non-SAFE stat() wrappers correctly skip
foreign sets that return -1. Two small comments below.

> +int get_ipc_idx_from_id(int id, int max_idx,
> +			 int (*stat_fn)(int idx, void *buf), void *buf);

Could this new public function gain a kernel-doc comment? Per the
documentation rules new public functions in include/ should be
documented with kernel-doc. The rest of this header is undocumented
too, so this is only a suggestion.

Also, the continuation line here is indented with three tabs plus one
extra space, so it does not align with the open parenthesis. The
definition in tse_newipc.c aligns with three tabs and no extra space;
should the declaration match?

> +static void func_sstat(int semid)
> +{
> +	if (semid != sem_id) {
> +		tst_res(TFAIL, "expected sem_id %d, got %d", sem_id, semid);
> +		return;
> +	}
> +
> +	if (buf.sem_nsems == PSEMS && buf.sem_perm.mode == (SEM_RA | NEWMODE))

This reads the mode set by the IPC_SET case. Since the SEM_STAT case
(index 11) always runs after IPC_SET (index 1) in the tcases array, and
the mode is not touched in between, buf.sem_perm.mode is 0666 as
asserted here - so the check holds. Just noting the dependency for the
record.

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
