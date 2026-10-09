Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A05CA6019
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 14:15:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEE7D3E9C7F
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 16:15:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 451E43E294E
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 16:15:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BB1CB20011A
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 16:15:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4594B21BA9;
 Fri,  9 Oct 2026 14:15:15 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BE161368B;
 Fri,  9 Oct 2026 14:15:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZGW7APP2yGqQFAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 09 Oct 2026 14:15:15 +0000
Date: Fri, 9 Oct 2026 16:15:32 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <asj3BGzxX9DxPaGH@yuki.lan>
References: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
 <20261005-fix_core_lib_deepseek-v1-9-fec334ce8e80@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261005-fix_core_lib_deepseek-v1-9-fec334ce8e80@suse.com>
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Spamd-Result: default: False [0.00 / 50.00]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 09/15] ujson: reader: Do not increment depth on
 overflow
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
> any_first() increments buf->depth before verifying whether
> depth > max_depth. If recursion overflows, depth is left skewed
> beyond max_depth. Check bounds before incrementing.
> 
> Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  libs/ujson/ujson_reader.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/libs/ujson/ujson_reader.c b/libs/ujson/ujson_reader.c
> index 272df4d55..b73a31b8f 100644
> --- a/libs/ujson/ujson_reader.c
> +++ b/libs/ujson/ujson_reader.c
> @@ -811,13 +811,13 @@ static int any_first(ujson_reader *buf, char b)
>  		return 1;
>  	}
>  
> -	buf->depth++;
> -
> -	if (buf->depth > buf->max_depth) {
> +	if (buf->depth >= buf->max_depth) {
>  		ujson_err(buf, "Recursion too deep");
>  		return 1;
>  	}
>  
> +	buf->depth++;
> +
>  	return 0;
>  }

I think that this is not a real problem, since once the error is set in
the buffer all subsequent calls to the library just return, since all of
them call check_err() at the start. That means that once the error is
set we will never call this function again.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
