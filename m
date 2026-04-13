Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC277F531D6
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 21:20:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 753793D0106
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 23:20:37 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2C063D0106
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 23:20:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 144821A0043E
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 23:20:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0A0676A8E6;
 Mon, 13 Apr 2026 21:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776115217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lNKsYdFx3e9iXyfIBuNHatUHYVKCFQigXsACFH2OmUU=;
 b=TwRP1kOiNi8LkKm6J77oFzHBttPUwKQoPUG3xIgFnyY/FandXMCGiVN/EYYsVW1knkpe8t
 L53+EMf9NHqMy6ztaZA27BFf/8n3tCKxCeGOy2Yy4kWFWDgl13An9+Y9YkuLbkqUXwxOas
 C9zhs4LlISImI+x39CCzN87/daf0zXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776115217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lNKsYdFx3e9iXyfIBuNHatUHYVKCFQigXsACFH2OmUU=;
 b=53MSG9XDoka88ZPplIQTCzgZynKAo/8H/LzQHHkNAtYXClOThjywXm2fAs6zds8Db5QwUx
 YJTo8EDI4yp34EBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TwRP1kOi;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=53MSG9XD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776115217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lNKsYdFx3e9iXyfIBuNHatUHYVKCFQigXsACFH2OmUU=;
 b=TwRP1kOiNi8LkKm6J77oFzHBttPUwKQoPUG3xIgFnyY/FandXMCGiVN/EYYsVW1knkpe8t
 L53+EMf9NHqMy6ztaZA27BFf/8n3tCKxCeGOy2Yy4kWFWDgl13An9+Y9YkuLbkqUXwxOas
 C9zhs4LlISImI+x39CCzN87/daf0zXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776115217;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lNKsYdFx3e9iXyfIBuNHatUHYVKCFQigXsACFH2OmUU=;
 b=53MSG9XDoka88ZPplIQTCzgZynKAo/8H/LzQHHkNAtYXClOThjywXm2fAs6zds8Db5QwUx
 YJTo8EDI4yp34EBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DD4BB4B0BD;
 Mon, 13 Apr 2026 21:20:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id V2ecNBBe3WnGDQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 13 Apr 2026 21:20:16 +0000
Date: Mon, 13 Apr 2026 23:20:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>
Message-ID: <20260413212007.GA164377@pevik>
References: <20260410175031.16921-1-always.starving0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260410175031.16921-1-always.starving0@gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FREEMAIL_TO(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; MISSING_XM_UA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 0A0676A8E6
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] include/lapi: add leaf Makefile
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

Thanks for fixing this!

> Fixes : https://github.com/linux-test-project/ltp/issues/1262

nit: Please next time avoid space before ':'.

Fixes: https://github.com/linux-test-project/ltp/issues/1262

> include/lapi and include/lapi/syscalls lack Makefiles, so 'make check'
> does not work in these directories. Add minimal leaf Makefiles.

nit: Also it'd go here.

> Signed-off-by: Jinseok Kim <always.starving0@gmail.com>
> ---
>  include/lapi/Makefile          | 8 ++++++++
>  include/lapi/syscalls/Makefile | 8 ++++++++
>  2 files changed, 16 insertions(+)
>  create mode 100644 include/lapi/Makefile
>  create mode 100644 include/lapi/syscalls/Makefile

> diff --git a/include/lapi/Makefile b/include/lapi/Makefile
> new file mode 100644
> index 000000000..83ef85c77
> --- /dev/null
> +++ b/include/lapi/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
> +
> +top_srcdir              ?= ../../
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/include/lapi/syscalls/Makefile b/include/lapi/syscalls/Makefile

> new file mode 100644
> index 000000000..e46c90ef5
> --- /dev/null
> +++ b/include/lapi/syscalls/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
> +
> +top_srcdir              ?= ../../../
> +
> +include $(top_srcdir)/include/mk/env_pre.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk

Why do we need this file? This one should be deleted. Also, because make install
works for include directory, it should work here as well.
I would just copy that header, update top_srcdir location and also include
generic_trunk_target.mk to include/Makefile.

I think this is a better version.

Kind regards,
Petr

diff --git include/Makefile include/Makefile
index 6b31b046e4..84cd4ed6e3 100644
--- include/Makefile
+++ include/Makefile
@@ -24,4 +24,4 @@ ac-maintainer-clean:: ac-clean
 
 vpath %.h $(abs_srcdir)
 
-include $(top_srcdir)/include/mk/generic_leaf_target.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git include/lapi/Makefile include/lapi/Makefile
index 83ef85c77c..2a66e5aff6 100644
--- include/lapi/Makefile
+++ include/lapi/Makefile
@@ -1,8 +1,28 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
+# Copyright (C) 2009, Cisco Systems Inc.
+# Copyright (c) Linux Test Project, 2026
+# Ngie Cooper, July 2009
 
-top_srcdir              ?= ../../
+top_srcdir		?= ../..
 
 include $(top_srcdir)/include/mk/env_pre.mk
 
+INSTALL_DIR		:= $(includedir)/lapi
+
+INSTALL_MODE		:= 00644
+
+INSTALL_TARGETS		:= *.h
+
+MAKE_TARGETS		:=
+
+.PHONY: ac-clean ac-distclean ac-maintainer-clean distclean maintainer-clean
+distclean:: clean ac-distclean
+maintainer-clean:: distclean ac-maintainer-clean
+ac-clean ac-distclean::
+	$(RM) -f config.h lapi/syscalls.h stamp-h1
+ac-maintainer-clean:: ac-clean
+	$(RM) -f config.h.in
+
+vpath %.h $(abs_srcdir)
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git include/lapi/syscalls/Makefile include/lapi/syscalls/Makefile
deleted file mode 100644
index e46c90ef5f..0000000000
--- include/lapi/syscalls/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-# Copyright (C) 2026 Jinseok Kim <always.starving0@gmail.com>
-
-top_srcdir              ?= ../../../
-
-include $(top_srcdir)/include/mk/env_pre.mk
-
-include $(top_srcdir)/include/mk/generic_leaf_target.mk

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
