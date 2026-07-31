Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979B6C55167
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 06:20:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 139E03E254E
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 08:20:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 313EB3E254E
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 08:20:25 +0200 (CEST)
Received: from mail-oi2-x02.google.com (mail-oi2-x02.google.com
 [IPv6:2607:f8b0:4864:32::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B2E0360086C
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 08:20:24 +0200 (CEST)
Received: by mail-oi2-x02.google.com with SMTP id
 5614622812f47-4a4492f5cd1so94073b6e.1
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 23:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785478823; x=1786083623; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Jve5CV/dSWXdqiDUuznPm6Z0kK0Q2T1iKTg6LSthh4=;
 b=iLuJEmtWGJzP2JLsqbgd5UO9uUyIx+hvznkMvE9C8Ezoy7ELVzeKQJ22Yh7pI+KxbV
 IQ3hQc5tmj5yfd7sl514+cSDsYVzArc2Zu0o+FMffOAoVq9KcteNWzbkO9p6q1y6pHTJ
 xTLEW+8JZuOdYLnKAOfoPqPxH758kmVxAkIPKX5BqK5KIucHOeSWJRM0ptnemiXRdsIQ
 LF0OxqSR2tcP2nWTU/q0TJIUpI9mzKbB9O48a54oUec7oAj0KByOV0ShKZA80RiPkZ1x
 XHY3Lk7FsfhCfm5pCRkSmGzBYzjMgM4sY02rRLeGgnjkvKHi2OYeAo9H9rgIkTDuwuGi
 61Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785478823; x=1786083623;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Jve5CV/dSWXdqiDUuznPm6Z0kK0Q2T1iKTg6LSthh4=;
 b=FwRt9ChNMtGZ7gAqtcjc2VVnCyQLtfGpyt5AJMiq7gDd9/FBeYHZAAZ9UeF8JKGmgI
 xdegJaRFu36bG1VFGWn+vMrQ9SRZVCxqTjc1HKMrCAFs+9yquEKOsZkmUM7d8LEDspwY
 WfEEsxQ0lOSvHSYPFP8MiNiWwjFM6foLPG1fnosaJ/3RM6VlXRa+XPmiSd2+xNNtMrcw
 /MoSSUFYixvQ1M2opo6puWd6S0yxSNDDaXBlE5rkhMi0ilZ004qAho3EiTgvA1h5FOMS
 IuOMcbRFkpg6wY9m/zAipDckmYnofH+euVn4dfJaZRGED9+F+MU6+dvUCF7zwwDNCjqt
 aj1Q==
X-Gm-Message-State: AOJu0Yw55/abrhlRk44PeLVn1CI2HtF2L9jMTVXnaJzKa7zyjdby7b80
 RGtAUIyvNeK74HGIbs/Lno4QrBiCE5FD1BYm3bgw0iKEMnOSGfTSAug9LKDi7siX/rw=
X-Gm-Gg: AR+sD10p+6uG3cB9BfhRt4YTfeY4PE6J0CrOUt/obo8VbEdyjgWbE1G2snzfEc8b7bT
 s+0gS3kmTrDJew6CqFNsP3O+N3PfPpu+0MSgao26X7rnq1OSqyrgbfsMoq6LCcCZjrrQS8nHGQ6
 sSWxhrome21DXS5ffGWazuvcxNHadPCIBrPgLYsXbg574pjOmmcUYZ6HTJ1WIhTdHLyWTTlngLP
 DgrDZS1dG5/QEs+r8ymnmwKlNpn++TtpywS+lW2xhB5IAn8mI0ouVd0KglTugW6vP6XJAeX2iyO
 tI9d36enAiZgRI7Zy1kQRYMLBLybJITFAc4mqPIitA5dNWwkrf8SkRKr2gqVCFBfhsREn9AMC4h
 JeIgBuOMQuU1ImUANPBrb6h4mvde9+eVK/TKMfJUEa0vZ5DEhuYXLzk6YQIfMbkvJkYc7PkcfaL
 +IHhYO8+DtVw1p1GvQInQkFngRTXg2UtzUJicw3XzW9JGJef/LxuKL4TekKlPiC1WI+FBpWmdH+
 wwP16iKBJMHZg36iks3VeSWtf1nogoL+OuRAf/KUj28IEN91htmW6/kyFvKnSWg8xztuDE3h3r3
X-Received: by 2002:a05:6808:179e:b0:497:d371:21c8 with SMTP id
 5614622812f47-4ae4c507a1amr657555b6e.19.1785478823267; 
 Thu, 30 Jul 2026 23:20:23 -0700 (PDT)
Received: from
 runnervmvrwv9.fjxtfgsjh5xezlzfbnqjfnxk1c.gx.internal.cloudapp.net
 ([20.221.68.242]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4ae318d6cfbsm412412b6e.16.2026.07.30.23.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 23:20:22 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Shaojie Sun <sunshaojie@kylinos.cn>
Date: Fri, 31 Jul 2026 06:20:21 +0000
Message-ID: <20260731062021.4129-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260731031343.1298712-2-sunshaojie@kylinos.cn>
References: <20260731031343.1298712-2-sunshaojie@kylinos.cn>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_cgroup: add cpu.stat and cpu.weight to cgroup file
 table
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

Hi Shaojie,

On 2026-07-31, Shaojie Sun wrote:
> tst_cgroup: add cpu.stat and cpu.weight to cgroup file table

--- [PATCH 2/3] ---

> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +top_srcdir		?= ../../../..

The build system convention is an SPDX line followed by a Copyright
line; the sibling controller Makefiles (memcg, cgroup) carry one. Could
a Copyright line be added here?

> +LDLIBS			+= -lpthread

This flag is applied directory-wide, but cgroup_cpu01.c does not include
cgroup_cpu_common.h and uses no pthreads. Would a per-target assignment
for the tests that actually need it be cleaner?

> +static struct tst_test test = {
> +	.cleanup = cleanup,
> +	.test_all = test_cpucg_subtree_control,
> +	.needs_cgroup_ver = TST_CG_V2,
> +	.needs_cgroup_ctrls = (const char *const []){ "cpu", NULL },
> +};

cgroup_cpu02..05 set .needs_root = 1, but this test does not, even
though it creates nested cgroups and writes cgroup.subtree_control. Is
the omission intentional?

> +/*
> + * Copyright (c) 2025 Richard Palethorpe <rpalethorpe@suse.com>
> + */

The other four test files and the shared header also credit the porting
author (2026). Should cgroup_cpu01.c carry the same attribution for
consistency?

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
