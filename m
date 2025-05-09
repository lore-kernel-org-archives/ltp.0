Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 570D8C3ABC3
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 09:58:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABD4B3CC194
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 11:58:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24F163CBB10
 for <ltp@lists.linux.it>; Fri,  9 May 2025 11:58:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 841DE2002B5
 for <ltp@lists.linux.it>; Fri,  9 May 2025 11:58:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4331F1F390;
 Fri,  9 May 2025 09:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746784691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E6YZAueKZLP3GZGl74orHMOER+uPU6wvr0AhGtUel3U=;
 b=pq++gNLMW8IA/zwFqy+8Q/N+z4jtkITOMIDN9YJsHr0zksncduFAOrramDrwDJ0sO5Uopv
 /mr1QqvPISDH0qBGWwUsbHNMJcslEJtVnbGctEJAzfqwfC+UKE8SEzcTBJ/e1d4LJZAfs6
 5VOneIUQR0M3bdX2dkzEqc1cLP+r2Yk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746784691;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E6YZAueKZLP3GZGl74orHMOER+uPU6wvr0AhGtUel3U=;
 b=eeB3GFAGVo4svA8NaE1z2j/f3BV548UMIjhxgdRSKRe+egmH8O9gqSe5nJdDHBTxYLi/wr
 R1szPTzjPl7RFzCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pq++gNLM;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eeB3GFAG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746784691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E6YZAueKZLP3GZGl74orHMOER+uPU6wvr0AhGtUel3U=;
 b=pq++gNLMW8IA/zwFqy+8Q/N+z4jtkITOMIDN9YJsHr0zksncduFAOrramDrwDJ0sO5Uopv
 /mr1QqvPISDH0qBGWwUsbHNMJcslEJtVnbGctEJAzfqwfC+UKE8SEzcTBJ/e1d4LJZAfs6
 5VOneIUQR0M3bdX2dkzEqc1cLP+r2Yk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746784691;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E6YZAueKZLP3GZGl74orHMOER+uPU6wvr0AhGtUel3U=;
 b=eeB3GFAGVo4svA8NaE1z2j/f3BV548UMIjhxgdRSKRe+egmH8O9gqSe5nJdDHBTxYLi/wr
 R1szPTzjPl7RFzCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32B171399F;
 Fri,  9 May 2025 09:58:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JNIpC7PRHWgddwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 09 May 2025 09:58:11 +0000
Date: Fri, 9 May 2025 11:58:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <aB3R3YFumeKXYVKZ@yuki.lan>
References: <20250507154543.22309-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250507154543.22309-1-mdoucha@suse.cz>
X-Rspamd-Queue-Id: 4331F1F390
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap_24-1: Change vm.max_map_count if needed
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
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c
> index 6cc8349e1..91677d289 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c
> @@ -31,12 +31,40 @@
>  #include <stdint.h>
>  #include "posixtest.h"
>  
> +#define MAX_MAP_COUNT_PATH "/proc/sys/vm/max_map_count"
> +#define MAP_COUNT_LIMIT 65530
> +
> +void proc_write_val(const char *path, size_t val)
> +{
> +	FILE *procfile;
> +
> +	procfile = fopen(path, "r+");
> +
> +	if (!procfile)
> +		return;

We should print a message that we failed to open the file for the update
here, otherwise it's not clear if we managed to update the limit or not.

> +	fprintf(procfile, "%zu", val);
> +	fclose(procfile);
> +}
> +
>  int main(void)
>  {
>  	char tmpfname[256];
>  	void *pa;
> -	size_t len;
> +	size_t len, max_map_count = 0;
>  	int fd;
> +	FILE *procfile;
> +
> +	/* Change vm.max_map_count to avoid OOM */
> +	procfile = fopen(MAX_MAP_COUNT_PATH, "r+");
> +
> +	if (procfile) {
> +		fscanf(procfile, "%zu", &max_map_count);
> +		fclose(procfile);
> +	}
> +
> +	if (max_map_count > MAP_COUNT_LIMIT)
> +		proc_write_val(MAX_MAP_COUNT_PATH, MAP_COUNT_LIMIT);
>  
>  	/* Size of the shared memory object */
>  	size_t shm_size = 1024;
> @@ -78,5 +106,10 @@ int main(void)
>  
>  	close(fd);
>  	printf("Test FAILED: Did not get ENOMEM as expected\n");
> +
> +	/* Restore original vm.max_map_count */
> +	if (max_map_count > MAP_COUNT_LIMIT)
> +		proc_write_val(MAX_MAP_COUNT_PATH, max_map_count);


Otherwise it looks good:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
