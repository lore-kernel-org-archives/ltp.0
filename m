Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D4E7C87FC9
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 13:02:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BA273CA6BE
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 15:02:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15B883C9FF2
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 15:02:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0E3A010009A1
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 15:02:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DD62E21A06;
 Tue, 29 Jul 2025 13:02:30 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D489313876;
 Tue, 29 Jul 2025 13:02:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4jSmM2bGiGjLFgAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 29 Jul 2025 13:02:30 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 29 Jul 2025 15:02:22 +0200
Message-ID: <2237115.irdbgypaU6@thinkpad>
In-Reply-To: <20250729-ioctl_pidfd01_selinux-v2-1-2d92c0e56b25@suse.com>
References: <20250729-ioctl_pidfd01_selinux-v2-1-2d92c0e56b25@suse.com>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: DD62E21A06
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ioctl_pidfd01: disable with SELinux enforcing
 policy
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

Hi,

Reviewed-by: Avinesh Kumar <akumar@suse.de>

Thanks,
Avinesh

On Tuesday, July 29, 2025 2:16:06 PM CEST Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> When SELinux is enabled with enforcing policy, ioctl_pidfd01 might fail
> with EACCESS. This is an error triggered by ioctl() syscall, before we
> actually reach the code we are about to test, so we need to skip the
> test just in case enforcing policy is on.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> Following errors are caused by SELinux, trying to block any access to
> the file descriptor before actually accessing to it.
> 
> ioctl_pidfd01.c:37: TINFO: io uring -> ...
> ioctl_pidfd01.c:28: TFAIL: ioctl(io uring, PIDFD_GET_INFO, info) expected EINVAL, EBADF, ENOTTY: EACCES (13)
> ---
> Changes in v2:
> - disable the whole test if enforcing policy is on
> - Link to v1: https://lore.kernel.org/r/20250729-ioctl_pidfd01_selinux-v1-1-432e100a5a53@suse.com
> ---
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
> index 92c51c6c0d0dcbb2308c1a8d82b2a92650f3a6b3..22921bfc7f5e7fa11d511f8aab03707426ae62ba 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
> @@ -44,6 +44,9 @@ static void setup(void)
>  	if (!ioctl_pidfd_info_exit_supported())
>  		tst_brk(TCONF, "PIDFD_INFO_EXIT is not supported by ioctl()");
>  
> +	if (tst_selinux_enforcing())
> +		tst_brk(TCONF, "Unstable test with SELinux enforcing mode on");
> +
>  	info->mask = PIDFD_INFO_EXIT;
>  }
>  
> 
> ---
> base-commit: 91e6272febf95e19a8300695dfc2089569adf9d8
> change-id: 20250729-ioctl_pidfd01_selinux-1479ea457850
> 
> Best regards,
> 





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
