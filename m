Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE3AC3DA7F
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 16:44:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC8F63D1FD8
	for <ltp@archiver.kernel.org>; Mon,  5 Aug 2024 18:44:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE6A53D0817
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 18:43:56 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 183F31400990
 for <ltp@lists.linux.it>; Mon,  5 Aug 2024 18:43:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7D70421BBD;
 Mon,  5 Aug 2024 16:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722876234;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gfW3vC/l8PNvbUrgE3aztKf4I6H56liyfUaer6AAaM8=;
 b=2Gxsb/9FdDJ6/LhzS0/4xcyw9cEi/z6+9wSxVvMNW7epqwHXwQwBL2Kf1b0G5edVhHpzHh
 m26PEzZCma9Dh6No1D0xfKVd18K9JQPc0kZj05wvb5wAiLMHdAXKWxEBv2YYyNnBRGw3zO
 Tn/9/w+HNnylMLSG04mjc4cfKsMEqVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722876234;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gfW3vC/l8PNvbUrgE3aztKf4I6H56liyfUaer6AAaM8=;
 b=Ozk+xoyMyTNZS/qBP1/T73HdMLZmxvtfRAbuaY/jWDS5qfSyKbdbush/CoBDEG4K+kGE1q
 jrEchdPC5PD+ucAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722876233;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gfW3vC/l8PNvbUrgE3aztKf4I6H56liyfUaer6AAaM8=;
 b=o1RbPhQKCJ5IXP9eBF57Kzmuk92a8aXjc0qITTQ7IWDeKzQxh9hqIeasMCBTs750Bo8IFx
 NHWuXrdYFf0GJAZ22ED7zhpxApxUJPcbbvzQsgKIBkk6bqW5OrVjMF3YsIzCh8sbcQz7u+
 nVQbQ1SG1c49vlTU4lQE3VvbmI3fTnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722876233;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gfW3vC/l8PNvbUrgE3aztKf4I6H56liyfUaer6AAaM8=;
 b=7h2L7twt5WzlqCao7rWl9ZuzBNGKqTtWj03ibSTxmBdJ7dD2pVrARuu7oebgfQCiGU6iEr
 jBHA/hN2b2VbTBDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 521F713254;
 Mon,  5 Aug 2024 16:43:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ekzwEkkBsWY6dgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 Aug 2024 16:43:53 +0000
Date: Mon, 5 Aug 2024 18:43:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20240805164348.GA53089@pevik>
References: <20240805092219.2659302-1-maxj.fnst@fujitsu.com>
 <2d414c20-ab82-41d5-8490-335dd0134755@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2d414c20-ab82-41d5-8490-335dd0134755@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] getcpu: Add testcase for EFAULT
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

> Hi!

> On 8/5/24 11:22, Ma Xinjian via ltp wrote:
> > Add a testcase with the arguments point to an invalid address.

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> > Signed-off-by: Ma Xinjian <maxj.fnst@fujitsu.com>
> > ---
> >   runtest/syscalls                            |  1 +
> >   testcases/kernel/syscalls/getcpu/getcpu02.c | 97 +++++++++++++++++++++
> >   2 files changed, 98 insertions(+)
> >   create mode 100644 testcases/kernel/syscalls/getcpu/getcpu02.c

> > diff --git a/runtest/syscalls b/runtest/syscalls
> > index b8728c1c5..1537b5022 100644
> > --- a/runtest/syscalls
> > +++ b/runtest/syscalls
> > @@ -448,6 +448,7 @@ futimesat01 futimesat01
> >   getcontext01 getcontext01
> >   getcpu01 getcpu01
> > +getcpu02 getcpu02
> >   getcwd01 getcwd01
> >   getcwd02 getcwd02
> > diff --git a/testcases/kernel/syscalls/getcpu/getcpu02.c b/testcases/kernel/syscalls/getcpu/getcpu02.c
> > new file mode 100644
> > index 000000000..f32660ef9
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/getcpu/getcpu02.c
> > @@ -0,0 +1,97 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
> > + * Copyright (c) Linux Test Project, 2024
> > + * Author: Ma Xinjian <maxj.fnst@fujitsu.com>
> > + *
> > + */
> > +
> > +/*\
> > + * [Description]
> > + *
> > + * Verify that getcpu(2) fails with
> > + *
> > + * - EFAULT arguments point outside the calling process's address
> > + *          space.
> We can squeeze the description in one single line since EFAULT is the only
> one we are gonna test.

Good point. As Andrea suggested to use .tcnt, defining 2 testcases with
different getcpu() input values, these two would deserve to be described.

Also it'd be nice to add some tst_res(TINFO, ...) description in the testing
function (similar to one above in /*\.

Kind regards,
Petr

> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include <errno.h>
> > +#include <sys/resource.h>
> > +#include <sys/time.h>
> > +#include <sys/wait.h>
> > +#include <stdlib.h>
> tst_test.h is importing these already.
> > +
> > +#include "tst_test.h"
> > +#include "lapi/sched.h"
> > +
> > +static void *bad_addr;
> > +
> > +static void setup(void)
> > +{
> > +	bad_addr = tst_get_bad_addr(NULL);
> > +}
> > +
> > +static void check_bad_cpu_id(void *bad_addr, unsigned int *node_id)
> > +{
> > +	int status;
> > +	pid_t pid;
> > +
> > +	pid = SAFE_FORK();
> > +	if (!pid) {
> > +		TST_EXP_FAIL(getcpu(bad_addr, node_id), EFAULT);
> > +
> > +		exit(0);
> > +	}
> > +
> > +	SAFE_WAITPID(pid, &status, 0);
> > +
> > +	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
> > +		tst_res(TPASS, "getcpu() caused SIGSEGV");
> > +		return;
> > +	}
> > +
> > +	if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
> > +		return;
> > +
> > +	tst_res(TFAIL, "child %s", tst_strstatus(status));
> > +}
> > +
> > +static void check_bad_node_id(unsigned int *cpu_id, void *bad_addr)
> > +{
> > +	int status;
> > +	pid_t pid;
> > +
> > +	pid = SAFE_FORK();
> > +	if (!pid) {
> > +		TST_EXP_FAIL(getcpu(cpu_id, bad_addr), EFAULT);
> > +
> > +		exit(0);
> > +	}
> > +
> > +	SAFE_WAITPID(pid, &status, 0);
> > +
> > +	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV) {
> > +		tst_res(TPASS, "getcpu() caused SIGSEGV");
> > +		return;
> > +	}
> > +
> > +	if (WIFEXITED(status) && WEXITSTATUS(status) == 0)
> > +		return;
> > +
> > +	tst_res(TFAIL, "child %s", tst_strstatus(status));
> > +}

These two testing functions are nearly the same, only parameters are different.
How about creating a single function and just pass a different params?
Also, only bad_addr and one of the functions holding "0" as id is needed.
> > +
> > +static void run_test(void)
> > +{
> > +	unsigned int cpu_id, node_id = 0;
> > +
> > +	check_bad_cpu_id(bad_addr, &node_id);
> > +	check_bad_node_id(&cpu_id, bad_addr);

> Here we can use .test/.tcnt , defining 2 testcases with different getcpu()
> input values.
+1

NOTE: sometimes we create struct tcase, but it'd be overkill for these 2
functions.

Kind regards,
Petr

> > +}
> > +
> > +static struct tst_test test = {
> > +	.setup = setup,
> > +	.test_all = run_test,
> > +	.forks_child = 1,
> > +};

> Best regards,
> Andrea Cervesato

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
