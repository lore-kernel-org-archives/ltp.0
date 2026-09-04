Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E7ECC61DD6
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:18:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 848FE3E975D
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:18:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C0183E9792
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:17:20 +0200 (CEST)
Received: from mail-oo2-x08.google.com (mail-oo2-x08.google.com
 [IPv6:2607:f8b0:4864:31::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 79326600437
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:17:20 +0200 (CEST)
Received: by mail-oo2-x08.google.com with SMTP id
 006d021491bc7-6b128c3af4bso65795eaf.0
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 05:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788524239; x=1789129039; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XSF+Nq69G/jvZDGeDONrI4RG5Yp/LQW2bYbDQvdPi8g=;
 b=KsqUYiDr6ImM3ah1ypuLfXmMKYqaFVcraQo3mOaxerKuPDH21NhcaCAnzc/+wzuY/K
 oYrgkbkq6Gtrslx46cKB11j4vM8amLZj4EzK79kwQISApBGveWxtR2IVIAOGiZbX60fn
 /g/FrPIcukxLiysf6k7d42BAXIhwTOtbfghXdajob6urjml+L+2kBdDFUnMSNcU5bUf1
 f2KqUa34+LoM6IaFi2YjqOXojrTz4ovsTG5cJf/UQkuw0iR0V55XoQtmTLomeP8M5gkC
 ygt4YHia04B9CKQqkSXy0+/6DMmE2xkM2buzy3RHoV+McxXBd9N1uDMlQrQU4FSCAG2h
 Znww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788524239; x=1789129039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XSF+Nq69G/jvZDGeDONrI4RG5Yp/LQW2bYbDQvdPi8g=;
 b=cdrxpaERHBu4r1PNeBP1O435pF8hTORcNErvjTggM+aKHfnmRRvBt3WI5oCY/h11ui
 sr2pycRSzosc4ERUShduea3F05USC8DJw8I7NIT5nWXQwQ8PYP1CzZcGzKeKtaIX27bo
 +uTTfz1Z4wxjxkwWC5k5zeMEAVxg5865JU0r8QyQgWo5eqov8b0raxBqE7YCe5GeF/Tx
 bLmReQt9TykEYkxvuhLcRZ2dLuiVwGp11VTzawWF05CJyyH8MLWrUQa577RngTjRFpRV
 QhcUPk+whlfGHKK7v+wC5labqidYrD8PWA2oZA09kPK4wmTyB9unxBroCmwrfKZvkYvZ
 apNw==
X-Gm-Message-State: AFuF++mK2LC16p4v+iyUZc9h05/sdAM1pzosaOcAxpV+J/7yV1k/1XfK
 krTdDJufTdeLFd+VZ+APvw6cYw8YEPWcCOOG1TmjMuqgHfz9s8FMfdeP
X-Gm-Gg: AYBFou0U7G41s8xpKQYEik+ijQCqEYfs2jmL/fb4r0w6pyH3Ea+FLfCLRqrVW6I5Ca/
 /OsMbZ0xFErN1VkGvyh+xtDj+zPgqoaEDVxSm2cOlFupTyCfWe/9wbXPOJjAqJQGqvA4cKbfdKK
 yV7+Z0B2gWyXNR09hoxTFAKTVnmRmbN/6T7pEyvyPL7iE0QogqtXe7iWWPppqxOwN76tiB/9V3h
 nCxIoqHDo4c5bkUFyH1Cv5Xtq3+Ri4mKeXd1XihXiMTDpm1c3MrGpd04R02ieUzDBIvxaE3/j7d
 UJP7ZFoyGK0aAgdx8pCXYeNRif/TdmAndeySI8KaWeLe5PGmt5A1hdTF1Cb5d5biooMElhYTMHj
 HBP7zvebp15qdH/aciYK1ZpN7uTZHKGDqWMNdyVQiP+RW0bUyUPELqEyAvSBlrw7ZmcEwimgSHn
 RMqxg8v16hP/kuFgT011ASaCe0InoBBVpPubzMb6Fu2dVEF+wwe3YtqthmnH7aj4qJKppHvqFD5
 FFzzENyb2Jbcxf8DVDC3cxwLXJ8P1VQPctaVfB+FUg5ILAabYJiE+A8BGz2fPaVDt/i/yPy6AaT
 mg==
X-Received: by 2002:a05:6820:1501:b0:6b7:8396:f3d0 with SMTP id
 006d021491bc7-6b78396f856mr1551099eaf.50.1788524238957; 
 Fri, 04 Sep 2026 05:17:18 -0700 (PDT)
Received: from
 runnervmgx7h7.ogivjxsiwz1ezf4lkjajubtz0a.yx.internal.cloudapp.net
 ([172.208.154.25]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534152sm6285184eec.10.2026.09.04.05.17.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:17:18 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jan Stancek <jstancek@redhat.com>
Date: Fri,  4 Sep 2026 12:17:17 +0000
Message-ID: <20260904121717.8675-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <a308e12198ce96305761a009858fa4a80c91f932.1788518850.git.jstancek@redhat.com>
References: <a308e12198ce96305761a009858fa4a80c91f932.1788518850.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] getrusage03: Pin the test to a single CPU
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

Hi Jan,

On Sep 4, 2026, Jan Stancek wrote:
> getrusage03: Pin the test to a single CPU

> +/*
> + * Pin the process (and everything it forks) to the CPU it currently runs on.
> + * Since commit f1a7941243c1 ("mm: convert mm's rss stats into percpu_counter")
> + * the RSS is tracked in a percpu counter whose fast read
> + * (percpu_counter_read_positive) only returns the global count, ignoring the
> + * per-CPU caches.

High: This setup makes the affected 100 MB child report pass instead of
exposing the approximately 64 MB getrusage(2) result. That is a kernel bug
workaround; keep the test migratable so the incorrect result remains visible.

> +	unsigned int cpu;
> +	cpu_set_t set;
> +
> +	if (getcpu(&cpu, NULL))
> +		tst_brk(TBROK | TERRNO, "getcpu() failed");
> +
> +	CPU_ZERO(&set);
> +	CPU_SET(cpu, &set);
> +	if (sched_setaffinity(0, sizeof(set), &set))
> +		tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");

Medium: cpu_set_t cannot represent valid CPU IDs of CPU_SETSIZE or higher, so
CPU_SET() leaves the mask empty and sched_setaffinity() fails with EINVAL.
Use a dynamically allocated mask with CPU_ALLOC_SIZE(tst_ncpus_max()) and the
CPU_ZERO_S()/CPU_SET_S() interfaces.

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
