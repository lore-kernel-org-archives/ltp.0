Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381B1C0218D
	for <ltp@archiver.kernel.org>; Fri, 31 Jan 2025 08:37:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DB5E3C7ABC
	for <ltp@archiver.kernel.org>; Fri, 31 Jan 2025 09:37:26 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0DBD3C0978
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 09:37:09 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B137227938D
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 09:37:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2344B1F38D;
 Fri, 31 Jan 2025 08:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738312624;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P1pWRSsH2VyfmBMNDMMQh5RFuph/RdWDPN1SZdTVh7c=;
 b=VYAAOLM7FuTOa+rsibIjKOINzhn5B4qrWfYTDwzJV3DeCPRWteNuFEOSwgpAnPptClpCh2
 5WujTH9gQ1KQ2OCNJrLYcXzsd7X9c8o84rxzPlWGRfz7PaWXizmISpc7MvX39r7Msj9uOW
 OAl17VATSK3rGn8B7cljw0HEHtbT7/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738312624;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P1pWRSsH2VyfmBMNDMMQh5RFuph/RdWDPN1SZdTVh7c=;
 b=N23PPQmO4HxN6ZWyLTzsagJGxY6W9ekkz4Yi/sTjGmBUs8opgwBYqKzx7CyimdJIyfZe2p
 JVIZUAak2wtlJzDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738312623;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P1pWRSsH2VyfmBMNDMMQh5RFuph/RdWDPN1SZdTVh7c=;
 b=GXTs44J+NGwVJ4UJv++wLZr8b/pfX6j4EQdnAxyYa7eoAVyrZOHpi7UKelukFHysi8Z+gt
 ZIT3rOLwTYx2d13uXE5NvTfEkVBj2XXWpdmepZX4U6rhbwnNshZ9tX9LiX8p3WOQBJ6Zh7
 FPfEjegy/G8LQbwvClMwrUSOhWThf9o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738312623;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P1pWRSsH2VyfmBMNDMMQh5RFuph/RdWDPN1SZdTVh7c=;
 b=V2tQC3CM4Wtw/puHZGdbRzf5HmZd9OXSUBaZMTk57vAsm9xoNbW14sN6E43uGBjsbHJyob
 ufntxd8Vvw0G6EBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F3F1C133A6;
 Fri, 31 Jan 2025 08:37:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JF9BOq6LnGd+DQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 31 Jan 2025 08:37:02 +0000
Date: Fri, 31 Jan 2025 09:36:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250131083653.GA1072273@pevik>
References: <20250127-xattrat-v1-0-c3ee31e2543b@suse.com>
 <20250127-xattrat-v1-2-c3ee31e2543b@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250127-xattrat-v1-2-c3ee31e2543b@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/8] lapi: add struct xattr_args fallback
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

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  configure.ac         |  1 +
>  include/lapi/xattr.h | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)

> diff --git a/configure.ac b/configure.ac
> index 6992d75ca300ccc4cc21a45a916f6b3be1a3b8fe..eb1a966322313cf785c25af0f317700418186927 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -247,6 +247,7 @@ AC_CHECK_TYPES([struct cachestat_range],,,[#include <sys/mman.h>])
>  AC_CHECK_TYPES([struct cachestat],,,[#include <sys/mman.h>])
>  AC_CHECK_TYPES([struct mnt_id_req],,,[#include <linux/mount.h>])
>  AC_CHECK_TYPES([struct statmount],,,[#include <linux/mount.h>])
> +AC_CHECK_TYPES([struct xattr_args],,,[#include <linux/xattr.h>])

>  # Tools knobs

> diff --git a/include/lapi/xattr.h b/include/lapi/xattr.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..b30b24ac0dce04ee225a7609e92fb7af8b545283
> --- /dev/null
> +++ b/include/lapi/xattr.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (c) 2025 Linux Test Project
> + */
> +
> +#ifndef LAPI_XATTR_H__
> +#define LAPI_XATTR_H__

> +
> +#include <stdint.h>

Could you, please, move conditional include from tests to this lapi header?

#ifdef HAVE_LINUX_XATTR_H
# include <linux/xattr.h>
#endif

That's the way we agreed in the past (tests include just a lapi header, not a
kernel one).

Otherwise LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +
> +#ifndef STRUCT_XATTR_ARGS
> +struct xattr_args {
> +	void *value;
> +	uint32_t size;
> +	uint32_t flags;
> +};
> +#endif
> +
> +#endif /* LAPI_XATTR_H__ */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
