Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2EBC44507
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 11:02:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5AE53E5699
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 13:02:45 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F0673E1E71
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 13:02:26 +0200 (CEST)
Received: from mail-qk2-x01.google.com (mail-qk2-x01.google.com
 [IPv6:2607:f8b0:4864:34::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3CE982009D1
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 13:02:26 +0200 (CEST)
Received: by mail-qk2-x01.google.com with SMTP id
 d75a77b69052e-51c1ff471c1so18488851cf.0
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 04:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784113345; x=1784718145; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eA4PbzEhVZ1QYivs5Sk/YTf9WBmLhzwWCa9OL6CTmEw=;
 b=aTjaluMtLf8kuYnxRAqH6E2CUG6ACfblmK5oz1DZ10sPsP7TjneFIMfzWlMaym/jgT
 abTZZX/73hLycVB6YJLhcpMbe++XateXFNceh5Z7f7t1nZLU1aiU4XDn/B1oNXNmJAek
 xDrwerTpOwUbuXft/Q/t2mE8nSlmohIZPO4V4PbOL94J0s33B9GqJ5c+CSXgNfIxIgz2
 iIE/viMOnaaeM+KtUp0A8P9lsKvBJY8mJ9ha5+sh5ZBH31+HpLxE/1AFv48qFY4sGmpn
 LlEMqYfity4S8sXKen8a7lvDxLt1wBCdqniPJZKnQ5bEGLSU3H9HxuJyD1H+g7eo0Wrd
 x0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784113345; x=1784718145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eA4PbzEhVZ1QYivs5Sk/YTf9WBmLhzwWCa9OL6CTmEw=;
 b=RsT8ZXLpfDlALPJtdztR3Q0wyK1XNgxPjOjU1s4LAZcTYdQbUjD47JBV4kQi2EIn6d
 DSG1kIXNcc7Mfm2VW3P5AcuRlqhbluNjPURMCliL+62/TZTZlIyQ2NENMQVfEhOhnA/c
 Rv+vzjTJLQpiFF6k/+WobHNQYQ6MYol8oR86yJQRZazFOdMNCq2fi5sslXt+i5dA9X03
 j1t6mioThLuUqYCuPlwVbR999NZz4tTV+AWAfrtRCwgQN7Sl8wrsOZMnVv+oxLsLfQMU
 Xt/6OOW3oRAjLoL2gVV5faHAI6H2az96bK6AR1CpKk1R71Ku9iWT8J6RUhCDQ7cz3tz7
 RdKg==
X-Gm-Message-State: AOJu0Yy82mrqWR9cSoOyLq016WNxV/z0+3dUtdidIBnha7Be1ZfywECM
 GDoz1/+BDfhDzXnf/HFiL2X2qPrEuajeRJFfnB7XyXXJ1u0rl3VG0lPZ
X-Gm-Gg: AfdE7cmYOnMDiRc0zmHk9YbbSrxyrHI+pSpJ1utVpahYFwK2k/JXSJQnGk6wIh1cNJR
 9+88fi6goNO9ihXuKx1Jf+FwXb5/RjbgDtYVaMg83TMOAkfr1UmVGb4xXlqon0CmUtKS8Y2yiZV
 Xt8/daUTx5HRsGvWYUQEd1J5vpriJWsO8IFtVDWMjDX5qO8+7pTtnJYpXzsPgyTH8qmB/K7DXOs
 eApJoGlrGyxA2hSfo/ltyf5D7ZNdcS2Z+E4fB6CAQ62YAWvLLNMUau9Eh8P23qSsBM8j0f+pvp3
 5ntAfHYLgzPQ80k6b1NEBzCqLJKpd/MgaMrQR4GXalI3qdXiTG6EP4Z0H3okzkusvXE8sDpDHeV
 uge4tstUw9ywAGg98RxF0sIXULhAKbb6bLqOatPJYd2b9iFYjzphrcfaCJ/EmX/mzMmbnYRpQuh
 p+h6SkwpRT6K5NFz04rn3xqgjwdLmcCjwv3QL3qHjlC4cP4fXQDSJnWKhrIoB5BF5Uyv4uLDAIk
 cEu1vzKjiI//MtUfK9BKbydvo3Wk/o=
X-Received: by 2002:a05:622a:1c10:b0:50d:900e:c1c1 with SMTP id
 d75a77b69052e-51e4ede806fmr21697821cf.7.1784113344561; 
 Wed, 15 Jul 2026 04:02:24 -0700 (PDT)
Received: from
 runnervm3jd5f.ku0h0fkqowmutcnvcpup3qcs1f.ex.internal.cloudapp.net
 ([172.183.183.211]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caaf5f61csm135208931cf.22.2026.07.15.04.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 04:02:24 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Jul 2026 11:02:23 +0000
Message-ID: <20260715110223.4165-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260715094138.1679456-2-chrubis@suse.cz>
References: <20260715094138.1679456-2-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls: Add epoll_ctl07
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

On Wed, 15 Jul 2026 11:41:34 +0200, Cyril Hrubis wrote:
> syscalls: Add epoll_ctl07

--- [PATCH 1/5] ---

> The epoll_ctl05 excercies the loop detector with a longer chain this
> tests does the same but only with two epoll fds.

Two typos: "excercies" -> "exercises", "this tests" -> "this test".

--- [PATCH 2/5] ---

> That checks that subsequent calls to epoll() return all events if there
> were more events than than the size of the events array passed to epoll.

Duplicate word: "than than" -> "than".

--- [PATCH 3/5] ---

> This is another test for maxevents cap, but in this case we do not drain
> the fds so they are newer removed from the ready set.

Typo: "newer" -> "never".

--- [PATCH 4/5] ---

> + * This is the default (non-EPOLLEXCLUSIVE) behavior and serves as the
> + * contrast to the thundering-herd avoidance tested in epoll_wait16.

At the point this patch is applied, epoll_wait16 does not exist yet
(it is added in the next patch). The intermediate tree has a dangling
cross-reference. Consider adding this sentence with patch 5/5, or
rewording to not name the follow-up test explicitly.

--- [PATCH 5/5] ---

The commit subject says "syscalls/epoll_wait15: Add EPOLLEXCLUSIVE
test" but the diff adds epoll_wait16.c, registers epoll_wait16 in
runtest/syscalls, and adds epoll_wait16 to .gitignore. Should the
subject name epoll_wait16?

> +	if (nwoken != round+1) {
> +		tst_res(TFAIL,
> +			"event %d woke %d waiters in total, expected %d",
> +			round, nwoken, round);

The last argument is `round`, but the predicate checks `nwoken !=
round+1`, so the expected value is `round+1`. At round=0 the message
would print "expected 0" when the expected count is 1. Should the last
argument be `round+1`?

> +#include "lapi/epoll.h"

EPOLLEXCLUSIVE is used in this test but is not defined anywhere in
lapi/epoll.h (confirmed: the file defines EPOLL_CLOEXEC and epoll_pwait
fallbacks, but nothing for EPOLLEXCLUSIVE). EPOLLEXCLUSIVE was added to
glibc in 2.24; on older build environments the test will fail to
compile.

A fallback definition belongs in lapi/epoll.h:

  #ifndef EPOLLEXCLUSIVE
  #define EPOLLEXCLUSIVE (1u << 28)
  #endif

> +	if (round == NWAITERS)
> +		tst_res(TPASS, "each event woke exactly one waiter");
> +
> +	SAFE_CLOSE(fds[0]);
> +	SAFE_CLOSE(fds[1]);
> +}

run() forks NWAITERS children but never calls tst_reap_children().
Each child calls exit(0) after the checkpoint wake, so they are all
finished by the time the loop exits, but the parent leaves them as
zombies. The structurally identical epoll_wait15.c calls
tst_reap_children() after its equivalent loop. Should tst_reap_children()
be called here before or after the result is reported?

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
