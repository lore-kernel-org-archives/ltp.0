Return-Path: <SRS0=Ux39=O7=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCE0C433EF
	for <ltp@archiver.kernel.org>; Mon, 11 Oct 2021 15:39:52 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B590860E52
	for <ltp@archiver.kernel.org>; Mon, 11 Oct 2021 15:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B590860E52
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2BE83C0BC3
	for <ltp@archiver.kernel.org>; Mon, 11 Oct 2021 17:39:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 201783C0302
 for <ltp@lists.linux.it>; Mon, 11 Oct 2021 17:39:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0E85F1001264
 for <ltp@lists.linux.it>; Mon, 11 Oct 2021 17:39:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 35E9F21F3D;
 Mon, 11 Oct 2021 15:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633966778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W9ggMcngfDMG/UbAUUFJsK2shpx6MheUsy6sTKt63/0=;
 b=EAPBnU0MRN1Icq82fPd33hi5Xt3MqvpSkCICSss+T6DZMwkX2ROqVyDRFpF/VbJ6dN0EB+
 wUFc6HW5trx3kue6qcQDn+lQgE2gmad8gXsw4SH7JBzaGXeppALiSGmu3bYTaplGZLi3oY
 h6gd6FVQwWHzxgwn4ibWUWleHvWdg9k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633966778;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W9ggMcngfDMG/UbAUUFJsK2shpx6MheUsy6sTKt63/0=;
 b=QQceTVoD4NxUBQ/mzStT8uxtOOUlkWsi/Es7lyJQATzbcbEbx8w/ABGPa5grVEU+hnFUBX
 WolGyEXQNYQup5Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E51213BCB;
 Mon, 11 Oct 2021 15:39:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id A1c5B7paZGEiVwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 11 Oct 2021 15:39:38 +0000
Date: Mon, 11 Oct 2021 17:40:17 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: zhanglianjie <zhanglianjie@uniontech.com>
Message-ID: <YWRa4VvL33YclVX3@yuki>
References: <20210923085224.868-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210923085224.868-1-zhanglianjie@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/5] syscalls/clone02: Convert to new API
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

Hi!
> -/*
> - * test_SIG() - This function changes the signal handler for SIGUSR2
> - *		signal for child. If CLONE_SIGHAND flag is set, this
> - *		affects parent also.
> - */
> -static int test_SIG(void)
> +static void verify_clone(void)
>  {
> +	TST_EXP_PID_SILENT(ltp_clone(tcases[tst_variant].flags, child_fn, NULL,
> +				CHILD_STACK_SIZE, child_stack));
> 
> -	struct sigaction new_act;
> +	if (!TST_PASS)
> +		return;
> 
> -	new_act.sa_handler = sig_child_defined_handler;
> -	new_act.sa_flags = SA_RESTART;
> -	sigemptyset(&new_act.sa_mask);
> -
> -	/* Set signal handler to sig_child_defined_handler */
> -	if (sigaction(SIGUSR2, &new_act, NULL) == -1) {
> -		tst_resm(TWARN | TERRNO, "signal failed in test_SIG");
> -		return -1;
> -	}
> -
> -	/* Send SIGUSR2 signal to parent */
> -	if (kill(getppid(), SIGUSR2) == -1) {
> -		tst_resm(TWARN | TERRNO, "kill failed in test_SIG");
> -		return -1;
> -	}
> +	tst_reap_children();
> 
> -	return 0;
> +	TST_EXP_PASS(tcases[tst_variant].parent_fn(), "%s", tcases[tst_variant].desc);

Can we, instead of this, print PASS/FAIL for each check we do, so that
if something fails the log explains what exactly has failed?

>  }
> 
> -/*
> - * modified_VM() - This function is called by parent process to check
> - *		   whether child's modification to parent_variable
> - *		   is visible to parent
> - */
> -
> -static int modified_VM(void)
> -{
> -
> -	if (parent_variable == CHILD_VALUE)
> -		/* child has modified parent_variable */
> -		return 1;
> -
> -	return 0;
> -}
> 
> -/*
> - * modified_FILES() - This function checks for file descriptor table
> - *		      modifications done by child
> - */
> -static int modified_FILES(void)
> +static void cleanup(void)
>  {
> -	char buff[20];
> +	SAFE_CHDIR(cwd_parent);
> +	SAFE_UNLINK(TESTFILE);
> +	SAFE_RMDIR(cwd_child);
> 
> -	if (((read(fd_parent, buff, sizeof(buff))) == -1) && (errno == EBADF))
> -		/* Child has closed this file descriptor */
> -		return 1;
> -
> -	/* close fd_parent */
> -	if ((close(fd_parent)) == -1)
> -		tst_resm(TWARN | TERRNO, "close() failed in modified_FILES()");
> -
> -	return 0;
> +	free(cwd_parent);
> +	free(child_stack);
>  }
> 
> -/*
> - * modified_FS() - This function checks parent's current working directory
> - *		   to see whether its modified by child or not.
> - */
> -static int modified_FS(void)
> +static void setup(void)
>  {
> -	char cwd[FILENAME_MAX];
> -
> -	if ((getcwd(cwd, sizeof(cwd))) == NULL)
> -		tst_resm(TWARN | TERRNO, "getcwd() failed");
> +	struct sigaction def_act;
> 
> -	if (!(strcmp(cwd, cwd_parent)))
> -		/* cwd hasn't changed */
> -		return 0;
> +	/* Save current working directory of parent */
> +	cwd_parent = tst_get_tmpdir();
> 
> -	return 1;
> -}
> +	/*
> +	 * Set value for parent_variable in parent, which will be
> +	 * changed by child for testing CLONE_VM flag
> +	 */
> +	parent_variable = PARENT_VALUE;
> 
> -/*
> - * modified_SIG() - This function checks whether child has changed
> - *		    parent's signal handler for signal, SIGUSR2
> - */
> -static int modified_SIG(void)
> -{
> +	/*
> +	 * Open file from parent, which will be closed by
> +	 * child, used for testing CLONE_FILES flag
> +	 */
> +	fd_parent = SAFE_OPEN(TESTFILE, O_CREAT | O_RDWR, 0777);
> 
> -	if (parent_got_signal)
> -		/*
> -		 * parent came through sig_child_defined_handler()
> -		 * this means child has changed parent's handler
> -		 */
> -		return 1;
> +	/*
> +	 * set parent_got_signal to 0, used for testing
> +	 * CLONE_SIGHAND flag
> +	 */
> +	parent_got_signal = 0;

We have to make sure we reset the $PWD, variable, got_signal flag and
open() the file before each test iteration otherwise the test will fail
on subsequent iterations with -i 2 command line parameter.

> -	return 0;
> -}
> +	def_act.sa_handler = sig_parent_default_handler;
> +	def_act.sa_flags = SA_RESTART;
> +	SAFE_SIGEMPTYSET(&def_act.sa_mask);
> +	SAFE_SIGACTION(SIGUSR2, &def_act, NULL);
> 
> -/*
> - * sig_child_defined_handler()  - Signal handler installed by child
> - */
> -static void sig_child_defined_handler(int pid)
> -{
> -	if ((syscall(__NR_gettid)) == child_pid)
> -		/* Child got signal, give warning */
> -		tst_resm(TWARN, "Child got SIGUSR2 signal");
> -	else
> -		parent_got_signal = TRUE;
> +	SAFE_MKDIR(TESTDIR, 0777);
> +	sprintf(cwd_child, "%s/%s", cwd_parent, TESTDIR);
> +	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);

Can we use the guarded buffer instead of MALLOC in this test as well?
Just as we do in clone01.c now.

>  }
> 
> -/* sig_default_handler() - Default handler for parent */
> -static void sig_default_handler(void)
> -{
> -}
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_variants = ARRAY_SIZE(tcases),

This should rather be .tcnt and .test = verify_clone instead of
variants.

Test variants are usually used when the whole test is exactly same but
the TEST_*() function calls different variant of the syscall instead.

> +	.test_all = verify_clone,
> +	.needs_tmpdir = 1,
> +};

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
