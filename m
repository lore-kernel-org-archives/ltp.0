Return-Path: <SRS0=ZNpR=QE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB20C433EF
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 10:24:12 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 693C9619F6
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 10:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 693C9619F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38C453C8851
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 11:24:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2ED23C7EBF
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 11:23:59 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 005261A00E09
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 11:23:58 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D20AF1FCA3;
 Wed, 17 Nov 2021 10:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1637144637;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CItzVamzeQdu+mKuqsXv+2pMnD6rtnAZOgxNIgBOpqg=;
 b=JZ8mjWT5qVhsEKct7U7/UZe5fUgDm9yYdVMsY1q/qkS2pkr/JY07O2+0/s+KU4Vf73Ffpg
 zBvhe7XYmgjxZztzf0+CzdKB0KbhB2vzSuAJEYCHuMSWSmRvPBZmfuDJZ1HpKEdQInMQGS
 EW+cdGGEwylEG4fajeHbCEVkRWdslx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1637144637;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CItzVamzeQdu+mKuqsXv+2pMnD6rtnAZOgxNIgBOpqg=;
 b=F2UwTf2X5NksJB18D8vEvKl+EdsPOxmGY1ooqLK1rwAhxbO4ycOwgZMIeBcFl5fyLnKO2x
 RdOnGbSpg+OuumCw==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 7E205A3B85;
 Wed, 17 Nov 2021 10:23:57 +0000 (UTC)
References: <20211117070708.2174932-1-liwang@redhat.com>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Li Wang <liwang@redhat.com>
Date: Wed, 17 Nov 2021 09:58:51 +0000
In-reply-to: <20211117070708.2174932-1-liwang@redhat.com>
Message-ID: <87zgq39j2b.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] lib: adding .supported_archs field in
 tst_test structure
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Testcases for specific arch should be limited on that only being supported
> platform to run, we now involve a .supported_archs to achieve this feature
> in LTP library. All you need to run a test on the expected arch is to set
> the '.supported_archs' array in the 'struct tst_test' to choose the required
> arch list. e.g.
>
>     .supported_archs = (const char *const []){"x86_64", "ppc64", NULL}
>
> This helps move the TCONF info from code to tst_test metadata as well.
>
> And, we also export a struct tst_arch to save the system architecture
> for using in the whole test cases.
>
>     extern const struct tst_arch {
>              char name[16];
>              enum tst_arch_type type;
>     } tst_arch;
>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  doc/c-test-api.txt | 36 +++++++++++++++++
>  include/tst_arch.h | 39 +++++++++++++++++++
>  include/tst_test.h |  7 ++++
>  lib/tst_arch.c     | 96 ++++++++++++++++++++++++++++++++++++++++++++++
>  lib/tst_test.c     |  3 ++
>  5 files changed, 181 insertions(+)
>  create mode 100644 include/tst_arch.h
>  create mode 100644 lib/tst_arch.c
>
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index 3127018a4..64d0630ce 100644
> --- a/doc/c-test-api.txt
> +++ b/doc/c-test-api.txt
> @@ -2261,6 +2261,42 @@ struct tst_test test = {
>  };
>  -------------------------------------------------------------------------------
>  
> +1.39 Testing on the specific architecture
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Testcases for specific arch should be limited on that only being supported
> +platform to run, we now involve a .supported_archs to achieve this feature
> +in LTP library. All you need to run a test on the expected arch is to set
> +the '.supported_archs' array in the 'struct tst_test' to choose the required
> +arch list. e.g.
> +
> +    .supported_archs = (const char *const []){"x86_64", "ppc64", NULL}
> +
> +This helps move the TCONF info from code to tst_test metadata as well.
> +
> +And, we also export a struct tst_arch to save the system architecture for
> +using in the whole test cases.
> +
> +    extern const struct tst_arch {
> +             char name[16];
> +             enum tst_arch_type type;
> +    } tst_arch;
> +
> +[source,c]
> +-------------------------------------------------------------------------------
> +#include "tst_test.h"
> +
> +static struct tst_test test = {
> +       ...
> +       .setup = setup,
> +       .supported_archs = (const char *const []) {
> +                 "x86_64",
> +                 "ppc64",
> +                 "s390x",
> +                 NULL
> +       },
> +};
> +-------------------------------------------------------------------------------
> +
>  2. Common problems
>  ------------------
>  
> diff --git a/include/tst_arch.h b/include/tst_arch.h
> new file mode 100644
> index 000000000..4a9473c6f
> --- /dev/null
> +++ b/include/tst_arch.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (c) 2021 Li Wang <liwang@redhat.com>
> + */
> +
> +#ifndef TST_ARCH_H__
> +#define TST_ARCH_H__
> +
> +enum tst_arch_type {
> +	TST_UNKNOWN,
> +	TST_X86,
> +	TST_X86_64,
> +	TST_IA64,
> +	TST_PPC,
> +	TST_PPC64,
> +	TST_S390,
> +	TST_S390X,
> +	TST_ARM,
> +	TST_AARCH64,
> +	TST_SPARC,
> +};
> +
> +/*
> + * This tst_arch is to save the system architecture for
> + * using in the whole testcase.
> + */
> +extern const struct tst_arch {
> +        char name[16];
> +        enum tst_arch_type type;
> +} tst_arch;
> +
> +/*
> + * Check if test platform is in the given arch list. If yes return 1,
> + * otherwise return 0.
> + *
> + * @archlist A NULL terminated array of architectures to support.
> + */
> +int tst_is_on_arch(const char *const *archlist);
> +
> +#endif /* TST_ARCH_H__ */
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 602ce3090..c06a4729b 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -43,6 +43,7 @@
>  #include "tst_fips.h"
>  #include "tst_taint.h"
>  #include "tst_memutils.h"
> +#include "tst_arch.h"
>  
>  /*
>   * Reports testcase result.
> @@ -139,6 +140,12 @@ struct tst_test {
>  
>  	const char *min_kver;
>  
> +	/*
> +	 * The supported_archs is a NULL terminated list of archs the test
> +	 * does support.
> +	 */
> +	const char *const *supported_archs;
> +
>  	/* If set the test is compiled out */
>  	const char *tconf_msg;
>  
> diff --git a/lib/tst_arch.c b/lib/tst_arch.c
> new file mode 100644
> index 000000000..f19802a03
> --- /dev/null
> +++ b/lib/tst_arch.c
> @@ -0,0 +1,96 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + * Copyright (c) 2021 Li Wang <liwang@redhat.com>
> + */
> +
> +#include <string.h>
> +#include <stdlib.h>
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_arch.h"
> +#include "tst_test.h"
> +
> +const struct tst_arch tst_arch = {
> +#if defined(__x86_64__)
> +        .name = "x86_64",

Writing out these string constants multiple times is error
prone. Perhaps arch_type_list can be indexed with enum tst_arch_type and
then name can be ".name = arch_type_list[TST_X86]"?

> +        .type = TST_X86_64,
> +#elif defined(__i386__) || defined(__i586__) || defined(__i686__)
> +        .name = "x86",
> +        .type = TST_X86,
> +#elif defined(__ia64__)
> +        .name = "ia64",
> +        .type = TST_IA64,
> +#elif defined(__powerpc64__) || defined(__ppc64__)
> +        .name = "ppc64",
> +        .type = TST_PPC64,
> +#elif defined(__powerpc__) || defined(__ppc__)
> +        .name = "ppc",
> +        .type = TST_PPC,
> +#elif defined(__s390x__)
> +        .name = "s390x",
> +        .type = TST_S390X,
> +#elif defined(__s390__)
> +        .name = "s390",
> +        .type = TST_S390,
> +#elif defined(__aarch64__)
> +        .name = "aarch64",
> +        .type = TST_AARCH64,
> +#elif defined(__arm__)
> +        .name = "arm",
> +        .type = TST_ARM,
> +#elif defined(__sparc__)
> +        .name = "sparc",
> +        .type = TST_SPARC,
> +#else
> +        .name = "unknown",
> +        .type = TST_UNKNOWN,
> +#endif
> +};
> +
> +static const char *const arch_type_list[] = {
> +	"i386",
> +	"i586",
> +	"i686",

These are not valid arch names AFAICT. There is no mapping from these to
x86 in the tst_arch table above.

Perhaps we could replace them all with x86?

e.g [TST_X86] = "x86",
    [TST_X86_64] = "x86_64",
    etc...

> +	"x86_64",
> +	"ia64",
> +	"ppc",
> +	"ppc64",
> +	"s390",
> +	"s390x",
> +	"arm",
> +	"aarch64",
> +	"sparc",
> +	NULL
> +};
> +

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
