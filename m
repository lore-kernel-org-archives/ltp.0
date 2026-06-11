Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D33E6CD8C9D
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 18:23:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E11CD3E1C0B
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 20:23:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 335123CE114
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 20:22:48 +0200 (CEST)
Received: from mail-dl1-x1241.google.com (mail-dl1-x1241.google.com
 [IPv6:2607:f8b0:4864:20::1241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A2FEB60070D
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 20:22:47 +0200 (CEST)
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-13832028e9fso118353c88.1
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 11:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781202166; x=1781806966; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G+1vMWU6+IdMaz1iz8vXWkBKZdf8E2zJCxuUMkXAA94=;
 b=F2bdZssZNPMq6aNvZ7xYYizLZfXPcigp3B98spF6wBnwuF87pV8CY8NyWjZ0AJgBeK
 9cO1hvrgHALrBWWVw2DzR93Q6DTmu42plljuwxYmKIXUk4UGnsFGaDOUmF00yeO/G6iZ
 gakPYbagVXVOBHfosGC/22IjzPPB5/JafZ9WCuL617cPJDXPEt/uCP8XiDaqY2dzduMQ
 5i8d+JeB79YPY350r0Cn29Uu72b2UgLQdLBvembpgQ26R6+co0lxNqzh0kzaTt8HYWgA
 B80Vv+lgxaMjcsS90Z6CoLllgvXZV6cxHj9eWhy/Eg71fabvCC9HYNgt/FzSgBbye0Mo
 t0Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781202166; x=1781806966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G+1vMWU6+IdMaz1iz8vXWkBKZdf8E2zJCxuUMkXAA94=;
 b=CpDaeoWuENTLAcNs+8zzhtIpofMGfykKKusnVlpJpgkH9OHGhiU/SEpAJ83Z0w19Iq
 Plt2uJwA0NfCZxor35yPNqzJOnzSHH1JkuKgsWa6zrr4d5q85PjOZtPr0Zp8HRoQuKCe
 Xmje/3L5aUIbuAMPKi+W1QMt+8Jwtk/75jr8fllY6vcGDLiDqlbN31AtF92Ci0uvJAE9
 h5AbUza76OYcebmp8DK8z/amKmrHZuv2f+ACYiEiQjpMCxV8VL9zrKOtUhfnpskPWTff
 VrsDdiIN7gNoevWe573jH7XztRrRbhs91AH8ZDdLbsSbswFdN6rercjv68eceS9zzDHX
 eMaw==
X-Gm-Message-State: AOJu0Yydi+crQbEZPlVpwt5V3N0cf0RAqZ+bGzMtfaT/28M6tCUJeZf8
 WE83Rc67L82qkFNg40QiFWg1cibbyjjsSJUjjomxZOar6JrwDwCuiEdPQbcZn0ho
X-Gm-Gg: Acq92OG+i3Vhsh7iRv4IaSSjC3Nzapn0JLJX1n0htrmSso4XQR2L3ZuFrJz/rW1/za3
 ockgQ94dVLVHx5nO9qeo6Y7AUIK8WN2yh+txMmL5DmRuFmpFPfHLHFE29Fuib5n+0nuy5a6/MMS
 r9LOwFF46cqgQJ852+SIfvyiYIRkpovrI0aX1C1ip91/UXnkAYB0izKC0nVunNEX17blRAxz3QF
 +68N91lEGS1C55uPvnxIIBI1lSCSBIkyPp7UQNNI7hY6aCLDXyN8jovD/1Eb4WoPPMX0XEfarbS
 5bdfCswzhjRnRU+0u8+J8InmXpWj+NcuF0z8OdlNbhu58TxaMgxPGCtWnlPrzXekE9pfX4rx1G8
 YIjw2a/S9JioITwU+JHhk+95d8vJ3QiO43dPeCeAjakfrpgboi/cjtGv4svNu+lQKYouyJOz92X
 13of29qakl/rpg0/fDJOkmsL45ky9DAktuFfXcgK6J2exoG37NeQTwMnL19L3/vhn/bcN7UxHRc
 RdMxFAvARnl4OqcXMym2gAvfMgBollIDnhY
X-Received: by 2002:a05:7022:7a0:b0:138:30b1:4bfc with SMTP id
 a92af1059eb24-138421355f7mr2474649c88.9.1781202165866; 
 Thu, 11 Jun 2026 11:22:45 -0700 (PDT)
Received: from
 runnervm1li68.g3hwm4zdrdxutl2hw05zhfo4lf.dx.internal.cloudapp.net
 ([13.83.162.3]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13842fa6ebbsm2581866c88.7.2026.06.11.11.22.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 11:22:45 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Thu, 11 Jun 2026 18:22:43 +0000
Message-ID: <20260611182244.4738-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611162932.756328-1-po-hsu.lin@canonical.com>
References: <20260611162932.756328-1-po-hsu.lin@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] pipe15: add min kver v4.4.281
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

Hi Po-Hsu,

On Fri, Jun 12, 2026, Po-Hsu Lin wrote:
> pipe15: add min kver v4.4.281

> This patch 46c4c9d1beb7 has been backported to stable v4.4 with
> commit 7392701d8615 on linux-4.4.y starting from tag v4.4.281 [1]

"This patch 46c4c9d1beb7" is ambiguous. In the context of a patch
submission, "this patch" reads as if it refers to the current LTP
patch. Something like "Upstream commit 46c4c9d1beb7 has been
backported..." would be clearer.

Also, the body describes the fact that a backport happened but does
not explain *why* adding min_kver to pipe15 is needed. What problem
does this solve? Does the test TBROK on older 4.4.x kernels because
/proc/sys/fs/pipe-user-pages-soft is missing? Or does it hang
because the fix is absent?

If the sysctl was never present on 4.4.x before 4.4.281, then the
min_kver is legitimate feature gating and the commit message should
say so. If the sysctl did exist but the hang fix was missing, then
skipping the test would mask the bug on those kernels, which
conflicts with the LTP policy of not working around kernel bugs.

Verdict: Needs revision

Pre-existing: the tags array at line 95 is missing the required
{} null terminator (see tst_test.h: "@tags: A {} terminated
array").

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
