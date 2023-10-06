Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B2A6E9413A
	for <ltp@archiver.kernel.org>; Fri,  6 Oct 2023 23:17:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2D7813C9611
	for <ltp@archiver.kernel.org>; Sat,  7 Oct 2023 01:17:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7556A3C88B2
 for <ltp@lists.linux.it>; Sat,  7 Oct 2023 01:17:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C7A1B603E8B
 for <ltp@lists.linux.it>; Sat,  7 Oct 2023 01:17:11 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B7C1F21866;
 Fri,  6 Oct 2023 23:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1696634230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aO8Wb1OGX0lwyiedJiI+FpuPbXezpiQfQpSrWySGlnU=;
 b=FY7+VhWSKRwE7UL5HcHgkSUdXsQTqwHhjIf3Q7RmfFfCDKjcrWQAwRzv0YvHaXI8zxEgus
 XXx4r7Hj1yo0wG6srJGuV7yoUBf4DTdqhs4a7XD2eRsK3Dez8JKqbSFwvSs/XfvunNlZDw
 4IRH+0Fc2xRVGuX/9Ly7VIxpGzYpKbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1696634230;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aO8Wb1OGX0lwyiedJiI+FpuPbXezpiQfQpSrWySGlnU=;
 b=38M5FRLEyodLR0nUsH7LE1DeDfFVtxtuFc5E2tEcMWUkEJeY6BQ7R6OFS2aGy0p5qlZUI6
 UJWfSuFdNCkncnCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9EFEA13586;
 Fri,  6 Oct 2023 23:17:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JyP9JXaVIGUoRQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 06 Oct 2023 23:17:10 +0000
Date: Sat, 7 Oct 2023 01:17:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ybonatakis <ybonatakis@suse.com>
Message-ID: <20231006231709.GA254103@pevik>
References: <20231003174155.25566-1-ybonatakis@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231003174155.25566-1-ybonatakis@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Refactor wait4/wait402.c to the new API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ioannis,

> Not major changes in functionality. Man page says, *wait for process to change
> state, BSD style*. So i kept the `_USE_BSD` macro, even if test seems to work
> anyway without it.
This is certainly wrong. _USE_BSD are glibc specific constants, which we should
avoid to use. man wait4(2) states for wait4():

   Since glibc 2.19:
	   _DEFAULT_SOURCE

   glibc 2.19 and earlier:
	   _BSD_SOURCE

_DEFAULT_SOURCE IMHO means it works by default, thus we wouldn't need anything.

musl libc guards it with:
#if defined(_GNU_SOURCE) || defined(_BSD_SOURCE)

But at least on Alpine (the most used musl based linux distro) also compiles
without any definition => let's remove it.

> Signed-off-by: ybonatakis <ybonatakis@suse.com>
Could you please use your real name?
Signed-off-by: Ioannis Bonatakis <ybonatakis@suse.com>

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

> ---
>  testcases/kernel/syscalls/wait4/wait402.c | 97 ++++-------------------
>  1 file changed, 17 insertions(+), 80 deletions(-)

> diff --git a/testcases/kernel/syscalls/wait4/wait402.c b/testcases/kernel/syscalls/wait4/wait402.c
> index 39b170253..13b2af533 100644
> --- a/testcases/kernel/syscalls/wait4/wait402.c
> +++ b/testcases/kernel/syscalls/wait4/wait402.c
> @@ -1,101 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   *
>   *   Copyright (c) International Business Machines  Corp., 2001
>   *   Copyright (c) 2012 Cyril Hrubis <chrubis@suse.cz>

nit: there should be a single space after *. Also I'd
/*
 * Copyright (c) International Business Machines  Corp., 2001
 * Copyright (c) 2012 Cyril Hrubis <chrubis@suse.cz>
 * Copyright (c) Linux Test Project, 2001-2015
 * Copyright (c) 2023 Ioannis Bonatakis <ybonatakis@suse.com>
 */

> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> + *   Copyright (c) 2023 Ioannis Bonatakis <ybonatakis@suse.com>
>   */

> +/*\
> + * [Description]
> + *
> + * Check for ECHILD errno when using an illegal pid value
nit: missing dot at the end. Also I reword it a bit:
 * Check for ECHILD errno when call wait4(2) with an invalid pid value.
> + */

> -#include <errno.h>
> +#include "tst_test.h"
>  #define _USE_BSD
Removed (see above).

> -#include <sys/types.h>
> -#include <sys/resource.h>
>  #include <sys/wait.h>
> -#include <stdlib.h>
> -#include <string.h>
...

> +static pid_t pid_max;

> -int main(int ac, char **av)
> +static void run(void)
>  {
> -	int lc;
> -	pid_t epid = get_pid_max() + 1;
NOTE: max PID + 1 is invalid.
> -
>  	int status = 1;
There is no need to initialize the variable, it will be set by wait4().

>  	struct rusage rusage;

> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		TEST(wait4(epid, &status, 0, &rusage));
> -
> -		if (TEST_RETURN == 0) {
> -			tst_brkm(TFAIL, cleanup,
> -				 "call failed to produce expected error - errno = %d - %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> -		}
> -
> -		switch (TEST_ERRNO) {
> -		case ECHILD:
> -			tst_resm(TPASS,
> -				 "received expected failure - errno = %d - %s",
> -				 TEST_ERRNO, strerror(TEST_ERRNO));
> -			break;
> -		default:
> -			tst_brkm(TFAIL, cleanup,
> -				 "call failed to produce expected "
> -				 "error - errno = %d - %s", TEST_ERRNO,
> -				 strerror(TEST_ERRNO));
> -		}
> -	}

> +	TST_EXP_FAIL2(wait4(pid_max, &status, 0, &rusage), ECHILD,
> +		      "wait4 fails with ECHILD");
	TST_EXP_FAIL2(wait4(pid_max + 1, &status, 0, &rusage), ECHILD);
NOTE: use +1, otherwise it would not be test for invalid pid value.

Also no need for "fails with ECHILD".

>  }

>  static void setup(void)
>  {
> +	SAFE_FILE_SCANF("/proc/sys/kernel/pid_max", "%d\n", &pid_max);
>  }

> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +};

In the end I fixed the issues and merged with the diff below.
Thanks for your work.

Kind regards,
Petr

+++ testcases/kernel/syscalls/wait4/wait402.c
@@ -1,30 +1,28 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
- *
- *   Copyright (c) International Business Machines  Corp., 2001
- *   Copyright (c) 2012 Cyril Hrubis <chrubis@suse.cz>
- *   Copyright (c) 2023 Ioannis Bonatakis <ybonatakis@suse.com>
+ * Copyright (c) International Business Machines  Corp., 2001
+ * Copyright (c) 2012 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2001-2015
+ * Copyright (c) 2023 Ioannis Bonatakis <ybonatakis@suse.com>
  */
 
 /*\
  * [Description]
  *
- * Check for ECHILD errno when using an illegal pid value
+ * Check for ECHILD errno when call wait4(2) with an illegal pid value.
  */
 
 #include "tst_test.h"
-#define _USE_BSD
 #include <sys/wait.h>
 
 static pid_t pid_max;
 
 static void run(void)
 {
-	int status = 1;
+	int status;
 	struct rusage rusage;
 
-	TST_EXP_FAIL2(wait4(pid_max, &status, 0, &rusage), ECHILD,
-		      "wait4 fails with ECHILD");
+	TST_EXP_FAIL2(wait4(pid_max + 1, &status, 0, &rusage), ECHILD);
 }
 
 static void setup(void)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
