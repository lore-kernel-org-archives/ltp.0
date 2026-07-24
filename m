Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BFDC531C9
	for <ltp@archiver.kernel.org>; Fri, 24 Jul 2026 12:11:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94EF63E290A
	for <ltp@archiver.kernel.org>; Fri, 24 Jul 2026 14:11:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C25313C0401
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 14:11:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2CC81200049
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 14:11:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E969A7B72C;
 Fri, 24 Jul 2026 12:11:20 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5EDF779BA;
 Fri, 24 Jul 2026 12:11:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id M4ZRM2hWY2pTVQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Jul 2026 12:11:20 +0000
Date: Fri, 24 Jul 2026 14:11:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wake Liu <wakel@google.com>
Message-ID: <20260724121114.GB983347@pevik>
References: <20260724095737.3631000-1-wakel@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260724095737.3631000-1-wakel@google.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: E969A7B72C
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] listmount04: Detect EBADF behavior dynamically at
 runtime
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

> Upstream commit 78f0e33cd6c9 ("fs/namespace: correctly handle errors
> returned by grab_requested_mnt_ns") changed the errno from EINVAL to
> EBADF when an invalid mount namespace file descriptor is passed to
> listmount(). This change has been backported to various stable kernels
> (e.g., 6.12.59 LTS).

> Instead of hardcoding version checks for every stable backport, probe
> the behavior dynamically in setup() by calling listmount() with an
> invalid fd (-1) and checking the returned errno.

> Signed-off-by: Wake Liu <wakel@google.com>
> ---
>  .../kernel/syscalls/listmount/listmount04.c   | 27 ++++++++++++++++---
>  1 file changed, 23 insertions(+), 4 deletions(-)

> diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
> index 919f4c854..f7343608f 100644
> --- a/testcases/kernel/syscalls/listmount/listmount04.c
> +++ b/testcases/kernel/syscalls/listmount/listmount04.c
> @@ -153,16 +153,35 @@ static void run(unsigned int n)
>  	}

>  	TST_EXP_FAIL(tst_syscall(__NR_listmount, req, tc->mnt_ids,
> -		tc->nr_mnt_ids, tc->flags), tc->exp_errno,
> -		"%s", tc->msg);
> +				 tc->nr_mnt_ids, tc->flags),
> +		     tc->exp_errno,
> +		     "%s", tc->msg);
>  }

>  static void setup(void)
>  {
> -	if (tst_kvercmp(6, 17, 9) >= 0)
> +	mnt_id_req req = {
> +		.size = MNT_ID_REQ_SIZE_VER0,
> +		.mnt_id = LSMT_ROOT,
> +		.mnt_ns_fd = -1,
> +	};
> +	uint64_t ids[MNT_SIZE];
> +
> +	TEST(tst_syscall(__NR_listmount, &req, ids, MNT_SIZE, 0));
I wonder if we should use listmount() from listmount.h.

> +	if (TST_RET >= 0)
> +		tst_brk(TBROK, "listmount() succeeded unexpectedly with invalid fd");
Maybe we could have TST_EXP_FAIL_ARR_SILENT_BRK() in the future :)

> +
> +	if (TST_ERR == EBADF) {
>  		kver = AFTER_6_17_9;
At this point we may rename macros back to AFTER_6_18 and BEFORE_6_18, with
keeping note that it got backported into stable.

> -	else
> +		tst_res(TINFO, "Detected kernel with EBADF behavior for invalid mnt_ns_fd");
> +	} else if (TST_ERR == EINVAL) {
>  		kver = BEFORE_6_17_9;
> +		tst_res(TINFO, "Detected kernel with EINVAL behavior for invalid mnt_ns_fd");
> +	} else if (TST_ERR == ENOSYS) {
> +		tst_brk(TCONF, "listmount() syscall not supported");
This is IMHO not supported, because it's part of tst_syscall().
Other than this LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +	} else {
> +		tst_brk(TBROK | TTERRNO, "Unexpected error during probe");
> +	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
