Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09FCC001B0
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 15:14:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62D543CD722
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 17:14:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84F783C2A04
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 17:14:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BAAA1600828
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 17:14:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9D23A218E3;
 Mon, 14 Aug 2023 15:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1692026052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nz94PdCTVEk3MNNiUIRFwznMjlTHFRTri3tPfwoSNB0=;
 b=Al8ooeXQuxKpC8FcZF2rzUPWDEcFI/I/YQNFz2lUoO4bidfDTtIrL07eGBIteZX0snTLn4
 kwokvX4J/HmCUpr9NV6glluAu6oiWLw0u9IpHtpLBXOCMUh44hfvvz0pozOLCrhQdo1aMT
 LDd5vI0IQ0/iZLMV9aFcLvTQkbzcwsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1692026052;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nz94PdCTVEk3MNNiUIRFwznMjlTHFRTri3tPfwoSNB0=;
 b=YEsJlcyhTpXY5dOLIuRuirEiH+SRxWfv8EHCWZQ8k6qSgk0y45HmyFJrjzrD0H0OYHj6et
 7r5aBydo86MtC7Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 837D7138E2;
 Mon, 14 Aug 2023 15:14:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id EBLmHsRE2mQoEgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 14 Aug 2023 15:14:12 +0000
Date: Mon, 14 Aug 2023 17:15:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Message-ID: <ZNpE_7LKnB6ZGFbK@yuki>
References: <20230814061810.2297146-1-vishalc@linux.ibm.com>
 <20230814061810.2297146-2-vishalc@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230814061810.2297146-2-vishalc@linux.ibm.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] Enhanced thread safety in ebizzy benchmark
 tool
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
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, raj.khem@gmail.com,
 chris@mips.com, ltp@lists.linux.it, tdavies@darkphysics.net,
 gaowanlong@cn.fujitsu.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Modified ebizzy.c to improve thread safety by introducing a mutex for
> 'records_read' shared variable.
> 
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Reviewed-by: Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>  utils/benchmark/ebizzy-0.3/ebizzy.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/utils/benchmark/ebizzy-0.3/ebizzy.c b/utils/benchmark/ebizzy-0.3/ebizzy.c
> index 54b047130..1af004d9d 100644
> --- a/utils/benchmark/ebizzy-0.3/ebizzy.c
> +++ b/utils/benchmark/ebizzy-0.3/ebizzy.c
> @@ -85,6 +85,8 @@ static time_t start_time;
>  static volatile int threads_go;
>  static unsigned int records_read;
>  
> +pthread_mutex_t records_read_lock;

Can't we just initialze the mutex statically?

i.e.:

static pthread_mutex_t record_read_lock =  PTHREAD_MUTEX_INITIALIZER;


Then we don't have to intialize/destroy it.

Or even better we can rework the code so that the value is passed up to
the pthread_join() function which would serialize the code naturally,
something as:

diff --git a/utils/benchmark/ebizzy-0.3/ebizzy.c b/utils/benchmark/ebizzy-0.3/ebizzy.c
index 54b047130..841bf0a1c 100644
--- a/utils/benchmark/ebizzy-0.3/ebizzy.c
+++ b/utils/benchmark/ebizzy-0.3/ebizzy.c
@@ -50,6 +50,7 @@
 #include <time.h>
 #include <sys/time.h>
 #include <sys/resource.h>
+#include <stdint.h>

 #include "ebizzy.h"

@@ -83,7 +84,6 @@ static char **hole_mem;
 static unsigned int page_size;
 static time_t start_time;
 static volatile int threads_go;
-static unsigned int records_read;

 static void usage(void)
 {
@@ -423,6 +423,8 @@ static unsigned int search_mem(void)

 static void *thread_run(void *arg __attribute__((unused)))
 {
+       uintptr_t records_thread;
+
        if (verbose > 1)
                printf("Thread started\n");

@@ -430,13 +432,13 @@ static void *thread_run(void *arg __attribute__((unused)))

        while (threads_go == 0) ;

-       records_read += search_mem();
+       records_thread = search_mem();

        if (verbose > 1)
                printf("Thread finished, %f seconds\n",
                       difftime(time(NULL), start_time));

-       return NULL;
+       return (void *)records_thread;
 }

 static struct timeval difftimeval(struct timeval *end, struct timeval *start)
@@ -454,6 +456,7 @@ static void start_threads(void)
        unsigned int i;
        struct rusage start_ru, end_ru;
        struct timeval usr_time, sys_time;
+       unsigned int records_read = 0;
        int err;

        if (verbose)
@@ -484,11 +487,13 @@ static void start_threads(void)
         */

        for (i = 0; i < threads; i++) {
-               err = pthread_join(thread_array[i], NULL);
+               uintptr_t record_thread;
+               err = pthread_join(thread_array[i], (void *)&record_thread);
                if (err) {
                        fprintf(stderr, "Error joining thread %d\n", i);
                        exit(1);
                }
+               records_read += record_thread;
        }

        if (verbose)


>  static void usage(void)
>  {
>  	fprintf(stderr, "Usage: %s [options]\n"
> @@ -430,7 +432,9 @@ static void *thread_run(void *arg __attribute__((unused)))
>  
>  	while (threads_go == 0) ;
>  
> +	pthread_mutex_lock(&records_read_lock);
>  	records_read += search_mem();
> +	pthread_mutex_unlock(&records_read_lock);
>  
>  	if (verbose > 1)
>  		printf("Thread finished, %f seconds\n",
> @@ -456,6 +460,12 @@ static void start_threads(void)
>  	struct timeval usr_time, sys_time;
>  	int err;
>  
> +	/* Initialize the mutex before starting the threads */
> +	if (pthread_mutex_init(&records_read_lock, NULL) != 0) {
> +		fprintf(stderr, "Failed to initialize mutex\n");
> +		exit(1);
> +	}
> +
>  	if (verbose)
>  		printf("Threads starting\n");
>  
> @@ -491,6 +501,8 @@ static void start_threads(void)
>  		}
>  	}
>  
> +	pthread_mutex_destroy(&records_read_lock);
> +
>  	if (verbose)
>  		printf("Threads finished\n");
>  
> -- 
> 2.39.3
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
