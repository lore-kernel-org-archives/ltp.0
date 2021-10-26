Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC75BC433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 14:13:17 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3417560E8F
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 14:13:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3417560E8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B1E713C6868
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 16:13:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 736753C6730
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 16:13:06 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 089391A017CA
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 16:13:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 37D791FD42;
 Tue, 26 Oct 2021 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635257581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XbEe7XTfvgNv4WiN4RPgAkB2tN5BIOt77exEhhm8oDQ=;
 b=YbZnBWl0mrGp72bTW9zpXqDxEUkfCNV8om6wPPKckg7gT9cMx6naNppYQk8hnoFnB7/b50
 YJAZtPDnphyHyswhtj+wwQCc1wboCqIRWY6AY7iZG/NcSLFUbk0nNxlNg6hbs+UhMUT49W
 K5sCcNX16EaEfn+Yvw9h0MsbBuEvWFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635257581;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XbEe7XTfvgNv4WiN4RPgAkB2tN5BIOt77exEhhm8oDQ=;
 b=va+/4kPKU/gfOPR3987UVA9nt/HFgaHva2g9UyA6ybHxsjfF3rms0YbdHrr0bvX6gVw/pH
 H1cIa1xWAeYOQrDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C35B13B06;
 Tue, 26 Oct 2021 14:13:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7g7ABO0MeGH0DgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 26 Oct 2021 14:13:01 +0000
Date: Tue, 26 Oct 2021 16:13:50 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YXgNHp6K/7CqyumH@yuki>
References: <1634562888-5987-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1634562888-5987-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 06/11] lapi/quotactl.h: Add fallback for
 quotactl_fd
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
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  configure.ac                                    |  1 +
>  include/lapi/quotactl.h                         | 16 +++++++++++++++-
>  testcases/kernel/syscalls/quotactl/quotactl01.c |  2 +-
>  testcases/kernel/syscalls/quotactl/quotactl04.c |  2 +-
>  testcases/kernel/syscalls/quotactl/quotactl07.c |  2 +-
>  5 files changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 5bf3c52ec..859aa9857 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -122,6 +122,7 @@ AC_CHECK_FUNCS_ONCE([ \
>      profil \
>      pwritev \
>      pwritev2 \
> +    quotactl_fd \
>      rand_r \
>      readlinkat \
>      recvmmsg \
> diff --git a/include/lapi/quotactl.h b/include/lapi/quotactl.h
> index 348b70b58..e265a6708 100644
> --- a/include/lapi/quotactl.h
> +++ b/include/lapi/quotactl.h
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * Copyright (c) 2017-2019 Fujitsu Ltd.
> + * Copyright (c) 2017-2021 FUJITSU LIMITED. All rights reserved
>   * Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
>   * Author: Yang Xu <xuyang2018.jy@cn.jujitsu.com>
>   */
> @@ -9,6 +9,20 @@
>  #define LAPI_QUOTACTL_H__
>  
>  #include <sys/quota.h>
> +#include "lapi/syscalls.h"
> +
> +static inline void quotactl_fd_supported(void)
> +{
> +	/* allow the tests to fail early */
> +	tst_syscall(__NR_quotactl_fd);
> +}
> +
> +#ifndef HAVE_QUOTACTL_FD
> +static inline int quotactl_fd(int fd, int cmd, int id, caddr_t addr)
> +{
> +	return tst_syscall(__NR_quotactl_fd, fd, cmd, id, addr);
> +}
> +#endif
>  
>  #ifdef HAVE_STRUCT_IF_NEXTDQBLK
>  # include <linux/quota.h>
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl01.c b/testcases/kernel/syscalls/quotactl/quotactl01.c
> index 4b791a03a..469c47437 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl01.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
> @@ -63,8 +63,8 @@
>  #include <string.h>
>  #include <unistd.h>
>  #include <stdio.h>
> -#include "lapi/quotactl.h"
>  #include "tst_test.h"
> +#include "lapi/quotactl.h"
>  
>  #define USRPATH MNTPOINT "/aquota.user"
>  #define GRPPATH MNTPOINT "/aquota.group"
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl04.c b/testcases/kernel/syscalls/quotactl/quotactl04.c
> index ca6a94263..e01657de5 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl04.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl04.c
> @@ -41,9 +41,9 @@
>  #include <sys/stat.h>
>  #include <sys/mount.h>
>  #include "config.h"
> +#include "tst_test.h"
>  #include "lapi/quotactl.h"
>  #include "tst_safe_stdio.h"
> -#include "tst_test.h"
>  
>  #define FMTID QFMT_VFS_V1
>  #define MNTPOINT	"mntpoint"
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl07.c b/testcases/kernel/syscalls/quotactl/quotactl07.c
> index a55416f0e..f745e9b1c 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl07.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl07.c
> @@ -16,8 +16,8 @@
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <sys/quota.h>
> -#include "lapi/quotactl.h"
>  #include "tst_test.h"
> +#include "lapi/quotactl.h"
>  
>  #ifdef HAVE_XFS_XQM_H
>  # include <xfs/xqm.h>

Unless it breaks compilation the part that shuffles the headers should
go in a separate patch. Or at least it should have been described in the
patch commit message...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
