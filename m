Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28DFC4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 15:13:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 360823CBE65
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 16:13:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 059E43C2B4D
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 16:13:42 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2DF4C1A0042C
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 16:13:41 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 37A061F8BD;
 Mon, 12 Dec 2022 15:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1670858021;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b6Yyl45goivCU8s4wADeH19pEcwqCYeQOAWSUZj33Dk=;
 b=Nfvt0J6r0VLoEmw2opu2Dp5I8Uz4vA/INVnkVmsQOLtje+/RcWO2hoirHHdbwR/6c1FIsr
 WcruCpqq9TXmfKL/DtctLuGKo0TUOJbH4W7UkqYLkbWj+iXg9U5HjegfYPg6IQ9WIEVNMU
 TTAwuAfiqCXwfevjQ6whvXdjdTNHMo8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1670858021;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b6Yyl45goivCU8s4wADeH19pEcwqCYeQOAWSUZj33Dk=;
 b=MPB/hWH5nciqQRiE6kUY8cRdxF6/9Uew92QsURtlvJbshCrbtH2gp2y8QMWdVl7foN0h/C
 gWDW3kLj7EOCkYCQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id F25B72C141;
 Mon, 12 Dec 2022 15:13:40 +0000 (UTC)
References: <20221207092428.11798-1-teo.coupriediaz@arm.com>
User-agent: mu4e 1.8.11; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
Date: Mon, 12 Dec 2022 15:12:04 +0000
Organization: Linux Private Site
In-reply-to: <20221207092428.11798-1-teo.coupriediaz@arm.com>
Message-ID: <871qp4u02j.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/brk: add direct syscall tst_variant
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


Cyril, Petr, Would you like to add your reviewed by tags? Then we can
merge this.

Teo Couprie Diaz <teo.coupriediaz@arm.com> writes:

> Direct usage of brk is discouraged in favor of using malloc. Also, brk was
> removed from POSIX in POSIX.1-2001.
> In particular, the Musl libc's brk always returns -ENOMEM which causes
> the LTP tests to exit prematurely. Invoking the syscall directly allows
> them to properly validate brk behavior. Add a new test variant handling if
> the libc wrappers are not implemented and testing the direct syscall.
>
> Use tst_syscall() and handle the failure cases ourselves, as
> we don't depend on the libc to do it anymore.
>
> The patch also works around the dependency on sbrk to get the current break
> as it has the same issues. Instead, call tst_syscall(__NR_brk, 0) which
> always returns the current break.
>
> Update brk01 to use void* to unify it with brk02.
>
> Signed-off-by: Teo Couprie Diaz <teo.coupriediaz@arm.com>
> ---
> v1: Reworked from RFC by adding a variant rather than replacing the
>     existing tests. Thanks Petr and Cyril !
> v2: brk doesn't return the new break, just if it error'd or not.
>     Fix styling and warnings.
>
>  testcases/kernel/syscalls/brk/brk01.c | 37 ++++++++++++++++------
>  testcases/kernel/syscalls/brk/brk02.c | 44 ++++++++++++++++++++++-----
>  2 files changed, 65 insertions(+), 16 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/brk/brk01.c b/testcases/kernel/syscalls/brk/brk01.c
> index a9b89bce5..93e430328 100644
> --- a/testcases/kernel/syscalls/brk/brk01.c
> +++ b/testcases/kernel/syscalls/brk/brk01.c
> @@ -9,14 +9,31 @@
>  #include <errno.h>
>  
>  #include "tst_test.h"
> +#include "lapi/syscalls.h"
>  
>  void verify_brk(void)
>  {
> -	uintptr_t cur_brk, new_brk;
> -	uintptr_t inc = getpagesize() * 2 - 1;
> +	void *cur_brk, *new_brk;
> +	size_t inc = getpagesize() * 2 - 1;
>  	unsigned int i;
>  
> -	cur_brk = (uintptr_t)sbrk(0);
> +	if (tst_variant) {
> +		tst_res(TINFO, "Testing syscall variant");
> +		cur_brk = (void *)tst_syscall(__NR_brk, 0);
> +	} else {
> +		tst_res(TINFO, "Testing libc variant");
> +		cur_brk = (void *)sbrk(0);
> +
> +		if (cur_brk == (void *)-1)
> +			tst_brk(TCONF, "sbrk() not implemented");
> +
> +		/*
> +		 * Check if brk itself is implemented: updating to the current break
> +		 * should be a no-op.
> +		 */
> +		if (brk(cur_brk) != 0)
> +			tst_brk(TCONF, "brk() not implemented");
> +	}
>  
>  	for (i = 0; i < 33; i++) {
>  		switch (i % 3) {
> @@ -31,16 +48,17 @@ void verify_brk(void)
>  		break;
>  		}
>  
> -		TST_EXP_PASS_SILENT(brk((void *)new_brk), "brk()");
> -		if (!TST_PASS)
> -			return;
> -
> -		cur_brk = (uintptr_t)sbrk(0);
> +		if (tst_variant) {
> +			cur_brk = (void *)tst_syscall(__NR_brk, new_brk);
> +		} else {
> +			TST_EXP_PASS_SILENT(brk(new_brk), "brk()");
> +			cur_brk = sbrk(0);
> +		}
>  
>  		if (cur_brk != new_brk) {
>  			tst_res(TFAIL,
>  				"brk() failed to set address have %p expected %p",
> -				(void *)cur_brk, (void *)new_brk);
> +				cur_brk, new_brk);
>  			return;
>  		}
>  
> @@ -54,4 +72,5 @@ void verify_brk(void)
>  
>  static struct tst_test test = {
>  	.test_all = verify_brk,
> +	.test_variants = 2,
>  };
> diff --git a/testcases/kernel/syscalls/brk/brk02.c b/testcases/kernel/syscalls/brk/brk02.c
> index 11e803cb4..3a97d279b 100644
> --- a/testcases/kernel/syscalls/brk/brk02.c
> +++ b/testcases/kernel/syscalls/brk/brk02.c
> @@ -14,24 +14,53 @@
>  #include <unistd.h>
>  #include <sys/mman.h>
>  #include "tst_test.h"
> +#include "lapi/syscalls.h"
> +
> +void *brk_variants(void *addr)
> +{
> +	void *brk_addr;
> +
> +	if (tst_variant) {
> +		brk_addr = (void *)tst_syscall(__NR_brk, addr);
> +	} else {
> +		TST_EXP_PASS_SILENT(brk(addr), "brk()");
> +		brk_addr = (void *)sbrk(0);
> +	}
> +	return brk_addr;
> +}
>  
>  void brk_down_vmas(void)
>  {
> -	void *brk_addr = sbrk(0);
> +	void *brk_addr;
> +
> +	if (tst_variant) {
> +		tst_res(TINFO, "Testing syscall variant");
> +		brk_addr = (void *)tst_syscall(__NR_brk, 0);
> +	} else {
> +		tst_res(TINFO, "Testing libc variant");
> +		brk_addr = (void *)sbrk(0);
>  
> -	if (brk_addr == (void *) -1)
> -		tst_brk(TBROK, "sbrk() failed");
> +		if (brk_addr == (void *)-1)
> +			tst_brk(TCONF, "sbrk() not implemented");
> +
> +		/*
> +		 * Check if brk itself is implemented: updating to the current break
> +		 * should be a no-op.
> +		 */
> +		if (brk(brk_addr) != 0)
> +			tst_brk(TCONF, "brk() not implemented");
> +	}
>  
>  	unsigned long page_size = getpagesize();
>  	void *addr = brk_addr + page_size;
>  
> -	if (brk(addr)) {
> +	if (brk_variants(addr) < addr) {
>  		tst_res(TFAIL | TERRNO, "Cannot expand brk() by page size");
>  		return;
>  	}
>  
>  	addr += page_size;
> -	if (brk(addr)) {
> +	if (brk_variants(addr) < addr) {
>  		tst_res(TFAIL | TERRNO, "Cannot expand brk() by 2x page size");
>  		return;
>  	}
> @@ -42,12 +71,12 @@ void brk_down_vmas(void)
>  	}
>  
>  	addr += page_size;
> -	if (brk(addr)) {
> +	if (brk_variants(addr) < addr) {
>  		tst_res(TFAIL | TERRNO, "Cannot expand brk() after mprotect");
>  		return;
>  	}
>  
> -	if (brk(brk_addr)) {
> +	if (brk_variants(brk_addr) != brk_addr) {
>  		tst_res(TFAIL | TERRNO, "Cannot restore brk() to start address");
>  		return;
>  	}
> @@ -57,4 +86,5 @@ void brk_down_vmas(void)
>  
>  static struct tst_test test = {
>  	.test_all = brk_down_vmas,
> +	.test_variants = 2,
>  };
>
> base-commit: 990c0b48f8508a747863b1dea5556fba57e1c304
> -- 
> 2.25.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
