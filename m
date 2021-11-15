Return-Path: <SRS0=J9GY=QC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E5AC433F5
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 15:21:32 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADC0061AAA
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 15:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ADC0061AAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 643C73C8622
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 16:21:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DC853C865F
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 16:21:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E46A960015C
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 16:21:13 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 34C9B21940;
 Mon, 15 Nov 2021 15:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636989673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KQIAD8O0cLTES2B8WPk8Ww2PNRZ/PzMPe4t8txVaPMM=;
 b=vHuuhIkDMEglnYED7SCAP3rkD52AsE7GmXkqKpuXHBfcLqOrYNynoP437jhwaZdd/QEH+t
 SaUyQMLlHdvBer3Iw0UyyqbbQT2qjlgf9kxtUaLVv7xrgxu3I+5q1b6FvpVyU0LIcXsC+9
 jvA3kCMXsKRCrUMmhDldDmXIc5xW5b8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636989673;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KQIAD8O0cLTES2B8WPk8Ww2PNRZ/PzMPe4t8txVaPMM=;
 b=rnCi74f3cU2/16j6pKq9/Yq2ee6wuUkhPLC405ERI1bTYWAn3G2cxC3TlkvqYrCaUVHt7L
 TBRGOmb1dst4IdDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BB2813A66;
 Mon, 15 Nov 2021 15:21:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3IDlBel6kmGNTgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 15 Nov 2021 15:21:13 +0000
Date: Mon, 15 Nov 2021 16:22:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <YZJ7KeRXJbEne7Jz@yuki>
References: <20211115081526.384856-1-lkml@jv-coder.de>
 <20211115081526.384856-4-lkml@jv-coder.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211115081526.384856-4-lkml@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] realtime/matrix_mult: Fix test optimization
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
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) International Business Machines  Corp., 2007, 2008
> + * 
> + * Authors: Darren Hart <dvhltc@us.ibm.com>
> + *          Dinakar Guniguntala <dino@in.ibm.com>
> + */
> +/*\
> + * [Description]
>   *
> - *   Copyright ?? International Business Machines  Corp., 2007, 2008
> - *
> - *   This program is free software;  you can redistribute it and/or modify
> - *   it under the terms of the GNU General Public License as published by
> - *   the Free Software Foundation; either version 2 of the License, or
> - *   (at your option) any later version.
> - *
> - *   This program is distributed in the hope that it will be useful,
> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> - *   the GNU General Public License for more details.
> - *
> - *   You should have received a copy of the GNU General Public License
> - *   along with this program;  if not, write to the Free Software
> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
> - *
> - * NAME
> - *      matrix_mult.c
> - *
> - * DESCRIPTION
> - *      Compare running sequential matrix multiplication routines
> - *      to running them in parallel to judge mutliprocessor
> - *      performance
> - *
> - * USAGE:
> - *      Use run_auto.sh script in current directory to build and run test.
> - *
> - * AUTHOR
> - *      Darren Hart <dvhltc@us.ibm.com>
> - *
> - * HISTORY
> - *      2007-Mar-09:  Initial version by Darren Hart <dvhltc@us.ibm.com>
> - *      2008-Feb-26:  Closely emulate jvm Dinakar Guniguntala <dino@in.ibm.com>
> - *
> - *****************************************************************************/
> + * Compare running sequential matrix multiplication routines
> + * to running them in parallel to judge multiprocessor
> + * performance
> + */

Ideally the comment changes should be in a separate patch...

>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -69,9 +46,14 @@ static int iterations_percpu;
>  stats_container_t sdat, cdat, *curdat;
>  stats_container_t shist, chist;
>  static pthread_barrier_t mult_start;
> -static pthread_mutex_t mutex_cpu;
>  
> -void usage(void)
> +struct matrices {
> +	double A[MATRIX_SIZE][MATRIX_SIZE];
> +	double B[MATRIX_SIZE][MATRIX_SIZE];
> +	double C[MATRIX_SIZE][MATRIX_SIZE];
> +};
> +
> +static void usage(void)
>  {
>  	rt_help();
>  	printf("matrix_mult specific options:\n");
> @@ -80,7 +62,7 @@ void usage(void)
>  	printf("  -i#	   #: number of iterations\n");
>  }
>  
> -int parse_args(int c, char *v)
> +static int parse_args(int c, char *v)
>  {
>  	int handled = 1;
>  	switch (c) {
> @@ -100,7 +82,7 @@ int parse_args(int c, char *v)
>  	return handled;
>  }
>  
> -void matrix_init(double A[MATRIX_SIZE][MATRIX_SIZE],
> +static void matrix_init(double A[MATRIX_SIZE][MATRIX_SIZE],
>  		 double B[MATRIX_SIZE][MATRIX_SIZE])

These static function conversions should ideally be in a separate patch
as well. At least the patch description does not mention either of these
changes.

>  {
>  	int i, j;
> @@ -112,41 +94,39 @@ void matrix_init(double A[MATRIX_SIZE][MATRIX_SIZE],
>  	}
>  }
>  
> -void matrix_mult(int m_size)
> +static void matrix_mult(struct matrices *matrices)
>  {
> -	double A[m_size][m_size];
> -	double B[m_size][m_size];
> -	double C[m_size][m_size];
>  	int i, j, k;
>  
> -	matrix_init(A, B);
> -	for (i = 0; i < m_size; i++) {
> -		int i_m = m_size - i;
> -		for (j = 0; j < m_size; j++) {
> -			double sum = A[i_m][j] * B[j][i];
> -			for (k = 0; k < m_size; k++)
> -				sum += A[i_m][k] * B[k][j];
> -			C[i][j] = sum;
> +	matrix_init(matrices->A, matrices->B);
> +	for (i = 0; i < MATRIX_SIZE; i++) {
> +		int i_m = MATRIX_SIZE - i;
> +		for (j = 0; j < MATRIX_SIZE; j++) {
> +			double sum = matrices->A[i_m][j] *  matrices->B[j][i];
> +			for (k = 0; k < MATRIX_SIZE; k++)
> +				sum +=  matrices->A[i_m][k] *  matrices->B[k][j];
> +			 matrices->C[i][j] = sum;
>  		}
>  	}
>  }
>  
> -void matrix_mult_record(int m_size, int index)
> +static void matrix_mult_record(struct matrices *matrices, int index)
>  {
>  	nsec_t start, end, delta;
>  	int i;
>  
>  	start = rt_gettime();
>  	for (i = 0; i < ops; i++)
> -		matrix_mult(MATRIX_SIZE);
> +		matrix_mult(matrices);
>  	end = rt_gettime();
>  	delta = (long)((end - start) / NS_PER_US);
>  	curdat->records[index].x = index;
>  	curdat->records[index].y = delta;
>  }
>  
> -int set_affinity(void)
> +static int set_affinity(void)
>  {
> +	static pthread_mutex_t mutex_cpu = PTHREAD_MUTEX_INITIALIZER;

As well as this change, it looks okay, but it's not listed in the patch
description.

>  	cpu_set_t mask;
>  	int cpuid;
>  
> @@ -166,9 +146,10 @@ int set_affinity(void)
>  	return -1;
>  }
>  
> -void *concurrent_thread(void *thread)
> +static void *concurrent_thread(void *thread)
>  {
>  	struct thread *t = (struct thread *)thread;
> +	struct matrices *matrices = (struct matrices *) t->arg;
>  	int thread_id = (intptr_t) t->id;
>  	int cpuid;
>  	int i;
> @@ -183,18 +164,23 @@ void *concurrent_thread(void *thread)
>  	index = iterations_percpu * thread_id;	/* To avoid stats overlapping */
>  	pthread_barrier_wait(&mult_start);
>  	for (i = 0; i < iterations_percpu; i++)
> -		matrix_mult_record(MATRIX_SIZE, index++);
> +		matrix_mult_record(matrices, index++);
>  
>  	return NULL;
>  }
>  
> -int main_thread(void)
> +static int main_thread(void)
>  {
>  	int ret, i, j;
>  	nsec_t start, end;
>  	long smin = 0, smax = 0, cmin = 0, cmax = 0, delta = 0;
>  	float savg, cavg;
>  	int cpuid;
> +	struct matrices *matrices[numcpus];
> +
> +	for (i = 0; i < numcpus; ++i) {
> +		matrices[i] = malloc(sizeof(struct matrices));
> +	}
>  
>  	if (stats_container_init(&sdat, iterations) ||
>  	    stats_container_init(&shist, HIST_BUCKETS) ||
> @@ -205,12 +191,11 @@ int main_thread(void)
>  		exit(1);
>  	}
>  
> -	tids = malloc(sizeof(int) * numcpus);
> +	tids = calloc(numcpus, sizeof(int));
>  	if (!tids) {
>  		perror("malloc");
>  		exit(1);
>  	}
> -	memset(tids, 0, numcpus);
>  
>  	cpuid = set_affinity();
>  	if (cpuid == -1) {
> @@ -223,8 +208,9 @@ int main_thread(void)
>  	curdat->index = iterations - 1;
>  	printf("\nRunning sequential operations\n");
>  	start = rt_gettime();
> -	for (i = 0; i < iterations; i++)
> -		matrix_mult_record(MATRIX_SIZE, i);
> +	for (i = 0; i < iterations; i++) {
> +		matrix_mult_record(matrices[0], i);
> +	}

And here LMKL coding style prefers to avoid the curly braces, but that
is very minor.

>  	end = rt_gettime();
>  	delta = (long)((end - start) / NS_PER_US);
>  
> @@ -256,7 +242,7 @@ int main_thread(void)
>  	online_cpu_id = -1;	/* Redispatch cpus */
>  	/* Create numcpus-1 concurrent threads */
>  	for (j = 0; j < numcpus; j++) {
> -		tids[j] = create_fifo_thread(concurrent_thread, NULL, PRIO);
> +		tids[j] = create_fifo_thread(concurrent_thread, matrices[j], PRIO);
>  		if (tids[j] == -1) {
>  			printf
>  			    ("Thread creation failed (max threads exceeded?)\n");
> @@ -308,6 +294,9 @@ int main_thread(void)
>  	     criteria);
>  	printf("Result: %s\n", ret ? "FAIL" : "PASS");
>  
> +	for (i = 0; i < numcpus; i++)
> +		free(matrices[i]);
> +
>  	return ret;
>  }
>  
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
