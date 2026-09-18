Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BEA5C982D8
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 15:54:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E80C3EAE1E
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 17:54:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECD093E9201
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 17:53:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 75192100065D
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 17:53:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6E5561F385;
 Fri, 18 Sep 2026 15:53:53 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 292921348F;
 Fri, 18 Sep 2026 15:53:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UMGdNpBerWoWWAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 18 Sep 2026 15:53:53 +0000
Date: Fri, 18 Sep 2026 17:53:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260918155351.GB1973373@pevik>
References: <20260916140402.1797325-1-pvorel@suse.cz>
 <20260916140402.1797325-28-pvorel@suse.cz>
 <aq1WHcDZqhKIU54T@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aq1WHcDZqhKIU54T@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6E5561F385
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 27/36] keyctl31: Test KEYCTL_PKEY_ENCRYPT and
 KEYCTL_PKEY_DECRYPT
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

Hi Cyril,

> Hi!
> > diff --git a/testcases/kernel/syscalls/keyctl/keyctl31.c b/testcases/kernel/syscalls/keyctl/keyctl31.c
> > new file mode 100644
> > index 0000000000..c1e6723ac8
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/keyctl/keyctl31.c
> > @@ -0,0 +1,110 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
> > + */
> > +
> > +/*\
> > + * Test ``KEYCTL_PKEY_ENCRYPT`` and ``KEYCTL_PKEY_DECRYPT`` of :manpage:`keyctl(2)`.
> > + *
> > + * ``KEYCTL_PKEY_ENCRYPT`` encrypts a data blob using an asymmetric public key
> > + * and ``KEYCTL_PKEY_DECRYPT`` decrypts the encrypted blob using the matching
> > + * private key.
> > + *
> > + * Requires root (CAP_SYS_MODULE) to load the ``x509_key_parser`` and
> > + * ``pkcs8_key_parser`` modules.
> > + *
> > + * [Algorithm]
> > + *
> > + * - encrypt a 32-byte plaintext using an RSA-2048 X.509 public key with ``enc=pkcs1``
> > + * - decrypt the 256-byte ciphertext using the matching PKCS#8 private key
> > + * - verify the decrypted output matches the original 32-byte plaintext
> > + */
> > +
> > +#include "keyctl_common.h"
> > +#include "keyctl_pkey_data.h"
> > +#include "tst_module.h"
> > +
> > +#define CIPHERTEXT_SIZE	256
> > +
> > +static const char plaintext[] = "LTP_PKEY_ENCRYPT_DECRYPT_TEST_32";
> > +#define PLAINTEXT_SIZE	(sizeof(plaintext) - 1)
> > +static unsigned char ciphertext[CIPHERTEXT_SIZE];
> > +static unsigned char decrypted[CIPHERTEXT_SIZE];

> Shouldn't these two be in the guarded buffers as well? I would say that
> it's pretty much important that the kernel does not touch anything
> outside of these arrays during encryption/decryption.

Make sense to me, I'll amend.

Kind regards,
Petr

+++ testcases/kernel/syscalls/keyctl/keyctl31.c
@@ -103,6 +103,8 @@ static struct tst_test test = {
 		NULL
 	},
 	.bufs = (struct tst_buffers []) {
+		{&ciphertext, .size = sizeof(*ciphertext)},
+		{&decrypted, .size = sizeof(*decrypted)},
 		{&enc_params, .size = sizeof(*enc_params)},
 		{&dec_params, .size = sizeof(*dec_params)},
 		{},

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
