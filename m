Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA964C52D7B
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 15:35:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1F703D2125
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 17:35:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CABC53D2106
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 17:35:10 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=richiejp.com (client-ip=103.168.172.152;
 helo=fhigh1-smtp.messagingengine.com; envelope-from=io@richiejp.com;
 receiver=lists.linux.it)
Received: from fhigh1-smtp.messagingengine.com
 (fhigh1-smtp.messagingengine.com [103.168.172.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C3F321401184
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 17:35:08 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal
 [10.202.2.46])
 by mailfhigh.nyi.internal (Postfix) with ESMTP id 22822114AB51;
 Tue, 13 Aug 2024 11:35:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Tue, 13 Aug 2024 11:35:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richiejp.com; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1723563307; x=1723649707; bh=rL9/YzxJpH
 MFh/sddsuLMqbW0ppyUnvANJyEuw4IPbQ=; b=E8K25XExkJDKw3EsREqL3N329X
 0ZBtgsb2oeWH46jLGWic96vxeYqR9xv/kmmAdR/7TloRVO9iGkVcB06o4kK5nKK7
 NNvWXyC+ZMhdJd/7j7RhPYk4/asGCOPlxCFjZiar77TDpdmtuSAwrC6q/jYS2pc7
 Kuefac3QYTyICuMBNGXQk6rBxxayqaYWCCro+9BDbrelHR7blW4WBuhbv1BuMcAs
 xUX2XYODiIp+C4XxizCBD5LmwtcFz3pO0vP6/vpCxIuNZ//2bezLw82p5a9u8skt
 uUlNP2cKX3b+vquxFE/kGVs6lsTA3B6BAfnLjLY9PeEtKM0cH9Axs94ZWZjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1723563307; x=1723649707; bh=rL9/YzxJpHMFh/sddsuLMqbW0ppy
 UnvANJyEuw4IPbQ=; b=IrjZLlxcb9YO4QyxGdNGglX3C5JZyM36l5/4UTdQlDdV
 d7YhUT7kkg8fwtAG4gfgbUT1cofPycbe2myP3yXq+HJ4cdEJZadB8hluTPT5qpl5
 iYmD822biJOVUhHt1gW/rhdkpGiICeIiZXoI23X4RuxVbBDRGt2QysjE0rqxJZIa
 Nroz3VqcgX9Ls4W21TVrOSi/pkNfPRuDWiBXflsdHJsn/aGLxk+8RxMxZacopHvB
 pc4Ttv2yCxnxOlFzXZpubSvXL76f4j6Pn3HzDAWMJkycVrkdESNq6d0C29k9JhR/
 N5SwuVMLjGlgJ/sqIe8XmSU1CzbZ7VDQKIYCnrDMwg==
X-ME-Sender: <xms:Kn27Zrh9P4A07cPBK3c5NmhoaunMH5uaWAAC-7L67COkSRmWA5T5fQ>
 <xme:Kn27ZoDzkWM5f7JF7kqCTmPQ4A81HUzC2m19Ku1qExMZlszBove6wNATzm6Ub4iGR
 chbbKgGVEFdqedY>
X-ME-Received: <xmr:Kn27ZrEFSvfGB_UPmuWgpvfakCIcN-57tNG_TPlybO1vpmAcXKo8S_dUpSSNjGH_mCkl-XKFL8rv1qR21r_m3ap50pNZEvVPHn8sazYpXlzYaubKoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgkeekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefujghffffkgggtsehttdertddttddtnecu
 hfhrohhmpeftihgthhgrrhguucfrrghlvghthhhorhhpvgcuoehiohesrhhitghhihgvjh
 hprdgtohhmqeenucggtffrrghtthgvrhhnpedthfduffekueeukefhjefhleeihfevgefh
 vefggfehtddvleeltdetgeejgfegvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
 grmhepmhgrihhlfhhrohhmpehiohesrhhitghhihgvjhhprdgtohhmpdhnsggprhgtphht
 thhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlthhpsehlihhsthhsrd
 hlihhnuhigrdhithdprhgtphhtthhopegthhhruhgsihhssehsuhhsvgdrtgii
X-ME-Proxy: <xmx:Kn27ZoTesM13Q_5foG5gZFW9WtrV4AUNlWAQ98uY6FS75oDSoWkK0A>
 <xmx:Kn27ZowaLVLNMMf77uBMTi8WhSzfvs8EY10ouYYwGWtW048Cu-6FcQ>
 <xmx:Kn27Zu6xBOVujblc_Z-Y20bpJX4efZR-hHpUqq-By9mCVa55i7Caew>
 <xmx:Kn27Ztwn4Zi40yXXqFoup59Ih-T2jeYQpwECopsr2w6gUvIw0uQ6-w>
 <xmx:K327Zj9tVCJmqDsePIRChblkKCcRJ2Jz4j0W1M7zcMxREKuBktDCtK1S>
Feedback-ID: i12a14689:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 11:35:05 -0400 (EDT)
From: Richard Palethorpe <io@richiejp.com>
To: Cyril Hrubis <chrubis@suse.cz>
In-Reply-To: <20240731092017.8267-2-chrubis@suse.cz> (Cyril Hrubis's message
 of "Wed, 31 Jul 2024 11:20:15 +0200")
References: <20240731092017.8267-1-chrubis@suse.cz>
 <20240731092017.8267-2-chrubis@suse.cz>
Date: Tue, 13 Aug 2024 16:35:04 +0100
Message-ID: <87wmkksafr.fsf@richiejp.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] Add support for mixing C and shell code
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

Cyril Hrubis <chrubis@suse.cz> writes:

Hello Cyril,

In general I like the idea except that it will encourage more shell
usage, but I'm guessing that is a battle that has already been
lost. Also if a suitable embedded scripting language were found this is
a starting point for that.

> This is a proof of a concept of a seamless C and shell integration. The
> idea is that with this you can mix shell and C code as much as as you
> wish to get the best of the two worlds.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/tst_test.h                           | 38 +++++++++++++
>  lib/tst_test.c                               | 51 +++++++++++++++++
>  testcases/lib/.gitignore                     |  1 +
>  testcases/lib/Makefile                       |  4 +-
>  testcases/lib/run_tests.sh                   | 11 ++++
>  testcases/lib/tests/.gitignore               |  6 ++
>  testcases/lib/tests/Makefile                 | 11 ++++
>  testcases/lib/tests/shell_test01.c           | 17 ++++++
>  testcases/lib/tests/shell_test02.c           | 18 ++++++
>  testcases/lib/tests/shell_test03.c           | 25 +++++++++
>  testcases/lib/tests/shell_test04.c           | 18 ++++++
>  testcases/lib/tests/shell_test05.c           | 27 +++++++++
>  testcases/lib/tests/shell_test06.c           | 16 ++++++
>  testcases/lib/tests/shell_test_brk.sh        |  6 ++
>  testcases/lib/tests/shell_test_check_argv.sh | 23 ++++++++
>  testcases/lib/tests/shell_test_checkpoint.sh |  7 +++
>  testcases/lib/tests/shell_test_pass.sh       |  6 ++
>  testcases/lib/tst_env.sh                     | 21 +++++++
>  testcases/lib/tst_res_.c                     | 58 ++++++++++++++++++++
>  19 files changed, 362 insertions(+), 2 deletions(-)
>  create mode 100755 testcases/lib/run_tests.sh
>  create mode 100644 testcases/lib/tests/.gitignore
>  create mode 100644 testcases/lib/tests/Makefile
>  create mode 100644 testcases/lib/tests/shell_test01.c
>  create mode 100644 testcases/lib/tests/shell_test02.c
>  create mode 100644 testcases/lib/tests/shell_test03.c
>  create mode 100644 testcases/lib/tests/shell_test04.c
>  create mode 100644 testcases/lib/tests/shell_test05.c
>  create mode 100644 testcases/lib/tests/shell_test06.c
>  create mode 100755 testcases/lib/tests/shell_test_brk.sh
>  create mode 100755 testcases/lib/tests/shell_test_check_argv.sh
>  create mode 100755 testcases/lib/tests/shell_test_checkpoint.sh
>  create mode 100755 testcases/lib/tests/shell_test_pass.sh
>  create mode 100644 testcases/lib/tst_env.sh
>  create mode 100644 testcases/lib/tst_res_.c
>
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 6c76f043d..a334195ac 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -331,6 +331,8 @@ struct tst_fs {
>   * @child_needs_reinit: Has to be set if the test needs to call tst_reinit()
>   *                      from a process started by exec().
>   *
> + * @runs_script: Implies child_needs_reinit and forks_child at the moment.
> + *
>   * @needs_devfs: If set the devfs is mounted at tst_test.mntpoint. This is
>   *               needed for tests that need to create device files since tmpfs
>   *               at /tmp is usually mounted with 'nodev' option.
> @@ -518,6 +520,7 @@ struct tst_fs {
>  	unsigned int mount_device:1;
>  	unsigned int needs_rofs:1;
>  	unsigned int child_needs_reinit:1;
> +	unsigned int runs_script:1;

This could be a string constant instead of a flag if you want to future
proof against multiple scripting languages or you could change it to runs_shell.

>  	unsigned int needs_devfs:1;
>  	unsigned int restore_wallclock:1;
>  
> @@ -526,6 +529,8 @@ struct tst_fs {
>  	unsigned int skip_in_lockdown:1;
>  	unsigned int skip_in_secureboot:1;
>  	unsigned int skip_in_compat:1;
> +
> +
>  	int needs_abi_bits;
>  
>  	unsigned int needs_hugetlbfs:1;
> @@ -611,6 +616,39 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>   */
>  void tst_reinit(void);
>  
> +/**
> + * tst_run_shell() - Prepare the environment and execute a shell script.
> + *
> + * @script_name: A filename of the script.
> + * @params: A NULL terminated array of shell script parameters, pass NULL if
> + *          none are needed. This what is passed starting from argv[1].
> + *
> + * The shell script is executed with LTP_IPC_PATH in environment so that the
> + * binary helpers such as tst_res_ or tst_checkpoint work properly when executed
> + * from the script. This also means that the tst_test.runs_script flag needs to
> + * be set.
> + *
> + * The shell script itself has to source the tst_env.sh shell script at the
> + * start and after that it's free to use tst_res in the same way C code would
> + * use.
> + *
> + * Example shell script that reports success::
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
>  
>  /*
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index e5bc5bf4d..7e1075fdf 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -4,6 +4,8 @@
>   * Copyright (c) Linux Test Project, 2016-2024
>   */
>  
> +#define _GNU_SOURCE
> +
>  #include <limits.h>
>  #include <stdio.h>
>  #include <stdarg.h>
> @@ -173,6 +175,50 @@ void tst_reinit(void)
>  	SAFE_CLOSE(fd);
>  }
>  
> +extern char **environ;
> +
> +static unsigned int params_array_len(char *const array[])
> +{
> +	unsigned int ret = 0;
> +
> +	if (!array)
> +		return 0;
> +
> +	while (*(array++))
> +		ret++;
> +
> +	return ret;
> +}
> +
> +int tst_run_shell(char *script_name, char *const params[])
script_name should really be const as this is an API
> +{
> +	int pid;
> +	unsigned int i, params_len = params_array_len(params);
> +	char *argv[params_len + 2];
> +
> +	if (!tst_test->runs_script)
> +		tst_brk(TBROK, "runs_script flag must be set!");
> +
> +	argv[0] = script_name;
maybe you'd have to cast it here or something, but IMO worth it

Reviewed-by: Richard Palethorpe <io@richiejp.com>

-- 
Thank you,
Richard,
richiejp.com.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
