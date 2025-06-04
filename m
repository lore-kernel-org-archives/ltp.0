Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEE1C5B543
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 11:55:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7BC33CA100
	for <ltp@archiver.kernel.org>; Wed,  4 Jun 2025 13:55:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 66C703CA0A8
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 13:54:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D3B911A00E12
 for <ltp@lists.linux.it>; Wed,  4 Jun 2025 13:54:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 99D7B224E8;
 Wed,  4 Jun 2025 11:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749038094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ouy7kiS/dn76UDf51KYLpg7AWrr5CoeEUSIrNscTg8A=;
 b=xt2uKTy0MPUjn3PzLMLsxBQyDzb9hut9eTqfOzpyBH7J0jphNsWdRr+mSXBWKABsActd9y
 0relifr/SOXba/1ot7TuF5uqevyAC9C2TW/JGea9637Hz1R3tfjCeYOnHdYO+PNI6eJjJ4
 Pb/1VoHE7i6qPVUjq18epsSAIWXGnSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749038094;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ouy7kiS/dn76UDf51KYLpg7AWrr5CoeEUSIrNscTg8A=;
 b=KOh6blDiLNAVzNz+otGPZJFhQRNcx0z42I8rqDcLIBn+6XIsZIZUQeBExI95AWhhCNlF0I
 x1vGuyvtnAcfdJDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749038094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ouy7kiS/dn76UDf51KYLpg7AWrr5CoeEUSIrNscTg8A=;
 b=xt2uKTy0MPUjn3PzLMLsxBQyDzb9hut9eTqfOzpyBH7J0jphNsWdRr+mSXBWKABsActd9y
 0relifr/SOXba/1ot7TuF5uqevyAC9C2TW/JGea9637Hz1R3tfjCeYOnHdYO+PNI6eJjJ4
 Pb/1VoHE7i6qPVUjq18epsSAIWXGnSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749038094;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ouy7kiS/dn76UDf51KYLpg7AWrr5CoeEUSIrNscTg8A=;
 b=KOh6blDiLNAVzNz+otGPZJFhQRNcx0z42I8rqDcLIBn+6XIsZIZUQeBExI95AWhhCNlF0I
 x1vGuyvtnAcfdJDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8815813A63;
 Wed,  4 Jun 2025 11:54:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9x+gHw40QGhbQwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 04 Jun 2025 11:54:54 +0000
Date: Wed, 4 Jun 2025 13:55:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <aEA0LYNKcPPeS0Uw@yuki.lan>
References: <20250515015855.68510-1-liwang@redhat.com>
 <20250515015855.68510-3-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250515015855.68510-3-liwang@redhat.com>
X-Spamd-Result: default: False [-4.27 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-0.999];
 NEURAL_HAM_SHORT(-0.18)[-0.875]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/2] lib: moves test infrastructure states into
 a shared context structure
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
>  	if (tst_test->needs_checkpoints) {
> -		tst_futexes = (char *)results + sizeof(struct results);
> -		tst_max_futexes = (size - sizeof(struct results))/sizeof(futex_t);
> +		tst_futexes = ipc->futexes;
> +
> +		size_t futexes_offset = (char *)ipc->futexes - (char *)ipc;
> +		tst_max_futexes = (size - futexes_offset) / sizeof(futex_t);
                                           ^
					   This would be better as:
					   offsetof(struct ipc, futexes)
>  	}
>  
> -	memset(results, 0 , size);
> -	results->lib_pid = getpid();
> +	/* Set environment variable for exec()'d children */
> +	if (tst_test->needs_checkpoints || tst_test->child_needs_reinit) {
> +		snprintf(ipc_path, sizeof(ipc_path), IPC_ENV_VAR "=%s", shm_path);
> +		putenv(ipc_path);
> +	} else {
> +		SAFE_UNLINK(shm_path);
> +	}
>  }
>  
>  static void cleanup_ipc(void)
> @@ -157,9 +175,11 @@ static void cleanup_ipc(void)
>  	if (shm_path[0] && !access(shm_path, F_OK) && unlink(shm_path))
>  		tst_res(TWARN | TERRNO, "unlink(%s) failed", shm_path);
>  
> -	if (results) {
> -		msync((void *)results, size, MS_SYNC);
> -		munmap((void *)results, size);
> +	if (ipc) {
> +		msync((void *)ipc, size, MS_SYNC);
> +		munmap((void *)ipc, size);
> +		ipc = NULL;
> +		context = NULL;
>  		results = NULL;
>  	}
>  }
> @@ -177,12 +197,22 @@ void tst_reinit(void)
>  		tst_brk(TBROK, "File %s does not exist!", path);
>  
>  	fd = SAFE_OPEN(path, O_RDWR);
> +	ipc = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +	SAFE_CLOSE(fd);
>  
> -	results = SAFE_MMAP(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> -	tst_futexes = (char *)results + sizeof(struct results);
> -	tst_max_futexes = (size - sizeof(struct results))/sizeof(futex_t);
> +	if (ipc->magic != LTP_MAGIC)
> +		tst_brk(TBROK, "Invalid shared memory region (bad magic)");
>  
> -	SAFE_CLOSE(fd);
> +	/* Restore the parent context from IPC region */
> +	context = &ipc->context;
> +	results = &ipc->results;
> +
> +	tst_futexes = ipc->futexes;
> +	size_t futexes_offset = (char *)ipc->futexes - (char *)ipc;
> +	tst_max_futexes = (size - futexes_offset) / sizeof(futex_t);
                                   ^
				   Here as well.

> +	if (context->tdebug)
> +		tst_res(TINFO, "tst_reinit(): restored metadata for PID %d", getpid());
>  }
>  
>  extern char **environ;
> @@ -236,19 +266,19 @@ static void update_results(int ttype)
>  
>  	switch (ttype) {
>  	case TCONF:
> -		tst_atomic_inc(&results->skipped);
> +		tst_atomic_inc((int *)&results->skipped);
>  	break;
>  	case TPASS:
> -		tst_atomic_inc(&results->passed);
> +		tst_atomic_inc((int *)&results->passed);
>  	break;
>  	case TWARN:
> -		tst_atomic_inc(&results->warnings);
> +		tst_atomic_inc((int *)&results->warnings);
>  	break;
>  	case TFAIL:
> -		tst_atomic_inc(&results->failed);
> +		tst_atomic_inc((int *)&results->failed);
>  	break;
>  	case TBROK:
> -		tst_atomic_inc(&results->broken);
> +		tst_atomic_inc((int *)&results->broken);
>  	break;

This gets ugly. I guess that it would be better to keep the results as
int unless we change the tst_atomic.h to work with int32_t.

Maybe we can actually drop the assembly fallbacks from tst_atomic.h
since as far as I can tell the __atomic_*() functions were added to
gcc-4.7 and the __sync_*() function were added into gcc-4.1 so unless we
need to support compiler older than 4.1 we can drop the assembly and
easily add support for atomic operations for int32_t.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
