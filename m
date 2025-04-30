Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D08C369D9
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 14:41:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8E3C63CBCDA
	for <ltp@archiver.kernel.org>; Wed, 30 Apr 2025 16:41:28 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7F8F3C9D85
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 16:41:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 54B591400BEF
 for <ltp@lists.linux.it>; Wed, 30 Apr 2025 16:41:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B374211E0;
 Wed, 30 Apr 2025 14:41:11 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F97C13A25;
 Wed, 30 Apr 2025 14:41:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TALiGoc2EmhZDgAAD6G6ig
 (envelope-from <akumar@suse.de>); Wed, 30 Apr 2025 14:41:11 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Apr 2025 16:41:11 +0200
Message-ID: <12656046.O9o76ZdvQC@thinkpad>
In-Reply-To: <20250430133615.15571-1-chrubis@suse.cz>
References: <20250430133615.15571-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7B374211E0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: tlibio.c: Restore LIO_IO_SYNCV
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

On Wednesday, April 30, 2025 3:36:15 PM CEST Cyril Hrubis wrote:
> There was a single case of "#ifndef CRAY" in all the "#ifdef CRAY"
> macros that got removed accidentally. This patch restores that piece.
> 
> Fixes: fed3e3ee6399 ('lib/tlibio: Get rid of support for old UNIXes')
> Reported-by: Avinesh Kumar <akumar@suse.de>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Thank you Cyril!

Tested-by: Avinesh Kumar <akumar@suse.de>

> ---
>  lib/tlibio.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 56 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/tlibio.c b/lib/tlibio.c
> index 451244525..b3e723aa7 100644
> --- a/lib/tlibio.c
> +++ b/lib/tlibio.c
> @@ -767,6 +767,34 @@ int lio_write_buffer(int fd,		/* open file descriptor */
>  			return -errno;
>  		}
>  	}
> +	else if (method & LIO_IO_SYNCV) {
> +		io_type = "writev(2)";
> +
> +		sprintf(Lio_SysCall, "writev(%d, &iov, 1) nbyte:%d", fd, size);
> +
> +		if (Debug_level) {
> +			printf("DEBUG %s/%d: %s\n", __FILE__, __LINE__,
> +			       Lio_SysCall);
> +		}
> +		if ((ret = writev(fd, &iov, 1)) == -1) {
> +			sprintf(Errormsg,
> +				"%s/%d writev(%d, iov, 1) nbyte:%d ret:-1, errno=%d %s",
> +				__FILE__, __LINE__, fd, size, errno,
> +				strerror(errno));
> +			return -errno;
> +		}
> +
> +		if (ret != size) {
> +			sprintf(Errormsg,
> +				"%s/%d writev(%d, iov, 1) nbyte:%d returned=%d",
> +				__FILE__, __LINE__, fd, size, ret);
> +		} else if (Debug_level > 1)
> +			printf
> +			    ("DEBUG %s/%d: writev completed without error (ret %d)\n",
> +			     __FILE__, __LINE__, ret);
> +
> +		return ret;
> +	}			/* LIO_IO_SYNCV */
>  	/* LIO_IO_ALISTIO */
>  	else if (method & LIO_IO_SYNCP) {
>  		io_type = "pwrite(2)";
> @@ -1150,6 +1178,34 @@ int lio_read_buffer(int fd,	/* open file descriptor */
>  		}
>  	}
>  	/* LIO_IO_ALISTIO */
> +	else if (method & LIO_IO_SYNCV) {
> +		io_type = "readv(2)";
> +
> +		sprintf(Lio_SysCall, "readv(%d, &iov, 1) nbyte:%d", fd, size);
> +
> +		if (Debug_level) {
> +			printf("DEBUG %s/%d: %s\n", __FILE__, __LINE__,
> +			       Lio_SysCall);
> +		}
> +		if ((ret = readv(fd, &iov, 1)) == -1) {
> +			sprintf(Errormsg,
> +				"%s/%d readv(%d, iov, 1) nbyte:%d ret:-1, errno=%d %s",
> +				__FILE__, __LINE__, fd, size, errno,
> +				strerror(errno));
> +			return -errno;
> +		}
> +
> +		if (ret != size) {
> +			sprintf(Errormsg,
> +				"%s/%d readv(%d, iov, 1) nbyte:%d returned=%d",
> +				__FILE__, __LINE__, fd, size, ret);
> +		} else if (Debug_level > 1)
> +			printf
> +			    ("DEBUG %s/%d: readv completed without error (ret %d)\n",
> +			     __FILE__, __LINE__, ret);
> +
> +		return ret;
> +	}			/* LIO_IO_SYNCV */
>  	else if (method & LIO_IO_SYNCP) {
>  		io_type = "pread(2)";
>  
> 

Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
