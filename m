Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2930EC43217
	for <ltp@archiver.kernel.org>; Tue,  8 Nov 2022 11:20:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B838D3CD89A
	for <ltp@archiver.kernel.org>; Tue,  8 Nov 2022 12:20:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70D233C9354
 for <ltp@lists.linux.it>; Tue,  8 Nov 2022 12:19:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id CD56860055D
 for <ltp@lists.linux.it>; Tue,  8 Nov 2022 12:19:56 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id B46771F88E;
 Tue,  8 Nov 2022 11:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667906395;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n1E7GVGKbS7y/t2LRxTJX52NrJCJxUweMs1GuxxAoUw=;
 b=ulr19jqBv9opNAGcyJaRoxihAI6RobXZeSc2MPVxAmatQKEGhawC3m1GR+AJs7+QFWGaUi
 Fa9SVt5kzunok6dHVkaN/oVMPE9TEdBM1Gkvii7FcXktfZErQemKVjaed5VHGl9cYYNZv1
 24n8oE7KpIQ96QomUOGLxSf3e9QyRwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667906395;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n1E7GVGKbS7y/t2LRxTJX52NrJCJxUweMs1GuxxAoUw=;
 b=btP2mQjqT3/A1ve9iNLcEVY+MOqsw30BQCTTylDar7QpOK7w/msrPqBRoIk9gkhOEFk9wF
 gj72Nn4LSprevSDA==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4452F2C141;
 Tue,  8 Nov 2022 11:19:54 +0000 (UTC)
References: <20221027215808.4126148-1-edliaw@google.com>
 <20221027215808.4126148-2-edliaw@google.com> <8735atww9l.fsf@suse.de>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Edward Liaw <edliaw@google.com>
Date: Tue, 08 Nov 2022 11:19:38 +0000
Organization: Linux Private Site
In-reply-to: <8735atww9l.fsf@suse.de>
Message-ID: <87y1slvgkm.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/1] mmapstress01: refactor to tst_test
 framework
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
Reply-To: rpalethorpe@suse.de
Cc: kernel-team@android.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hello,
>
> Edward Liaw via ltp <ltp@lists.linux.it> writes:
>
>> Use ltp framework and apply make check corrections.  Reorder functions
>> and variables.  Use safe macros.
>> Drop leavefile option.
>> Build tests with FILE_OFFSET_BITS=64 instead of doing LARGE_FILE checks
>> to switch between 32 and 64 bit types and syscalls.
>> Define fsize bounds by file offset bits.
>> Move sighandler to setup and remove sig blocks.
>> Add option to specify pattern.
>> Set default nprocs to ncpus with min of 1 and max of 20.
>>
>> Signed-off-by: Edward Liaw <edliaw@google.com>
>
> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
>
> Will merge this today if the CI is happy and nobody comments.

Merged, thanks!

>
>> ---
>>  testcases/kernel/mem/mmapstress/Makefile      |   2 +
>>  .../kernel/mem/mmapstress/mmapstress01.c      | 886 +++++-------------
>>  2 files changed, 261 insertions(+), 627 deletions(-)
>>
>> diff --git a/testcases/kernel/mem/mmapstress/Makefile b/testcases/kernel/mem/mmapstress/Makefile
>> index 744f099d8..b30bd34b8 100644
>> --- a/testcases/kernel/mem/mmapstress/Makefile
>> +++ b/testcases/kernel/mem/mmapstress/Makefile
>> @@ -5,3 +5,5 @@ top_srcdir              ?= ../../../..
>>  
>>  include $(top_srcdir)/include/mk/testcases.mk
>>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> +
>> +mmapstress01: CFLAGS += -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE
>> diff --git a/testcases/kernel/mem/mmapstress/mmapstress01.c b/testcases/kernel/mem/mmapstress/mmapstress01.c
>> index f425c223d..ac1b77387 100644
>> --- a/testcases/kernel/mem/mmapstress/mmapstress01.c
>> +++ b/testcases/kernel/mem/mmapstress/mmapstress01.c
>> @@ -1,23 +1,24 @@
>> -/* IBM Corporation */
>> -/* 01/02/2003	Port to LTP avenkat@us.ibm.com */
>> -/* 06/30/2001	Port to Linux	nsharoff@us.ibm.com */
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>  /*
>> - *   Copyright (c) International Business Machines  Corp., 2003
>> - *
>> - *
>> - *   This program is free software;  you can redistribute it and/or modify
>> - *   it under the terms of the GNU General Public License as published by
>> - *   the Free Software Foundation; either version 2 of the License, or
>> - *   (at your option) any later version.
>> - *
>> - *   This program is distributed in the hope that it will be useful,
>> - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
>> - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
>> - *   the GNU General Public License for more details.
>> + * Copyright (c) International Business Machines  Corp., 2003
>> + * 01/02/2003	Port to LTP avenkat@us.ibm.com
>> + * 06/30/2001	Port to Linux	nsharoff@us.ibm.com
>> + * 10/03/2022	Refactor to LTP framework	edliaw@google.com
>> + */
>> +/*\
>> + * [Description]
>> + * This test stresses mmaps, without dealing with fragments or anything!
>> + * It forks a specified number of children,
>> + * all of whom mmap the same file, make a given number of accesses
>> + * to random pages in the map (reading & writing and comparing data).
>> + * Then the child exits and the parent forks another to take its place.
>> + * Each time a child is forked, it stats the file and maps the full
>> + * length of the file.
>>   *
>> - *   You should have received a copy of the GNU General Public License
>> - *   along with this program;  if not, write to the Free Software
>> - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
>> + * This program continues to run until it either receives a SIGINT,
>> + * or times out (if a timeout value is specified).  When either of
>> + * these things happens, it cleans up its kids, then checks the
>> + * file to make sure it has the correct data.
>>   */
>>  
>>  #define _GNU_SOURCE 1
>> @@ -32,517 +33,159 @@
>>  #include <errno.h>
>>  #include <sys/types.h>
>>  #include <limits.h>
>> -/*****  LTP Port        *****/
>> -#include "test.h"
>> -#define FAILED 0
>> -#define PASSED 1
>> -
>> -int local_flag = PASSED;
>> -char *TCID = "mmapstress01";	//tmnoextend
>> -FILE *temp;
>> -int TST_TOTAL = 1;
>> -
>> -int anyfail();
>> -void ok_exit();
>> -/*****  **      **      *****/
>> -
>> -/*
>> - *  This test stresses mmaps, without dealing with fragments or anything!
>> - *  It forks a specified number of children,
>> - *  all of whom mmap the same file, make a given number of accesses
>> - *  to random pages in the map (reading & writing and comparing data).
>> - *  Then the child exits and the parent forks another to take its place.
>> - *  Each time a child is forked, it stats the file and maps the full
>> - *  length of the file.
>> - *
>> - *  This program continues to run until it either receives a SIGINT,
>> - *  or times out (if a timeout value is specified).  When either of
>> - *  these things happens, it cleans up its kids, then checks the
>> - *  file to make sure it has the correct data.
>> - *
>> - *  usage:
>> - *	tmnoextend -p nprocs [-t minutes -f filesize -S sparseoffset
>> - *			      -r -o -m -l -d]
>> - *  where:
>> - *	-p nprocs	- specifies the number of mapping children
>> - *			  to create.  (nprocs + 1 children actually
>> - *			  get created, since one is the writer child)
>> - *	-t minutes	- specifies minutes to run.  If not specified,
>> - *			  default is to run forever until a SIGINT
>> - *			  is received.
>> - *	-f filesize	- initial filesize (defaults to FILESIZE)
>> - *	-S sparseoffset - when non-zero, causes a sparse area to
>> - *			  be left before the data, meaning that the
>> - *			  actual initial file size is sparseoffset +
>> - *			  filesize.  Useful for testing large files.
>> - *			  (default is 0).
>> - *	-r		- randomize number of pages map children check.
>> - *			  (random % MAXLOOPS).  If not specified, each
>> - *			  child checks MAXLOOPS pages.
>> - *	-o		- randomize offset of file to map. (default is 0)
>> - *	-m		- do random msync/fsyncs as well
>> - *	-l		- if set, the output file is not removed on
>> - *			  program exit.
>> - *	-d		- enable debug output
>> - *
>> - *  Compile with -DLARGE_FILE to enable file sizes > 2 GB.
>> - */
>> -
>> +#include <float.h>
>> +#include "tst_test.h"
>> +
>> +#if _FILE_OFFSET_BITS == 64
>> +# define FSIZE_MIN LONG_MIN
>> +# define FSIZE_MAX LONG_MAX
>> +#else
>> +# define FSIZE_MIN INT_MIN
>> +# define FSIZE_MAX INT_MAX
>> +#endif
>>  #define MAXLOOPS	500	/* max pages for map children to write */
>> -#define	FILESIZE	4096	/* initial filesize set up by parent */
>> +#define TEST_FILE	"mmapstress01.out"
>>  
>>  #ifdef roundup
>>  #undef roundup
>>  #endif
>>  #define roundup(x, y)	((((x)+((y)-1))/(y))*(y))
>>  
>> -extern time_t time(time_t *);
>> -extern char *ctime(const time_t *);
>> -extern void *malloc(size_t);
>> -extern long lrand48(void);
>> -extern void srand(unsigned);
>> -extern void srand48(long);
>> -extern int rand(void);
>> -extern int atoi(const char *);
>> -
>> -char *usage =
>> -    "-p nprocs [-t minutes -f filesize -S sparseoffset -r -o -m -l -d]";
>> -
>> -typedef unsigned char uchar_t;
>> -#define SIZE_MAX UINT_MAX
>> -
>> -unsigned int initrand(void);
>> -void finish(int sig);
>> -void child_mapper(char *file, unsigned procno, unsigned nprocs);
>> -int fileokay(char *file, uchar_t * expbuf);
>> -int finished = 0;
>> -int leavefile = 0;
>> -
>> -int debug = 0;
>> -#ifdef LARGE_FILE
>> -off64_t filesize = FILESIZE;
>> -off64_t sparseoffset = 0;
>> -#else /* LARGE_FILE */
>> -off_t filesize = FILESIZE;
>> -off_t sparseoffset = 0;
>> -#endif /* LARGE_FILE */
>> -unsigned randloops = 0;
>> -unsigned dosync = 0;
>> -unsigned do_offset = 0;
>> -unsigned pattern = 0;
>> -
>> -int main(int argc, char *argv[])
>> +static unsigned int initrand(void);
>> +static void sighandler(int);
>> +
>> +static char *debug;
>> +static char *do_sync;
>> +static char *do_offset;
>> +static char *opt_filesize;
>> +static char *opt_nprocs;
>> +static char *opt_pattern;
>> +static char *opt_sparseoffset;
>> +static char *randloops;
>> +
>> +static int fd;
>> +static volatile int finished;
>> +static int nprocs;
>> +static long long filesize = 4096;
>> +static long long sparseoffset;
>> +static size_t pagesize;
>> +static int pattern;
>> +
>> +static struct tst_option options[] = {
>> +	{"d", &debug, "Enable debug output"},
>> +	{"f:", &opt_filesize, "Initial filesize (default 4096)"},
>> +	{"m", &do_sync, "Do random msync/fsyncs as well"},
>> +	{"o", &do_offset, "Randomize the offset of file to map"},
>> +	{"p:", &opt_nprocs,
>> +	 "Number of mapping children to create (default 1 < ncpus < 20)"},
>> +	{"P:", &opt_pattern,
>> +	 "Use a fixed pattern (default random)"},
>> +	{"r", &randloops,
>> +	 "Randomize number of pages map children check (random % 500), "
>> +	 "otherwise each child checks 500 pages"},
>> +	{"S:", &opt_sparseoffset,
>> +	 "When non-zero, causes the sparse area to be left before the data, "
>> +	 "so that the actual initial filesize is sparseoffset + filesize "
>> +	 "(default 0)"},
>> +	{},
>> +};
>> +
>> +static void setup(void)
>>  {
>> -	char *progname;
>> -	int fd;
>> -	int c;
>> -	extern char *optarg;
>> -	unsigned nprocs = 0;
>> -	unsigned procno;
>> -	pid_t *pidarray = NULL;
>> -	pid_t pid;
>> -	uchar_t *buf = NULL;
>> -	unsigned int seed;
>> -	int pagesize = sysconf(_SC_PAGE_SIZE);
>> -	float alarmtime = 0;
>>  	struct sigaction sa;
>> -	unsigned i;
>> -	int write_cnt;
>> -	uchar_t data;
>> -	int no_prob = 0;
>> -	int wait_stat;
>> -	time_t t;
>> -#ifdef LARGE_FILE
>> -	off64_t bytes_left;
>> -#else /* LARGE_FILE */
>> -	off_t bytes_left;
>> -#endif /* LARGE_FILE */
>> -	const char *filename = "mmapstress01.out";
>> -
>> -	progname = *argv;
>> -	tst_tmpdir();
>> -	if (argc < 2) {
>> -		tst_brkm(TBROK, NULL, "usage: %s %s", progname, usage);
>> -	}
>> -
>> -	while ((c = getopt(argc, argv, "S:omdlrf:p:t:")) != -1) {
>> -		switch (c) {
>> -		case 'd':
>> -			debug = 1;
>> -			break;
>> -		case 't':
>> -			alarmtime = atof(optarg) * 60;
>> -			break;
>> -		case 'p':
>> -			nprocs = atoi(optarg);
>> -			break;
>> -		case 'l':
>> -			leavefile = 1;
>> -			break;
>> -		case 'f':
>> -#ifdef LARGE_FILE
>> -			filesize = atoll(optarg);
>> -#else /* LARGE_FILE */
>> -			filesize = atoi(optarg);
>> -#endif /* LARGE_FILE */
>> -			if (filesize < 0) {
>> -				(void)fprintf(stderr, "error: negative "
>> -					      "filesize\n");
>> -				anyfail();
>> -			}
>> -			break;
>> -		case 'r':
>> -			randloops = 1;
>> -			break;
>> -		case 'm':
>> -			dosync = 1;
>> -			break;
>> -		case 'o':
>> -			do_offset = 1;
>> -			break;
>> -		case 'S':
>> -#ifdef LARGE_FILE
>> -			sparseoffset = atoll(optarg);
>> -#else /* LARGE_FILE */
>> -			sparseoffset = atoi(optarg);
>> -#endif /* LARGE_FILE */
>> -			if (sparseoffset % pagesize != 0) {
>> -				fprintf(stderr,
>> -					"sparseoffset must be pagesize multiple\n");
>> -				anyfail();
>> -			}
>> -			break;
>> -		default:
>> -			(void)fprintf(stderr, "usage: %s %s\n", progname,
>> -				      usage);
>> -			tst_exit();
>> -		}
>> -	}
>> -
>> -	/* nprocs is >= 0 since it's unsigned */
>> -	if (nprocs > 255) {
>> -		(void)fprintf(stderr, "invalid nprocs %d - (range 0-255)\n",
>> -			      nprocs);
>> -		anyfail();
>> -	}
>> -
>> -	(void)time(&t);
>> -
>> -	seed = initrand();
>> -	pattern = seed & 0xff;
>> -
>> -	if (debug) {
>> -#ifdef LARGE_FILE
>> -		(void)printf("creating file <%s> with %Ld bytes, pattern %d\n",
>> -			     filename, filesize, pattern);
>> -#else /* LARGE_FILE */
>> -		(void)printf("creating file <%s> with %ld bytes, pattern %d\n",
>> -			     filename, filesize, pattern);
>> -#endif /* LARGE_FILE */
>> -		if (alarmtime)
>> -			(void)printf("running for %f minutes\n",
>> -				     alarmtime / 60);
>> -		else
>> -			(void)printf("running with no time limit\n");
>> -	}
>>  
>> -	/*
>> -	 *  Plan for death by signal.  User may have specified
>> -	 *  a time limit, in which set an alarm and catch SIGALRM.
>> -	 *  Also catch and cleanup with SIGINT.
>> -	 */
>> -	sa.sa_handler = finish;
>> +	sa.sa_handler = sighandler;
>>  	sa.sa_flags = 0;
>> -	if (sigemptyset(&sa.sa_mask)) {
>> -		perror("sigemptyset error");
>> -		goto cleanup;
>> -	}
>> -
>> -	if (sigaction(SIGINT, &sa, 0) == -1) {
>> -		perror("sigaction error SIGINT");
>> -		goto cleanup;
>> -	}
>> -	if (sigaction(SIGQUIT, &sa, 0) == -1) {
>> -		perror("sigaction error SIGQUIT");
>> -		goto cleanup;
>> -	}
>> -	if (sigaction(SIGTERM, &sa, 0) == -1) {
>> -		perror("sigaction error SIGTERM");
>> -		goto cleanup;
>> -	}
>> -
>> -	if (alarmtime) {
>> -		if (sigaction(SIGALRM, &sa, 0) == -1) {
>> -			perror("sigaction error");
>> -			goto cleanup;
>> -		}
>> -		(void)alarm(alarmtime);
>> -	}
>> -#ifdef LARGE_FILE
>> -	if ((fd = open64(filename, O_CREAT | O_TRUNC | O_RDWR, 0664)) == -1) {
>> -#else /* LARGE_FILE */
>> -	if ((fd = open(filename, O_CREAT | O_TRUNC | O_RDWR, 0664)) == -1) {
>> -#endif /* LARGE_FILE */
>> -		perror("open error");
>> -		anyfail();
>> -	}
>> -
>> -	if ((buf = malloc(pagesize)) == NULL
>> -	    || (pidarray = malloc(nprocs * sizeof(pid_t))) == NULL) {
>> -		perror("malloc error");
>> -		anyfail();
>> -	}
>> -
>> -	for (i = 0; i < nprocs; i++)
>> -		*(pidarray + i) = 0;
>> -
>> -	for (i = 0, data = 0; i < pagesize; i++) {
>> -		*(buf + i) = (data + pattern) & 0xff;
>> -		if (++data == nprocs)
>> -			data = 0;
>> -	}
>> -#ifdef LARGE_FILE
>> -	if (lseek64(fd, sparseoffset, SEEK_SET) < 0) {
>> -#else /* LARGE_FILE */
>> -	if (lseek(fd, sparseoffset, SEEK_SET) < 0) {
>> -#endif /* LARGE_FILE */
>> -		perror("lseek");
>> -		anyfail();
>> -	}
>> -	for (bytes_left = filesize; bytes_left; bytes_left -= c) {
>> -		write_cnt = MIN(pagesize, (int)bytes_left);
>> -		if ((c = write(fd, buf, write_cnt)) != write_cnt) {
>> -			if (c == -1) {
>> -				perror("write error");
>> -			} else {
>> -				(void)fprintf(stderr, "write: wrote %d of %d "
>> -					      "bytes\n", c, write_cnt);
>> -			}
>> -			(void)close(fd);
>> -			(void)unlink(filename);
>> -			anyfail();
>> -		}
>> -	}
>> -
>> -	(void)close(fd);
>> -
>> -	/*
>> -	 *  Fork off mmap children.
>> -	 */
>> -	for (procno = 0; procno < nprocs; procno++) {
>> -		switch (pid = fork()) {
>> -
>> -		case -1:
>> -			perror("fork error");
>> -			goto cleanup;
>> -
>> -		case 0:
>> -			child_mapper(filename, procno, nprocs);
>> -			exit(0);
>> -
>> -		default:
>> -			pidarray[procno] = pid;
>> -		}
>> -	}
>> -
>> -	/*
>> -	 *  Now wait for children and refork them as needed.
>> -	 */
>> -
>> -	while (!finished) {
>> -		pid = wait(&wait_stat);
>> -		/*
>> -		 *  Block signals while processing child exit.
>> -		 */
>> -
>> -		if (sighold(SIGALRM) || sighold(SIGINT)) {
>> -			perror("sighold error");
>> -			goto cleanup;
>> -		}
>> -
>> -		if (pid != -1) {
>> -			/*
>> -			 *  Check exit status, then refork with the
>> -			 *  appropriate procno.
>> -			 */
>> -			if (!WIFEXITED(wait_stat)
>> -			    || WEXITSTATUS(wait_stat) != 0) {
>> -				(void)fprintf(stderr, "child exit with err "
>> -					      "<x%x>\n", wait_stat);
>> -				goto cleanup;
>> -			}
>> -			for (i = 0; i < nprocs; i++)
>> -				if (pid == pidarray[i])
>> -					break;
>> -			if (i == nprocs) {
>> -				(void)fprintf(stderr, "unknown child pid %d, "
>> -					      "<x%x>\n", pid, wait_stat);
>> -				goto cleanup;
>> -			}
>> -
>> -			if ((pid = fork()) == -1) {
>> -				perror("fork error");
>> -				pidarray[i] = 0;
>> -				goto cleanup;
>> -			} else if (pid == 0) {	/* child */
>> -				child_mapper(filename, i, nprocs);
>> -				exit(0);
>> -			} else
>> -				pidarray[i] = pid;
>> -		} else {
>> -			/*
>> -			 *  wait returned an error.  If EINTR, then
>> -			 *  normal finish, else it's an unexpected
>> -			 *  error...
>> -			 */
>> -			if (errno != EINTR || !finished) {
>> -				perror("unexpected wait error");
>> -				goto cleanup;
>> -			}
>> -		}
>> -		if (sigrelse(SIGALRM) || sigrelse(SIGINT)) {
>> -			perror("sigrelse error");
>> -			goto cleanup;
>> -		}
>> -	}
>> -
>> -	/*
>> -	 *  Finished!  Check the file for sanity, then kill all
>> -	 *  the children and done!.
>> -	 */
>> -
>> -	if (sighold(SIGALRM)) {
>> -		perror("sighold error");
>> -		goto cleanup;
>> -	}
>> -	(void)alarm(0);
>> -	no_prob = 1;
>> -
>> -cleanup:
>> -	for (i = 0; i < nprocs; i++)
>> -		(void)kill(pidarray[i], SIGKILL);
>> -
>> -	while (wait(&wait_stat) != -1 || errno != ECHILD)
>> -		continue;
>> -
>> -	if (no_prob) {		/* only check file if no errors */
>> -		if (!fileokay(filename, buf)) {
>> -			(void)fprintf(stderr, "file data incorrect!\n");
>> -			(void)printf("  leaving file <%s>\n", filename);
>> -			/***** LTP Port *****/
>> -			local_flag = FAILED;
>> -			anyfail();
>> -			/*****	**	*****/
>> -		} else {
>> -			(void)printf("file data okay\n");
>> -			if (!leavefile)
>> -				(void)unlink(filename);
>> -		}
>> -	} else
>> -		(void)printf("  leaving file <%s>\n", filename);
>> +	SAFE_SIGEMPTYSET(&sa.sa_mask);
>> +	SAFE_SIGACTION(SIGINT, &sa, 0);
>> +	SAFE_SIGACTION(SIGQUIT, &sa, 0);
>> +	SAFE_SIGACTION(SIGTERM, &sa, 0);
>> +	SAFE_SIGACTION(SIGALRM, &sa, 0);
>> +
>> +	pagesize = sysconf(_SC_PAGE_SIZE);
>> +
>> +	if (tst_parse_filesize(opt_filesize, &filesize, 0, FSIZE_MAX))
>> +		tst_brk(TBROK, "invalid initial filesize '%s'", opt_filesize);
>> +
>> +	if (tst_parse_filesize(opt_sparseoffset, &sparseoffset, FSIZE_MIN, FSIZE_MAX))
>> +		tst_brk(TBROK, "invalid sparse offset '%s'", opt_sparseoffset);
>> +	if (sparseoffset % pagesize != 0)
>> +		tst_brk(TBROK, "sparseoffset must be pagesize multiple");
>> +
>> +	if (tst_parse_int(opt_nprocs, &nprocs, 0, 255))
>> +		tst_brk(TBROK, "invalid number of mapping children '%s'",
>> +			opt_nprocs);
>> +	if (!opt_nprocs)
>> +		nprocs = MAX(MIN(tst_ncpus() - 1L, 20L), 1L);
>> +
>> +	if (tst_parse_int(opt_pattern, &pattern, 0, 255))
>> +		tst_brk(TBROK, "invalid pattern '%s'", opt_pattern);
>> +	if (!opt_pattern)
>> +		pattern = initrand() & 0xff;
>> +
>> +	tst_res(TINFO, "creating file <%s> with %lld bytes, pattern %d",
>> +		TEST_FILE, filesize, pattern);
>> +}
>>  
>> -	(void)time(&t);
>> -	//(void)printf("%s: Finished %s", argv[0], ctime(&t)); LTP Port
>> -	ok_exit();
>> -	tst_exit();
>> +static void cleanup(void)
>> +{
>> +	if (fd > 0)
>> +		SAFE_CLOSE(fd);
>>  }
>>  
>>  /*
>> - *  Child process that reads/writes map.  The child stats the file
>> - *  to determine the size, maps the size of the file, then reads/writes
>> - *  its own locations on random pages of the map (its locations being
>> - *  determined based on nprocs & procno).  After a specific number of
>> - *  iterations, it exits.
>> + * Child process that reads/writes map.  The child stats the file
>> + * to determine the size, maps the size of the file, then reads/writes
>> + * its own locations on random pages of the map (its locations being
>> + * determined based on nprocs & procno).  After a specific number of
>> + * iterations, it exits.
>>   */
>> -void child_mapper(char *file, unsigned procno, unsigned nprocs)
>> +static void child_mapper(char *file, unsigned int procno, unsigned int nprocs)
>>  {
>> -#ifdef LARGE_FILE
>> -	struct stat64 statbuf;
>> -	off64_t filesize;
>> -	off64_t offset;
>> -#else /* LARGE_FILE */
>>  	struct stat statbuf;
>>  	off_t filesize;
>>  	off_t offset;
>> -#endif /* LARGE_FILE */
>>  	size_t validsize;
>>  	size_t mapsize;
>>  	char *maddr = NULL, *paddr;
>> -	int fd;
>> -	size_t pagesize = sysconf(_SC_PAGE_SIZE);
>> -	unsigned randpage;
>> +	unsigned int randpage;
>>  	unsigned int seed;
>> -	unsigned loopcnt;
>> -	unsigned nloops;
>> -	unsigned mappages;
>> -	unsigned i;
>> -
>> -	seed = initrand();	/* initialize random seed */
>> -
>> -#ifdef LARGE_FILE
>> -	if (stat64(file, &statbuf) == -1) {
>> -#else /* LARGE_FILE */
>> -	if (stat(file, &statbuf) == -1) {
>> -#endif /* LARGE_FILE */
>> -		perror("stat error");
>> -		anyfail();
>> -	}
>> +	unsigned int loopcnt;
>> +	unsigned int nloops;
>> +	unsigned int mappages;
>> +	unsigned int i;
>> +
>> +	seed = initrand();
>> +
>> +	SAFE_STAT(file, &statbuf);
>>  	filesize = statbuf.st_size;
>>  
>> -#ifdef LARGE_FILE
>> -	if ((fd = open64(file, O_RDWR)) == -1) {
>> -#else /* LARGE_FILE */
>> -	if ((fd = open(file, O_RDWR)) == -1) {
>> -#endif /* LARGE_FILE */
>> -		perror("open error");
>> -		anyfail();
>> -	}
>> +	fd = SAFE_OPEN(file, O_RDWR);
>>  
>> -	if (statbuf.st_size - sparseoffset > SIZE_MAX) {
>> -		fprintf(stderr, "size_t overflow when setting up map\n");
>> -		anyfail();
>> -	}
>> +	if (statbuf.st_size - sparseoffset > UINT_MAX)
>> +		tst_brk(TBROK, "size_t overflow when setting up map");
>>  	mapsize = (size_t) (statbuf.st_size - sparseoffset);
>>  	mappages = roundup(mapsize, pagesize) / pagesize;
>>  	offset = sparseoffset;
>>  	if (do_offset) {
>>  		int pageoffset = lrand48() % mappages;
>>  		int byteoffset = pageoffset * pagesize;
>> +
>>  		offset += byteoffset;
>>  		mapsize -= byteoffset;
>>  		mappages -= pageoffset;
>>  	}
>>  	nloops = (randloops) ? (lrand48() % MAXLOOPS) : MAXLOOPS;
>>  
>> -	if (debug) {
>> -#ifdef LARGE_FILE
>> -		(void)printf("child %d (pid %ld): seed %d, fsize %Ld, "
>> -			     "mapsize %d, off %Ld, loop %d\n",
>> -			     procno, getpid(), seed, filesize, mapsize,
>> -			     offset / pagesize, nloops);
>> -#else /* LARGE_FILE */
>> -		(void)printf("child %d (pid %d): seed %d, fsize %ld, "
>> -			     "mapsize %ld, off %ld, loop %d\n",
>> -			     procno, getpid(), seed, filesize, (long)mapsize,
>> -			     offset / pagesize, nloops);
>> -#endif /* LARGE_FILE */
>> -	}
>> -#ifdef LARGE_FILE
>> -	if ((maddr = mmap64(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED,
>> -			    fd, offset)) == (caddr_t) - 1) {
>> -#else /* LARGE_FILE */
>> -	if ((maddr = mmap(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED,
>> -			  fd, offset)) == (caddr_t) - 1) {
>> -#endif /* LARGE_FILE */
>> -		perror("mmap error");
>> -		anyfail();
>> -	}
>> +	if (debug)
>> +		tst_res(TINFO, "child %d (pid %d): seed %d, fsize %lld, mapsize %ld, off %lld, loop %d",
>> +			procno, getpid(), seed, (long long)filesize,
>> +			(long)mapsize, (long long)offset / pagesize, nloops);
>>  
>> -	(void)close(fd);
>> +	maddr = SAFE_MMAP(0, mapsize, PROT_READ | PROT_WRITE, MAP_SHARED, fd,
>> +			  offset);
>> +	SAFE_CLOSE(fd);
>>  
>> -	/*
>> -	 *  Now loop read/writing random pages.
>> -	 */
>>  	for (loopcnt = 0; loopcnt < nloops; loopcnt++) {
>>  		randpage = lrand48() % mappages;
>>  		paddr = maddr + (randpage * pagesize);	/* page address */
>> @@ -554,185 +197,174 @@ void child_mapper(char *file, unsigned procno, unsigned nprocs)
>>  
>>  		for (i = procno; i < validsize; i += nprocs) {
>>  			if (*((unsigned char *)(paddr + i))
>> -			    != ((procno + pattern) & 0xff)) {
>> -				(void)fprintf(stderr, "child %d: invalid data "
>> -					      "<x%x>", procno,
>> -					      *((unsigned char *)(paddr + i)));
>> -				(void)fprintf(stderr, " at pg %d off %d, exp "
>> -					      "<x%x>\n", randpage, i,
>> -					      (procno + pattern) & 0xff);
>> -				anyfail();
>> -			}
>> +			    != ((procno + pattern) & 0xff))
>> +				tst_brk(TFAIL, "child %d: invalid data <x%x>\n"
>> +					" at pg %d off %d, exp <x%x>", procno,
>> +					*((unsigned char *)(paddr + i)),
>> +					randpage, i, (procno + pattern) & 0xff);
>>  
>> -			/*
>> -			 *  Now write it.
>> -			 */
>>  			*(paddr + i) = (procno + pattern) & 0xff;
>>  		}
>>  	}
>> -	if (dosync) {
>> -		/*
>> -		 * Exercise msync() as well!
>> -		 */
>> +	if (do_sync) {
>>  		randpage = lrand48() % mappages;
>>  		paddr = maddr + (randpage * pagesize);	/* page address */
>>  		if (msync(paddr, (mappages - randpage) * pagesize,
>> -			  MS_SYNC) == -1) {
>> -			anyfail();
>> -		}
>> -	}
>> -	if (munmap(maddr, mapsize) == -1) {
>> -		perror("munmap failed");
>> -		local_flag = FAILED;
>> -		anyfail();
>> +			  MS_SYNC) == -1)
>> +			tst_brk(TBROK | TERRNO, "msync failed");
>>  	}
>> +	SAFE_MUNMAP(maddr, mapsize);
>>  	exit(0);
>>  }
>>  
>> -/*
>> - *  Make sure file has all the correct data.
>> - */
>> -int fileokay(char *file, uchar_t * expbuf)
>> +/* Make sure file has all the correct data. */
>> +static void fileokay(char *file, unsigned char *expbuf)
>>  {
>> -#ifdef LARGE_FILE
>> -	struct stat64 statbuf;
>> -#else /* LARGE_FILE */
>> -	struct stat statbuf;
>> -#endif /* LARGE_FILE */
>> -	size_t mapsize;
>> -	unsigned mappages;
>> -	unsigned pagesize = sysconf(_SC_PAGE_SIZE);
>> -	uchar_t readbuf[pagesize];
>> -	int fd;
>>  	int cnt;
>> -	unsigned i, j;
>> -
>> -#ifdef LARGE_FILE
>> -	if ((fd = open64(file, O_RDONLY)) == -1) {
>> -#else /* LARGE_FILE */
>> -	if ((fd = open(file, O_RDONLY)) == -1) {
>> -#endif /* LARGE_FILE */
>> -		perror("open error");
>> -		/***** LTP Port *****/
>> -		local_flag = FAILED;
>> -		anyfail();
>> -		/*****	**	*****/
>> -		return 0;
>> -	}
>> -#ifdef LARGE_FILE
>> -	if (fstat64(fd, &statbuf) == -1) {
>> -#else /* LARGE_FILE */
>> -	if (fstat(fd, &statbuf) == -1) {
>> -#endif /* LARGE_FILE */
>> -		perror("stat error");
>> -		/***** LTP Port *****/
>> -		local_flag = FAILED;
>> -		anyfail();
>> -		/*****	**	*****/
>> -		return 0;
>> -	}
>> -#ifdef LARGE_FILE
>> -	if (lseek64(fd, sparseoffset, SEEK_SET) < 0) {
>> -#else /* LARGE_FILE */
>> -	if (lseek(fd, sparseoffset, SEEK_SET) < 0) {
>> -#endif /* LARGE_FILE */
>> -		perror("lseek");
>> -		anyfail();
>> -	}
>> +	size_t mapsize;
>> +	struct stat statbuf;
>> +	unsigned char readbuf[pagesize];
>> +	unsigned int i, j;
>> +	unsigned int mappages;
>>  
>> -	if (statbuf.st_size - sparseoffset > SIZE_MAX) {
>> -		fprintf(stderr, "size_t overflow when setting up map\n");
>> -		anyfail();
>> -	}
>> +	fd = SAFE_OPEN(file, O_RDONLY);
>> +
>> +	SAFE_FSTAT(fd, &statbuf);
>> +	SAFE_LSEEK(fd, sparseoffset, SEEK_SET);
>> +
>> +	if (statbuf.st_size - sparseoffset > UINT_MAX)
>> +		tst_brk(TBROK, "size_t overflow when setting up map");
>>  	mapsize = (size_t) (statbuf.st_size - sparseoffset);
>>  
>>  	mappages = roundup(mapsize, pagesize) / pagesize;
>>  
>>  	for (i = 0; i < mappages; i++) {
>> -		cnt = read(fd, readbuf, pagesize);
>> -		if (cnt == -1) {
>> -			perror("read error");
>> -			/***** LTP Port *****/
>> -			local_flag = FAILED;
>> -			anyfail();
>> -			/*****	**	*****/
>> -			return 0;
>> -		} else if (cnt != pagesize) {
>> -			/*
>> -			 *  Okay if at last page in file...
>> -			 */
>> -			if ((i * pagesize) + cnt != mapsize) {
>> -				(void)fprintf(stderr, "read %d of %ld bytes\n",
>> -					      (i * pagesize) + cnt,
>> -					      (long)mapsize);
>> -				close(fd);
>> -				return 0;
>> -			}
>> +		cnt = SAFE_READ(0, fd, readbuf, pagesize);
>> +		if ((unsigned int)cnt != pagesize) {
>> +			/* Okay if at last page in file... */
>> +			if ((i * pagesize) + cnt != mapsize)
>> +				tst_brk(TFAIL, "missing data: read %lu of %ld bytes",
>> +					(i * pagesize) + cnt, (long)mapsize);
>>  		}
>> -		/*
>> -		 *  Compare read bytes of data.
>> -		 */
>> -		for (j = 0; j < cnt; j++) {
>> -			if (expbuf[j] != readbuf[j]) {
>> -				(void)fprintf(stderr,
>> -					      "read bad data: exp %c got %c)",
>> -					      expbuf[j], readbuf[j]);
>> -#ifdef LARGE_FILE
>> -				(void)fprintf(stderr, ", pg %d off %d, "
>> -					      "(fsize %Ld)\n", i, j,
>> -					      statbuf.st_size);
>> -#else /* LARGE_FILE */
>> -				(void)fprintf(stderr, ", pg %d off %d, "
>> -					      "(fsize %ld)\n", i, j,
>> -					      statbuf.st_size);
>> -#endif /* LARGE_FILE */
>> -				close(fd);
>> -				return 0;
>> -			}
>> +		/* Compare read bytes of data. */
>> +		for (j = 0; j < (unsigned int)cnt; j++) {
>> +			if (expbuf[j] != readbuf[j])
>> +				tst_brk(TFAIL,
>> +					"read bad data: exp %c got %c, pg %d off %d, (fsize %lld)",
>> +					expbuf[j], readbuf[j], i, j,
>> +					(long long)statbuf.st_size);
>>  		}
>>  	}
>> -	close(fd);
>> -
>> -	return 1;
>> +	SAFE_CLOSE(fd);
>>  }
>>  
>> - /*ARGSUSED*/ void finish(int sig)
>> +static void sighandler(int sig LTP_ATTRIBUTE_UNUSED)
>>  {
>>  	finished++;
>> -	return;
>>  }
>>  
>> -unsigned int initrand(void)
>> +static unsigned int initrand(void)
>>  {
>>  	unsigned int seed;
>>  
>>  	/*
>> -	 *  Initialize random seed...  Got this from a test written
>> -	 *  by scooter:
>> -	 *      Use srand/rand to diffuse the information from the
>> -	 *      time and pid.  If you start several processes, then
>> -	 *      the time and pid information don't provide much
>> -	 *      variation.
>> +	 * Use srand/rand to diffuse the information from the
>> +	 * time and pid.  If you start several processes, then
>> +	 * the time and pid information don't provide much
>> +	 * variation.
>>  	 */
>>  	srand((unsigned int)getpid());
>>  	seed = rand();
>>  	srand((unsigned int)time(NULL));
>>  	seed = (seed ^ rand()) % 100000;
>> -	srand48((long int)seed);
>> -	return (seed);
>> +	srand48((long)seed);
>> +	return seed;
>>  }
>>  
>> -/*****  LTP Port        *****/
>> -void ok_exit(void)
>> +static void run(void)
>>  {
>> -	tst_resm(TPASS, "Test passed");
>> -	tst_rmdir();
>> -	tst_exit();
>> -}
>> +	int c;
>> +	int i;
>> +	int wait_stat;
>> +	off_t bytes_left;
>> +	pid_t pid;
>> +	pid_t *pidarray;
>> +	size_t write_cnt;
>> +	unsigned char data;
>> +	unsigned char *buf;
>>  
>> -int anyfail(void)
>> -{
>> -	tst_brkm(TFAIL, tst_rmdir, "Test failed");
>> +	alarm(tst_remaining_runtime());
>> +
>> +	finished = 0;
>> +	fd = SAFE_OPEN(TEST_FILE, O_CREAT | O_TRUNC | O_RDWR, 0664);
>> +	buf = SAFE_MALLOC(pagesize);
>> +	pidarray = SAFE_MALLOC(nprocs * sizeof(pid_t));
>> +
>> +	for (i = 0; i < nprocs; i++)
>> +		*(pidarray + i) = 0;
>> +
>> +	for (i = 0, data = 0; i < (int)pagesize; i++) {
>> +		*(buf + i) = (data + pattern) & 0xff;
>> +		if (++data == nprocs)
>> +			data = 0;
>> +	}
>> +	SAFE_LSEEK(fd, (off_t)sparseoffset, SEEK_SET);
>> +	for (bytes_left = filesize; bytes_left; bytes_left -= c) {
>> +		write_cnt = MIN((long long)pagesize, (long long)bytes_left);
>> +		c = SAFE_WRITE(1, fd, buf, write_cnt);
>> +	}
>> +	SAFE_CLOSE(fd);
>> +
>> +	for (i = 0; i < nprocs; i++) {
>> +		pid = SAFE_FORK();
>> +
>> +		if (pid == 0) {
>> +			child_mapper(TEST_FILE, (unsigned int)i, (unsigned int)nprocs);
>> +			exit(0);
>> +		} else {
>> +			pidarray[i] = pid;
>> +		}
>> +	}
>> +
>> +	while (!finished) {
>> +		pid = wait(&wait_stat);
>> +		if (pid != -1) {
>> +			if (!WIFEXITED(wait_stat)
>> +			    || WEXITSTATUS(wait_stat) != 0)
>> +				tst_brk(TBROK, "child exit with err <x%x>",
>> +					wait_stat);
>> +			for (i = 0; i < nprocs; i++)
>> +				if (pid == pidarray[i])
>> +					break;
>> +			if (i == nprocs)
>> +				tst_brk(TBROK, "unknown child pid %d, <x%x>",
>> +					pid, wait_stat);
>> +
>> +			pid = SAFE_FORK();
>> +			if (pid == 0) {
>> +				child_mapper(TEST_FILE, (unsigned int)i, (unsigned int)nprocs);
>> +				exit(0);
>> +			} else {
>> +				pidarray[i] = pid;
>> +			}
>> +		} else {
>> +			if (errno != EINTR || !finished)
>> +				tst_brk(TBROK | TERRNO,
>> +					"unexpected wait error");
>> +		}
>> +	}
>> +	alarm(0);
>> +
>> +	fileokay(TEST_FILE, buf);
>> +	tst_res(TPASS, "file has expected data");
>>  }
>>  
>> -/*****  **      **      *****/
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.options = options,
>> +	.cleanup = cleanup,
>> +	.max_runtime = 12,
>> +	.needs_tmpdir = 1,
>> +	.forks_child = 1,
>> +};
>> -- 
>> 2.38.1.273.g43a17bfeac-goog


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
