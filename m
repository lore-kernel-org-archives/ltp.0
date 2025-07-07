Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CECB2C83F07
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 11:47:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6E283C9939
	for <ltp@archiver.kernel.org>; Mon,  7 Jul 2025 13:47:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55F453C282E
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 13:47:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B5B72600801
 for <ltp@lists.linux.it>; Mon,  7 Jul 2025 13:47:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 24FB221164;
 Mon,  7 Jul 2025 11:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751888854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mK6irrG+xro0Z+8ug5OP9Xjb2FlavjD5kXK5GDSIRbY=;
 b=22sl9zPoNmwsdgzhpei7Lt1J+6Qf2ipOtujGfMcMZw2lusXE7X2E220acUiCpwctHUg6Cf
 pD8Df3xhf4NUlEHmOyNnMcuU7q9ShacdpLBTvTVAIc3NnZdUgmuuNbYJDxKvQeM4VJKiBl
 P+mpNv5X9muRiZrB2qB9QptVj/w5vTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751888854;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mK6irrG+xro0Z+8ug5OP9Xjb2FlavjD5kXK5GDSIRbY=;
 b=8xCe/H5VOwLZV60GbSFXzC6CX6nmT+MnNavGBLmOBkv2jzgKl1B9Jn4iB5Ed8597t05PIz
 9SdR6I887cSLTtDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751888854; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mK6irrG+xro0Z+8ug5OP9Xjb2FlavjD5kXK5GDSIRbY=;
 b=22sl9zPoNmwsdgzhpei7Lt1J+6Qf2ipOtujGfMcMZw2lusXE7X2E220acUiCpwctHUg6Cf
 pD8Df3xhf4NUlEHmOyNnMcuU7q9ShacdpLBTvTVAIc3NnZdUgmuuNbYJDxKvQeM4VJKiBl
 P+mpNv5X9muRiZrB2qB9QptVj/w5vTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751888854;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mK6irrG+xro0Z+8ug5OP9Xjb2FlavjD5kXK5GDSIRbY=;
 b=8xCe/H5VOwLZV60GbSFXzC6CX6nmT+MnNavGBLmOBkv2jzgKl1B9Jn4iB5Ed8597t05PIz
 9SdR6I887cSLTtDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 152CD13757;
 Mon,  7 Jul 2025 11:47:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nMyRBNaza2hWeAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 07 Jul 2025 11:47:34 +0000
Date: Mon, 7 Jul 2025 13:48:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aGuz-zaoq_B125m7@yuki.lan>
References: <20250704-ioctl_pidfd_suite-v2-0-88a6466d9f62@suse.com>
 <20250704-ioctl_pidfd_suite-v2-2-88a6466d9f62@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250704-ioctl_pidfd_suite-v2-2-88a6466d9f62@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/8] Fallback PIDFD_GET_INFO related definitions
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
>  configure.ac         |  2 ++
>  include/lapi/pidfd.h | 37 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index 69c5be7362a0e9f2fdaf3e6bd01f92f6f4880108..7132c00df97870e234fd5b8c9fcaf1beb263cf06 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -259,6 +259,8 @@ AC_CHECK_TYPES([struct cachestat],,,[#include <sys/mman.h>])
>  AC_CHECK_TYPES([struct mnt_id_req],,,[#include <sys/mount.h>])
>  AC_CHECK_TYPES([struct statmount],,,[#include <sys/mount.h>])
>  
> +AC_CHECK_TYPES([struct pidfd_info],,,[#include <uapi/linux/pidfd.h>])
                                                         ^
							 Just: <linux/pidfd.h>

When kernel headers are packaged and later installed on a system they
do not have the uapi/ directory prefix anymore.

> +
>  # Tools knobs
>  
>  # Bash
> diff --git a/include/lapi/pidfd.h b/include/lapi/pidfd.h
> index 9ca8e5aa23626646ebb2f18880abd5e52298bfc6..55a44d5840c01bda7b31237c5c0d54ebba8155c5 100644
> --- a/include/lapi/pidfd.h
> +++ b/include/lapi/pidfd.h
> @@ -8,16 +8,53 @@
>  #define LAPI_PIDFD_H__
>  
>  #include <fcntl.h>
> +#include <stdint.h>
> +#include <sys/ioctl.h>
> +
>  #ifdef HAVE_SYS_PIDFD_H
>  # include <sys/pidfd.h>
>  #endif
> +
>  #include "config.h"
>  #include "lapi/syscalls.h"
>  
> +#ifndef HAVE_STRUCT_PIDFD_INFO
> +struct pidfd_info {
> +	uint64_t mask;
> +	uint64_t cgroupid;
> +	uint32_t pid;
> +	uint32_t tgid;
> +	uint32_t ppid;
> +	uint32_t ruid;
> +	uint32_t rgid;
> +	uint32_t euid;
> +	uint32_t egid;
> +	uint32_t suid;
> +	uint32_t sgid;
> +	uint32_t fsuid;
> +	uint32_t fsgid;
> +	int32_t exit_code;
> +	uint32_t coredump_mask;
> +	uint32_t __spare1;
> +};
> +#endif
> +
>  #ifndef PIDFD_NONBLOCK
>  #define PIDFD_NONBLOCK O_NONBLOCK
>  #endif

Generally you are supposed to indent the inner macros by spaces after
the hash. So it looks like:

#ifndef ..
# define
# ifdef
#  define
# endif
#endif

With these two small things fixed:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
