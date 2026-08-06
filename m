Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA5DC55ABF
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 07:42:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D5FB3E49DC
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 09:42:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6600A3C73A9
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 09:41:52 +0200 (CEST)
Received: from mail-qk2-x01.google.com (mail-qk2-x01.google.com
 [IPv6:2607:f8b0:4864:34::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9CCC06008D6
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 09:41:51 +0200 (CEST)
Received: by mail-qk2-x01.google.com with SMTP id
 af79cd13be357-92e56000adeso33501585a.0
 for <ltp@lists.linux.it>; Thu, 06 Aug 2026 00:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786002110; x=1786606910; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rF6ivrWvHeLiOhaKST/zbl2BiHxsmXCSK3h8xW/8Qfw=;
 b=nSS61e9SQgh6WhwfKrQ5zSQe1zpl3hMXBnf5VK1GUX1CmR7XXJO/6Xvj+M3C8CIgST
 DTC7aSBuRal/P4n8hYFlvlyVRzMfqVkHNNg81VTVsL0ZXnx27RoSFtMazIVHUY6pm4AI
 caf0ldP4XDGl/kLuRC/JiAmrA1bV6O42jLgPTfu4cEqyfBlN3KqyVjnesl3kJjWtQvFQ
 aKSzefJyvgB7H1yrLSulpX8SL5Jz3+Ouh6pNdjkp7Imz5MzwKCOk/8CfbVkGhUowVkXV
 oKUNKwY/odwFeZDNGJZm5eFs4lr0f3TCOJuE9mYlC5hbPXpfbHOfTLoEZNn3Mt/eggAC
 V+1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786002110; x=1786606910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rF6ivrWvHeLiOhaKST/zbl2BiHxsmXCSK3h8xW/8Qfw=;
 b=l7bOrM0m+Vjw2BSdhk6OMycJB6o9rHiqq5NC6WaILo7yG6E2kqC3kSfB3INCTj1H+e
 wmMbww2qH6+wSYuWOiVPm69VsNnRKMm+cQ5ND3icrSiZGpRW3/fHy0LEEa8zBYM67grZ
 fsMVs6EZuSjLNIwdk+cpvBPAmQCAbRGejUPNq/6bKncSdh87dOpRKWmNwCYsAbJdFJi7
 wpPYy2qN1WLvyP8qSPqn9leittHCbGNxjyCDCJJYcMCm50ZViJtOVrUNrlZnoWPKEa4/
 ca4o6kMA47cuLF1zmTIqydRuWO8dAjgQuANrZfrx1tr0h0Y/yvXX/s6mACU+VmW3LKKb
 S+sw==
X-Gm-Message-State: AOJu0YzeginV4t0ibQRDIaNuDzpyIR22Z/I56OK25/aG+QNnMrTBpWoO
 ynl2y8YX9XU0MMtKN/XmKLMMe2iaEM+TCbROiIApZMn5ezIybTgqKNdG
X-Gm-Gg: AR+sD13BTN4V0mSGy6Au0dzt97LosQT/k/+yWkV/mWi2w25WAvclZOzVussV5EtqVdF
 u9S4LW0p1qXc80ykU8LttHDkiBZIkRxPUH9gfjMbLHniu9CaEEiBRTyReAL0w6TGtogwqVloY/g
 ocZSLTOiYWAficHsy/RrbuX7ZSuOnftB9Gzj1RrNM80xhrmsTRKmqJW0l/45/SWrLLicFAd1cSW
 sb+4y5emVbkxB+UajqKwC0RSaOU5QWfbrdioiDstkCXpvpdcnMN/u1FYKC9AEPKRkKHE3FmJWuR
 Dh1tJt3ZTp9QTfyfEaZTTIDKgpF+3CgjxW6rgSh4vev4RWU/MiWrGRhqSDqiH2vaKcZNMEwUm5R
 /fI6IXqsuJWOV1O4Shq9WeijTa3JyjtTm1d+o9lie9VWf4ubjSWIaG9ql9eDrNm32AXhCq20zuC
 U+WTWUL0xwmQPSHh65KVpIkF0mZrJdZDGs5YUFCH42jJaHAayYDGVuU2l++dqoYYEGmKDU7HqrE
 PnhMXDNCIeeVFuCoyn6LUGbJ3StZekKg+LT6fDzh07oNThXZfeIV/QTMlNqR15RAc9XSac+z+tm
X-Received: by 2002:a05:620a:2258:10b0:915:688b:aba with SMTP id
 af79cd13be357-9364913ba5dmr986847085a.35.1786002110179; 
 Thu, 06 Aug 2026 00:41:50 -0700 (PDT)
Received: from
 runnervmvrwv9.530sfc1j1x4exldi14v4jjn2ng.cx.internal.cloudapp.net
 ([20.109.95.164]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9364a42f345sm346708985a.19.2026.08.06.00.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 00:41:49 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  6 Aug 2026 07:41:49 +0000
Message-ID: <20260806074149.8930-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806070625.19475-1-chrubis@suse.cz>
References: <20260806070625.19475-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap36: Fix compilation on alpine
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

Hi Cyril,

On 6 Aug 2026, Cyril Hrubis wrote:
> hugemmap36: Fix compilation on alpine

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
