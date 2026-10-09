Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0C8CA6019
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 15:46:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06CE73EA8E3
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 17:46:48 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1276C3E2F43
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 17:46:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3EDA51A010A6
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 17:46:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CD73A1F7CB;
 Fri,  9 Oct 2026 15:46:29 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C9C41368B;
 Fri,  9 Oct 2026 15:46:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id syVSHVUMyWoLdgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 09 Oct 2026 15:46:29 +0000
Date: Fri, 9 Oct 2026 17:46:31 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <askMVzaXeF48_GHY@yuki.lan>
References: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
 <20261005-fix_core_lib_deepseek-v1-13-fec334ce8e80@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261005-fix_core_lib_deepseek-v1-13-fec334ce8e80@suse.com>
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Spamd-Bar: /
X-Rspamd-Queue-Id: CD73A1F7CB
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.00 / 50.00]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 13/15] ujson: writer: Set errno when a flush fails
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
> ujson_writer_file_close() uses errno to decide whether flushing the
> buffered data failed. out_writer_file_write() can fail without setting
> errno, when write() returns 0 or more bytes than requested, so close
> could report success even though data was lost. Set errno to EIO in
> these cases.
> 
> Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  libs/ujson/ujson_writer.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/libs/ujson/ujson_writer.c b/libs/ujson/ujson_writer.c
> index 15faca9be..49f73e436 100644
> --- a/libs/ujson/ujson_writer.c
> +++ b/libs/ujson/ujson_writer.c
> @@ -399,11 +399,15 @@ static int out_writer_file_write(ujson_writer *self, int fd, const char *buf, ss
>  		ssize_t ret = write(fd, buf, buf_len);
>  		if (ret <= 0) {
>  			err(self, "Failed to write to a file");
> +			/* ujson_writer_file_close() relies on errno */
> +			if (!ret)
> +				errno = EIO;

This is very edge case, most likely we will get ret == 0 if we are
writing to a non-blocking socket or pipe, however the code in the
library does only work on files. Maybe it would have more sense to add a
separtate message for the ret == 0 case:

		if (ret == 0) {
			err(self, "The write() syscall returned 0");
			errno = EAGAIN;
			return 1;
		}

>  			return 1;
>  		}
>  
>  		if (ret > buf_len) {
>  			err(self, "Wrote more bytes than requested?!");
> +			errno = EIO;
>  			return 1;
>  		}

This one looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
