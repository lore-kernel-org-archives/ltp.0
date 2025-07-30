Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67C3C87FCB
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 08:25:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DE803CAD72
	for <ltp@archiver.kernel.org>; Wed, 30 Jul 2025 10:25:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17E7F3C79EE
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 10:24:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1B978140007F
 for <ltp@lists.linux.it>; Wed, 30 Jul 2025 10:24:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 61BC921958;
 Wed, 30 Jul 2025 08:24:42 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3431A1388B;
 Wed, 30 Jul 2025 08:24:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kyebCsrWiWiEVQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Jul 2025 08:24:42 +0000
Date: Wed, 30 Jul 2025 10:24:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250730082435.GC54941@pevik>
References: <20250730-ioctl_pidfd01_selinux-v3-1-be5a56358b78@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250730-ioctl_pidfd01_selinux-v3-1-be5a56358b78@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 61BC921958
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ioctl_pidfd01: check EACCESS error when
 SELinux is enabled
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

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> When SELinux is enabled with enforcing policy, ioctl_pidfd01 might fail
> with EACCESS. This is an error triggered by ioctl() syscall, before we
> actually reach the code we are about to test, so we need to consider
> this errno just in case enforcing policy is on.

Thanks!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

ALso, we have yet another bug on some older kernel versions (found on 6.12 and
6.13, but 6.16 is not affected)
ioctl_pidfd.h:32: TBROK: ioctl(3,((((2U|1U) << (((0+8)+8)+14)) | (((0xFF)) << (0+8)) | (((11)) << 0) | ((((sizeof(struct pidfd_info)))) << ((0+8)+8)))),...) failed: ESRCH (3)

Kind regards,
Petr

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Following errors are caused by SELinux, trying to block any access to
> the file descriptor before actually accessing to it.

> ioctl_pidfd01.c:37: TINFO: io uring -> ...
> ioctl_pidfd01.c:28: TFAIL: ioctl(io uring, PIDFD_GET_INFO, info) expected EINVAL, EBADF, ENOTTY: EACCES (13)
> ---
> Changes in v3:
> - verify for EACCESS only
> - Link to v2: https://lore.kernel.org/r/20250729-ioctl_pidfd01_selinux-v2-1-2d92c0e56b25@suse.com

> Changes in v2:
> - disable the whole test if enforcing policy is on
> - Link to v1: https://lore.kernel.org/r/20250729-ioctl_pidfd01_selinux-v1-1-432e100a5a53@suse.com
> ---
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
> index 92c51c6c0d0dcbb2308c1a8d82b2a92650f3a6b3..a786b25b495b7b465ef8a2c410ae6c11e0e01763 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
> @@ -10,10 +10,12 @@

>  #include "ioctl_pidfd.h"

> +static int exp_errnos_num;
>  static int exp_errnos[] = {
>  	EINVAL,
>  	EBADF,
>  	ENOTTY,
> +	EACCES,
>  };

>  static struct pidfd_info *info;
> @@ -26,7 +28,7 @@ static void test_bad_pidfd(struct tst_fd *fd_in)
>  	}

>  	TST_EXP_FAIL_ARR(ioctl(fd_in->fd, PIDFD_GET_INFO, info),
> -		  exp_errnos, ARRAY_SIZE(exp_errnos),
> +		  exp_errnos, exp_errnos_num,
>  		  "ioctl(%s, PIDFD_GET_INFO, info)",
>  		  tst_fd_desc(fd_in));
>  }
> @@ -44,6 +46,11 @@ static void setup(void)
>  	if (!ioctl_pidfd_info_exit_supported())
>  		tst_brk(TCONF, "PIDFD_INFO_EXIT is not supported by ioctl()");

> +	exp_errnos_num = ARRAY_SIZE(exp_errnos) - 1;
> +
> +	if (tst_selinux_enforcing())
> +		exp_errnos_num++;
> +
>  	info->mask = PIDFD_INFO_EXIT;
>  }


> ---
> base-commit: 91e6272febf95e19a8300695dfc2089569adf9d8
> change-id: 20250729-ioctl_pidfd01_selinux-1479ea457850

> Best regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
