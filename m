Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E6E606A31B
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ATmFoiE3
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27DB43CD7E6
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 08:31:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3381A3CBE3E
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 08:31:29 +0100 (CET)
Received: from mail-dy2-x0a.google.com (mail-dy2-x0a.google.com
 [IPv6:2607:f8b0:4864:36::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C52372009FF
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 08:31:28 +0100 (CET)
Received: by mail-dy2-x0a.google.com with SMTP id
 5a478bee46e88-33e5ae86ff2so706580eec.0
 for <ltp@lists.linux.it>; Wed, 04 Nov 2026 23:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793863887; x=1794468687; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fJpN6gewcEpM0ruw62aRtk1qibJpu/Pj8aWmkF9kcDs=;
 b=ATmFoiE3PwA18zhU1cIZ8VIuWJDxGqDXSUN3RIw69ChIZ8PwdHqPsXhq4LOYHoAN1M
 4LcLKt8DU9IJJwyepuIIlqWxX2nJGCCdiReG0LoQ/QkRH8uC/m9MBVFlSpWUESRZlOlT
 L5geao/Qk3O1iFTyeGEN7nO/q1eahcJtSZJm1Mf7kA3a8c74JIYbDfbbGUVC1WV792c+
 ehz2qPJDo7lGJlNOht/BK1EGkwxuASt0Vj1SWu97yVtURX5+PpyKZmx3xxh+M3H4QWe6
 6jIMZ2bvW2fhfdNvKrOmpYgyT3+NumK1CpMgXjdOmc3BodvfokJclylEBsTQSaNV3yh/
 Qikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793863887; x=1794468687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fJpN6gewcEpM0ruw62aRtk1qibJpu/Pj8aWmkF9kcDs=;
 b=DYLiJhWX7HU1COiUxWbVDrVnT4BjKYW7Rz/pTXYtYa8EYYyU0q9skLbiYhTuYKUyJ6
 si7q14MQktbT+luMpzhlhmzxl8ihakGZ9QKzH/KzU4kl6mU4C1sXhbfPp5LgqW5uVibK
 isj80eGInLBzNdog8etbdnAMcC/uAA5eVAwv18Z3cer9VWyH6cXhHRpbcvNj+ReggUSG
 NkdDLdAEoSq9yjPR0AnDP823sKe0Od09MPHU50WB4PHwm0Z385+0c3Q7H3IVYVLot8d8
 jZoTIdGYXqbBzSbH6Mo13OMRERQEAtbghoflaA5xGR1TctOcO7OhnLIe6Jtobqrb1Hs2
 rqFQ==
X-Gm-Message-State: APuU4Z8BLFxRO1Dr8+8m49PHUQ0ECBV9J3hbSGjb/K25jFbptsrrxMr0
 ADTNBTRJ9fwkSGkZPjyDOG1giIOkyQdMqYZR9V8TnWSXNg652aDRefnw
X-Gm-Gg: AYBFou3rs6jVM4/KcR7Vpw8rK4FUF7o8Poz/0C6J/pgDnFL0ZO5Bryna/4W/GbvlQWh
 ArOYRnHYDQfaSU4bcwy36ab3rFgRYYniLHC5zHLu8kgoJizsvhLZo4ChzNnRBMzh75X7vZx+qsN
 R/1AynU9H3kTU2h7HIeLf+gFbUZ13SI7aO+5d6cMPkTbHyy8IClBdKtYho1eR0ycUtJ3Ikr8DfS
 NiIFIl5kJGDq411q3MbIdw1bbYNeGaLRWEa6sCgmM5c60fW4pnwsmS4HqtBogeyP4I2wyIFh8dS
 slkPtTFqYodo7gn59cfXI27ITQMc3YyQa/Ciluks2cF5tjOymCm3e1VVsnHEfrCm2zoz1HjSBNO
 DaPq3UkpIpZHe3unIQaAkSxuRX1qcVUmHn77wijnr/LgO68JzxriKeRPan2JFpyaVzsjDpz9KKx
 sNO5TPL6cvc36r2B+KrtzrSWIUrYHvVxKrKI7PEcfFn2RvpNLkDiV/+25tTzbWYry9JtOigoxOd
 Nl4jy6FrPtRJ90Zwm8QzvHsdzhRzciq8k2ZFBQRdg+emMHxmEsvDN/h/y+6KaXprkR83pWN6MDs
 hzfWSXlhaspXhKjM5NELErZIKXOekcdKcvdOXdM3IrsjDvDA3CHMug9DTmB047/U2Q9bA9rsFxQ
 bdepCGNuInmiKg4aT+DRYdBFSWm0/F09QMxrTLZeLREomzwSLNMoo7T2WBgYkPJg=
X-Received: by 2002:a05:693c:894f:20b0:369:d992:e3 with SMTP id
 5a478bee46e88-36a4242b2ebmr26266614eec.32.1793863886917; 
 Wed, 04 Nov 2026 23:31:26 -0800 (PST)
Received: from
 runnervmnwato.a5ptdsnimkhexhujicmmq541ee.phxx.internal.cloudapp.net
 ([20.169.99.53]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca394f297sm16179778eec.21.2026.11.04.23.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 23:31:26 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Changwei Zou <changwei.zou@canonical.com>
Date: Thu,  5 Nov 2026 07:31:24 +0000
Message-ID: <20261105073125.3672-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105005506.76889-2-changwei.zou@canonical.com>
References: <20261105005506.76889-2-changwei.zou@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cpuset_memory_spread: rewrite as a C test using the LTP
 cgroup library
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Changwei,

On Thu Nov 5 11:55:05 2026 +1100, Changwei Zou wrote:
> cpuset_memory_spread: rewrite as a C test using the LTP cgroup library

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
