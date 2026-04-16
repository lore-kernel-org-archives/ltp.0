Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F590F433D8
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 02:43:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC0503E71F9
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 04:43:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 998213CDC78
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 04:43:27 +0200 (CEST)
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2F76D600809
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 04:43:27 +0200 (CEST)
Received: by mail-qk1-x742.google.com with SMTP id
 af79cd13be357-8d68f702851so1140823785a.0
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 19:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776307406; x=1776912206; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7yZYVQbA3RbOGzDAh5KQnXfn8VESCjq9bf/kOuDXvvo=;
 b=Fql+/MxzFwKBx8pJqYSu8dc9ZALMZmqA8YEnNk10vAcFSJonDBgFr5c+15R444fPxo
 U4Qv/EQnkEccVGnFAzYcW5OTzAbPh3lOevbAGZXD4Mm5+frQy5Uz0fAr1u0G/lNp8Xcz
 WpB41J5QfYd8nqEAXq2x9nF+P6pYO5F1goQwVSbS/DuuYlpJLNCRpcoCI0AaEMSRYX7e
 ui+WOD2LEiYUNWli+HsP2yhAxcApR0yA2uRY+i5l1TEn6GtP6/uW2tDDoKVyjZ/jBFrk
 15Vi+H2TM+ErDbj9V6lXFQPVfUvyZuq7sh5k6h3/CKckcseog4pmyrvw7nXfV/nXkfpv
 dvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776307406; x=1776912206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7yZYVQbA3RbOGzDAh5KQnXfn8VESCjq9bf/kOuDXvvo=;
 b=dKtFX2pq8tqJxOKPJzZhzwiCaSNm2xRFwgXLp59OiZmD7DciJfXJswv7nS1L0BU7Q9
 +2Y/TaXT9MrD8zLGx6+5DFVpYUqhSb1a4IuPA0z4LGNDvTudpXBPG1MEe+h6hijue0ZH
 tXPEpP0SMnuaUyiegREbYlKBgYH4Ass1IhjvdSNRLLgvBA/hGpix4bcrUcp//hGJEXpv
 hYy1GzeRWft6R8QEmI0prb4daeuWELcH3bOJyNArptE7ydBB1TTisQ+/BHqhHrl/sCuP
 QqmiN8RmJZ+hldA0GVVIjD2oOR07md7Zi21n1AMUvBZttVm+jMyD7izjZCyurSgL8rby
 5p2g==
X-Gm-Message-State: AOJu0YwMRxiPlG2SFk44/zvBvc25CcrSAsM82dD2v+d0cEj8qdP/vG67
 hDeGG3sMwVjaPrNv8lTjYClyK9jeBihJzynIuo6UgRUmcVwLDJdUvFB0
X-Gm-Gg: AeBDietRMkdprKi11iOh6/uP5+JfHFoiQF712sXkn4Degb0Xh5nDYCrNOum/mWZRyM3
 vseZKVoSxTJ0IAqOG5lt+bc9yq3nwDK4UqGmAneqreCU8wNpMVNU2o7TLkp8VI4aHtEfuZdmnOC
 h17JT8Ka5XtD9RO64U95x3iPfJemblZSUX9qBVYwnXSiX4Pm2OK7RQMoWtwVPxJ4NQBNeMICHgi
 9GH0iQf2+4T7uE7OFzso4SNG0WQbGce6CwheLbERARvPv7LGwOjJUXS+GcD2M0ohdU9XnDXyPj0
 f8uwtTgpHlpaEMuD7tuPcI2+NxP7B/gsLHglSPm1xb1xdvQbSAzUMTYubI5xn1h9BIsdJCvzZvO
 rBWnKnxIiVPtEFvS78Joax6ioLZpcelMOu39jXUjej4O5I12zDqjBFb7FFV04XxXztShc9ENlMG
 hndDwClStvPI7tsVb3VmH2s9kBmtv2doJfLv6ig7DHG1+VRPLk9GZe+XVK7grJMEIIHJabUSqtQ
 MJfoYKZgHvNcKpZQDKGTZk6jUlOvkZCvWHl/YDt
X-Received: by 2002:a05:620a:472a:b0:8cf:d516:8451 with SMTP id
 af79cd13be357-8ddd0696085mr3712840985a.62.1776307405935; 
 Wed, 15 Apr 2026 19:43:25 -0700 (PDT)
Received: from
 runnervm35a4x.abeklq3pcfkunev5g5yv1x5cva.ex.internal.cloudapp.net
 ([135.232.232.49]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e4eed6ee47sm264496385a.10.2026.04.15.19.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 19:43:25 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Thu, 16 Apr 2026 02:43:24 +0000
Message-ID: <20260416024324.4039-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416005603.22427-2-wegao@suse.com>
References: <20260416005603.22427-2-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: New library function tst_get_free_uid
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

Hi Wei,

On Thu, 16 Apr 2026 00:55:23 +0000, Wei Gao via ltp wrote:
> [PATCH 2/2] open16: allow restricted O_CREAT of FIFOs and regular files
>
> This commit adds test cases to verify the security restrictions for opening
> FIFOs and regular files in world-writable sticky directories.

The body only describes what the test does, not why it is being added.
State the motivation explicitly, e.g. "Add LTP coverage for kernel commit
30aba6656f61 (Linux 4.19), which introduced protection against spoofing
attacks via O_CREAT of FIFOs and regular files in world-writable sticky
directories."

[...]

Regards,
LTP AI Reviewer

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
