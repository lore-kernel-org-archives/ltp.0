Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101E3606A31B
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=D31L9JOg;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Paq9E0B2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Ndj9vmEx;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bSKOhur3
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 985463CCB52
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 17:32:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 590373C99C9
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 17:31:47 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8263210009A6
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 17:31:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ED44321E56;
 Wed,  4 Nov 2026 16:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793809907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mvkV8QCZu/ZfONOBDFqSoNIDnc6CvicRn3v9ycxDTsI=;
 b=D31L9JOgT105k6bY6qNQxbgb3o/XESjrR6AzS5DrqU2cbL1HscpVnDYz0eiNQlJKm7s6Qm
 1sTgHihaAXg0NCYCr20enxdm4/yazjNm614iK5Ku0JmITV1jCU0uqTXT/x5fLSRpdkoBGf
 WYiQ7ROAo+SwMS0i4gg0XTaZKYrBn4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793809907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mvkV8QCZu/ZfONOBDFqSoNIDnc6CvicRn3v9ycxDTsI=;
 b=Paq9E0B23UrRLZoYLji0+79a/lpizSTJVDWL4z662I4LdBqk6atrHoiDLnqlLvNLgGpW9E
 aXo56E3wS9jjMFCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793809906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mvkV8QCZu/ZfONOBDFqSoNIDnc6CvicRn3v9ycxDTsI=;
 b=Ndj9vmExN8jJroXKazbkiJWZqVP/XcFV6hCCgP8Kz1puZ75iPltZe0iuKsKPbT0pNkQBTv
 N1MvIMJxkcJ8AyS3iFJsgOPhEzDIrpDdog9Kmo69Px6FPRA/3l/BwHPo8uSqVCFr+62jp+
 MQo2q74lS18S3g3jV/8RI/u7ckmkxJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793809906;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mvkV8QCZu/ZfONOBDFqSoNIDnc6CvicRn3v9ycxDTsI=;
 b=bSKOhur3/iURzJDVUj96YyXCMReldcjSjCrV97b22PutCz23H9xevjrahJm47cxBREvSAY
 VzL10ZM+tEdbgECw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB370134F0;
 Wed,  4 Nov 2026 16:31:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hETMJfJd62r1bwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 04 Nov 2026 16:31:46 +0000
Date: Wed, 4 Nov 2026 17:32:07 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Attila Fazekas <afazekas@redhat.com>
Message-ID: <auteByNCMzYWA5uV@yuki.lan>
References: <20261102105704.1577364-1-afazekas@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261102105704.1577364-1-afazekas@redhat.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -13.30
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap22: Bound child memory allocation to avoid OOM
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Assisted-by: Gemini CLI
> Signed-off-by: Attila Fazekas <afazekas@redhat.com>
> ---
>  testcases/kernel/syscalls/mmap/mmap22.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mmap/mmap22.c b/testcases/kernel/syscalls/mmap/mmap22.c
> index 0b95c578f..16fcb6dd8 100644
> --- a/testcases/kernel/syscalls/mmap/mmap22.c
> +++ b/testcases/kernel/syscalls/mmap/mmap22.c
> @@ -26,6 +26,7 @@
>  
>  #define MEM_LIMIT (256 * TST_MB)
>  #define ALLOC_SIZE (128 * TST_MB)
> +#define CHILD_ALLOC_MAX (ALLOC_SIZE + 32 * TST_MB)
                             ^
			     Wouldn't this be better:
			     (MEM_LIMIT - ALLOC_SIZE + 32*TST_MB)

That way this would stil work if we change either MEM_LIMIT or
ALLOC_SIZE.

Otherwise the change looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
