Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C78CD343B
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 14:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778079400; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=f5tBgTO07xH3ipTx74zsoK1HPUovPnD4Mqj362xKT+0=;
 b=pFoFPw2jarvIvI1VJOxjjkJ5ddXu2j6cVhRCusGeMNjOyJQ1yN+PPjIYEzrPy/9ZjM9Fg
 lQPPciyM9DZzYh47ONHDdszezfY8M2aSAe0+Ws4zO4/SqOGU462P/mNv7bVq5gx+7tXfvfL
 ktT2m3Po9N4ArN+Or9it0BKQgaYQ4Cg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C1C23E6167
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 16:56:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17AA83E2630
 for <ltp@lists.linux.it>; Wed,  6 May 2026 16:56:16 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 312851000A04
 for <ltp@lists.linux.it>; Wed,  6 May 2026 16:56:16 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso77364375e9.3
 for <ltp@lists.linux.it>; Wed, 06 May 2026 07:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778079375; x=1778684175; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=SEGaBJ1c0Razg6nzfiJ24CMsNRfBetRZN+GH6U0wQ+c=;
 b=dGdAWZDICyw2LC4Eti5x4hRafUzcZ6w3Zf1vtBR30jrf3+QlGvbMCB7MYnIAMW5yuL
 yBAVE2hE7ORPK4rawcSGbjWhWLWZrF9jQ3SWTU5aH2CaRJPw6jrf8FpwGTnRc1s0R/YE
 ul3wRx0ka35soLGJdMMx+AT9W6BfaRl15Mpqx3oOzj1F+hp1nHLsgRE0injfVbZwgtIi
 6hGnFj1zJ0PEHtJrX7Dq1Nt1XGX0UaFtN8q0Jm4jLgh4z+7hDt/FlrIt4EwuDepvOyJY
 ALIBpetuhzq4L4y9HhYM1Q7munlwAGXsq81LqiR2T2N74x9iG59DDtZh8hls/njZ2lQZ
 t1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778079375; x=1778684175;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SEGaBJ1c0Razg6nzfiJ24CMsNRfBetRZN+GH6U0wQ+c=;
 b=ILlEXlmJQhxjK7B7KDv02hb+7YAEMDvWPq+n6lxp46wq0rmDNCWmA914z7IubhmOhY
 nMx+l6v56UOUAl69Fy1po9RuRpC9FbU2OI+TT960xOpXznJRc0JxtF/IbXFR0XYiWs6u
 f21LvyF4bWnLPe3Qbz6g4QrtJ95uVx3iL1tPwaMGKzmBneZ7vXyszAkP9al/qSPCE9a7
 P1xPQ7bdplEUP62AWk4dLSct4rFizE7qzsg1k/gmf+w3YuQ2kXJ9bIZIbjnV20iXQigW
 jOhNLXBGHXki06LShIj6hGx8pvM+sVZvF0g/kp+rtZCU2WKutv8w0HFNYX52tHy85Uhq
 4GyQ==
X-Gm-Message-State: AOJu0Yygp7nGQE5YFbyLF2vC+wviBqpL0lDHl64siY7HtPTgjoV+nTOE
 c8zapde+w814LzcT+hIHgE4S3/7WiXr4Upn76fSn9V6LnEswnlgOVJYNK9kQwn+J+0A=
X-Gm-Gg: AeBDieuGB9sDJXUu8ryjK3gOd7eZpFCOvwDNkaGnDcI9x6P+cQ4Dauozv7HTezACzEf
 1DRVWJIF7RVbOdyjKXwAimkPPq/ajdSx0R2MPA/CB7Ui3B/EjgcDcD0Y1AmcJLVR5uf+qILGJQH
 KrLdvS21x1gohl9dGUK2ZKgdvoWEJhUrpK4WQgmCHVHZyp0DfpS0ET4PShTrDVsFunQowy686rp
 Qjla4+DZT+D+09L5MHrk2QfgzBwE1flq5FQwp2nt2W4t0BTz8JxXdVBOrvcbckOcMBlXmmWdR7B
 uYg7BRv30AArggLI42JDKj8Jkl9LqFvz47cmLPuSr/GcGm8TaZQ1YYkgrGCHNPZrnlCFqJDHQ6V
 RNHToNZJiahQLtY7nxEuCop/wioHQsTq0I3f5OIl5i8qzUor8FPLssMwfUUyd2xOsXR79/Rqakn
 3oNnUTtxQ2Sw95kEjPVI5a9BqVOv8KhAq64m1CXb9f+b4EzWpFC8M0/QkVDw32SKs6BjINdrTlo
 eVl+6i3/NA7ajz7fVrfHUTB/gCE2mp6LMC41xULS+6D2A==
X-Received: by 2002:a05:600c:3ba7:b0:48a:7772:c26b with SMTP id
 5b1f17b1804b1-48e51f40884mr69029005e9.26.1778079375452; 
 Wed, 06 May 2026 07:56:15 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51040b35527sm151395281cf.17.2026.05.06.07.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 07:56:14 -0700 (PDT)
Message-ID: <69fb568e.050a0220.245213.1fc0@mx.google.com>
To: Samir <samir@linux.ibm.com>
In-Reply-To: <20260412122842.1074017-1-samir@linux.ibm.com>
Date: Wed, 06 May 2026 14:56:11 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] cfs-scheduler: Fixed "make check" errors and
 warnings.
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
Cc: Samir <samir@linux.ibm.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Samir,

the AI agent didn't reply to your email at that time, but the
output is the following and I agree with that:

> Patch v1: https://lore.kernel.org/ltp/20260407062336.127454-1-samir@linux.ibm.com/
>
> Addressed review comments from patch v1 -> patch v2
> hackbench.c:
> - Drop SPDX-License-Identifier header addition.
> ...

Version changelog (v1->v2 notes, bullet lists, Patch vN links) must be
stripped before the final commit is applied. Move them to the cover
letter or drop them entirely.

[...]

> -/* This program is free software;  you can redistribute it and/or modify      */
> -/* it under the terms of the GNU General Public License as published by       */
> -/* the Free Software Foundation; either version 2 of the License, or          */
> -/* (at your option) any later version.                                        */

The GPL license prose was removed but no SPDX header was added. Add
// SPDX-License-Identifier: GPL-2.0-or-later as the first line to
replace the boilerplate; do not leave the file without a license.

[...]

The cfs_bandwidth01.c and hackbench.c changes address different scopes
(one line vs. 13 style items). Consider splitting into two commits.

Regards,
LTP AI Reviewer

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
