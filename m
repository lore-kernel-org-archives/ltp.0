Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10D33C43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 19:58:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4893D3E6229
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 21:58:35 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B8793E1644
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 21:58:21 +0200 (CEST)
Received: from mail-dl2-x02.google.com (mail-dl2-x02.google.com
 [IPv6:2607:f8b0:4864:38::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 25192600726
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 21:58:21 +0200 (CEST)
Received: by mail-dl2-x02.google.com with SMTP id
 a92af1059eb24-13985f8229aso1931921c88.1
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 12:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782849499; x=1783454299; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0yR0hSd6nqZpm8X9CTWN1Mn5xGVPkT0p0TlDP8IaVBs=;
 b=eDgCK+Lv/CvB8c2ituNccA5TB6V6+yh7ylfpFcY14do8tAppvWp+xYU1ESUWU3Q47W
 5Bhy83xPo+ouE5vpl224lNk/EO7FBW5L1pRl+zgQBnepRs8S5MCyJ8QZw+aCskdE8Hf8
 UsdiZdW5/AkCnYYJ7YfS2Yjs7o2bgmcErPz0zqOqRPAt4xKTBcmts+F1De/o3e3vCj7Z
 KI44UuVF+/nw36YdsCM9pN+hs6aQw1xuNeKeviYMXLFz+UIRhRk5rpMfThzaWNBWROws
 CUkEbAsNwUcdeFxLZRuBY4frcEFh6vwDmk4/lovLbZSi1bFUwGTbyST/7fx6k/MZv28R
 8Ztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782849499; x=1783454299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0yR0hSd6nqZpm8X9CTWN1Mn5xGVPkT0p0TlDP8IaVBs=;
 b=OzG/H01VW/f+xRoRnYHf7J/KsNH0VbZ7liPtGviSi+wlSlxISxzrvW+GtdwAHn+maG
 JwPH8WCEYBJFmmqzJ+EE4NZbyswiOdOhkhxvh2XfCgyAXhoQzuShgHemSaxCsOZeEJMP
 B/6YUSrHhouJlClX32RfeyQFt4m7PGeuoe5Ogl/r+A08v2CzkePeOIECt/yAIaSAz47x
 cZivU/i57nqf7ma4HsZy9tB2+eoJjKDzYV+EDZVSca27SX6eP/TSYkq8VDbGD51tmvZM
 GY1KhVRex/gXxNw8NJof9ZQu9zIhV1H2AqClcJU9T7xUle8JwbDWybBDmic5brgV7AIZ
 gI8A==
X-Gm-Message-State: AOJu0YzF26oxkNmO0KPHSeeGSIGsxAGQ8NBpH2jFZxh5gnpn0ABzjExa
 8sXp1W+cw5VakaEAO/MX0WkskmB/YplWQGD7nXa33/GiztSI+SIGyD3GueTYyBom
X-Gm-Gg: AfdE7cl7dY+vAI4z0a3p1jGzG581k7TEB5ROS2tO5/NvKlWJPrSOCZg/ovYh02lnwNl
 6bej5ZHe+HhiNpnHoP7JlVzNbnYBxIypUSNw2H+kCYPnGer9yaCEdDImG4lNTLJg4QffA0wysgq
 nx9RoiRP817pQdaEewb0SFcSzoO/AcKd5Ne93e62sKTeuYda+rH4H4t4A9145tocnBdK5TGklHz
 nwy64iyBTYULMw26R502YZicKyTWOpGR6i8xKPa4w0YhZ1Axf2oQfio05Avv2AJQyV0epAVJeSp
 45Ex8O6RQ/WeMsS4x3rErQk+tB0q25muhFkms4+n0jusP0LuVTWHnlUqaBT8DkJF8rTicgrMqv4
 8keezMHFkz26EI/oYTviN8aVIMRxPJ1MOuixvqYoNoSptR30iRQtTIls3b4wL1xfB973Swa97D2
 pXQIQWtGWsLXTsvneKLEt23jVpxJA4Gvj2G8/Suryrha0I1aaeC/q+pLFaYEpgK+Aouuh1k4GsS
 DRxgjej8xxOxgTS2/fnuDPlyiuV
X-Received: by 2002:a05:7022:fa01:b0:137:9ee5:2087 with SMTP id
 a92af1059eb24-13b2a1ac25bmr3302133c88.31.1782849499276; 
 Tue, 30 Jun 2026 12:58:19 -0700 (PDT)
Received: from
 runnervmmklqx.h0zle2lkrq1evn1mioojdfzlua.dx.internal.cloudapp.net
 ([52.234.45.186]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b2ab0fc3fsm11677778c88.2.2026.06.30.12.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 12:58:18 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Tue, 30 Jun 2026 19:58:17 +0000
Message-ID: <20260630195817.3935-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630180855.159467-1-avinesh.kumar@suse.com>
References: <20260630180855.159467-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_security.sh: quote variables in selinux helper
 functions
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

On Tue, Jun 30, 2026, Avinesh Kumar wrote:
> tst_security.sh: quote variables in selinux helper functions

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
