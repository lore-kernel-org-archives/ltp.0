Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A003C3DA60
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 12:57:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 014CE3D1AFE
	for <ltp@archiver.kernel.org>; Thu, 18 Jul 2024 14:57:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C39503D1AD0
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 14:57:13 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 17E70201DA0
 for <ltp@lists.linux.it>; Thu, 18 Jul 2024 14:57:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 07F1D1F399;
 Thu, 18 Jul 2024 12:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721307431;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5EBrV7kxZbZsNudtXHwuTrsFGTE9k/bsTem0YWNNxnA=;
 b=FihNwiWjdd2RKeivk/QLxEUxkDuLgVQr+4BzYEmcaU00a/Fu7OF0t0+ELiFcnbNRuQltJi
 6Wgs2dDqof0Rp2EjIx7QAcGpL4WsIEds0g94++RZ4ypVjmLy8KjuRV0xn7ajxx3yd1FSUl
 y1xepSWxx2/9wzQJggiJEBOGZdMiMFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721307431;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5EBrV7kxZbZsNudtXHwuTrsFGTE9k/bsTem0YWNNxnA=;
 b=KfaMAh1ghaFkUFvMJxqNv5K9MKr7Ytm0IAJSf0mbGPEp27gfmDdBOKezPsXyP7yLJUml2N
 R7FlY1YAX8D3zcCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FihNwiWj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KfaMAh1g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721307431;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5EBrV7kxZbZsNudtXHwuTrsFGTE9k/bsTem0YWNNxnA=;
 b=FihNwiWjdd2RKeivk/QLxEUxkDuLgVQr+4BzYEmcaU00a/Fu7OF0t0+ELiFcnbNRuQltJi
 6Wgs2dDqof0Rp2EjIx7QAcGpL4WsIEds0g94++RZ4ypVjmLy8KjuRV0xn7ajxx3yd1FSUl
 y1xepSWxx2/9wzQJggiJEBOGZdMiMFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721307431;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5EBrV7kxZbZsNudtXHwuTrsFGTE9k/bsTem0YWNNxnA=;
 b=KfaMAh1ghaFkUFvMJxqNv5K9MKr7Ytm0IAJSf0mbGPEp27gfmDdBOKezPsXyP7yLJUml2N
 R7FlY1YAX8D3zcCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DA545136F7;
 Thu, 18 Jul 2024 12:57:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MwOHMyYRmWZxegAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 18 Jul 2024 12:57:10 +0000
Date: Thu, 18 Jul 2024 14:57:09 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240718125709.GB738326@pevik>
References: <20240716153604.22984-1-chrubis@suse.cz>
 <20240716153604.22984-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240716153604.22984-2-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 07F1D1F399
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/2] Add support for mixing C and shell code
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

Hi Cyril,

> This is a proof of a concept of a seamless C and shell integration. The
> idea is that with this you can mix shell and C code as much as as you
> wish to get the best of the two worlds.

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/tst_test.h                           | 38 +++++++++++++
>  lib/tst_test.c                               | 51 +++++++++++++++++
>  testcases/lib/.gitignore                     |  1 +
>  testcases/lib/Makefile                       |  4 +-
>  testcases/lib/run_tests.sh                   | 10 ++++
>  testcases/lib/tests/.gitignore               |  6 ++
>  testcases/lib/tests/Makefile                 | 11 ++++
>  testcases/lib/tests/shell_loader.sh          |  5 ++
>  testcases/lib/tests/shell_test01.c           | 17 ++++++
>  testcases/lib/tests/shell_test02.c           | 18 ++++++
>  testcases/lib/tests/shell_test03.c           | 25 +++++++++
>  testcases/lib/tests/shell_test04.c           | 18 ++++++
>  testcases/lib/tests/shell_test05.c           | 27 +++++++++
>  testcases/lib/tests/shell_test06.c           | 16 ++++++
FYI we have shell tests for new library in lib/newlib_tests (C tests) and
lib/newlib_tests/shell/ (shell tests), is it necessary to add new location? Or,
if you prefer this, we should move existing tests from lib/newlib_tests/shell/
to this new location.

Also, we have lib/newlib_tests/runtest.sh script, which runs currently only te
tests which exit 0 (TPASS or TCONF). Here are LTP_SHELL_API_TESTS listed.

Also we have test-shell target in the top level Makefile.

=> these tests (currently only these which exits 0) should be run by test-shell
and thus in CI.

Generally the approach LGTM.

>  	unsigned int needs_hugetlbfs:1;
> @@ -607,6 +612,39 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>   */
>  void tst_reinit(void);

> +/**
> + * tst_run_shell() - Prepare the environment and execute a shell script.
> + *
> + * @script_name: A filename of the script.
> + * @params: A NULL terminated array of shell script parameters, pass NULL if
> + *          none are needed. This what is passed starting from argv[1].
> + *
> + * The shell script is executed with LTP_IPC_PATH in environment so that the
> + * binary helpers such as tst_res_ or tst_checkpoint work properly when executed
> + * from the script. This also means that the tst_test.runs_shell flag needs to
> + * be set.
> + *
> + * The shell script itself has to source the tst_env.sh shell script at the
> + * start and after that it's free to use tst_res in the same way C code would
> + * use.
> + *
> + * Example shell script that reports success::
nit: double :

> + *
> + *   #!/bin/sh
> + *   . tst_env.sh
> + *
> + *   tst_res TPASS "Example test works"
> + *
> + * The call returns a pid in a case that you want to examine the return value
> + * of the script yourself. If you do not need to check the return value
> + * yourself you can use tst_reap_children() to wait for the completion. Or let
> + * the test library collect the child automatically, just be wary that the
> + * script and the test both runs concurently at the same time in this case.
> + *
> + * Return: A pid of the shell process.
> + */
> +int tst_run_shell(char *script_name, char *const params[]);
> +
>  unsigned int tst_multiply_timeout(unsigned int timeout);

>  /*
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index e5bc5bf4d..fa0907353 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -173,6 +173,52 @@ void tst_reinit(void)
>  	SAFE_CLOSE(fd);
>  }
...

> +int tst_run_shell(char *script_name, char *const params[])
> +{
> +	int pid;
> +	unsigned int i, params_len = params_array_len(params);
> +	char *argv[params_len + 2] = {};
As I noted, this is a problem for old gcc 7 (still used in 15-SP6).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
