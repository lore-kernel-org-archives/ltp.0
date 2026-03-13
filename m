Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7E5107BCCD
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 16:43:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 316153E57A6
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 17:43:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07FF03E1885
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 17:43:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4A9E21A01153
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 17:43:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 725FA5BD15;
 Fri, 13 Mar 2026 16:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773420184;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b4s5QZXFGk+l96nChW3xF9nGjN6kyQdklhJwlDtwfeE=;
 b=LcDrTvSdmpgQyCmTqzXpOngKXRH/nvWkImQ8q6xqvTS/EbWvzk0DG6bF5/vXqEKTJaimBj
 X7jJ/W70boY1c1mIXPpnsjxUfCXmlIE3yHQKsLVVZFK/TyXOLuvxESgaSDeY5E88Pxg5vP
 g+otFdk5NOUWARGovpzyALjKc5a3JY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773420184;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b4s5QZXFGk+l96nChW3xF9nGjN6kyQdklhJwlDtwfeE=;
 b=t/hfafAbyHWbXoDz9fFvM3GfwVjhuXDqIz79Rcyopdxvo1AwjAYvUljS7Sy2pQmvLax35m
 HxDYG8/IdXrOXaDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LcDrTvSd;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="t/hfafAb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773420184;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b4s5QZXFGk+l96nChW3xF9nGjN6kyQdklhJwlDtwfeE=;
 b=LcDrTvSdmpgQyCmTqzXpOngKXRH/nvWkImQ8q6xqvTS/EbWvzk0DG6bF5/vXqEKTJaimBj
 X7jJ/W70boY1c1mIXPpnsjxUfCXmlIE3yHQKsLVVZFK/TyXOLuvxESgaSDeY5E88Pxg5vP
 g+otFdk5NOUWARGovpzyALjKc5a3JY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773420184;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b4s5QZXFGk+l96nChW3xF9nGjN6kyQdklhJwlDtwfeE=;
 b=t/hfafAbyHWbXoDz9fFvM3GfwVjhuXDqIz79Rcyopdxvo1AwjAYvUljS7Sy2pQmvLax35m
 HxDYG8/IdXrOXaDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 510224060E;
 Fri, 13 Mar 2026 16:43:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QoqCEpg+tGlYTQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 13 Mar 2026 16:43:04 +0000
Date: Fri, 13 Mar 2026 17:42:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jinseok Kim <always.starving0@gmail.com>
Message-ID: <20260313164258.GA251098@pevik>
References: <DGIU5TUBY8DA.1O11NEVRMZTZK@suse.com>
 <20260219141532.6513-1-always.starving0@gmail.com>
 <20260219141532.6513-2-always.starving0@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260219141532.6513-2-always.starving0@gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_TO(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 725FA5BD15
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] open: replace getdtablesize with getrlimit
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

> The test currently uses getdtablesize() to determine the maximum
> number of file descriptors for the process. This interface is
> considered legacy and is not specified by POSIX.

> Use getrlimit() instead, which provides a well-defined
> and portable way to obtain the per-process file descriptor limit.

Hm, it's still supported by all libc on Linux including musl [1] and bionic [2],
and we even test getdomainname [3], but ok, let's move beyond POSIX 2004.

[1] https://git.musl-libc.org/cgit/musl/tree/src/legacy/getdtablesize.c
[2] https://android.googlesource.com/platform/bionic.git/+/refs/heads/main/libc/bionic/ndk_cruft.cpp#288
[3] testcases/kernel/syscalls/getdomainname/getdomainname01.c

...
> +++ b/testcases/kernel/syscalls/open/open04.c
> @@ -11,6 +11,7 @@

>  #include <stdio.h>
>  #include <stdlib.h>
> +#include <sys/resource.h>
nit: I removed this before merge (header included by other headers).

Merged this patch only (not the first one).

Kind regards,
Petr

>  #include "tst_test.h"

>  #define FNAME "open04"
> @@ -23,8 +24,10 @@ static char fname[20];
>  static void setup(void)
>  {
>  	int fd;
> +	struct rlimit rlim;

> -	fds_limit = getdtablesize();
> +	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlim);
> +	fds_limit = rlim.rlim_cur;
>  	first = SAFE_OPEN(FNAME, O_RDWR | O_CREAT, 0777);

>  	fds = SAFE_MALLOC(sizeof(int) * (fds_limit - first));

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
