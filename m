Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDA87C55162
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 03:37:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C037F3E5334
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 05:37:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0951F3E145B
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 05:37:13 +0200 (CEST)
Received: from mail-qk2-x00.google.com (mail-qk2-x00.google.com
 [IPv6:2607:f8b0:4864:34::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 847A01A0035F
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 05:37:13 +0200 (CEST)
Received: by mail-qk2-x00.google.com with SMTP id
 af79cd13be357-91d4455ff18so70693485a.0
 for <ltp@lists.linux.it>; Sun, 02 Aug 2026 20:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785728232; x=1786333032; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LUY1gQc/B+QyhHm7Lu4mktueHMxQLBxXuohAGqLPi/M=;
 b=QdclDLd64drHa5cQ6aGtxl2nfpBLQfhWTJ/KINU3a2GplaucY9KfiQ0GkUMd8iiSXd
 EB+XND4kBWqgtMOlwMFgOMqN3+DLMIF4rOJae6hgiDpHijQAnoWGes4Rd0Men1j3sOvo
 MQrfiyAQ9Tt+LP+y4hqpceOJDP8LqyJip+Bi/9ZgaC7hYp1N7pZbEHBa6fD03PRP14Qc
 oqFAaSsA6Zyyh+/uXDtcBUKcTkbj+1lcEGOPFUUFyyEe2bxhcdmY7m2PJP8KZxbm4KYh
 YraABzL8+OqIa2adKIaMryzWRsQzoU8H2/RkDjeQgvgGokytKJ7sKJU3SLC8SY+YECA2
 uR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785728232; x=1786333032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LUY1gQc/B+QyhHm7Lu4mktueHMxQLBxXuohAGqLPi/M=;
 b=F4LIwOaRfCxVcKfzk0SQFTHUAR99paTE7nFQCK8Z57QLJo5JPNmfQG0hAF9suhV+6x
 jk6seV+qKKds44Gx3DMimeSwNOCsGzmMBMIuImt5shSs9o7bY5K4UmZ7cy9CcaO0Bx4T
 A+LQp5OEGZvlIfe0GBP5VwNAcI0EqlyhP2xom4rjgzg6R2Cf8XcuMCkiDK5In0Uw3ZrG
 grJEBkgjd7wtdT3z7vTPrU5A69BOMhJQw4SFPR4wAYw7pA81OucuAxuSy5YTug8Z3z4L
 HKCrqCnBCngKv3rm674qAqmPCP9Q4s5DkGHOyxp5HM/GxeGzXHBVlMb6JVjfhSpFAX9w
 sl6Q==
X-Gm-Message-State: AOJu0Yw+e9T/meiCX3lAbzfEbU31MuadmnwViUuiBPiDh/H9/ZrEbKIh
 YOZr8c41V3KUkGpgwtR9hfFHTF+fgo688AN1+HMtrgP936B5QOTedcs4
X-Gm-Gg: AR+sD11G5SjjewxrjaZ39ODG9kgXJo1wNe4mfUUR0HxaG1YmLPL7JnJXFQwd091PvIz
 KJldT3RnLzqDKL5xCGwZquucZcqz4NaqqCpnJygvUm7In7W7BBL4EZ0V9MB+aE5fxQs/JPPl3sM
 sglLvg3BrGuM418DkpIAh3kUcnYyzBt8EnJWR11t/tn7NiXnqa7Az4M7+lT3pbkY5cHknpn6KGO
 Zn/qxJyS6r/ta72Vo6I5zGaUkaGqf0Rk8DCxrNkYEG4ISNwnM12w1StLUMEIjOxsxfkKEycSC3n
 MECtn5zr6TyP1okqJOT48AO1Q83lKQPQFa0NcEJcmQq7s9THmLPL3q6sXDioNBZ9mI6SSCu60kx
 AVEI1L1GvWsa8aIhYEKWGfQsh4z9b/3XMgXE2+7C8O68TPzgD3naF9ocfuNc9yc29lhMVWdZ5mx
 lX2cAGt7sS9mIDUyPfKfuv9BOjjzk+RSUF1yT2y9cMM+/27phfrsQha1m9LOdhONlOL2GnttHmx
 5LMoPIA0smWzbY1kJhg6xLVY4uZRtgkKnBdvhb5QRJlY/t8uO5olRY7JiB7VphBxC0T6ZQavuiT
X-Received: by 2002:a05:622a:1cc9:b0:51c:15bb:b4f2 with SMTP id
 d75a77b69052e-52b56753541mr176350151cf.27.1785728231975; 
 Sun, 02 Aug 2026 20:37:11 -0700 (PDT)
Received: from
 runnervmvrwv9.rpzyaon4tsbuzbyx4xvysldu2h.bx.internal.cloudapp.net
 ([20.55.126.241]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-52b4eb6d94bsm52566431cf.14.2026.08.02.20.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2026 20:37:11 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Mon,  3 Aug 2026 03:37:11 +0000
Message-ID: <20260803033711.9131-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260803021230.14530-1-wegao@suse.com>
References: <20260803021230.14530-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fsconfig04: Check FSCONFIG_SET_PATH
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

On Aug 3, 2026, Wei Gao wrote:
> fsconfig04: Check FSCONFIG_SET_PATH

> + * - Format dev1 and dev2 as external journal devices with the same UUID
> + *   ("-O journal_dev -U <uuid>").
> + * - Format dev0 three times to cycle journal associations:
> + *   dev1 -> dev2 -> dev1, so both journal superblocks are consistent.
> + * - Open dev0 via fsopen(2) and set the source and journal_path using
> + *   fsconfig(FSCONFIG_SET_STRING) and fsconfig(FSCONFIG_SET_PATH).

Could the syscall references use the required :manpage:`fsopen(2)` and
:manpage:`fsconfig(2)` roles, and could identifiers and command-line
arguments use reStructuredText inline literals (for example,
``FSCONFIG_SET_PATH`` and ``-O journal_dev -U <uuid>``)? This block is
exported to the test catalog, where these roles and literals provide the
expected links and formatting.

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
