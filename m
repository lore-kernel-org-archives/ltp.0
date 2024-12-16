Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79844E77180
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 13:02:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8C973EBDED
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 14:02:11 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C9753E763B
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 14:01:55 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B0BBB62FBA4
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 14:01:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4FF1A21162;
 Mon, 16 Dec 2024 13:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734354112;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UDTd/t8hU8pXVdj1y78kVH6x4HIxxvJ/9ILwEJ8U4ms=;
 b=ypamxWfcaXVYiNNDOHKUSk9jV/7OA6vT0A7s9Z9fUtxtUwHB4c8jKtA4OtdMAu3QwV6kmd
 TodWqd4SF6DhBjIGOPpugLQMH8RQQm45YHvs7v2h6fGcvnquSyVdJ9vmqTSNf/JLMo8kDg
 xLoslbdu7oMlgmNMhnQ3ILNCH0gCOCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734354112;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UDTd/t8hU8pXVdj1y78kVH6x4HIxxvJ/9ILwEJ8U4ms=;
 b=kG+yR6ERBeSq5dpdQCxz98BIvpWixXMyxxpb9r8hEu5/s2t7z8+ODVWwp5T/luCWXRwvh3
 Fb/H1lnA2B05nNAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ypamxWfc;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kG+yR6ER
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734354112;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UDTd/t8hU8pXVdj1y78kVH6x4HIxxvJ/9ILwEJ8U4ms=;
 b=ypamxWfcaXVYiNNDOHKUSk9jV/7OA6vT0A7s9Z9fUtxtUwHB4c8jKtA4OtdMAu3QwV6kmd
 TodWqd4SF6DhBjIGOPpugLQMH8RQQm45YHvs7v2h6fGcvnquSyVdJ9vmqTSNf/JLMo8kDg
 xLoslbdu7oMlgmNMhnQ3ILNCH0gCOCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734354112;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UDTd/t8hU8pXVdj1y78kVH6x4HIxxvJ/9ILwEJ8U4ms=;
 b=kG+yR6ERBeSq5dpdQCxz98BIvpWixXMyxxpb9r8hEu5/s2t7z8+ODVWwp5T/luCWXRwvh3
 Fb/H1lnA2B05nNAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 33F7713ACA;
 Mon, 16 Dec 2024 13:01:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id L2g1C8AkYGd4VAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 16 Dec 2024 13:01:52 +0000
Date: Mon, 16 Dec 2024 14:01:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Ricardo B. Marliere" <rbm@suse.com>
Message-ID: <20241216130150.GA589341@pevik>
References: <20241212-convert_mmap01-v6-1-d186b68c3f09@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241212-convert_mmap01-v6-1-d186b68c3f09@suse.com>
X-Rspamd-Queue-Id: 4FF1A21162
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] mmap01: Convert to new API
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

Hi Ricardo,

generally LGTM, with minor comments below (only relevant is SAFE_MSYNC()).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +++ b/testcases/kernel/syscalls/mmap/mmap01.c
> @@ -1,194 +1,145 @@

> -/*
> - * Test Description:
> - *  Verify that, mmap() succeeds when used to map a file where size of the
> - *  file is not a multiple of the page size, the memory area beyond the end
> - *  of the file to the end of the page is accessible. Also, verify that
> - *  this area is all zeroed and the modifications done to this area are
> - *  not written to the file.
> +/*\
> + * [Description]
>   *
> - * Expected Result:
> - *  mmap() should succeed returning the address of the mapped region.
> - *  The memory area beyond the end of file to the end of page should be
> - *  filled with zero.
> - *  The changes beyond the end of file should not get written to the file.
> + * Verify that mmap() succeeds when used to map a file where size of the
> + * file is not a multiple of the page size, the memory area beyond the end
> + * of the file to the end of the page is accessible. Also, verify that
> + * this area is all zeroed and the modifications done to this area are
> + * not written to the file.
nit: Slightly hard to read, but I'm not able to suggest any improvement.
>   *
> - * HISTORY
> - *	07/2001 Ported by Wayne Boyer
> + * mmap() should succeed returning the address of the mapped region.
> + * The memory area beyond the end of file to the end of page should be
> + * filled with zero.
nit: FYI this new line has no effect for docparse formatting (html/pdf formatting).
If you want to have separate paragraph, it needs to be extra blank space.
I would just continue the sentence in previous paragaraph.
> + * The changes beyond the end of file should not get written to the file.
>   */

> +#include "tst_test.h"
> +
> +#define TEMPFILE "mmapfile"
> +#define STRING "hello world\n"

...

static void check_file(void)
{
	...
	for (i = 0; i < buf_len; i++)
		if (buf[i] == 'X' || buf[i] == 'Y' || buf[i] == 'Z')
			break;

	if (i == buf_len)
		tst_res(TPASS, "Functionality of mmap() successful");
very nit: IMHO that mmap() works is detectable from TPASS. I like when TPASS
describe what was the evaluation, maybe something like "pattern found in the file" ?
	else
		tst_res(TFAIL, "Specified pattern found in file");
	SAFE_CLOSE(fildes);
}

> -	page_sz = getpagesize();
> +static void run(void)
> +{
> +	pid_t pid;
> +
> +	set_file();
> +
> +	addr = SAFE_MMAP(NULL, page_sz, PROT_READ | PROT_WRITE,
> +			 MAP_FILE | MAP_SHARED, fildes, 0);
> +
> +	/*
> +	 * Check if mapped memory area beyond EOF are zeros and changes beyond
> +	 * EOF are not written to file.
> +	 */
> +	if (memcmp(&addr[file_sz], dummy, page_sz - file_sz))
> +		tst_brk(TFAIL, "mapped memory area contains invalid data");
> +
> +	/*
> +	 * Initialize memory beyond file size
> +	 */
> +	addr[file_sz] = 'X';
> +	addr[file_sz + 1] = 'Y';
> +	addr[file_sz + 2] = 'Z';
> +
> +	/*
> +	 * Synchronize the mapped memory region with the file.
> +	 */
> +	if (msync(addr, page_sz, MS_SYNC) != 0) {
> +		tst_res(TFAIL | TERRNO, "failed to synchronize mapped file");
> +		return;
I would use here SAFE_MSYNC().
> +	}

> -	/* Allocate and initialize dummy string of system page size bytes */
> -	if ((dummy = calloc(page_sz, sizeof(char))) == NULL) {
> -		tst_brkm(TFAIL, cleanup, "calloc failed (dummy)");
> +	/*
> +	 * Now, search for the pattern 'XYZ' in the temporary file.
> +	 * The pattern should not be found and the return value should be 1.
> +	 */
> +	pid = SAFE_FORK();
> +	if (!pid) {
nit: pid is not needed, how about use SAFE_FORK() directly?
if (!SAFE_FORK()) {

> +		check_file();
> +		SAFE_MUNMAP(addr, page_sz);
> +		exit(0);
>  	}
...

> +static void setup(void)
> +{
> +	page_sz = getpagesize();
> +
> +	/* Allocate and initialize dummy string of system page size bytes */
> +	dummy = SAFE_CALLOC(page_sz, sizeof(char));
nit: sizeof(char) is always guaranteed to be 1, I would use:

	dummy = SAFE_CALLOC(page_sz, 1);

The rest LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
