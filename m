Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0E6CAC5A7
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 11:55:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DEB13CDEBA
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 13:55:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B1FA3CDEA2
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 13:54:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 836F26005C9
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 13:54:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2FBCF1F800;
 Tue, 23 Sep 2025 11:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758628489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vS0Ny481oczTLXxX770wXqJa6mO1xOTJ40+Sldkf/nM=;
 b=JxQZJbhc1xjV/zRSnPaOzXr4RSclVF+wW5yY2SruTwOwVpSeWlWwsKXs2bwuDRGT1eT9GF
 T11/95rXFbazFsjQpHvClb4wbrbRQLAqcmwvsCo3HJR4vBiw6Envtdm9vpBLu6dnYTBI/1
 9tQZArFzy5bdYzQnx+PCEUsCIfzpFs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758628489;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vS0Ny481oczTLXxX770wXqJa6mO1xOTJ40+Sldkf/nM=;
 b=8KexgXr5PklEVTMLNPyY4WaL92hZ2bK/tqu+mKf1CEu+57qUwZgKuE1IDFXqRfacM1pWzV
 s0Tk9X5ENG0jaKCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JxQZJbhc;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8KexgXr5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758628489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vS0Ny481oczTLXxX770wXqJa6mO1xOTJ40+Sldkf/nM=;
 b=JxQZJbhc1xjV/zRSnPaOzXr4RSclVF+wW5yY2SruTwOwVpSeWlWwsKXs2bwuDRGT1eT9GF
 T11/95rXFbazFsjQpHvClb4wbrbRQLAqcmwvsCo3HJR4vBiw6Envtdm9vpBLu6dnYTBI/1
 9tQZArFzy5bdYzQnx+PCEUsCIfzpFs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758628489;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vS0Ny481oczTLXxX770wXqJa6mO1xOTJ40+Sldkf/nM=;
 b=8KexgXr5PklEVTMLNPyY4WaL92hZ2bK/tqu+mKf1CEu+57qUwZgKuE1IDFXqRfacM1pWzV
 s0Tk9X5ENG0jaKCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15525132C9;
 Tue, 23 Sep 2025 11:54:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r0Q6BImK0mj2CwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 23 Sep 2025 11:54:49 +0000
Date: Tue, 23 Sep 2025 13:55:33 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aNKKtXeaxoAfTsT8@yuki.lan>
References: <20250923-cve-2025-21756-v2-0-3bb1a6363123@suse.com>
 <20250923-cve-2025-21756-v2-2-3bb1a6363123@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250923-cve-2025-21756-v2-2-3bb1a6363123@suse.com>
X-Rspamd-Queue-Id: 2FBCF1F800
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] cve: add test reproducer for cve-2025-21756
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
> This test is verifying kernel commit fcdd2242c023 "vsock: Keep the
> binding until socket destruction" merged inside v6.14.
> 
> Beware, it will crash the system!
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/cve                    |  1 +
>  testcases/cve/.gitignore       |  1 +
>  testcases/cve/cve-2025-21756.c | 95 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 97 insertions(+)
> 
> diff --git a/runtest/cve b/runtest/cve
> index 6d575aa2165bcd46e5ca36a07db33f69a91bd94a..c3ecd74dd9f837924b810b7b431ebb911d809966 100644
> --- a/runtest/cve
> +++ b/runtest/cve
> @@ -92,3 +92,4 @@ cve-2020-25704 perf_event_open03
>  cve-2022-0185 fsconfig03
>  cve-2022-4378 cve-2022-4378
>  cve-2025-38236 cve-2025-38236
> +cve-2025-21756 cve-2025-21756
> diff --git a/testcases/cve/.gitignore b/testcases/cve/.gitignore
> index 8eb17ce56b01070e47917f9bb44cf146c0c5b338..dc1dad5b0d0d02a3ab57e72516c33ee7949c8431 100644
> --- a/testcases/cve/.gitignore
> +++ b/testcases/cve/.gitignore
> @@ -14,3 +14,4 @@ cve-2022-4378
>  icmp_rate_limit01
>  tcindex01
>  cve-2025-38236
> +cve-2025-21756
> diff --git a/testcases/cve/cve-2025-21756.c b/testcases/cve/cve-2025-21756.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..80fb84c473207fb2497f6ca6bb53166f0b1734cc
> --- /dev/null
> +++ b/testcases/cve/cve-2025-21756.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * Test for CVE-2025-21756 fixed in kernel v6.14:
> + * fcdd2242c023 vsock: Keep the binding until socket destruction
> + *
> + * Reproducer based on:
> + * https://lore.kernel.org/all/20250128-vsock-transport-vs-autobind-v3-5-1cf57065b770@rbox.co/
> + *
> + * Beware, this test will crash the system.
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/vm_sockets.h"
> +
> +#define MAX_PORT_RETRIES	24
> +#define VMADDR_CID_NONEXISTING	42
> +
> +static int vsock_bind(unsigned int cid, unsigned int port, int type)
> +{
> +	int sock;
> +
> +	struct sockaddr_vm sa = {
> +		.svm_family = AF_VSOCK,
> +		.svm_cid = cid,
> +		.svm_port = port,
> +	};
> +
> +	sock = SAFE_SOCKET(AF_VSOCK, type, 0);

So this generally works all the way back to the oldest LTP supported
kernel? I would expect that we would need an EINVAL check here.

Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
