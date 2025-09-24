Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FE1CAC5A5
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 08:34:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 60F7A3CDF36
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 10:34:20 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04B513CCD6F
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 10:34:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5AC531A0081A
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 10:34:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CF8122208D;
 Wed, 24 Sep 2025 08:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758702838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8tc7/lGW9TRTiPZuteHkeJkR7sL6vy4RfiQ4PFALwbI=;
 b=nzGsJrw0oregNBMP1WXCB1VkrCQziGAm/ebj4tGhwpyeUJObYbuxQkHCW3286FM4U31xQD
 UU8Pqt73RhPzdPPYvb80pcVpEHeIxtp3+uZcxl8RgHkWq3HC6OcizfuZXPS97mEIfHjaLE
 qzuNBs4qqGV23p9Lb+HEHYGl6WkwT3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758702838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8tc7/lGW9TRTiPZuteHkeJkR7sL6vy4RfiQ4PFALwbI=;
 b=TELdlIrzW1Zg1tokB3Ypajjz5jgtVqcneNGTXkXwQIabGbcdn40cdTQoYVIy/u+XeFgeWL
 QHLxrP9iRNfVwNAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758702838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8tc7/lGW9TRTiPZuteHkeJkR7sL6vy4RfiQ4PFALwbI=;
 b=nzGsJrw0oregNBMP1WXCB1VkrCQziGAm/ebj4tGhwpyeUJObYbuxQkHCW3286FM4U31xQD
 UU8Pqt73RhPzdPPYvb80pcVpEHeIxtp3+uZcxl8RgHkWq3HC6OcizfuZXPS97mEIfHjaLE
 qzuNBs4qqGV23p9Lb+HEHYGl6WkwT3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758702838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8tc7/lGW9TRTiPZuteHkeJkR7sL6vy4RfiQ4PFALwbI=;
 b=TELdlIrzW1Zg1tokB3Ypajjz5jgtVqcneNGTXkXwQIabGbcdn40cdTQoYVIy/u+XeFgeWL
 QHLxrP9iRNfVwNAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B85C113A61;
 Wed, 24 Sep 2025 08:33:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yQOSK/as02g1AgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Sep 2025 08:33:58 +0000
Date: Wed, 24 Sep 2025 10:34:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <aNOtI3crFfbKofHt@yuki.lan>
References: <aNKJP8fKNn6JcT5I@yuki.lan> <20250923150337.19821-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250923150337.19821-1-akumar@suse.de>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Introduce ioctl_pidfd_get_info_supported()
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
> +static inline bool ioctl_pidfd_get_info_supported(void)
> +{
> +	pid_t pid;
> +	int pidfd, ret;
> +	int supported = 0;
> +	struct pidfd_info info;
> +
> +	if (tst_kvercmp(6, 12, 0) >= 0)
> +		return 1;
> +
> +	memset(&info, 0, sizeof(struct pidfd_info));
> +
> +	pid = SAFE_FORK();
> +	if (!pid)
> +		exit(100);
> +
> +	pidfd = SAFE_PIDFD_OPEN(pid, 0);
> +	SAFE_WAITPID(pid, NULL, 0);

Again, please do not waitpid before the PIDFD_GET_INFO ioctl(). If you
do that it has no chance of succeeding.

From fs/pidfd.c:

...
        task = get_pid_task(pid, PIDTYPE_PID);
        if (!task) {
                /*
                 * If the task has already been reaped, only exit
                 * information is available
                 */
                if (!(mask & PIDFD_INFO_EXIT))
                        return -ESRCH;

                goto copy_out;
        }
...

We have to do the ioctl() first and the waitpid() second for this case.

And if we do so we don't have to check the errno at all, the call will
just succeed in case that it's supported.

> +	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
> +	SAFE_CLOSE(pidfd);
> +
> +	if (ret == -1) {
> +		/* - ENOTTY: kernel too old, ioctl(PIDFD_GET_INFO) not implemented */
> +		if (errno == ENOTTY)
> +			supported = 0;
> +
> +		/* - EINVAL: ioctl(PIDFD_GET_INFO) exists but args invalid
> +		 * - ESRCH: ioctl(PIDFD_GET_INFO) exists but task already exited
> +		 * supported in both cases, but info.mask not set
> +		 */
> +		else if (errno == EINVAL || errno == ESRCH)
> +			supported = 1;
> +		else
> +			tst_brk(TBROK | TERRNO, "unexpected ioctl(PIDFD_GET_INFO) error");
> +	} else {
> +		supported = 1;
> +	}
> +
> +	return supported;
> +}
> +
>  static inline int ioctl_pidfd_info_exit_supported(void)
>  {
>  	int ret;
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
> index c379717b3..d20c6f074 100644
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
> +	if (!ioctl_pidfd_get_info_supported())
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
