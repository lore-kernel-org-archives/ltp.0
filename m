Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128B9C55822
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 13:17:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 510C13E718C
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 15:17:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 498C13CC870
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 15:17:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7681F1A0080C
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 15:17:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E70717F727;
 Tue,  4 Aug 2026 13:17:30 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CDDC9779BB;
 Tue,  4 Aug 2026 13:17:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JdtFMGrmcWpOfAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 04 Aug 2026 13:17:30 +0000
Date: Tue, 4 Aug 2026 15:17:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260804131725.GE257786@pevik>
References: <20260804-shell_oom_protection-v3-1-fe42b15d034c@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260804-shell_oom_protection-v3-1-fe42b15d034c@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: E70717F727
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] shell: enable OOM protection by default
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

> Add TST_OOM_PROTECTION to activate/deactivate OOM protection in shell
> tests. When enabled, the shell harness shields itself from the OOM
> killer and runs the test in a child process, so it survives memory
> pressure and can still report results (e.g. during memcg stress tests).

C API just enables OOM protection unconditionally. Why we allow to disable it?
Also, I would not allow to disable it until any test actually needs that.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Under Li's idea, implement a OOM protection mechanism for the shell
Li would deserve his credit via Suggested-by: :). And it's not only for the
credit itself, but (maybe more important) when there is something later on
others know whom to ask for the details.

> tests so we can avoid OOM for memcg stress tests.
Ah, it's for memcg stress tests. Maybe people in the future appreciate to know
this, IMHO it should be part of the commit message.

> ---
> Changes in v3:
> - simplify oom code
> - enable OOM protection by default
> - Link to v2: https://lore.kernel.org/20260730-shell_oom_protection-v2-0-be1de2baa83d@suse.com

> Changes in v2:
> - update shell OOM protection functional test
> - Link to v1: https://lore.kernel.org/20260713-shell_oom_protection-v1-0-b732e8647894@suse.com
> ---
>  doc/developers/writing_tests.rst             |  3 +++
>  lib/newlib_tests/runtest.sh                  |  1 +
>  lib/newlib_tests/shell/tst_oom_protection.sh | 31 ++++++++++++++++++++++++
>  testcases/lib/tst_test.sh                    | 35 +++++++++++++++++++++++++++-
>  4 files changed, 69 insertions(+), 1 deletion(-)

> diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
> index 4db57898fcf08b83e68be996f666e91c418838fc..2d5bc294083fa2b89212714f0a6c5e5c3f22777a 100644
> --- a/doc/developers/writing_tests.rst
> +++ b/doc/developers/writing_tests.rst
> @@ -549,6 +549,9 @@ LTP C And Shell Test API Comparison
>      * - not applicable
>        - TST_FS_TYPE

> +    * - not applicable
> +      - TST_OOM_PROTECTION
If we really want to keep the variable, I'd for C part instead of "not
applicable" wrote:
_equivalent of OOM protection enabled in C API (tst_enable_oom_protection())_

And, more important, if we add new variable to tst_test.sh, IMHO it should be
documented in the only docs we have for it: doc/old/Shell-Test-API.asciidoc.

> diff --git a/lib/newlib_tests/runtest.sh b/lib/newlib_tests/runtest.sh
> index 71808ef8b8d5545f52d6014bc070145f952915e9..7e2d0a2ac329fc1d825c2fe0b6f7c09d4f2b0064 100755
> --- a/lib/newlib_tests/runtest.sh
> +++ b/lib/newlib_tests/runtest.sh
> @@ -44,6 +44,7 @@ shell/tst_check_driver.sh
>  shell/tst_check_kconfig0[1-5].sh
>  shell/tst_mount_device.sh
>  shell/tst_mount_device_tmpfs.sh
> +shell/tst_oom_protection.sh
+1

>  shell/tst_skip_filesystems.sh
>  shell/net/*.sh}"

> diff --git a/lib/newlib_tests/shell/tst_oom_protection.sh b/lib/newlib_tests/shell/tst_oom_protection.sh
> new file mode 100755
> index 0000000000000000000000000000000000000000..22993511c64845712e4fa9fc942e9869121d7e0b
> --- /dev/null
> +++ b/lib/newlib_tests/shell/tst_oom_protection.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2026 Linux Test Project
> +
> +TST_TESTFUNC=do_test
> +
> +read_oom_score_adj() {
> +	cat "/proc/$1/oom_score_adj" 2>/dev/null
Why this masking stderr? It should be always OK to read.

> +}
> +
> +do_test() {
> +	local harness_score child_score
> +
> +	harness_score=$(read_oom_score_adj "$$")
> +
> +	if [ "$harness_score" = -1000 ]; then
> +		tst_res TPASS "shell harness is protected from OOM by default"
> +
> +		child_score=$(tst_oom_unprotect read_oom_score_adj self)
> +		if [ "$child_score" = 0 ]; then
> +			tst_res TPASS "unprotected child process has oom_score_adj reset to 0"
> +		else
> +			tst_res TFAIL "unprotected child process oom_score_adj is $child_score, expected 0"
> +		fi
> +	else
> +		tst_res TCONF "shell harness OOM protection unavailable"
> +	fi
> +}
> +
> +. tst_test.sh
> +tst_run
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index b3e7e29bbf7b52de4cb65665751005cb4df156a8..70fa19e4dadfdceb92821a02fbce7cf6686d9c4e 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -15,6 +15,7 @@ export TST_CONF=0
>  export TST_COUNT=1
>  export TST_ITERATIONS=1
>  export TST_TMPDIR_RHOST=0
> +export TST_OOM_PROTECTION="${TST_OOM_PROTECTION:-1}"
>  export TST_LIB_LOADED=1

>  # see testcases/lib/tst_runas.c
> @@ -28,6 +29,34 @@ export TST_USR_GID="${LTP_USR_GID:-65534}"
>  trap "tst_brk TBROK 'test interrupted'" INT
>  trap "unset _tst_setup_timer_pid; tst_brk TBROK 'test terminated'" TERM

> +_tst_set_oom_score_adj()
> +{
> +	local value="$1"
> +	local path="/proc/self/oom_score_adj"
> +
> +	[ -e "$path" ] || return 0
If you don't reuse the return value you can use just "return"

Also, C API in set_oom_score_adj() warns:
tst_res(TINFO, "oom_score_adj does not exist, skipping the adjustment");

> +
> +	echo "$value" > "$path" 2>/dev/null || return 0

Do we want to hide "permission denied"? C API in set_oom_score_adj() uses
capability. If you want to really match the behavior with C API, you could
create C binary helper testcases/lib/tst_*.c which would just call
set_oom_score_adj(). But I'd be pragmatic, if the tests which needs it have
TST_NEEDS_ROOT=1 (and memcg_lib.sh sets it), you might just write shell code
which will behave similar like C code (except using capability, of course).

I would not hide "permission denied". At least similarly match C API in
set_oom_score_adj():

if ! echo "$value" > "$path"; then
	tst_res TWARN "Can't adjust score"
fi

I.e. no masking stderr), return is not used. And even if you want to use
function return value, $? will be taken from echo, e.g.:

$ echo foo > /asdf; echo $?
bash: /asdf: Permission denied
1

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
> +tst_oom_unprotect()
> +{
> +	_tst_disable_oom_protection
> +	if [ $# -gt 0 ]; then
> +		"$@"
Because there is only single use of tst_oom_unprotect(), I would call
"read_oom_score_adj self" here. More readable, more secure ("$@" is kind of
eval).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
