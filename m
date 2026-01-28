Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E00D46BFA
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 21:04:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E64283CA19B
	for <ltp@archiver.kernel.org>; Wed, 28 Jan 2026 22:04:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 262DC3C4D1D
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 22:03:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A2EBC6005DC
 for <ltp@lists.linux.it>; Wed, 28 Jan 2026 22:03:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DCC3A33DBD;
 Wed, 28 Jan 2026 21:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769634230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rt64pMpKR+C1EKkaAHp1jt5nuaGxGAeYAfl2xn0QhDg=;
 b=HTwVcd1n6FtGzfR7AHM1W9eQOzVCS7ue5mW7fBKzoh8qXqAg54EGDgjXY9Aqdfd3dqJsrc
 0D7oMTWOUc9l1+yZpiFkkP7sp3Nt0+pg5FdzA0clF/EhuDvp+uufqXD+RjeR6Gr/snwQfB
 3niE958P0lEquvI4UN+YWT1N5orQGS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769634230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rt64pMpKR+C1EKkaAHp1jt5nuaGxGAeYAfl2xn0QhDg=;
 b=OpDfoyJGNqwhwUQJzdtmS2sgxcREA8WXCnfY4oODV0gbcx87mxRd/oVKpTmmJ7txKkSe1O
 qEt+i8XQKBkjmiAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769634229;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rt64pMpKR+C1EKkaAHp1jt5nuaGxGAeYAfl2xn0QhDg=;
 b=UYlFYeuXNDEqtqJzGQCmdczHAeiKY7mbXmXdz82jg3U9vN6bYTNj7/B5wrZEsA9r4vLK3h
 EcalfqS61Dn8OuhcntrUYSksuf3v+6WPTYa+uvhkscVElYATxLVhsPMAMFTNav9+qc1ZNl
 mtglniQQ2MF0u3Ii9LG1bA4FQ5hnxAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769634229;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rt64pMpKR+C1EKkaAHp1jt5nuaGxGAeYAfl2xn0QhDg=;
 b=ByQ3tLC6WGXYnh+9skNV0XKFcycFLT5IEYxMNifSfwZ1cTlJpju2NQHhUv1lpmFA6KWjE1
 YXnqTm/tdgfVgACQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 49C323EA61;
 Wed, 28 Jan 2026 21:03:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6V75B7V5eml4eAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 28 Jan 2026 21:03:49 +0000
Date: Wed, 28 Jan 2026 22:03:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Kushal Chand K <kushalkataria5@gmail.com>
Message-ID: <20260128210346.GA58669@pevik>
References: <20260122150652.227342-1-kushalkataria5@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260122150652.227342-1-kushalkataria5@gmail.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] kvm: Add needs_driver support to check for kvm
 driver
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> This patch adds needs_driver field in kvm testcases to check for kvm driver

@Kushal Thanks for your patch. very nit: s/needs_driver/needs_drivers/
(can be changed before merge).

Implements: https://github.com/linux-test-project/ltp/issues/1219

@Martin Is it enough to have kvm driver? Or do tests depend on any of specific
kvm kernel config options (not only from virt/kvm/Kconfig, but arch dependent
configs e.g.  CONFIG_KVM_GUEST=y from arch/x86/Kconfig ?)

Kind regards,
Petr

> Signed-off-by: Kushal Chand K <kushalkataria5@gmail.com>
> ---
>  testcases/kernel/kvm/kvm_pagefault01.c | 4 ++++
>  testcases/kernel/kvm/kvm_svm01.c       | 4 ++++
>  testcases/kernel/kvm/kvm_svm02.c       | 4 ++++
>  testcases/kernel/kvm/kvm_svm03.c       | 4 ++++
>  testcases/kernel/kvm/kvm_svm04.c       | 4 ++++
>  testcases/kernel/kvm/kvm_vmx01.c       | 4 ++++
>  testcases/kernel/kvm/kvm_vmx02.c       | 4 ++++
>  7 files changed, 28 insertions(+)

> diff --git a/testcases/kernel/kvm/kvm_pagefault01.c b/testcases/kernel/kvm/kvm_pagefault01.c
> index db526cb7e..2b477f7af 100644
> --- a/testcases/kernel/kvm/kvm_pagefault01.c
> +++ b/testcases/kernel/kvm/kvm_pagefault01.c
> @@ -165,6 +165,10 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = tst_kvm_cleanup,
>  	.needs_root = 1,
> +	.needs_drivers = (const char *const []) {
> +		"kvm",
> +		NULL
> +	},
>  	.supported_archs = (const char *const []) {
>  		"x86_64",
>  		NULL
> diff --git a/testcases/kernel/kvm/kvm_svm01.c b/testcases/kernel/kvm/kvm_svm01.c
> index 32d15526b..f81602567 100644
> --- a/testcases/kernel/kvm/kvm_svm01.c
> +++ b/testcases/kernel/kvm/kvm_svm01.c
> @@ -108,6 +108,10 @@ static struct tst_test test = {
>  	.test_all = tst_kvm_run,
>  	.setup = tst_kvm_setup,
>  	.cleanup = tst_kvm_cleanup,
> +	.needs_drivers = (const char *const []) {
> +		"kvm",
> +		NULL
> +	},
>  	.supported_archs = (const char *const []) {
>  		"x86_64",
>  		"x86",
> diff --git a/testcases/kernel/kvm/kvm_svm02.c b/testcases/kernel/kvm/kvm_svm02.c
> index 6914fdcba..701f2731d 100644
> --- a/testcases/kernel/kvm/kvm_svm02.c
> +++ b/testcases/kernel/kvm/kvm_svm02.c
> @@ -129,6 +129,10 @@ static struct tst_test test = {
>  	.test_all = tst_kvm_run,
>  	.setup = tst_kvm_setup,
>  	.cleanup = tst_kvm_cleanup,
> +	.needs_drivers = (const char *const []) {
> +		"kvm",
> +		NULL
> +	},
>  	.supported_archs = (const char *const []) {
>  		"x86_64",
>  		"x86",
> diff --git a/testcases/kernel/kvm/kvm_svm03.c b/testcases/kernel/kvm/kvm_svm03.c
> index 87164d013..faafaf7cf 100644
> --- a/testcases/kernel/kvm/kvm_svm03.c
> +++ b/testcases/kernel/kvm/kvm_svm03.c
> @@ -154,6 +154,10 @@ static struct tst_test test = {
>  	.test_all = run,
>  	.setup = setup,
>  	.cleanup = cleanup,
> +	.needs_drivers = (const char *const []) {
> +		"kvm",
> +		NULL
> +	},
>  	.min_cpus = 2,
>  	.supported_archs = (const char *const []) {
>  		"x86_64",
> diff --git a/testcases/kernel/kvm/kvm_svm04.c b/testcases/kernel/kvm/kvm_svm04.c
> index 75fcbfdcf..af3c8b1c6 100644
> --- a/testcases/kernel/kvm/kvm_svm04.c
> +++ b/testcases/kernel/kvm/kvm_svm04.c
> @@ -295,6 +295,10 @@ static struct tst_test test = {
>  	.test_all = tst_kvm_run,
>  	.setup = tst_kvm_setup,
>  	.cleanup = tst_kvm_cleanup,
> +	.needs_drivers = (const char *const []) {
> +		"kvm",
> +		NULL
> +	},
>  	.supported_archs = (const char *const []) {
>  		"x86_64",
>  		"x86",
> diff --git a/testcases/kernel/kvm/kvm_vmx01.c b/testcases/kernel/kvm/kvm_vmx01.c
> index 5bffbe946..d0c4913c9 100644
> --- a/testcases/kernel/kvm/kvm_vmx01.c
> +++ b/testcases/kernel/kvm/kvm_vmx01.c
> @@ -269,6 +269,10 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = tst_kvm_cleanup,
>  	.needs_root = 1,
> +	.needs_drivers = (const char *const []) {
> +		"kvm",
> +		NULL
> +	},
>  	.supported_archs = (const char *const []) {
>  		"x86_64",
>  		"x86",
> diff --git a/testcases/kernel/kvm/kvm_vmx02.c b/testcases/kernel/kvm/kvm_vmx02.c
> index 3fcfebb3b..4ce225e56 100644
> --- a/testcases/kernel/kvm/kvm_vmx02.c
> +++ b/testcases/kernel/kvm/kvm_vmx02.c
> @@ -183,6 +183,10 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = tst_kvm_cleanup,
>  	.needs_root = 1,
> +	.needs_drivers = (const char *const []) {
> +		"kvm",
> +		NULL
> +	},
>  	.supported_archs = (const char *const []) {
>  		"x86_64",
>  		"x86",

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
