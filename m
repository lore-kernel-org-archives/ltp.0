Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B07EC5AD7B
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 17:32:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FE403D04D2
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 19:32:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4E483CBF02
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 19:32:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 26ADC2001AF
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 19:32:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B4F503E13;
 Mon, 10 Aug 2026 17:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786383125;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vcBZzk1oQ1lZR/d0Cww8joNSqdhEyuQW4oN/ivG0D7o=;
 b=grGngs28L4UKQtbWq7HXhQUgo7A+tKfOjFRYen+a726y7uipr5Ld6nj53+QiEEEEyy3unh
 fKZ815WkI6IiUD7RY3WFv5dDcBKRRSINWvvzLCnmj/DKzTmk6cv8fq6gYKSt+7N1Piw0jB
 pL8KrvK+p1uXI2GfvZ4qR6vlwscrPw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786383125;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vcBZzk1oQ1lZR/d0Cww8joNSqdhEyuQW4oN/ivG0D7o=;
 b=vAywPVomOHZbSKGgZMj+B/yX7F0s4ixkjRxgr/pLWDsfJR8L+UJbOt9nsd8Ii/3NBhXU59
 gWbAZZ+4UGB9IRBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786383121;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vcBZzk1oQ1lZR/d0Cww8joNSqdhEyuQW4oN/ivG0D7o=;
 b=nCq8ZHRmEcz5xBsEUCUtmvdn2poMRrf2aUkGFT9cj9CN8X2Cx39zYApPLiBm0KetsB7Wdk
 FnwNhSkoiqAGnG3c+J/ELu0rtc5yEtCq/Ho8L/+JdokHyWCrKWaLtSG5kv/I/lzMG8kPlp
 SI22t/GoNfpwl+jgOuTm6gomlYPa8nY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786383121;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vcBZzk1oQ1lZR/d0Cww8joNSqdhEyuQW4oN/ivG0D7o=;
 b=7qUZpU1UzyaCkcmWeB2nOcbBIuH33nATfwx+FbdXvdEOtYTjEJeP+mY1OkJExU6loQV02o
 TtyoR6aJs9F5PRDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 39DE6779B6;
 Mon, 10 Aug 2026 17:32:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VI7KCBELempYBAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Aug 2026 17:32:01 +0000
Date: Mon, 10 Aug 2026 19:31:58 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260810173158.GD1049677@pevik>
References: <20260810-shell_oom_protection-v4-1-4dac0dbb0414@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260810-shell_oom_protection-v4-1-4dac0dbb0414@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,tst_test.sh:url,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] shell: enable OOM protection by default
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

...
> diff --git a/lib/newlib_tests/shell/tst_oom_protection.sh b/lib/newlib_tests/shell/tst_oom_protection.sh
> new file mode 100755
> index 000000000..564680700
> --- /dev/null
> +++ b/lib/newlib_tests/shell/tst_oom_protection.sh
> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2026 Linux Test Project
> +
> +TST_TESTFUNC=do_test
> +
> +read_oom_score_adj() {
> +	cat "/proc/$1/oom_score_adj"
> +}
> +
> +do_test() {
> +	local harness_score body_score
> +
> +	# $$ points to the protected harness, while /proc/self is the
> +	# unprotected child that actually runs the test body.
> +	harness_score=$(read_oom_score_adj "$$")
> +	body_score=$(read_oom_score_adj self)
> +
> +	if [ "$harness_score" != -1000 ]; then
> +		tst_res TCONF "shell harness OOM protection unavailable"
> +		return
> +	fi
> +
> +	tst_res TPASS "shell harness is protected from OOM by default"
> +
> +	if [ "$body_score" = 0 ]; then
> +		tst_res TPASS "test body runs in an unprotected child (oom_score_adj=0)"
> +	else
> +		tst_res TFAIL "test body oom_score_adj is $body_score, expected 0"
> +	fi
> +}
> +
> +. tst_test.sh
> +tst_run
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index b3e7e29bb..e42e562f5 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -28,6 +28,48 @@ export TST_USR_GID="${LTP_USR_GID:-65534}"
>  trap "tst_brk TBROK 'test interrupted'" INT
>  trap "unset _tst_setup_timer_pid; tst_brk TBROK 'test terminated'" TERM

> +_tst_set_oom_score_adj()
> +{
> +	local value="$1"
> +	local path="/proc/self/oom_score_adj"
> +
> +	if [ ! -e "$path" ]; then
> +		tst_res TINFO "oom_score_adj does not exist, skipping the adjustment"
> +		return
> +	fi
> +
> +	if ! echo "$value" > "$path"; then
> +		tst_res TWARN "Can't adjust score"
> +	fi
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
> +_tst_write_results()
> +{
> +	[ "$TST_CHILD" = 1 ] || return 0
Yes, $TST_CHILD is here visible, because it's run from the child...

> +	[ -n "$TST_RESULTS_FILE" ] || return 0
> +
> +	echo "$TST_PASS $TST_FAIL $TST_BROK $TST_WARN $TST_CONF $TST_COUNT" \
> +		> "$TST_RESULTS_FILE"
> +}
> +
> +_tst_read_results()
> +{
> +	[ -s "$TST_RESULTS_FILE" ] || return 0
> +
> +	read TST_PASS TST_FAIL TST_BROK TST_WARN TST_CONF TST_COUNT \
> +		< "$TST_RESULTS_FILE"
> +}
> +
>  _tst_do_cleanup()
>  {
>  	if [ -n "$TST_DO_CLEANUP" -a -n "$TST_CLEANUP" -a -z "$LTP_NO_CLEANUP" ]; then
> @@ -48,6 +90,15 @@ _tst_do_exit()

>  	_tst_do_cleanup

> +	# When running as the unprotected test child, only propagate the
> +	# results back to the protected harness which does the teardown and
> +	# prints the summary.
> +	if [ "$TST_CHILD" = 1 ]; then
... but as agent noted $TST_CHILD is not visible here in _tst_do_exit() because
that's run from parent shell => nack.

> +		_tst_cleanup_timer
> +		_tst_write_results
> +		exit 0
> +	fi
> +
>  	cd "$LTPROOT"
>  	[ "$TST_MOUNT_FLAG" = 1 ] && tst_umount

> @@ -788,10 +839,34 @@ tst_run()

>  	TST_MNTPOINT="${TST_MNTPOINT:-$PWD/mntpoint}"

> -	if [ "$TST_ALL_FILESYSTEMS" = 1 ]; then
> -		_tst_run_tcases_per_fs
> -	else
> -		_tst_run_iterations
> +	# Protect the harness so it survives memory pressure and can
> +	# still report results, then run the test body in a child that
> +	# resets OOM protection. This way workloads forked by the test
> +	# remain killable, mirroring the C test harness.
> +	_tst_enable_oom_protection
> +
> +	TST_RESULTS_FILE=$(mktemp "${TMPDIR:-/tmp}/ltp_${TST_ID}_res.XXXXXX")
Hm, writing temporary file directly to TMPDIR is not optimal, but if that was
the only problem I'd be ok with it.

> +	(
> +		TST_CHILD=1
Agent is correct, this is not visible in the parent shell => I doubt it will
work.

Also this is supposed to fix memcg stress tests, but it touches all shell test
=> very effective way to broke many tests in single commit with great change to
get it quickly reverted :).

IMHO we should really rewrite the tests which does not work in tst_test.sh API
into C API (better) or to the shell loader. Further complicate tst_test.sh is
a way to hell.

Kind regards,
Petr

> +		_tst_disable_oom_protection
> +		trap '_tst_cleanup_timer; _tst_write_results' EXIT
> +
> +		if [ "$TST_ALL_FILESYSTEMS" = 1 ]; then
> +			_tst_run_tcases_per_fs
> +		else
> +			_tst_run_iterations
> +		fi
> +	) &
> +
> +	wait $!
> +	ret=$?
> +
> +	_tst_read_results
> +	rm -f "$TST_RESULTS_FILE"
> +
> +	if [ $ret -gt 128 ]; then
> +		tst_res TBROK "Test killed by signal $((ret - 128))!"
>  	fi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
