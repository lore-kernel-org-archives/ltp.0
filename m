Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E32CC43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 10:44:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 132E73E28CF
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 12:44:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AA853E28CF
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 12:44:07 +0200 (CEST)
Received: from mail-pj2-x00.google.com (mail-pj2-x00.google.com
 [IPv6:2607:f8b0:4864:39::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9D083200770
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 12:44:06 +0200 (CEST)
Received: by mail-pj2-x00.google.com with SMTP id
 d9443c01a7336-2cc6207127aso9544505ad.1
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 03:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783593845; x=1784198645; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UDIOCklhspzc++tviDvPT+g/C6QQ4oaAuTUSZaHu97s=;
 b=DSNqZgoaUXBNnUa+jK2oBd4i32YFyf2Wjvb91IsCFGwmhoQwT/hZ4H5NpHIn4aVTYP
 uuHes30DeGQTzeuBbL7G043HMxkVHNMD25vIDKPfDCHEAX131LBhx9/FxEtrc8F8Le16
 JlXTVG7Pvb83YE6X/FwSOtXF0tHdeKUXUXisKkmietezJoTeZjFHIl5ZJTU5W17ICeix
 4yGDqgw8FvxUA95sNdrWDxivO9+bjB/y66lGL50TULf4XRajkLRGsU1pe6x/ZHnt+IS9
 x737gWrZYvOfyXnIYvyyidS7gykv+uyYQ5RB246SczitGmjY1AZk7vpoD38Q8OOSHfez
 x2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783593845; x=1784198645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UDIOCklhspzc++tviDvPT+g/C6QQ4oaAuTUSZaHu97s=;
 b=VFCLeoEaBgamOn3PwFEUHo191Ryh3EGshn45rZeqZ2sQ7OCfdLE2GbKoGh3rtORObU
 SKRn6GxU/BYCWS0SSbfEkNFapnwmJvcK90NY4/77R/K3a7f0RBjIoO5f667hkcbVdGkQ
 PqsXzCQ2As/6bFnxKGKFLfW24sRqSGhOSDBq+rjzwXl55DWN2uyed44LmOmIx+aVtX8O
 Sa/GMnz2vTQAt/6sZiOigFp1swgzKuoFKYjE5VfJpPJtgXlGjB/OqANqWGfRskESIl9Y
 8oeteQEsPtqDIJoSxrycVETWvW4GHTHcwa588Tz17nwbNQByRY4QARySG8sh8F1rPeWu
 Ht6Q==
X-Gm-Message-State: AOJu0YwinB40uTo7rKjAx3xHLsCJm8rx61ec1p90avZmKbBdGgbM71vF
 wN4f9ycEcbNFm4b4gre4qyojoea66FgXYTC+PC/BOinPnOa5c/KCZyr4
X-Gm-Gg: AfdE7ckBgSX4dwDFkDeqxUThLkczg2HUQ1XyzZELrQx51Lom8TO7Hk8daoDPZTDvYnC
 NYRlJ0e4BmMgJOEgNfpaMbQd5Mbd1vLQQAJbyeAIji0aRm6Q9hKaOkUKpvhOXZseiwXyXEptM5r
 Od6lU5ZrtqhnuVdWdKZYPxwAV+C7ChHib8KhwQxnlWayMgnWScG4swAsS40RxmVAG+qP0B04PIO
 /IuT+7BLUJorxFaImSmwY5obDwN7blHlpIsTkO2lh5FqS5O/dxwnKnKggj/iQjsV7ajxlFnrwhP
 G92kLMFMl7nJOw+FXccqB1jg1t3QtqvwEL8N5ZXEo7WPrxi1jbytDmxIbk8FXZDlB7QGQPvqvwk
 YptSaG7dxB9rgk2IDwZ4V6/6hIHOiG4Yjd99pmTiodWzKQV/IIEm+Ztd69sL5No1AmoBkt40xCB
 5zWUPS2UPDZdTs9Hb7VGuu+HwLsKCUHdGYyu6Cp70SzcTrCMDSwnHYC4rdpsHw7Kr3Sph+h1Enk
 kMxt6OkJ2z5WvKkyoAjUeE62XDRaQGFOO4faiY=
X-Received: by 2002:a05:6a21:1493:b0:3b7:d8d5:2326 with SMTP id
 adf61e73a8af0-3c0bcf49541mr8090432637.1.1783593844908; 
 Thu, 09 Jul 2026 03:44:04 -0700 (PDT)
Received: from
 runnervm5mmn9.mhuo5aufw0zudj5rd413yb3ebd.dx.internal.cloudapp.net
 ([68.220.61.178]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c865asm31535208c88.11.2026.07.09.03.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 03:44:04 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu,  9 Jul 2026 10:44:03 +0000
Message-ID: <20260709104403.4345-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709085353.345957-2-chrubis@suse.cz>
References: <20260709085353.345957-2-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscalls: Add epoll_create03
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

On Thu, 09 Jul 2026 10:53:45 +0200, Cyril Hrubis wrote:
> syscalls: Add epoll_create03

--- [PATCH 1/9] ---

> /*\
>  * Verify that :manpage:epoll_create() fails with EMFILE when the per-process
>  * limit on the number of open file descriptors has been reached.
>  */

The :manpage: role is missing backticks and the section number. Should
be :manpage:`epoll_create(2)`.

--- [PATCH 2/9] ---

> /*\
>  * Verify that :manpage:epoll_wait() fails with EINTR when a signal arrives
>  * while waiting for events.
>  *
>  * [Algorithm]
>  *
>  * - Create an epoll instance
>  * - Fork a child that waits in the :manpage:epoll_wait(), parents sends
>  *   SIGUSR1 to interrupt it.
>  * - Verify that :manpage:epoll_wait() returns -1 with errno set to EINTR.
>  */

Three occurrences of :manpage:epoll_wait() are missing backticks and
the section number. Each should be :manpage:`epoll_wait(2)`.

"parents sends" should be "parent sends".

> 	TST_EXP_FAIL(epoll_wait(efd, &ev, 1, -1), EINTR,
> 		     "epoll_wait() interrupted by signal");

TST_EXP_FAIL is for syscalls that return 0 on success. epoll_wait()
returns a non-negative event count on success, so TST_EXP_FAIL2 is
the appropriate macro here.

In this particular setup it makes no practical difference (no fds
registered, infinite timeout), but using the wrong variant produces a
misleading error message if the expectation is ever violated.

--- [PATCH 3/9] ---

> /*\
>  * Verify that :manpage:epoll_wait() works with nested epoll instances up to
>  * the maximum nesting depth of 5 allowed by the kernel (EP_MAX_NESTS).
>  *
>  * [Algorithm]
>  *
>  * ...
>  * - Call :manpage:epoll_wait() on the outermost epoll instance and verify it

Two occurrences of :manpage:epoll_wait() are missing backticks and the
section number. Should be :manpage:`epoll_wait(2)`.

--- [PATCH 4/9] ---

> /*\
>  * Verify :manpage:epoll_ctl() EPOLL_CTL_ADD behavior across all file
>  * descriptor types.

The :manpage: role is missing backticks and the section number. Should
be :manpage:`epoll_ctl(2)`.

--- [PATCH 5/9] ---

> /*\
>  * Verify that :manpage:epoll_wait() with EPOLLPRI detects changes to
>  * /proc/mounts.

The :manpage: role is missing backticks and the section number. Should
be :manpage:`epoll_wait(2)`.

--- [PATCH 6/9] ---

> /*\
>  * Verify that :manpage:epoll_wait() reports EPOLLHUP when the write end of a
>  * pipe is closed while a child process is blocked in epoll_wait.
>  *
>  * [Algorithm]
>  *
>  * ...
>  * - The child's :manpage:epoll_wait() should return with EPOLLHUP.

Two occurrences of :manpage:epoll_wait() are missing backticks and the
section number. Should be :manpage:`epoll_wait(2)`.

--- [PATCH 7/9] ---

> 	rval = poll(fds, nfds, timeout);
> 	if (rval == -1) {
> 		tst_brk_(file, lineno, TBROK | TERRNO,
> 			"poll(%p, %li, %i) failed", fds, (long)nfds, timeout);
> 	} else if (rval < -1) {
> 		tst_brk_(file, lineno, TBROK | TERRNO,
> 			"Invalid poll(%p, %li, %i) return value %i",
> 			fds, (long)nfds, timeout, rval);
> 	}

poll() returns -1 on error or >= 0 on success; it cannot return a
value less than -1. The else-if branch is dead code.

The nearby safe_statvfs() uses "else if (rval)" to catch unexpected
non-zero returns for a function that is 0 on success. poll() returns
0 (timeout) and positive values (events ready) as normal outcomes, so
no such secondary check applies here. The body should just have the
rval == -1 guard and return rval.

> int safe_poll(const char *const file, const int lineno, struct pollfd *fds,
> 		nfds_t nfds, int timeout);
> #define SAFE_POLL(fds, nfds, timeout) \
> 	safe_poll(__FILE__, __LINE__, (fds), (nfds), (timeout))

New public functions in include/ must be documented with kernel-doc
syntax. A /** ... */ block covering the parameters and return value
is required.

--- [PATCH 8/9] ---

> /*\
>  * Verify that :manpage:epoll_wait() reports EPOLLERR when the read end of a
>  * pipe is closed while a child process is blocked in epoll_wait on the write
>  * end.
>  *
>  * [Algorithm]
>  *
>  * ...
>  * - The child's :manpage:epoll_wait() should return with EPOLLERR set.

Two occurrences of :manpage:epoll_wait() are missing backticks and the
section number. Should be :manpage:`epoll_wait(2)`.

--- [PATCH 9/9] ---

> Now that the epoll coverate is greater than it ever was we can remove

"coverate" should be "coverage".

> Fixes: https://github.com/linux-test-project/ltp/issues/860

The Fixes: tag must reference a commit hash in the local git history,
not a URL. For a GitHub issue reference use Closes: instead.

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
