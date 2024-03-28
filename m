Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96198C54E67
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 11:50:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D91593C1CEC
	for <ltp@archiver.kernel.org>; Thu, 28 Mar 2024 12:50:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 114313C02EB
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 12:49:39 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3762E618FDC
 for <ltp@lists.linux.it>; Thu, 28 Mar 2024 12:49:38 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E50BB33E36;
 Thu, 28 Mar 2024 11:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711626578;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2htXmSXLupccwIfGpykOAOQ3iyzb0Im9I+TTzAa6UAc=;
 b=iWMtIalQxy7qjwmQvNyp5oeVWpZwf2zwKjhfnpzXyLhAuFfoIUaL59TLP4wU6vQbZ7ODqe
 LIukSguftP7QlZBGQH2c+okAzlSTxC0vL9pONBLqvq8Al3jPUKHiARIs79AJYc6trrziYQ
 1pL06M/UxyhUt14UcotKRDjI5NTUw4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711626578;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2htXmSXLupccwIfGpykOAOQ3iyzb0Im9I+TTzAa6UAc=;
 b=zR8HNk+CD/acRLdvyAGFv3F5h9kNa01LL40v4Bay//I2TFu+0z1BLvWjobQGkRyPbgZ6Ln
 s3SowbOXSTkUoODw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711626577;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2htXmSXLupccwIfGpykOAOQ3iyzb0Im9I+TTzAa6UAc=;
 b=aRCh5OIMOpof1q+FjsmXb+0wthKeup0+Uw5r2UakeiLnX83ps9qNmWjhPrJQsybo7yPPEK
 7MiwWSN4iTHzvHuDDO0XsVd82oiJ8Wqm943bBkuodzHSgpXfHrRoCmW6QZ5mnR7Y/jnuOe
 tht/ZsiwSRUNi9xSynaHAKyr8UVoCq4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711626577;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2htXmSXLupccwIfGpykOAOQ3iyzb0Im9I+TTzAa6UAc=;
 b=xn86JwbV/Wdlec2gaDGtBO4AqTqUx9RBeDQ3YSFA1Gark63BrwM+6vfMCBs0GUhvBz8uXU
 2WE4PXAxwUzg2WAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CE54513AF7;
 Thu, 28 Mar 2024 11:49:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id Efx6MVFZBWY2HwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 28 Mar 2024 11:49:37 +0000
Date: Thu, 28 Mar 2024 12:49:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240328114932.GC51940@pevik>
References: <20240208013224.859-1-wegao@suse.com>
 <20240327034923.30987-1-wegao@suse.com>
 <20240327034923.30987-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240327034923.30987-2-wegao@suse.com>
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aRCh5OIM;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xn86JwbV
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.71 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.00)[29.91%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Queue-Id: E50BB33E36
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] lib: TST_EXP_{FAIL,PASS}_PTR_{NULL,VOID}
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

> --- /dev/null
> +++ b/lib/newlib_tests/test_macros07.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 Wei Gao <wegao@suse.com>
> + */
> +
> +/*
> + * Test TST_EXP_FAIL_PTR_{NULL,VOID} and TST_EXP_FAIL_PTR_ARR{NULL,VOID} macro.
> + */
> +
> +#include "tst_test.h"
> +
> +static char *fail_fn_null(void)
> +{
> +	errno = EINVAL;
> +	return NULL;
> +}
> +
> +static char *fail_fn_void(void)
> +{
> +	errno = EINVAL;
> +	return (void *)-1;
> +}
> +
> +static char *pass_fn(void)
> +{
> +	return "pass";
> +}
> +
> +static void do_test(void)
> +{
> +	const int exp_errs_pass[] = {ENOTTY, EINVAL};
> +	const int exp_errs_fail[] = {ENOTTY, EISDIR};
> +
> +	tst_res(TINFO, "Testing TST_EXP_FAIL_PTR_NULL macro");
> +	TST_EXP_FAIL_PTR_NULL(fail_fn_null(), EINVAL, "fail_fn_null()");
> +	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
> +	TST_EXP_FAIL_PTR_NULL(fail_fn_null(), ENOTTY, "fail_fn_null()");
> +	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
> +	TST_EXP_FAIL_PTR_NULL(pass_fn(), ENOTTY, "pass_fn()");
> +	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
> +	TST_EXP_FAIL_PTR_ARR_NULL(fail_fn_null(), exp_errs_pass, "fail_fn_null()");
> +	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
> +	TST_EXP_FAIL_PTR_ARR_NULL(fail_fn_null(), exp_errs_fail, "fail_fn()_null");
> +	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
> +
> +	tst_res(TINFO, "Testing TST_EXP_FAIL_PTR_VOID macro");
> +	TST_EXP_FAIL_PTR_VOID(fail_fn_void(), EINVAL, "fail_fn_void()");
> +	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
> +	TST_EXP_FAIL_PTR_VOID(fail_fn_void(), ENOTTY, "fail_fn_void()");
> +	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
> +	TST_EXP_FAIL_PTR_VOID(pass_fn(), ENOTTY, "pass_fn()");
> +	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
> +	TST_EXP_FAIL_PTR_ARR_VOID(fail_fn_void(), exp_errs_pass, "fail_fn_void()");
> +	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
> +	TST_EXP_FAIL_PTR_ARR_VOID(fail_fn_void(), exp_errs_fail, "fail_fn()_void");
> +	tst_res(TINFO, "TST_PASS = %i", TST_PASS);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +};

How about extend test_macros02.c (add testing macro, renaming functions to avoid clash,
add inval_ret_fn_char() which was missing in your version):

static int fail_fn(void)
{
	errno = EINVAL;
	return -1;
}

static int pass_fn(void)
{
	return 0;
}

static int inval_ret_fn(void)
{
	return 42;
}

static char *fail_fn_null(void)
{
	errno = EINVAL;
	return NULL;
}

static char *fail_fn_void(void)
{
	errno = EINVAL;
	return (void *)-1;
}

static char *inval_ret_fn_char(void)
{
	return (void *)-1;
}

static char *pass_fn_char(void)
{
	return "pass";
}

#define TEST_MACRO(macro, macro_arr, fail_fn, pass_fn, inval_fn) \
	do {                                                                   \
		tst_res(TINFO, "Testing macro macro"); \
		macro(fail_fn(), EINVAL, "fail_fn()"); \
		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
		macro(fail_fn(), ENOTTY, "fail_fn()"); \
		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
		macro(pass_fn(), ENOTTY, "pass_fn()"); \
		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
		macro(inval_fn(), ENOTTY, "inval_fn()"); \
		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
		macro_arr(fail_fn(), exp_errs_pass, "fail_fn()"); \
		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
		macro_arr(fail_fn(), exp_errs_fail, "fail_fn()"); \
		tst_res(TINFO, "TST_PASS = %i", TST_PASS); \
	} while (0)

static void do_test(void)
{

	const int exp_errs_pass[] = {ENOTTY, EINVAL};
	const int exp_errs_fail[] = {ENOTTY, EISDIR};

	TEST_MACRO(TST_EXP_FAIL, TST_EXP_FAIL_ARR, fail_fn, pass_fn, inval_ret_fn);
	TEST_MACRO(TST_EXP_FAIL2, TST_EXP_FAIL2_ARR, fail_fn, pass_fn, inval_ret_fn);
	TEST_MACRO(TST_EXP_FAIL_PTR_NULL, TST_EXP_FAIL_PTR_ARR_NULL, fail_fn_null,
			   pass_fn_char, inval_ret_fn_char);
	TEST_MACRO(TST_EXP_FAIL_PTR_VOID, TST_EXP_FAIL_PTR_ARR_VOID, fail_fn_void,
			   pass_fn_char, inval_ret_fn_char);
}

static struct tst_test test = {
	.test_all = do_test,
};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
