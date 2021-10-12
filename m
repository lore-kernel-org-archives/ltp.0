Return-Path: <SRS0=5AcX=PA=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E740C433F5
	for <ltp@archiver.kernel.org>; Tue, 12 Oct 2021 09:21:29 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E41761056
	for <ltp@archiver.kernel.org>; Tue, 12 Oct 2021 09:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3E41761056
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E48D83C0E2C
	for <ltp@archiver.kernel.org>; Tue, 12 Oct 2021 11:21:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 714D73C03AE
 for <ltp@lists.linux.it>; Tue, 12 Oct 2021 11:21:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E51FA6000E8
 for <ltp@lists.linux.it>; Tue, 12 Oct 2021 11:21:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CEE662216B;
 Tue, 12 Oct 2021 09:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1634030474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5YBgdQfb5CJfstTIJvH1c+VLjOdaOi058+pMf+F0kQ=;
 b=QYJ8Qye5jaghA8hCXOEChqbKNW6EyN5ZHl9DbzuTev8BOlb1PEmKXHUrtoQGxpPqGBnA1U
 NjPHZC7b0SuIikdhzYLZry406tNzcEEj8XP37xbSelk1idW35gJVjMsWY+8Ip08BYDI5MC
 2ZTbWumRvWILwVf43yKIP63wwUuWGKg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1634030474;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5YBgdQfb5CJfstTIJvH1c+VLjOdaOi058+pMf+F0kQ=;
 b=ps/9/p/Bq4gDgXyhb5CYaT2q3MlDPxG6hKc7ZA0ostv+mwGUt+u37GEqL5Hc2YWqdgB2Kj
 dHGvyT1hJjc20OAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B508B132D4;
 Tue, 12 Oct 2021 09:21:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0UTDKopTZWEMYwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 12 Oct 2021 09:21:14 +0000
Date: Tue, 12 Oct 2021 11:21:54 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: zhanglianjie <zhanglianjie@uniontech.com>
Message-ID: <YWVTsg3BLFwZRcl0@yuki>
References: <20210923085224.868-1-zhanglianjie@uniontech.com>
 <20210923085224.868-4-zhanglianjie@uniontech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210923085224.868-4-zhanglianjie@uniontech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/5] syscalls/clone06: Convert to new API
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
> -	cleanup();
> -	tst_exit();
> +	parent_env = getenv("TERM") ? : "";

I guess that it would make more sense to create a new variable than
depend on anything that may or may not be present on the system.

What about we setenv a variable instead and use that for the test?

#define ENV_VAL "LTP test variable value"
#define ENV_ID "LTP_CLONE_TEST"

static void setup(void)
{
	int ret;

	ret = setenv(ENV_ID, ENV_VAL, 0)
	if (ret)
		tst_brk(TBROK | TERRNO, "setenv() failed");

}


> +	TST_EXP_VAL(strcmp(buff, parent_env), 0,
> +				"verify environment variables by child");

Also there is no need to propagate the value to the parent like this,
the child process can report the result (in the new library) as well, so
this really could be as simple as:

static int do_child(void *arg LTP_ATTRIBUTE_UNUSED)
{
	const char *env_val = getenv(ENV_ID);

	if (!env_val) {
		tst_res(TFAIL, "Variable " ENV_ID " not defined in child");
		return;
	}

	if (strcmp(env_val, ENV_VAL)) {
		tst_res(TFAIL, "Variable value is different");
		return;
	}

	tst_res(TPASS, ...);
}

>  }
> 
>  static void setup(void)
>  {
> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> -	TEST_PAUSE;
> +	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
> +	buff = SAFE_MMAP(NULL, MAX_LINE_LENGTH, PROT_READ | PROT_WRITE,
> +			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>  }
> 
>  static void cleanup(void)
>  {
> -}
> -
> -/*
> - *	Function executed by child.
> - *	Gets the value for environment variable,TERM &
> - *	writes it to  a pipe.
> - */
> -static int child_environ(void)
> -{
> -
> -	char var[MAX_LINE_LENGTH];
> -
> -	/* Close read end from child */
> -	if ((close(pfd[0])) == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup, "close(pfd[0]) failed");
> -
> -	if ((sprintf(var, "%s", getenv("TERM") ? : "")) < 0)
> -		tst_resm(TWARN | TERRNO, "sprintf() failed");
> -
> -	if ((write(pfd[1], var, MAX_LINE_LENGTH)) == -1)
> -		tst_resm(TWARN | TERRNO, "write to pipe failed");
> -
> -	/* Close write end of pipe from child */
> -	if ((close(pfd[1])) == -1)
> -		tst_resm(TWARN | TERRNO, "close(pfd[1]) failed");
> +	free(child_stack);
> 
> -	exit(0);
> +	if (buff)
> +		SAFE_MUNMAP(buff, MAX_LINE_LENGTH);
>  }
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test_all = verify_clone,
> +	.cleanup = cleanup,
> +};
> --
> 2.20.1
> 
> 
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
