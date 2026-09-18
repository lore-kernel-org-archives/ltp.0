Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 578AAC982DA
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 15:18:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EF4A3EAE16
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 17:18:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 530513E76BA
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 17:17:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1662E14010E7
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 17:17:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4C4B421D2B;
 Fri, 18 Sep 2026 15:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789744662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SCGzEwK5F1RkijjEDovzS3miF46zdJRVUN2k/w6j8/U=;
 b=lx0IWR8+JAS06QDUAERVJQSbYJrafP0EObVq7aSCblYzTEmuSR0qkVg2u/1SC8Z0ILvF9h
 LRlpwnd8NkFsD+AweE02sTJzebWfJOF0jTCwXWHkn/3qKrYv2e6o4Xe77yCXLqHjxqeLHe
 jcv8ZY5st4GUnuFwZIlZNzBZSdpmAZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789744662;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SCGzEwK5F1RkijjEDovzS3miF46zdJRVUN2k/w6j8/U=;
 b=enTgUFnnDwQIHrsWnw38hrYHrtJrDATBjv0LkvY5tcDLMWKZZBhfhkA2t50SdaPXZxzkK7
 2fMVE3wRjJh4zvAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789744658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SCGzEwK5F1RkijjEDovzS3miF46zdJRVUN2k/w6j8/U=;
 b=piedDBb3c82ObNupPmZJzJkOXiEzKobd81tm0iczrj3bZ5e58QIfe4ok5LrI/0w8m1eDRk
 J9lnxuK0hpO9wm91TQdekBuLC1TIVAEG32y0YX5DZ7iDqUtiXJh8PYmFI+UNViOTN1LpUp
 B5Pj2lgRC/zNbNlRNn4XEsncZUXJHq0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789744658;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SCGzEwK5F1RkijjEDovzS3miF46zdJRVUN2k/w6j8/U=;
 b=+PpQ/PTBRt1Y3Rf2eLwuPnq/2H/II6Vr7EUUFhYYGX6jw7IkHrjUuE9kFo0TjFfh2EOGHf
 DDzYgbRHZBRMX6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17E3713927;
 Fri, 18 Sep 2026 15:17:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +rMOORFWrWrTMQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 18 Sep 2026 15:17:38 +0000
Date: Fri, 18 Sep 2026 17:17:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aq1WHcDZqhKIU54T@yuki.lan>
References: <20260916140402.1797325-1-pvorel@suse.cz>
 <20260916140402.1797325-28-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260916140402.1797325-28-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/kernel/syscalls/keyctl/keyctl31.c b/testcases/kernel/syscalls/keyctl/keyctl31.c
> new file mode 100644
> index 0000000000..c1e6723ac8
> --- /dev/null
> +++ b/testcases/kernel/syscalls/keyctl/keyctl31.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Test ``KEYCTL_PKEY_ENCRYPT`` and ``KEYCTL_PKEY_DECRYPT`` of :manpage:`keyctl(2)`.
> + *
> + * ``KEYCTL_PKEY_ENCRYPT`` encrypts a data blob using an asymmetric public key
> + * and ``KEYCTL_PKEY_DECRYPT`` decrypts the encrypted blob using the matching
> + * private key.
> + *
> + * Requires root (CAP_SYS_MODULE) to load the ``x509_key_parser`` and
> + * ``pkcs8_key_parser`` modules.
> + *
> + * [Algorithm]
> + *
> + * - encrypt a 32-byte plaintext using an RSA-2048 X.509 public key with ``enc=pkcs1``
> + * - decrypt the 256-byte ciphertext using the matching PKCS#8 private key
> + * - verify the decrypted output matches the original 32-byte plaintext
> + */
> +
> +#include "keyctl_common.h"
> +#include "keyctl_pkey_data.h"
> +#include "tst_module.h"
> +
> +#define CIPHERTEXT_SIZE	256
> +
> +static const char plaintext[] = "LTP_PKEY_ENCRYPT_DECRYPT_TEST_32";
> +#define PLAINTEXT_SIZE	(sizeof(plaintext) - 1)
> +static unsigned char ciphertext[CIPHERTEXT_SIZE];
> +static unsigned char decrypted[CIPHERTEXT_SIZE];

Shouldn't these two be in the guarded buffers as well? I would say that
it's pretty much important that the kernel does not touch anything
outside of these arrays during encryption/decryption.

Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
