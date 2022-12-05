Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4215C47089
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 14:00:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E32E3CC253
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 15:00:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 435B33CC1FE
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 14:59:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4974930C029
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 14:59:55 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 19F841FE93;
 Mon,  5 Dec 2022 13:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670248795;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RI0vTMrwvP+uNdoIDLM8Ss/YJxctFcFegowuCOA82c8=;
 b=Ny01VOd+vq50ahkRr/GhNpVgYMbm8UBSouQaZxxSLghgMJK8KZyAk3RJBW7gcbdvti2N5D
 +zZFda9Yo0NmJzG+NTNOXX8hfcSOqW8bbVtxE/A/eLIwFjEW6sC5em4EBHteX0UvKljmuT
 EEQXApTl8NjgYHumvKBWphybNmjHn8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670248795;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RI0vTMrwvP+uNdoIDLM8Ss/YJxctFcFegowuCOA82c8=;
 b=lKbNaruY2UPSvTWH1mYrVvevYpNAloNaA0Yw+wKF7aEcRWT789qHZOgQoklU9yIlDkhROF
 a/8Rd1V7VOBNA/DA==
Received: from g78 (rpalethorpe.udp.ovpn1.nue.suse.de [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C2FE72C141;
 Mon,  5 Dec 2022 13:59:54 +0000 (UTC)
References: <20221201122844.142062-1-tsahu@linux.ibm.com>
 <20221201122844.142062-3-tsahu@linux.ibm.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Tarun Sahu <tsahu@linux.ibm.com>
Date: Mon, 05 Dec 2022 13:32:30 +0000
Organization: Linux Private Site
In-reply-to: <20221201122844.142062-3-tsahu@linux.ibm.com>
Message-ID: <87mt82t0h4.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/8] Hugetlb: Migrating libhugetlbfs
 huge_at_4GB_normal_below
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
Reply-To: rpalethorpe@suse.de
Cc: aneesh.kumar@linux.ibm.com, ltp@lists.linux.it, sbhat@linux.ibm.com,
 geetika@linux.ibm.com, vaibhav@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Tarun Sahu <tsahu@linux.ibm.com> writes:

> Migrating the libhugetlbfs/testcases/huge_at_4GB_normal_below.c test
>
> Test Description: Designed to pick up a bug on ppc64 where
> touches_hugepage_high_range() falsely reported true for ranges reaching
> below 4GB
>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> ---
>  runtest/hugetlb                               |   1 +
>  testcases/kernel/mem/.gitignore               |   1 +
>  .../kernel/mem/hugetlb/hugemmap/hugemmap13.c  | 122 ++++++++++++++++++
>  3 files changed, 124 insertions(+)
>  create mode 100644 testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
>
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index 4c16e1e7c..2029ee4b3 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -14,6 +14,7 @@ hugemmap09 hugemmap09
>  hugemmap10 hugemmap10
>  hugemmap11 hugemmap11
>  hugemmap12 hugemmap12
> +hugemmap13 hugemmap13
>  hugemmap05_1 hugemmap05 -m
>  hugemmap05_2 hugemmap05 -s
>  hugemmap05_3 hugemmap05 -s -m
> diff --git a/testcases/kernel/mem/.gitignore b/testcases/kernel/mem/.gitignore
> index adea760c7..5955ed613 100644
> --- a/testcases/kernel/mem/.gitignore
> +++ b/testcases/kernel/mem/.gitignore
> @@ -13,6 +13,7 @@
>  /hugetlb/hugemmap/hugemmap10
>  /hugetlb/hugemmap/hugemmap11
>  /hugetlb/hugemmap/hugemmap12
> +/hugetlb/hugemmap/hugemmap13
>  /hugetlb/hugeshmat/hugeshmat01
>  /hugetlb/hugeshmat/hugeshmat02
>  /hugetlb/hugeshmat/hugeshmat03
> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
> new file mode 100644
> index 000000000..84a84e074
> --- /dev/null
> +++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap13.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: LGPL-2.1-or-later
> +/*
> + * Copyright (C) 2005-2006 David Gibson & Adam Litke, IBM Corporation.
> + * Author: David Gibson & Adam Litke
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Designed to pick up a bug on ppc64 where touches_hugepage_high_range()
> + * falsely reported true for ranges reaching below 4GB

Hhmm seems like the macro no longer exists. This isn't a great test
description.

This appers to be the fix for the bug mentioned:
https://lkml.org/lkml/2005/11/23/540

Maybe we could add to this that the test creates a hugepage just above
the 32bit memory space and a normal page below it. That on old kernels
this would trigger a bug caused by an off-by-one error.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
