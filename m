Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D63FF8875
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 09:18:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5AFA3E52F4
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 11:18:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 32FFA3E210C
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 11:18:35 +0200 (CEST)
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com
 [IPv6:2607:f8b0:4864:20::744])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C22316012A2
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 11:18:34 +0200 (CEST)
Received: by mail-qk1-x744.google.com with SMTP id
 af79cd13be357-8cb38e86cf2so58634685a.1
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 02:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777540713; x=1778145513; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Scx0F50+s/5R6QyHFXK94XLOuvwylKu2H/YDKUnJ9Sc=;
 b=DK4ibauys1KD8VvFpK69YxST/jWJOdFPwL/95qPT8vTn62YGmlELZY6L7Ef79uhRoP
 tkqZjY2Z/0t8/u/whqAnhHdcU79eSqizycK9EQN047+J1TjtaswSlBRERryuCjXLSi6m
 i8i//cFwfCN1U29T8TEa4EsVmhMJK+V0dg5sLhiW7zrf4UrZ42hIjC+CH2UbwiTUTfL2
 uMHmCFOu3ob3J5knYDuo1gyuYeMW/UHIwbczuNKL7e8hNd9wfprGRFIzfIW8RRlL9bHe
 UKWlj599+igPJxhS+IIMoquYfPzj0yawnDxAfS3sK2qwQT1gdmHuXF9UgG5pjhzIqgEx
 OgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777540713; x=1778145513;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Scx0F50+s/5R6QyHFXK94XLOuvwylKu2H/YDKUnJ9Sc=;
 b=WSMqqEafF++K2WSxueCrON7Uz3oRp8xBN8MOMBiOOWEHMniajK+sCmU7h11lo3AzWc
 7Dq8MoEoc3LXeYkI0NT8PH+mzHKNZtsoGreGOxxwog62xMPaMUmcGpK7MZD+cf75c+7L
 8rhETBlaJBcm2z95dRdjCpUxgZ7eTjum2OXE/6vLhh6oMQUcZ5CuyLLyPM0YlaU+Lomq
 6jr6DdrOY8eE22Ewv0a/fi++OacRc4JUT4SslgtQBgV2ox5t9WLhH46ecc247R6s5pm2
 VXst1MmhQ7u+kVYCScYD+ftGFJuOCxg26nA/FDtGKgPolO9bBNbVCzMRvIjXIivJ+Eo6
 8SKA==
X-Gm-Message-State: AOJu0Yz3cVuZiUonI8iq2KQ9xWXJIhFJ7YB1l2HnXtOny/OTjmUBgSzq
 oKEF+noPGc+JoJLH4LHf+4nInAiW2FXcTJgri+z6xx4Zqr/17eRO95kN
X-Gm-Gg: AeBDietEfr+xadrmZYiOHd7b7DzAzgr3VE0R38QbbtnTMfSEczvBG1EHtzwU7Q8bu6B
 0eotnqLzJVhUb8NMJc6NQALR5GVWtSwgctmjZu2/i27CdTjRu4aYjUh5UZgmQq1jy+tpRKny7Cq
 msOiEUFcxecraDc1AkOJEtTYoBCra7odPXVEWIKFceRS3xxiSunPIiOvRLsapgTjSFj1wJsJAXC
 ow2LMr03Z+0uXogNaPF/blNmSjGGmZjL38TgDMX1x2hOJ+AjokE9m3zoWCZ/MsvxY75saKmrZcK
 JOIfDAN6AFJEnlwF/icffG0KyCuaeQDQZ0dDKdVPSSfuYimxU5MdiAcE1+ZcuBJQpxnk8M1SAOn
 mY55FeKMrc+r0noYt/NqO5LHhSqfPlxJN13mYxllZYQY5S20eP32OhIY1pxMB2cQPpNlasCncbe
 Bh0xLeAf8HCgja7mZar17uMEK1SWY1gD2klycHKKS++on+Rif/hRmpj4r9CKp5Z+SZZvwQvqdCI
 zzlfwqdPhILtbu3yDHtUhX4xckun0kWjQEzj4i/YTw7Z7pk4uRppPtNIl4=
X-Received: by 2002:a05:620a:40c9:b0:8eb:10d4:a46e with SMTP id
 af79cd13be357-8fa8a3ca2famr302691085a.45.1777540713353; 
 Thu, 30 Apr 2026 02:18:33 -0700 (PDT)
Received: from
 runnervmeorf1.11dd50q2uqgerai5ailtq5mtfd.bx.internal.cloudapp.net
 ([4.236.158.81]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8f93ccfecdesm403104585a.13.2026.04.30.02.18.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:18:33 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Thu, 30 Apr 2026 09:18:32 +0000
Message-ID: <20260430091832.3987-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430084239.320182-2-piotr.kubaj@intel.com>
References: <20260430084239.320182-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thermal: add new test group
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

Hi Piotr,

On Thu, 30 Apr 2026 10:42:40 +0200, Piotr Kubaj wrote:
> [PATCH] thermal: add new test group

> +# Copyright (c) 2025, Intel Corporation. All rights reserved.

Wrong year in the new Makefile -- should be 2026.

> +	while (sleep_time > 0) {
> +		[...]
> +		tst_reap_children();
> +		[...]
> +		sleep(sleep_time--);

sleep() must not be used for synchronization (G2). The children are
already reaped with tst_reap_children(); this sleep is waiting for a
hardware thermal state change. Use a polling loop with
tst_timer_start()/tst_timer_expired_ms() instead, which you already
use in cpu_workload().

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
