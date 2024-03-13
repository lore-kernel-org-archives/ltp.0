Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925C5C54791
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 09:58:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECF123CFD1F
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 10:58:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E8433CEC45
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 10:58:34 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 501F060227A
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 10:58:33 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C250B1F7BD;
 Wed, 13 Mar 2024 09:58:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B292F1397F;
 Wed, 13 Mar 2024 09:58:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uYmAKsh48WWqfwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 13 Mar 2024 09:58:32 +0000
Date: Wed, 13 Mar 2024 10:56:19 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZfF4Q7fcBdUCOslR@rei>
References: <20240313092331.18069-1-andrea.cervesato@suse.de>
 <20240313092331.18069-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240313092331.18069-2-andrea.cervesato@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: C250B1F7BD
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] Add SAFE_MPROTECT() macro
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
> +static void prot_to_str(const int prot, char *buf)
> +{
> +	char *ptr = buf;
>

I would still put an explicit check for the buffer size here, so that we
are sure that the complete combination of READ|WRITE|EXEC would fit, but
I guess that it's fine as long as this is an internal static function
and not part of the API.

> +	if (prot == PROT_NONE) {
> +		strcpy(buf, "PROT_NONE");
> +		return;
> +	}
> +
> +	if (prot & PROT_READ) {
> +		strcpy(ptr, PROT_FLAG_STR(PROT_READ));
> +		ptr += sizeof(PROT_FLAG_STR(PROT_READ)) - 1;
> +	}
> +
> +	if (prot & PROT_WRITE) {
> +		strcpy(ptr, PROT_FLAG_STR(PROT_WRITE));
> +		ptr += sizeof(PROT_FLAG_STR(PROT_WRITE)) - 1;
> +	}
> +
> +	if (prot & PROT_EXEC) {
> +		strcpy(ptr, PROT_FLAG_STR(PROT_EXEC));
> +		ptr += sizeof(PROT_FLAG_STR(PROT_EXEC)) - 1;
> +	}
> +
> +	if (buf != ptr)
> +		ptr[-3] = 0;
> +}
> +
>  static inline void *safe_mmap(const char *file, const int lineno,
>                                void *addr, size_t length,
>                                int prot, int flags, int fd, off_t offset)
> @@ -287,6 +318,35 @@ static inline void *safe_mmap(const char *file, const int lineno,
>  	safe_mmap(__FILE__, __LINE__, (addr), (length), (prot), \
>  	(flags), (fd), (offset))
>  
> +static inline int safe_mprotect(const char *file, const int lineno,
> +	char *addr, size_t len, int prot)
> +{
> +	int rval;
> +	char *prot_buf;
> +
> +	prot_buf = (char*) safe_malloc(file, lineno, 0, 512);

Why are we allocating the buffer? Why not just prot_buf[512] ?

Also the cast to (char*) is never needed in C as void* is automatically
converted to any type of a pointer without explicit cast.


Otherwise it looks good. You can add my Reviewed-by: if you change the
malloc to an array on the stack.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
