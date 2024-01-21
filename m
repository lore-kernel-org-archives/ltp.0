Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86D0C47422
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 19:50:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BF0F3CE27C
	for <ltp@archiver.kernel.org>; Sun, 21 Jan 2024 20:50:08 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 722213CAF8E
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 20:49:53 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ED1591000340
 for <ltp@lists.linux.it>; Sun, 21 Jan 2024 20:49:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E4E861FD41;
 Sun, 21 Jan 2024 19:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705866592;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cu7f0rG3X5g2md3uK5663qgSE6R0fV4RsLXxQSZJF/w=;
 b=LmFqkS1ZJQ16e2rkbYIoFZ3YBiQ5zSKMOPX5l2tgRIDEXhGolYGYXrDc86x/09Nf54inJm
 ZHnhSLHOC6wSUpHHt47j4t15vUPxNAchGgJ4dpnvesDp2mslDuDZNQK4CGkeNFFBd2J8nA
 Eu4btzKdVTZAL7NUkNWLb3nyt3m63NM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705866592;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cu7f0rG3X5g2md3uK5663qgSE6R0fV4RsLXxQSZJF/w=;
 b=Uh9tNvHe0wfA33s+wa+yGejMRxtNSTTLofZDPVLzXBWkNJVL5pkDG3y5mhWgk6l1z3P7pU
 5Sa5nkrR0OOGASBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705866591;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cu7f0rG3X5g2md3uK5663qgSE6R0fV4RsLXxQSZJF/w=;
 b=Q4TdXlgqcOZTzOGa4WDqrntepzBQLepGarC3g6Q9yfxdDA1tU51pySYO2bSpr5LA2w1ENe
 69pSoOsHi/fchvAVl84Ln+gL/k2yB/TcC/vRWoHLfXhI65A3rzuKjSb2HgJWRVbOzdWHIa
 ZqOI6lyDjz1WzVbVnZZRvhkHD3TSTSI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705866591;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cu7f0rG3X5g2md3uK5663qgSE6R0fV4RsLXxQSZJF/w=;
 b=OpWJMnUuMHsqyzaOWWKeq3YAitRQgSQA4lS1Z6j1DpmPeBx/QKkMxAzNEGaGliU+HA/8j6
 mnEZJ4iRadJqJ2BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4E67139A1;
 Sun, 21 Jan 2024 19:49:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id b8LAIl91rWUjLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Sun, 21 Jan 2024 19:49:51 +0000
Date: Sun, 21 Jan 2024 20:49:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Xiao Yang <yangx.jy@fujitsu.com>
Message-ID: <20240121194949.GF51882@pevik>
References: <20240121122959.1386-1-yangx.jy@fujitsu.com>
 <20240121122959.1386-4-yangx.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240121122959.1386-4-yangx.jy@fujitsu.com>
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Q4TdXlgq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OpWJMnUu
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.71 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: E4E861FD41
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/4] syscalls/pwritev: Make make check happy
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

Hi Xiao Yang,

> Also add LTP Copyright.

> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/pwritev/pwritev.h   | 21 ++++++-------------
>  testcases/kernel/syscalls/pwritev/pwritev01.c |  7 ++++---
>  testcases/kernel/syscalls/pwritev/pwritev02.c |  7 ++++---
>  testcases/kernel/syscalls/pwritev/pwritev03.c |  3 ++-
>  4 files changed, 16 insertions(+), 22 deletions(-)

> diff --git a/testcases/kernel/syscalls/pwritev/pwritev.h b/testcases/kernel/syscalls/pwritev/pwritev.h
> index 833160ddb..bc98487d0 100644
> --- a/testcases/kernel/syscalls/pwritev/pwritev.h
> +++ b/testcases/kernel/syscalls/pwritev/pwritev.h
> @@ -1,18 +1,9 @@
> -/*
> -* Copyright (c) 2015 Fujitsu Ltd.
> -* Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
> -*
> -* This program is free software; you can redistribute it and/or modify it
> -* under the terms of version 2 of the GNU General Public License as
> -* published by the Free Software Foundation.
> -*
> -* This program is distributed in the hope that it would be useful, but
> -* WITHOUT ANY WARRANTY; without even the implied warranty of
> -* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> -*
> -* You should have received a copy of the GNU General Public License
> -* alone with this program.
> -*/
> +/* SPDX-License-Identifier: GPL-2.0
Again, you're the author, you could dare to relicense to GPL-2.0-or-later

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Although there is git freeze since Friday [1], I guess these simple fixes can be
merged even on Monday.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/Zak5QdHCUyUmJ5x4@yuki/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
