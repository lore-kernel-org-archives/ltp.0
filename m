Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A316CD8CB2
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 14:30:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D5BE3E6EE2
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 16:30:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D809B3E183A
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 16:30:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1F38210005A7
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 16:30:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 45A906AD98;
 Wed, 10 Jun 2026 14:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781101817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vJs2hiXekrvfvrxaYglRg0dlwXLSypuP0Fc6KJ8Dj8w=;
 b=bWxVGAmSCl8r1cmpaOUDaPGBeyp+blB0/Z/ZZoKkBIp6OtB+g2KouLqJqvPXHm+vopiDIU
 q/Mgw/PkRCmvnKjS/70TSKpRaCJzXq4VZwAvfZxx2OzZ1sUgHhbeg+Wbyt4a3i43NMVcEE
 ncQrmybksh7T15tCnT2wU9IK4a0S1S8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781101817;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vJs2hiXekrvfvrxaYglRg0dlwXLSypuP0Fc6KJ8Dj8w=;
 b=ZDY5TzDf4V2wvQUMeV6Oj4iJB5Xny1Fx65rxSGWTKSQ5ErvUfhcUTbgsS9K3lCoP1++0a3
 aK2rpY1PNNGmYMAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bWxVGAmS;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZDY5TzDf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781101817; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vJs2hiXekrvfvrxaYglRg0dlwXLSypuP0Fc6KJ8Dj8w=;
 b=bWxVGAmSCl8r1cmpaOUDaPGBeyp+blB0/Z/ZZoKkBIp6OtB+g2KouLqJqvPXHm+vopiDIU
 q/Mgw/PkRCmvnKjS/70TSKpRaCJzXq4VZwAvfZxx2OzZ1sUgHhbeg+Wbyt4a3i43NMVcEE
 ncQrmybksh7T15tCnT2wU9IK4a0S1S8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781101817;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vJs2hiXekrvfvrxaYglRg0dlwXLSypuP0Fc6KJ8Dj8w=;
 b=ZDY5TzDf4V2wvQUMeV6Oj4iJB5Xny1Fx65rxSGWTKSQ5ErvUfhcUTbgsS9K3lCoP1++0a3
 aK2rpY1PNNGmYMAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3795A779A7;
 Wed, 10 Jun 2026 14:30:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MOt5DPl0KWpvZQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 10 Jun 2026 14:30:17 +0000
Date: Wed, 10 Jun 2026 16:30:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Sebastian Chlad <sebastianchlad@gmail.com>
Message-ID: <ail084ZtfQErQjuR@yuki.lan>
References: <89e9004c-4415-4f05-8288-4f73a491d8dd@suse.cz>
 <20260604163909.17853-1-sebastian.chlad@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260604163909.17853-1-sebastian.chlad@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 45A906AD98
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, yuki.lan:mid, linux.it:url,
 suse.cz:email, suse.cz:dkim, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/2] lapi: Add io_uring_clone_buffers and
 RDS_CMSG_ZCOPY_COOKIE fallbacks
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> --- a/include/lapi/io_uring.h
> +++ b/include/lapi/io_uring.h
> @@ -265,6 +265,23 @@ struct io_uring_probe {
>  
>  #endif /* IOSQE_FIXED_FILE */
>  
> +/* linux/io_uring.h: IORING_REGISTER_CLONE_BUFFERS = 30 */
> +#ifndef IORING_REGISTER_CLONE_BUFFERS
> +# define IORING_REGISTER_CLONE_BUFFERS	30
> +#endif
> +
> +/* Argument for IORING_REGISTER_CLONE_BUFFERS (linux/io_uring.h) */
> +#ifndef HAVE_STRUCT_IO_URING_CLONE_BUFFERS
> +struct io_uring_clone_buffers {
> +	uint32_t src_fd;
> +	uint32_t flags;
> +	uint32_t src_off;
> +	uint32_t dst_off;
> +	uint32_t nr;
> +	uint32_t pad[3];
> +};
> +#endif
> +
>  #ifndef IOSQE_IO_HADRLINK
>  /* like LINK, but stronger */
>  #define IOSQE_IO_HARDLINK_BIT	3
> diff --git a/include/lapi/rds.h b/include/lapi/rds.h
> new file mode 100644
> index 000000000..7405a7f37
> --- /dev/null
> +++ b/include/lapi/rds.h
> @@ -0,0 +1,16 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 SUSE LLC Sebastian Chlad <sebastian.chlad@suse.com>
> + */
> +
> +#ifndef LAPI_RDS_H__
> +#define LAPI_RDS_H__
> +
> +#include <linux/rds.h>
> +
> +/* Fallback for older userspace headers (e.g. openSUSE Leap 42.2). */

Generally we do not add such comments that mostly state the obvious.
The less comments like this we add the better, apart from adding visual
noise they also tend to go out of sync with the code.

Please add only the fallbacks without the comments.

> +#ifndef RDS_CMSG_ZCOPY_COOKIE
> +# define RDS_CMSG_ZCOPY_COOKIE	12
> +#endif
> +
> +#endif /* LAPI_RDS_H__ */
> -- 
> 2.51.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
