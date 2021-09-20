Return-Path: <SRS0=cJ4o=OK=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E57CC433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 04:51:50 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECBBA61056
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 04:51:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECBBA61056
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jv-coder.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 098B93C8736
	for <ltp@archiver.kernel.org>; Mon, 20 Sep 2021 06:51:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE7F53C188A
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 06:51:35 +0200 (CEST)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AB94F1000A52
 for <ltp@lists.linux.it>; Mon, 20 Sep 2021 06:51:34 +0200 (CEST)
Received: from [192.168.178.40] (unknown [188.192.255.100])
 by mail.jv-coder.de (Postfix) with ESMTPSA id DF6A49FBF7;
 Mon, 20 Sep 2021 04:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1632113493; bh=KHzBU68DebHf9IO2I68ty4QjqxYuCGHJbBUH9EM+nxI=;
 h=Subject:To:From:Message-ID:Date:MIME-Version;
 b=VqPnB7azQzuIC3O2hP7dkVAPLUastw7iQc7gofidR1F7fV2Q9iIEZFPDQ1OoVMv0u
 KZonnClBRyH1lYnZgSLKztT5YvoPC86P21OgZxQON6yXoc9AR2k+sAZdi/IYl8L7F1
 9GARGnNSu6N4qEzxKAZ0W/L93fvsUCD43/XOd+AU=
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20210917141719.5739-1-chrubis@suse.cz>
From: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <01fb50a1-8edb-77ac-fba4-b70965022b3f@jv-coder.de>
Date: Mon, 20 Sep 2021 06:51:46 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210917141719.5739-1-chrubis@suse.cz>
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi

Sorry for my late reply on this topic, I was on vacation.

On 9/17/2021 4:17 PM, Cyril Hrubis wrote:
> There were actually several races in the shell library timeout handling.
>
> This commit fixes hopefully all of them by:
>
> * Reimplementing the backgroud timer in C
I did that once, but at that point it was kinda rejected ;)
See https://lists.linux.it/pipermail/ltp/2021-May/022445.html
and https://lists.linux.it/pipermail/ltp/2021-May/022453.html

>
> * Making sure that the timer has started before we leave test setup
>
> The rewrite of the backround timer to C allows us to run all the timeout
> logic in a single process, which simplifies the whole problem greatly
> since previously we had chain of processes that estabilished signal
> handlers to kill it's descendants, which in the end had a few races in
> it.
>
> The race that caused the problems is, as far as I can tell, in the way
> how shell spawns it's children. I haven't checked the shell code, but I
> guess that when shell runs a process in bacground it does vfork() +
> exec() and because signals are ignored during the operation. If the
> SIGTERM arrives at that point it gets lost.
>
> That means that we created a race window in the shell library each time
> we started a new process. The rewrite to C simplifies the code but we
> still end up with a single place where this can happen and that is when
> we execute the tst_timeout_kill binary. This is now fixed in the shell
> library by waiting until the background process gets to a sleep state,
> which means that the proces has been executed and waiting for the
> timeout.
>
> After these fixes I haven't been able to reproduce the hang with:
>
> cat > debug.sh <<EOF
> #!/bin/sh
>
> TST_SETUP="setup"
> TST_TESTFUNC="do_test"
> . tst_test.sh
>
> setup()
> {
>          tst_brk TCONF "quit now!"
> }
>
> do_test()
> {
>          tst_res TPASS "pass :)"
> }
>
> tst_run
> EOF
>
> # while true; do ./debug.sh; done
>
> Reported-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>   testcases/lib/.gitignore         |  1 +
>   testcases/lib/Makefile           |  2 +-
>   testcases/lib/tst_test.sh        | 47 +++++-----------
>   testcases/lib/tst_timeout_kill.c | 93 ++++++++++++++++++++++++++++++++
>   4 files changed, 108 insertions(+), 35 deletions(-)
>   create mode 100644 testcases/lib/tst_timeout_kill.c
>
> diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
> index 5a0e8cba2..f266a3e6b 100644
> --- a/testcases/lib/.gitignore
> +++ b/testcases/lib/.gitignore
> @@ -14,3 +14,4 @@
>   /tst_sleep
>   /tst_supported_fs
>   /tst_hexdump
> +tst_timeout_kill
> diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
> index 179b47479..d6b4c7a91 100644
> --- a/testcases/lib/Makefile
> +++ b/testcases/lib/Makefile
> @@ -11,6 +11,6 @@ INSTALL_TARGETS		:= *.sh
>   MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
>   			   tst_device tst_net_iface_prefix tst_net_ip_prefix tst_net_vars\
>   			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
> -			   tst_get_median tst_hexdump tst_get_free_pids
> +			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill
>   
>   include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 8f69b0551..2556b28f5 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -474,27 +474,6 @@ _tst_multiply_timeout()
>   	return 0
>   }
>   
> -_tst_kill_test()
> -{
> -	local i=10
> -
> -	trap '' TERM
> -	tst_res TBROK "Test timed out, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1"
> -	kill -TERM -$pid
> -	tst_sleep 100ms
> -
> -	while kill -0 $pid >/dev/null 2>&1 && [ $i -gt 0 ]; do
> -		tst_res TINFO "Test is still running, waiting ${i}s"
> -		sleep 1
> -		i=$((i-1))
> -	done
> -
> -	if kill -0 $pid >/dev/null 2>&1; then
> -		tst_res TBROK "Test still running, sending SIGKILL"
> -		kill -KILL -$pid
> -	fi
> -}
> -
>   _tst_cleanup_timer()
>   {
>   	if [ -n "$_tst_setup_timer_pid" ]; then
> @@ -503,18 +482,6 @@ _tst_cleanup_timer()
>   	fi
>   }
>   
> -_tst_timeout_process()
> -{
> -	local sleep_pid
> -
> -	sleep $sec &
> -	sleep_pid=$!
> -	trap "kill $sleep_pid; exit" TERM
> -	wait $sleep_pid
> -	trap - TERM
> -	_tst_kill_test
> -}
> -
>   _tst_setup_timer()
>   {
>   	TST_TIMEOUT=${TST_TIMEOUT:-300}
> @@ -539,9 +506,21 @@ _tst_setup_timer()
>   
>   	_tst_cleanup_timer
>   
> -	_tst_timeout_process &
> +	tst_timeout_kill $sec $pid &
>   
>   	_tst_setup_timer_pid=$!
> +
> +	while true; do
> +		local state
> +
> +		state=$(cut -d' ' -f3 "/proc/$_tst_setup_timer_pid/stat")
Hmm maybe we could use the checkpoint api here instead. Wouldn't this be 
more portable?
> +
> +		if [ "$state" = "S" ]; then
> +			break;
> +		fi
> +
> +		tst_sleep 1ms
> +	done
>   }
>   
>   tst_require_root()
> diff --git a/testcases/lib/tst_timeout_kill.c b/testcases/lib/tst_timeout_kill.c
> new file mode 100644
> index 000000000..6e97514f1
> --- /dev/null
> +++ b/testcases/lib/tst_timeout_kill.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2021 Cyril Hrubis <chrubis@suse.cz>
> + */
> +
> +#include <stdio.h>
> +#include <signal.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <tst_res_flags.h>
> +#include <tst_ansi_color.h>
> +
> +static void print_help(const char *name)
> +{
> +	fprintf(stderr, "usage: %s timeout pid\n", name);
> +}
> +
> +static void print_msg(int type, const char *msg)
> +{
> +	const char *strtype = "";
> +
> +	switch (type) {
> +	case TBROK:
> +		strtype = "TBROK";
> +	break;
> +	case TINFO:
> +		strtype = "TINFO";
> +	break;
> +	}
> +
> +	if (tst_color_enabled(STDERR_FILENO)) {
> +		fprintf(stderr, "%s%s: %s%s\n", tst_ttype2color(type),
> +			strtype, ANSI_COLOR_RESET, msg);
> +	} else {
> +		fprintf(stderr, "%s: %s\n", strtype, msg);
> +	}
> +}
Shouldn't this be reused from the library instead of being reimplemented?
> +
> +int main(int argc, char *argv[])
> +{
> +	int timeout, pid, ret, i;
> +
> +	if (argc != 3) {
> +		print_help(argv[0]);
> +		return 1;
> +	}
> +
> +	timeout = atoi(argv[1]);
> +	pid = atoi(argv[2]);
> +
> +	if (timeout < 0) {
> +		fprintf(stderr, "Invalid timeout '%s'", argv[1]);
> +		print_help(argv[0]);
> +		return 1;
> +	}
> +
> +	if (pid <= 1) {
> +		fprintf(stderr, "Invalid pid '%s'", argv[2]);
> +		print_help(argv[0]);
> +		return 1;
> +	}
> +
> +	if (timeout)
> +		sleep(timeout);
> +
> +	print_msg(TBROK, "Test timed out, sending SIGTERM! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1");
> +
> +	ret = kill(-pid, SIGTERM);
> +	if (ret) {
> +		print_msg(TBROK, "kill() failed");
> +		return 1;
> +	}
> +
> +	usleep(100000);
> +
> +	i = 10;
> +
> +	while (!kill(-pid, 0) && i-- > 0) {
This was kill(pid, 0) in the original shell code. I am not sure if it is 
important
> +		print_msg(TINFO, "Test is still running...");
> +		sleep(1);
> +	}
> +
> +	if (!kill(-pid, 0)) {
Here as well
> +		print_msg(TBROK, "Test is still running, sending SIGKILL");
> +		ret = kill(-pid, SIGKILL);
> +		if (ret) {
> +			print_msg(TBROK, "kill() failed");
> +			return 1;
> +		}
> +	}
> +
> +	return 0;
> +}

Joerg

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
