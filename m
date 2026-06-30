Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2ACFC43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 10:20:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 289A43E4C2A
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 12:20:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B564A3C2780
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 12:20:28 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3860F200966
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 12:20:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 953BF73587;
 Tue, 30 Jun 2026 10:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782814827;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2qSGYlExK4YRnzVII17K55v0C1+FmYhqlkrMi7KMQAk=;
 b=oQ5mu4Z7qs+/KfNm3lR1+IYKVJPkQkz5LJHLcNkY9PKjyNG1ej82WDwFwn8lk16AqSQKo4
 APPVtVAroaQkuRfydfkJqSt0XAmKltenjH6Nc1lDBq/5kxuuxLRugpYVAhz++Io3JkLHkM
 gVlSsTUzZm0EcBCmQWwqp0AemT3FuRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782814827;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2qSGYlExK4YRnzVII17K55v0C1+FmYhqlkrMi7KMQAk=;
 b=uVKvgADdhXUoRU9GkSxHxMdjwKph4QJTRXs+8l2G3c6UcIchUh+uqu5xOVCssk8PQcr4Kg
 U6zKYpxeHgh3TyAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oQ5mu4Z7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uVKvgADd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782814827;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2qSGYlExK4YRnzVII17K55v0C1+FmYhqlkrMi7KMQAk=;
 b=oQ5mu4Z7qs+/KfNm3lR1+IYKVJPkQkz5LJHLcNkY9PKjyNG1ej82WDwFwn8lk16AqSQKo4
 APPVtVAroaQkuRfydfkJqSt0XAmKltenjH6Nc1lDBq/5kxuuxLRugpYVAhz++Io3JkLHkM
 gVlSsTUzZm0EcBCmQWwqp0AemT3FuRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782814827;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2qSGYlExK4YRnzVII17K55v0C1+FmYhqlkrMi7KMQAk=;
 b=uVKvgADdhXUoRU9GkSxHxMdjwKph4QJTRXs+8l2G3c6UcIchUh+uqu5xOVCssk8PQcr4Kg
 U6zKYpxeHgh3TyAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70861779A8;
 Tue, 30 Jun 2026 10:20:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NmSuGmuYQ2q6BQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jun 2026 10:20:27 +0000
Date: Tue, 30 Jun 2026 12:20:26 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260630102026.GB417625@pevik>
References: <20260629-invalid_syscalls-v1-1-6276034a35c5@suse.com>
 <akMN_kOtke47w0-v@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <akMN_kOtke47w0-v@autotest-wegao.qe.prg2.suse.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 953BF73587
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscall02: add invalid syscall number test
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, Wei,

> > Add a test verifying that syscall() returns ENOSYS when called with
> > unimplemented syscall numbers. The chosen numbers stay above the syscall
> > table and below the architecture-specific private ranges, so they are
> > reliably invalid on every supported architecture.

+1

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> > +++ b/testcases/kernel/syscalls/syscall/syscall02.c
> > @@ -0,0 +1,47 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
> > + */
> > +
> > +/*\
> > + * Verify that :manpage:`syscall(2)` fails with ENOSYS when invoked with
> > + * invalid syscall numbers.
> > + *
> > + * The syscall number is dispatched as an unsigned value on Linux. A value is
> > + * reliably unimplemented on every supported architecture when it is:
> > + *
> > + * - above the syscall table
> > + * - below the architecture-specific private syscall ranges (e.g. ARM's
> > + *   0x0f0000 base)
> > + * - without the x32 ABI bit (0x40000000) set
> > + *
> > + * Such a number is routed to sys_ni_syscall and returns ENOSYS.
> > + */
> > +
> > +#include <unistd.h>
> > +#include <sys/syscall.h>
> > +
> > +#include "tst_test.h"
> > +
> > +#define TC(x) {.scno = (long)(x), .desc = #x}
> > +
> > +static struct tcase {
> > +	long scno;
> > +	const char *desc;
> > +} tcases[] = {
> > +	TC(0x8000),
> > +	TC(0xf000),
> > +	TC(0xfffe),
> > +};

> I suggest add two more cases check:
> 1) -1
> 2) __NR_syscalls +1 (Base arch/powerpc/kernel/syscall.c)

+1. Something like this wouldn't harm (tested only on x86_64 and x86).

Kind regards,
Petr

+++ testcases/kernel/syscalls/syscall/syscall02.c
@@ -14,12 +14,15 @@
  * - below the architecture-specific private syscall ranges (e.g. ARM's
  *   0x0f0000 base)
  * - without the x32 ABI bit (0x40000000) set
+ * - -1
+ * - __NR_syscalls + 1
  *
  * Such a number is routed to sys_ni_syscall and returns ENOSYS.
  */
 
 #include <unistd.h>
 #include <sys/syscall.h>
+#include <asm-generic/unistd.h>
 
 #include "tst_test.h"
 
@@ -32,6 +35,8 @@ static struct tcase {
 	TC(0x8000),
 	TC(0xf000),
 	TC(0xfffe),
+	TC(-1),
+	TC(__NR_syscalls + 1),
 };
 
 static void verify_syscall(unsigned int n)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
