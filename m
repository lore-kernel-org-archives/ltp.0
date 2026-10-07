Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9471ACA5FF1
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 10:00:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 669E13E9C8A
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 12:00:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5455A3E6C17
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 11:59:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 76FF31A003D2
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 11:59:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 595191F441;
 Wed,  7 Oct 2026 09:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791367184;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zsqNh53HtWB2sAjtXfG2nCisfuB03mXPtd9eQK5XWLU=;
 b=A3mq0EvXL8A7guPy2F8vpv/d9+BuzRsAJ2Sk10ahDvu7MFSw9j6P0uNCVQBPRqXLG+1ahc
 pUTb7egZ6L+RjDT0pHH/69GG8w7QQ6e+R3ItRAgdmyfvNpSKWpK1pYNdW97G/aZ4kZIktd
 2yxKxUEHDYZTEGGK+1l2IvUjI7+ZdnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791367184;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zsqNh53HtWB2sAjtXfG2nCisfuB03mXPtd9eQK5XWLU=;
 b=7jkxIWkoOagSV0COfkys2n7htHI2X4b/AIf8G8si1WNNDORoZhv8YQWe1wjcUlUX9vjpnW
 2fGF+zKedX9xjUBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=A3mq0EvX;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7jkxIWko
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791367184;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zsqNh53HtWB2sAjtXfG2nCisfuB03mXPtd9eQK5XWLU=;
 b=A3mq0EvXL8A7guPy2F8vpv/d9+BuzRsAJ2Sk10ahDvu7MFSw9j6P0uNCVQBPRqXLG+1ahc
 pUTb7egZ6L+RjDT0pHH/69GG8w7QQ6e+R3ItRAgdmyfvNpSKWpK1pYNdW97G/aZ4kZIktd
 2yxKxUEHDYZTEGGK+1l2IvUjI7+ZdnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791367184;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zsqNh53HtWB2sAjtXfG2nCisfuB03mXPtd9eQK5XWLU=;
 b=7jkxIWkoOagSV0COfkys2n7htHI2X4b/AIf8G8si1WNNDORoZhv8YQWe1wjcUlUX9vjpnW
 2fGF+zKedX9xjUBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D1ED13B97;
 Wed,  7 Oct 2026 09:59:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4/mfOA8YxmoXJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 Oct 2026 09:59:44 +0000
Date: Wed, 7 Oct 2026 11:59:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wake Liu <wakel@google.com>
Message-ID: <20261007095938.GA3295049@pevik>
References: <20261002130546.1236713-1-wakel@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261002130546.1236713-1-wakel@google.com>
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 595191F441
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] keyctl: Fix struct keyctl_dh_params build on
 Bionic
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

Hi Wake Liu, Cyril,

> Bionic generates its copy of the UAPI headers with the C++ keyword

Ah, we forget on the most used C++ libc when we prepared 71353a6c009b.

> 'private' renamed to '__linux_private', so its struct keyctl_dh_params
> only provides the 'priv' alias added in kernel 4.20. Since keyctl25-28
> were switched to 'private', they fail to build on Android:

>     error: no member named 'private' in 'struct keyctl_dh_params'

> Detect the 'private' member in configure and access the member via a
> new KEYCTL_DH_PRIVATE() macro, which falls back to 'priv' when
> 'private' is not available, similar to FSID_VAL_MEMBER() in
> lapi/fanotify.h.

> Checking for 'private' rather than 'priv' leaves every build whose UAPI
> headers provide 'private' unchanged, including headers older than 4.20
> which lack 'priv'. It also makes 'priv' the default when configure is
> not run, as in the Android build, which uses a hand-maintained
> config.h. The LTP fallback definition provides both members.

> Fixes: 71353a6c009b ("keyctl: Use struct keyctl_dh_params 'private' instead of 'priv'")
> Signed-off-by: Wake Liu <wakel@google.com>

Looks like we cannot avoid struct keyctl_dh_params.private. Make sense.
Cc Cyril just in case he has some different idea.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> ---
>  configure.ac                                |  1 +
>  include/lapi/keyctl.h                       | 14 ++++++++++++++
>  testcases/kernel/syscalls/keyctl/keyctl25.c |  5 +++--
>  testcases/kernel/syscalls/keyctl/keyctl26.c |  5 +++--
>  testcases/kernel/syscalls/keyctl/keyctl27.c |  5 +++--
>  testcases/kernel/syscalls/keyctl/keyctl28.c |  2 +-
>  6 files changed, 25 insertions(+), 7 deletions(-)

> diff --git a/configure.ac b/configure.ac
> index e979de0e7..4087856c8 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -302,6 +302,7 @@ AC_CHECK_TYPES([struct uffdio_writeprotect],,,[#include <linux/userfaultfd.h>])
>  AC_CHECK_TYPES([struct keyctl_dh_params, struct keyctl_kdf_params,
>  	struct keyctl_pkey_query, struct keyctl_pkey_params],,,
>  	[#include <linux/keyctl.h>])
> +AC_CHECK_MEMBERS([struct keyctl_dh_params.private],,,[#include <linux/keyctl.h>])

>  # Tools knobs

> diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
> index eb4d25c42..788c4d509 100644
> --- a/include/lapi/keyctl.h
> +++ b/include/lapi/keyctl.h
> @@ -67,6 +67,20 @@ struct keyctl_dh_params {
>  };
>  #endif

> +/**
> + * KEYCTL_DH_PRIVATE - Access the private key in struct keyctl_dh_params.
> + * @params: Pointer to struct keyctl_dh_params.
> + *
> + * Uses 'private' if the UAPI headers provide it, 'priv' otherwise. UAPI
> + * headers older than 4.20 provide only 'private'. Bionic renames 'private'
> + * (a C++ keyword) to '__linux_private', so only 'priv' is usable there.
> + */
> +#ifdef HAVE_STRUCT_KEYCTL_DH_PARAMS_PRIVATE
> +# define KEYCTL_DH_PRIVATE(params) ((params)->private)
> +#else
> +# define KEYCTL_DH_PRIVATE(params) ((params)->priv)
> +#endif
> +
>  #ifndef HAVE_STRUCT_KEYCTL_KDF_PARAMS
>  struct keyctl_kdf_params {
>  	char *hashname;
> diff --git a/testcases/kernel/syscalls/keyctl/keyctl25.c b/testcases/kernel/syscalls/keyctl/keyctl25.c
> index 84e76c019..80a341cf3 100644
> --- a/testcases/kernel/syscalls/keyctl/keyctl25.c
> +++ b/testcases/kernel/syscalls/keyctl/keyctl25.c
> @@ -22,8 +22,9 @@ static void setup(void)
>  {
>  	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);

> -	dh_params->private = SAFE_NEW_USER_KEY("dh_priv", dh_priv, sizeof(dh_priv),
> -				       KEY_SPEC_PROCESS_KEYRING);
> +	KEYCTL_DH_PRIVATE(dh_params) =
> +		SAFE_NEW_USER_KEY("dh_priv", dh_priv, sizeof(dh_priv),
> +				  KEY_SPEC_PROCESS_KEYRING);
>  	dh_params->prime = SAFE_NEW_USER_KEY("dh_prime", dh_prime, sizeof(dh_prime),
>  					KEY_SPEC_PROCESS_KEYRING);
>  	dh_params->base = SAFE_NEW_USER_KEY("dh_base", dh_base, sizeof(dh_base),
...

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
