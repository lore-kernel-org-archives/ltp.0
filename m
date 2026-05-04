Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A863CD3430
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 14:08:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F9AA3E6219
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 16:08:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 051703E49A2
 for <ltp@lists.linux.it>; Mon,  4 May 2026 16:07:44 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7123120004B
 for <ltp@lists.linux.it>; Mon,  4 May 2026 16:07:44 +0200 (CEST)
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-50faf8ed9c5so19954611cf.2
 for <ltp@lists.linux.it>; Mon, 04 May 2026 07:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777903663; x=1778508463; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FpZQ3SRS2s6OnI5Lm8V91in7drK53VW6GUmgSw+sKFc=;
 b=iOSbqTzKwcctj7fjHFjqi5mYflDRYCzncsPonWp2i7NhWNiWF8RV+tHXvC7Exd1Mbf
 MnP1jxVQp8mJHTYi/cAy2e8JNnfbYoKsWZXDKn9rwCpmC2dn8sgqQSNwFo+pk6qCCHbP
 F3cD+M7lqT0eeJz6QqDYWN7xBFSfsWly6VaDntdNZPNcAFD8i4p8L4FtY6pyGurAFC3p
 Fl+vgBd6t6L5KKvPZq4ew8d17nWI7Z9GPftF0Sh0Cixhe/J9RT0dpqVRdiLAnYY51p3R
 vHnCzhYbQw8SaG6lUXW3FmU6KqDpY80aSWfdNE1xCtyNJvLk0QPEMekwSIOqCnRVEhZE
 /6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777903663; x=1778508463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FpZQ3SRS2s6OnI5Lm8V91in7drK53VW6GUmgSw+sKFc=;
 b=Azemxgoqui3liITz9kDp1qbz91aHHPTrkPaWmtFbwZCCTP9sQGD40NbsS/vnn5ZU5H
 NqaHgnvfwmF5Np3+omo9g99HIYGOeCmlAl3Bq9pX4cq7O9oSQOkj4l6W/ShoHEDaRimy
 TcUYtGnzSeRKB2JWcp9w12oeOrH3UUhl8xgskxHtV4OUPuKkV+HB8GEZtTeJtMMoALpN
 lvKqlJqII1Y9xVCeYZDP6httqnIVaobpOFz7agK8V+eiNk1WrWcOuvEoCwoUmo0wJmry
 9e9N/m+y065nCtKqLfApa83zHUoPKQb+ScQ3irUUq5W44o7mwDZN3+Ntb9VoLGQjAOhs
 C/PQ==
X-Gm-Message-State: AOJu0YytI7F8IgoXVwnI68nmomc3EHOMYIWQvHeW40VoySBurMLiYHa7
 vPv/fLc5vuuRYPtQA6yaPZ9dPwZ16NsRpjkD7UqiPiheVPeOmWDrMQWV
X-Gm-Gg: AeBDietYVKXgPXh0iNUJdZhPm9/87/Zjm/kRYQ52R9n3fdMf64QWqeMWlKJei+KloEt
 QFJ4ghIWJ+8Afxjg/hBNENymvk88xRtiFnVrg5uvQFWE8UhMpXw/6QdjkgWHR0jN8B1jvE7s5uH
 JFmNp+fBlNINLb2kuxPZwWfqLdhzv+t9V8tmRXKhG+ir81q05VUK+EQq2d61fCoHRh36RxsA+sA
 znPdpoVdhSuYxtmMaf8dbsex4QKFYF14OMs5jormsDddAm/PeOUVGGCG1gCesWgqNgdzFMdlVBc
 IJJo+MSY5wMAL2tg8105PJCGqRA+AHJck1HUOS3hzRj13P6GqEHPCX+/dqOXsAHSQhxk6cZEynm
 cZT0T3S3SYM1KUoR5Xm69jxhgjV9cxuKKY0oRMxp+qWtITYRbyjkXLqEvWuVHXoFV+um1go9Jp2
 0Ng+LnsKQmsCT13JTfEWxzbwwLyrT8jkpQ0bH2PiZlObOgNhqZaeSNnGvPZZSqarTbj2X0iCZ5v
 vgs17gRnd7Lg6qaG4kD68YnMqMD76i1qwAFGsnxlBhu7/ni0zQ=
X-Received: by 2002:ac8:7dce:0:b0:50f:c2d5:3154 with SMTP id
 d75a77b69052e-5104bffd209mr141381321cf.42.1777903663065; 
 Mon, 04 May 2026 07:07:43 -0700 (PDT)
Received: from
 runnervmeorf1.nvcrsk4lb03ebagxjwngdrxj4g.ex.internal.cloudapp.net
 ([64.236.140.215]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51040b33248sm97836111cf.18.2026.05.04.07.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 07:07:42 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Samir <samir@linux.ibm.com>
Date: Mon,  4 May 2026 14:07:41 +0000
Message-ID: <20260504140741.4042-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504132405.333588-1-samir@linux.ibm.com>
References: <20260504132405.333588-1-samir@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Migrating the
 libhugetlbfs/testcases/alloc-instantiate-race.c test
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

Hi Samir,

On 2026-05-04, Samir <samir@linux.ibm.com> wrote:
> Migrating the libhugetlbfs/testcases/alloc-instantiate-race.c test

> Signed-off-by: Samir <samir@linux.ibm.com>
> v3: https://lore.kernel.org/all/20250928030721.3537869-1-samir@linux.ibm.com/
> v4: https://lore.kernel.org/ltp/20260317095559.5766-1-samir@linux.ibm.com/
>
> LTP Github CI link: https://github.com/linux-test-project/ltp/pull/1313
> All the checks are passed

Version history references should use the `Link:` tag:

  Link: https://lore.kernel.org/ltp/20260317095559.5766-1-samir@linux.ibm.com/

The `LTP Github CI link:` line and `All the checks are passed` are
free text appearing after `Signed-off-by:` and must be removed.

[...]

> +/*
> + * Copyright (C) 2005-2006 IBM Corporation
> + * Author: David Gibson & Adam Litke
> + */

New file must include the year it was added. Add 2026 to the copyright
range.

> +/*
> + * This test is designed to detect a kernel allocation race introduced

The doc block must open with `/*\` (not `/*`) for LTP's RST toolchain.

[...]

> +#include "tst_safe_pthread.h"
> +#include "hugetlb.h"

Add `#include "tst_test.h"` explicitly, as done in the rest of this
directory.

[...]

> +static int child1, child2, race_type, fd_sync;

`fd_sync` zero-initializes to 0 (stdin). `cleanup()` checks
`if (fd_sync >= 0)` and would close stdin if called before `run_test()`.
Also, after `run_test()` calls `SAFE_CLOSE(fd_sync)` without resetting
it to -1, `cleanup()` double-closes the same fd on the normal exit path.
Initialize `fd_sync = -1` and reset it to -1 after each close.

[...]

Pre-existing issues noticed in the surrounding code (not introduced
by this patch):

- run_test(): local `p_sync` (MMAP) is not reachable from cleanup(); leaks if tst_brk() fires inside run_race().
- run_race(): local `fd` and `p` are not reachable from cleanup(); same concern.

---
Note:

Our agent completed the review of the patch. The agent can sometimes
produce false positives although often its findings are genuine. If
you find issues with the review, please comment this email or ignore
the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
