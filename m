Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1E3FF8868
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 14:43:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAFF93E2D6E
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 16:43:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E6283E1A46
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 16:43:03 +0200 (CEST)
Received: from mail-dy1-x1341.google.com (mail-dy1-x1341.google.com
 [IPv6:2607:f8b0:4864:20::1341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D1F0D200049
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 16:43:02 +0200 (CEST)
Received: by mail-dy1-x1341.google.com with SMTP id
 5a478bee46e88-2b4520f6b32so16554021eec.0
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 07:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777387381; x=1777992181; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1BkMryCuD7eVQ7/jRjnQsS0SmIwK5ZCUPHNY3GiT03I=;
 b=Tus0CVA9a9ZuiqMWXsGtVRhZayJyht4ts0fr3dTrwvHqIMH1BC98lUDpL+EQWe8eBS
 iZguaq7g9iOwhmho7v2PGY2BBYdDk/Dn6y9qcEDxkFXVX1O9ScfdFUpFTnaZhTqWKHHy
 /Ref58ZZlwoZs9XSY0eTKeLHPtsPHs6V1c+cnBprh2WbWHoTybFl53P1J42HluUGAsws
 J+pP/6tnO6fUApCh6Y3gAFibj0iYcS+8BUzjPRd9BSktmocBcnGfpU+5hYCo9SlGxJD5
 QdgmV1ctgClvRXu39UGyOmM4IyetnsLZQJSxLgbT0RbbkMB5oA8/Mzqn+ifUhjiuoAYL
 R48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777387381; x=1777992181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1BkMryCuD7eVQ7/jRjnQsS0SmIwK5ZCUPHNY3GiT03I=;
 b=SnEghNtGjcIw5aR5C0kJEg+n2VMX70t33nGKqaLmPgEp4A7BjVqLOGsExMCpLHWDSw
 lyLqMVKGJa1TlJ76g4jSOzxUeCEOwoR6kiJS30E+KfSWDH3Kqi5pV8EqJ6uEnoLfYLln
 QPYdM+0gJ0IPuqsUNPAtjTY5j3mpgThSzs+5EXwQmNpwIeQaPBIGi25gYzEEQUA6vPEq
 eT4XsrZxzpt16dtEBHHi12fCDw0cA1olPhKJCJt0KrBMBVn0LUX5NOUdpc38XS1SLYjW
 a5QzixackP70Jji7ReB/QhRoMjYfx667YZORAub8eYRB9mkny8HN799YD2n2MBTjTb9Q
 Q8Ag==
X-Gm-Message-State: AOJu0Ywdq9nQcvm9vJtkYUI6hJgW+tJILt40/rUeu1XXG0royEEK1Fi9
 O8U7/uvOk8UmVLx8JnZHcIBV9gpPADkS2b0H48IELHe/brMkeyC/vgBW
X-Gm-Gg: AeBDietV1D+9PNBMNKUKde9ab0sm3z5odYUIBTF52eiW662HzLU1XE25Yex7hxyRDo4
 XriNDZmsKeehaSxIAX5jm9d+iH4aabZNdUQmmB2sEyYoUNOvLI5kXptCfm8E7pTEctmJ0OftQiV
 7pvvsC7iB7zlg4CaXAtUpoh2JNhQwLjIqkgzxd0s5Ik2wUBS6WtDtXIe6gUSQCl31nStmzyngLv
 NudpQRl4KR8tX/h72bNyK88xmfvYQ/YK/Phi/PZaYurmXNn+MSzSgHDbJX/sUKCLAw2/y6QVCnM
 8iWKO0FPUFqWVEqFb1c0nlldsVBJQPVFmG1TxJfAsPFqDbV7qfUzDkRLngOoOi7/BDnFhZ7oSJL
 AbPxuxWaI8+ue5sVha1xYnfpVV5oSc8ToW4VF6lw28Ydpz4XKvOoJLrSfeoubNFp887BkfXXCfc
 0ajLgqDUqJnZIfU7uPOV0hsHU8uC2tfjRU41nVNZ5VxBsaB/msZ3Awc0Ze8TRrrNjXAB0M/KWne
 BAShHZoMdcXh8J5g0kHmZ2wyOE4pLhlaGuSCApxQOrYtUA7yHJS8rZHwaiceQ==
X-Received: by 2002:a05:7300:fd0d:b0:2ea:d965:a4b9 with SMTP id
 5a478bee46e88-2ed0a03466amr1708437eec.7.1777387380940; 
 Tue, 28 Apr 2026 07:43:00 -0700 (PDT)
Received: from
 runnervmhkfpo.qpvj1weuju0e1kbcccd5wfpkkd.yx.internal.cloudapp.net
 ([57.151.143.178]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed09dd953asm2365107eec.0.2026.04.28.07.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 07:43:00 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 28 Apr 2026 14:42:59 +0000
Message-ID: <20260428144259.3779-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260428-fix_clock_settime_helper-v2-1-26cce3b7d706@suse.com>
References: <20260428-fix_clock_settime_helper-v2-1-26cce3b7d706@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] clock_settime: use POSIX runtime detection for
 CLOCK_MONOTONIC
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

Hi Andrea,

On Tue, 28 Apr 2026 14:24:50 +0200, Andrea Cervesato wrote:
> clock_settime: use POSIX runtime detection for CLOCK_MONOTONIC

> +++ b/testcases/open_posix_testsuite/include/clock.h
> @@ -0,0 +1,23 @@
> +/*
> + * Copyright (c) 2026, Linux Test Project
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */

New Open POSIX testsuite headers should carry a "Created by: name <email>"
line and a brief description of the file's purpose in the copyright block,
consistent with the rest of the tree (e.g. helpers.h). Please add both.

[...]

---
Note:

Our agent completed the review of the patch. The full review can be found at:
https://patchwork.ozlabs.org/project/ltp/list/?series=501837

The agent can sometimes produce false positives although often its findings
are genuine. If you find issues with the review, please comment this email
or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
