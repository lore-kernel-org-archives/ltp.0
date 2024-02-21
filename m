Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21570C48BC3
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 14:06:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79A6B3D0883
	for <ltp@archiver.kernel.org>; Wed, 21 Feb 2024 15:06:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10BE03C8EE0
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 15:06:10 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7A7AB1A0111B
 for <ltp@lists.linux.it>; Wed, 21 Feb 2024 15:06:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 42BE721F90;
 Wed, 21 Feb 2024 14:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708524367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9UNdB0EmbzBhaaBlnDLnNqwFS1ublojSRgyUN4wMX0o=;
 b=Q9GYkxKRiaPO1ipUBYMZ5nwBgfksyOpML8PqSFvxxjxhy8sRohE4CHn1ReGMD1EMPWTcUt
 geY9DVaZQcE4wKOYiI72/TjkJfmkP2QsuQwXhCad5oaphqjdo4/t7LIXBubJrIfv9JY/2w
 TMphI0pRffS8qnrDRFhgD6J5dvAJ2eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708524367;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9UNdB0EmbzBhaaBlnDLnNqwFS1ublojSRgyUN4wMX0o=;
 b=ivLqBmZTDhFuYl5yPofMGSBUTgYNXbRvuPeserl5sbaLAbHf/rb3zB96uOiUzz8P8M0Ydg
 AZXqg0nm91uZsDAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708524367; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9UNdB0EmbzBhaaBlnDLnNqwFS1ublojSRgyUN4wMX0o=;
 b=Q9GYkxKRiaPO1ipUBYMZ5nwBgfksyOpML8PqSFvxxjxhy8sRohE4CHn1ReGMD1EMPWTcUt
 geY9DVaZQcE4wKOYiI72/TjkJfmkP2QsuQwXhCad5oaphqjdo4/t7LIXBubJrIfv9JY/2w
 TMphI0pRffS8qnrDRFhgD6J5dvAJ2eo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708524367;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9UNdB0EmbzBhaaBlnDLnNqwFS1ublojSRgyUN4wMX0o=;
 b=ivLqBmZTDhFuYl5yPofMGSBUTgYNXbRvuPeserl5sbaLAbHf/rb3zB96uOiUzz8P8M0Ydg
 AZXqg0nm91uZsDAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31F7D13A69;
 Wed, 21 Feb 2024 14:06:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Aes9C08D1mXifAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 21 Feb 2024 14:06:07 +0000
Date: Wed, 21 Feb 2024 15:04:59 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <ZdYDC7m7xJ_MbXR3@yuki>
References: <20240219153012.3085-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240219153012.3085-1-akumar@suse.de>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Q9GYkxKR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ivLqBmZT
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 42BE721F90
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] msync01: Rewrite using new LTP API
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
> -/*
> - * setup() - performs all ONE TIME setup for this test.
> - *
> - * Get system page size,
> - * Creat a temporary directory and a file under it used for mapping.
> - * Write 1 page size char data into file.
> - * Initialize paged region (256 bytes) from the specified offset pos.
> - */
> -void setup(void)
> +static void setup(void)
>  {
> -	size_t c_total = 0, nwrite = 0;	/* no. of bytes to be written */
> -
> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> -
> -	TEST_PAUSE;
> +	page_sz = SAFE_SYSCONF(_SC_PAGESIZE);
>  
> -	page_sz = (size_t)getpagesize();
> +	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);
>  
> -	tst_tmpdir();
> -
> -	if ((fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0)
> -		tst_brkm(TBROK | TERRNO, cleanup, "open failed");
> -
> -	while (c_total < page_sz) {
> -		nwrite = write(fildes, write_buf, sizeof(write_buf));
> -		if (nwrite <= 0)
> -			tst_brkm(TBROK | TERRNO, cleanup, "write failed");
> -		else
> -			c_total += nwrite;
> -	}
> -
> -	/*
> -	 * Call mmap to map virtual memory (mul. of page size bytes) from the
> -	 * beginning of temporary file (offset is 0) into memory.
> -	 */
> -	addr = mmap(0, page_sz, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED,
> -		    fildes, 0);
> -
> -	/* Check for the return value of mmap() */
> -	if (addr == MAP_FAILED)
> -		tst_brkm(TBROK | TERRNO, cleanup, "mmap failed");
> -
> -	/* Set 256 bytes, at 100 byte offset in the mapped region */
> -	memset(addr + 100, 1, 256);
> +	SAFE_LSEEK(fd, page_sz, SEEK_SET);

Why the LSEEK here? If I'm reading the original code correctly it wrote
page_size worth of bytes not a single byte at page size offset.

Also I guess that we have to rewrite the file on each iteration, i.e.

- write page_size bytes 'a'
- mmap() that region and memset() to 'b'
- msync() that region
- read that back by read() and expect it to be changed to 'b'

Also given the speed of current hardware I would make the size of the
msynced() region to be configurable and set the default to a few
megabytes (8 or 16) at least.

> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, "a", 1);
>  }
>  
> -void cleanup(void)
> +static void cleanup(void)
>  {
> -	if (munmap(addr, page_sz) == -1)
> -		tst_resm(TBROK | TERRNO, "munmap failed");
> -
> -	if (close(fildes) == -1)
> -		tst_resm(TWARN | TERRNO, "close failed");
> -
> -	tst_rmdir();
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
>  }
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.needs_tmpdir = 1
> +};
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
