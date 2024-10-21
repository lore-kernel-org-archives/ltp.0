Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13150D15DAD
	for <ltp@archiver.kernel.org>; Mon, 21 Oct 2024 15:25:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 086F43C6F23
	for <ltp@archiver.kernel.org>; Mon, 21 Oct 2024 17:25:08 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA2173C061D
 for <ltp@lists.linux.it>; Mon, 21 Oct 2024 17:24:50 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ADDA723465E
 for <ltp@lists.linux.it>; Mon, 21 Oct 2024 17:24:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B657E21E2C;
 Mon, 21 Oct 2024 15:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729524288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GlKVv91TAt6uQuxHSA9yTNBJw+ZRgIyGQi3roXVEFq4=;
 b=O0pXkrb/lrEsOCwLI/bA7UZg+kVryR44jPvBEOeSOFpxPEOMm7JWJ3sfwpKbq8ksYLCZYk
 OaohdzwcYOJTz6rduFjOT1lBjohrSvFEycpBZhWKx8VpjN4X4iXofTBEIzow5dGCHEKC99
 Z+NdJBrPLsbjZz9X1O553zwsQOym39I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729524288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GlKVv91TAt6uQuxHSA9yTNBJw+ZRgIyGQi3roXVEFq4=;
 b=DZ8rpUGo/UYeEICnNQg87SKu+534yihYsaU8wQibAe+OiOl+wbmrkDBGyhYluAFZxTAbvC
 kyPWXxzYeEP+51DQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729524288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GlKVv91TAt6uQuxHSA9yTNBJw+ZRgIyGQi3roXVEFq4=;
 b=O0pXkrb/lrEsOCwLI/bA7UZg+kVryR44jPvBEOeSOFpxPEOMm7JWJ3sfwpKbq8ksYLCZYk
 OaohdzwcYOJTz6rduFjOT1lBjohrSvFEycpBZhWKx8VpjN4X4iXofTBEIzow5dGCHEKC99
 Z+NdJBrPLsbjZz9X1O553zwsQOym39I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729524288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GlKVv91TAt6uQuxHSA9yTNBJw+ZRgIyGQi3roXVEFq4=;
 b=DZ8rpUGo/UYeEICnNQg87SKu+534yihYsaU8wQibAe+OiOl+wbmrkDBGyhYluAFZxTAbvC
 kyPWXxzYeEP+51DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A114C136DC;
 Mon, 21 Oct 2024 15:24:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RxUyJkByFmdfaQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 21 Oct 2024 15:24:48 +0000
Date: Mon, 21 Oct 2024 17:24:48 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: "Ricardo B. Marliere" <rbm@suse.com>
Message-ID: <ZxZyQIV_d95yg30k@yuki.lan>
References: <20241018-block_dev-v1-1-f1f98dfebb6d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241018-block_dev-v1-1-f1f98dfebb6d@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] block_dev: Convert to new API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  .../block/block_dev_kernel/ltp_block_dev.c         |  1 -
>  .../block/block_dev_user/block_dev.c               | 78 +++++++++-------=
------
>  2 files changed, 32 insertions(+), 47 deletions(-)
> =

> diff --git a/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_b=
lock_dev.c b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_blo=
ck_dev.c
> index 17047c0d5ae3f6556f3fa4b0eb2a17a86e5f05a6..8a3ee4ff0bac6ed46c7c09c57=
52b6fec3ef01a40 100644
> --- a/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_de=
v.c
> +++ b/testcases/kernel/device-drivers/block/block_dev_kernel/ltp_block_de=
v.c
> @@ -12,7 +12,6 @@
>  #include <linux/module.h>
>  #include <linux/device.h>
>  #include <linux/fs.h>
> -#include <linux/genhd.h>
>  #include <linux/blkdev.h>

Technically LTP is supposed to support kernel 4.4 and newer, looking
into kernel git the genhd.h content was moved into blkdev.h in 5.18 so
ideally we should make it work for both. I suppose that we can make use
of one of the macros that were moved into blkdev.h and do something as:

#include <linux/blkdev.h>
#ifndef DISK_NAME_LEN
# include <linux/genhd.h>
#endif

>  MODULE_AUTHOR("M=E1rton N=E9meth <nm127@freemail.hu>");
> diff --git a/testcases/kernel/device-drivers/block/block_dev_user/block_d=
ev.c b/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
> index 543c36795cc3b2776c59141023e03ff2c58bd36a..f795fb05b9af71f6a3c748936=
a15ac3a652db5e3 100644
> --- a/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
> +++ b/testcases/kernel/device-drivers/block/block_dev_user/block_dev.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
>   *
> @@ -26,74 +27,59 @@
>  #include <unistd.h>
>  #include <string.h>
>  =

> -#include "test.h"
> -#include "safe_macros.h"
> -#include "old_module.h"
> +#include "tst_test.h"
> +#include "tst_module.h"
> +
> +#define MODULE_NAME "ltp_block_dev"
> +#define MODULE_NAME_KO	MODULE_NAME ".ko"
>  =

>  char *TCID =3D "block_dev";

Isn't this unused as well?

> -int TST_TOTAL =3D 9;
>  =

> -static const char module_name[]	=3D "ltp_block_dev.ko";
>  static const char dev_result[]	=3D "/sys/devices/ltp_block_dev/result";
>  static const char dev_tcase[]	=3D "/sys/devices/ltp_block_dev/tcase";
> -static int module_loaded;
>  =

> -static int run_all_testcases;
> -static const option_t options[] =3D {
> -	{"a", &run_all_testcases, NULL},
> +static int module_loaded;
> +static char* run_all_testcases;

The whitespaces around the asterisk here are wrong. Have fixed all the
errors and warnings reported by 'make check'?

> +static struct tst_option options[] =3D {
> +	{"a",  &run_all_testcases, "-a\tRun all test-cases (can crash the kerne=
l)"},
>  	{NULL, NULL, NULL}
>  };
>  =

>  static void cleanup(void)
>  {
>  	if (module_loaded)
> -		tst_module_unload(NULL, module_name);
> -}
> -
> -static void help(void)
> -{
> -	printf("  -a      Run all test-cases (can crash the kernel)\n");
> -}
> -
> -void setup(int argc, char *argv[])
> -{
> -	tst_parse_opts(argc, argv, options, help);
> -
> -	tst_require_root();
> -
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> +		tst_module_unload(MODULE_NAME_KO);
>  }
>  =

> -static void test_run(void)
> +static void run(unsigned int n)
>  {
> -	int off =3D 0;
>  	/*
>  	 * test-cases #8 and #9 can crash the kernel.
>  	 * We have to wait for kernel fix where register_blkdev() &
>  	 * unregister_blkdev() checks the input device name parameter
>  	 * against NULL pointer.
>  	 */

Is this still true?

> -	if (!run_all_testcases)
> -		off =3D 2;
> -
> -	tst_module_load(cleanup, module_name, NULL);
> -	module_loaded =3D 1;
> -
> -	int i, pass =3D 0;
> -	for (i =3D 0; i < TST_TOTAL - off; ++i) {
> -		SAFE_FILE_PRINTF(cleanup, dev_tcase, "%d", i + 1);
> -		SAFE_FILE_SCANF(cleanup, dev_result, "%d", &pass);
> -		tst_resm((pass) ? TPASS : TFAIL, "Test-case '%d'", i + 1);
> +	n++;
> +	if (!run_all_testcases && (n =3D=3D 8 || n =3D=3D 9)) {
> +		tst_res(TCONF, "Skipped n =3D %d", n);
> +		return;
>  	}
> -}
> -
> -int main(int argc, char *argv[])
> -{
> -	setup(argc, argv);
> -
> -	test_run();
>  =

> -	cleanup();
> +	if (!module_loaded) {
> +		tst_module_load(MODULE_NAME_KO, NULL);
> +		module_loaded =3D 1;
> +	}
>  =

> -	tst_exit();
> +	int pass =3D 0;
> +	SAFE_FILE_PRINTF(dev_tcase, "%d", n);
> +	SAFE_FILE_SCANF(dev_result, "%d", &pass);
> +	tst_res((pass) ? TPASS : TFAIL, "Test-case '%d'", n);

It would be way better if we printed a menaningful information about the
test here as well, but that would probably require having a third file
exported by the test module and should ideally be done in an subsequent
patch.

>  }
> +
> +static struct tst_test test =3D {
> +	.needs_root =3D 1,
> +	.cleanup =3D cleanup,
> +	.test =3D run,
> +	.tcnt =3D 9,
> +	.options =3D options,
> +};
> =

> ---
> base-commit: 47aff4decc81ac837fd745278def6883fc2f197b
> change-id: 20241018-block_dev-c322152e03ad
> =

> Best regards,
> -- =

> Ricardo B. Marliere <rbm@suse.com>
> =

> =

> -- =

> Mailing list info: https://lists.linux.it/listinfo/ltp

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
