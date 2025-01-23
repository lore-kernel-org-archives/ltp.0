Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F3FC02182
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 11:35:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85EA63C4C4C
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 12:35:38 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 04D9D3C1927
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 12:35:21 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 67CDF225B76
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 12:35:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F3F531F38C;
 Thu, 23 Jan 2025 11:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737632120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R2FGP8s3xwBG+cgfMgvkXhqRN5Yu0UBz4CPVuLN36eE=;
 b=Qbswns+dnzKH3yL7TNvvpUZzFMDrT19Dfj/TvBErSDlpTgi6oLlztG4ry7tiX6xlin7yIf
 dkh1oZj6WfPtM9IL99GBJ3tZ1eHy88tf9SyF5McvUceULBYew3T7T13MnQpoVecfODhIYw
 ZC8PwtnI/hHYlmquSAxF6jwhkrvyp7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737632120;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R2FGP8s3xwBG+cgfMgvkXhqRN5Yu0UBz4CPVuLN36eE=;
 b=Xzh1TjuL4Z9gjeoTB7RRmjS4bBY1alH42UKJ10pdtEAC/TEmbF8qh7vF6ln/HRCAhQjSqH
 dxMMr06V6cFGBMBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Qbswns+d;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Xzh1TjuL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737632120; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R2FGP8s3xwBG+cgfMgvkXhqRN5Yu0UBz4CPVuLN36eE=;
 b=Qbswns+dnzKH3yL7TNvvpUZzFMDrT19Dfj/TvBErSDlpTgi6oLlztG4ry7tiX6xlin7yIf
 dkh1oZj6WfPtM9IL99GBJ3tZ1eHy88tf9SyF5McvUceULBYew3T7T13MnQpoVecfODhIYw
 ZC8PwtnI/hHYlmquSAxF6jwhkrvyp7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737632120;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R2FGP8s3xwBG+cgfMgvkXhqRN5Yu0UBz4CPVuLN36eE=;
 b=Xzh1TjuL4Z9gjeoTB7RRmjS4bBY1alH42UKJ10pdtEAC/TEmbF8qh7vF6ln/HRCAhQjSqH
 dxMMr06V6cFGBMBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E13621351A;
 Thu, 23 Jan 2025 11:35:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id R7YYNncpkmcIRgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 23 Jan 2025 11:35:19 +0000
Date: Thu, 23 Jan 2025 12:35:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Sven Schnelle <svens@linux.ibm.com>
Message-ID: <Z5IpckANo_28f7eS@yuki.lan>
References: <20250122135808.3827827-1-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250122135808.3827827-1-svens@linux.ibm.com>
X-Rspamd-Queue-Id: F3F531F38C
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mmap01: fix check_file() test for file
 corruption
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
> mmap01 reported random test failures. Investigation showed
> that check_file() will compare the whole buffer even if less
> bytes were read from the file. Adjust check_file() to:
> 
> - fail the test if the not the correct amount of data has been read.
> - only compare the bytes actually read
> 
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
> ---
> Changes in v2:
> 
> - check return value from SAFE_READ
> - only verify bytes actually read
> 
>  testcases/kernel/syscalls/mmap/mmap01.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
> index c93c37ceda52..b5798c8d2367 100644
> --- a/testcases/kernel/syscalls/mmap/mmap01.c
> +++ b/testcases/kernel/syscalls/mmap/mmap01.c
> @@ -35,15 +35,18 @@ static void check_file(void)
>  {
>  	int i, fildes, buf_len = sizeof(STRING) + 3;
>  	char buf[buf_len];
> +	ssize_t len;
>  
>  	fildes = SAFE_OPEN(TEMPFILE, O_RDONLY);
> -	SAFE_READ(0, fildes, buf, sizeof(buf));
> +	len = SAFE_READ(0, fildes, buf, sizeof(buf));
> +	if (len != strlen(STRING))
> +		tst_res(TFAIL, "Error reading from file\n");
                                                        ^
							no newline here
							please

		And possibly it would make sense to write how many
		characters were read and how many we expected so
		something as:

		tst_res(TFAIL, "Read %zi expected %zu", len, strlen(STRING));

		and we also want to do return; if we fail to read
		strlen(STRING) bytes because checking the buffer content
		does not make sense at that point, since it's possibly
		only partialy intialized

>  
> -	for (i = 0; i < buf_len; i++)
> +	for (i = 0; i < len; i++)
>  		if (buf[i] == 'X' || buf[i] == 'Y' || buf[i] == 'Z')
>  			break;
>  
> -	if (i == buf_len)
> +	if (i == len)
>  		tst_res(TPASS, "Specified pattern not found in file");
>  	else
>  		tst_res(TFAIL, "Specified pattern found in file");
> -- 
> 2.47.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
