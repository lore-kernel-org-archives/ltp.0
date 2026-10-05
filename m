Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2622ECA5FF0
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 08:28:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46CAF3E4B54
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 10:28:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BB623E2D84
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 10:28:18 +0200 (CEST)
Received: from mail-dy2-x08.google.com (mail-dy2-x08.google.com
 [IPv6:2607:f8b0:4864:36::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0C70C600271
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 10:28:18 +0200 (CEST)
Received: by mail-dy2-x08.google.com with SMTP id
 5a478bee46e88-35133d53028so448701eec.1
 for <ltp@lists.linux.it>; Mon, 05 Oct 2026 01:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791188896; x=1791793696; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=r/mjxbT9fK+12eL7M2vppIZMuoIusOiKt8SPjnLMws4=;
 b=gXRPM6Ns1Ss9R3L1fItHwK1eamv2bDAu48VJp+rGeFgqlQdYkZQyKDsicpwhpKu+Jh
 sXVhVHWENGRyLzo9f9Ud/CPsKvfuzfFxxrwwBAxRqz2lqzBBQ/VkHK0YexRBT/+0sy71
 /TlEG8Ax79ncK3yLEqrzopS2Y/+tBDey9qQgyLssNK2ul+vhi0iQW4EE3kQBialu05jm
 /bI3D99DpYrdAxHLXMNCI/DUANJSc87mvax90KGuqo6dJqVCo0rNWhiC+n5iB2/8c1No
 9mYSnx1PgEjro5aFvhgADcYCZ4OX9WKignMisDT/qCVPF3R68ryouDH46WWG1rUHr4/p
 glrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791188896; x=1791793696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=r/mjxbT9fK+12eL7M2vppIZMuoIusOiKt8SPjnLMws4=;
 b=rfxxk4USWRqGe4nPVAcA9s381WRrSYFOTRSzRSb86v5OXkKB4O5m9htRByYYwAIZ9C
 VAegqTlTVGP0puww9T4A1Mjdr92PjubapA8qaxF9RoePBDDs/wcYdt2JooPL1Z9UL4hN
 Km8JdY+JXKqiNV16dvle0qtKMCGlb3njVk+q2atlVgmEL8XFtBOSxFUZdCfsJcXmKIqO
 RchfSZxcZUnvEYcgV7Wc0SHxkNSG69EJhH/jwF44i9BnTOj84nBIUabKq8WPsxfla4Oj
 zlL40TZTc7Up4rildgbtI7p7wMJWKRheISBAdYkvqCyPY5p/Yf7Eji1PQC1X3mmjcgRk
 Md2g==
X-Gm-Message-State: AFq9FYKaqwxSubu+KUwm8UoDdVEhoSzN6hhH8tY/u9y7DoW2D5kP1lSV
 uFEGuWmN/KhwcsG8sA55W6lGztGn1Tfk0YqHCp4Gwx2vJrBjY24fF6oO
X-Gm-Gg: AYBFou0oL02Xb7F8h4DCjak64cvNgty0fNf/TKE49H+eZY5vTecuz2K8HOFJoza725f
 dMrGlYHWzLGB4C9AlcSZllpAQbCzN60qyo1U6koVZ+HME/H6vDr3C6QOnj30qhmi/zVwVTIjAzN
 x1WHbtjevRadPo5msxAIiSV/cTAFY4IoWFcZEzXvXy9uIUPm4SbXsFMoSkHCJnp5xI6NCsNmrLP
 LfBe2DtO6lsvZoVcNBRWw+DBah0Ji8HzE+uHL720YPAV7RbNwTRciwjJ1miC1k9JVxiRMqhETqF
 2Wqb5nu6oBz91lY/ZquzO11O3Q9KuwJV3mWy6N42N/9cltduzqT94/uPtR658sEQJnbK5URCoAd
 LH06NSJ8s8ygHakTpW7C7EDfbGN03jhLLbnPaod0tV8B1hbYixNCzE2AMsYtz/jj7/6fUlflH0v
 J8l8rvR9qCYVfp9lFwrqDITCmKIPOcEZmNAj7xbBGY1Dn2EAaOYHeRDBwWCmRSxHKg+o7knbiBC
 Vh3rr4KrSNZsQVvPH1LK00mq0p8P6fpCqoxanR1yIvE9swLLfmwaKeBZqhkbS8sle+VZuBREPul
 qSaxRCK5WQ==
X-Received: by 2002:a05:693c:2a11:b0:34d:2084:12f1 with SMTP id
 5a478bee46e88-34f218564eamr12735041eec.33.1791188896222; 
 Mon, 05 Oct 2026 01:28:16 -0700 (PDT)
Received: from
 runnervm8df0l.gk5s5zgvqmpebimwnvrwccxg2g.dx.internal.cloudapp.net
 ([52.225.25.98]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-351271612e9sm12028210eec.12.2026.10.05.01.28.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 01:28:15 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Mon,  5 Oct 2026 08:28:14 +0000
Message-ID: <20261005082814.9390-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005061933.4108985-1-wakel@google.com>
References: <20261005061933.4108985-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] pathconf01: Allow EINVAL where POSIX leaves support
 unspecified
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

Hi Wake,

On Mon, 5 Oct 2026 06:19:33 +0000, Wake Liu via ltp wrote:
> [PATCH] pathconf01: Allow EINVAL where POSIX leaves support unspecified

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
