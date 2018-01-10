From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 10 Jan 2018 14:05:50 +0100
Subject: [LTP] [PATCH] Add read_all01 test
In-Reply-To: <20180110110144.GA18314@rei>
References: <20180109153028.30160-1-rpalethorpe@suse.com>
 <20180110110144.GA18314@rei>
Message-ID: <87tvvtkgnl.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis writes:

> Hi!
>>  # Was not sure why it should reside in runtest/crashme and won??t get tested ever
>>  proc01 proc01 -m 128
>>
>> +read_all01_dev read_all01 -d /dev
>> +read_all01_proc read_all01 -d /proc
>> +read_all01_sys read_all01
>
> I find it a little bit confusing that we default to /sys, I wonder if
> printing error in case that user haven't supplied the path would be
> better.

OK.

>
> And mabe we can drop the 01 from the name, or do you plan to write
> more tests likes this one?

Maybe read_all02 could take a dictionary with callbacks for handling
particular files. I think that even if we just have one executable which
takes various arguments to perform different tests it might be good to
number the tests in the runtest file.

I am not against dropping the 01 from the .c file though.

>
>> diff --git a/testcases/kernel/fs/read_all/.gitignore b/testcases/kernel/fs/read_all/.gitignore
>> new file mode 100644
>> index 000000000..4b405760c
>> --- /dev/null
>> +++ b/testcases/kernel/fs/read_all/.gitignore
>> @@ -0,0 +1 @@
>> +read_all01
>> diff --git a/testcases/kernel/fs/read_all/Makefile b/testcases/kernel/fs/read_all/Makefile
>> new file mode 100644
>> index 000000000..f51fbe591
>> --- /dev/null
>> +++ b/testcases/kernel/fs/read_all/Makefile
>> @@ -0,0 +1,22 @@
>> +# Copyright (c) 2017 Linux Test Project
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License as
>> +# published by the Free Software Foundation; either version 2 of
>> +# the License, or (at your option) any later version.
>> +#
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program. If not, see <http://www.gnu.org/licenses/>.
>> +
>> +top_srcdir		?= ../../../..
>> +
>> +include $(top_srcdir)/include/mk/testcases.mk
>> +
>> +CFLAGS			+= -D_GNU_SOURCE
>> +
>> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
>> diff --git a/testcases/kernel/fs/read_all/read_all01.c b/testcases/kernel/fs/read_all/read_all01.c
>> new file mode 100644
>> index 000000000..f746db33b
>> --- /dev/null
>> +++ b/testcases/kernel/fs/read_all/read_all01.c
>> @@ -0,0 +1,288 @@
>> +/*
>> + * Copyright (c) 2017 Richard Palethorpe <rpalethorpe@suse.com>
>> + *
>> + * This program is free software: you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation, either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program. If not, see <http://www.gnu.org/licenses/>.
>> + */
>> +/*
>> + * Perform a small read on every file in a directory tree.
>> + *
>> + * Useful for testing file systems like proc, sysfs and debugfs or anything
>> + * which exposes a file like API so long as it respects O_NONBLOCK. This test
>> + * is not concerned if a particular file in one of these file systems conforms
>> + * exactly to its specific documented behavior. Just whether reading from that
>> + * file causes a serious error such as a NULL pointer dereference.
>> + *
>> + * It is not required to run this as root, but test coverage will be much
>> + * higher with full privileges.
>> + *
>> + * The reads are preformed by worker processes which are given file paths by a
>> + * single parent process. The parent process recursively scans a given
>> + * directory and passes the file paths it finds to the child processes through
>> + * a pipe. The test will use a maximum of 15 processes, depending on the
>> + * number of CPU cores available, under the assumption that while parallelism
>> + * is good we don't want to spend too much time creating processes,
>> + * distributing data and waiting for locks.
>
> I wonder if we could make this faster with threads and semaphore over
> circular string buffer. Design with processes and pipes resembless the
> shell version quite a lot...

I suppose so. I would like to keep processes as well as threads though,
but I could communicate using shared memory instead of pipes.

>
>> +#include <sys/types.h>
>> +#include <sys/stat.h>
>> +#include <stdlib.h>
>> +#include <stdio.h>
>> +#include <dirent.h>
>> +#include <errno.h>
>> +#include <unistd.h>
>> +#include <string.h>
>> +#include <limits.h>
>> +#include <fnmatch.h>
>> +
>> +#include "tst_test.h"
>> +#include "tst_minmax.h"
>
> Isn't the tst_minmax.h included in tst_test.h?
>
> I think that it needs to be included separately only for oldlib tests.
>
>> +#define BUFFER_SIZE 1024
>> +#define MAX_PATH 4096
>> +
>> +struct worker {
>> +	pid_t pid;
>> +	int in;
>> +	int out;
>> +};
>> +
>> +static char *verbose;
>> +static char *root_dir = "/sys";
>> +static char *exclude;
>> +static long worker_count;
>> +static struct worker *workers;
>> +
>> +static struct tst_option options[] = {
>> +	{"v", &verbose,
>> +	 "-v       Print information about successful reads"},
>> +	{"d:", &root_dir,
>> +	 "-d path  Path to the directory to read from, defaults to /sys"},
>> +	{"e:", &exclude,
>> +	 "-e pattern Ignore files which match an 'extended' pattern, see fnmatch(3)"},
>> +	{NULL, NULL, NULL}
>> +};
>> +
>> +static void read_test(const char *path)
>> +{
>> +	char buf[BUFFER_SIZE];
>> +	int fd;
>> +	ssize_t count;
>> +
>> +	if (exclude && !fnmatch(exclude, path, FNM_EXTMATCH)) {
>> +		if (verbose)
>> +			tst_res(TINFO, "Ignoring %s", path);
>> +		return;
>> +	}
>> +
>> +	if (verbose)
>> +		tst_res(TINFO, "%s(%s)", __func__, path);
>> +
>> +	fd = open(path, O_RDONLY | O_NONBLOCK);
>> +	if (fd < 0) {
>> +		tst_res(TINFO | TERRNO, "open(%s)", path);
>> +		return;
>> +	}
>> +
>> +	count = read(fd, buf, sizeof(buf) - 1);
>> +	if (count > 0 && verbose) {
>> +		if (count <= 20) {
>> +			if (buf[count - 1] == '\n')
>> +				buf[count - 1] = '\0';
>> +			else
>> +				buf[count] = '\0';
>> +		} else
>> +			strcpy(buf + 20, "...");
>> +
>> +		tst_res(TINFO, "read(%s, buf) = %ld, buf = %s",
>> +			path, count, buf);
>
> We should probably make sure here that the buffer contains printable
> characters (isprint() ?) otherwise we may print some terminal controll
> characters.
>
>> +	} else if (!count && verbose)
>> +		tst_res(TINFO, "read(%s) = EOF", path);
>> +	else if (count < 0)
>> +		tst_res(TINFO | TERRNO, "read(%s)", path);
>> +
>> +	SAFE_CLOSE(fd);
>> +}
>> +
>> +static int worker_run(struct worker *self)
>> +{
>> +	ssize_t i, j, ret, count;
>> +	char buf[PIPE_BUF];
>> +	struct sigaction term_sa = {
>> +		.sa_handler = SIG_IGN,
>> +		.sa_flags = 0,
>> +	};
>> +
>> +	sigaction(SIGTTIN, &term_sa, NULL);
>> +
>> +	for (count = 0;;) {
>> +		ret = read(self->in, buf + count, sizeof(buf) - 1 - count);
>> +		if (ret < 0 && errno == EINTR)
>> +			continue;
>> +		else if (ret < 0)
>> +			tst_res(TBROK | TERRNO,
>> +				"Worker can not read from pipe");
>> +		else if (ret == 0)
>> +			break;
>> +
>> +		count += ret;
>> +
>> +		for (i = 0, j = 0; i < count; i++) {
>> +			if (buf[i] == '\n') {
>> +				buf[i] = '\0';
>> +				read_test(buf + j);
>> +				j = i + 1;
>> +			}
>> +		}
>> +
>> +		count = i - j;
>> +		memmove(buf, buf + j, count);
>> +		if (sizeof(buf) - 1 - count < 1)
>> +			tst_brk(TBROK,
>> +				"Worker receive buffer is too small for path");
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void spawn_workers(void)
>> +{
>> +	int i, j;
>> +	int pipe[2];
>> +	struct worker *wa = workers;
>> +
>> +	bzero(workers, worker_count * sizeof(*workers));
>> +
>> +	for (i = 0; i < worker_count; i++) {
>> +		SAFE_PIPE(pipe);
>> +		wa[i].in = pipe[0];
>> +		wa[i].out = pipe[1];
>> +		wa[i].pid = SAFE_FORK();
>> +		if (!wa[i].pid) {
>> +			for (j = 0; j <= i; j++)
>> +				SAFE_CLOSE(wa[j].out);
>> +			exit(worker_run(wa + i));
>> +		} else {
>> +			SAFE_CLOSE(wa[i].in);
>> +		}
>> +	}
>> +}
>> +
>> +static void stop_workers(void)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; workers && i < worker_count; i++) {
>> +		if (workers[i].out > 0)
>> +			SAFE_CLOSE(workers[i].out);
>> +	}
>> +}
>> +
>> +static void sched_work(const char *path)
>> +{
>> +	static long cur;
>> +
>> +	SAFE_WRITE(1, workers[cur].out, path, strlen(path));
>> +	cur++;
>> +	if (cur >= worker_count)
>> +		cur = 0;
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	worker_count = MIN(MAX(SAFE_SYSCONF(_SC_NPROCESSORS_ONLN) - 1, 1), 15);
>> +	workers = (struct worker *)SAFE_MALLOC(worker_count * sizeof(*workers));
>                     ^
> 		    Please no useless casts like this one.
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	stop_workers();
>> +
>> +	if (workers)
>> +		free(workers);
>
> Again, free(NULL) is no-op, no need for the if () here.
>
>> +}
>> +
>> +static void visit_dir(const char *path)
>> +{
>> +	DIR *dir;
>> +	struct dirent *dent;
>> +	struct stat dent_st;
>> +	char dent_path[MAX_PATH];
>> +
>> +	dir = opendir(path);
>> +	if (!dir) {
>> +		tst_res(TINFO | TERRNO, "opendir(%s)", path);
>> +		return;
>> +	}
>> +
>> +	for (dent = SAFE_READDIR(dir); dent; dent = SAFE_READDIR(dir)) {
>> +		if (!strcmp(dent->d_name, ".") ||
>> +		    !strcmp(dent->d_name, ".."))
>> +			continue;
>> +
>> +		if (dent->d_type != DT_UNKNOWN) {
>> +			switch (dent->d_type) {
>> +			case DT_DIR:
>> +				snprintf(dent_path, MAX_PATH,
>> +					 "%s/%s", path, dent->d_name);
>> +				visit_dir(dent_path);
>> +				break;
>> +			case DT_LNK:
>> +				break;
>> +			default:
>> +				snprintf(dent_path, MAX_PATH,
>> +					 "%s/%s\n", path, dent->d_name);
>> +				sched_work(dent_path);
>> +			}
>> +		} else {
>> +			SAFE_LSTAT(dent_path, &dent_st);
>                                     ^
> 				    Shouldn't we initialize the
> 				    dent_path with snprintf() first?

doh

>
>> +			switch (dent_st.st_mode & S_IFMT) {
>> +			case S_IFDIR:
>> +				snprintf(dent_path, MAX_PATH,
>> +					 "%s/%s", path, dent->d_name);
>> +				visit_dir(dent_path);
>> +				break;
>> +			case S_IFLNK:
>> +				break;
>> +			default:
>> +				snprintf(dent_path, MAX_PATH,
>> +					 "%s/%s\n", path, dent->d_name);
>> +				sched_work(dent_path);
>> +			}
>> +		}
>> +	}
>> +
>> +	SAFE_CLOSEDIR(dir);
>> +}
>> +
>> +static void run(void)
>> +{
>> +	spawn_workers();
>> +
>> +	visit_dir(root_dir);
>> +	tst_res(TPASS, "Finished scanning directory tree");
>
> I also wonder if it would be beneficial to run several visit_dir()
> threads here in order to try to trigger race conditions when the same
> file is opened several times.
>
> I would probable have created abstract rreader (recursive reader) API
> so that we can initialize/allocate rreader then request it to run on a
> directory with a given number of threads and then deinit/free it at the
> end. Then we can run several of these in parallel even for a given
> subdirectory.
>

That seems reasonable; the user could specify the number of directory
reads they want to do in parallel and then each directory reader could
queue up work for the file readers.

--
Thank you,
Richard.
