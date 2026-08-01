Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB7CC55173
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 11:49:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF42F3EA682
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 13:49:22 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A69D3EA67C
 for <ltp@lists.linux.it>; Sat,  1 Aug 2026 13:49:06 +0200 (CEST)
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com
 [91.218.175.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 59C591400077
 for <ltp@lists.linux.it>; Sat,  1 Aug 2026 13:49:04 +0200 (CEST)
Date: Sat, 1 Aug 2026 19:48:54 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785584943;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NM5AggfZA2kC4GO0SbzBaxUiDSaF5n1TyOxyYcSJa4s=;
 b=wXhS6L/7Bk68OQBteLYxTmyMQ+DO15Ub3vUYuQMBm77SGR+cCY/AatVUI3eWKRMbHLEKTF
 ZKZrtkoREHU8Ma4N4w/X0TgXoSEr6htaxVVQPLXZ7qFcUo7aQ6k9hkAi1YoSL9rjA8LcmO
 yKCI/0GkK9BDtLq3wRTAyXLP2nNVckg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <am3dJgE_4tMWnsh1@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260730-shell_oom_protection-v2-0-be1de2baa83d@suse.com>
 <20260730-shell_oom_protection-v2-1-be1de2baa83d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260730-shell_oom_protection-v2-1-be1de2baa83d@suse.com>
X-Migadu-Flow: FLOW_OUT
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Andrea Cervesato wrote:

> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -28,6 +28,57 @@ export TST_USR_GID="${LTP_USR_GID:-65534}"
>  trap "tst_brk TBROK 'test interrupted'" INT
>  trap "unset _tst_setup_timer_pid; tst_brk TBROK 'test terminated'" TERM
>  
> +_tst_set_oom_score_adj()
> +{
> +	local value="$1"
> +	local path="/proc/self/oom_score_adj"
> +
> +	[ -e "$path" ] || return 0
> +
> +	echo "$value" > "$path" 2>/dev/null || return 0
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
> +		_tst_disable_oom_protection
> +		_TST_OOM_PROTECTION=0
> +		export _TST_OOM_PROTECTION
> +		tst_run "$@"
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
>  
> +	if [ "$TST_OOM_PROTECTION" = 1 -a "$_TST_OOM_PROTECTION" != 0 ]; then
> +		_tst_run_oom_protected "$@"
> +	fi

In the C library, OOM protection for the LTP library and harness
is enabled by default. But in such Shell implementation, we have to
explicitly enable it via 'TST_OOM_PROTECTION=1'.

If we keep them consistent and remove the TST_OOM_PROTECTION
variable, things will become easier I guess :).

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
