Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F305C433F5
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 17:21:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BA193C9539
	for <ltp@archiver.kernel.org>; Thu, 13 Jan 2022 18:21:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 731343C3215
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 18:21:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BE7D7600973
 for <ltp@lists.linux.it>; Thu, 13 Jan 2022 18:21:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA383218F1;
 Thu, 13 Jan 2022 17:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642094469;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ladgQ82huq+Wo9sE2NQSa+eYydDSHw8pb4ymi382LN8=;
 b=2RWwUihlyTkVM2RdO6PatQToeeLOkPb7e9TYV/TI55l9Vu1UmRS3Jt5Hs9uwDTLmDvHWwd
 zyFx8+m1JQie9widP2GjPwM2qWYUKLp9CIt32x0GEhTSPj1rsc4wfwzlg+avEcc+MVqnWy
 06Bz2D1QBTFkDsIr0d4qIiQ8G9fgmK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642094469;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ladgQ82huq+Wo9sE2NQSa+eYydDSHw8pb4ymi382LN8=;
 b=ExT1L+O4WoIkIhmm2pKS88HA0w0NavjIhpvNsra30gpNdH61rMqdFC6VHZE98XsqAyT8HU
 OxhgjhYty3Q6rcDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BD22A13EA3;
 Thu, 13 Jan 2022 17:21:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ic8DLIVf4GGLTAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 13 Jan 2022 17:21:09 +0000
Date: Thu, 13 Jan 2022 18:21:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Message-ID: <YeBfgxRwzVbYCwLV@pevik>
References: <20220112161942.4065665-1-nikita.yushchenko@virtuozzo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220112161942.4065665-1-nikita.yushchenko@virtuozzo.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nfs_flock: fail the test if lock/unlock ops fail
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

Hi Nikita,

[ Cc Alexey ]
> Since nfs_flock is testing locking operations, ignoring errors returned
> from those operations is nonsense.

Makes sense.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
> ---
>  testcases/network/nfs/nfslock01/nfs_flock.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

> diff --git a/testcases/network/nfs/nfslock01/nfs_flock.c b/testcases/network/nfs/nfslock01/nfs_flock.c
> index a7673c751..a13ddd251 100644
> --- a/testcases/network/nfs/nfslock01/nfs_flock.c
> +++ b/testcases/network/nfs/nfslock01/nfs_flock.c
> @@ -63,16 +63,20 @@ int main(int argc, char **argv)
>  				continue;
>  		}

> -		if (writeb_lock(fd, offset, SEEK_SET, BYTES) < 0)
> -			printf("failed in writeb_lock, Errno = %d", errno);
> +		if (writeb_lock(fd, offset, SEEK_SET, BYTES) < 0) {
> +			printf("failed in writeb_lock, Errno = %d\n", errno);
> +			exit(1);
> +		}

>  		lseek(fd, offset, SEEK_SET);

>  		/* write to the test file */
>  		write(fd, buf, BYTES);

> -		if (unb_lock(fd, offset, SEEK_SET, BYTES) < 0)
> -			printf("failed in unb_lock, Errno = %d", errno);
> +		if (unb_lock(fd, offset, SEEK_SET, BYTES) < 0) {
> +			printf("failed in unb_lock, Errno = %d\n", errno);
> +			exit(1);
> +		}
>  	}
>  	exit(0);
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
