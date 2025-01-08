Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52504E77188
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 12:40:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE0623C1B9A
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 13:40:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DA233C02C2
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 13:39:54 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6D038102786E
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 13:39:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9415C1F385;
 Wed,  8 Jan 2025 12:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736339991;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P1M+iIl4tmWkR7b/tBjNT0dqWOCqAe5ojZXvNvvkEJw=;
 b=rpKwmaCVu/jAJeDLf6SlAAjYImpBiceVTsZ/t+DMC/U0WghiK0uDMTAEC5VAMlQxS/W23Q
 EycTd6dSHkYH1DKf208Puh778tr9mYPxrgxw/lN3N9jzMq6HpLLas86j+c4DWp+SQT6Qin
 diB9xzpJAqhHQiHjPqsb0/YQayofkpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736339991;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P1M+iIl4tmWkR7b/tBjNT0dqWOCqAe5ojZXvNvvkEJw=;
 b=9MBFrGubT7XB9CEHsxptnmpftxdlyzprwiJJiwZk83PMxCqwDtPTIY+3hxPUl1ouVKAEHD
 jy0bCKp8/ESGM0Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1736339991;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P1M+iIl4tmWkR7b/tBjNT0dqWOCqAe5ojZXvNvvkEJw=;
 b=rpKwmaCVu/jAJeDLf6SlAAjYImpBiceVTsZ/t+DMC/U0WghiK0uDMTAEC5VAMlQxS/W23Q
 EycTd6dSHkYH1DKf208Puh778tr9mYPxrgxw/lN3N9jzMq6HpLLas86j+c4DWp+SQT6Qin
 diB9xzpJAqhHQiHjPqsb0/YQayofkpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1736339991;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P1M+iIl4tmWkR7b/tBjNT0dqWOCqAe5ojZXvNvvkEJw=;
 b=9MBFrGubT7XB9CEHsxptnmpftxdlyzprwiJJiwZk83PMxCqwDtPTIY+3hxPUl1ouVKAEHD
 jy0bCKp8/ESGM0Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76DBE1351A;
 Wed,  8 Jan 2025 12:39:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wgqHGxdyfmeUJQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 08 Jan 2025 12:39:51 +0000
Date: Wed, 8 Jan 2025 13:39:46 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250108123946.GA27248@pevik>
References: <20250106-fix_setsid_tests-v2-0-c43f57a2bab6@suse.com>
 <20250106-fix_setsid_tests-v2-9-c43f57a2bab6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250106-fix_setsid_tests-v2-9-c43f57a2bab6@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 09/11] Refactor pty01 test
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

Hi Andrea,

> Rewrite part of the code using the new LTP library and fix the execution
> of the test inside a new session via setsid(). The test is now split
> into multiple files, instead of having multiple test* functions
> executing all in one file.

> Fixes: https://github.com/linux-test-project/kirk/issues/28
+1

> +++ b/testcases/kernel/pty/pty01.c
...
> +#define STRING_LEN strlen(STRING)
IMHO this is not much useful, it runs strlen() more times.
How about save the result in the test function to size_t variable?

...
> +static void run(void)
>  {
> -	int masterfd;		/* master pty fd */
> -	int slavefd;		/* slave pty fd */
> +	int masterfd;
> +	int slavefd;
>  	char *slavename;
>  	struct stat st;
> -	char buf[TESTSIZE];
> +	char buf[BUFSIZ];

> -	masterfd = SAFE_OPEN(NULL, MASTERCLONE, O_RDWR);
> +	memset(buf, 0, BUFSIZ);

> -	slavename = ptsname(masterfd);
> -	if (slavename == NULL) {
> -		tst_brkm(TBROK | TERRNO, NULL, "ptsname() call failed");
> -	}
> +	masterfd = SAFE_OPEN(MASTERCLONE, O_RDWR);
> +	slavename = SAFE_PTSNAME(masterfd);

These two should be in the setup() as Cyril noted to other tests.

> -	if (grantpt(masterfd) != 0) {
> -		tst_brkm(TBROK | TERRNO, NULL, "grantpt() call failed");
> -	}
> +	if (grantpt(masterfd) == -1)
> +		tst_brk(TBROK | TERRNO, "grantpt() error");

> -	if (stat(slavename, &st) != 0) {
> -		tst_brkm(TBROK | TERRNO, NULL, "stat(%s) failed", slavename);
> -	}
> -	if (st.st_uid != getuid()) {
> -		tst_brkm(TBROK, NULL, "uid mismatch");
> +	TST_EXP_PASS_SILENT(unlockpt(masterfd));
> +	if (TST_RET == -1) {
> +		SAFE_CLOSE(masterfd);
> +		return;
If you have this in the cleanup() as Cyril suggested for other test, there would
be a simple return.

> +	SAFE_STAT(slavename, &st);
> +	TST_EXP_EQ_LI(st.st_uid, getuid());
> +
> +	/* grantpt() is a no-op in bionic. */
>  #ifndef __BIONIC__
> -	if (st.st_mode != (S_IFCHR | S_IRUSR | S_IWUSR | S_IWGRP)) {
> -		tst_brkm(TBROK, NULL, "mode mismatch (mode=%o)", st.st_mode);
> -	}
> +	TST_EXP_EQ_LI(st.st_mode, 0620);

Here it continues testing, does it makes sense? Previously it quit with
tst_brkm().

> +static void setup(void)
>  {
> +	if (access(MASTERCLONE, F_OK))
> +		tst_brk(TBROK, "%s device doesn't exist", MASTERCLONE);

IMHO this should be TCONF (SUT is not configured to have /dev/ptmx.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
