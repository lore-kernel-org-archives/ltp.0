Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893DCCA5FFC
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 15:15:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 075293E2570
	for <ltp@archiver.kernel.org>; Mon,  5 Oct 2026 17:15:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86AF53CBE7F
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 17:15:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BDEFD60007B
 for <ltp@lists.linux.it>; Mon,  5 Oct 2026 17:15:15 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 94C6A1F78E;
 Mon,  5 Oct 2026 15:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791213310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fQ4j6+VDvUAY7gMYt8H9hklILuI7ijLE6SxqaxMYcrs=;
 b=g/IHfPd2c50vuCACE7804RFw/oGJpJEjSrwkWu2syanUC1QNSQm8wi6d64ICimpZh73yDr
 siqrU1k6WD4c2PTP8dh+C0x0DmKShrcPti+PoPN/fFAFMHuQGtJ4JXc4lZyBCTsZBlY43x
 Z6CA0XvBQK343l9hlRz01kzhqJq6LZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791213310;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fQ4j6+VDvUAY7gMYt8H9hklILuI7ijLE6SxqaxMYcrs=;
 b=/4HtjMhlQd7cNh7Ds/sc6aoV8oTvwDoB4RHLnAWpH+jVkmw3Hm0PH0LGmVuowBQPa1KJ48
 ZX4lL0NI0A4apCBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791213306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fQ4j6+VDvUAY7gMYt8H9hklILuI7ijLE6SxqaxMYcrs=;
 b=cHJwJLcSwrDbSXHjldeJsfjTPcoPISjKr8H3vtg0zR5Hv4vjyn26/mj3CxpZNddBVvLfr3
 ulrZZM94Bnldv+N8tfs+b9dDYmApr3vslcT6bWLx+snmmKQ5Cfuz3Bb2djcN+o4CBlcy1S
 Dz+yfcpipVxKryn8KGkfcxXOPje5ruY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791213306;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fQ4j6+VDvUAY7gMYt8H9hklILuI7ijLE6SxqaxMYcrs=;
 b=1rZvDlk/PzDUGQOOt6NDldI9fPYnoBqXMD5TLmd9oYxq/yNWVHe4Xxi7GyEmJzXkMZpZxO
 PkARmk0I/3kuX0CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6839113688;
 Mon,  5 Oct 2026 15:15:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KMO0EPq+w2piZgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 05 Oct 2026 15:15:06 +0000
Date: Mon, 5 Oct 2026 17:15:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <asO_Bq81gJC766Q2@yuki.lan>
References: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
 <20261005-fix_core_lib_deepseek-v1-4-fec334ce8e80@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261005-fix_core_lib_deepseek-v1-4-fec334ce8e80@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:email, yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 04/15] ujson: writer: Fix open() return value check
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
> open() returns -1 on failure and a non-negative file descriptor on
> success (including 0). Checking !writer_file->fd wrongly rejects fd 0
> as an error and accepts -1 on open failure. Check for negative fd
> instead.
> 
> Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  libs/ujson/ujson_writer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/libs/ujson/ujson_writer.c b/libs/ujson/ujson_writer.c
> index b5da494d1..040ae680e 100644
> --- a/libs/ujson/ujson_writer.c
> +++ b/libs/ujson/ujson_writer.c
> @@ -475,7 +475,7 @@ ujson_writer *ujson_writer_file_open(const char *path)
>  	writer_file = (void*)ret + sizeof(ujson_writer);
>  
>  	writer_file->fd = open(path, O_CREAT | O_WRONLY | O_TRUNC, 0664);
> -	if (!writer_file->fd) {
> +	if (writer_file->fd < 0) {
>  		free(ret);
>  		return NULL;
>  	}

This one is also very minor, since it's very unlikely that the fd 0
wouldn't be taken by stdin.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
