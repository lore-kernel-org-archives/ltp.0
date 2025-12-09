Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA062D3B7EA
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 11:17:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B77B3D0180
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 12:17:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8064F3CF6F3
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 12:17:34 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 77E13100046C
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 12:17:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9B1665BD61;
 Tue,  9 Dec 2025 11:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765279047;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BnjLfcK7yL8I5smZOGqSHo5H7XlAi89tqNT8+vpxUA4=;
 b=ecoDrz6JTWdCqtzeFUxkgSrhwDM64VZpYwvIsPfkRbC0R/iq50cBufyIXUz26KfUSMu87G
 TzIFZwPbWlgPnrmc15aqFMTMLiWTlNuxm38gCDeH6iVpIyimGyiesiSBwse1IyljCHZUaE
 83oq8gOH4dW9LoXcAop5P8cvZqbni/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765279047;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BnjLfcK7yL8I5smZOGqSHo5H7XlAi89tqNT8+vpxUA4=;
 b=TtiZSLAtInWwH4oKuahGJmgvhxhsCJS7tP+Ea9Qr2IbL/h5Ctvx6rBgywald4XLXqD/2Ew
 +lVNumdjqUdA28BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765279046;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BnjLfcK7yL8I5smZOGqSHo5H7XlAi89tqNT8+vpxUA4=;
 b=pEJLenTYo3fi6VgNKhVLGKQfLzRQcBf/CHnj/7J4eZz0LpT+MBOgPrN+xscTjb54u0ZULz
 y57TT8sy7/PD7+UOgDSCXxNKqc55qBLJjCZp8RcJw1/KQ9DRJpICOljoF3mhesdAq43yXO
 TUWRWAA4SHYlPYbsdetlR6c3aUKs4OA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765279046;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BnjLfcK7yL8I5smZOGqSHo5H7XlAi89tqNT8+vpxUA4=;
 b=W0+A3FYmlJp1pI9Lmq2yZpB9kbX3aMx8Z0MUv2h9S0HsI77Q3WRh8H9Lxev+FAt+XX4quk
 zWO16u7fRBgX7XCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 737083EA63;
 Tue,  9 Dec 2025 11:17:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HLxNGkYFOGn1HwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 09 Dec 2025 11:17:26 +0000
Date: Tue, 9 Dec 2025 12:17:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251209111725.GA756311@pevik>
References: <20251127143959.9416-1-wegao@suse.com>
 <20251209004242.31774-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251209004242.31774-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] listmount04.c: Update case support
 mnt_id_req.mnt_ns_fd
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

Hi Wei,

> New kernel commit lead test case failure with following error message:
"New" will eventually become "old" :). Why not to state that it's change from
v6.18-rc7? (it saves people in the future to search.)

> listmount04.c:128: TFAIL: invalid mnt_id_req.spare expected EINVAL: EBADF (9)

2 things needs to be changed.

> Detail of new kernel commit:
> commit: 78f0e33cd6c939a555aa80dbed2fec6b333a7660
> fs/namespace: correctly handle errors returned by grab_requested_mnt_ns

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  configure.ac                                    |  1 +
>  .../kernel/syscalls/listmount/listmount04.c     | 17 +++++++++++++++++
>  2 files changed, 18 insertions(+)

> diff --git a/configure.ac b/configure.ac
> index 0480f46ca..fcff90799 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -263,6 +263,7 @@ AC_CHECK_TYPES([struct cachestat],,,[#include <sys/mman.h>])

>  # Defined in <linux/mount.h>, but include/lapi/mount.h includes <sys/mount.h> */
>  AC_CHECK_TYPES([struct mnt_id_req],,,[#include <sys/mount.h>])
> +AC_CHECK_MEMBERS([struct mnt_id_req.mnt_ns_fd],,,[#include <sys/mount.h>])
>  AC_CHECK_TYPES([struct statmount],,,[#include <sys/mount.h>])
>  AC_CHECK_MEMBERS([struct statmount.mnt_ns_id],,,[#include <unistd.h>
>  #include <linux/mount.h>])
> diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
> index a52bad064..0a198e6a9 100644
> --- a/testcases/kernel/syscalls/listmount/listmount04.c
> +++ b/testcases/kernel/syscalls/listmount/listmount04.c
> @@ -26,7 +26,11 @@ static uint64_t mnt_ids[MNT_SIZE];
>  static struct tcase {
>  	int req_usage;
>  	uint32_t size;
> +#ifdef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD

Any time you modify configure.ac please remember to use:

#include "config.h"

> +	uint32_t mnt_ns_fd;
> +#else
>  	uint32_t spare;
> +#endif
>  	uint64_t mnt_id;
>  	uint64_t param;
>  	uint64_t *mnt_ids;
> @@ -73,12 +77,21 @@ static struct tcase {
>  	{
>  		.req_usage = 1,
>  		.size = MNT_ID_REQ_SIZE_VER0,
> +#ifdef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> +		.mnt_ns_fd = -1,
> +#else
>  		.spare = -1,
> +#endif
>  		.mnt_id = LSMT_ROOT,
>  		.mnt_ids = mnt_ids,
>  		.nr_mnt_ids = MNT_SIZE,
> +#ifdef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> +		.exp_errno = EBADF,
> +		.msg = "invalid mnt_id_req.mnt_ns_fd bad file descriptor",
> +#else
>  		.exp_errno = EINVAL,
>  		.msg = "invalid mnt_id_req.spare",
> +#endif

I tried to run it on VM with affected (new) libc and old kernel and it fails:

tst_test.c:2028: TINFO: Tested kernel: 6.12.38+deb13-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.12.38-1 (2025-07-16) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/boot/config-6.12.38+deb13-amd64'
tst_test.c:1846: TINFO: Overall timeout per run is 0h 00m 30s
listmount04.c:146: TPASS: request points to unaccessible memory : EFAULT (14)
listmount04.c:146: TPASS: mnt_ids points to unaccessible memory : EFAULT (14)
listmount04.c:146: TPASS: invalid flags : EINVAL (22)
listmount04.c:146: TPASS: insufficient mnt_id_req.size : EINVAL (22)
listmount04.c:146: TFAIL: invalid mnt_id_req.mnt_ns_fd bad file descriptor expected EBADF: EINVAL (22)

Usual "headers vs running kernel mismatch problem".
@Li, @Cyril Do we care about these incompatibilities? Could we just accept both?
Or we don't care?

Obviously it works on new enough kernel (patch change is from 6.18):

tst_test.c:2028: TINFO: Tested kernel: 6.17.11+deb14-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.17.11-1 (2025-12-07) x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/boot/config-6.17.11+deb14-amd64'
tst_test.c:1846: TINFO: Overall timeout per run is 0h 00m 30s
listmount04.c:146: TPASS: request points to unaccessible memory : EFAULT (14)
listmount04.c:146: TPASS: mnt_ids points to unaccessible memory : EFAULT (14)
listmount04.c:146: TPASS: invalid flags : EINVAL (22)
listmount04.c:146: TPASS: insufficient mnt_id_req.size : EINVAL (22)
listmount04.c:146: TPASS: invalid mnt_id_req.mnt_ns_fd bad file descriptor : EBADF (9)
listmount04.c:146: TPASS: invalid mnt_id_req.param : EINVAL (22)
listmount04.c:146: TPASS: invalid mnt_id_req.mnt_id : EINVAL (22)
listmount04.c:146: TPASS: non-existant mnt_id : ENOENT (2)

Kind regards,
Petr

>  	},
>  	{
>  		.req_usage = 1,
> @@ -122,7 +135,11 @@ static void run(unsigned int n)
>  		req->mnt_id = tc->mnt_id;
>  		req->param = tc->param;
>  		req->size = tc->size;
> +#ifdef HAVE_STRUCT_MNT_ID_REQ_MNT_NS_FD
> +		req->mnt_ns_fd = tc->mnt_ns_fd;
> +#else
>  		req->spare = tc->spare;
> +#endif

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
