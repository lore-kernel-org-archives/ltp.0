Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB1BC87FD2
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 13:57:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BF933CA849
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 15:57:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 487593C06B4
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 15:56:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 580DB600991
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 15:56:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 551DE33977;
 Fri,  8 Aug 2025 13:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754661402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c8DjlzM0CjJiZ+IWgXoxO5o0xxE7vbGLSZzuijeT9Wg=;
 b=qBgTaQab/ogzOBVVo0Sy8P86TL91HYDHyy/WeZmbtOsHOtk6i0W16USEbj+Rm0dt0KUesx
 ejezC7LbfuGNd4EQOI4vpPBopIoCdf2OJg2i/AkptU4xzSBXnGDpfCPqKdZQNi4FgnNK+I
 YUAY9WX9+QjoPdilx4H4crQ6fYItfBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754661402;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c8DjlzM0CjJiZ+IWgXoxO5o0xxE7vbGLSZzuijeT9Wg=;
 b=JOePVcdCS9pgElEkxM/dTotFew4VME1RQe84n/M9JUJqK0PWJjQ+mB6QTb5ZU7aarsOm3K
 LSY3cAZGI8y4+cBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1754661402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c8DjlzM0CjJiZ+IWgXoxO5o0xxE7vbGLSZzuijeT9Wg=;
 b=qBgTaQab/ogzOBVVo0Sy8P86TL91HYDHyy/WeZmbtOsHOtk6i0W16USEbj+Rm0dt0KUesx
 ejezC7LbfuGNd4EQOI4vpPBopIoCdf2OJg2i/AkptU4xzSBXnGDpfCPqKdZQNi4FgnNK+I
 YUAY9WX9+QjoPdilx4H4crQ6fYItfBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1754661402;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c8DjlzM0CjJiZ+IWgXoxO5o0xxE7vbGLSZzuijeT9Wg=;
 b=JOePVcdCS9pgElEkxM/dTotFew4VME1RQe84n/M9JUJqK0PWJjQ+mB6QTb5ZU7aarsOm3K
 LSY3cAZGI8y4+cBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 481091392A;
 Fri,  8 Aug 2025 13:56:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Dcu3EBoClmh5KwAAD6G6ig
 (envelope-from <akumar@suse.de>); Fri, 08 Aug 2025 13:56:42 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 08 Aug 2025 15:56:41 +0200
Message-ID: <12721614.O9o76ZdvQC@thinkpad>
In-Reply-To: <20250808110102.454689-2-pvorel@suse.cz>
References: <20250808110102.454689-1-pvorel@suse.cz>
 <20250808110102.454689-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-7.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; CTE_CASE(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/3] Remove m4/ltp-signalfd.m4
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

On Friday, August 8, 2025 1:01:00 PM CEST Petr Vorel wrote:
> HAVE_STRUCT_SIGNALFD_SIGINFO_SSI_SIGNO autotols check was used only in
s/autotols/autotools

Reviewed-by: Avinesh Kumar <akumar@suse.de>
for all patches in this series.

Thanks,
Avinesh

> testcases/kernel/syscalls/signalfd/signalfd01.c before it got rewritten
> to the new API in a569202b6e.
> 
> Fixes: a569202b6e ("signalfd01: Refactor old case with new API")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  configure.ac       |  1 -
>  m4/ltp-signalfd.m4 | 17 -----------------
>  2 files changed, 18 deletions(-)
>  delete mode 100644 m4/ltp-signalfd.m4
> 
> diff --git a/configure.ac b/configure.ac
> index db41175bf2..5362aaf1bc 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -414,7 +414,6 @@ fi
>  AC_DEFINE_UNQUOTED(NUMA_ERROR_MSG, ["$numa_error_msg"], [Error message when no NUMA support])
>  
>  
> -LTP_CHECK_SYSCALL_SIGNALFD
>  LTP_CHECK_SYSCALL_UTIMENSAT
>  LTP_CHECK_TASKSTATS
>  test "x$with_tirpc" = xyes && LTP_CHECK_TIRPC
> diff --git a/m4/ltp-signalfd.m4 b/m4/ltp-signalfd.m4
> deleted file mode 100644
> index 5aac395bd7..0000000000
> --- a/m4/ltp-signalfd.m4
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -dnl SPDX-License-Identifier: GPL-2.0-or-later
> -dnl Copyright (c) Red Hat Inc., 2008
> -dnl Copyright (c) 2019 Fujitsu Ltd.
> -dnl Author: Masatake YAMATO <yamato@redhat.com>
> -
> -AC_DEFUN([LTP_CHECK_SYSCALL_SIGNALFD],[
> -
> -AC_CHECK_FUNCS(signalfd,,)
> -AC_CHECK_HEADERS([sys/signalfd.h],,)
> -AC_CHECK_HEADERS([linux/signalfd.h],,)
> -AC_CHECK_MEMBERS([struct signalfd_siginfo.ssi_signo],,,[
> -#if defined HAVE_SYS_SIGNALFD_H
> -#include <sys/signalfd.h>
> -#elif defined HAVE_LINUX_SIGNALFD_H
> -#include <linux/signalfd.h>
> -#endif])
> -])
> 





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
