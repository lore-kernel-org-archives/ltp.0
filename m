Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3258CD98C7
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 11:03:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 457C83E5B6D
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 13:03:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F36D43E5B6D
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 13:03:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EB29620098A
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 13:03:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED4A76AD4E;
 Mon, 15 Jun 2026 11:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781521419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pfQuuQkLWCirvlfsrJo9UZ2XLsPJWLCAy0WgZrUBXwc=;
 b=u11Ke1wTrIFg+cUugAuwD24QPhltpofISRqA9Y0+YfJ+pB+Ik3zCb/9J1dbdd4ZXkXcq07
 6xo651Q4bFQIj187QH1RyKKPYusLrEOzH5u88Mzf3xvumxGBsEiC/BzjDWi5CnWGvAYA0q
 HIrJ19j3Y4MX0GvN8XmhoBly7dkLJVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781521419;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pfQuuQkLWCirvlfsrJo9UZ2XLsPJWLCAy0WgZrUBXwc=;
 b=fqfcGwRFkZc4AaiCHmPdLN2lI1D/Gegur+b6ur4aR2kXz/vW1Ak3JrulhLdQWWFmXtiM9v
 4TNMzb0xR9aR2TCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=u11Ke1wT;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fqfcGwRF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781521419; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pfQuuQkLWCirvlfsrJo9UZ2XLsPJWLCAy0WgZrUBXwc=;
 b=u11Ke1wTrIFg+cUugAuwD24QPhltpofISRqA9Y0+YfJ+pB+Ik3zCb/9J1dbdd4ZXkXcq07
 6xo651Q4bFQIj187QH1RyKKPYusLrEOzH5u88Mzf3xvumxGBsEiC/BzjDWi5CnWGvAYA0q
 HIrJ19j3Y4MX0GvN8XmhoBly7dkLJVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781521419;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pfQuuQkLWCirvlfsrJo9UZ2XLsPJWLCAy0WgZrUBXwc=;
 b=fqfcGwRFkZc4AaiCHmPdLN2lI1D/Gegur+b6ur4aR2kXz/vW1Ak3JrulhLdQWWFmXtiM9v
 4TNMzb0xR9aR2TCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6E11779A7;
 Mon, 15 Jun 2026 11:03:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id udDBMgrcL2rbHgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 15 Jun 2026 11:03:38 +0000
Date: Mon, 15 Jun 2026 13:03:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ai_cB22CDvnGd1yK@yuki.lan>
References: <20260611-fw_load-v6-0-c2aec79a7ed7@suse.com>
 <20260611-fw_load-v6-1-c2aec79a7ed7@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260611-fw_load-v6-1-c2aec79a7ed7@suse.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:dkim,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns, suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: ED4A76AD4E
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/4] fw_load: Modernize ltp_fw_load kernel
 module
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
> diff --git a/testcases/kernel/firmware/fw_load_kernel/ltp_fw_load.c b/testcases/kernel/firmware/fw_load_kernel/ltp_fw_load.c
> index b7397e8f13154a16c2626517545c3c14d153a043..8aac0fc9691f85970be12fca360a17473474365b 100644
> --- a/testcases/kernel/firmware/fw_load_kernel/ltp_fw_load.c
> +++ b/testcases/kernel/firmware/fw_load_kernel/ltp_fw_load.c
> @@ -1,25 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2013 Oracle and/or its affiliates. All Rights Reserved.
> + * Author: Alexey Kodanev <alexey.kodanev@oracle.com>
>   *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation; either version 2 of
> - * the License, or (at your option) any later version.
> + * Copyright (c) 2023 Andrea Cervesato <andrea.cervesato@suse.com>
                     ^
		Shouldn't that be 2026?

Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
