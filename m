Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEC3DCAC5B0
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 11:16:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C88623CDEB3
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 13:16:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC4B53CDD33
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 13:16:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 33EFA1400DD1
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 13:16:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 54EFD1F7CF;
 Tue, 23 Sep 2025 11:16:17 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4575F1388C;
 Tue, 23 Sep 2025 11:16:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uxafD4GB0mj3fQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 23 Sep 2025 11:16:17 +0000
Date: Tue, 23 Sep 2025 13:17:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <aNKBrcI4ZuHL8RE0@yuki.lan>
References: <20250922210723.GA44059@pevik>
 <20250923075118.29757-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250923075118.29757-1-akumar@suse.de>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 54EFD1F7CF
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Introduce ioctl_pidfd_get_info_supported()
 function
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
> - use new routine in ioctl_pidfd05 test
> - refactor ioctl_pidfd_info_exit_supported() routine
> 
> Suggested-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd.h | 49 ++++++++++++-------
>  .../kernel/syscalls/ioctl/ioctl_pidfd05.c     |  9 +++-
>  2 files changed, 39 insertions(+), 19 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h b/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
> index 811f969cd..067ef18ba 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
> @@ -9,19 +9,16 @@
>  #include "tst_test.h"
>  #include "lapi/pidfd.h"
>  
> -static inline int ioctl_pidfd_info_exit_supported(void)
> +static inline long ioctl_pidfd_get_info_supported(void)
>  {
> -	int ret;
>  	pid_t pid;
> -	int pidfd;
> -	int supported = 0;
> +	int pidfd, ret;
>  	struct pidfd_info info;
>  
> -	if (tst_kvercmp(6, 15, 0) >= 0)
> +	if (tst_kvercmp(6, 12, 0) >= 0)
>  		return 1;
>  
>  	memset(&info, 0, sizeof(struct pidfd_info));
> -	info.mask = PIDFD_INFO_EXIT;

We have to keep the PIDFD_INFO_EXIT in the mask, otherwise it will never
be set back by the kernel.

>  	pid = SAFE_FORK();
>  	if (!pid)
> @@ -31,23 +28,39 @@ static inline int ioctl_pidfd_info_exit_supported(void)
>  	SAFE_WAITPID(pid, NULL, 0);
>  
>  	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
> +	SAFE_CLOSE(pidfd);
> +
>  	if (ret == -1) {
> -		/* - ENOTTY: old kernels not implementing fs/pidfs.c:pidfd_ioctl
> -		 * - EINVAL: until v6.13 kernel
> -		 * - ESRCH: all kernels between v6.13 and v6.15
> +		/* - ENOTTY: kernel too old, ioctl(PIDFD_GET_INFO) not implemented; return -1 */
> +		if (errno == ENOTTY)
> +			return -1;
> +
> +		/* - EINVAL: ioctl(PIDFD_GET_INFO) exists but invalid args
> +		 * - ESRCH: ioctl(PIDFD_GET_INFO) exists but task already exited
> +		 * both mean supported, but info.mask is not set; return 0
>  		 */
> -		if (errno != ENOTTY &&
> -			errno != EINVAL &&
> -			errno != ESRCH)
> -			tst_brk(TBROK | TERRNO, "ioctl error");
> -	} else {
> -		if (info.mask & PIDFD_INFO_EXIT)
> -			supported = 1;
> +		if (errno == EINVAL || errno == ESRCH)
> +			return 0;

If we do not pass the PIDFD_INFO_EXIT above we will end up with ESRCH
here all the time.

Generally I do not like this code that much, since we depend on the fact
that we get ESCHR from the syscall if PIDFD_INFO_EXIT is not
implemented. Without the PIDFD_INFO_EXIT flag the pidfd_info() syscall
is supposed to work on a process before it's waited for and
PIDFD_INFO_EXIT does not work before the process is waited for, mixing
these two checks is a bit ugly.

> +		tst_brk(TBROK | TERRNO, "unexpected ioctl(PIDFD_GET_INFO) error");
>  	}
>  
> -	SAFE_CLOSE(pidfd);
> +	/* ioctl(PIDFD_GET_INFO) successful; return mask */
> +	return info.mask;
> +}
> +
> +static inline bool ioctl_pidfd_info_exit_supported(void)
> +{
> +	long mask;
> +
> +	if (tst_kvercmp(6, 15, 0) >= 0)
> +		return 1;
> +
> +	mask = ioctl_pidfd_get_info_supported();
> +	if (mask == -1)
> +		return 0;
>  
> -	return supported;
> +	return !!(mask & PIDFD_INFO_EXIT);
>  }
>  
>  #endif
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
> index c379717b3..871f2fe5e 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
> @@ -14,7 +14,7 @@
>  #include "tst_test.h"
>  #include "lapi/pidfd.h"
>  #include "lapi/sched.h"
> -#include "lapi/ioctl.h"
> +#include "ioctl_pidfd.h"
>  
>  struct pidfd_info_invalid {
>  	uint32_t dummy;
> @@ -48,8 +48,15 @@ static void run(void)
>  	SAFE_CLOSE(pidfd);
>  }
>  
> +static void setup(void)
> +{
> +	if (ioctl_pidfd_get_info_supported() == -1)
> +		tst_brk(TCONF, "ioctl(PIDFD_GET_INFO) is not implemented");
> +}
> +
>  static struct tst_test test = {
>  	.test_all = run,
> +	.setup = setup,
>  	.forks_child = 1,
>  	.bufs = (struct tst_buffers []) {
>  		{&args, .size = sizeof(*args)},
> -- 
> 2.51.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
