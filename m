Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD4AC46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 17:23:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D159E3CF97A
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 18:23:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF12B3CF96B
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 18:22:46 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3A5E9600F2B
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 18:22:45 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2BD0D222C5;
 Tue, 30 Jan 2024 17:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706635365;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+7Q/hkvR4UzP9gWGJWruvdGlWydEf1ixNg8wGNOESEY=;
 b=zimy47NuwMqBKVjpl2mJyrJlufqLbfmYgeB1uyUUiNm7aQ2HNKIa00XISAm/8EMcHr2Ad1
 gYesnOAzitQdPJCvO9y0053ttopDOWZYOSqCJ4tRhE+ml9QFHNtCrCDsxreVR498cwaWRv
 Ptv8WmPao0/1VY4PZ+7SCMo4QEoQtKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706635365;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+7Q/hkvR4UzP9gWGJWruvdGlWydEf1ixNg8wGNOESEY=;
 b=p5GgEMk2npAQMUSZWzUGF/jl+JGoyuIV45O8P6vS1Q6J5bj399xDgpDjxvP9PHzAmVuqR5
 +MI0h4b/Fl88mGDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706635365;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+7Q/hkvR4UzP9gWGJWruvdGlWydEf1ixNg8wGNOESEY=;
 b=zimy47NuwMqBKVjpl2mJyrJlufqLbfmYgeB1uyUUiNm7aQ2HNKIa00XISAm/8EMcHr2Ad1
 gYesnOAzitQdPJCvO9y0053ttopDOWZYOSqCJ4tRhE+ml9QFHNtCrCDsxreVR498cwaWRv
 Ptv8WmPao0/1VY4PZ+7SCMo4QEoQtKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706635365;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+7Q/hkvR4UzP9gWGJWruvdGlWydEf1ixNg8wGNOESEY=;
 b=p5GgEMk2npAQMUSZWzUGF/jl+JGoyuIV45O8P6vS1Q6J5bj399xDgpDjxvP9PHzAmVuqR5
 +MI0h4b/Fl88mGDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A0F113212;
 Tue, 30 Jan 2024 17:22:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id TOqxAGUwuWWrZAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jan 2024 17:22:45 +0000
Date: Tue, 30 Jan 2024 18:22:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240130172243.GB824958@pevik>
References: <20240130162813.20278-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240130162813.20278-1-mdoucha@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.94 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.64)[82.39%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] waitpid01: Test all standard deadly signals
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

Hi Martin,

nice work.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +++ b/testcases/kernel/syscalls/waitpid/waitpid01.c
> @@ -5,25 +5,57 @@
>   * Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>

Very nice cleanup, you deserve copyright, right?
 * Copyright (C) 2024 SUSE LLC <mdoucha@suse.cz>
>   */

> Extend waitpid01 to test all standard signals that kill the target
> process unless caught. Also remove waitpid02 since testing SIGFPE
> in waitpid01 makes it redundant.
> +static int testcase_list[] = {
> +	SIGABRT,
> +	SIGALRM,
> +	SIGBUS,
> +	SIGFPE,
> +	SIGHUP,
> +	SIGILL,
> +	SIGINT,
> +	SIGKILL,
> +	SIGPIPE,
> +	SIGPOLL,
> +	SIGPROF,
> +	SIGQUIT,
> +	SIGSEGV,
> +	SIGSYS,
> +	SIGTERM,
> +	SIGTRAP,
> +	SIGVTALRM,
> +	SIGXCPU,
> +	SIGXFSZ
> +};

I suppose you ignored from the list of signals in man signal(7) these with
action "Core" "Term" unless without standard ("-"), right?
So user defined signals (SIGUSR1, SIGUSR2) does not make sense to test?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
