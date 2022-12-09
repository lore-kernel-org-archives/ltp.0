Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5ACCC4167B
	for <ltp@archiver.kernel.org>; Fri,  9 Dec 2022 11:30:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 272C73CBFD7
	for <ltp@archiver.kernel.org>; Fri,  9 Dec 2022 12:30:05 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9C243CBFA6
 for <ltp@lists.linux.it>; Fri,  9 Dec 2022 12:29:52 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8737310009BA
 for <ltp@lists.linux.it>; Fri,  9 Dec 2022 12:29:51 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8C37E1FDB3;
 Fri,  9 Dec 2022 11:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670585390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vVj3ShzeW1eMc+eSXv2uADXaTbx4P6juHzxOFaKy72o=;
 b=qhMBHNGfQdXjC3g/ingVCp6eLytrCYdmb2+Nweg98CMFS17SYnnzqDoqa6rXtRMAWbllOc
 aeXqnnc87IA362nii2fbEV+3wIguJ4XFwGKfz66QK8JoqsNEUkU+KEHwFqTgrpyOsISybX
 006VNBwGeXQqc8Y7oBIfXOYueNrgfyI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670585390;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vVj3ShzeW1eMc+eSXv2uADXaTbx4P6juHzxOFaKy72o=;
 b=AhyDyuhHKXSTy4/doLQ/AKOZCGGfA/7uGdi7mUAQmf9tBs28eIYzR/qt4/DX+7LfBX7Me6
 4uIKQb5IKmoATVCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E58313597;
 Fri,  9 Dec 2022 11:29:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ta7KGS4ck2PFLAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 09 Dec 2022 11:29:50 +0000
Date: Fri, 9 Dec 2022 12:29:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Y5McIzmX7sCkDw6I@rei>
References: <20221130135451.28399-1-andrea.cervesato@suse.com>
 <20221130135451.28399-2-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221130135451.28399-2-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v10 1/2] Rewrite aio-stress test using LTP API
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
> + * Test creates a series of files and start AIO operations on them.
> + * AIO is done in a rotating loop: first file1.bin gets 8 requests, then
> + * file2.bin, then file3.bin etc. As each file finishes writing, test switches
> + * to reads. IO buffers are aligned in case we want to do raw IO.
                                                              ^
							      direct
>   */
> +
>  #define _FILE_OFFSET_BITS 64
> -#define PROG_VERSION "0.21"
> -#define NEW_GETEVENTS
>  
>  #define _GNU_SOURCE
> +#include "tst_test.h"
> +
> +#ifdef HAVE_LIBAIO
>  #include <stdio.h>
>  #include <errno.h>
>  #include <assert.h>
> @@ -60,16 +34,12 @@
>  #include <sys/mman.h>
>  #include <string.h>
>  #include <pthread.h>
> -
> -#include "config.h"
> -#include "tst_res_flags.h"
> -
> -#ifdef HAVE_LIBAIO
>  #include <libaio.h>
> +#include "tst_safe_pthread.h"
> +#include "tst_safe_sysv_ipc.h"
>  
>  #define IO_FREE 0
>  #define IO_PENDING 1
> -#define RUN_FOREVER -1
>  
>  enum {
>  	WRITE,
> @@ -83,52 +53,52 @@ enum {
>  #define USE_SHM 1
>  #define USE_SHMFS 2
>  
> -/*
> - * various globals, these are effectively read only by the time the threads
> - * are started
> - */
> -long stages = 0;
> -unsigned long page_size_mask;
> -int o_direct = 0;
> -int o_sync = 0;
> -int latency_stats = 0;
> -int completion_latency_stats = 0;
> -int io_iter = 8;
> -int iterations = RUN_FOREVER;
> -int max_io_submit = 0;
> -long rec_len = 64 * 1024;
> -int depth = 64;
> -int num_threads = 1;
> -int num_contexts = 1;
> -off_t context_offset = 2 * 1024 * 1024;
> -int fsync_stages = 1;
> -int use_shm = 0;
> -int shm_id;
> -char *unaligned_buffer = NULL;
> -char *aligned_buffer = NULL;
> -int padded_reclen = 0;
> -int stonewall = 1;
> -int verify = 0;
> -char *verify_buf = NULL;
> -int unlink_files = 0;
> -
> -struct io_unit;
> -struct thread_info;
> -
> -/* pthread mutexes and other globals for keeping the threads in sync */
> -pthread_cond_t stage_cond = PTHREAD_COND_INITIALIZER;
> -pthread_mutex_t stage_mutex = PTHREAD_MUTEX_INITIALIZER;
> -int threads_ending = 0;
> -int threads_starting = 0;
> -struct timeval global_stage_start_time;
> -struct thread_info *global_thread_info;
> +static char *str_num_files;
> +static char *str_max_io_submit;
> +static char *str_num_contexts;
> +static char *str_context_offset;
> +static char *str_file_size;
> +static char *str_rec_len;
> +static char *str_depth;
> +static char *str_io_iter;
> +static char *str_iterations;
> +static char *str_o_flag;
> +static char *str_stages;
> +static char *str_use_shm;
> +static char *str_num_threads;
> +
> +static int num_files = 1;
> +static long long file_size = 1024 * 1024 * 1024;
> +static long stages;
> +static unsigned long page_size_mask;
> +static int o_flag;
> +static char *latency_stats;
> +static char *completion_latency_stats;
> +static int io_iter = 8;
> +static int iterations = 500;
> +static int max_io_submit;
> +static long rec_len = 64 * 1024;
> +static int depth = 64;
> +static int num_threads = 1;
> +static int num_contexts = 1;
> +static long long context_offset = 2 * 1024 * 1024;
> +static char *no_fsync_stages;
> +static int use_shm;
> +static int shm_id;
> +static char *unaligned_buffer;
> +static char *aligned_buffer;
> +static int padded_reclen;
> +static char *no_stonewall;
> +static char *verify;
> +static char *verify_buf;
> +static char *unlink_files;
>  
>  /*
>   * latencies during io_submit are measured, these are the
>   * granularities for deviations
>   */
>  #define DEVIATIONS 6
> -int deviations[DEVIATIONS] = { 100, 250, 500, 1000, 5000, 10000 };
> +static int deviations[DEVIATIONS] = { 100, 250, 500, 1000, 5000, 10000 };
>  
>  struct io_latency {
>  	double max;
> @@ -140,7 +110,8 @@ struct io_latency {
>  
>  /* container for a series of operations to a file */
>  struct io_oper {
> -	/* already open file descriptor, valid for whatever operation you want */
> +	/* already open file descriptor, valid for whatever operation you want
> +	 */
>  	int fd;
>  
>  	/* starting byte of the operation */
> @@ -210,7 +181,7 @@ struct io_unit {
>  
>  	struct io_unit *next;
>  
> -	struct timeval io_start_time;	/* time of io_submit */
> +	struct timeval io_start_time; /* time of io_submit */
>  };
>  
>  struct thread_info {
> @@ -255,6 +226,14 @@ struct thread_info {
>  	struct io_latency io_completion_latency;
>  };
>  
> +/* pthread mutexes and other globals for keeping the threads in sync */
> +static pthread_cond_t stage_cond = PTHREAD_COND_INITIALIZER;
> +static pthread_mutex_t stage_mutex = PTHREAD_MUTEX_INITIALIZER;
> +static int threads_ending;
> +static int threads_starting;
> +static struct timeval global_stage_start_time;
> +static struct thread_info *global_thread_info;
> +
>  /*
>   * return seconds between start_tv and stop_tv in double precision
>   */
> @@ -262,15 +241,18 @@ static double time_since(struct timeval *start_tv, struct timeval *stop_tv)
>  {
>  	double sec, usec;
>  	double ret;
> +
>  	sec = stop_tv->tv_sec - start_tv->tv_sec;
>  	usec = stop_tv->tv_usec - start_tv->tv_usec;
>  	if (sec > 0 && usec < 0) {
>  		sec--;
>  		usec += 1000000;
>  	}
> +
>  	ret = sec + usec / (double)1000000;
>  	if (ret < 0)
>  		ret = 0;
> +
>  	return ret;
>  }
>  
> @@ -280,7 +262,9 @@ static double time_since(struct timeval *start_tv, struct timeval *stop_tv)
>  static double time_since_now(struct timeval *start_tv)
>  {
>  	struct timeval stop_time;
> +
>  	gettimeofday(&stop_time, NULL);
> +
>  	return time_since(start_tv, &stop_time);
>  }

We do have utility functions for exactly this in the tst_timer.h, but
this patch is large enough. So ideally we would make use of them in a
subsequent patch once this patchset is accepted.


...

> +static int setup_shared_mem(int num_threads, int num_files, int depth, int reclen)
>  {
>  	char *p = NULL;
>  	size_t total_ram;
> @@ -1017,6 +967,7 @@ int setup_shared_mem(int num_threads, int num_files, int depth,
>  	padded_reclen = (reclen + page_size_mask) / (page_size_mask + 1);
>  	padded_reclen = padded_reclen * (page_size_mask + 1);
>  	total_ram = num_files * depth * padded_reclen + num_threads;
> +
>  	if (verify)
>  		total_ram += padded_reclen;
>  
> @@ -1024,63 +975,40 @@ int setup_shared_mem(int num_threads, int num_files, int depth,
>  	total_ram += page_size_mask;
>  
>  	if (use_shm == USE_MALLOC) {
> -		p = malloc(total_ram);
> +		p = SAFE_MALLOC(total_ram);
>  	} else if (use_shm == USE_SHM) {
> -		shm_id = shmget(IPC_PRIVATE, total_ram, IPC_CREAT | 0700);
> -		if (shm_id < 0) {
> -			perror("shmget");
> -			drop_shm();
> -			goto free_buffers;
> -		}
> -		p = shmat(shm_id, (char *)0x50000000, 0);
> -		if ((long)p == -1) {
> -			perror("shmat");
> -			goto free_buffers;
> -		}
> -		/* won't really be dropped until we shmdt */
> -		drop_shm();
> +		SAFE_SHMGET(IPC_PRIVATE, total_ram, IPC_CREAT | 0700);
> +		p = SAFE_SHMAT(shm_id, (char *)0x50000000, 0);
>  	} else if (use_shm == USE_SHMFS) {
> -		char mmap_name[16];	/* /dev/shm/ + null + XXXXXX */
> +		char mmap_name[16]; /* /dev/shm/ + null + XXXXXX */
>  		int fd;
>  
>  		strcpy(mmap_name, "/dev/shm/XXXXXX");
>  		fd = mkstemp(mmap_name);
> -		if (fd < 0) {
> -			perror("mkstemp");
> -			goto free_buffers;
> -		}
> -		unlink(mmap_name);
> -		ftruncate(fd, total_ram);
> +		if (fd < 0)
> +			tst_brk(TBROK, "mkstemp error");
> +
> +		SAFE_UNLINK(mmap_name);

btw, we do have tst_creat_unlinked() now, so we may as well make use of
it in an subsequent patchset.

> +		SAFE_FTRUNCATE(fd, total_ram);
> +
>  		shm_id = fd;
> -		p = mmap((char *)0x50000000, total_ram,
> -			 PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>  
> -		if (p == MAP_FAILED) {
> -			perror("mmap");
> -			goto free_buffers;
> -		}
> -	}
> -	if (!p) {
> -		fprintf(stderr, "unable to allocate buffers\n");
> -		goto free_buffers;
> +		p = SAFE_MMAP((char *)0x50000000, total_ram,
> +			      PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
>  	}
> +
>  	unaligned_buffer = p;
> -	p = (char *)((intptr_t) (p + page_size_mask) & ~page_size_mask);
> +	p = (char *)((intptr_t)(p + page_size_mask) & ~page_size_mask);
>  	aligned_buffer = p;
> -	return 0;
>  
> -free_buffers:
> -	drop_shm();
> -	if (unaligned_buffer)
> -		free(unaligned_buffer);
> -	return -1;
> +	return 0;
>  }
>  
>  /*
>   * runs through all the thread_info structs and calculates a combined
>   * throughput
>   */
> -void global_thread_throughput(struct thread_info *t, char *this_stage)
> +static void global_thread_throughput(struct thread_info *t, char *this_stage)
>  {
>  	int i;
>  	double runtime = time_since_now(&global_stage_start_time);
> @@ -1089,16 +1017,17 @@ void global_thread_throughput(struct thread_info *t, char *this_stage)
>  
>  	for (i = 0; i < num_threads; i++) {
>  		total_mb += global_thread_info[i].stage_mb_trans;
> +
>  		if (!min_trans || t->stage_mb_trans < min_trans)
>  			min_trans = t->stage_mb_trans;
>  	}
> +
>  	if (total_mb) {
> -		fprintf(stderr, "%s throughput (%.2f MB/s) ", this_stage,
> -			total_mb / runtime);
> -		fprintf(stderr, "%.2f MB in %.2fs", total_mb, runtime);
> -		if (stonewall)
> -			fprintf(stderr, " min transfer %.2fMB", min_trans);
> -		fprintf(stderr, "\n");
> +		tst_res(TINFO, "%s throughput (%.2f MB/s)", this_stage, total_mb / runtime);
> +		tst_res(TINFO, "%.2f MB in %.2fs", total_mb, runtime);
> +
> +		if (no_stonewall)
> +			tst_res(TINFO, "min transfer %.2fMB", min_trans);
>  	}
>  }
>  
> @@ -1111,7 +1040,7 @@ void global_thread_throughput(struct thread_info *t, char *this_stage)
>   * various timings are printed in between the stages, along with
>   * thread synchronization if there are more than one threads.
>   */
> -int worker(struct thread_info *t)
> +static int *worker(struct thread_info *t)
>  {
>  	struct io_oper *oper;
>  	char *this_stage = NULL;
> @@ -1126,15 +1055,18 @@ restart:
>  	if (num_threads > 1) {
>  		pthread_mutex_lock(&stage_mutex);
>  		threads_starting++;
> +
>  		if (threads_starting == num_threads) {
>  			threads_ending = 0;
>  			gettimeofday(&global_stage_start_time, NULL);
>  			pthread_cond_broadcast(&stage_cond);
>  		}
> +
>  		while (threads_starting != num_threads)
>  			pthread_cond_wait(&stage_cond, &stage_mutex);
>  		pthread_mutex_unlock(&stage_mutex);
>  	}
> +
>  	if (t->active_opers) {
>  		this_stage = stage_name(t->active_opers->rw);
>  		gettimeofday(&stage_time, NULL);
> @@ -1142,10 +1074,10 @@ restart:
>  	}
>  
>  	cnt = 0;
> +
>  	/* first we send everything through aio */
> -	while (t->active_opers
> -	       && (cnt < iterations || iterations == RUN_FOREVER)) {
> -		if (stonewall && threads_ending) {
> +	while (t->active_opers && cnt < iterations) {
> +		if (!no_stonewall && threads_ending) {
>  			oper = t->active_opers;
>  			oper->stonewalled = 1;
>  			oper_list_del(oper, &t->active_opers);
> @@ -1155,6 +1087,7 @@ restart:
>  		}
>  		cnt++;
>  	}
> +
>  	if (latency_stats)
>  		print_latency(t);
>  
> @@ -1175,44 +1108,49 @@ restart:
>  	 */
>  	oper = t->finished_opers;
>  	while (oper) {
> -		if (fsync_stages)
> -			fsync(oper->fd);
> +		if (!no_fsync_stages)
> +			SAFE_FSYNC(oper->fd);
> +
>  		t->stage_mb_trans += oper_mb_trans(oper);
> +
>  		if (restart_oper(oper)) {
>  			oper_list_del(oper, &t->finished_opers);
>  			oper_list_add(oper, &t->active_opers);
>  			oper = t->finished_opers;
>  			continue;
>  		}
> +
>  		oper = oper->next;
> +
>  		if (oper == t->finished_opers)
>  			break;
>  	}
>  
>  	if (t->stage_mb_trans && t->num_files > 0) {
>  		double seconds = time_since_now(&stage_time);
> -		fprintf(stderr,
> -			"thread %td %s totals (%.2f MB/s) %.2f MB in %.2fs\n",
> +
> +		tst_res(TINFO, "thread %td %s totals (%.2f MB/s) %.2f MB in %.2fs",
>  			t - global_thread_info, this_stage,
> -			t->stage_mb_trans / seconds, t->stage_mb_trans,
> -			seconds);
> +			t->stage_mb_trans / seconds, t->stage_mb_trans, seconds);
>  	}
>  
>  	if (num_threads > 1) {
>  		pthread_mutex_lock(&stage_mutex);
>  		threads_ending++;
> +
>  		if (threads_ending == num_threads) {
>  			threads_starting = 0;
>  			pthread_cond_broadcast(&stage_cond);
>  			global_thread_throughput(t, this_stage);
>  		}
> +
>  		while (threads_ending != num_threads)
>  			pthread_cond_wait(&stage_cond, &stage_mutex);
>  		pthread_mutex_unlock(&stage_mutex);
>  	}
>  
>  	/* someone got restarted, go back to the beginning */
> -	if (t->active_opers && (cnt < iterations || iterations == RUN_FOREVER)) {
> +	if (t->active_opers && cnt < iterations) {
>  		iteration++;
>  		goto restart;
>  	}
> @@ -1224,210 +1162,112 @@ restart:
>  		status = finish_oper(t, oper);
>  	}
>  
> -	if (t->num_global_pending) {
> -		fprintf(stderr, "global num pending is %d\n",
> -			t->num_global_pending);
> -	}
> +	if (t->num_global_pending)
> +		tst_res(TINFO, "global num pending is %d", t->num_global_pending);
> +
>  	io_queue_release(t->io_ctx);
>  
> -	return status;
> +	return (void *)(intptr_t)status;
>  }
>  
> -typedef void *(*start_routine) (void *);
> -int run_workers(struct thread_info *t, int num_threads)
> +typedef void *(*start_routine)(void *);
> +static int run_workers(struct thread_info *t, int num_threads)
>  {
> -	int ret;
> +	void *retval;
> +	int ret = 0;
>  	int i;
>  
> +	for (i = 0; i < num_threads; i++)
> +		SAFE_PTHREAD_CREATE(&t[i].tid, NULL, (start_routine)worker, t + i);
> +
>  	for (i = 0; i < num_threads; i++) {
> -		ret =
> -		    pthread_create(&t[i].tid, NULL, (start_routine) worker,
> -				   t + i);
> -		if (ret) {
> -			perror("pthread_create");
> -			exit(1);
> -		}
> -	}
> -	for (i = 0; i < num_threads; i++) {
> -		ret = pthread_join(t[i].tid, NULL);
> -		if (ret) {
> -			perror("pthread_join");
> -			exit(1);
> -		}
> +		SAFE_PTHREAD_JOIN(t[i].tid, &retval);
> +		ret = (intptr_t)retval;

This does not look right, with that we would return the exit value only
for the last joined thread. I suppoose this should have been
ret |= (intptr_t)retval; instead.

>  	}
> -	return 0;
> -}
>  
> -off_t parse_size(char *size_arg, off_t mult)
> -{
> -	char c;
> -	int num;
> -	off_t ret;
> -	c = size_arg[strlen(size_arg) - 1];
> -	if (c > '9') {
> -		size_arg[strlen(size_arg) - 1] = '\0';
> -	}
> -	num = atoi(size_arg);
> -	switch (c) {
> -	case 'g':
> -	case 'G':
> -		mult = 1024 * 1024 * 1024;
> -		break;
> -	case 'm':
> -	case 'M':
> -		mult = 1024 * 1024;
> -		break;
> -	case 'k':
> -	case 'K':
> -		mult = 1024;
> -		break;
> -	case 'b':
> -	case 'B':
> -		mult = 1;
> -		break;
> -	}
> -	ret = mult * num;
>  	return ret;
>  }
>  
> -void print_usage(void)
> +static void setup(void)
>  {
> -	printf
> -	    ("usage: aio-stress [-s size] [-r size] [-a size] [-d num] [-b num]\n");
> -	printf
> -	    ("                  [-i num] [-t num] [-c num] [-C size] [-nxhOS ]\n");
> -	printf("                  file1 [file2 ...]\n");
> -	printf("\t-a size in KB at which to align buffers\n");
> -	printf("\t-b max number of iocbs to give io_submit at once\n");
> -	printf("\t-c number of io contexts per file\n");
> -	printf("\t-C offset between contexts, default 2MB\n");
> -	printf("\t-s size in MB of the test file(s), default 1024MB\n");
> -	printf("\t-r record size in KB used for each io, default 64KB\n");
> -	printf
> -	    ("\t-d number of pending aio requests for each file, default 64\n");
> -	printf("\t-i number of I/O per file sent before switching\n"
> -	       "\t   to the next file, default 8\n");
> -	printf("\t-I total number of ayncs I/O the program will run, "
> -	       "default is run until Cntl-C\n");
> -	printf("\t-O Use O_DIRECT (not available in 2.4 kernels),\n");
> -	printf("\t-S Use O_SYNC for writes\n");
> -	printf("\t-o add an operation to the list: write=0, read=1,\n");
> -	printf("\t   random write=2, random read=3.\n");
> -	printf("\t   repeat -o to specify multiple ops: -o 0 -o 1 etc.\n");
> -	printf
> -	    ("\t-m shm use ipc shared memory for io buffers instead of malloc\n");
> -	printf("\t-m shmfs mmap a file in /dev/shm for io buffers\n");
> -	printf("\t-n no fsyncs between write stage and read stage\n");
> -	printf("\t-l print io_submit latencies after each stage\n");
> -	printf("\t-L print io completion latencies after each stage\n");
> -	printf("\t-t number of threads to run\n");
> -	printf("\t-u unlink files after completion\n");
> -	printf("\t-v verification of bytes written\n");
> -	printf("\t-x turn off thread stonewalling\n");
> -	printf("\t-h this message\n");
> -	printf
> -	    ("\n\t   the size options (-a -s and -r) allow modifiers -s 400{k,m,g}\n");
> -	printf("\t   translate to 400KB, 400MB and 400GB\n");
> -	printf("version %s\n", PROG_VERSION);
> +	int maxaio;
> +	int stages_i;
> +
> +	page_size_mask = getpagesize() - 1;
> +
> +	SAFE_FILE_SCANF("/proc/sys/fs/aio-max-nr", "%d", &maxaio);
> +	tst_res(TINFO, "Maximum AIO blocks: %d", maxaio);
> +
> +	if (tst_parse_int(str_num_files, &num_files, 1, INT_MAX))
> +		tst_brk(TBROK, "Invalid number of files to generate '%s'", str_num_files);
> +
> +	if (tst_parse_int(str_max_io_submit, &max_io_submit, 0, INT_MAX))
> +		tst_brk(TBROK, "Invalid number of iocbs '%s'", str_max_io_submit);
> +
> +	if (max_io_submit > maxaio)
> +		tst_res(TCONF, "Number of async IO blocks passed the maximum (%d)", maxaio);
> +
> +	if (tst_parse_int(str_num_contexts, &num_contexts, 1, INT_MAX))
> +		tst_brk(TBROK, "Invalid number of contexts per file '%s'", str_num_contexts);
> +
> +	if (tst_parse_filesize(str_context_offset, &context_offset, 1, LLONG_MAX))
> +		tst_brk(TBROK, "Invalid offset between contexts '%s'", str_context_offset);
> +
> +	if (tst_parse_filesize(str_file_size, &file_size, 1, LLONG_MAX))
> +		tst_brk(TBROK, "Invalid file size '%s'", str_file_size);
> +
> +	if (tst_parse_long(str_rec_len, &rec_len, 1, LONG_MAX))
> +		tst_brk(TBROK, "Invalid record size '%s'", str_rec_len);

Shouldn't this be tst_parse_filesize() as well?

> +	if (tst_parse_int(str_depth, &depth, 1, INT_MAX))
> +		tst_brk(TBROK, "Invalid number of pending aio requests '%s'", str_depth);
> +
> +	if (tst_parse_int(str_io_iter, &io_iter, 1, INT_MAX))
> +		tst_brk(TBROK, "Invalid number of I/O per file '%s'", str_io_iter);
> +
> +	if (tst_parse_int(str_iterations, &iterations, 1, INT_MAX))
> +		tst_brk(TBROK, "Invalid number of total ayncs I/O '%s'", str_iterations);
> +
> +	if (tst_parse_int(str_stages, &stages_i, 0, INT_MAX))
> +		tst_brk(TBROK, "Invalid stage number '%s'", str_stages);
> +
> +	if (stages_i) {
> +		stages |= 1 << stages_i;
> +		tst_res(TINFO, "Adding stage %s", stage_name(stages_i));
> +	}
> +
> +	if (tst_parse_int(str_num_threads, &num_threads, 1, INT_MAX))
> +		tst_brk(TBROK, "Invalid number of threads '%s'", str_num_threads);
> +
> +	if (str_o_flag)
> +		o_flag = O_DIRECT;
> +	else
> +		o_flag = O_SYNC;
> +
> +	if (str_use_shm) {
> +		if (!strcmp(str_use_shm, "shm")) {
> +			tst_res(TINFO, "using ipc shm");
> +			use_shm = USE_SHM;
> +		} else if (!strcmp(str_use_shm, "shmfs")) {
> +			tst_res(TINFO, "using /dev/shm for buffers");
> +			use_shm = USE_SHMFS;
> +		} else {
> +			tst_brk(TBROK, "Invalid shm option '%s'", str_use_shm);
> +		}
> +	}
>  }

With the three problems fixed:

- direct instead raw in description
- tst_parse_filesize() for record length
- return value propagation from threads

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
