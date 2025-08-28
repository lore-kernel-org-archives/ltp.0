Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30630C8303F
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 10:26:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF4593CCFFD
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 12:26:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3C7AC3CCFED
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 12:25:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A5F3760083A
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 12:25:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D6FF4337F2;
 Thu, 28 Aug 2025 10:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756376741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O4cHGVRhgzuTSJxLV2V3Jg59s6a1SvJgVW7yVTfNMiY=;
 b=FO/zAkkrYF+AUtM2nYdlWlrIHyfGDzrAHFv7P8ndhp28WaoB5Zi5stmN31IEVqeTqJo3bN
 ihZhBELNl5kuP7viSb9ZjMTcF3iGyCxCzelXv+TZcHAf9DuzXDOXFibnu9dUWDp5RaGzkV
 sYxZR9ZlaFiMDYomeIfODvzWD9fnNtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756376741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O4cHGVRhgzuTSJxLV2V3Jg59s6a1SvJgVW7yVTfNMiY=;
 b=5p0DLWwTsfVvMfE/DGTd7Rv+vlNhzwKGk9hAq0djd0FV1n75kRdydibSnxIgr7CeS+F93y
 mDO0o5VukqHPXHDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756376740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O4cHGVRhgzuTSJxLV2V3Jg59s6a1SvJgVW7yVTfNMiY=;
 b=gDmzVtKPbNizR0GvWOzoz/F9Jn8Bt8P9VJpFrYGJwl5D2kAeYE1fiZP0GqNHQ0nPjJEZTx
 TuoQFR05Jm+kphSEIN+uHB0tc4X2c6SMeot5o46b3NKF8ehmyuGpjCTspeYvZG0S8Y9aSO
 KG5d+UZcaOZGxaQqqpjw+MCEr8GKmsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756376740;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O4cHGVRhgzuTSJxLV2V3Jg59s6a1SvJgVW7yVTfNMiY=;
 b=mfKrlTZnxYnLubt/D32uAW8+KoeaGQaXaT8iCFd5XUyATvTc2KzuZEicDA+Hydt1sRMMgc
 EC3j9sp1dpSS6XAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4C1013326;
 Thu, 28 Aug 2025 10:25:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ThHfLqQusGhZUgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 28 Aug 2025 10:25:40 +0000
Date: Thu, 28 Aug 2025 12:26:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <aLAuxxi5DLz22ztX@yuki.lan>
References: <20250822135702.23337-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250822135702.23337-1-mdoucha@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] aio_cancel_7-1: Write into a socket
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
> -	unlink(tmpfname);
> +	/* Socket buffer size is twice the maximum message size */
> +	bufsize /= 2;
>  
>  	/* create AIO req */
>  	for (i = 0; i < BUF_NB; i++) {
>  		aiocb[i] = calloc(1, sizeof(struct aiocb));
>  
>  		if (aiocb[i] == NULL) {
> -			printf(TNAME " Error at malloc(): %s\n",
> +			printf(TNAME " Error at calloc(): %s\n",
>  			       strerror(errno));
> -			close(fd);
> +			cleanup();
>  			return PTS_UNRESOLVED;
>  		}
> 
> -		aiocb[i]->aio_fildes = fd;
> -		aiocb[i]->aio_buf = malloc(BUF_SIZE);
> +		aiocb[i]->aio_fildes = fds[0];
> +		aiocb[i]->aio_buf = malloc(bufsize);
>  
>  		if (aiocb[i]->aio_buf == NULL) {
>  			printf(TNAME " Error at malloc(): %s\n",
>  			       strerror(errno));
> -			close(fd);
> +			cleanup();
>  			return PTS_UNRESOLVED;
>  		}
>  
> -		aiocb[i]->aio_nbytes = BUF_SIZE;
> +		aiocb[i]->aio_nbytes = bufsize;
>  		aiocb[i]->aio_offset = 0;
>  		aiocb[i]->aio_sigevent.sigev_notify = SIGEV_NONE;
>  
>  		if (aio_write(aiocb[i]) == -1) {
>  			printf(TNAME " loop %d: Error at aio_write(): %s\n",
>  			       i, strerror(errno));
> -			close(fd);
> +			cleanup();
>  			return PTS_FAIL;
>  		}
>  	}

Do I get it right that we queue eight aio writes and four of them finish
before the socket buffer is full and then the writing gets stuck with
the fift one?

So in the end we have four finished writes, one in progress and three
canceled?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
