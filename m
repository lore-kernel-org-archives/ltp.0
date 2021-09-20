Return-Path: <SRS0=cJ4o=OK=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B134CC433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 07:36:23 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A1161074
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 07:36:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 08A1161074
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B353A3C8728
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 09:36:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C01983C1B0A
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 09:36:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0D5AF600445
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 09:36:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 97CC621C5D;
 Mon, 20 Sep 2021 07:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632123369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O/OlppgiBwuWQIu8PBQK0+agcP77WeOmg1ZRG3T1K4E=;
 b=JVUTkFUfnUBEMiyY1eFiHBzMP7rHSL7VjJHsDj+xA4jqRqv4x1bmmsF5zeVqJ8cHIIACyO
 uxk3/iAaMkfEvQQ9mw9GOzCv3La4CZLxtaiwBQ/Izp/9OcJkkluyPxQg7Pa1xWD+3uvJV6
 XlCd4pTYlZPrsXQNCOxpG2Vlr9HJCfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632123369;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O/OlppgiBwuWQIu8PBQK0+agcP77WeOmg1ZRG3T1K4E=;
 b=1Z8jrvdVdaSJwnHQ1+Iyzdn1L1smycN5lIiubTalJpzDTdYU8Pvs9TyOsmlLYLqTD3uXnA
 sZGuv1R9s+m3QhAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 569F213ADA;
 Mon, 20 Sep 2021 07:36:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bFQXFOg5SGGOfgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 20 Sep 2021 07:36:08 +0000
Date: Mon, 20 Sep 2021 09:36:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <YUg6BM39OKgI5Ovl@yuki>
References: <20210917141719.5739-1-chrubis@suse.cz>
 <01fb50a1-8edb-77ac-fba4-b70965022b3f@jv-coder.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <01fb50a1-8edb-77ac-fba4-b70965022b3f@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [RFC] lib: shell: Fix timeout process races
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
> > There were actually several races in the shell library timeout handling.
> >
> > This commit fixes hopefully all of them by:
> >
> > * Reimplementing the backgroud timer in C
> I did that once, but at that point it was kinda rejected ;)
> See https://lists.linux.it/pipermail/ltp/2021-May/022445.html
> and https://lists.linux.it/pipermail/ltp/2021-May/022453.html

I guess we found out the hard way that it's impossible to write raceless
timeouts in shell.

> > +	tst_timeout_kill $sec $pid &
> >   
> >   	_tst_setup_timer_pid=$!
> > +
> > +	while true; do
> > +		local state
> > +
> > +		state=$(cut -d' ' -f3 "/proc/$_tst_setup_timer_pid/stat")
> Hmm maybe we could use the checkpoint api here instead. Wouldn't this be 
> more portable?

Well there are other tests in LTP that depend on the /proc/$PID/stat
already and I do not remmeber any bugreports about it being broken or
not available. Linux generally does not work without /proc/ being
mounted anyways.

I wanted to avoid checkpoints because that requires shared memory and
it's more complex to setup and if we add it here it would be set up by
every shell process, but maybe that's not that bad. Maybe we should
set up the piece of shared memory as we do in C and use it for the
result counter as well. But anyways that is orthogonal from the fixes
here and could be done later on.

> > +
> > +		if [ "$state" = "S" ]; then
> > +			break;
> > +		fi
> > +
> > +		tst_sleep 1ms
> > +	done
> >   }
> >   
> >   tst_require_root()
> > diff --git a/testcases/lib/tst_timeout_kill.c b/testcases/lib/tst_timeout_kill.c
> > new file mode 100644
> > index 000000000..6e97514f1
> > --- /dev/null
> > +++ b/testcases/lib/tst_timeout_kill.c
> > @@ -0,0 +1,93 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2021 Cyril Hrubis <chrubis@suse.cz>
> > + */
> > +
> > +#include <stdio.h>
> > +#include <signal.h>
> > +#include <stdlib.h>
> > +#include <unistd.h>
> > +#include <tst_res_flags.h>
> > +#include <tst_ansi_color.h>
> > +
> > +static void print_help(const char *name)
> > +{
> > +	fprintf(stderr, "usage: %s timeout pid\n", name);
> > +}
> > +
> > +static void print_msg(int type, const char *msg)
> > +{
> > +	const char *strtype = "";
> > +
> > +	switch (type) {
> > +	case TBROK:
> > +		strtype = "TBROK";
> > +	break;
> > +	case TINFO:
> > +		strtype = "TINFO";
> > +	break;
> > +	}
> > +
> > +	if (tst_color_enabled(STDERR_FILENO)) {
> > +		fprintf(stderr, "%s%s: %s%s\n", tst_ttype2color(type),
> > +			strtype, ANSI_COLOR_RESET, msg);
> > +	} else {
> > +		fprintf(stderr, "%s: %s\n", strtype, msg);
> > +	}
> > +}
> Shouldn't this be reused from the library instead of being reimplemented?

I wanted to avoid calling the tst_res() functions to keep things simple,
but I guess that there is no reason not to use it.

> > +
> > +int main(int argc, char *argv[])
> > +{
> > +	int timeout, pid, ret, i;
> > +
> > +	if (argc != 3) {
> > +		print_help(argv[0]);
> > +		return 1;
> > +	}
> > +
> > +	timeout = atoi(argv[1]);
> > +	pid = atoi(argv[2]);
> > +
> > +	if (timeout < 0) {
> > +		fprintf(stderr, "Invalid timeout '%s'", argv[1]);
> > +		print_help(argv[0]);
> > +		return 1;
> > +	}
> > +
> > +	if (pid <= 1) {
> > +		fprintf(stderr, "Invalid pid '%s'", argv[2]);
> > +		print_help(argv[0]);
> > +		return 1;
> > +	}
> > +
> > +	if (timeout)
> > +		sleep(timeout);
> > +
> > +	print_msg(TBROK, "Test timed out, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1");
> > +
> > +	ret = kill(-pid, SIGTERM);
> > +	if (ret) {
> > +		print_msg(TBROK, "kill() failed");
> > +		return 1;
> > +	}
> > +
> > +	usleep(100000);
> > +
> > +	i = 10;
> > +
> > +	while (!kill(-pid, 0) && i-- > 0) {
> This was kill(pid, 0) in the original shell code. I am not sure if it is 
> important

I think that this is better this way since this should loop until there
is at least one process alive in the process group.

> > +		print_msg(TINFO, "Test is still running...");
> > +		sleep(1);
> > +	}
> > +
> > +	if (!kill(-pid, 0)) {
> Here as well
> > +		print_msg(TBROK, "Test is still running, sending SIGKILL");
> > +		ret = kill(-pid, SIGKILL);
> > +		if (ret) {
> > +			print_msg(TBROK, "kill() failed");
> > +			return 1;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> 
> Joerg

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
