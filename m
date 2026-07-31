Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CACC54F54
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 13:04:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDEDE3E7204
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 15:04:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 547F63E1FC0
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 15:04:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 747601400E0E
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 15:04:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 18CCA4146;
 Fri, 31 Jul 2026 13:04:08 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F900779D3;
 Fri, 31 Jul 2026 13:04:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id l/cBFkedbGpiKwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 31 Jul 2026 13:04:07 +0000
Date: Fri, 31 Jul 2026 15:03:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260731130357.GC196217@pevik>
References: <20260730-shell_oom_protection-v2-0-be1de2baa83d@suse.com>
 <20260730-shell_oom_protection-v2-1-be1de2baa83d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260730-shell_oom_protection-v2-1-be1de2baa83d@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 18CCA4146
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] shell: add optional OOM protection
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Add TST_OOM_PROTECTION to activate OOM protection in shell tests. When
> enabled, the shell harness shields itself from the OOM killer and runs
> the test in a child process, so it survives memory pressure and can
> still report results (e.g. during memcg stress tests).

> diff --git a/testcases/lib/tests/shell_oom_protection.sh b/testcases/lib/tests/shell_oom_protection.sh
> new file mode 100755
> index 0000000000000000000000000000000000000000..aeab36816ee7d8eeae9366d2199a0aabde73e25a
> --- /dev/null
> +++ b/testcases/lib/tests/shell_oom_protection.sh
> @@ -0,0 +1,42 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2026 Linux Test Project
> +#
> +# doc
> +# Verify that TST_OOM_PROTECTION shields the shell harness from the OOM
> +# killer and resets the test process oom_score_adj to 0.
> +#
> +# ---
> +# env
> +# {
> +# }
> +# ---
> +
> +TST_TESTFUNC=do_test
> +TST_OOM_PROTECTION=1
> +
> +read_oom_score_adj() {
> +	cat "/proc/$1/oom_score_adj" 2>/dev/null
> +}
> +
> +do_test() {
> +	local self_score harness_score
> +
> +	self_score=$(read_oom_score_adj self)
> +	harness_score=$(read_oom_score_adj "$$")
> +
> +	if [ "$self_score" = 0 ]; then
> +		tst_res TPASS "test process has oom_score_adj reset to 0"
> +	else
> +		tst_res TFAIL "test process oom_score_adj is $self_score, expected 0"
> +	fi
> +
> +	if [ "$harness_score" = -1000 ]; then
> +		tst_res TPASS "shell harness is protected from OOM"
> +	else
> +		tst_res TCONF "shell harness OOM protection unavailable"
> +	fi
> +}
> +

If the test always TPASS or TCONF, please add it to lib/newlib_tests/runtest.sh
(to be run in CI).

...

> +. tst_test.sh
> +tst_run
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 8701bb3903889b009f88ba98bac47534608cdd0a..48dacb432b953295ae4ad710e4f27ed87ac0a7e5 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -28,6 +28,57 @@ export TST_USR_GID="${LTP_USR_GID:-65534}"
>  trap "tst_brk TBROK 'test interrupted'" INT
>  trap "unset _tst_setup_timer_pid; tst_brk TBROK 'test terminated'" TERM

> +_tst_set_oom_score_adj()
> +{
> +	local value="$1"
> +	local path="/proc/self/oom_score_adj"
> +
> +	[ -e "$path" ] || return 0
> +
> +	echo "$value" > "$path" 2>/dev/null || return 0
So, we want to hide "write error: Permission denied"?

> +}
> +
> +_tst_enable_oom_protection()
> +{
> +	_tst_set_oom_score_adj -1000
> +}
> +
> +_tst_disable_oom_protection()
> +{
> +	_tst_set_oom_score_adj 0
> +}
> +
> +_tst_run_oom_protected()
> +{
> +	local _tst_pid
> +	local _tst_ret
> +
> +	# Shield the harness from the OOM killer and run the test in a child.
> +	# The child keeps the default oom_score_adj so that it, and any process
> +	# it spawns, stay killable under memory pressure while the harness
> +	# survives to report results.
> +	_tst_enable_oom_protection
> +
> +	(
Interesting idea. Hopefully it could work (I'm not sure if tst_test.sh API will
work well with yet another subshell, if killing will work correctly).

> +		_tst_disable_oom_protection
> +		_TST_OOM_PROTECTION=0
> +		export _TST_OOM_PROTECTION
NOTE: you can export variable with value in a single command:
export _TST_OOM_PROTECTION=0

Also, "$_TST_" does not have the protection about misuse which "$TST_" has (that
protection for _tst_i in $(grep ... you modified).
Please use a different name with "$TST_". But best would be just to assign a
different value:
export TST_OOM_PROTECTION=2

> +		tst_run "$@"
Running the test in the cleanup phase, that looks to me strange.

> +	) &
> +	_tst_pid=$!
> +
> +	wait "$_tst_pid"
> +	_tst_ret=$?
> +
> +	if [ "$_tst_ret" -eq 137 ]; then
> +		tst_res TINFO "Test was SIGKILLed: OOM killer or timeout?"
> +		tst_res TINFO "On a slow machine try exporting LTP_TIMEOUT_MUL > 1"
> +		tst_brk TBROK "Test killed!"
> +	fi
> +
> +	exit "$_tst_ret"
> +}
> +
>  _tst_do_cleanup()
>  {
>  	if [ -n "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" -a -z "$LTP_NO_CLEANUP" ]; then
> @@ -680,12 +731,16 @@ tst_run()
>  	local _tst_pattern='[='\''"} \t\/:`$\;|].*'
>  	local ret

> +	if [ "$TST_OOM_PROTECTION" = 1 -a "$_TST_OOM_PROTECTION" != 0 ]; then
And here have just:
	if [ "$TST_OOM_PROTECTION" = 1 ]; then

Kind regards,
Petr

> +		_tst_run_oom_protected "$@"
> +	fi
> +
>  	if [ -n "$TST_TEST_PATH" ]; then
>  		for _tst_i in $(grep '^[^#]*\<TST_' "$TST_TEST_PATH" | sed "s/.*TST_//; s/$_tst_pattern//"); do
>  			case "$_tst_i" in
>  			ALL_FILESYSTEMS|DISABLE_APPARMOR|DISABLE_SELINUX);;
>  			SETUP|CLEANUP|TESTFUNC|ID|CNT|MIN_KVER);;
> -			OPTS|USAGE|PARSE_ARGS|POS_ARGS);;
> +			OPTS|USAGE|PARSE_ARGS|POS_ARGS|OOM_PROTECTION);;
>  			NEEDS_ROOT|NEEDS_TMPDIR|TMPDIR|NEEDS_DEVICE|DEVICE);;
>  			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
>  			NEEDS_DRIVERS|FS_TYPE|MNTPOINT|MNT_PARAMS);;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
