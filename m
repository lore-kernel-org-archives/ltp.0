Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C39CD6E77
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 17:55:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 635873E71BD
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 19:55:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 62ECE3CD56E
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 19:55:11 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EFF96600A7C
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 19:55:10 +0200 (CEST)
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-8ced8f44da0so10261996d6.2
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 10:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780595710; x=1781200510; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HLXOWrmKt1qpX6/1w8VtgjlV/5XY3MAUWc9qCKlPPeI=;
 b=Xoeafyq+Y9T5I8ZhqzM2aAhVlXILSjy+YoFvLhVM3Q2TAMA1lF0qIyI/HUDYps9T13
 NWwckF17k7IOFJDCqbBpaEi7BFh7LNA3w9o1O9AkMwSv09/jCObVNbVzWnGaJcG5NJNY
 fHVXv0LDDjr7AP5QIH1zSPikkhXFAq+Gsdsy7PrKM8CzKMn9LFHJnzUINfYWs3h9oun+
 yGq+NAf19VPa3s2KOacZOvEsAs5rbxSdWWawfVZZkujAISNc2aGj46oY2qatCXXgWC4C
 R0gvmvMM9lJB/bvs8GC262AxqIMClrBYJoDknu748DYZrtIH4N08bYtaZ1Gsc/KTmdW+
 PlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780595710; x=1781200510;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HLXOWrmKt1qpX6/1w8VtgjlV/5XY3MAUWc9qCKlPPeI=;
 b=etYWuR+0w+TIjf2e+c6jz+CXadvdzmDpyaOyniWD224R7M8LG343UkVKPa1ALf/Cth
 MKzptYfoGwzijIAqmxsa2PIw8I8/3m0Klc/sInGu/nOedG/dvV3CIEOmh8WkoNU6VqGF
 sHYkfw84EEfQEtE7dxkcKixfp/EFEFfEZUjMavtzIBzLlD2MEri1W3RA0UYeGjcX5aEc
 1mSKlOdM6qy56K7RV+Q8+bxmN0FQRJGEpkijV41FZtQrjp5CRYRv+mB20TVp3j9aJlM6
 7zxhsy98iWy1n1QE8uxuVMFkRF0C8x4p44wyiLZG5uL1VybuUID1TdxOvFWFY+VAvN3Y
 K28A==
X-Gm-Message-State: AOJu0YzeIsHbrUiNvb9ZiV6+dn6S6nNQgZfngQG5jmUuQPaA+HhrZkAq
 qcsD0Edf22sjZmUBhkt5S+jt/331HjNwYs+eB3+osG1kDgYan9hLgwMj
X-Gm-Gg: Acq92OEOjKS87eJ/3wYnkCslSZUdcXIJhi1SDPOipnOuw15OEUL/txjKQvbf857Al1G
 726sr4VEg/fybvY3oJx9TDDgJ8PSFV1MDxx8dG/FoDL+dYd956gTyJs4yNIS+hh5wsQ8Jy797JL
 yr6NuZB7ztG89tzy2/LzklddNARlC5ko4ptm6r6azK+1iMNHb1PZH96gq06OmfB/Dt2hb7Y7fqd
 EOKuDQkT6m8cxd9f9xjRZXDAIssAiz4Rr3L4eGUmajK6cAQ0ZLNTf8EPnOr28DJsoYpxX5mDTSm
 sRqaxv93I7ZGU/7RXNXFreKqIR32dTEWGsNHl3/JnhJvxnrmsz8tKwohNG12Qp+SpJBfJ19QWw2
 G0wXeIbvLNIEOZINcF/Fm5Mj5TcxjQPmu8EMnTM0fTxd7tVbuqlrwf5YyZEeRtHTqevLyRaOkto
 DZsk4e8drA7xkQI3EVSYRNiWCMpl+r7IrEJ4cfgzDoCil+JmPcGfVkUVtu1M1rU5ttu02iv3Fid
 vtC6njaQUc/Z4muszcopBQTQVI405aK3E4/mUDog0+mSt0=
X-Received: by 2002:a0c:e749:0:b0:8cc:60dc:a249 with SMTP id
 6a1803df08f44-8cee63b0d08mr1673986d6.42.1780595709501; 
 Thu, 04 Jun 2026 10:55:09 -0700 (PDT)
Received: from
 runnervm3jyl0.t0wjbh1ntu3exmtqficsg1sdwa.cx.internal.cloudapp.net
 ([20.49.61.54]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ceccdb5e92sm58581206d6.11.2026.06.04.10.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 10:55:09 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: yeziwen1989@yeah.net
Date: Thu,  4 Jun 2026 17:55:07 +0000
Message-ID: <20260604175507.3923-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604160112.159917-1-yeziwen1989@yeah.net>
References: <20260604160112.159917-1-yeziwen1989@yeah.net>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] execve05: add exit call when execve failed
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

Hi Yeguojin,

On Fri Jun 5 00:01:12 2026, Yeguojin wrote:
> execve05: add exit call when execve failed

The Signed-off-by: tag is missing. It is mandatory for all LTP patches.

Verdict: Needs revision

Pre-existing issues:

testcases/kernel/syscalls/execve/execve05.c: The doc comment has a
duplicate reference -- "execve(2) :manpage:`execve(2)`" -- which
renders as "execve(2) execve(2)" in the documentation. The plain text
"execve(2)" before the :manpage: directive should be removed.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
