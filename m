Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E25D358F9
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 10:34:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A03F83CBF00
	for <ltp@archiver.kernel.org>; Thu, 29 Jan 2026 11:34:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 024553CBE7F
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 11:34:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 767926008F9
 for <ltp@lists.linux.it>; Thu, 29 Jan 2026 11:34:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E21C65BD0C;
 Thu, 29 Jan 2026 10:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769682867; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S9IBrgL7T9mmWe/X83KqmFPaGkIlCxxyYkXrLztrY4Q=;
 b=eVUG87+bxdqOYPMNhJ/uDcfr86exwfeBuuiZPZDLbFPYee/DClpcal+YVjhpO3sQnN/li7
 XqBMovX0FKuYwYXcHygRF5BCUxwNAzxDeb6lrkcoiTdiy+2fZaLtyjHh7xb+nk6+MpilNR
 K1hqJjTz3ms1jDACeMXPDKVtYayYGkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769682867;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S9IBrgL7T9mmWe/X83KqmFPaGkIlCxxyYkXrLztrY4Q=;
 b=WmI/TdkJiVDDigven61Y+rYHGs0F1K480JlNzkKmLRmpl8trqV5AGyczuk5wic608LbTqO
 XqF+mIMHt7oboECA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769682866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S9IBrgL7T9mmWe/X83KqmFPaGkIlCxxyYkXrLztrY4Q=;
 b=zHl8AT+yM0Ei1i6GJ0iIL3iURvxE7tM0McrceU3Gl4ydB1Z4Jv2yDH3CfAFGcHy1JbZly4
 Qz+c6nzj5aMBArOuzeld73Pfkj2c37uP2PNlMafhwVdGTMGQZaHJFm1oQGwZXl3g4wnDjs
 qa4Uhf6yMr2i7iPtqD+/sexcM2cGAfY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769682866;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=S9IBrgL7T9mmWe/X83KqmFPaGkIlCxxyYkXrLztrY4Q=;
 b=LzDLBDnNUvYamaofW4Jwj5nYPWT2XXX1xYgNDqc4nHzOr24mahAsRFNNDzgCusuS5/aWqY
 CyVqkz6SDCi1shBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CE1D23EA61;
 Thu, 29 Jan 2026 10:34:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HWASMrI3e2nCbAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Thu, 29 Jan 2026 10:34:26 +0000
Message-ID: <a6d005b3-55be-44d4-98bb-bac885848f20@suse.cz>
Date: Thu, 29 Jan 2026 11:34:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kushal Chand K <kushalkataria5@gmail.com>, ltp@lists.linux.it
References: <20260122150652.227342-1-kushalkataria5@gmail.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20260122150652.227342-1-kushalkataria5@gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,lists.linux.it]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Thanks for the patch.

Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 1/22/26 16:06, Kushal Chand K wrote:
> This patch adds needs_driver field in kvm testcases to check for kvm driver
> 
> Signed-off-by: Kushal Chand K <kushalkataria5@gmail.com>
> ---
>   testcases/kernel/kvm/kvm_pagefault01.c | 4 ++++
>   testcases/kernel/kvm/kvm_svm01.c       | 4 ++++
>   testcases/kernel/kvm/kvm_svm02.c       | 4 ++++
>   testcases/kernel/kvm/kvm_svm03.c       | 4 ++++
>   testcases/kernel/kvm/kvm_svm04.c       | 4 ++++
>   testcases/kernel/kvm/kvm_vmx01.c       | 4 ++++
>   testcases/kernel/kvm/kvm_vmx02.c       | 4 ++++
>   7 files changed, 28 insertions(+)
> 
> diff --git a/testcases/kernel/kvm/kvm_pagefault01.c b/testcases/kernel/kvm/kvm_pagefault01.c
> index db526cb7e..2b477f7af 100644
> --- a/testcases/kernel/kvm/kvm_pagefault01.c
> +++ b/testcases/kernel/kvm/kvm_pagefault01.c
> @@ -165,6 +165,10 @@ static struct tst_test test = {
>   	.setup = setup,
>   	.cleanup = tst_kvm_cleanup,
>   	.needs_root = 1,
> +	.needs_drivers = (const char *const []) {
> +		"kvm",
> +		NULL
> +	},
>   	.supported_archs = (const char *const []) {
>   		"x86_64",
>   		NULL
> diff --git a/testcases/kernel/kvm/kvm_svm01.c b/testcases/kernel/kvm/kvm_svm01.c
> index 32d15526b..f81602567 100644
> --- a/testcases/kernel/kvm/kvm_svm01.c
> +++ b/testcases/kernel/kvm/kvm_svm01.c
> @@ -108,6 +108,10 @@ static struct tst_test test = {
>   	.test_all = tst_kvm_run,
>   	.setup = tst_kvm_setup,
>   	.cleanup = tst_kvm_cleanup,
> +	.needs_drivers = (const char *const []) {
> +		"kvm",
> +		NULL
> +	},
>   	.supported_archs = (const char *const []) {
>   		"x86_64",
>   		"x86",
> diff --git a/testcases/kernel/kvm/kvm_svm02.c b/testcases/kernel/kvm/kvm_svm02.c
> index 6914fdcba..701f2731d 100644
> --- a/testcases/kernel/kvm/kvm_svm02.c
> +++ b/testcases/kernel/kvm/kvm_svm02.c
> @@ -129,6 +129,10 @@ static struct tst_test test = {
>   	.test_all = tst_kvm_run,
>   	.setup = tst_kvm_setup,
>   	.cleanup = tst_kvm_cleanup,
> +	.needs_drivers = (const char *const []) {
> +		"kvm",
> +		NULL
> +	},
>   	.supported_archs = (const char *const []) {
>   		"x86_64",
>   		"x86",
> diff --git a/testcases/kernel/kvm/kvm_svm03.c b/testcases/kernel/kvm/kvm_svm03.c
> index 87164d013..faafaf7cf 100644
> --- a/testcases/kernel/kvm/kvm_svm03.c
> +++ b/testcases/kernel/kvm/kvm_svm03.c
> @@ -154,6 +154,10 @@ static struct tst_test test = {
>   	.test_all = run,
>   	.setup = setup,
>   	.cleanup = cleanup,
> +	.needs_drivers = (const char *const []) {
> +		"kvm",
> +		NULL
> +	},
>   	.min_cpus = 2,
>   	.supported_archs = (const char *const []) {
>   		"x86_64",
> diff --git a/testcases/kernel/kvm/kvm_svm04.c b/testcases/kernel/kvm/kvm_svm04.c
> index 75fcbfdcf..af3c8b1c6 100644
> --- a/testcases/kernel/kvm/kvm_svm04.c
> +++ b/testcases/kernel/kvm/kvm_svm04.c
> @@ -295,6 +295,10 @@ static struct tst_test test = {
>   	.test_all = tst_kvm_run,
>   	.setup = tst_kvm_setup,
>   	.cleanup = tst_kvm_cleanup,
> +	.needs_drivers = (const char *const []) {
> +		"kvm",
> +		NULL
> +	},
>   	.supported_archs = (const char *const []) {
>   		"x86_64",
>   		"x86",
> diff --git a/testcases/kernel/kvm/kvm_vmx01.c b/testcases/kernel/kvm/kvm_vmx01.c
> index 5bffbe946..d0c4913c9 100644
> --- a/testcases/kernel/kvm/kvm_vmx01.c
> +++ b/testcases/kernel/kvm/kvm_vmx01.c
> @@ -269,6 +269,10 @@ static struct tst_test test = {
>   	.setup = setup,
>   	.cleanup = tst_kvm_cleanup,
>   	.needs_root = 1,
> +	.needs_drivers = (const char *const []) {
> +		"kvm",
> +		NULL
> +	},
>   	.supported_archs = (const char *const []) {
>   		"x86_64",
>   		"x86",
> diff --git a/testcases/kernel/kvm/kvm_vmx02.c b/testcases/kernel/kvm/kvm_vmx02.c
> index 3fcfebb3b..4ce225e56 100644
> --- a/testcases/kernel/kvm/kvm_vmx02.c
> +++ b/testcases/kernel/kvm/kvm_vmx02.c
> @@ -183,6 +183,10 @@ static struct tst_test test = {
>   	.setup = setup,
>   	.cleanup = tst_kvm_cleanup,
>   	.needs_root = 1,
> +	.needs_drivers = (const char *const []) {
> +		"kvm",
> +		NULL
> +	},
>   	.supported_archs = (const char *const []) {
>   		"x86_64",
>   		"x86",
> --
> 2.43.0
> 
> 


-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
