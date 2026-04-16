Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2277F8D765
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 18:54:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2EBD33E955E
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 20:54:02 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D09C3E74F1
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 20:53:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CE9111A0064C
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 20:53:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6F11C6A815;
 Thu, 16 Apr 2026 18:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776365620;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0/b6daOKi8W91OrlH93eLf3D0bYtWBv4vhEuMzkqiZM=;
 b=euzvl9nt6XoLwF58gx/sZIri/ViViAeoGQFLk4MSZZ9cyQNgxd9Zyikez3G1wkpb7oBYEN
 TqMMc5r1F1pUm43UJZ5OfdM4MX7WPP/ztN81g6jEbQ0yRD0OKupKFEudOWAeupnNyxJbfk
 tcjxgMEhTdMxXpZf5AMA4+fAkefzLMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776365620;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0/b6daOKi8W91OrlH93eLf3D0bYtWBv4vhEuMzkqiZM=;
 b=CfZkSYHgbiWcy0UDv6Je/IPcwoIA1RA6soMY6wykz0R1I0lLUbEj8Cfoz1II4ZRJ3dX5r4
 +JwRHx7XG8cSIGBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776365619;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0/b6daOKi8W91OrlH93eLf3D0bYtWBv4vhEuMzkqiZM=;
 b=l9pLoOevI2CrWLGkkskjoqTdSecVLiZqSD6Hb/v/g/xSRM97rXi4pL3bY98s9Dzknf+8YZ
 zP+vv5FiERSc/fccdspoKWjGnf9JlB/KlwNRmaNRSZ39R4li3E35be8iCkrWh7SSEJgyDE
 Hja3mqtfAM3t/BpVqSHhfuyfxGnTGCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776365619;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0/b6daOKi8W91OrlH93eLf3D0bYtWBv4vhEuMzkqiZM=;
 b=fJKWpXALK9mkkdatYiBk3wpV3OlOqXjvJIxYxmbwq5vp7ZttJe05xHdUrMSN6t4YzL36KZ
 Y/ws8J5WyV90OYAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BA83593A3;
 Thu, 16 Apr 2026 18:53:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id F/J+BzMw4WmlFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 Apr 2026 18:53:39 +0000
Date: Thu, 16 Apr 2026 20:53:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20260416185329.GA385137@pevik>
References: <20260416144213.27221-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260416144213.27221-1-mdoucha@suse.cz>
X-Spamd-Result: default: False [-6.00 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,suse.cz,gmail.com,redhat.com];
 REPLYTO_EQ_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[]; MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] OpenPOSIX: Add common entry point function for
 all tests
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

Hi all,

> Add a new shared source file implementing the main() function and rename
> the existing main() functions in test case sources to test_main(). This
> allows adding custom debug code to all test cases at once.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Martin, thanks!

Li, Jan, hopefully you don't mind. We'd prefer not having to keep rebasing.

> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>  testcases/open_posix_testsuite/Makefile       | 13 +++---
>  .../conformance/behavior/WIFEXITED/1-1.c      |  2 +-
>  .../conformance/interfaces/nanosleep/3-2.c    |  2 +-
...
>  testcases/open_posix_testsuite/lib/Makefile   | 18 ++++++++
>  testcases/open_posix_testsuite/lib/common.c   | 13 ++++++
>  .../scripts/generate-makefiles.sh             | 10 ++++-
...
>  1695 files changed, 1974 insertions(+), 1920 deletions(-)
>  create mode 100644 testcases/open_posix_testsuite/lib/Makefile
>  create mode 100644 testcases/open_posix_testsuite/lib/common.c

...
> diff --git a/testcases/open_posix_testsuite/conformance/behavior/WIFEXITED/1-1.c b/testcases/open_posix_testsuite/conformance/behavior/WIFEXITED/1-1.c
> index ae021917c..6f7044b4a 100644
> --- a/testcases/open_posix_testsuite/conformance/behavior/WIFEXITED/1-1.c
> +++ b/testcases/open_posix_testsuite/conformance/behavior/WIFEXITED/1-1.c
> @@ -11,7 +11,7 @@
>  #include <unistd.h>
>  #include "posixtest.h"

> -int main()
> +int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
>  {
>  	int s;
...
> new file mode 100644
> index 000000000..ad6a9d7e6
> --- /dev/null
> +++ b/testcases/open_posix_testsuite/lib/Makefile
> @@ -0,0 +1,18 @@
> +top_srcdir?=		..
> +subdir=			lib
> +
> +AR?=			ar
> +RANLIB?=		ranlib
> +CFLAGS+=		-I$(top_srcdir)/include
> +
> +
> +vpath %.c $(top_srcdir)/$(subdir)
> +
> +all: libcommon.a
> +
> +clean:
> +	rm -f libcommon.a *.o
> +
> +libcommon.a: common.o
> +	$(AR) -rc "$@" $^
> +	$(RANLIB) "$@"
> diff --git a/testcases/open_posix_testsuite/lib/common.c b/testcases/open_posix_testsuite/lib/common.c
> new file mode 100644
> index 000000000..71e9afb2b
> --- /dev/null
> +++ b/testcases/open_posix_testsuite/lib/common.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 SUSE LLC <mdoucha@suse.cz>
> + *
> + * OpenPOSIX test bootstrap
> + */
> +
> +int test_main(int argc, char **argv);
> +
> +int main(int argc, char **argv)
> +{
> +	return test_main(argc, argv);
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
