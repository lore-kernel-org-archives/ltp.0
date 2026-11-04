Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC1B606A32E
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 11:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wFk7nooN
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B29353CBE3E
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 12:41:47 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86D443CAE19
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 12:41:31 +0100 (CET)
Received: from mail-oo2-x04.google.com (mail-oo2-x04.google.com
 [IPv6:2607:f8b0:4864:31::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1F0931A00354
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 12:41:31 +0100 (CET)
Received: by mail-oo2-x04.google.com with SMTP id
 006d021491bc7-702f1150a16so61085eaf.1
 for <ltp@lists.linux.it>; Wed, 04 Nov 2026 03:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793792489; x=1794397289; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pORdL9nTZPi+gy2k3Gb+15+iyt8ZRBesIkKUsVxqRdM=;
 b=wFk7nooNyojVye8gQRFbuuUUDU15XNSQhPA7RsGH3uQBLGDmkLhSmqvWRma+Z7Z+UY
 9poACUk5nD6YUX6wjEMdazBnynHIXdqyjfo8QtgIoNPsez62/Ezza1Ynuo+oiLaiRfR1
 BpOQvTmRbjmKXgu61MDHvPEb9j8wDI9AWOmAiiabAP7Za7WC5zESHJ/AZ6qz9W8wpagU
 eLw9PmkiyH+9K3WW1whtKJpvwImjKx+OnUlMaFCe8yEcWRsTs5t8fs4v1ZsLWSf2yqCA
 c+vF/0HLWcWXRFdBtBgXFyQHiUFEBA49wsDsflpocWDWsLpxPA8IExqNXZ/VVFm1ffuG
 NHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793792489; x=1794397289;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pORdL9nTZPi+gy2k3Gb+15+iyt8ZRBesIkKUsVxqRdM=;
 b=HmUAUhjeH9LZ3M4eZurI3dKr8ifo1wg8mc4uE9bKt+XELrP3K3T8XRsGRq6pGbNB4X
 RUCy8SF1b8OTgpTG7G9TAQkjiL61mk4aE0QzKypiM+Rbx9rSOwtUN+j/yRmT1OKgbUgq
 dYzrPpZR2ECSuMNiG2K5VKr+uX23CQ5n+Ak2wpF2NxhK1kHwVzVZlaEu/kx7wYGk33hl
 OrEtDstY2Pzf/po4r665nnBeQiWznxUXTg2NFekiAdYWy5Bk/DE2RP3tkqHXQeAz9ZIs
 TNQaunRTJU0nbYOKI5tYahpVqxCxLS8OOSaUjKO7x2q0HRdNTa/daJH+9yPESEaaVV3m
 jFCQ==
X-Gm-Message-State: APuU4Z+pht6h8FGMgCCgU0G2pPnxchIQWXEpCf1Qt10QIgxbBZSn266M
 pL/aHsuGPsQBV02s7WwFJWduX6MzWM8rPmOpMaTdWM+eZU3jS3UTkWtY
X-Gm-Gg: AYBFou3H+BXkYAbN3EV+YwwpZ99x/QMYfe7bOo9gFwDaMPA3D9ghNZYt58Y3LRsnUCB
 wmQxfNQXheEal5aGTuceM3I/pDjKNrLDuTxLltui/xGoL7FYY8sR4bv3QKrTO25ID1+6b9a3NhE
 pG/y5p4j0nzolKDMDpzJTEqijYHMsQfDVmkt4ItDNC/KjG0DvzwQrHBlUrg8U+zwpXNKFk3k4kA
 vKnYO7mQPx4Du7dJY12M+PTBojQ5wZct/K+N7zY8qK3s0MWPOIYi12nlir3l2bfSaQsrJtfQ74B
 qS+nHwO3ogZjgqFYw0F8UPjSJe9pxsJOQo66O2giXn11+uXeURIZI9GZ8ieUM0eaMWQm3isUgfP
 wlw7JcJ3ZrqI9QmUB8iD/JT2aOU/6LU7ifV2GToCZkLLgXgd93x+AHxgtznjTuOWqhZrLZDZvL3
 Rtg5qy+Wjshv1y/orns6gNjHuuhi5PmnUTk6pVreHPl2IUds/6qfgmkWGUPJzByEXj0BK4OQ2U6
 yEfpVRuOVWJOH4KjQJaMb4BH2BaBILYCkDw9RMq7O6veURD8XBENZ96/ENirG8qzI+PiOmveoH3
 lpx8RxE12vIgnGQl8gG9zc7kQwW+lY7U51scrqLr48Vm3JOllFG32LRAwhQi1QAn1buwVfcuT7J
 TIcFHzbjKIa0MVxkRtpjkshHA1F/sTElXU0YrPiZIXg==
X-Received: by 2002:a05:6808:150f:b0:496:34a:d7e3 with SMTP id
 5614622812f47-5640dce920dmr11296789b6e.17.1793792489492; 
 Wed, 04 Nov 2026 03:41:29 -0800 (PST)
Received: from
 runnervmnwato.qp4aleha3tsu3mttg3kqyr0yhb.gx.internal.cloudapp.net
 ([20.118.38.105]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-567a9f400fasm1391908b6e.8.2026.11.04.03.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 03:41:28 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Changwei Zou <changwei.zou@canonical.com>
Date: Wed,  4 Nov 2026 11:41:27 +0000
Message-ID: <20261104114127.3917-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104071908.128726-2-changwei.zou@canonical.com>
References: <20261104071908.128726-2-changwei.zou@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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

On Wed Nov 4 18:19:08 2026 +1100, Changwei Zou wrote:
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
