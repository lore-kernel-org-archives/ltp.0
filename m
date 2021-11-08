Return-Path: <SRS0=tV2W=P3=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8553AC433EF
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 12:33:54 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 975D96125F
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 12:33:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 975D96125F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E894E3C7672
	for <ltp@archiver.kernel.org>; Mon,  8 Nov 2021 13:33:50 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B77413C101C
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 13:33:40 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7B93F1400519
 for <ltp@lists.linux.it>; Mon,  8 Nov 2021 13:33:39 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B89182195D;
 Mon,  8 Nov 2021 12:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636374818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qPiq8WEsjVAbbJs8Hd+OvceNt8DEa07YqJfEYdLqOfI=;
 b=VVUCL1OVl91Np4/35tvkd/OEaKKwkTd4IcptHzD+JBU0+/+2QFmQpQmHwykpEoo+cE4PeT
 h60d4bhtDLfNnf2qojrNfGeN53VhMsHPUmp/XCmtzc17X0S2veKmYRIHpBvMGY1qdLSeMm
 9OJq8o8GJY9Xv2BCeBK1YJfInnGVh/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636374818;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qPiq8WEsjVAbbJs8Hd+OvceNt8DEa07YqJfEYdLqOfI=;
 b=CO3vULD8pyupCaIF8Wm/4UN2zTRC3452DpSerlc1WEp9jDdYawbLy8ntnEd+7FNKnr6deR
 UdC+kWPVIBCgxiAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FC8F13BA0;
 Mon,  8 Nov 2021 12:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RPU9JSIZiWFvZgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 08 Nov 2021 12:33:38 +0000
Date: Mon, 8 Nov 2021 13:34:38 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YYkZXtBn+ZKOXVzB@yuki>
References: <20211108021450.1460819-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211108021450.1460819-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/3] lib: adding .supported_archs field in
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
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
>     extern struct arch {
>              char name[16];
>              enum tst_arch_type type;
>     } tst_arch;
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  doc/c-test-api.txt |  36 +++++++++++++++
>  include/tst_arch.h |  39 ++++++++++++++++
>  include/tst_test.h |  10 +++++
>  lib/tst_arch.c     | 108 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 193 insertions(+)
>  create mode 100644 include/tst_arch.h
>  create mode 100644 lib/tst_arch.c
> 
> diff --git a/doc/c-test-api.txt b/doc/c-test-api.txt
> index 3127018a4..5e32b7075 100644
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
> +    extern struct arch {
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
> index 000000000..784c3093b
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
> +	TST_I386,
> +	TST_X86,

Why do we have both i386 and X86 here? Isn't __i386__ synonymous for
__x86__ does gcc even define __x86__?

I doubt that we care about the differencies between i386, i586 and i686
at all. I would just keep TST_X86 in the list for any 32bit intel
compatible hardware.

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
> +extern struct arch {
> +	char name[16];
> +	enum tst_arch_type type;
> +} tst_arch;

the struct should be prefixed with tst_ as well. i.e.

extern struct tst_arch {
	...

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
> index 3dcb45de0..7611520ee 100644
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
> @@ -316,6 +323,9 @@ static struct tst_test test;
>  
>  int main(int argc, char *argv[])
>  {
> +	if (!tst_is_on_arch(test.supported_archs))
> +		tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);

Why are you putting this check into the header? All the other checks are
in the do_setup() in lib/tst_test.c

>  	tst_run_tcases(argc, argv, &test);
>  }
>  
> diff --git a/lib/tst_arch.c b/lib/tst_arch.c
> new file mode 100644
> index 000000000..ae5817075
> --- /dev/null
> +++ b/lib/tst_arch.c
> @@ -0,0 +1,108 @@
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
> +struct arch tst_arch;
> +
> +static const char *const arch_type_list[] = {
> +	"i386",
> +	"x86",
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
> +static int is_matched_arch(const char *arch, const char *name)
> +{
> +	if (strcmp(arch, name) == 0)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +static int is_valid_arch_name(const char *name)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; arch_type_list[i]; i++) {
> +		if (is_matched_arch(arch_type_list[i], name))
> +			return 1;
> +	}
> +
> +	return 0;
> +}
> +
> +static void get_system_arch(void)
> +{
> +#if defined(__i386__)
> +	strcpy(tst_arch.name, "i386");
> +	tst_arch.type = TST_I386;
> +#elif defined(__x86__)
> +	strcpy(tst_arch.name, "x86");
> +	tst_arch.type = TST_X86;
> +#elif defined(__x86_64__)
> +	strcpy(tst_arch.name, "x86_64");
> +	tst_arch.type = TST_X86_64;
> +#elif defined(__ia64__)
> +	strcpy(tst_arch.name, "ia64");
> +	tst_arch.type = TST_IA64;
> +#elif defined(__powerpc__)
> +	strcpy(tst_arch.name, "ppc");
> +	tst_arch.type = TST_PPC;
> +#elif defined(__powerpc64__)
> +	strcpy(tst_arch.name, "ppc64");
> +	tst_arch.type = TST_PPC64;
> +#elif defined(__s390x__)
> +	strcpy(tst_arch.name, "s390x");
> +	tst_arch.type = TST_S390X;
> +#elif defined(__s390__)
> +	strcpy(tst_arch.name, "s390");
> +	tst_arch.type = TST_S390;
> +#elif defined(__arm__)
> +	strcpy(tst_arch.name, "s390x");
> +	tst_arch.type = TST_ARM;
> +#elif defined(__aarch64__)
> +	strcpy(tst_arch.name, "aarch64");
> +	tst_arch.type = TST_AARCH64;
> +#elif defined(__sparc__)
> +	strcpy(tst_arch.name, "sparc");
> +	tst_arch.type = TST_SPARC;
> +#endif
> +}

Actually we can initialize this staically as:

const struct arch tst_arch = {
#if defined(__x86_64__)
	.name = "x86_64",
	.type = TST_X86_64,
#elif
...
#else
	.name = "unknown",
	.type = TST_ARCH_UNKNOWN,
#endif
};

> +int tst_is_on_arch(const char *const *archlist)
> +{
> +	unsigned int i;
> +
> +	get_system_arch();
> +
> +	if (archlist == NULL)
> +		return 1;

Just if (!archlist)

> +	for (i = 0; archlist[i]; i++) {
> +		if (!is_valid_arch_name(archlist[i]))
> +			tst_brk(TBROK, "%s is invalid arch, please reset!",
                                                                   ^
								   fix?
> +					archlist[i]);
> +	}
> +
> +	for (i = 0; archlist[i]; i++) {
> +		if (is_matched_arch(tst_arch.name, archlist[i]))

I would just do !strcmp() here, there is no point in havin a function
that just calls strcmp() and returns the result.

> +			return 1;
> +	}
> +
> +	return 0;
> +}
> -- 
> 2.31.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
