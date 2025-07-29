Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994CCC83F26
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 08:33:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0411D3CA20F
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 10:33:11 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E94FA3C9ABA
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 10:32:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 648971000960
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 10:32:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 996AD211D1;
 Tue, 29 Jul 2025 08:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753777968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNjo0t3GKzoyyHVJG5xAjOtoxMX12TobonhoDpsX0g0=;
 b=Is1itEouw0J8GP30Tb46KHVG7Z9bliDMowMY3toaHWmZDS/FgebutRTa+EoQhPF9VtYkoY
 4jF0JTsGoFIsxY/Ol6HIf1OqFP2QtuR4ucmUjdOh9NCC9S3NeTLRuOvVl621D0htAGRMM7
 E9SEHsc/43yXNy4y3FPJ5gXHCBCfJG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753777968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNjo0t3GKzoyyHVJG5xAjOtoxMX12TobonhoDpsX0g0=;
 b=Q5SIr50iwbugmZYOU6Bfrdhu/9Q/cE2rsCPX/47poCGXqC7EDk0oNyQk7szLmMsYfkOSgr
 D5OT2eYWceXe1JAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1753777968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNjo0t3GKzoyyHVJG5xAjOtoxMX12TobonhoDpsX0g0=;
 b=Is1itEouw0J8GP30Tb46KHVG7Z9bliDMowMY3toaHWmZDS/FgebutRTa+EoQhPF9VtYkoY
 4jF0JTsGoFIsxY/Ol6HIf1OqFP2QtuR4ucmUjdOh9NCC9S3NeTLRuOvVl621D0htAGRMM7
 E9SEHsc/43yXNy4y3FPJ5gXHCBCfJG8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1753777968;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xNjo0t3GKzoyyHVJG5xAjOtoxMX12TobonhoDpsX0g0=;
 b=Q5SIr50iwbugmZYOU6Bfrdhu/9Q/cE2rsCPX/47poCGXqC7EDk0oNyQk7szLmMsYfkOSgr
 D5OT2eYWceXe1JAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 913B813A8A;
 Tue, 29 Jul 2025 08:32:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id R4VNIzCHiGi6PQAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 29 Jul 2025 08:32:48 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 29 Jul 2025 10:32:48 +0200
Message-ID: <5913636.DvuYhMxLoT@thinkpad>
In-Reply-To: <20250729-ioctl_pidfd01_selinux-v1-1-432e100a5a53@suse.com>
References: <20250729-ioctl_pidfd01_selinux-v1-1-432e100a5a53@suse.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-7.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; CTE_CASE(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Disable io_uring fd in ioctl_pidfd01 for selinux
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

On Tuesday, July 29, 2025 10:06:45 AM CEST Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Disable io_uring bad file descriptor in ioctl_pidfd01 when SELinux is
> enabled with enforcing mode. The reason is that SELinux inhibits usage
> of the io_uring file descriptor with EACCESS, causing test to fail
> without a real underlying bug.

We also have same failure for memfd_secret case in this test:

ioctl_pidfd01.c:37: TINFO: memfd secret -> ...
ioctl_pidfd01.c:28: TFAIL: ioctl(memfd secret, PIDFD_GET_INFO, info) expected EINVAL, EBADF, ENOTTY: EACCES (13)

If we are opting for skipping the tests when selinux is enforcing mode,
this also needs to be skipped.

> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> ioctl_pidfd01.c:37: TINFO: io uring -> ...
> ioctl_pidfd01.c:28: TFAIL: ioctl(io uring, PIDFD_GET_INFO, info) expected EINVAL, EBADF, ENOTTY: EACCES (13)
> ---
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
> index 92c51c6c0d0dcbb2308c1a8d82b2a92650f3a6b3..1ccb4bcd8a5d4283d29e0a005aef57fbb6753759 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd01.c
> @@ -17,6 +17,7 @@ static int exp_errnos[] = {
>  };
>  
>  static struct pidfd_info *info;
> +static int selinux_enforcing;
>  
>  static void test_bad_pidfd(struct tst_fd *fd_in)
>  {
> @@ -25,6 +26,11 @@ static void test_bad_pidfd(struct tst_fd *fd_in)
>  		return;
>  	}
>  
> +	if (fd_in->type == TST_FD_IO_URING && selinux_enforcing) {
> +		tst_res(TINFO, "Skipping io_uring: SELinux enforcing enabled");
> +		return;
> +	}
> +
>  	TST_EXP_FAIL_ARR(ioctl(fd_in->fd, PIDFD_GET_INFO, info),
>  		  exp_errnos, ARRAY_SIZE(exp_errnos),
>  		  "ioctl(%s, PIDFD_GET_INFO, info)",
> @@ -44,6 +50,8 @@ static void setup(void)
>  	if (!ioctl_pidfd_info_exit_supported())
>  		tst_brk(TCONF, "PIDFD_INFO_EXIT is not supported by ioctl()");
>  
> +	selinux_enforcing = tst_selinux_enforcing();
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

Thanks,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
