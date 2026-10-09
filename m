Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7AD8CA6019
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 16:05:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20B993E949F
	for <ltp@archiver.kernel.org>; Fri,  9 Oct 2026 18:05:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC90F3C21F2
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 18:05:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 87A5F1000D55
 for <ltp@lists.linux.it>; Fri,  9 Oct 2026 18:05:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 128C821BFF;
 Fri,  9 Oct 2026 16:05:17 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D2E011368B;
 Fri,  9 Oct 2026 16:05:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id r7z/KrwQyWrCCgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 09 Oct 2026 16:05:16 +0000
Date: Fri, 9 Oct 2026 18:05:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <askQyWTnbZFpGELv@yuki.lan>
References: <20261005-fix_core_lib_deepseek-v1-0-fec334ce8e80@suse.com>
 <20261005-fix_core_lib_deepseek-v1-15-fec334ce8e80@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261005-fix_core_lib_deepseek-v1-15-fec334ce8e80@suse.com>
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Spamd-Result: default: False [0.00 / 50.00]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 15/15] ujson: writer: Flush buffer before direct
 writes
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
> Fixes: c50a0e0751c8 ("libs: Vendor ujson library")
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  libs/ujson/ujson_writer.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/libs/ujson/ujson_writer.c b/libs/ujson/ujson_writer.c
> index 2553d8cd2..df67b1f4d 100644
> --- a/libs/ujson/ujson_writer.c
> +++ b/libs/ujson/ujson_writer.c
> @@ -424,8 +424,16 @@ static int out_writer_file(ujson_writer *self, const char *buf, size_t buf_len)
>  	size_t buf_size = sizeof(writer_file->buf);
>  	size_t buf_avail = buf_size - writer_file->buf_used;
>  
> -	if (buf_len > buf_size/4)
> +	if (buf_len > buf_size / 4) {
> +		if (writer_file->buf_used &&
> +		    out_writer_file_write(self, writer_file->fd,
> +					  writer_file->buf, writer_file->buf_used))

The check for buf_len == 0 should be inside the out_writer_fiel_write()
so that we do not have to handle it in each caller.

diff --git a/libs/ujson/ujson_writer.c b/libs/ujson/ujson_writer.c
index c86a3b2af..29a863287 100644
--- a/libs/ujson/ujson_writer.c
+++ b/libs/ujson/ujson_writer.c
@@ -389,6 +389,9 @@ struct json_writer_file {
 
 static int out_writer_file_write(ujson_writer *self, int fd, const char *buf, ssize_t buf_len)
 {
+       if (!buf_len)
+               return 0;
+
        do {

> +			return 1;
> +
> +		writer_file->buf_used = 0;
> +
>  		return out_writer_file_write(self, writer_file->fd, buf, buf_len);
> +	}
>  
>  	if (buf_len >= buf_avail) {
>  		if (out_writer_file_write(self, writer_file->fd,

For example we need the check here.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
