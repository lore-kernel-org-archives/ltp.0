Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74440C46CD2
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 11:59:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D636D3CE506
	for <ltp@archiver.kernel.org>; Tue,  9 Jan 2024 12:59:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B966A3CD0F8
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 12:59:38 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A1A2220173C
 for <ltp@lists.linux.it>; Tue,  9 Jan 2024 12:59:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 54B8521DCD;
 Tue,  9 Jan 2024 11:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704801576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RPepdu8BRS+rimpD7iOPwHdO2SnUqUrlNbXYBNR1zRY=;
 b=pQn9uo7oBny8dmk1XriD6n25OpM8Z5dWlVafc/Y9CGa8wDI83mBNJNYA11Qv5K+dct0qTl
 19+yYpuHB4LgGYch0TQVg2VUPvfihqx+OeCS/RpI6h96EA1kWIa+tUg1KdQTJRuOKkew2p
 Wm8CJtcIg58dnAV14LSY6XzPtesMo5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704801576;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RPepdu8BRS+rimpD7iOPwHdO2SnUqUrlNbXYBNR1zRY=;
 b=RysB2mE1ypy9Q3Ne18Ib5/eVYrj4Wohm6tkKjyA7kKgEFTHupHcEfjhoG3rfwZfLJuBN5g
 /hKTOAHNUiJN1XCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704801576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RPepdu8BRS+rimpD7iOPwHdO2SnUqUrlNbXYBNR1zRY=;
 b=pQn9uo7oBny8dmk1XriD6n25OpM8Z5dWlVafc/Y9CGa8wDI83mBNJNYA11Qv5K+dct0qTl
 19+yYpuHB4LgGYch0TQVg2VUPvfihqx+OeCS/RpI6h96EA1kWIa+tUg1KdQTJRuOKkew2p
 Wm8CJtcIg58dnAV14LSY6XzPtesMo5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704801576;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RPepdu8BRS+rimpD7iOPwHdO2SnUqUrlNbXYBNR1zRY=;
 b=RysB2mE1ypy9Q3Ne18Ib5/eVYrj4Wohm6tkKjyA7kKgEFTHupHcEfjhoG3rfwZfLJuBN5g
 /hKTOAHNUiJN1XCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4527B134E8;
 Tue,  9 Jan 2024 11:59:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0J+gDyg1nWV7FQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 09 Jan 2024 11:59:36 +0000
Date: Tue, 9 Jan 2024 13:00:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: chenguanxi11234@163.com
Message-ID: <ZZ01QNfFCkSZR2Fr@yuki>
References: <ebf6297f90def1cac9f2d6202941b343c361c5a6.1704703396.git.chen.haonan2@zte.com.cn>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ebf6297f90def1cac9f2d6202941b343c361c5a6.1704703396.git.chen.haonan2@zte.com.cn>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.80 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FREEMAIL_TO(0.00)[163.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.00)[11.30%]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FREEMAIL_ENVRCPT(0.00)[163.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] posix/conformance/interfaces/sem_timedwait/2-1:
 Fix test
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
Cc: yang.guang5@zte.com.cn, ltp@lists.linux.it,
 Chen Haonan <chen.haonan2@zte.com.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +/* Modifications by: Chen Haonan <chen.haonan2@zte.com.cn>
> + * Date: 2024-01-08
> + *
> + * Since the parent and child processes are not operating on
> + * the same semaphore, this code wasn't doing its job correctly
> + * before, so we mapped the semaphore to a piece of shared
> + * memory and changed some implementation details in the
> + * original code to make it work.
> + */

Please do not duplicate the commit message in the actual code.

> +#include <stdlib.h>
>  #include <stdio.h>
>  #include <errno.h>
>  #include <unistd.h>
>  #include <semaphore.h>
>  #include <sys/stat.h>
>  #include <sys/wait.h>
> +#include <sys/mman.h>
>  #include <fcntl.h>
>  #include <signal.h>
>  #include <time.h>
> @@ -28,12 +39,16 @@
>  
>  int main(void)
>  {
> -	sem_t mysemp;
> +	sem_t *mysemp;
>  	struct timespec ts;
>  	int pid;
>  
> -	/* Semaphore started out locked */
> -	if (sem_init(&mysemp, 0, 0) == -1) {
> +	/* Map semaphore to shared memory */
> +	int shm_fd = shm_open("/myshm", O_CREAT | O_RDWR, 0666);
> _
> +	ftruncate(shm_fd, sizeof(sem_t));
> +	mysemp = (sem_t *)mmap(NULL, sizeof(sem_t), PROT_READ | PROT_WRITE, MAP_SHARED, shm_fd, 0);

We do not have to have a shm object for a shared memory between a parent
and a child process, for that we can just map anonymous shared memory.

> +	if (sem_init(mysemp, 1, 0) == -1) {
>  		perror(ERROR_PREFIX "sem_init");
>  		return PTS_UNRESOLVED;
>  	}
> @@ -43,20 +58,22 @@ int main(void)
>  	{
>  		ts.tv_sec = time(NULL) + 2;
>  		ts.tv_nsec = 0;
> -
> -		if (sem_timedwait(&mysemp, &ts) == -1) {
> +		if (sem_timedwait(mysemp, &ts) == -1) {
>  			puts("TEST FAILED");
> +			sem_destroy(mysemp);
> +			munmap(mysemp, sizeof(sem_t));
> +			close(shm_fd);
> +			shm_unlink("/myshm");
>  			return PTS_FAIL;
>  		} else {
> -			puts("TEST PASSED");
> -			sem_destroy(&mysemp);
> +			puts("TEST PASSED");
>  			return PTS_PASS;
>  		}
>  	} else if (pid > 0)	// parent to unlock semaphore
>  	{
>  		int i;
>  		sleep(1);
> -		if (sem_post(&mysemp) == -1) {
> +		if (sem_post(mysemp) == -1) {
>  			perror(ERROR_PREFIX "sem_post");
>  			return PTS_FAIL;
>  		}
> @@ -64,12 +81,14 @@ int main(void)
>  			perror("Error waiting for child to exit");
>  			return PTS_UNRESOLVED;
>  		}
> -
> -		if (!WEXITSTATUS(i)) {
> +		if (WEXITSTATUS(i)) {
>  			return PTS_FAIL;
>  		}
>  		puts("TEST PASSED");
> -		sem_destroy(&mysemp);
> +		sem_destroy(mysemp);
> +		munmap(mysemp, sizeof(sem_t));
> +		close(shm_fd);
> +		shm_unlink("/myshm");
>  		return PTS_PASS;
>  	}
>  	return PTS_UNRESOLVED;
> -- 
> 2.25.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
