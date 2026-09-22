Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13F2AC982FA
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 14:03:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 087CB3E6D3E
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 16:03:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 937003E5DE0
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 16:02:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F2E45600A94
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 16:02:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2DBE4219E3;
 Tue, 22 Sep 2026 14:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790085774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=usfRdLiwBF+V671sBNnF1QylkINhjIMDj8+XHoXTY5g=;
 b=QNGzXLkgNZmFubeWwLp2sWhPUg6pemRCD6bQjxBflZoez61QhXpxZBwqVWDd0YGAKM+0G9
 tFhIk2yizrgH1REvhgnQTR/cDwWfoUtKuGWx0eMyYIgN8h2IfhAKdsUle56l6XeyIFJgF3
 ggu2kitqtS81Y8+aqRciXBe1PQYoGiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790085774;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=usfRdLiwBF+V671sBNnF1QylkINhjIMDj8+XHoXTY5g=;
 b=0fhXH4IEGzSru5hLslKyywYG7dMtRuWyA4dEv/SVCxO+SZoujhN+OsPscvknsKSzNpG46s
 jZw7TdRxylGOYcCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sE6bfSFY;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2yduPPAk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790085770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=usfRdLiwBF+V671sBNnF1QylkINhjIMDj8+XHoXTY5g=;
 b=sE6bfSFY7acVLJ/yfYJwWkTAGFe/q/ecELOwZXgTr62yzJJ1vzbeqsStCv3pF0hrlk2tA/
 8o17Gspy6T3aNrqI0gMXtB5h5axB6R4vzMrHiRctJpCg5keWpA8I5MN9Cjw/RDGFOBrMxM
 HUxRRUKkL9a7Hr9836dXPQH9cCEStg8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790085770;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=usfRdLiwBF+V671sBNnF1QylkINhjIMDj8+XHoXTY5g=;
 b=2yduPPAkQc8oQdNGOAgoSfxl0kZsgI8Wc5U2TbVJ33G64ccCiJR73Ggsv6n/kIYyQ7Njzi
 r9vyxgTnYXb4p6AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1975132D3;
 Tue, 22 Sep 2026 14:02:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PpwrM4mKsmoVHQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 22 Sep 2026 14:02:49 +0000
Date: Tue, 22 Sep 2026 16:03:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <arKKloQVzHXo4Vs_@yuki.lan>
References: <20260922095126.2169599-1-pvorel@suse.cz>
 <arKIz5Oygb57INup@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <arKIz5Oygb57INup@yuki.lan>
X-Rspamd-Queue-Id: 2DBE4219E3
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TAGGED_RCPT(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,yuki.lan:mid,suse.cz:dkim,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] keyctl: Vendor struct keyctl_dh_params
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> I think that we should simplify this by including only
> include/linux/keyctl.h and do not ever include the include/keyutils.h
> from keyutils package.
> 
> This should do the trick:
> 
> diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
> index fdb68d172..90ebf88c1 100644
> --- a/include/lapi/keyctl.h
> +++ b/include/lapi/keyctl.h
> @@ -10,15 +10,13 @@
> 
>  #include <stdint.h>
> 
> -#if defined(HAVE_KEYUTILS_H) && defined(HAVE_LIBKEYUTILS)
> -# include <keyutils.h>
> -#else
> -# ifdef HAVE_LINUX_KEYCTL_H
> -#  include <linux/keyctl.h>
> -# endif /* HAVE_LINUX_KEYCTL_H */
> -
> -# include <stdarg.h>
> -# include "lapi/syscalls.h"
> +#ifdef HAVE_LINUX_KEYCTL_H
> +# include <linux/keyctl.h>
> +#endif /* HAVE_LINUX_KEYCTL_H */
> +
> +#include <stdarg.h>
> +#include "lapi/syscalls.h"
> +
>  typedef int32_t key_serial_t;
> 
>  static inline key_serial_t add_key(const char *type,
> @@ -59,11 +57,12 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
>         return keyctl(KEYCTL_JOIN_SESSION_KEYRING, name);
>  }
> 
> -#endif /* defined(HAVE_KEYUTILS_H) && defined(HAVE_LIBKEYUTILS) */
> -
>  #ifndef HAVE_STRUCT_KEYCTL_DH_PARAMS
>  struct keyctl_dh_params {
> -       int32_t priv;
> +       union {
> +               int32_t priv;
> +               int32_t private;
> +       };
>         int32_t prime;
>         int32_t base;
>  };

And of course we have to change the ->priv to ->private to get the
tests compiled on older distributions as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
