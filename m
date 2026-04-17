Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946ECF43699
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 12:54:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 34D273E5954
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 14:53:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E82383E2983
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 14:53:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3BA4B140032C
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 14:53:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4FA385BD1C;
 Fri, 17 Apr 2026 12:53:39 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F459593AE;
 Fri, 17 Apr 2026 12:53:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OBluClMt4mkNSAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Apr 2026 12:53:39 +0000
Date: Fri, 17 Apr 2026 14:53:22 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260417125322.GA419619@pevik>
References: <20260416-fix_clock_settime_helper-v1-1-2874202291bf@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260416-fix_clock_settime_helper-v1-1-2874202291bf@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 4FA385BD1C
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] clock_settime: use POSIX runtime detection for
 CLOCK_MONOTONIC
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> The clock_settime helpers.h used a compile-time #ifdef on
> _POSIX_MONOTONIC_CLOCK to select between real and stub
> implementations of pts_mono_time_start()/pts_mono_time_check().

> On Linux/glibc, _POSIX_MONOTONIC_CLOCK is defined as 0, meaning
> support is optional and must be verified at runtime via
> sysconf(_SC_MONOTONIC_CLOCK). The #ifdef treated 0 the same as
> >0 (always available), which is not POSIX-correct.

> Replace the compile-time #ifdef/#else split with a runtime
> pts_mono_available() helper that performs proper POSIX detection
> via sysconf(). Also add a missing #ifndef include guard and
> #include <unistd.h> so _POSIX_MONOTONIC_CLOCK is always defined.

> Fixes: 9ecb4a004b18 ("clock_settime: Detect external clock adjustments via CLOCK_MONOTONIC")
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  .../conformance/interfaces/clock_settime/helpers.h | 76 +++++++++++++---------
>  1 file changed, 46 insertions(+), 30 deletions(-)

> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h
> index 37bf30926f039553e9e370751b7938ca5ea1d00a..b568ec8122d3bba8246b09a5b694f1263084a408 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h
> @@ -13,7 +13,11 @@
>   * by those tests.
>   */

> +#ifndef CLOCK_SETTIME_HELPERS_H
> +#define CLOCK_SETTIME_HELPERS_H
> +
>  #include <stdlib.h>
> +#include <unistd.h>

>  static int getBeforeTime(struct timespec *tpget)
>  {
> @@ -37,53 +41,65 @@ static int setBackTime(struct timespec tpset)

>  #define PTS_MONO_MAX_RETRIES 3

> +static struct timespec pts_mono_start;
> +
> +static inline int pts_mono_available(void)
> +{
>  #ifdef _POSIX_MONOTONIC_CLOCK
> -static struct timespec _pts_mono_start;
> +	if (_POSIX_MONOTONIC_CLOCK > 0)
> +		return 1;
> +
> +	if (!_POSIX_MONOTONIC_CLOCK && sysconf(_SC_MONOTONIC_CLOCK) > 0)
This and the previous condition is the same as in patch for nanosleep.
It's a simple code, but because it's still a bit specific, wouldn't it make
sense to move the function from nanosleep/helpers.h [1]
to newly created file in testcases/open_posix_testsuite/include/clock.h?
And both tests would use it?

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20260416-fix_nanosleep_include-v2-1-b3147763acb8@suse.com/

> +		return 1;
> +#endif
> +	return 0;
> +}


Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
