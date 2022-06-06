Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C854C43334
	for <ltp@archiver.kernel.org>; Mon,  6 Jun 2022 11:20:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 74E363C8CA7
	for <ltp@archiver.kernel.org>; Mon,  6 Jun 2022 13:20:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 761753C0895
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 13:19:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9BAFE2005D4
 for <ltp@lists.linux.it>; Mon,  6 Jun 2022 13:19:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A3EC021A5A;
 Mon,  6 Jun 2022 11:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1654514388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uK7NJVvHx+2pzEUymlMgUT0jv9AEMjxGhTCRYW6eQYk=;
 b=cXTg4W1heeuSMyyAmRcjdJOfiGSsUhQaVuN+2XDyyjKnH+0pEJoye+rocooGw1OrU5S7zI
 kNIhH8w1R+ySWwJ9FoKknJTgJeA94W+xxWKSGFobTpHExHvSLRsB1bTeaXVEu8JjzW3nc4
 BW7VG3m6gRTu+8g6oDM8LT3KstJsx3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1654514388;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uK7NJVvHx+2pzEUymlMgUT0jv9AEMjxGhTCRYW6eQYk=;
 b=IdrwIuJ3Lok09fHovi8DajOClmzUkvsgXlCar+21E2jMxkTg1iwwKOlU425QjkCQ7hCFFD
 V6B6H8IMQL03AwAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 89E2C13A5F;
 Mon,  6 Jun 2022 11:19:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gkcXIdTinWICJwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 06 Jun 2022 11:19:48 +0000
Date: Mon, 6 Jun 2022 13:21:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Yp3jUX/rLNKPtpxx@yuki>
References: <20220301142322.31885-1-andrea.cervesato@suse.de>
 <20220301142322.31885-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220301142322.31885-2-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/2] Rewrite aio-stress test using LTP API
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
> +// SPDX-License-Identifier: GPL-2.0-or-later

Well in this case I guess it's okay to change to GPL-2.0 since the
original copyright is SUSE after all, but keeping it GPL-2.0 is probably
safer since there were (minor) contributions from other companies.

>  /*
>   * Copyright (c) 2004 SuSE, Inc.  All Rights Reserved.

I would add something as:

    Written by: Chris Mason

just to preserve historical context.

> + * Copyright (C) 2021 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
>   *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of version 2 of the GNU General Public License as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it would be useful, but
> - * WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> - *
> - * Further, this software is distributed without any warranty that it is
> - * free of the rightful claim of any third person regarding infringement
> - * or the like.  Any license provided herein, whether implied or
> - * otherwise, applies only to this software file.  Patent licenses, if
> - * any, provided herein do not apply to combinations of this program with
> - * other software, or any other product whatsoever.
> - *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> - *
> - * Contact information: Silicon Graphics, Inc., 1600 Amphitheatre Pkwy,
> - * Mountain View, CA  94043, or:
> - *
> - *
> - * aio-stress
> - *
> - * will open or create each file on the command line, and start a series
> + * Will open or create each file on the command line, and start a series
>   * of aio to it.
>   *
> - * aio is done in a rotating loop.  first file1 gets 8 requests, then
> - * file2, then file3 etc.  As each file finishes writing, it is switched
> - * to reads
> - *
> - * io buffers are aligned in case you want to do raw io
> + * aio is done in a rotating loop. First file1.bin gets 8 requests, then
> + * file2.bin, then file3.bin etc. As each file finishes writing, it is switched
> + * to reads.
>   *
> - * compile with gcc -Wall -laio -lpthread -o aio-stress aio-stress.c
> - *
> - * run aio-stress -h to see the options
> - *
> - * Please mail Chris Mason (mason@suse.com) with bug reports or patches
> + * io buffers are aligned in case you want to do raw io.
>   */
> +
>  #define _FILE_OFFSET_BITS 64
> -#define PROG_VERSION "0.21"
>  #define NEW_GETEVENTS
>  
>  #define _GNU_SOURCE
> +#include "tst_test.h"
> +
> +#ifdef HAVE_LIBAIO
>  #include <stdio.h>
>  #include <errno.h>
>  #include <assert.h>
> @@ -60,12 +38,9 @@
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
> @@ -83,52 +58,52 @@ enum {
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
> +static int iterations = RUN_FOREVER;
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
> @@ -140,7 +115,8 @@ struct io_latency {
>  
>  /* container for a series of operations to a file */
>  struct io_oper {
> -	/* already open file descriptor, valid for whatever operation you want */
> +	/* already open file descriptor, valid for whatever operation you want
> +	 */
>  	int fd;
>  
>  	/* starting byte of the operation */
> @@ -210,7 +186,7 @@ struct io_unit {
>  
>  	struct io_unit *next;
>  
> -	struct timeval io_start_time;	/* time of io_submit */
> +	struct timeval io_start_time; /* time of io_submit */
>  };
>  
>  struct thread_info {
> @@ -255,6 +231,14 @@ struct thread_info {
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
> @@ -262,6 +246,7 @@ static double time_since(struct timeval *start_tv, struct timeval *stop_tv)
>  {
>  	double sec, usec;
>  	double ret;
> +
>  	sec = stop_tv->tv_sec - start_tv->tv_sec;
>  	usec = stop_tv->tv_usec - start_tv->tv_usec;
>  	if (sec > 0 && usec < 0) {
> @@ -280,6 +265,7 @@ static double time_since(struct timeval *start_tv, struct timeval *stop_tv)
>  static double time_since_now(struct timeval *start_tv)
>  {
>  	struct timeval stop_time;
> +
>  	gettimeofday(&stop_time, NULL);
>  	return time_since(start_tv, &stop_time);
>  }
> @@ -292,6 +278,7 @@ static void calc_latency(struct timeval *start_tv, struct timeval *stop_tv,
>  {
>  	double delta;
>  	int i;
> +
>  	delta = time_since(start_tv, stop_tv);
>  	delta = delta * 1000;
>  
> @@ -320,7 +307,6 @@ static void oper_list_add(struct io_oper *oper, struct io_oper **list)
>  	oper->next = *list;
>  	(*list)->prev->next = oper;
>  	(*list)->prev = oper;
> -	return;
>  }
>  
>  static void oper_list_del(struct io_oper *oper, struct io_oper **list)
> @@ -338,11 +324,13 @@ static void oper_list_del(struct io_oper *oper, struct io_oper **list)
>  /* worker func to check error fields in the io unit */
>  static int check_finished_io(struct io_unit *io)
>  {
> +	char out[4 * 1024];
>  	int i;
> -	if (io->res != io->buf_size) {
>  
> +	if (io->res != io->buf_size) {
>  		struct stat s;
> -		fstat(io->io_oper->fd, &s);
> +
> +		SAFE_FSTAT(io->io_oper->fd, &s);
>  
>  		/*
>  		 * If file size is large enough for the read, then this short
> @@ -351,32 +339,30 @@ static int check_finished_io(struct io_unit *io)
>  		if ((io->io_oper->rw == READ || io->io_oper->rw == RREAD) &&
>  		    s.st_size > (io->iocb.u.c.offset + io->res)) {
>  
> -			fprintf(stderr,
> -				"io err %lu (%s) op %d, off %Lu size %d\n",
> -				io->res, strerror(-io->res),
> -				io->iocb.aio_lio_opcode, io->iocb.u.c.offset,
> -				io->buf_size);
> +			tst_res(TINFO, "io err %lu (%s) op %d, off %llu size %d",
> +				io->res, tst_strerrno(-io->res), io->iocb.aio_lio_opcode,
> +				io->iocb.u.c.offset, io->buf_size);
>  			io->io_oper->last_err = io->res;
>  			io->io_oper->num_err++;
>  			return -1;
>  		}
>  	}
> +
>  	if (verify && io->io_oper->rw == READ) {
>  		if (memcmp(io->buf, verify_buf, io->io_oper->reclen)) {
> -			fprintf(stderr,
> -				"verify error, file %s offset %Lu contents (offset:bad:good):\n",
> +			tst_res(TINFO, "verify error, file %s offset %llu contents (offset:bad:good):",
>  				io->io_oper->file_name, io->iocb.u.c.offset);
>  
>  			for (i = 0; i < io->io_oper->reclen; i++) {
>  				if (io->buf[i] != verify_buf[i]) {
> -					fprintf(stderr, "%d:%c:%c ", i,
> +					tst_res(TINFO, "%d:%c:%c ", i,
>  						io->buf[i], verify_buf[i]);
>  				}
>  			}
> -			fprintf(stderr, "\n");
> +			tst_res(TINFO, "%s", out);

You seem to be printing an uninitialized buffer here, weren't you
planning to print into that buffer instead of the tst_res(INFO,) calls?

>  		}
> -
>  	}
> +
>  	return 0;
>  }
>  
> @@ -392,7 +378,7 @@ static int grab_iou(struct io_unit *io, struct io_oper *oper)
>  	return 0;
>  }
>  
> -char *stage_name(int rw)
> +static char *stage_name(int rw)
>  {
>  	switch (rw) {
>  	case WRITE:
> @@ -409,8 +395,7 @@ char *stage_name(int rw)
>  
>  static inline double oper_mb_trans(struct io_oper *oper)
>  {
> -	return ((double)oper->started_ios * (double)oper->reclen) /
> -	    (double)(1024 * 1024);
> +	return ((double)oper->started_ios * (double)oper->reclen) / (double)(1024 * 1024);
>  }
>  
>  static void print_time(struct io_oper *oper)
> @@ -422,38 +407,45 @@ static void print_time(struct io_oper *oper)
>  	runtime = time_since_now(&oper->start_time);
>  	mb = oper_mb_trans(oper);
>  	tput = mb / runtime;
> -	fprintf(stderr, "%s on %s (%.2f MB/s) %.2f MB in %.2fs\n",
> +
> +	tst_res(TINFO, "%s on %s (%.2f MB/s) %.2f MB in %.2fs",
>  		stage_name(oper->rw), oper->file_name, tput, mb, runtime);
>  }
>  
>  static void print_lat(char *str, struct io_latency *lat)
>  {
> +	char out[4 * 1024];
> +	char *ptr = out;
>  	double avg = lat->total_lat / lat->total_io;
>  	int i;
>  	double total_counted = 0;
> -	fprintf(stderr, "%s min %.2f avg %.2f max %.2f\n\t",
> -		str, lat->min, avg, lat->max);
> +
> +	tst_res(TINFO, "%s min %.2f avg %.2f max %.2f", str, lat->min, avg, lat->max);
>  
>  	for (i = 0; i < DEVIATIONS; i++) {
> -		fprintf(stderr, " %.0f < %d", lat->deviations[i],
> -			deviations[i]);
> +		ptr += sprintf(ptr, "%.0f < %d", lat->deviations[i], deviations[i]);
>  		total_counted += lat->deviations[i];
>  	}
> +
>  	if (total_counted && lat->total_io - total_counted)
> -		fprintf(stderr, " < %.0f", lat->total_io - total_counted);
> -	fprintf(stderr, "\n");
> +		ptr += sprintf(ptr, " < %.0f", lat->total_io - total_counted);
> +
> +	tst_res(TINFO, "%s", out);
> +
>  	memset(lat, 0, sizeof(*lat));
>  }
>  
>  static void print_latency(struct thread_info *t)
>  {
>  	struct io_latency *lat = &t->io_submit_latency;
> +
>  	print_lat("latency", lat);
>  }
>  
>  static void print_completion_latency(struct thread_info *t)
>  {
>  	struct io_latency *lat = &t->io_completion_latency;
> +
>  	print_lat("completion latency", lat);
>  }
>  
> @@ -461,8 +453,8 @@ static void print_completion_latency(struct thread_info *t)
>   * updates the fields in the io operation struct that belongs to this
>   * io unit, and make the io unit reusable again
>   */
> -void finish_io(struct thread_info *t, struct io_unit *io, long result,
> -	       struct timeval *tv_now)
> +static void finish_io(struct thread_info *t, struct io_unit *io, long result,
> +		      struct timeval *tv_now)
>  {
>  	struct io_oper *oper = io->io_oper;
>  
> @@ -480,7 +472,7 @@ void finish_io(struct thread_info *t, struct io_unit *io, long result,
>  	}
>  }
>  
> -int read_some_events(struct thread_info *t)
> +static int read_some_events(struct thread_info *t)
>  {
>  	struct io_unit *event_io;
>  	struct io_event *event;
> @@ -493,8 +485,7 @@ int read_some_events(struct thread_info *t)
>  		min_nr = t->num_global_pending;
>  
>  #ifdef NEW_GETEVENTS
> -	nr = io_getevents(t->io_ctx, min_nr, t->num_global_events, t->events,
> -			  NULL);
> +	nr = io_getevents(t->io_ctx, min_nr, t->num_global_events, t->events, NULL);
>  #else
>  	nr = io_getevents(t->io_ctx, t->num_global_events, t->events, NULL);
>  #endif
> @@ -524,7 +515,7 @@ retry:
>  		event_io = t->free_ious;
>  		t->free_ious = t->free_ious->next;
>  		if (grab_iou(event_io, oper)) {
> -			fprintf(stderr, "io unit on free list but not free\n");
> +			tst_res(TINFO, "io unit on free list but not free");
>  			abort();
>  		}
>  		return event_io;
> @@ -533,7 +524,8 @@ retry:
>  	if (nr > 0)
>  		goto retry;
>  	else
> -		fprintf(stderr, "no free ious after read_some_events\n");
> +		tst_res(TINFO, "no free ious after read_some_events");
> +
>  	return NULL;
>  }
>  
> @@ -545,22 +537,22 @@ static int io_oper_wait(struct thread_info *t, struct io_oper *oper)
>  	struct io_event event;
>  	struct io_unit *event_io;
>  
> -	if (oper == NULL) {
> +	if (!oper)
>  		return 0;
> -	}
>  
>  	if (oper->num_pending == 0)
>  		goto done;
>  
> -	/* this func is not speed sensitive, no need to go wild reading
> -	 * more than one event at a time
> -	 */
> +		/* this func is not speed sensitive, no need to go wild reading
> +		 * more than one event at a time
> +		 */
>  #ifdef NEW_GETEVENTS
>  	while (io_getevents(t->io_ctx, 1, 1, &event, NULL) > 0) {
>  #else
>  	while (io_getevents(t->io_ctx, 1, &event, NULL) > 0) {
>  #endif
>  		struct timeval tv_now;
> +
>  		event_io = (struct io_unit *)((unsigned long)event.obj);
>  
>  		gettimeofday(&tv_now, NULL);
> @@ -570,14 +562,13 @@ static int io_oper_wait(struct thread_info *t, struct io_oper *oper)
>  			break;
>  	}
>  done:
> -	if (oper->num_err) {
> -		fprintf(stderr, "%u errors on oper, last %u\n",
> -			oper->num_err, oper->last_err);
> -	}
> +	if (oper->num_err)
> +		tst_res(TINFO, "%u errors on oper, last %u", oper->num_err, oper->last_err);
> +
>  	return 0;
>  }
>  
> -off_t random_byte_offset(struct io_oper * oper)
> +static off_t random_byte_offset(struct io_oper *oper)
>  {
>  	off_t num;
>  	off_t rand_byte = oper->start;
> @@ -603,9 +594,9 @@ off_t random_byte_offset(struct io_oper * oper)
>  	num = (num + page_size_mask) & ~page_size_mask;
>  	rand_byte += num;
>  
> -	if (rand_byte + oper->reclen > oper->end) {
> +	if (rand_byte + oper->reclen > oper->end)
>  		rand_byte -= oper->reclen;
> -	}
> +
>  	return rand_byte;
>  }
>  
> @@ -623,33 +614,27 @@ static struct io_unit *build_iocb(struct thread_info *t, struct io_oper *oper)
>  	off_t rand_byte;
>  
>  	io = find_iou(t, oper);
> -	if (!io) {
> -		fprintf(stderr, "unable to find io unit\n");
> -		return NULL;
> -	}
> +	if (!io)
> +		tst_brk(TBROK, "unable to find io unit");
>  
>  	switch (oper->rw) {
>  	case WRITE:
> -		io_prep_pwrite(&io->iocb, oper->fd, io->buf, oper->reclen,
> -			       oper->last_offset);
> +		io_prep_pwrite(&io->iocb, oper->fd, io->buf, oper->reclen, oper->last_offset);
>  		oper->last_offset += oper->reclen;
>  		break;
>  	case READ:
> -		io_prep_pread(&io->iocb, oper->fd, io->buf, oper->reclen,
> -			      oper->last_offset);
> +		io_prep_pread(&io->iocb, oper->fd, io->buf, oper->reclen, oper->last_offset);
>  		oper->last_offset += oper->reclen;
>  		break;
>  	case RREAD:
>  		rand_byte = random_byte_offset(oper);
>  		oper->last_offset = rand_byte;
> -		io_prep_pread(&io->iocb, oper->fd, io->buf, oper->reclen,
> -			      rand_byte);
> +		io_prep_pread(&io->iocb, oper->fd, io->buf, oper->reclen, rand_byte);
>  		break;
>  	case RWRITE:
>  		rand_byte = random_byte_offset(oper);
>  		oper->last_offset = rand_byte;
> -		io_prep_pwrite(&io->iocb, oper->fd, io->buf, oper->reclen,
> -			       rand_byte);
> +		io_prep_pwrite(&io->iocb, oper->fd, io->buf, oper->reclen, rand_byte);
>  
>  		break;
>  	}
> @@ -667,10 +652,10 @@ static int finish_oper(struct thread_info *t, struct io_oper *oper)
>  
>  	io_oper_wait(t, oper);
>  	last_err = oper->last_err;
> -	if (oper->num_pending > 0) {
> -		fprintf(stderr, "oper num_pending is %d\n", oper->num_pending);
> -	}
> -	close(oper->fd);
> +	if (oper->num_pending > 0)
> +		tst_res(TINFO, "oper num_pending is %d", oper->num_pending);
> +
> +	SAFE_CLOSE(oper->fd);
>  	free(oper);
>  	return last_err;
>  }
> @@ -680,16 +665,11 @@ static int finish_oper(struct thread_info *t, struct io_oper *oper)
>   * null on error
>   */
>  static struct io_oper *create_oper(int fd, int rw, off_t start, off_t end,
> -				   int reclen, int depth, int iter,
> -				   char *file_name)
> +				   int reclen, int depth, char *file_name)
>  {
>  	struct io_oper *oper;
>  
> -	oper = malloc(sizeof(*oper));
> -	if (!oper) {
> -		fprintf(stderr, "unable to allocate io oper\n");
> -		return NULL;
> -	}
> +	oper = SAFE_MALLOC(sizeof(*oper));
>  	memset(oper, 0, sizeof(*oper));
>  
>  	oper->depth = depth;
> @@ -709,8 +689,8 @@ static struct io_oper *create_oper(int fd, int rw, off_t start, off_t end,
>   * does setup on num_ios worth of iocbs, but does not actually
>   * start any io
>   */
> -int build_oper(struct thread_info *t, struct io_oper *oper, int num_ios,
> -	       struct iocb **my_iocbs)
> +static int build_oper(struct thread_info *t, struct io_oper *oper, int num_ios,
> +		      struct iocb **my_iocbs)
>  {
>  	int i;
>  	struct io_unit *io;
> @@ -726,9 +706,9 @@ int build_oper(struct thread_info *t, struct io_oper *oper, int num_ios,
>  
>  	for (i = 0; i < num_ios; i++) {
>  		io = build_iocb(t, oper);
> -		if (!io) {
> +		if (!io)
>  			return -1;
> -		}
> +
>  		my_iocbs[i] = &io->iocb;
>  	}
>  	return num_ios;
> @@ -738,21 +718,21 @@ int build_oper(struct thread_info *t, struct io_oper *oper, int num_ios,
>   * runs through the iocbs in the array provided and updates
>   * counters in the associated oper struct
>   */
> -static void update_iou_counters(struct iocb **my_iocbs, int nr,
> -				struct timeval *tv_now)
> +static void update_iou_counters(struct iocb **my_iocbs, int nr, struct timeval *tv_now)
>  {
>  	struct io_unit *io;
>  	int i;
> +
>  	for (i = 0; i < nr; i++) {
>  		io = (struct io_unit *)(my_iocbs[i]);
>  		io->io_oper->num_pending++;
>  		io->io_oper->started_ios++;
> -		io->io_start_time = *tv_now;	/* set time of io_submit */
> +		io->io_start_time = *tv_now; /* set time of io_submit */
>  	}
>  }
>  
>  /* starts some io for a given file, returns zero if all went well */
> -int run_built(struct thread_info *t, int num_ios, struct iocb **my_iocbs)
> +static int run_built(struct thread_info *t, int num_ios, struct iocb **my_iocbs)
>  {
>  	int ret;
>  	struct timeval start_time;
> @@ -778,17 +758,17 @@ resubmit:
>  		 */
>  		if (ret > 0 || ret == -EAGAIN) {
>  			int old_ret = ret;
> -			if ((ret = read_some_events(t) > 0)) {
> +
> +			ret = read_some_events(t);
> +			if (ret > 0) {
>  				goto resubmit;
>  			} else {
> -				fprintf(stderr, "ret was %d and now is %d\n",
> -					ret, old_ret);
> +				tst_res(TINFO, "ret was %d and now is %d", ret, old_ret);
>  				abort();
>  			}
>  		}
>  
> -		fprintf(stderr, "ret %d (%s) on io_submit\n", ret,
> -			strerror(-ret));
> +		tst_res(TINFO, "ret %d (%s) on io_submit", ret, tst_strerrno(-ret));
>  		return -1;
>  	}
>  	update_iou_counters(my_iocbs, ret, &stop_time);
> @@ -803,6 +783,7 @@ resubmit:
>  static int restart_oper(struct io_oper *oper)
>  {
>  	int new_rw = 0;
> +
>  	if (oper->last_err)
>  		return 0;
>  
> @@ -811,12 +792,18 @@ static int restart_oper(struct io_oper *oper)
>  	case WRITE:
>  		if (stages & (1 << READ))
>  			new_rw = READ;
> +		break;
>  	case READ:
>  		if (!new_rw && stages & (1 << RWRITE))
>  			new_rw = RWRITE;
> +		break;
>  	case RWRITE:
>  		if (!new_rw && stages & (1 << RREAD))
>  			new_rw = RREAD;
> +		break;
> +	default:
> +		/* fallthrough */
> +		break;

This looks wrong, there is a comment just before the switch that it's
supposed to fall through and if you looks closely at the code it checks
if the new_rw has been set. Looks like mindless attempt to silence
warnings actually broke the code.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
