Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD0CC54798
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 21:31:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 754CA3D0D0A
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 22:31:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F9593CEA01
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 22:30:54 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C4F5D100287F
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 22:30:53 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B6BBE338B2;
 Tue,  5 Mar 2024 21:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709674251;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JMhmjf2eBTziMPnv/elzAmpBoW4eTiBgsdZKfrdwOcU=;
 b=1irKkHLIXOSqrqog7D0TNzOrqclDWMZ30O7xsWScqurrXuNtukxYGu+CJQ4pt7hqirZvQN
 cAYRZ9S/SMo5MLAXwlhAC3218vo6YQiqPghlCF7+f9WDkD+SUed3Ix8V/vaE/hnxtcAClM
 W4qpRqbUZ3sCrtakApkJ644uX1vwfl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709674251;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JMhmjf2eBTziMPnv/elzAmpBoW4eTiBgsdZKfrdwOcU=;
 b=S7T8hQsrHEiVBVJgxhg3qnCarnZQ59EzPrrYLEfEEjbffxyHwpx5m1utSF+KZRKdB/WS03
 8RIE2dbi/3QfInDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709674251;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JMhmjf2eBTziMPnv/elzAmpBoW4eTiBgsdZKfrdwOcU=;
 b=1irKkHLIXOSqrqog7D0TNzOrqclDWMZ30O7xsWScqurrXuNtukxYGu+CJQ4pt7hqirZvQN
 cAYRZ9S/SMo5MLAXwlhAC3218vo6YQiqPghlCF7+f9WDkD+SUed3Ix8V/vaE/hnxtcAClM
 W4qpRqbUZ3sCrtakApkJ644uX1vwfl8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709674251;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JMhmjf2eBTziMPnv/elzAmpBoW4eTiBgsdZKfrdwOcU=;
 b=S7T8hQsrHEiVBVJgxhg3qnCarnZQ59EzPrrYLEfEEjbffxyHwpx5m1utSF+KZRKdB/WS03
 8RIE2dbi/3QfInDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E41E13466;
 Tue,  5 Mar 2024 21:30:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id wDelHQuP52UUHwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 05 Mar 2024 21:30:51 +0000
Date: Tue, 5 Mar 2024 22:30:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Dennis Brendel <dbrendel@redhat.com>
Message-ID: <20240305213050.GB44833@pevik>
References: <6dfa210d-1c9a-4888-9408-eccc3068cd2a@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6dfa210d-1c9a-4888-9408-eccc3068cd2a@redhat.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] munlockall: add test case that verifies memory
 has been unlocked
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

Hi Dennis,

Generally LGTM, thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

you should also add test into .gitignore and to some file in runtest/ (in this
case into runtest/syscalls), if we don't simply replace your test with munlockall01.c
as Cyril suggested (I would also vote for replacing it).

FYI you can have look for what we check:

https://github.com/linux-test-project/ltp/wiki/Maintainer-Patch-Review-Checklist

> Changes to v1:

> - use a docparse comment
> - use tabs for indentation
> - report broken test and exit if any preparation/confirmation fails
>   by using tst_brk(TBROK, ...)
> - fix further violations reported by `make check`

> I did not yet replace munlockall01.c because I am not familiar with
I guess Cyril meant just to replace munlockall01.c with what you wrote.
+1 for this, there is no point to keep original munlockall01.c.
And because you replace, you can delete the original copyright and can use
GPL-2.0-or-later (original test was GPL v2 only).

> that (legacy?) syntax and why uclinux needs special handling.

uclinux is for nommu, we don't support it in new API (and nobody from the
community standup for the support), it can be just deleted.

> ---
>  .../kernel/syscalls/munlockall/munlockall02.c | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/munlockall/munlockall02.c

> diff --git a/testcases/kernel/syscalls/munlockall/munlockall02.c b/testcases/kernel/syscalls/munlockall/munlockall02.c
> new file mode 100644
> index 000000000..06f781d86
> --- /dev/null
> +++ b/testcases/kernel/syscalls/munlockall/munlockall02.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright Red Hat
> + * Author: Dennis Brendel <dbrendel@redhat.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that munlockall(2) unlocks all previously locked memory
> + */
> +
> +#include <sys/mman.h>
> +
> +#include "tst_test.h"
> +
> +static void verify_munlockall(void)
> +{
> +	size_t size = 0;
> +
> +	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
> +
> +	if (size != 0UL)
> +		tst_brk(TBROK, "Locked memory after init should be 0 but is "
> +			       "%ld", size);
nit: I would not split string (kernel source code also relaxed to 100 chars
instead of 8O).

> +
> +	if (mlockall(MCL_CURRENT | MCL_FUTURE) != 0)
> +		tst_brk(TBROK, "Could not lock memory using mlockall()");
Maybe use tst_brk(TBROK | TERRNO, to get errno printed?
> +
> +	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
> +
> +	if (size == 0UL)
> +		tst_brk(TBROK, "Locked memory after mlockall() should be "
> +			       "greater than 0, but is %ld", size);
I suppose < 0 really means no memory locked, thus really safe to quit before
munlockall(), right?
> +
> +	if (munlockall() != 0)
> +		tst_brk(TBROK, "Could not unlock memory using munlockall()");
Also here use TBROK | TERRNO ?
> +
> +	SAFE_FILE_LINES_SCANF("/proc/self/status", "VmLck: %ld", &size);
> +
> +	if (size != 0UL) {
> +		tst_res(TFAIL, "Locked memory after munlockall() should be 0 "
> +			       "but is %ld", size);
nit: also here I would join string to single line (still below 100 chars).
> +	} else {
> +		tst_res(TPASS, "Test passed");
nit maybe:
		tst_res(TPASS, "Memory successfully locked and unlocked");

Kind regards,
Petr

> +	}
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_munlockall,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
