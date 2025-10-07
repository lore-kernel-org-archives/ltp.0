Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09C0CCA470
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 15:16:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5831D3CE547
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 17:16:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CD2D03CE1F8
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 17:15:47 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BF69114001E1
 for <ltp@lists.linux.it>; Tue,  7 Oct 2025 17:15:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3235C1F788;
 Tue,  7 Oct 2025 15:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759850145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z0MCpvsEqjQSfFGfDL0rk+up/wbYhyU6Hl6r+1BuakQ=;
 b=knAS93kZDtn9IsODY9AdWj9MR23jRVU7C3DEU8ck/+0+PpR1WNWQqH9jASsxuhd3Q3pv3J
 yVYHN3kk9wTMculqn7TVqc/ysFgNDdAuReGXhl49zMkRwyONeqkeO7P2UmSkcFDRP2/0ND
 e45beDDuaZcx09+o/oGJoXoTvTA47zA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759850145;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z0MCpvsEqjQSfFGfDL0rk+up/wbYhyU6Hl6r+1BuakQ=;
 b=tbWb7APk7d0pOt1D08Wu6CP4fSIjOXXs+BTYMIHu3nNI5+wHE8egmQ1ZY+3wUM+axYDKIq
 fpUbDrxEFMxwz1Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=PkLzljsU;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2Y46lEl1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759850144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z0MCpvsEqjQSfFGfDL0rk+up/wbYhyU6Hl6r+1BuakQ=;
 b=PkLzljsUDp/mMj1RtG1nU3dcQMYg+7VZHP8/WLLhBgw8dsA3ANFXqfxiKvXa3g23Z6FPzZ
 4EoZsr14UuBsUtUziw08kTSxostCCBPfQwJjeaIkeCl0QFHeRjknFCYGYqL/53EfVKMt+g
 gp1NhXWTiMY81gXqjTop7+IBtGFBgVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759850144;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z0MCpvsEqjQSfFGfDL0rk+up/wbYhyU6Hl6r+1BuakQ=;
 b=2Y46lEl1tTtfs/jJ8ixGjvlUxsh4bsilY8QyA3n2vIgYqne2A64zMQ0LYuYY0ismXFAKI9
 bjf9RyA7kJLWMcDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21F8513693;
 Tue,  7 Oct 2025 15:15:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bUlrB6Au5WhqSwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 07 Oct 2025 15:15:44 +0000
Date: Tue, 7 Oct 2025 17:16:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aOUuzl1CoAY4q380@yuki.lan>
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
 <20251007-xattrat-v2-2-bf458fa66358@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251007-xattrat-v2-2-bf458fa66358@suse.com>
X-Rspamd-Queue-Id: 3235C1F788
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 02/10] lapi: add setxattrat() fallback
 definition
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

On Tue, Oct 07, 2025 at 08:46:54AM +0200, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  configure.ac         |  1 +
>  include/lapi/xattr.h | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/configure.ac b/configure.ac
> index c32d9992c..827a8e6eb 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -157,6 +157,7 @@ AC_CHECK_FUNCS_ONCE([ \
>      sendmmsg \
>      sethostid \
>      setns \
> +    setxattrat \
>      sigpending \
>      splice \
>      statx \
> diff --git a/include/lapi/xattr.h b/include/lapi/xattr.h
> index 8bd2d45e4..8ab7e51d5 100644
> --- a/include/lapi/xattr.h
> +++ b/include/lapi/xattr.h
> @@ -7,7 +7,9 @@
>  #define LAPI_XATTR_H__
>  
>  #include <stdint.h>
> +#include <stddef.h>
>  #include "config.h"
> +#include "lapi/syscalls.h"
>  
>  #ifdef HAVE_LINUX_XATTR_H
>  # include <linux/xattr.h>
> @@ -29,4 +31,14 @@ struct xattr_args {
>  };
>  #endif
>  
> +#ifndef HAVE_FUNC_SETXATTRAT
                  ^
		  Actually that FUNC shouldn't be there, it's just
		  HAVE_SETXATTRAT

> +static inline int setxattrat(int dfd, const char *pathname,
> +			     unsigned int at_flags, const char *name,
> +			     const struct xattr_args *uargs, size_t usize)
> +{
> +	return tst_syscall(__NR_setxattrat, dfd, pathname, at_flags, name,
> +		    uargs, usize);
> +}
> +#endif
> +
>  #endif /* LAPI_XATTR_H__ */
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
