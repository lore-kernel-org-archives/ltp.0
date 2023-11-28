Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063B5C4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 10:54:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE3FA3CDA16
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 11:54:39 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E7683CD990
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 11:54:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3DDB36068CE
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 11:53:34 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A4E3F1F890;
 Tue, 28 Nov 2023 10:52:47 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 925B8139FC;
 Tue, 28 Nov 2023 10:52:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id dSkFI3/GZWXPbAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 28 Nov 2023 10:52:47 +0000
Date: Tue, 28 Nov 2023 11:52:42 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20231128105242.GA362098@pevik>
References: <20230928084408.21125-1-wegao@suse.com>
 <20230929004518.29632-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230929004518.29632-1-wegao@suse.com>
X-Spamd-Bar: +++++++++
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de; dkim=none;
 spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither
 permitted nor denied by domain of pvorel@suse.cz)
 smtp.mailfrom=pvorel@suse.cz; dmarc=none
X-Rspamd-Queue-Id: A4E3F1F890
X-Spamd-Result: default: False [9.70 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 TO_DN_SOME(0.00)[]; R_SPF_SOFTFAIL(4.60)[~all];
 RCVD_COUNT_THREE(0.00)[3]; MX_GOOD(-0.01)[];
 FROM_EQ_ENVFROM(0.00)[]; R_DKIM_NA(2.20)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-3.00)[100.00%];
 ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_SPAM_SHORT(0.51)[0.170]; MIME_GOOD(-0.10)[text/plain];
 DMARC_NA(1.20)[suse.cz]; NEURAL_SPAM_LONG(3.50)[1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] getcwd01: Use syscall directly check invalid
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

> Fixes: #1084

You haven't written the reason for switching to raw syscall syscall(__NR_getcwd, ...).
(Adding https://github.com/linux-test-project/ltp/issues/1084 is not enough, the
reason for the change is important enough to write to the commit message).

Also, raw syscall obviously returns a different errnos than glibc wrapper.
But again, it would be better to document in the commit message the reason for
the errno change.



> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/getcwd/getcwd01.c | 27 ++++++---------------
>  1 file changed, 7 insertions(+), 20 deletions(-)

> diff --git a/testcases/kernel/syscalls/getcwd/getcwd01.c b/testcases/kernel/syscalls/getcwd/getcwd01.c
> index 65d827873..ac35383a4 100644
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
> @@ -34,32 +35,18 @@ static struct t_case {
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
> -
> -	errno = 0;
> -	res = getcwd(tc->buf, tc->size);
> -	TST_ERR = errno;
> -	if (res) {
> -		tst_res(TFAIL, "getcwd() succeeded unexpectedly");
> -		return;
> -	}
> -
> -	if (TST_ERR != tc->exp_err) {
> -		tst_res(TFAIL | TTERRNO, "getcwd() failed unexpectedly, expected %s",
> -			tst_strerrno(tc->exp_err));
> -		return;
> -	}

> -	tst_res(TPASS | TTERRNO, "getcwd() failed as expected");
> +	TST_EXP_FAIL2(syscall(__NR_getcwd, tc->buf, tc->size), tc->exp_err);

If the reason is that getcwd() wrapper in musl is not easily fixable (we
probably don't want #ifdef __GLIBC__), I'm ok for this.

OTOH if test would be easily fixable for musl, we could consider testing both
raw syscall and libc wrapper via .test_variants (separate effort).

Kind regards,
Petr

>  }

>  static struct tst_test test = {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
