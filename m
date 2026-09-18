Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B50BC982D8
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 15:25:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A2BE53EA15E
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 17:25:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B8423C7277
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 17:25:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CC20F200B34
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 17:25:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4EE5C21BF6;
 Fri, 18 Sep 2026 15:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789745101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qqcZXUTs1rUrF2DGiHaoOh9Hrg89nHPw2uCN+rCT4VU=;
 b=t+bXomIE/yUBJv6ehDahfM0NKDjwb6KqWd5NEG0+A90g1ixe9SNIRadoVVs1tbnVZZ61b+
 aZaEN8cLr81/CCbnZIX1hwT8fiLkBzPNxokmS1k2SNnWjZ2EbZDOOdLpY8XWQSO9qOScEG
 dZONdNd/xMoWXNvTf1clihJy8lFbNVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789745101;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qqcZXUTs1rUrF2DGiHaoOh9Hrg89nHPw2uCN+rCT4VU=;
 b=/iKE56JPK3c+spJrxZXPGZLhg16zLSScoqgjHkVcWRhZQy4T7b01ZhTKOQ+szww9yVjRYj
 Cwb5xA/bWdXDkRBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MAR96j1H;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=j4exnOF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789745097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qqcZXUTs1rUrF2DGiHaoOh9Hrg89nHPw2uCN+rCT4VU=;
 b=MAR96j1Hm3OB9TxGpuHfoLRcnDnRQiYByK2YUxZ0grV/gNg1U9MLKYwp23VEoF3jrHbh1t
 hjqpgD7LVxZr9ODe4Rvsj5P4vVat9qWqFeS1IvIzB80nZXaeYjrnKKxe84Mz1RRZmwge5N
 2tGv7cgfWqz/sfaRyPmrxxxylfcpDLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789745097;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qqcZXUTs1rUrF2DGiHaoOh9Hrg89nHPw2uCN+rCT4VU=;
 b=j4exnOF1lY1+ZRULuPHRzo8rn2gO2lislKa8Ps792OOSvZx5r5m7/FwNG36no7XVd5em2x
 zfgivYzxKhj/U8Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16AE6133CF;
 Fri, 18 Sep 2026 15:24:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KBXzOMhXrWo6OgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 18 Sep 2026 15:24:57 +0000
Date: Fri, 18 Sep 2026 17:25:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aq1X0HEKH3jRx5e4@yuki.lan>
References: <20260916140402.1797325-1-pvorel@suse.cz>
 <20260916140402.1797325-29-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260916140402.1797325-29-pvorel@suse.cz>
X-Rspamd-Queue-Id: 4EE5C21BF6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,yuki.lan:mid];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 28/36] keyctl32: Test KEYCTL_PKEY_SIGN and
 VERIFY
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
> +/*\
> + * Test ``KEYCTL_PKEY_SIGN`` and ``KEYCTL_PKEY_VERIFY`` of :manpage:`keyctl(2)`.
> + *
> + * ``KEYCTL_PKEY_SIGN`` signs a digest using an asymmetric private key and
> + * ``KEYCTL_PKEY_VERIFY`` verifies the signature using the matching public key.
> + *
> + * Requires root (CAP_SYS_MODULE) to load the ``x509_key_parser`` and
> + * ``pkcs8_key_parser`` modules.
> + *
> + * [Algorithm]
> + *
> + * - sign a 32-byte digest using an RSA-2048 PKCS#8 private key with
> + *   ``enc=pkcs1 hash=sha256``
> + * - verify the 256-byte signature using the matching X.509 public key
> + * - verify a mismatched digest fails verification with ``EKEYREJECTED``
> + */
> +
> +#include "keyctl_common.h"
> +#include "keyctl_pkey_data.h"
> +#include "tst_module.h"
> +
> +#define DIGEST_SIZE	32
> +#define SIG_SIZE	256
> +
> +static const unsigned char digest[DIGEST_SIZE] = {
> +	0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
> +	0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f,
> +	0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17,
> +	0x18, 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f,
> +};
> +
> +static unsigned char sig[SIG_SIZE];
> +static unsigned char wrong_digest[DIGEST_SIZE];

Here as well, these buffers should ideally be in the guarded buffers.

Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
