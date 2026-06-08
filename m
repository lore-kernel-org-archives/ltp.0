Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B81CD8C9D
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 12:08:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E18153E5F85
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 14:08:30 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6915F3E6F98
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 14:08:11 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E4DAB60226F
 for <ltp@lists.linux.it>; Mon,  8 Jun 2026 14:08:10 +0200 (CEST)
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8ce9e56f68cso35238786d6.2
 for <ltp@lists.linux.it>; Mon, 08 Jun 2026 05:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780920489; x=1781525289; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I3BbcsTW89zthnJXAvM1s23oWekoXpm8pyYfS8yMjNs=;
 b=psHENNCDr4+7NAETnN8BqNlQheoHzPF99VKRlZbitpjuROvJG9ztrCWkH1Uh1KFCjF
 8m87I2qGL9DwTLQjaM42gkino17kOgEwgIiel53tbW/MxXxsKA0oVWTG7R8/oTC9mOlq
 OK9M2VsgWmPyujSc5J7lIhdglpCHpe3Jfy25owRIxztTMWOPp5WbLjNf8l0WMDPMSD7e
 VxouThOwrtWpwzOzWkRC8FK00bZJDeIAy0JNKbwZ/tYVcS+CiMuClqU962u3NdW8I30e
 0+kshTGdbNP0W5zTknzY8uNSspqOXdPC8KMKWasahF2WntTNAW8ulIASwy8Cp9jIFlUQ
 l7ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780920489; x=1781525289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I3BbcsTW89zthnJXAvM1s23oWekoXpm8pyYfS8yMjNs=;
 b=IHEkO8QQ44qc3KgkZP0DnnoNnutogcexsa28BwJZhBV3KxUmLAdwG+Is8TIEPdXbw3
 gRxhKAPzHUB1PVRSPbWfYEGm8EpfSIbLvPb9R5mlzeB3x2EkTf1prfRScYuTYQXEeVsP
 rlV2BJ9mNorYpLFsrZQ2UpdDKfIdXrRGnn+nIbFiL5tIggncAJA3aSxVAsRYRxIl3ylV
 1TMfTHkHxCiQbpBPF7ton8kYPC3hCzA7hNmGd1X/ks9cPEE+b03El9hh/YDrRCSD0OGC
 fZxtzTtgJAYANU/cw0TWqw4YKjdwuGWafd8OYeplLBe11TFBuDxqDKWIMI/KMUPMDLdW
 nIcQ==
X-Gm-Message-State: AOJu0YxdhwxB2iz7rgd2/hNVKSmRxgXdLxe7KsPyyFJmYm1xm8+lcVUY
 3bWDlhPPDLRXueBtvxCrkiq0WobkET1+Vh+wYrzXT7MRGv626fC1duvzmqnIYnjY
X-Gm-Gg: Acq92OGrRFRO1fJvnhFarbT8iY8quwjOEaFyKX8WLNxcI+2PgpRCcNVJxUyHxrjLaAG
 KgzHJpE52xlrXR0/cJ6C87G+dyLqjL/e+wB58PbqH5jVpZEYJHGIOsVaQzZjTZ6PJlIxKj+VQtu
 pG5iXpAszqWclclHfjh9779bOUTbOVXepznpVGo3YQOOuZSNZoob7MYwO69Tkj6SZcURYRTR0Sx
 0zdsfGTUux2PR0fW34Ro/bGklC4F41rDr3kAK8BFAfBxFnFhutH1LzRMzzs+cheUK91HB5IwhrR
 E5O2H/Cz3CKxh+IToLPfwD16q9gRako0HaZVGjABDB1khkE6L7IJem8JoWz3E59fuHq91xEPzdg
 xRsSdWVVZjU0tGCjmvnaPt26EaEPHBPn3UyOcRaK8itzQJtTz0l64RiSvT3WlK2UG3f+kngVySY
 hlRKoR4q32Jxmj8fSpIrZXoPC/GRFSfW4emnqE30RignU2wR6jjR6eBXrAG3d6OHMpHA81Aa7MZ
 CuCpy3S2DMaY21iuWXL/Q2q4CQyecMTzeB0Q6zw/YqIHuQf2ws=
X-Received: by 2002:ac8:5f84:0:b0:517:b58e:a1e4 with SMTP id
 d75a77b69052e-517b58ea315mr65988721cf.41.1780920489401; 
 Mon, 08 Jun 2026 05:08:09 -0700 (PDT)
Received: from
 runnervm3jyl0.ysas3otiowhuxowhhblauwz2td.bx.internal.cloudapp.net
 ([172.203.213.86]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775c08234sm152616511cf.6.2026.06.08.05.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 05:08:09 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Mon,  8 Jun 2026 12:08:08 +0000
Message-ID: <20260608120808.4225-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260608074419.1276-1-wegao@suse.com>
References: <20260608074419.1276-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ksm: Fix sysfs path concatenation in ksm_test.h
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

On Mon, Jun 8, 2026 at 07:44:15AM +0000, Wei Gao wrote:
> ksm: Fix sysfs path concatenation in ksm_test.h

Verdict: Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
