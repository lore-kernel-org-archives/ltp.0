Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E415BC55ABF
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 11:47:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 553BD3E2E66
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 13:47:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17DA33C73AF
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 13:47:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4D85660020C
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 13:47:00 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7C6003E16;
 Thu,  6 Aug 2026 11:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786016815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gxhtM1buKxS7QR3hRZl1IXH621jT6hkz4JRLBhNq4qE=;
 b=PaA1YfCsQZOg3CGwZf28NGW0R2fg3iUGlQSP3PBWFC/gI5oh1HbvK8+eUmygMC4Z8A9JRW
 yDHQWwGv2QWek+zpzjqve9lAebyfpKe9NlVVZODa6yiTT1uoZUF9ZsWmEiD5s81IpXRhWP
 UsjvhAExDqp60BkXXhPbx3WI7TLoXJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786016815;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gxhtM1buKxS7QR3hRZl1IXH621jT6hkz4JRLBhNq4qE=;
 b=WvXbWieDYl0UkCp+xBrQsXwmG1WQXYbxPSEZcohxLHwNy/6U5mqY2e5KL82Ee31IHo21rP
 7oINFzlJV6aLvsAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786016811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gxhtM1buKxS7QR3hRZl1IXH621jT6hkz4JRLBhNq4qE=;
 b=AICSl4CT/c580fZCCxbhnKT4otLgLaqYxdq1f/IDaK9Ye+BWkECwtzfdeB9Hej0OxI/7EM
 54KRORBsLpVRdqW+oGBTyhoM74aQKbKosj1dtHvEt9L/k6U9wlR+TRUc73IVJTLVdAmQVh
 tJ5sg+FoEVWF8zmY5YtGmxgjjkzAk3Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786016811;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gxhtM1buKxS7QR3hRZl1IXH621jT6hkz4JRLBhNq4qE=;
 b=TkBrEO8B3hTdElnR44J9xj6PDGJ2x7gl4qNZi+4qx1VvVLlhcoxCHOHkVAEjXMbDfFpkx7
 lJzFbjKp/NV++BDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6C7EA779B6;
 Thu,  6 Aug 2026 11:46:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jSRuGSt0dGphNQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 06 Aug 2026 11:46:51 +0000
Date: Thu, 6 Aug 2026 13:45:43 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <anRz55OQe2cjL12R@rei>
References: <20260721-rewrite_mremap_testing_suite-v1-0-ec2c3cff6ea4@suse.com>
 <20260721-rewrite_mremap_testing_suite-v1-1-ec2c3cff6ea4@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260721-rewrite_mremap_testing_suite-v1-1-ec2c3cff6ea4@suse.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] mremap01: Convert to new API
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
> -	/*
> -	 * Call mmap to map virtual memory (memsize bytes) from the
> -	 * beginning of temporary file (offset is 0) into memory.
> -	 */
> -	addr = mmap(0, memsize, PROT_WRITE, MAP_SHARED, fildes, 0);
> +	for (ind = 0; ind < newsize; ind++)
> +		addr[ind] = (char)ind;
>  
> -	/* Check for the return value of mmap() */
> -	if (addr == (char *)MAP_FAILED) {
> -		tst_brkm(TBROK, cleanup, "mmaping Failed on %s", TEMPFILE);
> -	}
> +	SAFE_MSYNC(addr, newsize, MS_SYNC);
>  
> -	/* Stretch the file to newsize of virtual memory block */
> -	if (lseek(fildes, (off_t) newsize, SEEK_SET) != (off_t) newsize) {
> -		tst_brkm(TBROK, cleanup, "lseek() to %d offset pos. Failed, "
> -			 "error=%d : %s", newsize, errno, strerror(errno));
> -	}
> +	if (verify_file())
> +		tst_res(TFAIL, "mremap()'d region did not sync to the file");
> +	else
> +		tst_res(TPASS, "Functionality of mremap() is correct");
>  
> -	/* Write one byte data into temporary file */
> -	if (write(fildes, "\0", 1) != 1) {
> -		tst_brkm(TBROK | TERRNO, cleanup, "writing to %s failed",
> -			 TEMPFILE);
> -	}

We should probably ftruncate(fd, 0) here so that we start with the same
state on -i 10.

> +	SAFE_MUNMAP(addr, newsize);
> +	addr = MAP_FAILED;

Can we patch SAFE_MUNMAP() to set the addr to MAP_FAILED as we do in
SAFE_CLOSE()?


Otherwise:
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
