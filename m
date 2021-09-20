Return-Path: <SRS0=cJ4o=OK=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B95C433F5
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 07:53:15 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7642C60F6E
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 07:53:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7642C60F6E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E97B3C871A
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 09:53:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BBE233C21F8
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 09:53:01 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1AD9F600103
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 09:53:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 49FDF2003A;
 Mon, 20 Sep 2021 07:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632124380;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TYaJGXvrx6xJcAppyiC6g+uBZbmNOk3LJyheJzw49yk=;
 b=t667NROIvfplFUekqOO+xJdUkEA5pN1bisBWKQqBYCUXlpNqlu45TxlxYjy4Wg3kGeULmk
 3+831VYn883KTJ4Yt46AhjPvceegbX8+lyC+kQdp+zbk+cttS+HD3rhEtePMOLMbLH2xF5
 gssikDegK2JNKytKrY9mq1nas+QNTRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632124380;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TYaJGXvrx6xJcAppyiC6g+uBZbmNOk3LJyheJzw49yk=;
 b=vhqWK+5xK7xgxEtXNV4dgP8I9wOA+QKN/4ktAgwJoTpwg3xOXsFtBdxjUFvqrm+pVnZ06S
 0EUxLNrlQ5cHMvCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 174C113ACC;
 Mon, 20 Sep 2021 07:52:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id B1i5Ods9SGEZCQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 20 Sep 2021 07:52:59 +0000
Date: Mon, 20 Sep 2021 09:52:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YUg92YO7x1wQO/qD@pevik>
References: <20210917141719.5739-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210917141719.5739-1-chrubis@suse.cz>
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

> There were actually several races in the shell library timeout handling.

> This commit fixes hopefully all of them by:

> * Reimplementing the backgroud timer in C
+1

> * Making sure that the timer has started before we leave test setup
+1

> The rewrite of the backround timer to C allows us to run all the timeout
> logic in a single process, which simplifies the whole problem greatly
> since previously we had chain of processes that estabilished signal
> handlers to kill it's descendants, which in the end had a few races in
> it.

> The race that caused the problems is, as far as I can tell, in the way
> how shell spawns it's children. I haven't checked the shell code, but I
> guess that when shell runs a process in bacground it does vfork() +
> exec() and because signals are ignored during the operation. If the
> SIGTERM arrives at that point it gets lost.

> That means that we created a race window in the shell library each time
> we started a new process. The rewrite to C simplifies the code but we
> still end up with a single place where this can happen and that is when
> we execute the tst_timeout_kill binary. This is now fixed in the shell
> library by waiting until the background process gets to a sleep state,
> which means that the proces has been executed and waiting for the
> timeout.

> After these fixes I haven't been able to reproduce the hang with:

> cat > debug.sh <<EOF
> #!/bin/sh

> TST_SETUP="setup"
> TST_TESTFUNC="do_test"
> . tst_test.sh

> setup()
> {
>         tst_brk TCONF "quit now!"
> }

> do_test()
> {
>         tst_res TPASS "pass :)"
> }

> tst_run
> EOF

> # while true; do ./debug.sh; done
I verified it's ok on both VM which were previously affected.

After release I might write a test for tst_timeout_kill.c.
Thanks for fixing it!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
