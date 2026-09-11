Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1DEC88E50
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 12:12:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D70E73E9225
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 14:12:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26BE03C876A
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 14:11:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3EAB7600728
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 14:11:56 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0490C21C7F;
 Fri, 11 Sep 2026 12:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789128711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gNSzSt085vzXqOwWzs8a6cw90YT4jZuporSjjCHi8nE=;
 b=cfCcC8kseuI3ZTqnxHhde+gl3/B/jTykrtJWxJgR5FAgmv8ecYsgVNJCN9tdVKogCzzgiT
 84mmHrrhs7UWKE3OyDmwtG1U0tnHYl3P/JZc+Le1bfM6p3AZJvqZxB+4Ah4lwhQkrXlO/3
 dWlUYBrtU05YXbqi6Rj306NMI/HEvPY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789128711;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gNSzSt085vzXqOwWzs8a6cw90YT4jZuporSjjCHi8nE=;
 b=l3vO+7eBCmIpppkOn3q/tG68CWs8gtRz7K6kNoBrPSGcr0nF3xke6YpST0TfiXd9FRxjjR
 wiJhPV1McePHQbAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dUenuwum;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gahsmJho
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789128707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gNSzSt085vzXqOwWzs8a6cw90YT4jZuporSjjCHi8nE=;
 b=dUenuwumoiRs4ScRYqQyrqx/M+KkaiYF5GKUtFm+vGPZyIW709JqFeZ85Cmr+G2SHZwCML
 6jIY2j4+2p0O0S8g3TwX8tavoGzPl9baabUOVPbyxY19tQIytjUjy9Uhg/Jk/9bDt4DJHo
 uVKA0Cy7Bowo8Uy/mbE174lJMisGpVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789128707;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gNSzSt085vzXqOwWzs8a6cw90YT4jZuporSjjCHi8nE=;
 b=gahsmJho6zLyD+tXjiTIFEkbsWjw9syHhxZZGTg7AJNKchDw3nZ3M7+tqO3/LPYOr+1o4/
 lZYz77FKPRDSYFCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B606913770;
 Fri, 11 Sep 2026 12:11:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E9xoLALwo2qtbAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Sep 2026 12:11:46 +0000
Date: Fri, 11 Sep 2026 14:11:48 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aqPwBHMeuGApyhzG@yuki.lan>
References: <20260904-keyctl_coverage-v2-0-43b78b15ef9f@suse.com>
 <20260904-keyctl_coverage-v2-13-43b78b15ef9f@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260904-keyctl_coverage-v2-13-43b78b15ef9f@suse.com>
X-Rspamd-Queue-Id: 0490C21C7F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 13/33] keyctl21: Negative and boundary tests
 for KEYCTL_MOVE
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
> Test error and boundary conditions of KEYCTL_MOVE using a
> parameterized tcase table: KEYCTL_MOVE_EXCL (EEXIST), unknown flag
> bits (EINVAL), bogus IDs (ENOKEY), non-keyrings (ENOTDIR), unlinked
> key (ENOENT), keyring cycle (EDEADLK), and destination without
> Write permission (EACCES).
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/syscalls                            |   1 +
>  testcases/kernel/syscalls/keyctl/.gitignore |   1 +
>  testcases/kernel/syscalls/keyctl/keyctl21.c | 111 ++++++++++++++++++++++++++++
>  3 files changed, 113 insertions(+)
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index bfe4090a0..b95264564 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -738,6 +738,7 @@ keyctl17 keyctl17
>  keyctl18 keyctl18
>  keyctl19 keyctl19
>  keyctl20 keyctl20
> +keyctl21 keyctl21
>  
>  kcmp01 kcmp01
>  kcmp02 kcmp02
> diff --git a/testcases/kernel/syscalls/keyctl/.gitignore b/testcases/kernel/syscalls/keyctl/.gitignore
> index acddfa79e..e8c71e79e 100644
> --- a/testcases/kernel/syscalls/keyctl/.gitignore
> +++ b/testcases/kernel/syscalls/keyctl/.gitignore
> @@ -18,3 +18,4 @@
>  /keyctl18
>  /keyctl19
>  /keyctl20
> +/keyctl21
> diff --git a/testcases/kernel/syscalls/keyctl/keyctl21.c b/testcases/kernel/syscalls/keyctl/keyctl21.c
> new file mode 100644
> index 000000000..a2db5a406
> --- /dev/null
> +++ b/testcases/kernel/syscalls/keyctl/keyctl21.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Negative and boundary test cases for ``KEYCTL_MOVE`` of :manpage:`keyctl(2)`.
> + *
> + * [Algorithm]
> + *
> + * - ``KEYCTL_MOVE_EXCL`` fails with ``EEXIST`` when the destination already
> + *   holds a matching key
> + * - unknown flag bits are rejected with ``EINVAL``
> + * - bogus key or keyring ids fail with ``ENOKEY``
> + * - a plain key used as source or destination keyring fails with ``ENOTDIR``
> + * - moving a key that is not linked in the source fails with ``ENOENT``
> + * - moving a keyring into itself fails with ``EDEADLK`` from the keyring
> + *   cycle detection
> + * - moving into a keyring without Write permission fails with ``EACCES``
> + */
> +
> +#include "keyctl_common.h"
> +
> +#define RING_A_DESC	"ltpkeyctl21_a"
> +#define RING_B_DESC	"ltpkeyctl21_b"
> +#define RING_C_DESC	"ltpkeyctl21_c"
> +#define KEY_A_DESC	"ka"
> +#define KEY_B_DESC	"kb"
> +#define PAYLOAD		"payload"
> +
> +static key_serial_t ring_a, ring_b, ring_c, ring_no_write;
> +static key_serial_t key_a, key_b, key_excl;
> +static key_serial_t bogus_id = INT32_MAX;
> +
> +static struct tcase {
> +	key_serial_t *keyid;
> +	key_serial_t *from;
> +	key_serial_t *to;
> +	unsigned int flags;
> +	int exp_errno;
> +	const char *desc;
> +} tcases[] = {
> +	{ &key_a, &ring_a, &ring_b, KEYCTL_MOVE_EXCL,
> +	  EEXIST, "KEYCTL_MOVE_EXCL on existing key" },
> +
> +	{ &key_a, &ring_a, &ring_b, 0x2,
> +	  EINVAL, "unknown flag bits" },
> +
> +	{ &bogus_id, &ring_a, &ring_b, 0,
> +	  ENOKEY, "bogus key id" },
> +
> +	{ &key_a, &bogus_id, &ring_b, 0,
> +	  ENOKEY, "bogus source keyring" },
> +
> +	{ &key_a, &ring_a, &bogus_id, 0,
> +	  ENOKEY, "bogus destination keyring" },
> +
> +	{ &key_a, &key_b, &ring_b, 0,
> +	  ENOTDIR, "plain key as source keyring" },
> +
> +	{ &key_a, &ring_a, &key_b, 0,
> +	  ENOTDIR, "plain key as destination keyring" },
> +
> +	{ &key_b, &ring_a, &ring_b, 0,
> +	  ENOENT, "key not linked in the source keyring" },
> +
> +	{ &ring_c, &ring_b, &ring_c, 0,
> +	  EDEADLK, "keyring into itself" },
> +
> +	{ &key_a, &ring_a, &ring_no_write, 0,
> +	  EACCES, "destination without Write permission" },
> +};
> +
> +static void setup(void)
> +{
> +	SAFE_KEYCTL(KEYCTL_JOIN_SESSION_KEYRING, 0, 0, 0, 0);
> +
> +	ring_a = new_ring(RING_A_DESC);
> +	ring_b = new_ring(RING_B_DESC);
> +	ring_c = new_ring(RING_C_DESC);
> +	ring_no_write = new_ring("ltpkeyctl21_nowrite");
> +	SAFE_KEYCTL(KEYCTL_SETPERM, ring_no_write, KEY_PERM_NO_WRITE, 0, 0);
> +
> +	key_a = new_user_key(KEY_A_DESC, PAYLOAD, sizeof(PAYLOAD), ring_a);
> +	key_b = new_user_key(KEY_B_DESC, PAYLOAD, sizeof(PAYLOAD), ring_b);
> +	key_excl = new_user_key(KEY_A_DESC, PAYLOAD, sizeof(PAYLOAD), ring_b);

Same here, the new_ring and new_user_key should have been SAFE_..
macros.


Other than that it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
