Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66D3D78783
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 14:38:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DFF23CF82D
	for <ltp@archiver.kernel.org>; Fri, 19 Dec 2025 15:38:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 873C53CAD2A
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 15:37:45 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4138D1A00F95
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 15:37:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F79E5BD33;
 Fri, 19 Dec 2025 14:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766155063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AjcY75ybqS1QtWIQTQD7Wej8uyP4WXbyH6d3clfPijg=;
 b=CZZschizKaUhjKB7cEQOGSgLTNY6XEUa+n9eqz3BQjGCDrfQm3Oywx9kjCxATlOhVp5/MD
 Ok/Qejbig/+oRTu8bveZkeIwten1juTHe2E3M7sPllCs2H/9HnacROuogj51XH7CTZsGkM
 hydCW+7LWydpdVqG78jsi9Y/22e/lEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766155063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AjcY75ybqS1QtWIQTQD7Wej8uyP4WXbyH6d3clfPijg=;
 b=QXTYpum8+VNf81XdYKOpPbyCBMefCkuZQ9Z5u39bONpaP/3aFeciejIOCM/zQcXp64W5Yo
 JWB7GsUcVW9eZgAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZiWtg0t0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ORLH0t4N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766155062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AjcY75ybqS1QtWIQTQD7Wej8uyP4WXbyH6d3clfPijg=;
 b=ZiWtg0t03w5AnZ0wF3C0zH0FHLlJfH9A9vI62OWufHx2mXbvHKogc1c74D3Gd2McW9uHLd
 aPod1QEEpTbxItjAI8PXIlqtJdopI97kW4YiIvQB78hWjtz09qP090MRUYn2BhWH9Gnton
 V5syhSG0JB3zNtUuppqPWVxps/MVV9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766155062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AjcY75ybqS1QtWIQTQD7Wej8uyP4WXbyH6d3clfPijg=;
 b=ORLH0t4Nq7Y670x23EvGihHO8J/t9vIcVD/KqFeXQafLsZc0lB9EOAbeqWuVGUCjuiafKz
 K2hndQdyqgtSm+Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FF1B3EA63;
 Fri, 19 Dec 2025 14:37:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7n5mCjZjRWknPAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 19 Dec 2025 14:37:42 +0000
Date: Fri, 19 Dec 2025 15:38:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aUVjZh2ho98yMhid@yuki.lan>
References: <20251126073521.159834-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251126073521.159834-1-liwang@redhat.com>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3F79E5BD33
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH] readahead02: detect cache stats via mincore
 per testfile
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
> -	unsigned long ret;
> +	size_t pagecnt, resident = 0;
> +	size_t map_len;
> +	unsigned char *vec;
> +	void *addr;
> +	int fd;
> +	size_t i;
>  
> -	SAFE_FILE_LINES_SCANF(MEMINFO_FNAME, "Cached: %lu", &ret);
> +	if (!length)
> +		return 0;
>  
> -	return ret;
> +	fd = SAFE_OPEN(path, O_RDONLY);
> +
> +	pagecnt = (length + pagesize - 1) / pagesize;

We have LTP_ALIGN() macro, maybe we should use that one instead.

> +	map_len = pagecnt * pagesize;
> +
> +	addr = SAFE_MMAP(NULL, map_len, PROT_NONE, MAP_SHARED, fd, 0);
> +	vec = SAFE_MALLOC(pagecnt);
> +
> +	if (mincore(addr, map_len, vec) == -1)
> +		tst_brk(TBROK | TERRNO, "mincore");
> +
> +	for (i = 0; i < pagecnt; i++) {
> +		size_t chunk = pagesize;
> +		size_t tail = length % pagesize;
> +
> +		if (i == pagecnt - 1 && tail)
> +			chunk = tail;
> +
> +		if (vec[i] & 1)
> +			resident += chunk;
> +	}
> +
> +	free(vec);
> +	SAFE_MUNMAP(addr, map_len);
> +	SAFE_CLOSE(fd);
> +
> +	return resident;
>  }

Otherwise: Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
