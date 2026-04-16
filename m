Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BDECF433F7
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 05:54:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 15C1B3E1DD0
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 07:54:30 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A4D33CC8C5
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 07:54:09 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 21930100036A
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 07:54:09 +0200 (CEST)
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-8a48deebe95so61538076d6.0
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 22:54:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776318848; cv=none;
 d=google.com; s=arc-20240605;
 b=GEKoO5cAR/PHl1ObLsyge6UOHAWNqL08C5nLTMjbgQHgNcg4S8KTh83mOphF6a5wU/
 giGUZjZ5VhSC4EI8wzkKrzehEBK4S5Rk1oOPCwfeUYB1Kix2ddSQkJkDUNWBKbaQ15eG
 3GCdIYQdZlfVFsE+/hKUuALNCst3PxFXspDInFjbg1AlZnA7GofJCKOdV1gJ8U21G4jP
 UDVafr8HquZaG+e6zuVPH0pbQvBMnIK/HYWf3OAqoKHJhz1fk/15GqIgy5RWIG5iSYFn
 Ru+yGRI85EdkSt+Z6LUdBoQtKhHJYzEiA5OSyJpSd+PUewnQUaoEf3q1RR3ytZR2icKT
 XBWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UEnf5nuuvMIrDPrcqmo6YPelq4gS5QlbqZxeb3GFQaE=;
 fh=Zfzk/SUJ4TmbaA4JA+azdFJ3XHdG+bxusN5ghhPguT4=;
 b=TFzcl4uHd8HiOmZ9F6+1ioV0EbR/V8L6KRMbnm7nvfPhdaVIN8F/JuejcetKvMuDMO
 4CB5vU4R/yA0FsahO2ugcLrzfZABkRb/OLGafsZKStCYdzoEtp9CD8JjKoWFFKhtTke6
 5Q5vJUhulJQ0eHNqYcHRsxIiWZjIDcR1S+SQGRjIBw9wsiSWpoXb5/aD+C/i2hJIltb0
 /WcEukvvwXlcMxedxs6EALepx5zEHCN9XWL2Ni3/EjDd/mNrj1txarJO9Z/Tgsr8sZPS
 8xDT9J99veILTTxe/pbpdiLo1HIV+8wbuMC3vggLFgmzdojnm3At/Fww32BMcatlEnTt
 M4mQ==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776318848; x=1776923648; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UEnf5nuuvMIrDPrcqmo6YPelq4gS5QlbqZxeb3GFQaE=;
 b=nsmgjyTmNT+SlgQ3D06Zp8594Gu4kChnyNqelJF/PvtDu3HVdwk4zv1eAfCJWY/Av7
 rpqi9pV/O3frpXlEEOR06dyX0u59omROVVYkiEiMfp7zD+RZ0jdV7YHe0WFihGcoKcIN
 dHTvyMfjIso8eeH31VRGY5p3MQIyvygzuaxXlkt8AgrYwm6NYfK//oYOcs9BLw4d1RE5
 F9LHgUaSLKHThMsnJsfyyZdP/GW7C+XExPWeOAJpawTWZLbUyZwkHhaOFMjGd7tj1Uh9
 sNwCgm5Zpv9TYLjFKo9EN78BEsmhH+SPgsIhEjT+SlUN6R9jh0OrD9gI5z03jsYQbcE4
 dAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776318848; x=1776923648;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UEnf5nuuvMIrDPrcqmo6YPelq4gS5QlbqZxeb3GFQaE=;
 b=h1MKTumd46xqDsO0WR9jNGJfq6Bs9AH9RlvobcFN1UuvNKGCdHqMQ/2/M7r1u5kHI4
 z7SzO5DVJYmCXTpBuFaBBY4gdmQY+//b+Ok4jRoMbyk2HxwTJFztltRxRpE70iDgj6V9
 ILJQJCsiWkEW22dtir4rYgxLtE75akqaZ1qZJJwo8ZdzzjPHXTIAPDNSyiwg+CHgL/UL
 A0F9m97SJTiGLvqjlm4SK7QCCcbj4SkI45rOqT6iyLq+Zbzmaz/hAx1cmGbCV2eytYps
 dR8G86FPEoinC4GkK6BZ6Ndcz1w4b5+sgCjHkxwH+QH4wNTZiZ0nCBAhEYxJkyGNre+V
 RXTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+l9T9l6lmS2EK8VTdLZ5qCdWQkSyotZtpsQtBfMqSHdi2t6L3FckPb//EkOoIHrmZAWZo=@lists.linux.it
X-Gm-Message-State: AOJu0Yx7B2wyyyb9fTChyHLqiorpAeEajujk5v0MwgRNmzcFNTYm+/QQ
 2KLtG+VSvKzDwYPvibAsJKWUygSgntRTkwAxUU7mOBvBoHljhVq0SWJW/y6v6X3JDJt+U62AW9s
 TUuel791rTA0lZtQ9CkGmp7BBmIzmuw==
X-Gm-Gg: AeBDietfih4dbVD3ndIknUFbiaVaWEvCDE6c/46dCdEkUSjOF7qqVtlnA7tuashYOQ4
 T/v3IcxwGgGQO1H7zdm2F7H/H9y1WDVfoLzMDxsF0eqgK8dxQK/jgR4XDo65mulhGU/yAkCYM6L
 47isnwc2VdThIpJdJiBlpQN0Rfq/Yucu9ygQ5VzeoZEYfz3QCcXlpIrBNWrFlAbsUSOx/h2FkLm
 MWV8/opo4avKSOwLYogmeaN+KfYiM9RpT3t0XiFbWtsxDjaO2eedSQpf7mbiFZTABp1sItSt+vM
 A1t7KJ/Vq0/5kirv
X-Received: by 2002:ad4:574d:0:b0:8a6:1216:fb6f with SMTP id
 6a1803df08f44-8ac862e0dbcmr421107156d6.32.1776318847838; Wed, 15 Apr 2026
 22:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <53f26493-09fc-4f8b-9751-24d2c2e80697@linux.ibm.com>
 <ad5jSSYZJS0FdZva@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CANgNiRyTovPjVq01n7sCNhbNdYNp6nSvWcpVV_8aC3+kBX0edg@mail.gmail.com>
 <ad-sqJXCYZpBAKM0@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CANDhNCoAc4ktPUzqgam_oO7aAc4yp3nCqkcwQDvWs0zV15ZCaw@mail.gmail.com>
 <CANgNiRz7c7mJ3E2QQwHCHb4=DCk-S6vXe3Xkge05xfYe2LYTEQ@mail.gmail.com>
In-Reply-To: <CANgNiRz7c7mJ3E2QQwHCHb4=DCk-S6vXe3Xkge05xfYe2LYTEQ@mail.gmail.com>
From: Li Wang <wangli.ahau@gmail.com>
Date: Thu, 16 Apr 2026 13:53:56 +0800
X-Gm-Features: AQROBzB2J1QZbopKSEJlKnBNFO4hA87MrmAJ9ie2enoPgZHku68KaM6R-AxmGew
Message-ID: <CANgNiRxV5Kd1Y3hHjM4mXaE2sdjhCQdp4Ff85YdqxL_DOSZdgw@mail.gmail.com>
To: John Stultz <jstultz@google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched_football: fix false failures on many-CPU
 systems
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
Cc: Soma Das <somadas1@linux.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> That's why I tend to believe disabling throttling for this specific test is the
> wise and practical approach.

However, back to the original patch, disabling throttling was
indeed a bit of an overprotection based on the pined method
(I didn't realize that before).

Once we go with pin 'defense' threads to every CPU, while leaving
the offense thread unpinned, this throttling can be kept enabled.

Whichever CPU gets unthrottled first will instantly execute its local
defensetask, completely starving the lower-priority offense task.

It relies on strict local preemption to perfectly mask the SMP sequential
unthrottling latency, fixing the test without needing to disable
sched_rt_runtime_us in the kernel.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
