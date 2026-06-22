Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E9FECDB46F
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 10:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782125334; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=ZpakG/doqRzO1VoRsr9mY4VySO22UGYkoyvUGf5Fquo=;
 b=d4hENRbdNBsNso/kY0ytknZzWxN5+/o5JzpCHEG+M8+jKB+0noinWXVtvfO8Gi3R/GHjO
 wvtO65QTexaihYvkO9gKEmRDpAJJHRnudzHh99SAUGze/0bZXBDviXh3W1GoJhuGLuovBWY
 OT9864vnfXnOoG7yQKxRey4emAPvP9k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EE07F3E697C
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 12:48:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4FA273E53B0
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 12:48:29 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9308E140018A
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 12:48:28 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so40540595e9.3
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 03:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782125308; x=1782730108; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=/ggOIlYk1vninWHed/wiRiChBFpzHi0WIC6R/DlE/iE=;
 b=MZLR7TVyVnelPWS+rzq5QasOkJPEGIr4O375opdEGuvAfqw4WWc4WkgEurmzQT4HJz
 YFomznxYlPt14u6DSyCwSUDhWoc04u7oV07MNOIYXPy/X8pysU78RGY7dcgpA4pLDa5u
 c5OANMM4JPwVC5AihqggSTftltoooZ7Iug1Ruw2FKYu4f+9isPS94X+5qdotCMUZ6hT2
 NgyAHd5NP2uA9ZDedBeuaDmChA392w6eaFiTGvwLdwgoWxP4MDcoswInc5COkAOaShQY
 49EL/ntai6uHIXFLe6odnIMfd+pOqyCeczjPxqRHzNjCu0MLkR5itXoc5jgS3BvTVSMZ
 5maA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782125308; x=1782730108;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ggOIlYk1vninWHed/wiRiChBFpzHi0WIC6R/DlE/iE=;
 b=q4NAz5wZhT9QxnndSin/c9HwhhtMUv36rilfuZO5md+QFxDvUVmoibtpidqQl0drgk
 rFmv6KUD6TDdWH8ywOnvgpFYPcVcBgKnTQzOpMx7dtPAY3n9Xu5Nr//Nap6AxWjOhcH6
 RkDpHEtL7Su6KWzf2MCMLgpqSV5GKy2v5QpS7HoOa89gIv3kET5Ql/XRHDB6KHaGKC6S
 4PrLSFofFAYc9WFyZfKmFm8FSwui+moMJ/Mfl60GhBp1BjhRvL5yxREi8FeaHim0IjUS
 Q4Lf5sOpafc8lM99gw7b4TOMyP2iuvI1Ulriv+LF/Sz8zpQhtSMnHkwdTd0NxTHQh9FU
 1IbA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NErrJEtzUOe5CRKuAKNGeaveNsoeaioliRv/3kYV/13wW5jDoNUw+Hz2PMSY6NATrYg8=@lists.linux.it
X-Gm-Message-State: AOJu0Ywi/VAYA20nOeEImmypO8ZIN1RCEKRKf/DD3CAFGmFmBvQVxiLF
 TcYJncmJiZYJGq34FWEiAgS76wtFGqzu9zPAA6fAS4xNlkNuAGl1mLPSiWQwOS6dfCE=
X-Gm-Gg: AfdE7ckph8UlGP5PT/opFWHr0rXfCDRUwJRUttPQPRBnMbuKqbpjRz28QiApzOKudQl
 L8ZZ6yWobUZxIzCGADkXGey6PiQN3+mthoRi8m7OvCDb1VMtXXAqQPm3qt4f58t98Ow/iThewoB
 txUJNbsqGttzNhNIG6vFOrC5vYGv16YEblq3kPsuu7MM9icRejdlRd79whnHW7qJVmBMcqdqm2p
 Qg4Ac4pz7CvcAbUGvV8uB9XUQ350TUdb7kFuxmLpcgOixxoQOZjtg6VLU+gnk4YEMCAEQTFzxQT
 7uwzfuxwHXTDWT4vy1uXCX2mvvB5XJs2AYPzwDVEX0JqW3HKp4eTa0j21I1U9lQMghA+NPvyRkd
 L+A6ouq10ZK42AnLIww518OjC3QksSJ3CmgE3Y+ZFlOb47WDqxJE0kBCsil6clKYEmeqAadh1fz
 UaqJjkX5pSQLjyUPiiZbdsd3oNe/Ik6zN16ltGjtWB0GXPAGcJ3uTn3iasIgNfcYpqI409qygt2
 Tl+W7u/3SDTRq7gfVZVoYeP
X-Received: by 2002:a05:600c:8010:b0:490:e170:b80b with SMTP id
 5b1f17b1804b1-49240e7a4bfmr219851795e9.32.1782125307918; 
 Mon, 22 Jun 2026 03:48:27 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4924923914fsm211829625e9.6.2026.06.22.03.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 03:48:27 -0700 (PDT)
Message-ID: <6a3912fb.459cdc55.211296.c4cf@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ajkHmVoetXBnSDD7@yuki.lan>
Date: Mon, 22 Jun 2026 10:48:26 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] metadata: add tests grouping support
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged with fixes on agent found issues, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
