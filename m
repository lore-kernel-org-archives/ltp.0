Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B443BCD5BC9
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 17:12:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CED2E3E62F0
	for <ltp@archiver.kernel.org>; Mon, 25 May 2026 19:12:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A73DD3E1BD7
 for <ltp@lists.linux.it>; Mon, 25 May 2026 19:12:06 +0200 (CEST)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F2E83140055D
 for <ltp@lists.linux.it>; Mon, 25 May 2026 19:12:05 +0200 (CEST)
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-8b4298d271fso189507666d6.3
 for <ltp@lists.linux.it>; Mon, 25 May 2026 10:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779729125; x=1780333925; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AkXfMbAv1bQ1quoT8c7Eoub0LPPvRFHcsC/d4JcXNKU=;
 b=Fc4YFfskwsE0jxcgtV+jA0lwuaAAcVj7B72QfE0N156aK3j6/9EOT/f1F6528Y8tz7
 hUvlYbY6f+k/eQbQG+Kr9FvlOiSa1sQA/scpv0SZVH++Op7WbgJJSC8vxB66qHa4nWqR
 GDSPnahbsZr36pRT1wJXYz4/lzFyrU48JMzrh1tjnjHR4WSIsTOgeX9aZGRhhg51UHgL
 248b2CQKVq2uicriR+FU/MWA+ngHB/Jl789b8Le62X1dGuu1o6sc0DTCEacfiWlOD+q8
 jWbrYyrZBnn4+NSNJoVpsf+7l3HBMh+TDDw/Fz8icw4oty9hQBhtj4hk4oDrJmC7T0yA
 RUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779729125; x=1780333925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AkXfMbAv1bQ1quoT8c7Eoub0LPPvRFHcsC/d4JcXNKU=;
 b=iuTwOkgcFy7rGB5gLPklyjKbvgJO3MtpBYgb5HbmZ6xqfcDdp2jiZsmYH8sX8ZRLRv
 tkpexPoZoXCrgcJ40X8Uk+9wwIzC8PSBgUoO8BUXMeRy5OxD74VQFMm6TjkrDjWQS5VE
 S0U80Xo+aAnHIFLe/A8uACaszccPaaHAXGvUKdvl6UDKP04uLWkC0Vr9xsbZoo3TwOLw
 zm6qqYS/Z0kl07u9jOA7tzal92WnGQkuU1hdBX9r8fprdttx+9sNzQPrNrFGnbcGXMCe
 59rIa9um7BpM80Z6IQxkn4ZlYG+dm9ir7HCzEfgqaXwMvUYQvWMHLFTfw9VkLHT+KsZM
 vfgQ==
X-Gm-Message-State: AOJu0YwJY0xlzOuzMdSS7Fw4XE7O4oF/Nv0jl0R2J4sDZKLO2aB1rkBi
 HVnwJeKE6jHN4gOCp3nYV45Cjt/s607OOtzqafA6cVZil9RIjBlVB/KkbhCrIZSMTZg=
X-Gm-Gg: Acq92OGEE70PSPw5M3J+FSop4nkG83bN1XF12GaL+yqSSeqSKZcvfPYpZ9TnQT2Zx4T
 B3nLRSc0i4E3nsNLWr4v+1GaPkyZg2mZ+cdqi7UgUEg9zrAszgTDjFWmBGQb9VsJAxohWMytmbj
 ZwkM4M/BtRYyVDnucf8zKzXjUuUCTG7Q1JiRiMWEi6JpfchAsDsSb762V8LHajPXaVAeDc3fsyc
 jqGG7F2Qdjk73mCSTblnDoDpXEdor0X3QvyZcjCcme+sxJeEmDM8A8htjmn2ALkn3NwODpWhSza
 05m2U1J8tflKFkzkdlBq01c0VOtiqB8hVnB29lHsakHwbmPt9YaK+6oFD3COi+phjb6AhxiApKi
 Qv7TzDyxqRPSH3FmTuGxrVVwejVnQPW1esPOYilaVZBU2elM90aBmwnJXwK9Tl2qBulEBPv4vDY
 d11hLRhuxkzghfI5LRkAf8MSFj02PWq/Lgw7QGIAdvXSbQ4UcyTShgwgZtEyPiVrHmE7lcChw2I
 v1j42Ht/56phrKLO1TetJesRfjK6rZ8gOM/q21+
X-Received: by 2002:a05:6214:468f:b0:8ca:16fd:7297 with SMTP id
 6a1803df08f44-8cc7b60142emr250400146d6.30.1779729124672; 
 Mon, 25 May 2026 10:12:04 -0700 (PDT)
Received: from
 runnervmg397c.uy2f3jgrofrezmhnynlbnfxqnb.bx.internal.cloudapp.net
 ([20.127.214.212]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc812e657csm126020256d6.24.2026.05.25.10.12.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 10:12:04 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Mon, 25 May 2026 17:12:03 +0000
Message-ID: <20260525171203.3996-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525153352.188816-1-pavrampu@linux.ibm.com>
References: <20260525153352.188816-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/memcontrol04: Fix race in pagecache allocation
 measurement
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Pavithra,

On Mon, 25 May 2026, Pavithra wrote:
> memcg/memcontrol04: Fix race in pagecache allocation measurement

> +static unsigned int num_children_spawned;

> +enum checkpoints {
> -	CHILD_IDLE
> +	CHILD_IDLE,
> +	TEST_DONE,
>  };

> +	if (num_children_spawned > 0) {
> +		TST_CHECKPOINT_WAKE2(TEST_DONE, num_children_spawned);
> +		tst_reap_children();
> +		num_children_spawned = 0;
> +	}

Correct. Waking all pagecache children before tst_reap_children() and
resetting the counter is safe since cleanup_sub_groups() is idempotent
(called both from test_memcg_low() and cleanup()).

> -		tst_reap_children();
> +		SAFE_WAITPID(pid, NULL, 0);

Good catch. The old tst_reap_children() would have reaped the still-
waiting pagecache children prematurely.

> +	num_children_spawned++;
> +	TST_CHECKPOINT_WAIT(CHILD_IDLE);

Sequential fork+wait pairs mean CHILD_IDLE is always at zero before
the next child is forked, so there's no ambiguity in who signals it.

> +	SAFE_FSYNC(fd);
> +
> +	TST_CHECKPOINT_WAKE(CHILD_IDLE);
> +	TST_CHECKPOINT_WAIT(TEST_DONE);

fsync before signalling the parent ensures the pagecache is durably
accounted before memory.current is read.

> +	num_children_spawned = 0;
>  	fd = SAFE_OPEN(TMPDIR"/tmpfile", O_RDWR | O_CREAT, 0600);

Explicit reset at the start of each test_all invocation is the right
place; handles repeated runs correctly.

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/26411599009

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer
```

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
