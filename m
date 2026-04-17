Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D202BF43687
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 09:22:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8096A3E2954
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 11:22:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C21003E196A
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 11:22:34 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4A50D600B2A
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 11:22:34 +0200 (CEST)
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-8d736211595so26396785a.0
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 02:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776417753; x=1777022553; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+kdh3Aoe2KpCdgqS1hEvIZL4ezHXrDrxrs8aIh/gxNk=;
 b=PFCCi8n0tSs3doPEoUcnQsZF5/nZmXrp7asSeUtIeEkLVq5E89HlhEV/uOQWS92ZHZ
 pAwn/D1OkEjWfKAZck4vXVfiZrk03qR6pg2BW0J6vuttx+Z1UDoJfppG/giONhhpwBQr
 HRRB6t7f9+xhRIjL2FacVyBoXQ+POSqrawJ1AhjZ2DtSNVRtNb/wm7aksXpCOvDZ9vaT
 mmOhcA8c1b7yBgderiYbYPLEAMwhMl/RoAZHa5zflUx6NA8KvQpDH37YwdQy6PYWOOtn
 3IUWuB0Hkg67dwF/g9bHYMVbSYCNwc7OUoJu+T0jyqQvik+im0roiCRhkxEqtzzCZdLt
 qIbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776417753; x=1777022553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+kdh3Aoe2KpCdgqS1hEvIZL4ezHXrDrxrs8aIh/gxNk=;
 b=o7UlDXLQjHX1jEcYuNvwKJjPb1phWQPnDYfLn35iXsNITkyacg4xugSRElzWmXHbdS
 ma3Ot7pp8tSNodndQtR03ObE28Wlxeh9AEi50oATw27glKsY+yVn2V6bq3XkYMuPlgfT
 5d/JwwzH3vizxlX2/JlNt6k7l4KFBpdtvownGHXx7OEixa7/XVljr975k2p8UXh3i1MY
 bzNSHUUmMxYjAHzPlJQtev2BtswnqkAUYXL1J0uhwNI1/jt5Z1xITcM+VfFGRiOymJdb
 QVLz7ImklycM/srobLe1NgkQx5CD31XCn0qB1qbqEQy4IVnOV+PUjHN0oMQHp2vDhFbY
 EFag==
X-Gm-Message-State: AOJu0YxmkicirtNQIZDfyEmwSbcgQ5ZqV5zAphqqDmP6Ald66U3icItZ
 vuqapcBJIbwm+Ko/nW4ZQCkdUjtiO5sBGWMW0uJfOydMn0mMLA8U+H2z
X-Gm-Gg: AeBDiev1iBWEZf44LqS8NwISx/aoRi1UngasmSkOo0b4V/mbm7joCjyuQVcY9EqhPiK
 LP5KX/FN3/4WZzQMA2oZZqBOlMYJrZOI5S5+yTLtzbh0dupKocCF3nS/AYNvBOebNB2KwjjEHHg
 UFiALR32nHFbyDlq28D6XPRKg9Q2EHgKkQ5JlOwsMFmYJ/5j2a5MBATeKc27oSW/uBR0mxqb8dr
 R5SMX3PgW0jVl4bNTcLhpdg5mTbCTzolz3vv7gGbguK41tKnoIKrsPG1RHggoUKHK6zdWLsMc7E
 Hcj+Qmh9kigOPCA3b99kFUPXunNTaH4IU9SDtRo78TmyICa5Zr7j2wcSt+3wzGXokLXfHy1TVGF
 MAOm6wtxuw/Xrg+10G/3PBIXsEVobc+rIpFvqsjJdSpgBtNBL1zojQHQHFP25zpfxfIre0nE7Yy
 6csZULp/aF/vSFbjBAmsRnPtHcybnGP+Zo6pB4xNG0v4C5m/HtpQKjYL/vNdS1VMBrEHyxz0x4R
 hKqJkP80OrOdXMFI4pnXefEdEcet5yOLXZZnSdBy69o18c+fV0=
X-Received: by 2002:a05:620a:4613:b0:8d7:cf69:3c00 with SMTP id
 af79cd13be357-8e791b8d505mr235008285a.39.1776417753086; 
 Fri, 17 Apr 2026 02:22:33 -0700 (PDT)
Received: from
 runnervm35a4x.2nwclih42vyuji5rolimwxmlmg.ex.internal.cloudapp.net
 ([64.236.169.132]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d69ad49dsm82529385a.18.2026.04.17.02.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 02:22:32 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Cermak <mcermak@redhat.com>
Date: Fri, 17 Apr 2026 09:22:31 +0000
Message-ID: <20260417092231.3781-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417082920.1101928-1-mcermak@redhat.com>
References: <20260417082920.1101928-1-mcermak@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Fix Valgrind warnings in ioctl_pidfd02
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

Hi Martin,

On Fri, 17 Apr 2026, Martin Cermak wrote:
> Fix Valgrind warnings in ioctl_pidfd02

The subject names ioctl_pidfd02, but the only changed file is
lib/tst_clone.c. Use the component prefix instead:

  lib/tst_clone: Fix clone() parent_tid argument when CLONE_PIDFD is used

> This patch also sets ARG4 and ARG5.

No Fixes: tag. Please add one in the trailer pointing to the commit that
introduced the 2-argument clone() fallback in tst_clone.c.

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
