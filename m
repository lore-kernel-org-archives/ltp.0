Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1CAC35FF3
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 08:16:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 578F03C2DF6
	for <ltp@archiver.kernel.org>; Tue, 17 Sep 2024 10:16:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2680B3C1BD4
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 10:16:26 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6D4D91A005E0
 for <ltp@lists.linux.it>; Tue, 17 Sep 2024 10:16:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8286D1FFC2;
 Tue, 17 Sep 2024 08:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726560983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JVr7GgvxugrZ1pu2aUB+hLutM4B8zWkQDlFRq4YbGzo=;
 b=kcAwzu/6Ugfb/eX5vgm7p6k3eOHVgyBMeuquNbwshsSQIVUHpV+puDIQg10TTPHwYmDP6B
 zCt/llX//EupxCDatOV5NnKmpMtaK/gPYuXhPSX4s+3NgMVf5v5Lf43rB4FSUQhQIQ0cu9
 q9wXfyqH6WF1Vqj+oe1D4Ny4uXum4cA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726560983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JVr7GgvxugrZ1pu2aUB+hLutM4B8zWkQDlFRq4YbGzo=;
 b=eYy9svAJgZPpmpfqELwMwrV6nTAlTGW3lOU1tuJcsfcBHQHrskdPxGM/lbAjf8dLqJ5WYA
 KmTMPa3K3xJxNHBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=C9l6AL+P;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FLQS6nDI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726560982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JVr7GgvxugrZ1pu2aUB+hLutM4B8zWkQDlFRq4YbGzo=;
 b=C9l6AL+P1BPIU52ILgqmEsyAlym3Swyz2BbCsh2reQ7UZ8Sbd8zEHGhrQOUy97GhbosAQH
 Wn54DhpJZR4r5JJywrOgoDkUoWMfBsPWKQB3XzAbl6a0Emclpd9Xz2aahMS2Mcaq/+ty1H
 TzpMct0WyDW/i16AFDauQ1Slz0NDJjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726560982;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JVr7GgvxugrZ1pu2aUB+hLutM4B8zWkQDlFRq4YbGzo=;
 b=FLQS6nDIOaLItyfKAn4feINQUHyExuqe+tGDMl6mQeiiuqAi/VPFyFYerUS/mINn71WwPk
 LssSFf7V5/tmrfDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70CD313AB6;
 Tue, 17 Sep 2024 08:16:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MXXKGtY66WYETQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 17 Sep 2024 08:16:22 +0000
Date: Tue, 17 Sep 2024 10:15:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
Message-ID: <Zuk6k_8ryjwZqpO9@yuki.lan>
References: <20240522060321.2223-1-maxj.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240522060321.2223-1-maxj.fnst@fujitsu.com>
X-Rspamd-Queue-Id: 8286D1FFC2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,linux.it:url,linux-test-project.readthedocs.io:url,fujitsu.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,yuki.lan:mid];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] rt_sigqueueinfo: Add negative tests for
 rt_sigqueueinfo
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
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
> + * Author: Ma Xinjian <maxj.fnst@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that rt_sigqueueinfo(2) fails with
> + *
> + * - EINVAL when sig is invalid
> + * - EPERM when uinfo->si_code is invalid
> + * - ESRCH when no thread group matching tgid is found
> + */
> +#include <pwd.h>
> +#include <signal.h>
> +#include "config.h"
> +#include "tst_test.h"
> +
> +#ifdef HAVE_STRUCT_SIGACTION_SA_SIGACTION
> +#include "rt_sigqueueinfo.h"
> +
> +static siginfo_t siginfo_einval;
> +static siginfo_t siginfo_eperm;
> +static siginfo_t siginfo_esrch;

Ideally these should be allocated as guarded buffers:

https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html#guarded-buffers

You can have a look at signalfd02.c and the .bufs in the tst_test
structure initialization.

> +static pid_t tgid_notfound = -1;
> +
> +static struct test_case_t {
> +	pid_t *tgid;
> +	int sig;
> +	siginfo_t *uinfo;
> +	int expected_errno;
> +	char *desc;
> +} tcases[] = {
> +	{NULL, -1, &siginfo_einval, EINVAL, "sig is invalid"},
> +	{NULL, SIGUSR1, &siginfo_eperm, EPERM, "uinfo->si_code is invalid"},
> +	{&tgid_notfound, SIGUSR1, &siginfo_esrch, ESRCH,
> +		"no thread group matching tgid is found"},
> +};
> +
> +static void setup(void)
> +{
> +	siginfo_einval.si_code = SI_QUEUE;
> +	siginfo_eperm.si_code = 0;
> +	siginfo_esrch.si_code = SI_QUEUE;
> +}
> +
> +static void sig_handler(int sig)
> +{
> +	tst_res(TINFO, "Receive signal %s(%d)", tst_strsig(sig), sig);
> +}
> +
> +static void parent_do(struct test_case_t *tc, pid_t pid)
> +{
> +	pid_t real_pid;
> +
> +	if (tc->tgid)
> +		real_pid = *(tc->tgid);
> +	else
> +		real_pid = pid;
> +
> +	TST_EXP_FAIL(sys_rt_sigqueueinfo(real_pid, tc->sig, tc->uinfo),
> +		tc->expected_errno, "%s", tc->desc);
> +	TST_CHECKPOINT_WAKE(1);
> +}
> +
> +static void child_do(struct test_case_t *tc)
> +{
> +	struct sigaction sa;
> +
> +	sa.sa_handler = sig_handler;
> +	SAFE_SIGEMPTYSET(&sa.sa_mask);
> +	if (tc->sig > 0)
> +		SAFE_SIGACTION(tc->sig, &sa, NULL);
> +	else
> +		SAFE_SIGACTION(SIGUSR1, &sa, NULL);
> +
> +	TST_CHECKPOINT_WAKE(0);
> +	TST_CHECKPOINT_WAIT(1);

The child will never get any signal so all that needs to be done here is
to do TST_CHECKPOINT_WAIT() so that the child exists while the parent
runs.

> +}
> +
> +static void verify_rt_sigqueueinfo(unsigned int i)
> +{
> +	struct test_case_t *tc = &tcases[i];
> +	pid_t pid = SAFE_FORK();
> +
> +	if (!pid) {
> +		child_do(tc);
> +		exit(0);
> +	}
> +	TST_CHECKPOINT_WAIT(0);
> +	parent_do(tc, pid);
> +	SAFE_WAITPID(pid, NULL, 0);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_rt_sigqueueinfo,
> +	.forks_child = 1,
> +	.needs_checkpoints = 1,
> +};
> +
> +#else
> +	TST_TEST_TCONF("This system does not support rt_sigqueueinfo()");
> +#endif /* HAVE_STRUCT_SIGACTION_SA_SIGACTION */
> -- 
> 2.39.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
