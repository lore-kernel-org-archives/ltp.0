Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFDAC43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 09:23:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A39283E4B37
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 11:23:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1E9F3C73A9
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 11:22:52 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5A315600141
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 11:22:52 +0200 (CEST)
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8f2509d6becso4594506d6.2
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 02:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782811371; x=1783416171; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jmQTHVPr+nKQJqfSO2ve/n0T3PRFFDCHN3m2VnjQFNM=;
 b=TApw9YJIhBj28+vhc3lfTHwXmTUJjUfUEhgAMDyIZ51lRxsvmWDMQEfhl3vvj9fmSz
 bREZQliv00GfZKKiCtyWcmZ8amOkIF4LzHVIFZOTzs1wVZ9B0xe1BmQ+5YRXk+B2KtGX
 1bQzYAprYP9/EaV6W5lygznWmGYB5hSot2JArFgWZlwXYYqChr9zsy4IzrGcO5xFNKRk
 MatWlicNbE3IJiX0zKUSFf9SI9WyPHv/yHymb39hKm35Ysv00M9+9wIDVqgz0oUIL/Ri
 MASHeiE7ThH/34A7wUMpmOZr1FnDu2x2Rdfg9/R1mVJVw4T6VhhjOHCEyiTvbdE+g8pF
 ld2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782811371; x=1783416171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jmQTHVPr+nKQJqfSO2ve/n0T3PRFFDCHN3m2VnjQFNM=;
 b=CvPG/1YWcAw0HOLOWNeLKti2TRZq9CYiT/HNNu58jpq21o5bBei4aU3AEPyngn/4+m
 c5cYbzmiFfYgov7DhougGppWuLOBL0fAeRqcbtOvnXjqzZmSanTC58pKtMx+Lj9jaTRn
 Rq0esfLYwAOHV/fIgasWWnfW4omlV6sd2F/7bYbf3I8bsDbdXv8Qo0Wi3c2FWgCnGzLQ
 jmATpOZmfARErk066x7ISybyfoyLoPEwKLGNChNF7XlfxQg0UXQdn+QlInqy1cbqYjGR
 UVrRKR+3L+mh8CDuJ0Iw1Vq2lGhfxIskzanQvt4hGUqC7KFUdhNb8jD5xSsfqZAJbiir
 FWSw==
X-Gm-Message-State: AOJu0YwGx7eYPKyuLuTM3A25jXSGPvxWsQJipkSk9RCMcoaU5NN7Lh/+
 CMEU18bFFtGJ1NydNhz8wqiIGxQS2PeBFatEjXwylAg+IHQF4/HSeyRc
X-Gm-Gg: AfdE7cm+xvVASYt4GtTOiAJtD1aEpHBUPspbqfNk3LafBT/5zxBkHRx2OUuIcyttKSJ
 zbG55S5NPZtc4Q8Mg/y3jPwBQDM0mE64mKUxQBwNbaUmqmYy4n9ANwAeL4kbTfWEl3f4d6TTw/7
 ZCAJdVplMvtK0h+OBVlt6NUVcBagJT1eLtlrTQyuaqY5cVTW4zzeEizaHExmwJzqjXLZ2u13gPY
 kR/OA17B5BbZJjdDMqoEzkiRAGkp74/NLFRH7f6eG4TnqLvkCyxhC/TMGuyR+nWW4i8Vzh4madt
 FQ3PJnuqcm6rOju/mZw4FXDh+7B/MrcNB0cx8BoEh5k6WgoPviK1fKwl9P3rn3egSPHWPDU31DX
 kR+2d5OivgXmfVvn4tR9daKUFinApy+quKrZyJHQV0eld8apdLfntUMbCcW1DQXGjB5i/hm0XmX
 FmVPX4KmYfqpOASrIvORImBdOYtv/HHD+Mw0kjXZYEDDig/uciIhpoTtaEACn0htpzh0d2qJj1u
 Q7ZXlIcZ88CVkXqgmEDiSGBLsuF
X-Received: by 2002:a05:6214:f04:b0:8de:25f7:98bc with SMTP id
 6a1803df08f44-8f1b9dd6cbcmr46258926d6.22.1782811371100; 
 Tue, 30 Jun 2026 02:22:51 -0700 (PDT)
Received: from
 runnervmmklqx.hdryostwtogu5fpu5w2elnmblb.bx.internal.cloudapp.net
 ([20.119.87.103]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f2a73f764csm758116d6.32.2026.06.30.02.22.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 02:22:50 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Tue, 30 Jun 2026 09:22:50 +0000
Message-ID: <20260630092250.4087-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626135347.48218-1-avinesh.kumar@suse.com>
References: <20260626135347.48218-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] set_mempolicy: require CONFIG_NUMA
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

Hi Avinesh,

On Fri, Jun 26, 2026, Avinesh Kumar wrote:
> set_mempolicy: require CONFIG_NUMA

> set_mempolicy05.c:105: TFAIL: set_mempolicy should fail with EFAULT or EINVAL, instead returned 38

These log output lines have trailing whitespace. checkpatch flags them
as errors. Could you strip the trailing spaces from the commit message?

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
