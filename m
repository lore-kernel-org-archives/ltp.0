Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F01DE909AE
	for <ltp@archiver.kernel.org>; Tue, 17 Feb 2026 14:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771338228; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=nDlzrgH8Qcj0nFKIWc+Wsdwy/vQw3TqTWW1W+Ay2YkA=;
 b=V2HrZxfDuCvJjfb0IeQc/ULgA5cXQSjQ+9Nmq6MmP6hOg19oE4czWz2gng2Cl0jJWRgf8
 cmS3/K64D1HvEl4KdKuKX4JlEkgxVZQQ3ar2zj3l+W4853cJJGN3726CTaes8ScsoR2/URK
 VmN/COrFpY43K0YTIJWz437IaqgVEns=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0DD43D0635
	for <ltp@archiver.kernel.org>; Tue, 17 Feb 2026 15:23:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B70643C7BAA
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 15:23:25 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D17421000486
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 15:23:24 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48372efa020so31065545e9.2
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 06:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771338204; x=1771943004; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V5waIzCU1jGsvZGFBuQKk9z/OpIeCbp/K2hRISVnsDg=;
 b=B6BShKItRDcmacamv2C+XkRrHt9IXYi8kdTvJCROjt82GF17JnADMsQocqUdkSzcV4
 cl2cbS/Rw6Sj3yP5vqCVtlwV6vA1s/seU88s8+2ygwtm5KxsNLfcanU8MqE0Nk6WISyk
 Er4y6F3tujNn26iHKfJMViJjiA0vBOyqoUf4eplJX31/3CAgy6sm+QVnn2ivz30qTbi7
 4BshMiLn+sLEMdCrMJPgFqjhdEaNueXahJX7Dw/7VeN+DVy1TTuTd3/YSRCnA5vpqn3a
 j/0/Nq8zkNziN3AtDwjV1oJukVzYxoz2nPTfneeZiMsmwkBtbSCFGNVtoKsgvs8bbYrJ
 Lrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771338204; x=1771943004;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V5waIzCU1jGsvZGFBuQKk9z/OpIeCbp/K2hRISVnsDg=;
 b=YnSGfahlnoXjR/wXGz4jpJmM4Q/EJSSeyJraizbthSmuh3FYmm8/4Sp7HKV95fiMLh
 GYyl/5MGdSQ64Uem58XXNgGv/ucE7EUzcMDHNAqJAizncIYwAf9iMIQPGS4USRqR3DC8
 bercRT6ZuEjOgVcDUg18Sy//NnsC8BaePHOA3ZNzZe7lqTOZfaaAAAepJPqJop2IuFgv
 dJnM9uGHvt7HY5eKc/lz8LWeR76sBqjH3UljA7aDcpR4sH1nbPVfazlcFYyYAfsvH7wB
 67qyPrvrvdcdTDyX+GTY2o4o0WwOAlP6N9Sua9c36yWJ8Qo2i9uuS26H4MVadnrueDpd
 BQUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiFYaAUYBp4L1y66q6K0vGvqfXv19nVVKYsrIabAQ/z5aXXbF/jxo0H9vLFq4I5G62QJs=@lists.linux.it
X-Gm-Message-State: AOJu0YxBu7jQubELIsf6SVyfh4qlVd7mRKacXmUoilB2bxvUZm6FW6Wb
 D6ymCIIqhb5Nn/Us/Y4iVaWBQWMUkD/FNmEwR67C2TQxUPCcwLS3CeBRNdCCF6ztFkZ+GTvV+/0
 ToB7u+yw=
X-Gm-Gg: AZuq6aKatTR3Z9+jePAMNJa9jWEU6cdvXBKUql4citt7c3VMNSswD22fBNM9dRYIrtq
 Xn7mT0AR2+fcioFsXVOQfway3bYjLflhhhaWautvnxHG+sMMInPqeTUxHHEKjkU1oLYg+uab2Bv
 LMX047UgUYhgQHswPhNmdS7qY/ikk+jbN8R/rMifaUfWVZLTsmWetgHPHZs3KXHwreKdjKbtUs9
 Kt7osLPc725Nzvfvy3JbVRq/52qJZt1Nhzxs1uaGlT/dgGgcFKKNBU9A4XOTJuZSsO13EPTpx0p
 ugq069og5srKkgS3+F7OslFtbd+So7WnqVlYdPsvBDtoXpzF2YgXHiKwklgAe/l9cR6bDEoJYRi
 lT6tPht5EkMzQCDz+kIQ+oaPmGlobFgr3afXtjxfos6/SALvUXLUClzaNGm2IsCEd6lPlWJxWOa
 X5btDX6HO7YmfeGWaiJhhDdtKMFN6O2m1JPiIiMYsq37LazKfR7mdreCJFF1HnRR3lt4/niT1jF
 5DVU/Avtx++D5/m7UdaU+buC6K7Ow==
X-Received: by 2002:a05:600c:8608:b0:483:7783:537b with SMTP id
 5b1f17b1804b1-48379bfd7b7mr158805245e9.24.1771338204158; 
 Tue, 17 Feb 2026 06:23:24 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4836aa0847asm564810565e9.3.2026.02.17.06.23.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 06:23:23 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 17 Feb 2026 15:23:23 +0100
Message-Id: <DGHAZKT0BPBL.167V6DLGZOOF@suse.com>
To: "Samir Mulani" <samir@linux.ibm.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20250928034647.3539824-1-samir@linux.ibm.com>
In-Reply-To: <20250928034647.3539824-1-samir@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [PATCH v4] Migrating the
 libhugetlbfs/testcases/truncate_sigbus_versus_oom.c test
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Sun Sep 28, 2025 at 5:46 AM CEST, Samir Mulani wrote:
> In this test case, we are verifying the bug fix commit that is attached as
> a part of the test case structure,
>
> Some kernel have a bug in the positioning of the test against
         ^
	 typo: kernels

> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap37.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + */
> +
> +/*\
> + * [Description]

Description is not needed anymore.

> + *
> + * Some kernel have a bug in the positioning of the test against
            ^
	    typo: kernels

> + * i_size.  This bug means that attempting to instantiate a page
> + * beyond the end of a hugepage file can result in an OOM and SIGKILL
> + * instead of the correct SIGBUS.
> + */
> +
> +#include "hugetlb.h"
> +#include <setjmp.h>
> +#include <signal.h>
> +
> +#define MNTPOINT "hugetlbfs/"
> +static int fd = -1, fdx = -1;
> +
> +static unsigned long long hpage_size;
> +static unsigned long totpages;
> +struct sigaction sa;

Should be used inside the setup().

> +static sigjmp_buf sig_escape;
> +static volatile int test_pass;
> +static int sigbus_count;

Never used.


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
