Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8A5C282D0
	for <ltp@archiver.kernel.org>; Fri,  7 Mar 2025 16:40:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D69B03CA15D
	for <ltp@archiver.kernel.org>; Fri,  7 Mar 2025 17:40:38 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EA603C2969
 for <ltp@lists.linux.it>; Fri,  7 Mar 2025 17:40:21 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DD6BA68042F
 for <ltp@lists.linux.it>; Fri,  7 Mar 2025 17:40:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AE9AE1F441;
 Fri,  7 Mar 2025 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741365618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/fUdJvNOPliZKhbTmuSh8ofF2yo1sL+I8nOrbH+4bsg=;
 b=yC++s9jSE9syYvuhENi+r1HLQEk374phOx7cV+zqLt+TIbazd4guSjGisvyiu9clxvbleu
 cRvymtQw3cLbUD1fl0bwyvIvBPDhoGgiYb7HshyQ9d9nsIKIkj3cS2ZXbfzX6qptb6zktj
 u1L025reB0lE6unM5wtL7GG+rE/F/n4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741365618;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/fUdJvNOPliZKhbTmuSh8ofF2yo1sL+I8nOrbH+4bsg=;
 b=thfjiK3BuPh/l666CWFdO9xwRJ2oFs+9skwqcWPqqg7mjXVuI9smiv9Flneo8OiFlUscfV
 L/nhTPmQqanrTGBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1741365618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/fUdJvNOPliZKhbTmuSh8ofF2yo1sL+I8nOrbH+4bsg=;
 b=yC++s9jSE9syYvuhENi+r1HLQEk374phOx7cV+zqLt+TIbazd4guSjGisvyiu9clxvbleu
 cRvymtQw3cLbUD1fl0bwyvIvBPDhoGgiYb7HshyQ9d9nsIKIkj3cS2ZXbfzX6qptb6zktj
 u1L025reB0lE6unM5wtL7GG+rE/F/n4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1741365618;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/fUdJvNOPliZKhbTmuSh8ofF2yo1sL+I8nOrbH+4bsg=;
 b=thfjiK3BuPh/l666CWFdO9xwRJ2oFs+9skwqcWPqqg7mjXVuI9smiv9Flneo8OiFlUscfV
 L/nhTPmQqanrTGBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 94A1C13939;
 Fri,  7 Mar 2025 16:40:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QCpAI3Ihy2eTVgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 07 Mar 2025 16:40:18 +0000
Date: Fri, 7 Mar 2025 17:40:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z8shfrkfVkwsCOTw@yuki.lan>
References: <20250228172439.3276777-1-pvorel@suse.cz>
 <20250228172439.3276777-5-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250228172439.3276777-5-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 4/5] shell lib: Add basic support for test
 cleanup
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

> diff --git a/testcases/lib/tst_env.sh b/testcases/lib/tst_env.sh
> index b13bab37c3..68f9a0daa9 100644
> --- a/testcases/lib/tst_env.sh
> +++ b/testcases/lib/tst_env.sh
> @@ -35,7 +35,3 @@ tst_brk_()
>  
>  alias tst_res="tst_res_ $tst_script_name \$LINENO"
>  alias tst_brk="tst_brk_ $tst_script_name \$LINENO"
> -
> -if [ -n "$TST_CLEANUP" ]; then
> -	trap $TST_CLEANUP EXIT
> -fi
> diff --git a/testcases/lib/tst_exec.sh b/testcases/lib/tst_exec.sh
> new file mode 100755
> index 0000000000..dcf40fd5bb
> --- /dev/null
> +++ b/testcases/lib/tst_exec.sh
> @@ -0,0 +1,19 @@
> +#!/bin/sh
> +# Copyright (c) 2025 Cyril Hrubis <chrubis@suse.cz>
> +# Copyright (c) 2025 Petr Vorel <pvorel@suse.cz>
> +
> +. tst_env.sh
> +
> +. "$1"
> +
> +if [ -n "$TST_CLEANUP" ]; then
> +	trap $TST_CLEANUP EXIT
> +fi
> +
> +if [ -n "$TST_SETUP" ]; then
> +    $TST_SETUP
> +fi
> +
> +tst_test
> +
> +# vim: set ft=sh ts=4 sts=4 sw=4 expandtab :

Please do not add the vim formatting hints.

> diff --git a/testcases/lib/tst_loader.sh b/testcases/lib/tst_loader.sh
> index 62c9cc6d8f..e2d1bd7daf 100644
> --- a/testcases/lib/tst_loader.sh
> +++ b/testcases/lib/tst_loader.sh
> @@ -3,11 +3,8 @@
>  # Copyright (c) 2024-2025 Cyril Hrubis <chrubis@suse.cz>
>  #
>  # This is a loader for shell tests that use the C test library.
> -#
>  
>  if [ -z "$LTP_IPC_PATH" ]; then
> -	tst_run_shell $(basename "$0") "$@"
> +	tst_run_shell tst_exec.sh $(basename "$0") "$@"
>  	exit $?
> -else
> -	. tst_env.sh
>  fi

Do we really need the tst_exec.sh?

Doesn't it work if we add what is in the tst_exec here?

The whole point of [ -z "$LTP_IPC_PATH" ]; is to detect when we are
being re-executed by the tst_run_shell, so the else branch (which
isn't really needed, because we do exit in the if) was when the test did
run.

If you change the tests to be in functions and source the tst_loader.sh
at the end it should just work.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
