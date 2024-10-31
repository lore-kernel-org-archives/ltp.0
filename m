Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA6FE68973
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 10:25:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3D643CBE75
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 11:25:29 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD7553CBCF4
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 11:25:13 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 23EE823BBEA
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 11:25:12 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7DCB11F7DB;
 Thu, 31 Oct 2024 10:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730370311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cJInIchwPTkiQssZh9IRoM8jp/aNsowTMYSOeaSLho8=;
 b=dlxc5Yo7BwT3aNnKKQ4iWpEVwCtvhIPA8MsgHBfJPbH8IvPuGJKnVy3c/Rn97GIylRjsT8
 Emnjg17ptq5mHGwN9u5lAaVff+eMODJfcvfSZmjIIy9gYSD4BNlQd/mYivXqDbc7k/ly+w
 MgC50o4O53AaXyA80W4p0lEJXDrD/q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730370311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cJInIchwPTkiQssZh9IRoM8jp/aNsowTMYSOeaSLho8=;
 b=o93sM60/uHEc+LxhipXl3jHde8wsn9Pqbl9QLdoIb6bsdUKOITa9tefeFYdT6cu5fVgXa7
 777ilPiqddqbMJDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dlxc5Yo7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="o93sM60/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730370311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cJInIchwPTkiQssZh9IRoM8jp/aNsowTMYSOeaSLho8=;
 b=dlxc5Yo7BwT3aNnKKQ4iWpEVwCtvhIPA8MsgHBfJPbH8IvPuGJKnVy3c/Rn97GIylRjsT8
 Emnjg17ptq5mHGwN9u5lAaVff+eMODJfcvfSZmjIIy9gYSD4BNlQd/mYivXqDbc7k/ly+w
 MgC50o4O53AaXyA80W4p0lEJXDrD/q0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730370311;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cJInIchwPTkiQssZh9IRoM8jp/aNsowTMYSOeaSLho8=;
 b=o93sM60/uHEc+LxhipXl3jHde8wsn9Pqbl9QLdoIb6bsdUKOITa9tefeFYdT6cu5fVgXa7
 777ilPiqddqbMJDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C6CF13A53;
 Thu, 31 Oct 2024 10:25:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rLKLGQdbI2dWPAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 31 Oct 2024 10:25:11 +0000
Date: Thu, 31 Oct 2024 11:25:12 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZyNbCKxK_rKwuH1C@yuki.lan>
References: <20241031-generate_syscalls-v6-0-1ad86a33ce2d@suse.com>
 <20241031-generate_syscalls-v6-1-1ad86a33ce2d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241031-generate_syscalls-v6-1-1ad86a33ce2d@suse.com>
X-Rspamd-Queue-Id: 7DCB11F7DB
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/3] Refactor regen.sh script to generate
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +echo '
^
This adds an empty line to the start of the file.

> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/************************************************
> + * GENERATED FILE: DO NOT EDIT/PATCH THIS FILE  *
> + *  change your arch specific .in file instead  *
> + ************************************************/
> +
> +/*
> + * Here we stick all the ugly *fallback* logic for linux
> + * system call numbers (those __NR_ thingies).
> + */
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
> +while IFS= read -r arch; do
> +	(
> +		echo
> +		case ${arch} in
> +		sparc64) echo "#if defined(__sparc__) && defined(__arch64__)" ;;
> +		sparc) echo "#if defined(__sparc__) && !defined(__arch64__)" ;;
> +		s390) echo "#if defined(__s390__) && !defined(__s390x__)" ;;
> +		mips64n32) echo "#if defined(__mips__) && defined(_ABIN32)" ;;
> +		mips64) echo "#if defined(__mips__) && defined(_ABI64)" ;;
> +		mipso32) echo "#if defined(__mips__) && defined(_ABIO32) && _MIPS_SZLONG == 32" ;;
> +		parisc) echo "#ifdef __hppa__" ;;
> +		loongarch64) echo "#ifdef __loongarch__" ;;
> +		arm64) echo "#ifdef __aarch64__" ;;
> +		*) echo "#ifdef __${arch}__" ;;
> +		esac
> +
> +		while read -r line; do
> +			set -- ${line}
> +			syscall_nr="__NR_$1"
> +			shift
> +
> +			echo "# ifndef ${syscall_nr}"
> +			echo "#  define ${syscall_nr} $*"
> +			echo "# endif"
> +		done <"${SCRIPT_DIR}/${arch}.in"
> +		echo "#endif"
> +		echo
> +	) >>${SYSCALLS_FILE}
> +done <${SUPPORTED_ARCH}
> +
> +(
> +	echo
> +	echo "/* Common stubs */"
> +	for num in $(awk '{print $1}' "${SCRIPT_DIR}/"*.in | sort -u); do
> +		syscall_nr="__NR_${num}"
> +		shift

This shift is not needed here anymore and generates a lot of warnings.

> +		echo "# ifndef ${syscall_nr}"
> +		echo "#  define ${syscall_nr} __LTP__NR_INVALID_SYSCALL"
> +		echo "# endif"
> +	done
> +	echo "#endif"
> +) >>${SYSCALLS_FILE}

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
