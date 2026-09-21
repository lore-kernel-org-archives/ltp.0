Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01111C982ED
	for <ltp@archiver.kernel.org>; Mon, 21 Sep 2026 13:36:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0970C3E6E78
	for <ltp@archiver.kernel.org>; Mon, 21 Sep 2026 15:36:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A5263E5E62
 for <ltp@lists.linux.it>; Mon, 21 Sep 2026 15:36:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A9FD32005E7
 for <ltp@lists.linux.it>; Mon, 21 Sep 2026 15:36:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7196721B46;
 Mon, 21 Sep 2026 13:36:15 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 151481368D;
 Mon, 21 Sep 2026 13:36:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HCJyMc4ysWrvCAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 21 Sep 2026 13:36:14 +0000
Date: Mon, 21 Sep 2026 15:36:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260921133613.GA2143203@pevik>
References: <20260921111407.2137467-1-pvorel@suse.cz>
 <arEagQKsecxyn8dy@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <arEagQKsecxyn8dy@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7196721B46
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 TAGGED_RCPT(0.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lapi/keyctl.h: Fix compilation on old kernel
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

> Hi!
> > diff --git a/include/lapi/keyctl.h b/include/lapi/keyctl.h
> > index fdb68d1725..e1e46b7865 100644
> > --- a/include/lapi/keyctl.h
> > +++ b/include/lapi/keyctl.h
> > @@ -69,6 +69,12 @@ struct keyctl_dh_params {
> >  };
> >  #endif

> > +/* Fix for kernel < v4.20 */
> > +#if defined(HAVE_STRUCT_KEYCTL_DH_PARAMS) && \
> > +	!defined(HAVE_STRUCT_KEYCTL_DH_PARAMS_PRIV)
> > +# define priv private
> > +#endif

> I do not like this one, we may end up redefining wrong priv and break
> everything.

> Given that the private stil exists in the structure for C code:

> (/usr/include/linux/keyctl.h)
> /* keyctl structures */
> struct keyctl_dh_params {
>         union {
> #ifndef __cplusplus
>                 __s32 private;
> #endif
>                 __s32 priv;
>         };
>         __s32 prime;
>         __s32 base;
> };

> We may as well use private in the tests consistently and update our
> fallback with the union as well.

When I looked in the struct in UAPI I considered define better, but indeed
mirroring UAPI the same way is really better.

I'll retest it and send v2.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
