Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40187C79FA1
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 07:54:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C1E03E91FF
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 09:54:27 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BCE93E91FB
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:54:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5291B1000458
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 09:54:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BEA631FEEC;
 Fri, 11 Sep 2026 07:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789113236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g8i1H9NncqrU4Usg1Uo36CX9qdTVm9S3F8Ek0mCsb9Q=;
 b=1hTlpmBFQOyP72no4apxTdQXRPO1yqXgrloGYcUafS86pWugd/PT6J8rInCvNbrAlmhFRz
 bDb2zoMVly+kVVeDSi90yarH0VnEOUqEJD6SGcKZdfs/bz494rgnOf/SWwGhMJnH7WTwBB
 eO4aXifM0cjKzt2NhAPBhGKJ0MrteNk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789113236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g8i1H9NncqrU4Usg1Uo36CX9qdTVm9S3F8Ek0mCsb9Q=;
 b=v2nl6IUHgAUrfuYoxeW1YOYRQTkn6hWEz3ATKb2ziQtPzU1Ty7Mkhce1Oyg2mioXmJwo1q
 1j6n7uwSmabclRDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="j/2Ysn8D";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="v1Z4/0rV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789113232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g8i1H9NncqrU4Usg1Uo36CX9qdTVm9S3F8Ek0mCsb9Q=;
 b=j/2Ysn8Dz0Rl/bnKgB34fSKYPQ3oEnL9hPhpMThcw+FmP6M5QHD3hHHvar5KB3NGdnfhrY
 /grlPkoeNjlsFF3xhLyaHijJE8UVfwnWSe7HhZhTGLABG0+qtByrjiuLUFfyAxpTtYeG3b
 CZW++yCmhTTzyVXMeLfqxRMjlM//6uo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789113232;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g8i1H9NncqrU4Usg1Uo36CX9qdTVm9S3F8Ek0mCsb9Q=;
 b=v1Z4/0rVMEDJHeKO0XFpoF+NrhIgmgktHj938HQvDS++KC/OYOhHojs5uD/MF8Zu41BbP3
 XqCeDgQQgRwx2bAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8981713715;
 Fri, 11 Sep 2026 07:53:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fg2KIZCzo2p5YQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Sep 2026 07:53:52 +0000
Date: Fri, 11 Sep 2026 09:54:02 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aqOzmkEbREEl5cqh@yuki.lan>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
 <20260904-keyctl_coverage-v2-2-43b78b15ef9f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260904-keyctl_coverage-v2-2-43b78b15ef9f@suse.com>
X-Rspamd-Queue-Id: BEA631FEEC
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,yuki.lan:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 02/33] keyctl10: Test KEYCTL_DESCRIBE format
 parsing
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/kernel/syscalls/keyctl/keyctl_common.h b/testcases/kernel/syscalls/keyctl/keyctl_common.h
> new file mode 100644
> index 000000000..c7290cc6e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/keyctl/keyctl_common.h
> @@ -0,0 +1,53 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +#ifndef KEYCTL_COMMON_H__
> +#define KEYCTL_COMMON_H__
> +
> +#include <stdint.h>
> +#include <string.h>
> +
> +#include "tst_test.h"
> +#include "lapi/keyctl.h"
> +
> +#define KEY_PERM_ALL		(KEY_POS_ALL | KEY_USR_ALL | KEY_GRP_ALL | KEY_OTH_ALL)
> +#define KEY_PERM_SET		(KEY_POS_ALL | KEY_USR_ALL)
> +
> +#define KEY_VIEW_BITS		(KEY_POS_VIEW | KEY_USR_VIEW | KEY_GRP_VIEW | KEY_OTH_VIEW)
> +#define KEY_PERM_NO_VIEW	(KEY_PERM_ALL & ~KEY_VIEW_BITS)
> +
> +#define KEY_WRITE_BITS		(KEY_POS_WRITE | KEY_USR_WRITE | KEY_GRP_WRITE | KEY_OTH_WRITE)
> +#define KEY_PERM_NO_WRITE	(KEY_PERM_ALL & ~KEY_WRITE_BITS)
> +
> +#define KEY_SETATTR_BITS	(KEY_POS_SETATTR | KEY_USR_SETATTR | KEY_GRP_SETATTR | KEY_OTH_SETATTR)
> +#define KEY_PERM_NO_SETATTR	(KEY_PERM_ALL & ~KEY_SETATTR_BITS)
> +
> +static inline key_serial_t new_ring(const char *desc)
> +{
> +	TEST(add_key("keyring", desc, NULL, 0, KEY_SPEC_PROCESS_KEYRING));
> +	if (TST_RET < 0)
> +		tst_brk(TBROK | TTERRNO, "failed to create keyring '%s'", desc);
> +
> +	return TST_RET;
> +}
> +
> +static inline key_serial_t new_user_key(const char *desc, const void *payload,
> +					size_t plen, key_serial_t ring)
> +{
> +	TEST(add_key("user", desc, payload, plen, ring));
> +	if (TST_RET < 0)
> +		tst_brk(TBROK | TTERRNO, "failed to add user key '%s'", desc);
> +
> +	return TST_RET;
> +}


These looks like we are working around the need to add SAFE_ADD_KEY().

Even if we are going to keep them in keyctl_common.h I would stick to
the SAFE_FOO() pattern, adding safe_add_key() first and building macros
on the top of it. I.e.:

SAFE_NEW_RING(const char *desc) \
	safe_add_key(__FILE__, __LINE__, "keyring", desc, NULL, 0, KEY_SPEC_PROCESS_KEYRING)

> +static inline key_serial_t search_ring(key_serial_t ring, const char *type,
> +				       const char *desc)
> +{
> +	return keyctl(KEYCTL_SEARCH, ring, (unsigned long)type,
> +		      (unsigned long)desc, 0);
> +}

I'm not that sure this indirection is adding much value.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
