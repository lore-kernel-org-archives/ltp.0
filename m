Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F42CD342C
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 11:18:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75F743E61FD
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 13:18:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A70663E49A8
 for <ltp@lists.linux.it>; Mon,  4 May 2026 13:17:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7CC9B1A00153
 for <ltp@lists.linux.it>; Mon,  4 May 2026 13:17:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BC0916AADE;
 Mon,  4 May 2026 11:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777893455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jUMR7OPHn8nED9HWOYBOyav0uXDQrvS/xqvKfOOIeCU=;
 b=1iTnaEksyn8XKU2bOhpEg7XvX73i1CsQeuCXU+Q7zsiV8oYdQ6LDXto+tcAffYkRqezQcH
 3qLlGm3Ha/DtS8Nq59ib3rLgvK8nFT6si2A3HrZHAmc+hIlkyH2QERf42kEwPLCaQfU2on
 k6hHK06bC8t1LVIgMPtVQ2QHcdjwEOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777893455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jUMR7OPHn8nED9HWOYBOyav0uXDQrvS/xqvKfOOIeCU=;
 b=xeef6lsSV1+19cM3HAAAls42VVY5ttA40LIVj/8fMl1OJcGt0ti3VtW1nSCV6xSGwe28QF
 6OG63iqeaCJiOtCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1777893455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jUMR7OPHn8nED9HWOYBOyav0uXDQrvS/xqvKfOOIeCU=;
 b=1iTnaEksyn8XKU2bOhpEg7XvX73i1CsQeuCXU+Q7zsiV8oYdQ6LDXto+tcAffYkRqezQcH
 3qLlGm3Ha/DtS8Nq59ib3rLgvK8nFT6si2A3HrZHAmc+hIlkyH2QERf42kEwPLCaQfU2on
 k6hHK06bC8t1LVIgMPtVQ2QHcdjwEOU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1777893455;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jUMR7OPHn8nED9HWOYBOyav0uXDQrvS/xqvKfOOIeCU=;
 b=xeef6lsSV1+19cM3HAAAls42VVY5ttA40LIVj/8fMl1OJcGt0ti3VtW1nSCV6xSGwe28QF
 6OG63iqeaCJiOtCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A5286593A3;
 Mon,  4 May 2026 11:17:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id livbJk+A+GnBEQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 04 May 2026 11:17:35 +0000
Date: Mon, 4 May 2026 13:17:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <afiAUXp-UY52IuKz@yuki.lan>
References: <20260504-safe_splice-v3-0-e5acf4c9193b@suse.com>
 <20260504-safe_splice-v3-1-e5acf4c9193b@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260504-safe_splice-v3-1-e5acf4c9193b@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:email,
 linux.it:url, suse.cz:email, yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] lib: Add SAFE_SPLICE() macro
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Add new SAFE_SPLIT() in lapi/splice.h.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  include/lapi/splice.h | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/include/lapi/splice.h b/include/lapi/splice.h
> index 191b22d2d6397d1efad5e2025be5a2c4370724dc..e346e5cca9f44bd8421c6b99f84cd4646269ac1f 100644
> --- a/include/lapi/splice.h
> +++ b/include/lapi/splice.h
> @@ -7,6 +7,13 @@
>  #ifndef LAPI_SPLICE_H__
>  #define LAPI_SPLICE_H__
>  
> +#ifndef _GNU_SOURCE
> +# define _GNU_SOURCE
> +#endif
> +
> +#include <fcntl.h>
> +#include <sys/types.h>
> +
>  #include "config.h"
>  #include "lapi/syscalls.h"
>  
> @@ -19,4 +26,25 @@ static inline ssize_t splice(int fd_in, loff_t *off_in, int fd_out,
>  }
>  #endif
>  
> +static inline ssize_t safe_splice(const char *file, const int lineno,
> +				   int fd_in, loff_t *off_in,
> +				   int fd_out, loff_t *off_out,
> +				   size_t len, unsigned int flags)
> +{
> +	ssize_t ret;
> +
> +	ret = splice(fd_in, off_in, fd_out, off_out, len, flags);
> +
> +	if (ret < 0) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"splice(%d, %d, %zu) failed", fd_in, fd_out, len);

Why don't we print the offsets?


Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> +	}
> +
> +	return ret;
> +}
> +
> +#define SAFE_SPLICE(fd_in, off_in, fd_out, off_out, len, flags) \
> +	safe_splice(__FILE__, __LINE__, (fd_in), (off_in), (fd_out), \
> +		    (off_out), (len), (flags))
> +
>  #endif /* LAPI_SPLICE_H__ */
> 
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
