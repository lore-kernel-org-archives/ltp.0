Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CD4AFED3C9
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 13:45:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A9953E534D
	for <ltp@archiver.kernel.org>; Fri, 24 Apr 2026 15:45:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B1D9D3E146D
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 15:45:31 +0200 (CEST)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 787A5200239
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 15:45:31 +0200 (CEST)
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-8aca4e14411so96249576d6.3
 for <ltp@lists.linux.it>; Fri, 24 Apr 2026 06:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777038330; x=1777643130; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sUci4JmTD6aysltfKwOlJ1Kzi8mLAHDyS1W3H/aiAnc=;
 b=V/MTkOew9Wk2YHvuF6KrVeHliOBRFmdYGjJYL05sFunjANyjj4ZPoSLKHxirSOWQOe
 uGeMc4QjXpTeCmniUkci9EZxOt6m5IwLg3L9dqDlwIbrhzAP8kcdDSWMK3beeVWVNibK
 ifMyPuDmlsyaiNaNwx/PV6w+mxQuVIsmOJBM3wEDLqqsfXVFP5Q0neaWAmkorFlcdqVl
 LlZAwo0pcYIWX2QaXNWMq+hMvsAoTwp+wowfpaVhBfbsNDKU93TcqoLfWlehiqStN96L
 dMYtBnyy8MZRKSxOuw2JhWSVRUD10RjnuNrF0yU7pz5V++MeolUbEidgtj9qSKa2IMcA
 /cLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777038330; x=1777643130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=sUci4JmTD6aysltfKwOlJ1Kzi8mLAHDyS1W3H/aiAnc=;
 b=D5EaO5fzaD4IIzD7NDf3WrtVpM4euN2WS2Wk8DAblonTRFhSjX9JLY+yXixSOw/eHP
 uckQbMOVyU6G3dK9DWFaTfoZ8tDqYhQspA3ZAuaVx2O03cU3b0u8T96Hb9TcL8PtOb3K
 jFGyetQsNAdIuVsBk7u2IEK/0G3bCAREIc4l1bytoTYH6DsudaEGZspnhfBQmyVd3S2P
 PlYScp14o4aXr9Io/D068uzfEYsWApWM90i294sa10Y0ayp+ADNc5fRu/YNC+In5u/js
 ws+l3jtK96kjd876V5/9zAoSdhgb8Mp6i0w4zWsIPQqPGS7GI59q1kQpJOoSvvGEMgmC
 LWTw==
X-Gm-Message-State: AOJu0YykluP0gA5RIq8Sv5q/PWzbfHze6fJkXM6FtoAl3qktL3SDPy4N
 Ah/zeXH+OmkgcxYNLda5KD4V0woiQYtM95H+/NVU1qrNWIALVjL02Eb9
X-Gm-Gg: AeBDiev9RmNUPS0Sq8Q1Mo6nFrXHt+Ex3iZoSydOM9rm4slLRZj0d3RbaikT4F5zvcR
 Hp9l6p4iT+H0WRUUSxfVVAbOYXztrAF3gTYyoS+whEJYH0By8vAniypHPeb7BOqp1BRNpKsoAad
 YGIvKI9mbLAi3wTNau9k0cLFmE8+7m5P98w5EEAt9nLuaKLHPNzlythMjW3gcDOC3DYyD920CN9
 gmlj/U16blmYIDKwJ1P4JzBKCLTPbTOZZLMOff+DqEPQnVjsiIiHfi/Qa4ZQei0TkTEXYVqCWkm
 4XQ+c7WjMr55Xk9bjrSuJxwrjScyHLpmngyLHvoHC0KqPiD9dSSf3Vrn1wKaYM/sG/yWtWRI9KN
 q8BF44vQuM5dvwGtlFafUchBSzhS4teT91TNIOPuKSs1TD6/DaMHgBVUwOtVZZTIJBMdt3P4s4I
 +3TCJm1VeP96ZludP1dUD1RDIgU2J3GIibK5BeeczsqH9mLCCl560a8+eBAXJ3lLElOOpcP8S/9
 SGu735YSkIDUU7UHW6BeuEU6h0tUqv5Hlhbou227PwwlW7e
X-Received: by 2002:ad4:574b:0:b0:8b1:f8fe:507b with SMTP id
 6a1803df08f44-8b1f8fe54edmr235124786d6.19.1777038329829; 
 Fri, 24 Apr 2026 06:45:29 -0700 (PDT)
Received: from
 runnervmeorf1.u1ap2i3zw00e3nek3vh4h3r4hd.bx.internal.cloudapp.net
 ([20.55.13.160]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ac4685csm182202856d6.6.2026.04.24.06.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 06:45:29 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 24 Apr 2026 13:45:28 +0000
Message-ID: <20260424134528.3879-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260424132606.61550-1-mdoucha@suse.cz>
References: <20260424132606.61550-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] pty03: Calculate test case count from test case array
 length
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

On 2026-04-24, Martin Doucha wrote:
> pty03: Calculate test case count from test case array length

> -	.tcnt = 9,
> +	.tcnt = ARRAY_SIZE(ldiscs) - 1,

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://patchwork.ozlabs.org/project/ltp/list/?series=501361

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
