Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2E8C77B7F
	for <ltp@archiver.kernel.org>; Tue, 16 May 2023 22:43:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE3423CDDFD
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 00:43:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1BAF73CA0BA
 for <ltp@lists.linux.it>; Wed, 17 May 2023 00:43:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DB86820092D
 for <ltp@lists.linux.it>; Wed, 17 May 2023 00:43:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 976B2201C2;
 Tue, 16 May 2023 22:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684276986;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OdpkNfysNwCLKQESnmaLwBpFid22RUI9jIg/tmrAg7s=;
 b=x6Mibu5N83CF/ie3pwHdda49tNslrso0wsTpzvUd2SEypm6jctFN6TquIcLVEEajO1QyQC
 p7y44thU9d4CN4T2isYWyT2XSNlChFxBWLa9Uh7pygoAtSlaQCHKNj5Z+uazcSFJtRfdt1
 HGyKvotWb+5RVnfUp8MEiQVTQx3baas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684276986;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OdpkNfysNwCLKQESnmaLwBpFid22RUI9jIg/tmrAg7s=;
 b=dhpjmdxJR0jO4rLFiTx5ygiwNJ97PlBVnSzu1PUcv3icGWfjKnLWzfCIlRlsXcxG3S3HlO
 4/V4llnROrQ30XCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 14C4D138F5;
 Tue, 16 May 2023 22:43:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id j+YXAvoGZGRXOwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 16 May 2023 22:43:06 +0000
Date: Wed, 17 May 2023 02:23:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Message-ID: <20230517002302.GA9395@pevik>
References: <20230516165929.1343864-1-khorenko@virtuozzo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230516165929.1343864-1-khorenko@virtuozzo.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] scsi_debug/tlibio/lio_write_buffer: Always
 return total amount of written bytes
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

Hi Konstantin,

> Sometimes we got failures like:
>  growfiles(gf217): 65884 growfiles.c/2262: 104203 tlibio.c/744 write(3, buf, 5000) returned=2288
>  growfiles(gf217): 65884 growfiles.c/1765: 104203 Hit max errors value of 1
>  gf217       1  TFAIL  :  growfiles.c:134: Test failed

I wonder on which circumstances do you get this error. Running on container?

> Which looked strange as partial write is something usual and valid.
> It turned out that lio_write_buffer() has the code cycle writes in case
> of a partial write happens, but it anyway returns the amount of bytes
> written by the LAST write.

> And upper growfile() consider the returned amount from
> lio_write_buffer() to be less than it tried to write and fails the
> testcase.

> Fix lio_write_buffer() to always return total bytes written, even in
> case partial writes.

> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
>  lib/tlibio.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

> diff --git a/lib/tlibio.c b/lib/tlibio.c
> index cc110d1c9..8298e2de9 100644
> --- a/lib/tlibio.c
> +++ b/lib/tlibio.c
> @@ -539,6 +539,8 @@ int lio_write_buffer(int fd,		/* open file descriptor */
>  		long wrd)	/* to allow future features, use zero for now */
>  {
>  	int ret = 0;		/* syscall return or used to get random method */
> +	int totally_written = 0;/* as we cycle writes in case of partial writes, */
> +				/* we have to report up total bytes written */

Nit: I'd do multiline comment (much more readable):

	/* as we cycle writes in case of partial writes,
	 * we have to report up total bytes written */
	int totally_written = 0;

Otherwise LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

>  	char *io_type;		/* Holds string of type of io */
>  	int omethod = method;
>  	int listio_cmd;		/* Holds the listio/lio_listio cmd */
> @@ -745,13 +747,14 @@ int lio_write_buffer(int fd,		/* open file descriptor */
>  						fd, size, ret);
>  					size -= ret;
>  					buffer += ret;
> +					totally_written += ret;
>  				} else {
>  					if (Debug_level > 1)
>  						printf
>  						    ("DEBUG %s/%d: write completed without error (ret %d)\n",
>  						     __FILE__, __LINE__, ret);

BTW growfiles.c and other files based on tlibio.c would deserve big cleanup and
rewrite into new API.

Kind regards,
Petr

> -					return ret;
> +					return totally_written + ret;
>  				}
>  			}
>  			wait4sync_io(fd, 0);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
