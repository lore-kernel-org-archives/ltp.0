Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09A6C5516F
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 07:30:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C65253E9510
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 09:30:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BD633E9838
 for <ltp@lists.linux.it>; Sat,  1 Aug 2026 09:30:23 +0200 (CEST)
Received: from mail-pj2-x03.google.com (mail-pj2-x03.google.com
 [IPv6:2607:f8b0:4864:39::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4B2371A00611
 for <ltp@lists.linux.it>; Sat,  1 Aug 2026 09:30:23 +0200 (CEST)
Received: by mail-pj2-x03.google.com with SMTP id
 98e67ed59e1d1-38111ea8a88so1239825a91.1
 for <ltp@lists.linux.it>; Sat, 01 Aug 2026 00:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785569422; x=1786174222; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=unW1I/uSiOyS6tohZwjoVoBuNH7rhvwZe2ch1y0V0mQ=;
 b=OdDKc2+862y03TBWO++2bTaNUs52QDb8BHSidRPLgQ9R9m5qq80L80DbseRuzvS5NW
 3DJiv/Nn8uQestl7FdgrAYPmlYiEfwFeHAM0xNEIQ8FS1hsUbtDLdYzda7riZ0csrW7m
 N9nV8xhIQf37LL4f8aHYISPUeQsrTq1r6yHpUgjKn1jae+o5QOwVMYz3rpLWDTOHh+3C
 NOsb3Elh017E5WdaL2y97j+PKh1f1be4QGdJWLe3HpASZOYD1X/ECJabRsEAEybfQ0RU
 af5GWD8YCwZbj9bDbLpkwzp5eXbUCOxQq3/awPHQsRu296AMJB2q8LV0Ke4UBviitiVE
 Mi2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785569422; x=1786174222;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=unW1I/uSiOyS6tohZwjoVoBuNH7rhvwZe2ch1y0V0mQ=;
 b=Dqxkiw/BnrCilsbCCGDeyieGP1FcrI9wzAWAc25D296P1TpJJBHNiO72XeIxwoTGsB
 cV5Typsdq/RwLZbPLXfBDpkxY1+yV694BNgpC3iAZUwvmWh/dRva8kUIPOnybn3PR+2Z
 WAMUhn4EEm84djYr/6SM8s6gc1NBQSKBNuDqfceWKhc7J+/TR0a8rJApcGPdhHauvU4i
 TvF/+L1E3SPFKdg3Zo67srqSyT4d2t+xfUB+fLRtQhJEXCXaoYW8ERX7ZqTPrB9n93ge
 rFO8RH1VRJsheWciTgaDSNr3VYB+MQ39ZxYvCxh9konYpNmq6bNVUOSk1mQm/qbWPpFX
 15+g==
X-Gm-Message-State: AOJu0YyzsuT3NrYDlJ85Epcr4I0H2jMQXneiqqHCAOWmaEjES/tzLuFb
 Nojb2XlnmR5Wyf7T2e6ahaYpXvx4u4PhTLTcZO/o0bsc3pwuTc9hYSB+1L6FeVzK
X-Gm-Gg: AR+sD10fo5vg4LITAo9h9HEcxTZpQBt7+DaPi+WpEzc6YDuX4eLUzFbX1hcP8nn10Dr
 cUqUZBv2CSxGVCogEVswbPMmY/Bk0Qk3xMjXiN6PqENey4pHlyaXHqMqBYSlFRetpbmnibBoOr5
 3aNGlAtDHdrFQ64yFU3Htpz0r136RdVwe4I+BV8pop/TMYRSbIi2nQBePARWPY7U0J9CGqBRmf7
 hg17MLnzsclg22/RK1NLyGXnF3VIIdTvgG05wwPsSXg+w1Azd1J1eTjJpB1swsl0U7W2D7YLJJp
 vlfce0ZXYtqvLL0inMKLEJtZSZH7s0lRV3OeKynsvVy/UEhXxGZiITBPWjxbshv9VX4YjXxADU7
 zvI+Mv/A6FeENMEYZqjc1hH1USFgc7Hq35fri5mQffQPOI2R1L0F2R4lSfMvXr9QiLw/FpqnVgW
 LIWeDbfVQmK75yZpe28ye0nIncjxGUOMs/K7JdjXNfUvv7Vbm0xNBbDkY1yf+xidSEiUf3xUX/k
 enrPQCQTvJLK3tYtYsVSr9KJd0M9XLZMYolCtjEk5Ac8Yzo5NsS/VjJbIsqNBpX+B0vuQQRunF9
X-Received: by 2002:a17:90b:51c3:b0:38e:4114:d8c7 with SMTP id
 98e67ed59e1d1-38fbc0b4881mr2695757a91.0.1785569421630; 
 Sat, 01 Aug 2026 00:30:21 -0700 (PDT)
Received: from
 runnervmvrwv9.ykf55hypnykulgqgjyfh40wznf.xx.internal.cloudapp.net
 ([4.155.149.108]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38fb2b8c5c5sm1049015a91.4.2026.08.01.00.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 00:30:21 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
Date: Sat,  1 Aug 2026 07:30:20 +0000
Message-ID: <20260801073020.8923-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731041949.26465-1-yeswanth@linux.ibm.com>
References: <20260731041949.26465-1-yeswanth@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cgroup/cgroup_core03: convert to new LTP API with
 parameterised subtests
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

Hi Yeswanth,

On Fri, 31 Jul 2026, Yeswanth Krishna Tellakula wrote:
> cgroup/cgroup_core03: convert to new LTP API with parameterised subtests

> +	if (n == 0) {
> +		*data_ptr = 0;
> +		num_pids = PID_NUM;
> +
> +		for (i = 0; i < num_pids; i++)
> +			pids[i] = cg_run_nowait(cg_child);
> +
> +		TST_CHECKPOINT_WAIT(0);
> +	}
> +
> +	switch (n) {
> +	case 0:
> +		test_cg_kill_procs_count();
> +		break;
> +	case 1:
> +		test_cg_kill_trigger();

Could this sequence remain in one .test_all callback? After run(0) returns,
the LTP runner calls tst_reap_children(), which blocks waiting for the paused
children. The callback that writes to cgroup.kill is therefore never reached,
and the test times out.

Helper functions can still report the individual checks, but no live child
can remain when a .test callback returns.

> + * [Description]
> + *
> + * Functional test for cgroup.kill interface (cgroupv2).

Could the deprecated [Description] marker be removed? Test catalog comments
begin directly with the description; only [Algorithm] is a supported section
marker.

> cgroup/cgroup_core03: convert to new LTP API with parameterised subtests
>
> The test used the old .test_all single-function style.
> [...]
> No functional behaviour change.

Could the commit message describe this as a callback-model refactoring rather
than a new API conversion? The existing test already uses tst_test.h and
struct tst_test, and the callback split currently changes behavior by causing
the timeout above.

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
