Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA9F10A1E7D
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 11:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774524281; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=+td6IsoirjYLxwuz/nPO9CqosI4hc/D62FT1k/aasCE=;
 b=dLwnln1I0lASY9ZEZco0UPYDXiS8NEebRN4BzTOCffKpzg5h9vIh3P+wmn6dnYYFuDt2N
 KwaOECKISGdgP5+RRvJKL0fL6NTjgnnXkJfwgtWXVscBAlPhyf4YzCZas9fzCswQMjCk5N0
 P7kFNZe03Bz0H/qnRvGCFByFiWp/jm4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82D533C6CC7
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 12:24:41 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1BE83C6AC2
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 12:24:17 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F2C271000A41
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 12:24:14 +0100 (CET)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-439b6d9c981so501332f8f.1
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 04:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774524254; x=1775129054; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=bTSB7vQApA+RXwfD/DN1hPG5cW7xYlKPm2+sbZKYnjI=;
 b=QLA8CZXihzOSOBWf5arNzTFMBbTGf6PVwVUZkokclnaCV5bC8XJDAyD/CbtJPQTsjs
 ld5ojliogkBSQ9IuYoKrN82Xk9VZjWKToDiyCHvPeoPz2s8Pb4KEwf1xJTe2GPiS3rh1
 kJfKFRM8wgVly3baq+SCmUs6XYLkiETmrTGvbbvV8EdFja/ENnGeAjUNN5ZChFrNEZ7X
 n1emqAkY7eLAG6PUOcdEPrlxr3R2INUmouMMT7i1rblHwbYkIXoMIY1vjI9vsuGMWJO4
 8K90OFcaaCin+Try5uGGJyVJCo2lW/fA6ITGs6mtVTfXLmdFbozt80vZt34vUjY8nTCG
 ZWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774524254; x=1775129054;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bTSB7vQApA+RXwfD/DN1hPG5cW7xYlKPm2+sbZKYnjI=;
 b=Ym5HUNow2te0hXSWz5/xXt7aqoyrQKAGCik9IY8BXzgzDSUVJH6OWRh4ImO48E7Iaw
 LX6bLJmS0giO+FOVzdN1nFPxSyTThDsb9+eunc/8x47/spxkgWjTMzMdkt2KaWoR+6me
 LuGvPMJF5gkB1RvxWngBrgw7t7lbipYBs49W7onarxw1d4arHCifWin3XT80Z9NlbpTl
 6LXy06nNKuaiZy3R8HkttrZMAurjlrUYuSm8ryHGu3n7feKVmUamsz+87G1EC9ApJbk0
 m9Q5j/rLfKX5eFzU+QWT6oZM6diogkdUZNRmoHjdpeP4ftG3zniS/afkpBOqKfJNUDS0
 obvw==
X-Gm-Message-State: AOJu0YxXZ8TdAbGJf3Ggn84UC1nY0H421iSdMnoq5Ce04NjoIgFFSxwa
 YyNz8+q1lb1DQDZ9ZVKvy+QBoIBLctS6eLkeQijQNIeEx5Wgtkrkh88DY1djJajIWMkMGAdazFz
 w983uk0yhLg==
X-Gm-Gg: ATEYQzyqQlm/dqqHDVB2v6Q4gncO6NEWoWKfwOXNtavluIkG5ZMjAWzP4c9oIF5XZZm
 9WDQ2Mq0FTBqS3AbQnaacMnsRZqe9hyWW0RpvkfKZLm7Vci0LpRz4nCn2wRi6NQw1ngZZIKk2IR
 Lrf5vIFnq+aTKu1a190eMu6oL+fCo3GUwrk4xRDGwjcwTXfSsC25qyq6LFFxHo5z27O5kSQbQSd
 +qOgLBWjXFNILo2qODNHGMsCzszNd53Jxj11AXHm2emg+RuP7qRSuY5LsdnXU7gPUx6aeUCDk2M
 U7eSk/8wvawOxijZYFVl6gKxSic+3i+YZJ1W46t2PzIOwQ1Zzrt5b9wZxG0S1NBylAhtLiQ4ZK7
 qNnHg2tO3+ETFHQ+7vnF2wNONKxYYyRHyKxno8VLeZqd3BjfXPw0m07pVKjwQy5UKmtecECBI8D
 V5Vqes4lzJHmhIEN8Yj6bkGuBwbACcyR4AIjzpPQFZ
X-Received: by 2002:a05:6000:240d:b0:439:ccd7:cdcc with SMTP id
 ffacd0b85a97d-43b97a4b7a7mr2191639f8f.18.1774524254209; 
 Thu, 26 Mar 2026 04:24:14 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.27])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2d3sm7226500f8f.19.2026.03.26.04.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 04:24:13 -0700 (PDT)
Message-ID: <69c5175d.df0a0220.190c3f.bcd5@mx.google.com>
To: Pavithra <pavrampu@linux.ibm.com>
In-Reply-To: <20260310112044.123827-1-pavrampu@linux.ibm.com>
Date: Thu, 26 Mar 2026 11:24:13 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [PATCH] [PATCH v5] Hugetlb: Migrating
 libhugetlbfs test truncate_reserve_wraparound.c
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
Cc: pavrampu@linux.ibm.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Here a deeper analysis on the patch:

> Changes in v5:
> - removed unused parameters from sigbus_handler call
> - Added check for after_mmap_rsvd == initial_rsvd + 1
> - Used TST_EXP_EQ_LU for comparsion

This should stay away from the commit message. And commit message should have
a meaningful explaination of the test or what was done by the patch.

> 
> Signed-off-by: Pavithra <pavrampu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap35.c  | 125 ++++++++++++++++++
>  3 files changed, 127 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap35.c
> 
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 0896d3c94..8ee0e6f82 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -36,6 +36,7 @@ hugemmap30 hugemmap30
>  hugemmap31 hugemmap31
>  hugemmap32 hugemmap32
>  hugemmap34 hugemmap34
> +hugemmap35 hugemmap35
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index b4455de51..0e59035df 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -36,6 +36,7 @@
>  /hugetlb/hugemmap/hugemmap31
>  /hugetlb/hugemmap/hugemmap32
>  /hugetlb/hugemmap/hugemmap34
> +/hugetlb/hugemmap/hugemmap35
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap35.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap35.c
> new file mode 100644
> index 000000000..dc678661e
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap35.c
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + */
> +
> +/*\
> + * [Description]

This is deprecated. Pleae use /*\

> + *
> + * Origin: https://github.com/libhugetlbfs/libhugetlbfs/blob/master/tests/truncate_reserve_wraparound.c
> + *
> + * At one stage, improper handling of tests against i_size could mess
> + * up accounting of reserved hugepages on certain truncate
> + * operations.

Can we write the description a bit better? At the moment is a bit generic.

> + *
> + */
> +
> +#include <signal.h>
> +#include <setjmp.h>
> +#include "hugetlb.h"
> +
> +#define MNTPOINT "hugetlbfs/"
> +
> +static long hpage_size;
> +static int fd = -1;
> +
> +static sigjmp_buf sig_escape;
> +
> +static void sigbus_handler(int signum LTP_ATTRIBUTE_UNUSED)
> +{
> +	siglongjmp(sig_escape, 17);
> +}
> +
> +static void run_test(void)
> +{
> +
> +	static int sigbus_count;

Is it needed to be static? We just need `int sigbus_count = 0`.

> +	unsigned long initial_rsvd, after_map_rsvd, after_touch_rsvd;
> +	unsigned long after_trunc_rsvd, after_unmap_rsvd, after_sigbus_rsvd;
> +	volatile unsigned int *q;
> +	void *p;
> +
> +	sigbus_count = 0;

And this goes away.

> +
> +	initial_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +	tst_res(TINFO, "Reserve count before map: %lu", initial_rsvd);
> +
> +	p = SAFE_MMAP(NULL, hpage_size, PROT_READ|PROT_WRITE, MAP_SHARED,
> +			fd, 0);
> +	q = p;
> +
> +	after_map_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +
> +	TST_EXP_EQ_LU(initial_rsvd + 1, after_map_rsvd);
> +	if (!TST_PASS)
> +		goto windup;
> +
> +	*q = 0;
> +	after_touch_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +
> +	TST_EXP_EQ_LU(initial_rsvd, after_touch_rsvd);
> +	if (!TST_PASS)
> +		goto windup;
> +
> +	SAFE_FTRUNCATE(fd, 0);
> +	after_trunc_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +
> +	TST_EXP_EQ_LU(initial_rsvd, after_trunc_rsvd);
> +	if (!TST_PASS)
> +		goto windup;
> +
> +	if (sigsetjmp(sig_escape, 1) == 0)
> +		*q; /* Fault, triggering a SIGBUS */
> +	else
> +		sigbus_count++;
> +
> +	if (sigbus_count != 1) {
> +		tst_res(TFAIL, "Didn't SIGBUS after truncate");
> +		goto windup;
> +	}
> +
> +	after_sigbus_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +
> +	TST_EXP_EQ_LU(initial_rsvd, after_sigbus_rsvd);
> +	if (!TST_PASS)
> +		goto windup;
> +
> +windup:
> +	SAFE_MUNMAP(p, hpage_size);
> +	after_unmap_rsvd = SAFE_READ_MEMINFO(MEMINFO_HPAGE_RSVD);
> +	tst_res(TINFO, "Reserve count after munmap: %lu", after_unmap_rsvd);

This variable is printed but never checked inside the test.

> +
> +}
> +
> +static void setup(void)
> +{
> +	hpage_size = tst_get_hugepage_size();

Need space here.

> +	fd = tst_creat_unlinked(MNTPOINT, 0, 0600);
> +
> +	struct sigaction sa = {
> +		.sa_handler = sigbus_handler,
> +		.sa_flags = 0,
> +	};
> +
> +	SAFE_SIGACTION(SIGBUS, &sa, NULL);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd >= 0)
> +		SAFE_CLOSE(fd);

Pleae use fd != -1 here.


Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
