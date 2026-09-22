Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8E8C982FE
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 14:39:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 414A13E6CD1
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 16:39:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7652E3E1CC9
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 16:39:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F01071000D83
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 16:39:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D94DB1F769;
 Tue, 22 Sep 2026 14:39:19 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65D5913A23;
 Tue, 22 Sep 2026 14:39:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ahNJDxeTsmoJRAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 22 Sep 2026 14:39:19 +0000
Date: Tue, 22 Sep 2026 16:39:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260922143913.GB2205904@pevik>
References: <20260922095126.2169599-1-pvorel@suse.cz>
 <arKIz5Oygb57INup@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <arKIz5Oygb57INup@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: D94DB1F769
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 TAGGED_RCPT(0.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> I think that we should simplify this by including only
> include/linux/keyctl.h and do not ever include the include/keyutils.h
> from keyutils package.

> This should do the trick:

> diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
> index fdb68d172..90ebf88c1 100644
> --- a/include/lapi/keyctl.h
> +++ b/include/lapi/keyctl.h
> @@ -10,15 +10,13 @@

>  #include <stdint.h>

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

>  static inline key_serial_t add_key(const char *type,
> @@ -59,11 +57,12 @@ static inline key_serial_t keyctl_join_session_keyring(const char *name) {
>         return keyctl(KEYCTL_JOIN_SESSION_KEYRING, name);
>  }

> -#endif /* defined(HAVE_KEYUTILS_H) && defined(HAVE_LIBKEYUTILS) */
> -
>  #ifndef HAVE_STRUCT_KEYCTL_DH_PARAMS
>  struct keyctl_dh_params {
> -       int32_t priv;
> +       union {
> +               int32_t priv;
> +               int32_t private;
> +       };

I see now :). Good point, I'll remove the rest of keyutils + use private instead
of priv and send whole patchset asap.

Kind regards,
Petr

>         int32_t prime;
>         int32_t base;
>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
