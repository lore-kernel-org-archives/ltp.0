Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193E7C54E41
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 20:53:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C8573D0BD2
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 21:53:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2F19B3CEB73
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 21:52:45 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 46B7D602211
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 21:52:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0D1B93737E;
 Tue,  5 Mar 2024 20:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709671964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ury9W2QBzwc4AvC7fkxs8mU6Rx7f65hoSebohvgvk0k=;
 b=B9OGQYUubdPl9/eEAjO68OV+a6yojHmeX2W92+29FEjeOJ5GUsW/ynOao4u/m8FS2XVaJv
 8Diya2mbz+NV9J9vWHl9rt1JdkpV+hjn2LXzgoPREpzO00nmAJx6Qgy7sKablApW241SWj
 Pc1O4sbo/f3V3AsxUgU+ZeMm+oepeoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709671964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ury9W2QBzwc4AvC7fkxs8mU6Rx7f65hoSebohvgvk0k=;
 b=pN5zVRsoiD4AIhcgOudL6eFxa7ZZD1ndfLSzIIbWrGFypgWzXr3U1dwStk+91vnIHC4O+m
 6xFKUGCrzfcRwtBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709671964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ury9W2QBzwc4AvC7fkxs8mU6Rx7f65hoSebohvgvk0k=;
 b=B9OGQYUubdPl9/eEAjO68OV+a6yojHmeX2W92+29FEjeOJ5GUsW/ynOao4u/m8FS2XVaJv
 8Diya2mbz+NV9J9vWHl9rt1JdkpV+hjn2LXzgoPREpzO00nmAJx6Qgy7sKablApW241SWj
 Pc1O4sbo/f3V3AsxUgU+ZeMm+oepeoA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709671964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ury9W2QBzwc4AvC7fkxs8mU6Rx7f65hoSebohvgvk0k=;
 b=pN5zVRsoiD4AIhcgOudL6eFxa7ZZD1ndfLSzIIbWrGFypgWzXr3U1dwStk+91vnIHC4O+m
 6xFKUGCrzfcRwtBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D241F13A5B;
 Tue,  5 Mar 2024 20:52:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wJd2LxuG52XVRAAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 05 Mar 2024 20:52:43 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Date: Tue, 05 Mar 2024 21:52:43 +0100
Message-ID: <3561882.dWV9SEqChM@localhost>
Organization: SUSE
In-Reply-To: <20240121161159.4106646-2-ruansy.fnst@fujitsu.com>
References: <20240121161159.4106646-1-ruansy.fnst@fujitsu.com>
 <20240121161159.4106646-2-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.28 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_ORG_HEADER(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.18)[-0.902]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; CTE_CASE(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] getxattr01: Convert to new API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Shiyang,
some comments below.

On Sunday, January 21, 2024 5:11:59 PM CET Shiyang Ruan wrote:
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  .../kernel/syscalls/getxattr/getxattr01.c     | 188 ++++++------------
>  1 file changed, 61 insertions(+), 127 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/getxattr/getxattr01.c
> b/testcases/kernel/syscalls/getxattr/getxattr01.c index
> cec802a33..e11f00d46 100644
> --- a/testcases/kernel/syscalls/getxattr/getxattr01.c
> +++ b/testcases/kernel/syscalls/getxattr/getxattr01.c
> @@ -1,28 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (C) 2011  Red Hat, Inc.
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of version 2 of the GNU General Public
> - * License as published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it
> - * is free of the rightful claim of any third person regarding
> - * infringement or the like.  Any license provided herein, whether
> - * implied or otherwise, applies only to this software file.  Patent
> - * licenses, if any, provided herein do not apply to combinations of
> - * this program with other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License
> - * along with this program; if not, write the Free Software
> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> - * 02110-1301, USA.
> + * Copyright (c) Linux Test Project, 2012-2024
>   */
> 
> -/*
> +/*\
> + * [Description]
> + *
>   * Basic tests for getxattr(2) and make sure getxattr(2) handles error
>   * conditions correctly.
>   *
> @@ -35,22 +19,11 @@
>   * 4. Verify the attribute got by getxattr(2) is same as the value we set
>   */
> 
> -#include "config.h"
> -#include <sys/types.h>
> -#include <sys/stat.h>
> -#include <errno.h>
> -#include <fcntl.h>
> -#include <unistd.h>
> -#include <stdio.h>
>  #include <stdlib.h>
> -#include <string.h>
> +#include "tst_test.h"
>  #ifdef HAVE_SYS_XATTR_H
>  # include <sys/xattr.h>
>  #endif
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -char *TCID = "getxattr01";
> 
>  #ifdef HAVE_SYS_XATTR_H
>  #define XATTR_TEST_KEY "user.testkey"
> @@ -58,85 +31,51 @@ char *TCID = "getxattr01";
>  #define XATTR_TEST_VALUE_SIZE 20
>  #define BUFFSIZE 64
> 
> -static void setup(void);
> -static void cleanup(void);
> -
> -char filename[BUFSIZ];
> +static char filename[BUFSIZ];
> 
> -struct test_case {
> +static struct tcase {
>  	char *fname;
>  	char *key;
>  	char *value;
>  	size_t size;
>  	int exp_err;
> -};
> -struct test_case tc[] = {
> -	{			/* case 00, get non-existing attribute */
> -	 .fname = filename,
> -	 .key = "user.nosuchkey",
> -	 .value = NULL,
> -	 .size = BUFFSIZE - 1,
> -	 .exp_err = ENODATA,
> -	 },
> -	{			/* case 01, small value buffer */
> -	 .fname = filename,
> -	 .key = XATTR_TEST_KEY,
> -	 .value = NULL,
> -	 .size = 1,
> -	 .exp_err = ERANGE,
> -	 },
> -	{			/* case 02, get existing attribute */
> -	 .fname = filename,
> -	 .key = XATTR_TEST_KEY,
> -	 .value = NULL,
> -	 .size = BUFFSIZE - 1,
> -	 .exp_err = 0,
> -	 },
> +} tcases[] = {
> +	/* case 00, get non-existing attribute */
Can we please remove these comments, as we are describing the testcases
in the description already.
> +	{ filename, "user.nosuchkey", NULL, BUFFSIZE - 1, ENODATA },
> +	/* case 01, small value buffer */
> +	{ filename, XATTR_TEST_KEY, NULL, 1, ERANGE },
> +	/* case 02, get existing attribute */
> +	{ filename, XATTR_TEST_KEY, NULL, BUFFSIZE - 1, 0 },
>  };
> 
> -int TST_TOTAL = sizeof(tc) / sizeof(tc[0]) + 1;
> -
> -int main(int argc, char *argv[])
> +static void run(unsigned int n)
>  {
> -	int lc;
> -	int i;
> -
> -	tst_parse_opts(argc, argv, NULL, NULL);
> -
> -	setup();
> -
> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
> -		tst_count = 0;
> -
> -		for (i = 0; i < (int)ARRAY_SIZE(tc); i++) {
> -			TEST(getxattr(tc[i].fname, tc[i].key, tc[i].value,
> -				      tc[i].size));
> -
> -			if (TEST_ERRNO == tc[i].exp_err) {
> -				tst_resm(TPASS | TTERRNO, "expected behavior");
> -			} else {
> -				tst_resm(TFAIL | TTERRNO, "unexpected behavior"
> -					 "- expected errno %d - Got",
> -					 tc[i].exp_err);
> -			}
> -		}
> -
> -		if (TEST_RETURN != XATTR_TEST_VALUE_SIZE) {
> -			tst_resm(TFAIL,
> -				 "getxattr() returned wrong size %ld expected %d",
> -				 TEST_RETURN, XATTR_TEST_VALUE_SIZE);
> -			continue;
> -		}
> -
> -		if (memcmp(tc[i - 1].value, XATTR_TEST_VALUE, XATTR_TEST_VALUE_SIZE))
> -			tst_resm(TFAIL, "Wrong value, expect \"%s\" got \"%s\"",
> -				 XATTR_TEST_VALUE, tc[i - 1].value);
> -		else
> -			tst_resm(TPASS, "Got the right value");
> +	struct tcase *tc = &tcases[n];
> +
> +	TEST(getxattr(tc->fname, tc->key, tc->value, tc->size));
> +	if (TST_ERR == tc->exp_err) {
> +		tst_res(TPASS | TTERRNO, "expected behavior");
> +	} else {
> +		tst_res(TFAIL | TTERRNO, "unexpected behavior"
> +			"- expected errno %d - Got",
> +			tc->exp_err);
>  	}
> 
> -	cleanup();
> -	tst_exit();
> +	/* The last check:
> +	 *  Verify the attribute got by getxattr(2) is same as the value we set
> +	 */
> +	if (n == ARRAY_SIZE(tcases) - 1) {
Though ideally we separate the errno checking testcases and syscall success
tests in different test files.
But here we can simplify this using TST_EXP_* macros, maybe something like -

if (tc->exp_err == 0) {
	TST_EXP_VAL(getxattr(tc->fname, tc->key, tc->value, tc->size), XATTR_TEST_VALUE_SIZE);
	if (memcmp(tc->value, XATTR_TEST_VALUE, XATTR_TEST_VALUE_SIZE))
		tst_res(TFAIL, "Wrong value, expect \"%s\" got \"%s\"",
			XATTR_TEST_VALUE, tc->value);
	else
		tst_res(TPASS, "getxattr() retrieved expected value");
} else {
	TST_EXP_FAIL(getxattr(tc->fname, tc->key, tc->value, tc->size), tc->exp_err);
}

> +		if (TST_RET != XATTR_TEST_VALUE_SIZE)
> +			tst_res(TFAIL,
> +				"getxattr() returned wrong size %ld expected %d",
> +				TST_RET, XATTR_TEST_VALUE_SIZE);
> +
> +		if (memcmp(tc->value, XATTR_TEST_VALUE, XATTR_TEST_VALUE_SIZE))
> +			tst_res(TFAIL, "Wrong value, expect \"%s\" got \"%s\"",
> +					XATTR_TEST_VALUE, tc->value);
> +		else
> +			tst_res(TPASS, "Got the right value");
> +	}
>  }
> 
>  static void setup(void)
> @@ -144,41 +83,36 @@ static void setup(void)
>  	int fd;
>  	unsigned int i;
> 
> -	tst_require_root();
> -
> -	tst_tmpdir();
> -
>  	/* Create test file and setup initial xattr */
>  	snprintf(filename, BUFSIZ, "getxattr01testfile");
> -	fd = SAFE_CREAT(cleanup, filename, 0644);
> +	fd = SAFE_CREAT(filename, 0644);
>  	close(fd);
we can use SAFE_CLOSE()
> -	if (setxattr(filename, XATTR_TEST_KEY, XATTR_TEST_VALUE,
> -		     strlen(XATTR_TEST_VALUE), XATTR_CREATE) == -1) {
> -		if (errno == ENOTSUP) {
> -			tst_brkm(TCONF, cleanup, "No xattr support in fs or "
> -				 "mount without user_xattr option");
> -		}
> -	}
> 
> -	/* Prepare test cases */
> -	for (i = 0; i < ARRAY_SIZE(tc); i++) {
> -		tc[i].value = malloc(BUFFSIZE);
> -		if (tc[i].value == NULL) {
> -			tst_brkm(TBROK | TERRNO, cleanup,
> -				 "Cannot allocate memory");
> -		}
> -	}
> +	SAFE_SETXATTR(filename, XATTR_TEST_KEY, XATTR_TEST_VALUE,
> +		      strlen(XATTR_TEST_VALUE), XATTR_CREATE);
> 
> -	TEST_PAUSE;
> +	for (i = 0; i < ARRAY_SIZE(tcases); i++)
> +		tcases[i].value = SAFE_MALLOC(BUFFSIZE);
>  }
> 
>  static void cleanup(void)
>  {
> -	tst_rmdir();
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(tcases); i++)
> +		if (tcases[i].value != NULL)
> +			free(tcases[i].value);
>  }
> +
> +static struct tst_test test = {
> +	.needs_tmpdir = 1,
> +	.needs_root = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run,
> +};
> +
>  #else /* HAVE_SYS_XATTR_H */
> -int main(int argc, char *argv[])
> -{
> -	tst_brkm(TCONF, NULL, "<sys/xattr.h> does not exist.");
> -}
> +	TST_TEST_TCONF("<sys/xattr.h> does not exist.");
>  #endif

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
