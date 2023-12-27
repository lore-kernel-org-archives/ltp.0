Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3BBC46CD2
	for <ltp@archiver.kernel.org>; Wed, 27 Dec 2023 13:22:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 117D63CD7F6
	for <ltp@archiver.kernel.org>; Wed, 27 Dec 2023 14:22:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F264D3C890F
 for <ltp@lists.linux.it>; Wed, 27 Dec 2023 14:21:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7391B140020E
 for <ltp@lists.linux.it>; Wed, 27 Dec 2023 14:21:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 825AF1F8B6;
 Wed, 27 Dec 2023 13:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1703683307;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+hA/KTPycy7bOL1dKwdW2A3LNQSGuEOr27ctCEi3mMw=;
 b=F9IAuYy6eDbhmccriAvKTb6mW3LrdQfWqdU9ttGIhYxSgdvfSU/80LCkqL9cGwIAnv3ivA
 hZvk1OGTddwoOK55vDBgeSOu1AnOghGOw7M0cXNsDb8bjEDmV7J2jPkY05WTvDNJvDAh0x
 oa1KUxqBdSwzslo4PC4dBO7aP9tZyWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1703683307;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+hA/KTPycy7bOL1dKwdW2A3LNQSGuEOr27ctCEi3mMw=;
 b=RXVyWw/c+E3mJU6OY6r0HRpC79l0k16IIZ9R1OluYxpKSVgGMx8/Tb6hzfMSZzR79Esb2b
 ARHg9RJGHFDPS6BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1703683306;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+hA/KTPycy7bOL1dKwdW2A3LNQSGuEOr27ctCEi3mMw=;
 b=nuiUD4FZvx5qMdW+E8YVLjyLrgjxNR3ubF59/hJOGwocux1qczLAIWVicVlaCjgRFMkB5C
 OqViZrC2OI4Xs21zHkt+OmIfAEFDKCh+A+TUwND9TJOdhc+hI5R+CMlPqJflwrjdYS4Gqc
 utFxMJJjWLZ/arhY9mN4w0Ann+0E5fE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1703683306;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+hA/KTPycy7bOL1dKwdW2A3LNQSGuEOr27ctCEi3mMw=;
 b=We5Woh4Rh+n2mw1ahUtOgKn2lhXFLE/dKjwwntFS4yq9lMGswN8inj2Y5/V6V1nY7S55Zp
 CP8Gzaa8TJOOsHDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A7EC13281;
 Wed, 27 Dec 2023 13:21:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xn2IFOokjGVWJQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 27 Dec 2023 13:21:46 +0000
Date: Wed, 27 Dec 2023 14:21:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20231227132144.GA740736@pevik>
References: <20231206105318.11832-1-wegao@suse.com>
 <20231222100611.12661-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231222100611.12661-1-wegao@suse.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: +++++
X-Spamd-Result: default: False [5.59 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3]; BAYES_SPAM(5.10)[100.00%];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[testinfo.pl:url,suse.cz:dkim,suse.cz:email,suse.com:email,googlesource.com:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nuiUD4FZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=We5Woh4R
X-Rspamd-Queue-Id: 825AF1F8B6
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] getcwd01: Implement .test_variants
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

Hi Wei,

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/getcwd/getcwd.h   | 80 +++++++++++++++++++++
>  testcases/kernel/syscalls/getcwd/getcwd01.c | 35 ++++++---
>  2 files changed, 105 insertions(+), 10 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/getcwd/getcwd.h

> diff --git a/testcases/kernel/syscalls/getcwd/getcwd.h b/testcases/kernel/syscalls/getcwd/getcwd.h
> new file mode 100644
> index 000000000..91f229904
> --- /dev/null
> +++ b/testcases/kernel/syscalls/getcwd/getcwd.h
First, I don't think it's a good idea to create getcwd.h, when code is used only
in single source. It should be in getcwd01.c. And looking into other getcwd0*.c
sources, I would use test_variants only in this source.

> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later
> + *
> + * Copyright (c) International Business Machines  Corp., 2001
> + * Copyright (c) 2013 Cyril Hrubis <chrubis@suse.cz>
Why these two copyrights?

> + *
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program;  if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
You know that SPDX is used to replaced this verbose license text, right?

> + */
> +
> +#ifndef GETCWD_H
> +#define GETCWD_H
We usually add trailing __ to avoid theoretical clash with third party headers.
(GETCWD_H__).

> +#include <stdint.h>
> +#include "config.h"
> +#include "lapi/syscalls.h"
> +
> +static inline void
> +check_getcwd(char *buf, size_t size, int exp_err)
This should be on single line. If you copy pasted it from something, that was
probably where signature was much longer than 80 char, this is even less than 80
chars.

> +{
> +	char *res;
> +
> +	errno = 0;
> +	res = getcwd(buf, size);
Why so complicated code? Why not just use TST_EXP_FAIL2() as you do in
tst_getcwd()? That would be way fewer lines of code. There is no problem to use
TST_EXP_FAIL2() with libc syscall wrappers.

> +	TST_ERR = errno;
> +	if (res) {
> +		tst_res(TFAIL, "getcwd() succeeded unexpectedly");
> +		return;
> +	}
> +
> +	if (TST_ERR != exp_err) {
> +		tst_res(TFAIL | TTERRNO, "getcwd() failed unexpectedly, expected %s",
> +				tst_strerrno(exp_err));
> +		return;
> +	}
> +
> +	tst_res(TPASS | TTERRNO, "getcwd() failed as expected");
> +}
> +
> +static inline void
> +tst_getcwd(char *buf, size_t size, int exp_err, int exp_err2)
And here as well: this should be on single line.
> +{
> +	switch (tst_variant) {
Please, do not use switch for 2 variants, if is much readable in this case.
> +	case 0:
> +		TST_EXP_FAIL2(tst_syscall(__NR_getcwd, buf, size), exp_err);
> +		break;
> +	case 1:
> +#ifdef __GLIBC__

#1084 [1] reported problem on MUSL only. Your original patch [2] to fix #1084
skipped only 2 of tests, which used NULL buffer. Why now skip everything? Please
skip only these two and put comment about musl and #1084 to be obvious why you
do that. You could also add note to the git commit message. Not documenting this
will raise questions in the future.

Also, looking that into bionic [3], it's compatible with glibc and uclibc{,-ng}
(I'll verify it with Edward Liaw from Google), thus I would check like in
run(unsigned int n):

static void run(unsigned int n)
{
	struct t_case *tc = &tcases[n];

	/* https://github.com/linux-test-project/ltp/issues/1084 */
#if !defined(__GLIBC__) && !defined(__ANDROID__)
	if (tst_variant && !tc->buf) {
		tst_res(TCONF, "NULL buffer test skipped on MUSL due different implementation");
		return;
	}
#endif

	tst_getcwd(tc->buf, tc->size, tc->exp_err, tc->exp_err2);
}

Or we could skip NULL buffer test on all libc.

[1] https://github.com/linux-test-project/ltp/issues/1084
[2] https://lore.kernel.org/ltp/20230928010808.15862-1-wegao@suse.com/
[3] https://android.googlesource.com/platform/bionic.git/+/refs/tags/android-14.0.0_r18/libc/bionic/getcwd.cpp

> +		check_getcwd(buf, size, exp_err2);
> +#endif
> +		break;
> +	}
> +}
> +
> +static inline void
> +getcwd_info(void)
This should be on single line.
> +{
> +	switch (tst_variant) {
> +	case 0:
> +		tst_res(TINFO, "Testing getcwd with raw syscall");
> +		break;
> +	case 1:
> +		tst_res(TINFO, "Testing getcwd with wrap syscall");
> +		break;
> +	}
Instead of this, I would add direct TINFO messages to the setup function in getcwd01.c.
Again, once this is used in 2 sources, it makes sense to have custom function to
it, otherwise not.
And we should rethink, how to simplify using test_variants on these simple
cases (I did some proposal in the past, I should get back to it; the problem is
with that some tests use clock_adjtime.h, which is a bit complicate than this
raw syscall vs. libc wrapper simple use case).

> +}
> +
> +#define TEST_VARIANTS 2

Instead of this define I would just put 2 into .test_variants =
(again, only used in single file).

> +
> +#endif /* GETCWD_H */
> diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
> index 218bf4ef2..6decb961f 100644
> --- a/testcases/kernel/syscalls/getcwd/getcwd01.c
> +++ b/testcases/kernel/syscalls/getcwd/getcwd01.c
> @@ -13,18 +13,26 @@
>   * 5) getcwd(2) fails if buf points to NULL and the size is set to 1.
>   *
>   * Expected Result:
> + * linux syscall
Well, I told you several times, that list requires separating by blank line
otherwise it breaks formatting. Could you please add it and check generated
docparse before sending a patch:
cd metadata && make && chromium ../docparse/*.html
We should check for it in metaparse.c or in testinfo.pl.
>   * 1) getcwd(2) should return NULL and set errno to EFAULT.
>   * 2) getcwd(2) should return NULL and set errno to EFAULT.
>   * 3) getcwd(2) should return NULL and set errno to ERANGE.
>   * 4) getcwd(2) should return NULL and set errno to ERANGE.
>   * 5) getcwd(2) should return NULL and set errno to ERANGE.
> + *
> + * glibc
FYI #ifdef __GLIBC__ means glibc and uclibc{,-ng}.
Also, again missing blank line before list.
> + * 1) getcwd(2) should return NULL and set errno to EFAULT.
> + * 2) getcwd(2) should return NULL and set errno to ENOMEM.
> + * 3) getcwd(2) should return NULL and set errno to EINVAL.
> + * 4) getcwd(2) should return NULL and set errno to ERANGE.
> + * 5) getcwd(2) should return NULL and set errno to ERANGE.
>   */

>  #include <errno.h>
>  #include <unistd.h>
>  #include <limits.h>
>  #include "tst_test.h"
> -#include "lapi/syscalls.h"
> +#include "getcwd.h"

>  static char buffer[5];

> @@ -32,23 +40,30 @@ static struct t_case {
>  	char *buf;
>  	size_t size;
>  	int exp_err;
> +	int exp_err2;
Maybe exp_err_kernel and exp_err_libc would actually describe the purpose.

>  } tcases[] = {
> -	{(void *)-1, PATH_MAX, EFAULT},
> -	{NULL, (size_t)-1, EFAULT},
> -	{buffer, 0, ERANGE},
> -	{buffer, 1, ERANGE},
> -	{NULL, 1, ERANGE}
> +	{(void *)-1, PATH_MAX, EFAULT, EFAULT},
> +	{NULL, (size_t)-1, EFAULT, ENOMEM},
> +	{buffer, 0, ERANGE, EINVAL},
> +	{buffer, 1, ERANGE, ERANGE},
> +	{NULL, 1, ERANGE, ERANGE},
>  };

> -
> -static void verify_getcwd(unsigned int n)
> +static void run(unsigned int n)
nit: this can stay verify_getcwd().
>  {
>  	struct t_case *tc = &tcases[n];

> -	TST_EXP_FAIL2(tst_syscall(__NR_getcwd, tc->buf, tc->size), tc->exp_err);
> +	tst_getcwd(tc->buf, tc->size, tc->exp_err, tc->exp_err2);
> +}
> +
> +static void setup(void)
> +{
> +	getcwd_info();
There is no point to use wrappers like this (I guess I have told you on
different patch). We would specify .setup = getcwd_info, in the struct tst_test.
But as I wrote above, better would be to move content of getcwd_info() to setup
function.

>  }

>  static struct tst_test test = {
> +	.setup = setup,
>  	.tcnt = ARRAY_SIZE(tcases),
> -	.test = verify_getcwd
> +	.test = run,
> +	.test_variants = TEST_VARIANTS,
	.test_variants = 2,
>  };

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
