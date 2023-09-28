Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C39CE7AFC
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 17:55:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF4453CFB85
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 19:55:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD2C93CE15C
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 19:55:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C34B11A00FB5
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 19:55:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 52EA21F88F;
 Thu, 28 Sep 2023 17:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695923732;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XZ6Hb64uyPMgPfV8IIXv7v8plu2cI9R1BdmqFuch/Ms=;
 b=k8gYkr88W94Rf1NtogKD4rQV830WhsDVdtVeyX85ipjb5Fks9/DdP5q+EgPUwASO2mJUGO
 xmHiC0MMyKBoczzvcamNCHTiApsbgqrdIw22aHoa3H7A0mJVzWut7/St/Re1PBa+QW5agW
 VQvuQFOFx7XbeazI+SDjQFbnq9K0HUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695923732;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XZ6Hb64uyPMgPfV8IIXv7v8plu2cI9R1BdmqFuch/Ms=;
 b=dOa8bQglE6QaQG82wbETzBlkg40nMeaeNXyhpuwxp6iiMGaMBBFru3aKM/alIIipJFYlZw
 6G40Tvgm9vhvObAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C155D138E9;
 Thu, 28 Sep 2023 17:55:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8JSuKRO+FWUjcwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 28 Sep 2023 17:55:31 +0000
Date: Thu, 28 Sep 2023 19:55:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230928175529.GB307171@pevik>
References: <20230928010808.15862-1-wegao@suse.com>
 <20230928084408.21125-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230928084408.21125-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getcwd01: Use syscall directly check invalid
 argument
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

Yes, syscall(__NR_getcwd, ...) is way much better than #ifdef __GLIBC__ in v2.

> Related issue: https://github.com/linux-test-project/ltp/issues/1084
This should be Fixes: #1084


> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/getcwd/getcwd01.c | 23 +++++++++++----------
>  1 file changed, 12 insertions(+), 11 deletions(-)

> diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
> index 65d827873..d47174ffc 100644
> --- a/testcases/kernel/syscalls/getcwd/getcwd01.c
> +++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
> @@ -14,8 +14,8 @@
>   *
>   * Expected Result:
>   * 1) getcwd(2) should return NULL and set errno to EFAULT.
> - * 2) getcwd(2) should return NULL and set errno to ENOMEM.
> - * 3) getcwd(2) should return NULL and set errno to EINVAL.
> + * 2) getcwd(2) should return NULL and set errno to EFAULT.
> + * 3) getcwd(2) should return NULL and set errno to ERANGE.
>   * 4) getcwd(2) should return NULL and set errno to ERANGE.
>   * 5) getcwd(2) should return NULL and set errno to ERANGE.
>   *
> @@ -24,6 +24,7 @@
>  #include <errno.h>
>  #include <unistd.h>
>  #include <limits.h>
> +#include "lapi/syscalls.h"
>  #include "tst_test.h"

>  static char buffer[5];
> @@ -34,32 +35,32 @@ static struct t_case {
>  	int exp_err;
>  } tcases[] = {
>  	{(void *)-1, PATH_MAX, EFAULT},
> -	{NULL, (size_t)-1, ENOMEM},
> -	{buffer, 0, EINVAL},
> +	{NULL, (size_t)-1, EFAULT},
> +	{buffer, 0, ERANGE},
>  	{buffer, 1, ERANGE},
>  	{NULL, 1, ERANGE}
>  };

> +
>  static void verify_getcwd(unsigned int n)
>  {
>  	struct t_case *tc = &tcases[n];
> -	char *res;
> +	int res;

>  	errno = 0;
> -	res = getcwd(tc->buf, tc->size);
> -	TST_ERR = errno;
> -	if (res) {
> +	res = syscall(__NR_getcwd, tc->buf, tc->size);
> +	if (!res) {
>  		tst_res(TFAIL, "getcwd() succeeded unexpectedly");
>  		return;
>  	}

> -	if (TST_ERR != tc->exp_err) {
> -		tst_res(TFAIL | TTERRNO, "getcwd() failed unexpectedly, expected %s",
> +	if (errno != tc->exp_err) {
> +		tst_res(TFAIL, "getcwd() failed unexpectedly, expected %s",
Hm, macros in tst_test_macros.h does not support char * (getcwd() returns NULL
on failure. I wonder if we want to add TST_EXP_FAIL3(), or maybe macro with a
better name (TST_EXP_FAIL_STR()).

Kind regards,
Petr

>  			tst_strerrno(tc->exp_err));
>  		return;
>  	}

> -	tst_res(TPASS | TTERRNO, "getcwd() failed as expected");
> +	tst_res(TPASS, "getcwd() failed as expected");
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
