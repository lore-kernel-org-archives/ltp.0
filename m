Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1336ECF6D28
	for <ltp@archiver.kernel.org>; Wed,  2 Oct 2024 14:14:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89DB23C5ADC
	for <ltp@archiver.kernel.org>; Wed,  2 Oct 2024 16:14:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 271D93C5A3B
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 16:14:00 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 500E51BB9594
 for <ltp@lists.linux.it>; Wed,  2 Oct 2024 16:13:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 232D91FB6A;
 Wed,  2 Oct 2024 14:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727878436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SduEiF9Ik/ZK5SMlOPgQmZLFgXGcZILlq78H7xxnbHI=;
 b=xAJA0isLc9rWGWzZSnBqYFVTlNKtS6xkolEzXCRbJJw2srsjc6X6wERYEcsN8pHYMMBAP7
 FQWhE/bizapmS+ENSy5p+6sy+arU8C/VB1Ps0BdNDjUa6D//MbhblvsaLpmn/oen30P3aG
 2T7C3z/Zvh1I3CuqSYbMUZZmCp11eZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727878436;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SduEiF9Ik/ZK5SMlOPgQmZLFgXGcZILlq78H7xxnbHI=;
 b=ktzIysb+yZepvLYBBcgdX6gKxd+E7MN+rqsJNOl9U0BDL3qo36MMrco1LFcNGzCnHm+NH9
 NfAfSuy5N1sVbQCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727878436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SduEiF9Ik/ZK5SMlOPgQmZLFgXGcZILlq78H7xxnbHI=;
 b=xAJA0isLc9rWGWzZSnBqYFVTlNKtS6xkolEzXCRbJJw2srsjc6X6wERYEcsN8pHYMMBAP7
 FQWhE/bizapmS+ENSy5p+6sy+arU8C/VB1Ps0BdNDjUa6D//MbhblvsaLpmn/oen30P3aG
 2T7C3z/Zvh1I3CuqSYbMUZZmCp11eZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727878436;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SduEiF9Ik/ZK5SMlOPgQmZLFgXGcZILlq78H7xxnbHI=;
 b=ktzIysb+yZepvLYBBcgdX6gKxd+E7MN+rqsJNOl9U0BDL3qo36MMrco1LFcNGzCnHm+NH9
 NfAfSuy5N1sVbQCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 079D613974;
 Wed,  2 Oct 2024 14:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +YC5ACRV/WbdLAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 02 Oct 2024 14:13:56 +0000
Date: Wed, 2 Oct 2024 16:12:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zv1U5dtEseUQyZoC@yuki.lan>
References: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
 <20240909-listmount_statmount-v4-3-39558204ddf0@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240909-listmount_statmount-v4-3-39558204ddf0@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 03/13] Add listmount/statmount fallback
 declarations
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
> diff --git a/configure.ac b/configure.ac
> index ebbf49e28..3dca7c646 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -114,6 +114,7 @@ AC_CHECK_FUNCS_ONCE([ \
>      io_uring_register \
>      io_uring_enter \
>      kcmp \
> +    listmount \
>      mallinfo \
>      mallinfo2 \
>      mallopt \
> @@ -143,6 +144,7 @@ AC_CHECK_FUNCS_ONCE([ \
>      setns \
>      sigpending \
>      splice \
> +    statmount \
>      statx \
>      stime \
>      sync_file_range \

These two checks shouldn't be here because we do not use them at all and
just define cunstom wrappers later on.

> @@ -246,6 +248,8 @@ AC_CHECK_TYPES([struct mount_attr],,,[
>  
>  AC_CHECK_TYPES([struct cachestat_range],,,[#include <sys/mman.h>])
>  AC_CHECK_TYPES([struct cachestat],,,[#include <sys/mman.h>])
> +AC_CHECK_TYPES([struct mnt_id_req],,,[#include <linux/mount.h>])
> +AC_CHECK_TYPES([struct statmount],,,[#include <linux/mount.h>])
>  
>  # Tools knobs
>  
> diff --git a/include/lapi/mount.h b/include/lapi/mount.h
> index c1af944fe..01a0fd2d6 100644
> --- a/include/lapi/mount.h
> +++ b/include/lapi/mount.h
> @@ -2,12 +2,15 @@
>  /*
>   * Copyright (c) Linux Test Project, 2015-2022
>   * Copyright (c) 2015 Cui Bixuan <cuibixuan@huawei.com>
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>   */
>  
>  #ifndef LAPI_MOUNT_H__
>  #define LAPI_MOUNT_H__
>  
> +#include <stdint.h>
>  #include <sys/mount.h>
> +#include "config.h"
>  
>  #ifndef MS_REC
>  # define MS_REC 16384
> @@ -37,4 +40,71 @@
>  # define MS_NOSYMFOLLOW 256
>  #endif
>  
> +#ifndef HAVE_STRUCT_MNT_ID_REQ
> +struct mnt_id_req {
> +	uint32_t size;
> +	uint32_t spare;
> +	uint64_t mnt_id;
> +	uint64_t param;
> +};
> +#endif
> +
> +#ifndef HAVE_STRUCT_STATMOUNT
> +struct statmount {
> +	uint32_t size;
> +	uint32_t __spare1;
> +	uint64_t mask;
> +	uint32_t sb_dev_major;
> +	uint32_t sb_dev_minor;
> +	uint64_t sb_magic;
> +	uint32_t sb_flags;
> +	uint32_t fs_type;
> +	uint64_t mnt_id;
> +	uint64_t mnt_parent_id;
> +	uint32_t mnt_id_old;
> +	uint32_t mnt_parent_id_old;
> +	uint64_t mnt_attr;
> +	uint64_t mnt_propagation;
> +	uint64_t mnt_peer_group;
> +	uint64_t mnt_master;
> +	uint64_t propagate_from;
> +	uint32_t mnt_root;
> +	uint32_t mnt_point;
> +	uint64_t __spare2[50];
> +	char str[];
> +};
> +#endif
> +
> +#ifndef MNT_ID_REQ_SIZE_VER0
> +# define MNT_ID_REQ_SIZE_VER0 24
> +#endif
> +
> +#ifndef STATMOUNT_SB_BASIC
> +# define STATMOUNT_SB_BASIC 0x00000001U
> +#endif
> +
> +#ifndef STATMOUNT_MNT_BASIC
> +# define STATMOUNT_MNT_BASIC 0x00000002U
> +#endif
> +
> +#ifndef STATMOUNT_PROPAGATE_FROM
> +# define STATMOUNT_PROPAGATE_FROM 0x00000004U
> +#endif
> +
> +#ifndef STATMOUNT_MNT_ROOT
> +# define STATMOUNT_MNT_ROOT 0x00000008U
> +#endif
> +
> +#ifndef STATMOUNT_MNT_POINT
> +# define STATMOUNT_MNT_POINT 0x00000010U
> +#endif
> +
> +#ifndef STATMOUNT_FS_TYPE
> +# define STATMOUNT_FS_TYPE 0x00000020U
> +#endif
> +
> +#ifndef LSMT_ROOT
> +# define LSMT_ROOT 0xffffffffffffffff
> +#endif
> +
>  #endif /* LAPI_MOUNT_H__ */

The rest looks fine:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
