Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D45D1D482
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 17:10:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C91A03C666D
	for <ltp@archiver.kernel.org>; Thu,  8 Jan 2026 18:10:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E0963C0032
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 18:09:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 986182001CA
 for <ltp@lists.linux.it>; Thu,  8 Jan 2026 18:09:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2CCD55CA1C;
 Thu,  8 Jan 2026 17:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767892185;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tB3lCj9efRtmDRQim/pWAWw0EQtkTbd8Aga1niOFH8=;
 b=g4fy8IzLthAjNoNXWavtaCZrYduA6tgg88VPA/uH+7pGbyKbZH60a0ajEBvkkmFfbTYJzf
 lOfBT/D8S3y7OJBNZvCkrkX2PwCIc2uLtaacf9qQRcsTqBA5um5zIIGCcgwrR16y0vdvRf
 z6D4QHZAZ53t509+6pUNdBCxNGQJvzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767892185;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tB3lCj9efRtmDRQim/pWAWw0EQtkTbd8Aga1niOFH8=;
 b=gkuZw2QLXEV6eirGMB8Ss4z52DAkZV1ULWJRo2i4AN9qxGMq/I3gPZYNnsvwSTeT7jU5+Q
 DnPizCegehnkWoDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767892185;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tB3lCj9efRtmDRQim/pWAWw0EQtkTbd8Aga1niOFH8=;
 b=g4fy8IzLthAjNoNXWavtaCZrYduA6tgg88VPA/uH+7pGbyKbZH60a0ajEBvkkmFfbTYJzf
 lOfBT/D8S3y7OJBNZvCkrkX2PwCIc2uLtaacf9qQRcsTqBA5um5zIIGCcgwrR16y0vdvRf
 z6D4QHZAZ53t509+6pUNdBCxNGQJvzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767892185;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1tB3lCj9efRtmDRQim/pWAWw0EQtkTbd8Aga1niOFH8=;
 b=gkuZw2QLXEV6eirGMB8Ss4z52DAkZV1ULWJRo2i4AN9qxGMq/I3gPZYNnsvwSTeT7jU5+Q
 DnPizCegehnkWoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00ED23EA63;
 Thu,  8 Jan 2026 17:09:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eweCONjkX2nRZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 08 Jan 2026 17:09:44 +0000
Date: Thu, 8 Jan 2026 18:09:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Message-ID: <20260108170938.GA28911@pevik>
References: <20260108162152.104192-1-po-hsu.lin@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260108162152.104192-1-po-hsu.lin@canonical.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email,canonical.com:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCHv4] listmount04.c: update struct mnt_id_req support
 to kernel >= 6.17.9
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

Hi Po-Hsu Lin,

> The kernel change 78f0e33cd6c93 ("fs/namespace: correctly handle errors
> returned by grab_requested_mnt_ns") from 6.18 has been ported to upstream
> 6.17.9 [1][2].

> Therefore change the expectation from >= 6.18 to >= 6.17 accodingly.

> [1] https://lwn.net/Articles/1047684/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.17.9&id=8ff97ade

> v2: add comments for this change into the code.
> v3: correct the RST syntax and move comment as suggested by Petr Vorel.
> v4: correct the patch title.

Thank you, LGTM now.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  .../kernel/syscalls/listmount/listmount04.c   | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

> diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
> index 2b8b49101..919f4c854 100644
> --- a/testcases/kernel/syscalls/listmount/listmount04.c
> +++ b/testcases/kernel/syscalls/listmount/listmount04.c
> @@ -7,6 +7,7 @@
>   * Verify that listmount() raises the correct errors according with
>   * invalid data:
>   *
> + * - EBADF: invalid mnt_ns_fd
>   * - EFAULT: req or mnt_id are unaccessible memories
>   * - EINVAL: invalid flags or mnt_id request
>   * - ENOENT: non-existent mount point
> @@ -20,8 +21,12 @@
>  #include "lapi/syscalls.h"

>  #define MNT_SIZE 32
> -#define BEFORE_6_18 1
> -#define AFTER_6_18 2
> +/*
> + * For commit 78f0e33cd6c9 ("fs/namespace: correctly handle errors returned
> + * by grab_requested_mnt_ns") from v6.18-rc7 backported to v6.17.9.
> + */
> +#define BEFORE_6_17_9 1
> +#define AFTER_6_17_9 2

>  static mnt_id_req *request;
>  static uint64_t mnt_ids[MNT_SIZE];
> @@ -84,7 +89,7 @@ static struct tcase {
>  		.nr_mnt_ids = MNT_SIZE,
>  		.exp_errno = EINVAL,
>  		.msg = "invalid mnt_id_req.spare",
> -		.kver = BEFORE_6_18,
> +		.kver = BEFORE_6_17_9,
>  	},
>  	{
>  		.req_usage = 1,
> @@ -95,7 +100,7 @@ static struct tcase {
>  		.nr_mnt_ids = MNT_SIZE,
>  		.exp_errno = EBADF,
>  		.msg = "invalid mnt_id_req.mnt_ns_fd",
> -		.kver = AFTER_6_18,
> +		.kver = AFTER_6_17_9,
>  	},
>  	{
>  		.req_usage = 1,
> @@ -154,10 +159,10 @@ static void run(unsigned int n)

>  static void setup(void)
>  {
> -	if (tst_kvercmp(6, 18, 0) >= 0)
> -		kver = AFTER_6_18;
> +	if (tst_kvercmp(6, 17, 9) >= 0)
> +		kver = AFTER_6_17_9;
>  	else
> -		kver = BEFORE_6_18;
> +		kver = BEFORE_6_17_9;
>  }

>  static struct tst_test test = {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
