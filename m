Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7FC6FF885A
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 11:54:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6CF123C22A5
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 13:54:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 651143C22A5
 for <ltp@lists.linux.it>; Mon,  4 May 2026 13:54:28 +0200 (CEST)
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AAB281000489
 for <ltp@lists.linux.it>; Mon,  4 May 2026 13:54:27 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id
 d2e1a72fcca58-82fb2d0c5d1so3107201b3a.0
 for <ltp@lists.linux.it>; Mon, 04 May 2026 04:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777895666; x=1778500466; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FdktCNVIq9DlDkLZr1oC3lpNxpOQPCqF1Yjukhp/2Ws=;
 b=cIYV8W8tL/T0Sw9AaFkLb0a6wgkl3ejUdzeVJIwOwz0V3NBUIcoqes09PENF8BV9HJ
 SnpaTAC778cvwKao9bLMMiFmXhh86fDJqE41Nu7tZIrDLMI/Mu4tB0o1FWMmtEqR0rkM
 3Aimohyc8zEqPIml/4ZOfmPRD6xCHNg/TG//g3erDg21O6not0eEYcJTC8oS3gURC9ad
 j+Cz2bMqu2PZSOCF3yxBRXQUh8qdZn8WP2b00o7/6/HgE4lTBZuAyPhvItbRnXqccSjb
 cerqaq3BS4VYrqUUIOMwt17B4p1tQHEogqJugqx+/6NECz4H4W5SwhjNMO4u6R/Sf4rC
 M2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777895666; x=1778500466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FdktCNVIq9DlDkLZr1oC3lpNxpOQPCqF1Yjukhp/2Ws=;
 b=cvSZTTf1IZeX87IVMXh2/ZgNklmdIcv7jLN97CaB2cgTlVstmmtbT7MB2RcNeKxTVC
 l2yLfl8dmDmhbhMJRG5gkOVWpDf6PoKP8pYmk9u1uE9Z//KW1b4HvZ1JVe7GR5DqFp09
 0dew0pibEU5zMOHEXTAZ3sy5+E0v/nvdobbhOWGpGqhEu/ZQQCJ5ZOZsPmxzBfh4mE8Z
 Ay1WqpHQ5BkxhA3ZVm7TavUpfgH14RmSzq7F7piGLdVrUlqkyVIpN+WvRRg0HLuwqPHZ
 AImkzvk+2OugfBo99xmvzFyWlP60Hrd9OHxhS4uqYALb5OakraIJaR7YpQe/3yfdkRRn
 DsHQ==
X-Gm-Message-State: AOJu0Yyv2Hj00tbjrN62PIVdp3BXHikqh7aUoBtLUBiXBDhdrFXIvjKm
 lyhYCt3IXb19WOyDZXJzBbBSLHSAC1C146tQq3V9Fk/mvAGxIAEsQ4Ewzm9VoqZadb2puA==
X-Gm-Gg: AeBDiesdyum0NodrVdeu0feIzKyzIyl0k9Ag1oPvvNwRy2LNlgP8UI8Di8cvAu1nckj
 j6CVtmInPnlGPx+eZxmOCdFBIBQAiN6iAI5YmGX/vPxaJU5+TZlrOkXE12/5vfuvVOtYSiKLIYq
 5r/wAoUq7NAUlz+7yl6KxOFqP/um1I/Z7upd2P+LgIauksjGW9yl5rE1/eEHkCZDW4gv7v6+H5V
 IRD7K3tUz4j2WndjYNx2BziPsyZZG9+9rXgh2OAZz6I+D+KiK0YbS5H9hD5jx8ko9xPzTLcFRXz
 HsbyeY6bG7bzw/DyPWv3Z3ngGt1y0c2+LqavFobt3m63B4RZXRCuQc4UcRB8VMGukkFHR4nUlj6
 PJkUxIbdP3og5Polz8if4WY5aCd/LjHNHaF6xQ+07eBksGb7Jx2RAVqJgUcN3f52/Ts8iD6UUfN
 08QrtS2ZReP3PzMtUMTNlN08BlKkriLnn5QQu2X4cAQPfpEMmWPk4AARsNqsbqWr9LMx1PVILu5
 kR0vzKM1T37KX5nSdCjtNgr5vUma1u9o9vo2esl2hdiZ/k=
X-Received: by 2002:a05:6a00:9284:b0:834:e24c:3f9c with SMTP id
 d2e1a72fcca58-8350000ec86mr14570747b3a.22.1777895666106; 
 Mon, 04 May 2026 04:54:26 -0700 (PDT)
Received: from
 runnervmeorf1.atih1j5idlnuzf0a0ifstqup0a.xx.internal.cloudapp.net
 ([4.155.99.35]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-835446b1b0asm6124545b3a.8.2026.05.04.04.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 04:54:25 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Mon,  4 May 2026 11:54:24 +0000
Message-ID: <20260504115424.3993-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504100841.20737-2-piotr.kubaj@intel.com>
References: <20260504100841.20737-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cpufreq.c: add new test for cpufreq sysfs interface
 validation
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

On Mon, 4 May 2026 12:08:42 +0200, Piotr Kubaj wrote:
> cpufreq.c: add new test for cpufreq sysfs interface validation

> +		snprintf(path, sizeof(path), "/sys/devices/system/cpu/cpu%d/cpufreq/scaling_governor", i);
> +		...
> +		SAFE_FILE_PRINTF(path, "powersave");

scaling_governor is modified for every online CPU (in both the active-mode
and passive-mode loops) but is never saved in setup() nor restored in
cleanup(). After the test exits each CPU is left with scaling_governor set
to "schedutil". Please save the original value per CPU in setup() alongside
previous_scaling_max_freq and restore it in cleanup().

[...]

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/25317225931

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
