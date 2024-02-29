Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E10C54798
	for <ltp@archiver.kernel.org>; Thu, 29 Feb 2024 09:41:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01D303CEDE0
	for <ltp@archiver.kernel.org>; Thu, 29 Feb 2024 10:41:20 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A0AC3C26B9
 for <ltp@lists.linux.it>; Thu, 29 Feb 2024 10:41:04 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 82C761401181
 for <ltp@lists.linux.it>; Thu, 29 Feb 2024 10:41:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 621DD1F7CB;
 Thu, 29 Feb 2024 09:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709199662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5dQRAIJcz7rGlWpuZ4pP4xG0k0W8GUBvOOKc6UblaDs=;
 b=0Rd2wlBvI1odH7Y0A+E/QdR9t5gKvZaxuck+D+ft1y/G+fTOUGNOfNf2uvNAJQNmAnw2rN
 +Kp0gf1FkK/6ciVY+zVX4aerpHaN1AXBPlm67LcNn2SR8k34XnNHtj5Y892v0JIO1gTnK2
 fgZuRF3xzm5jbVOV5J96GlN79CqBN0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709199662;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5dQRAIJcz7rGlWpuZ4pP4xG0k0W8GUBvOOKc6UblaDs=;
 b=Fq3x1vkjZv26rXywihTVte29il4h3HCQVDNpbz3bukWU0/YxQy77M0gg3JE8EOqwCJX/nQ
 fWueheMJnlYwnADA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709199662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5dQRAIJcz7rGlWpuZ4pP4xG0k0W8GUBvOOKc6UblaDs=;
 b=0Rd2wlBvI1odH7Y0A+E/QdR9t5gKvZaxuck+D+ft1y/G+fTOUGNOfNf2uvNAJQNmAnw2rN
 +Kp0gf1FkK/6ciVY+zVX4aerpHaN1AXBPlm67LcNn2SR8k34XnNHtj5Y892v0JIO1gTnK2
 fgZuRF3xzm5jbVOV5J96GlN79CqBN0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709199662;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5dQRAIJcz7rGlWpuZ4pP4xG0k0W8GUBvOOKc6UblaDs=;
 b=Fq3x1vkjZv26rXywihTVte29il4h3HCQVDNpbz3bukWU0/YxQy77M0gg3JE8EOqwCJX/nQ
 fWueheMJnlYwnADA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56E9013503;
 Thu, 29 Feb 2024 09:41:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3EnqFC5R4GWqXAAAD6G6ig
 (envelope-from <akumar@suse.de>); Thu, 29 Feb 2024 09:41:02 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it, Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Thu, 29 Feb 2024 10:40:54 +0100
Message-ID: <14365805.8JY2RFzSmD@localhost>
Organization: SUSE
In-Reply-To: <20240227054144.27013-1-xuyang2018.jy@fujitsu.com>
References: <20240227054144.27013-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0Rd2wlBv;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Fq3x1vkj
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; HAS_ORG_HEADER(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; CTE_CASE(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 621DD1F7CB
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] munlockall01: Convert to new API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On Tuesday, February 27, 2024 6:41:44 AM CET Yang Xu via ltp wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  .../kernel/syscalls/munlockall/munlockall01.c | 140 +++---------------
>  1 file changed, 18 insertions(+), 122 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/munlockall/munlockall01.c
> b/testcases/kernel/syscalls/munlockall/munlockall01.c index
> 51f731b65..9306cef11 100644
> --- a/testcases/kernel/syscalls/munlockall/munlockall01.c
> +++ b/testcases/kernel/syscalls/munlockall/munlockall01.c
> @@ -1,134 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
should be "GPL-2.0-only"

>  /*
>   * Copyright (c) Wipro Technologies Ltd, 2002.  All Rights Reserved.
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
> + * Copyright (c) Linux Test Project, 2002-2024
> + * Author: sowmya adiga<sowmya.adiga@wipro.com>
>   */
> -/**************************************************************************
> - *
> - *    TEST IDENTIFIER	: munlockall01
> - *
> - *    EXECUTED BY	: root / superuser
> - *
> - *    TEST TITLE	: Basic test for munlockall(2)
> - *
> - *    TEST CASE TOTAL	: 1
> - *
> - *    AUTHOR		: sowmya adiga<sowmya.adiga@wipro.com>
> - *
> - *    SIGNALS
> - * 	Uses SIGUSR1 to pause before test if option set.
> - * 	(See the parse_opts(3) man page).
> - *
> - *    DESCRIPTION
> - *	This is a phase I test for the munlockall(2) system call.
> - *	It is intended to provide a limited exposure of the system call.
> - *
> - * 	Setup:
> - *	  Setup signal handling.
> - *	  Pause for SIGUSR1 if option specified.
> - *
> - * 	Test:
> - *        Execute system call
> - *	  Check return code, if system call failed (return=-1)
> - *	  Log the errno and Issue a FAIL message.
> - *	  Otherwise, Issue a PASS message.
> - *
> - * 	Cleanup:
> - * 	  Print errno log and/or timing stats if options given
> - *
> - * USAGE:  <for command-line>
> - *  munlockall01 [-c n] [-e] [-i n] [-I x] [-p x] [-t]
> - *		where,		-c n : Run n copies concurrently
> - *	               		-e   : Turn on errno logging.
> - *				-h   : Show this help screen
> - *				-i n : Execute test n times.
> - *				-I x : Execute test for x seconds.
> - *				-p   : Pause for SIGUSR1 before starting
> - *                      	-P x : Pause for x seconds between iterations.
> - *                       	 t   : Turn on syscall timing.
> - *
> - * RESTRICTIONS
> - * Must be root/superuser to run it.
> -
> ***************************************************************************
> **/ -#include <errno.h>
> -#include <sys/mman.h>
> -#include "test.h"
> -
> -void setup();
> -void cleanup();
> -
> -char *TCID = "munlockall01";
> -int TST_TOTAL = 1;
> -
> -#if !defined(UCLINUX)
> -
> -int main(int ac, char **av)
> -{
> -	int lc;
> -
> -	tst_parse_opts(ac, av, NULL, NULL);
> -
> -	setup();
> -
> -	/* check looping state */
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -
> -		tst_count = 0;
> 
> -		TEST(munlockall());
> -
> -		/* check return code */
> -		if (TEST_RETURN == -1) {
> -			tst_resm(TFAIL | TTERRNO, "munlockall() Failed with"
> -				 " return=%ld", TEST_RETURN);
> -		} else {
> -			tst_resm(TPASS, "munlockall() passed with"
> -				 " return=%ld ", TEST_RETURN);
> -
> -		}
> -	}
> -
> -	/* cleanup and exit */
> -	cleanup();
> -	tst_exit();
> -
> -}
> +/*
> + * [Description]
> + *
> + * Check the basic function of munlockall(2) system call.
> + */
> 
> -#else
> +#include "tst_test.h"
> 
> -int main(void)
> +static void verify_munlockall(void)
>  {
> -	tst_resm(TINFO, "test is not available on uClinux");
> -	tst_exit();
> +	TST_EXP_PASS(munlockall());
>  }
> 
> -#endif /* if !defined(UCLINUX) */
> -
> -/* setup() - performs all ONE TIME setup for this test. */
> -void setup(void)
> +static void setup(void)
>  {
> -	tst_require_root();
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	mlockall(MCL_CURRENT);

I think this should be done in the main test function for each iteration.

>  }
> 
> -/*
> - * cleanup() - performs all ONE TIME cleanup for this test at
> - *		completion or premature exit.
> - */
> -void cleanup(void)
> -{
> -}
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.setup = setup,
> +	.test_all  = verify_munlockall,
> +};

Thanks,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
