Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE07C44501
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:50:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22CC43E574E
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 12:50:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29EDF3E78DD
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 12:50:13 +0200 (CEST)
Received: from mail-qk2-x03.google.com (mail-qk2-x03.google.com
 [IPv6:2607:f8b0:4864:34::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8C0C46005C3
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 12:50:13 +0200 (CEST)
Received: by mail-qk2-x03.google.com with SMTP id
 d75a77b69052e-51cafb11d1fso1469891cf.1
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 03:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784026212; x=1784631012; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tRXbAycAPFhVvPP5g1FaqcAzhnYsIlAKQUI1zcbejb4=;
 b=TSapei3lqBhaq8AVYIaQ7Tp0lvCQDVFqpNqOcbKVZezxgqxJRDxPwyPlzFEiOMpnZK
 9qBgYkBTyGa6v/CigUykvXUTs/MpfKrjyeKb2RzBGtJd/9Z+WYUuxvmTIq0GUkVTsJB/
 TBWe7BVPnQ46esOUCqH9MOM1hHV2CesZjCiol8PElb2ZuGVOKvi0aUZXVnenVrroBmTX
 zUgwuuCDo8fmeJvigJH1iE2Pu2u5eBMq1BoWIu/LRsX0q04qwy+we91xoLLseKJ5QFcp
 ovoy6FTcosh6NLNhpssOLKR5udhbvtLNvrUpkuA5m5zJDQuLdE8JSGEs989jXb20Z1J+
 /62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784026212; x=1784631012;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tRXbAycAPFhVvPP5g1FaqcAzhnYsIlAKQUI1zcbejb4=;
 b=i2kJPjLEfyqoVUekW+NSzF4CZYqup9GBpXAQM0VwCIi+FSlhiKvh7T9aCGF6qw8zFF
 PeewkbuTiSPyHAmEgkNaz3u5ZX/Chjm518i+1FI6qgUBpf+LT4y1O7yGgkJZsEJ5l6kh
 5HgkDVe0fVaX/fww7uzuw07PYcGoZhrEydeClPLi5nZQyNBp8f2E6nFXUnFafePGM2Im
 Adw6zr423WcfjRJDQ7wQSokAp/XFNVLXwEx4xllNYF2K3sRHwe0uv7O7Lvg208FRvoGU
 kCII3Jd5pYzuj0QrWUThwPAqIiwuhHFeT/sruG9NEoE6wgHMxgoZBiYEdfBJvZkbVnnM
 md6Q==
X-Gm-Message-State: AOJu0YwObMpvd65xB8Q8N9zcETY4irbjCwzf0CqcNsfz4tY5cNtqT58s
 AcO8J4Q7QgJWaelzuSGUylpzbyps8q3OytHOo2wtqJHwI4DH2sQl6ZZFEqB6UxE4v3w=
X-Gm-Gg: AfdE7cl/MQES+D2Saw3yHWj3BnFERvRguvUBL4MOAazH5gvjIaUWph2HfrHxaZTsOwe
 OQMI93PlhLJQkXD7lvSe2jynlHmy8socsnVahWpE6P3tTCdb4KaESzQFnnJTF3hBMvn2W1AkVDA
 7Xt+btJv3EBLfMjy52CHrfQoOqWTycoUrlI6+x37pHBNGKBthCoCKCrBLaz6xVhZIjejY9T0uGX
 n7wv25I2y7O6/hnOLZ5B5lQY5NYP95Yk+y4Sdb1nxm9/4haX8+17sXPG2+R2ewnUwbX5d/99tLC
 VtdcP7ooIzImilAdm5l+DJK3CJ7Dtgj5Yf6vIx7baMWel5zKPTROzjzbHXGpb3gpr0DSUQQT8QR
 95VYZVL/hH1XMcPs6NK+BaI0t6acADzaT5fFWUc9C0m4wvv3kOcJwmOqcZalmc3uTBId6XxvKsN
 8f5WRP88E2Xc1rFe+KAwEMx+R0YtBr5ooJHdxyqSi5eA+da6no8acJOp+OGgu/Dcpl3/+Fxlcry
 ABzI/ySbYgzCOTXmCQq9iYWfVNF
X-Received: by 2002:ac8:5a47:0:b0:51a:8c99:1f18 with SMTP id
 d75a77b69052e-51cbf281a2bmr119429091cf.71.1784026212309; 
 Tue, 14 Jul 2026 03:50:12 -0700 (PDT)
Received: from
 runnervm5mmn9.xdy23aex2gdehfi5fo3ofqo3dg.cx.internal.cloudapp.net
 ([145.132.99.23]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51caacaad78sm108071651cf.7.2026.07.14.03.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 03:50:12 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 14 Jul 2026 10:50:11 +0000
Message-ID: <20260714105011.4039-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714-syscall_invalid_nr-v1-1-d8b6f4e3ec7b@suse.com>
References: <20260714-syscall_invalid_nr-v1-1-d8b6f4e3ec7b@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] syscall02: test invalid syscall number -1
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

On Tue, 14 Jul 2026 11:25:40 +0200, Andrea Cervesato wrote:
> syscall02: test invalid syscall number -1

> +#include <unistd.h>
> +#include <sys/syscall.h>

<sys/syscall.h> provides SYS_* constants, but none are used here.
syscall() is declared by <unistd.h>. The include can be dropped.

> + * Verify that a raw :manpage:`syscall(2)` with the reserved system call
> + * number -1 fails with ENOSYS.

Same in the commit message body: -1 is not formally reserved by the
kernel ABI or POSIX. It is simply an out-of-range number that lands on
sys_ni_syscall. The test itself uses "invalid" in the message string,
which is the more accurate term. Worth aligning the description with
that wording.

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
