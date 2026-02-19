Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67897E9A05F
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 20:06:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D06E23D073D
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 21:06:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 636023CAC50
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 21:06:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EBED82002A1
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 21:06:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5FD5F5BD0F;
 Thu, 19 Feb 2026 20:06:20 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90F683EA65;
 Thu, 19 Feb 2026 20:06:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id izTNHDttl2mmTQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 19 Feb 2026 20:06:19 +0000
Date: Thu, 19 Feb 2026 21:06:02 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Polensky <japo@linux.ibm.com>
Message-ID: <20260219200602.GA341772@pevik>
References: <20260219163030.69022-1-japo@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260219163030.69022-1-japo@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 5FD5F5BD0F
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] [STAGING] ioctl_pidfd06: accept
 EREMOTE/ESRCH for PIDFD_GET_INFO across pidns
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan,

> PIDFD_GET_INFO semantics changed for pidfds referring to tasks without a PID
> in the caller's current pid namespace (commit ab89060fbc92e ("pidfs: return
> -EREMOTE when PIDFD_GET_INFO is called on another ns")).

> Accept both errnos to keep the test working on kernels with and without the
> change (including backports).

LGTM, thanks!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
> index 751281bacb74..6b4bc3191e37 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd06.c
> @@ -14,6 +14,7 @@

>  static struct tst_clone_args *args;
>  static struct pidfd_info *info;
> +static const int exp_errnos[] = {EREMOTE, ESRCH};

>  static void run(void)
>  {
> @@ -41,7 +42,8 @@ static void run(void)
>  	args->exit_signal = SIGCHLD;

>  	if (!SAFE_CLONE(args)) {
> -		TST_EXP_FAIL(ioctl(pidfd, PIDFD_GET_INFO, info), ESRCH);
> +		TST_EXP_FAIL_ARR(ioctl(pidfd, PIDFD_GET_INFO, info), exp_errnos,
> +				ARRAY_SIZE(exp_errnos));
>  		exit(0);
>  	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
