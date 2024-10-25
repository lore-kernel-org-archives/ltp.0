Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34049D0C5F8
	for <ltp@archiver.kernel.org>; Fri, 25 Oct 2024 10:03:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A72BC3C72E9
	for <ltp@archiver.kernel.org>; Fri, 25 Oct 2024 12:03:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E95AD3C727F
 for <ltp@lists.linux.it>; Fri, 25 Oct 2024 12:03:07 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 439BF1BC79AF
 for <ltp@lists.linux.it>; Fri, 25 Oct 2024 12:03:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6239A1FDE6;
 Fri, 25 Oct 2024 10:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729850586;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ioQqRIMIri+lvEoLhod6pQy2rjQaSLrKLz6oq9jr8p0=;
 b=Cm113yDRaqqhmRDkC359jrQk9VksppodqqIXk/9DPZYL+CQBbuUGIseBT9wadUaf7Uw+Ws
 IkkBpFeUlkQLOFQLhpk9RGZHMzLgb8s2aQFmR5FscmPwsQnYCH/R+wFI/FujskGspO4SAJ
 4vfSLw5tGVqD/OC+dxiPey/z3Co56AE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729850586;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ioQqRIMIri+lvEoLhod6pQy2rjQaSLrKLz6oq9jr8p0=;
 b=J34jCyeG+B6XN8fww8MiICiHsfgU8BGrT3Z2i6gx0vPvbHpj/faCnH/6npaDRU8EmumUw0
 qmS25wpFBHy2jqBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1729850585;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ioQqRIMIri+lvEoLhod6pQy2rjQaSLrKLz6oq9jr8p0=;
 b=RpGyuoN3cl8jdGhRSf5wsgrpM9Y9gr21KV1W1YboqhyN2MAXJaLJX4h/6aYCETXI3Cr4pU
 hPbAH1BqBi/wHJdiJ+AzNpYZRlIQiiFeqXKvCurPB9erlIF+DRgpOAzHG7V7ZhJ0BgX4Pr
 7d/EGd7wuUMzKYZNRgCsJGa+XKh4ibs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1729850585;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ioQqRIMIri+lvEoLhod6pQy2rjQaSLrKLz6oq9jr8p0=;
 b=zhEmWS/+EYJcoVXwMxiVchMkehpq4bqtuuoifLyTkX5+fltk0edrNxdSVfX0M/pgd4Di69
 rW/8PZURVQ4p/sCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DFF3132D3;
 Fri, 25 Oct 2024 10:03:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ah2nCdlsG2diAwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 25 Oct 2024 10:03:05 +0000
Date: Fri, 25 Oct 2024 12:03:03 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20241025100303.GA681652@pevik>
References: <20241009-generate_syscalls-v4-0-5328a785bbad@suse.com>
 <20241009-generate_syscalls-v4-1-5328a785bbad@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241009-generate_syscalls-v4-1-5328a785bbad@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,suse.com:email]; 
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/4] Refactor regen.sh script to generate
 syscalls
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

Hi Andrea,

nice improvement.

TL;DR typo "kj" + missing SPDX and copyright would be worth to fix before merge.

Below are other minor notes, feel free to ignore.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Rename regen.sh into a more meaningful generate_syscalls.sh name, rename
> order into a more meaningful supported-syscalls.txt name and rewrite
> part of the regen.sh script code in order to execute it from anywhere in
> the filesystem, without need to be in its own folder. The new code is
> also more clear and concise, using native sh features which are
> simplifying the code.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  configure.ac                                       |   2 +-
>  include/lapi/syscalls/generate_syscalls.sh         | 115 ++++++++++++++++++
>  include/lapi/syscalls/regen.sh                     | 129 ---------------------
>  .../lapi/syscalls/{order => supported-arch.txt}    |   0
>  4 files changed, 116 insertions(+), 130 deletions(-)

> diff --git a/configure.ac b/configure.ac
> index ebbf49e28..45f92477f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -384,7 +384,7 @@ else
>      AC_SUBST([WITH_REALTIME_TESTSUITE],["no"])
>  fi

> -AC_CONFIG_COMMANDS([syscalls.h], [cd ${ac_top_srcdir}/include/lapi/syscalls; ./regen.sh])
> +AC_CONFIG_COMMANDS([syscalls.h], [cd ${ac_top_srcdir}/include/lapi/syscalls; ./generate_syscalls.sh ../syscalls.h])

As Li noted, this will need to be rebased
AC_CONFIG_COMMANDS([syscalls.h], [cd ${ac_top_srcdir}/include/lapi/syscalls; ./generate_syscalls.sh; cd - >/dev/null])

But as you don't do cd, that fix "cd - > /dev/null" can be again removed.

>  # custom functions
>  # NOTE: don't create custom functions for simple checks, put them into this file
> diff --git a/include/lapi/syscalls/generate_syscalls.sh b/include/lapi/syscalls/generate_syscalls.sh
> new file mode 100755
> index 000000000..863f52253
> --- /dev/null
> +++ b/include/lapi/syscalls/generate_syscalls.sh
> @@ -0,0 +1,115 @@
> +#!/bin/sh

The script should have SPDX + some copyright, right?
# SPDX-License-Identifier: GPL-2.0-or-later

> +#
> +# Generate the syscalls.h file, merging all architectures syscalls input file
> +# which are in the current folder and defined inside supported-arch.txt file.
> +
> +SYSCALLS_FILE="${1}"

nit: {} are not needed
SYSCALLS_FILE="$1"

I would personally use ${..} only when needed (IMHO everywhere in the script
just $... can be used (readability).

> +
> +if [ -z "${SYSCALLS_FILE}" ]; then
> +	echo "Please provide the syscalls.h directory:"
> +	echo ""
> +	echo "$0 path/of/syscalls.h"
> +	echo ""
> +	exit 1
> +fi
> +
> +SCRIPT_DIR="$(realpath $(dirname "$0"))"
> +SUPPORTED_ARCH="${SCRIPT_DIR}/supported-arch.txt"
> +
> +merge_syscalls() {
> +	echo '
> +/************************************************
> +* GENERATED FILE: DO NOT EDIT/PATCH THIS FILE  *
> +*  change your arch specific .in file instead  *
> +************************************************/
> +
> +/*
> +kj* Here we stick all the ugly *fallback* logic for linux

typo "kj", can you please remove it?

> +* system call numbers (those __NR_ thingies).
> +*
> +* Licensed under the GPLv2 or later, see the COPYING file.
> +*/
> +
> +#ifndef LAPI_SYSCALLS_H__
> +#define LAPI_SYSCALLS_H__
> +
> +#include <errno.h>
> +#include <sys/syscall.h>
> +#include <asm/unistd.h>
> +
> +#ifdef TST_TEST_H__
> +#define TST_SYSCALL_BRK__(NR, SNR) ({ \
> +tst_brk(TCONF, \
> +	"syscall(%d) " SNR " not supported on your arch", NR); \
> +})
> +#else
> +inline static void dummy_cleanup(void) {}
> +
> +#define TST_SYSCALL_BRK__(NR, SNR) ({ \
> +tst_brkm(TCONF, dummy_cleanup, \
> +	"syscall(%d) " SNR " not supported on your arch", NR); \
> +})
> +#endif
> +
> +#define tst_syscall(NR, ...) ({ \
> +intptr_t tst_ret; \
> +if (NR == __LTP__NR_INVALID_SYSCALL) { \
> +	errno = ENOSYS; \
> +	tst_ret = -1; \
> +} else { \
> +	tst_ret = syscall(NR, ##__VA_ARGS__); \
> +} \
> +if (tst_ret == -1 && errno == ENOSYS) { \
> +	TST_SYSCALL_BRK__(NR, #NR); \
> +} \
> +tst_ret; \
> +})
> +
> +#define __LTP__NR_INVALID_SYSCALL -1' >${SYSCALLS_FILE}
> +
> +	while IFS= read -r arch; do
> +		(
> +			echo
> +			case ${arch} in
> +			sparc64) echo "#if defined(__sparc__) && defined(__arch64__)" ;;
> +			sparc) echo "#if defined(__sparc__) && !defined(__arch64__)" ;;
> +			s390) echo "#if defined(__s390__) && !defined(__s390x__)" ;;
> +			mips_n32) echo "#if defined(__mips__) && defined(_ABIN32)" ;;
> +			mips_n64) echo "#if defined(__mips__) && defined(_ABI64)" ;;
> +			mips_o32) echo "#if defined(__mips__) && defined(_ABIO32) && _MIPS_SZLONG == 32" ;;
> +			*) echo "#ifdef __${arch}__" ;;
> +			esac
> +
> +			while read -r line; do
> +				set -- ${line}
> +				syscall_nr="__NR_$1"
> +				shift
> +
> +				echo "# ifndef ${syscall_nr}"
> +				echo "#  define ${syscall_nr} $*"
> +				echo "# endif"
> +			done <"${SCRIPT_DIR}/${arch}.in"
> +			echo "#endif"
> +			echo
> +		) >>${SYSCALLS_FILE}
> +	done <${SUPPORTED_ARCH}

nit: I would either don't define any function at all (have everything as
inline, thus save 1 indent) or, have this part of the code as a function.

Kind regards,
Petr

> +
> +	(
> +		echo
> +		echo "/* Common stubs */"
> +		while IFS= read -r arch; do
> +			while IFS= read -r line; do
> +				set -- ${line}
> +				syscall_nr="__NR_$1"
> +				shift
> +
> +				echo "# ifndef ${syscall_nr}"
> +				echo "#  define ${syscall_nr} __LTP__NR_INVALID_SYSCALL"
> +				echo "# endif"
> +			done <"${SCRIPT_DIR}/${arch}.in"
> +		done <${SUPPORTED_ARCH}
> +		echo "#endif"
> +	) >>${SYSCALLS_FILE}
> +}
> +
> +merge_syscalls

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
