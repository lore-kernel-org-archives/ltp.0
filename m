Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62445C433F5
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 15:22:38 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5E32611C0
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 15:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A5E32611C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0F5D3C8B73
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 16:22:35 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C677D3C1824
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 16:22:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DC1C2601585
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 16:22:24 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0FAD2212C8;
 Fri, 19 Nov 2021 15:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637335344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xAnLhJUb9xaNy76qhf9qxHvgke50VMXiNeADNEup50=;
 b=w57YFdLHwzbKUQmWda3NY4+zjukOefk575lX7H5+9Uea2aWdNasiZFnD9isX9gUm6AUa8k
 pzR4pwKNTamJwZZA2zdMs8KAQtVw2QFOezhk90KFKWdRo2RStl5vFjGz+cL8ROEeZ1VMYu
 lfG7EyQTN9V/L3h21lRDtxvJWKWsfkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637335344;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7xAnLhJUb9xaNy76qhf9qxHvgke50VMXiNeADNEup50=;
 b=D8FxeSxAkYVNozf+6mjNYw0XL1r1MIwZ+1yuwrlgkTj2YUBfgn59i6bYj2ik4JrdQ4bGcH
 jSkwaPBDX37KaZBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF40413216;
 Fri, 19 Nov 2021 15:22:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jLRTNS/Bl2EqHAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 19 Nov 2021 15:22:23 +0000
Date: Fri, 19 Nov 2021 16:23:29 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <YZfBcfs8VZApzMU9@yuki>
References: <20211119074602.857595-1-lkml@jv-coder.de>
 <20211119074602.857595-6-lkml@jv-coder.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211119074602.857595-6-lkml@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 05/12] posix/conformance/interfaces: Fix all
 unused variable warnings
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c
> index e1ae59e3b..cd1aa0318 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_read/9-1.c
> @@ -48,7 +48,6 @@ int main(void)
>  	int i;
>  	struct aiocb aiocbs[NUM_AIOCBS];
>  	int last_req;
> -	int err;
>  	int ret;
>  
>  	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L
> @@ -85,7 +84,7 @@ int main(void)
>  	}
>  
>  	for (i = 0; i < last_req - 1; i++) {
> -		err = aio_error(&aiocbs[i]);
> +		aio_error(&aiocbs[i]);
>  		ret = aio_return(&aiocbs[i]);
>  
>  	}

Looking at the test the whole loop here is pointless, can we remove it
completely?

> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c
> index 277573a38..52c8d7004 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/aio_write/7-1.c
> @@ -48,7 +48,6 @@ int main(void)
>  	int i;
>  	struct aiocb aiocbs[NUM_AIOCBS];
>  	int last_req;
> -	int err;
>  	int ret;
>  
>  	if (sysconf(_SC_ASYNCHRONOUS_IO) < 200112L
> @@ -79,7 +78,7 @@ int main(void)
>  	}
>  
>  	for (i = 0; i < last_req - 1; i++) {
> -		err = aio_error(&aiocbs[i]);
> +		aio_error(&aiocbs[i]);
>  		ret = aio_return(&aiocbs[i]);
>  
>  	}

Here as well.

> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
> index aaf1403f9..9a0b148d9 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/fork/7-1.c
> @@ -51,7 +51,7 @@
>  
>  static void read_catalog(nl_catd cat, char *who)
>  {
> -	char *msg = NULL;
> +	char *msg PTS_ATTRIBUTE_UNUSED = NULL;
>  	int i, j;

I guess that in this case the test is wrong as well. It does not seem
that catgets() fails when it returns the pointer to the "not found"
string and does not even touch errno.

>  #if VERBOSE > 0
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_init/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_init/2-1.c
> index 4a60f7098..fbb7c68ff 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_init/2-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_init/2-1.c
> @@ -14,7 +14,7 @@
>  #include <stdio.h>
>  #include "posixtest.h"
>  
> -static pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
> +static pthread_cond_t cond PTS_ATTRIBUTE_UNUSED = PTHREAD_COND_INITIALIZER;

This one looks fine.

>  int main(void)
>  {
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/2-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/2-2.c
> index 2fc3ff700..16c658f73 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/2-2.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/2-2.c
> @@ -92,7 +92,7 @@
>  static int global = 0;
>  static int tab[3];
>  
> -#define CLEANUP(n) static void clnp##n(void * arg)\
> +#define CLEANUP(n) static void clnp##n(void * arg PTS_ATTRIBUTE_UNUSED)\
>  {\
>  	tab[global]=n; \
>  	global++; \
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/3-2.c
> index 5fa6c8b50..4437ffc77 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/3-2.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_exit/3-2.c
> @@ -94,7 +94,7 @@ static int global = 0;
>  static int tab[4];
>  static pthread_key_t tld[3];
>  
> -#define CLEANUP(n) static void clnp##n(void * arg)\
> +#define CLEANUP(n) static void clnp##n(void * arg PTS_ATTRIBUTE_UNUSED)\
>  {\
>  	tab[global]=n; \
>  	global++; \

THese two as well.

> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/3-1.c
> index 9ee86a5db..8a9b989f1 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/3-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_init/3-1.c
> @@ -5,7 +5,7 @@
>   * of this license, see the COPYING file at the top level of this
>   * source tree.
>  
> - * Test that the macro PTHREAD_MUTEX_INITIALIZER can be sued to intiailize
> + * Test that the macro PTHREAD_MUTEX_INITIALIZER can be used to initialize
>   * mutexes that are statically allocated.
>   *
>   */
> @@ -20,7 +20,7 @@ typedef struct my_data {
>  	int value;		/* Access protected by mutex */
>  } my_data_t;
>  
> -static my_data_t data = { PTHREAD_MUTEX_INITIALIZER, 0 };
> +static my_data_t data PTS_ATTRIBUTE_UNUSED = { PTHREAD_MUTEX_INITIALIZER, 0 };
>  
>  int main(void)
>  {

This one as well.

> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/4-1.c
> index a7099688b..d3c0bdae9 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/4-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/4-1.c
> @@ -32,9 +32,7 @@ static void *f1(void *parm);
>  static int ret;			/* Save return value of
>  				   pthread_mutex_timedlock(). */
>  static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;	/* The mutex */
> -static time_t currsec1, currsec2;	/* Variables for saving time before
> -				   and afer locking the mutex using
> -				   pthread_mutex_timedlock(). */
> +
>  /****************************
>   *
>   * MAIN()
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-1.c
> index 077bfe76d..f51106bdf 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-1.c
> @@ -40,9 +40,7 @@ static void *f1(void *parm);
>  static int ret;			/* Save return value of
>  				   pthread_mutex_timedlock(). */
>  static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;	/* The mutex */
> -static time_t currsec1, currsec2;	/* Variables for saving time before
> -				   and afer locking the mutex using
> -				   pthread_mutex_timedlock(). */
> +
>  /****************************
>   *
>   * MAIN()
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-2.c
> index 0eda6e58f..afca84eed 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-2.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-2.c
> @@ -40,9 +40,7 @@ static void *f1(void *parm);
>  static int ret;			/* Save return value of
>  				   pthread_mutex_timedlock(). */
>  static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;	/* The mutex */
> -static time_t currsec1, currsec2;	/* Variables for saving time before
> -				   and afer locking the mutex using
> -				   pthread_mutex_timedlock(). */
> +
>  /****************************
>   *
>   * MAIN()
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-3.c
> index baf429503..a5f8b3383 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-3.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_timedlock/5-3.c
> @@ -36,9 +36,7 @@ static void *f1(void *parm);
>  static int ret;			/* Save return value of
>  				   pthread_mutex_timedlock(). */
>  static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;	/* The mutex */
> -static time_t currsec1, currsec2;	/* Variables for saving time before
> -				   and afer locking the mutex using
> -				   pthread_mutex_timedlock(). */
> +
>  /****************************
>   *
>   * MAIN()

This part as well.

> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/4-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/4-3.c
> index e7e86bfa8..2145bde8a 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/4-3.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_trylock/4-3.c
> @@ -103,7 +103,6 @@ static struct _scenar {
>  #define NSCENAR (sizeof(scenarii)/sizeof(scenarii[0]))
>  
>  static char do_it = 1;
> -static char woken = 0;
>  static unsigned long count_ope = 0;
>  #ifdef WITH_SYNCHRO
>  static sem_t semsig1;
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_unlock/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_unlock/2-1.c
> index 27f0ee3d7..39dacb73e 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_unlock/2-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_unlock/2-1.c
> @@ -39,13 +39,13 @@ static int value;			/* value protected by mutex */
>  
>  int main(void)
>  {
> -	int i, rc;
> +	int i;
>  	pthread_t threads[THREAD_NUM];
>  
>  	/* Create threads */
>  	fprintf(stderr, "Creating %d threads\n", THREAD_NUM);
>  	for (i = 0; i < THREAD_NUM; ++i)
> -		rc = pthread_create(&threads[i], NULL, func, NULL);
> +		pthread_create(&threads[i], NULL, func, NULL);
>  
>  	/* Wait to join all threads */
>  	for (i = 0; i < THREAD_NUM; ++i)

Well technically we should check the return value, but this is better
than it was before.

> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/1-1.c
> index 909b53bf4..8e8617bbd 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/1-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutexattr_setpshared/1-1.c
> @@ -37,8 +37,6 @@
>  #include <stdio.h>
>  #include "posixtest.h"
>  
> -static pthread_mutex_t new_mutex;	/* The mutex. */
> -
>  int main(void)
>  {
>  	pthread_mutexattr_t mta;
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/4-1-buildonly.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/4-1-buildonly.c
> index 6e519962b..d3392f908 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/4-1-buildonly.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_once/4-1-buildonly.c
> @@ -11,5 +11,6 @@
>     */
>  
>  #include <pthread.h>
> +#include "posixtest.h"
>  
> -static pthread_once_t dummy = PTHREAD_ONCE_INIT;
> +static pthread_once_t dummy PTS_ATTRIBUTE_UNUSED = PTHREAD_ONCE_INIT;

And these two are fine as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
