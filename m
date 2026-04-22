Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B655F94CC2
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 05:18:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E04E3E259F
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 07:18:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1F6A3E1A84
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 07:18:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4FA5B1400270
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 07:18:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4551C5BD33;
 Wed, 22 Apr 2026 05:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776835087;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pzwh7+wULhqNy373ItinQno8Pof204v/yAO/ob/2Z88=;
 b=Lj+NZ/7fql7tMkFnBfRWP1tVNxHYmcJwXaiCuZzHEqh1D7b//yXJOaazLsk3c3tgJjCit1
 zeZ+ABynEKdtwdOQfYIgb4fS24BPjkhW/Q9WW444EBKDQYRENoT+R2T0HmFX4O5TiEipq7
 vAVnDgPtMIcWqX5mfX4rYFLgHeRFZac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776835087;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pzwh7+wULhqNy373ItinQno8Pof204v/yAO/ob/2Z88=;
 b=kJeLn7bPucjWy5VibnYaXIYqr3MISnkzmwxTvXRxDtOaCav4OYvAf1SiT04ZLZwvGM4y88
 3qd7DUfekXEZzJAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Lj+NZ/7f";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kJeLn7bP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776835087;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pzwh7+wULhqNy373ItinQno8Pof204v/yAO/ob/2Z88=;
 b=Lj+NZ/7fql7tMkFnBfRWP1tVNxHYmcJwXaiCuZzHEqh1D7b//yXJOaazLsk3c3tgJjCit1
 zeZ+ABynEKdtwdOQfYIgb4fS24BPjkhW/Q9WW444EBKDQYRENoT+R2T0HmFX4O5TiEipq7
 vAVnDgPtMIcWqX5mfX4rYFLgHeRFZac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776835087;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pzwh7+wULhqNy373ItinQno8Pof204v/yAO/ob/2Z88=;
 b=kJeLn7bPucjWy5VibnYaXIYqr3MISnkzmwxTvXRxDtOaCav4OYvAf1SiT04ZLZwvGM4y88
 3qd7DUfekXEZzJAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23125593AF;
 Wed, 22 Apr 2026 05:18:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id j5CkBw9a6GnpGAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 22 Apr 2026 05:18:07 +0000
Date: Wed, 22 Apr 2026 07:18:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>
Message-ID: <20260422051800.GA392764@pevik>
References: <20260417113453.GA409289@pevik>
 <20260421160828.4483-1-always.starving0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260421160828.4483-1-always.starving0@gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,lists.linux.it];
 DBL_BLOCKED_OPENRESOLVER(0.00)[generic_trunk_target.mk:url,suse.cz:dkim,suse.cz:replyto,suse.cz:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 4551C5BD33
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] include/lapi: add leaf Makefile
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

Hi Jinseok,

> Convert include/Makefile to use generic_trunk_target.mk and
> add minimal leaf Makefile in include/lapi.

add minimal leaf Makefile in include/lapi in order to have 'make check'.

FYI AI is correct it's better to describe the reason (although we have a ticket,
one day might github disappear and we lost the reason in the ticket).

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Wait little longer if Li has time to ack this.

> Fixes: https://github.com/linux-test-project/ltp/issues/1262

> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
> ---
> Changes in v2:
> - Switch include/Makefile to trunk and remove lapi/syscalls/Makefile
> - Link to v1 : https://lore.kernel.org/ltp/20260410175031.16921-1-always.starving0@gmail.com
> ---
>  include/Makefile      |  2 +-
>  include/lapi/Makefile | 10 ++++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>  create mode 100644 include/lapi/Makefile

> diff --git a/include/Makefile b/include/Makefile
> index 6b31b046e..84cd4ed6e 100644
> --- a/include/Makefile
> +++ b/include/Makefile
> @@ -24,4 +24,4 @@ ac-maintainer-clean:: ac-clean

>  vpath %.h $(abs_srcdir)

> -include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/include/lapi/Makefile b/include/lapi/Makefile
> new file mode 100644
> index 000000000..f265f856d
> --- /dev/null
> +++ b/include/lapi/Makefile
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2009, Cisco Systems Inc.
I'll remove this line before merge. IMHO it's no longer Cisco work :).
While this is related when code is significantly based on old code,
I would not bother with 2 lines of Makefile.

> +# Copyright (c) Linux Test Project, 2026
> +# Ngie Cooper, July 2009
And this one.

Kind regards,
Petr

> +
> +top_srcdir              ?= ../../
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
