Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Whi7B-0001o9-53
	for ltp-list@lists.sourceforge.net; Tue, 06 May 2014 16:21:09 +0000
Date: Tue, 6 May 2014 18:20:09 +0200
From: chrubis@suse.cz
Message-ID: <20140506162009.GB7908@rei.Home>
References: <1397663294-60210-1-git-send-email-mats.liljegren@enea.com>
	<1398697619-27372-1-git-send-email-mats.liljegren@enea.com>
	<1398697619-27372-2-git-send-email-mats.liljegren@enea.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1398697619-27372-2-git-send-email-mats.liljegren@enea.com>
Subject: Re: [LTP] [PATCH] partrt_nohz_full: Introducing a new test case
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mats Liljegren <mats.liljegren@enea.com>
Cc: ltp-list@lists.sourceforge.net, Kevin Hilman <khilman@linaro.org>, Frederic Weisbecker <fweisbec@gmail.com>

Hi!
> +Dependencies
> +------------
> +CPU partitioning is performed by the partrt tool, which is available as a git
> +submodule. Before building, do the following from the LTP root directory to
> +include rt-tools in the build:
> +
> +        git submodule update utils/rt-tools

I think that you have to do git submodule init prior to this (at least
if you do this right after you cloned git repository).

> +The following build time kernel configurations must be enabled:
> +
> +        CONFIG_NO_HZ_FULL=y
> +        CONFIG_CPUSETS=y
> +
> +These kernel configuration parameters are also documented in the
> +READ.kernel_config file in LTP root directory.
> +
> +The following kernel boot parameter needs to be set:
> +
> +        nohz_full=<cpu list>
> +
> +There might be other parameters needed to actually get nohz_full working, but
> +this is largely dependent on architecture and kernel version.
> +
> +How to run
> +----------
> +
> +The partrt_nohz_full test is run by runltp like so:
> +
> +        ./runltp -f partrt_nohz_full
> +
> +To make life interesting, you can play with "-n" and "-i" options to runltp, to
> +generate some load in the non-realtime partition:
> +
> +        ./runltp -n -i 5 -f partrt_nohz_full
> +
> +To get some more help with the cause of a failing test, do this as root before
> +running the test:
> +
> +        echo 1 > /sys/kernel/debug/tracing/events/enable
> +
> +and then look at trace after test failed:
> +
> +        cat /sys/kernel/debug/tracing/trace
> +
> +Since "count_ticks" also uses ftrace and will update tracing_cpumask to only
> +trace the nohz_full CPUs, the trace should be close to empty if the run was
> +successful.
> diff --git a/testcases/kernel/partrt/nohz_full/.gitignore b/testcases/kernel/partrt/nohz_full/.gitignore
> new file mode 100644
> index 0000000..5848b21
> --- /dev/null
> +++ b/testcases/kernel/partrt/nohz_full/.gitignore
> @@ -0,0 +1 @@
> +/test_partrt_nohz_full
> diff --git a/testcases/kernel/partrt/nohz_full/Makefile b/testcases/kernel/partrt/nohz_full/Makefile
> new file mode 100644
> index 0000000..5528dc0
> --- /dev/null
> +++ b/testcases/kernel/partrt/nohz_full/Makefile
> @@ -0,0 +1,23 @@
> +#
> +#  Copyright (C) 2014, Enea AB.
> +#
> +#  This program is free software;  you can redistribute it and/or modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation; either version 2 of the License, or
> +#  (at your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +#  the GNU General Public License for more details.
> +#
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +LDLIBS			+= -lrt
> +
> +MAKE_TARGETS		:= test_partrt_nohz_full
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/partrt/nohz_full/test_partrt_nohz_full.c b/testcases/kernel/partrt/nohz_full/test_partrt_nohz_full.c
> new file mode 100644
> index 0000000..1343b71
> --- /dev/null
> +++ b/testcases/kernel/partrt/nohz_full/test_partrt_nohz_full.c
> @@ -0,0 +1,551 @@
> +/*
> + * Copyright (C) 2014, Enea AB.
> + *
> + * This program is free software;  you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY;  without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> + * the GNU General Public License for more details.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <errno.h>
> +#include <string.h>
> +#include <getopt.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <sys/syscall.h>
> +#include <sys/stat.h>
> +#include <sys/timerfd.h>
> +#include <stdarg.h>
> +#include <inttypes.h>
> +#include <limits.h>
> +#include <time.h>
> +#include <sched.h>
> +#include <fcntl.h>
> +
> +#include <test.h>
> +#include <usctest.h>
> +#include <safe_macros.h>
> +#include <safe_stdio.h>
> +
> +const char *TCID = "partrt_nohz_full";
> +const int TST_TOTAL = 1;
> +
> +/* Used for RT load */
> +volatile int dummy_value;
> +
> +/* When true (1), all children will terminate */
> +static volatile int time_is_up;
> +
> +/* Verbosity level chosen from program command line.
> + * 0 = No extra information from called sub-programs
> + * 1 = Request verbose information from called sub-programs
> + * 2 = Request more verbose inormation from called sub-programs.
> + */
> +static int verbose;

The verbosity level doesn't seem to be used anywhere (apart from being
set while parsing command line options).

> +/* Name of application as given in argv[0] */
> +static const char *appname;
> +
> +/* Boolean describing whether RT partition in cpuset needs to be created */
> +int need_partrt_create = 0;
> +
> +/* RT load function prototype */
> +typedef void (child_func)(void);
> +
> +/* Amount of stack for RT load threads */
> +#define STACK_SZ (64 * 1024)
> +
> +/* Default path to cgroups/cpuset */
> +#define CPUSET_ROOT "/sys/fs/cgroup/cpuset"
> +
> +/* Expected path to cpuset RT partition */
> +#define CPUSET_RT_PATH CPUSET_ROOT "/rt"
> +
> +/* Expected path to RT partition tasks list file */
> +#define CPUSET_RT_TASKS_FILE CPUSET_RT_PATH "/tasks"
> +
> +/* Expected path to RT partition CPU list file */
> +#define CPUSET_RT_CPUS_FILE CPUSET_RT_PATH "/cpuset.cpus"
> +
> +/* File to look for to determine whether true 0Hz can be achieved */
> +#define SCHED_TICK_MAX_FILE "/sys/kernel/debug/sched_tick_max_deferment"
> +
> +/* File containing a list of filesystems supported by the kernel */
> +#define PROC_FILESYSTEMS_FILE "/proc/filesystems"
> +
> +static void cleanup(void);
> +
> +/*
> + * Check exit status value.
> + * If any signs of error is found, report error and abort testing.
> + */
> +static void assert_exit_status(const char *cmd, int status)
> +{
> +	if (status == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			"%s: Could not execute command", cmd);
> +	if (WIFSIGNALED(status))
> +		tst_brkm(TBROK, cleanup,
> +			 "%s: Child terminated unexpectedly due to signal nr %d",
> +			 cmd,
> +			 WTERMSIG(status));

I think that it's more readbale to add the curly braces around block
that spawns to multiple lines even if it's technically one function
call.

> +	if (!WIFEXITED(status))
> +		tst_brkm(TBROK, cleanup, "%s: Child terminated unexpectedly",
> +			 cmd);
> +	if (WEXITSTATUS(status) != 0)
> +		tst_brkm(TBROK, cleanup, "%s: Child exited with exit status %d",
> +			 cmd,
> +			 WEXITSTATUS(status));
> +}
> +
> +/*
> + * Execute given command using shell, ensure success (0) is returned.
> + */
> +static void shell(const char *cmd, ...)
> +{
> +	char *cmd_buf;
> +	va_list va;
> +
> +	va_start(va, cmd);
> +	if (vasprintf(&cmd_buf, cmd, va) == -1)
> +		tst_brkm(TBROK, cleanup,
> +			 "%s: Not valid printf format, or out of memory", cmd);
> +	va_end(va);
> +
> +	tst_resm(TINFO, "%s: Executing", cmd_buf);
> +	assert_exit_status(cmd_buf, system(cmd_buf));
> +	tst_resm(TINFO, "%s: Returns success", cmd_buf);
> +
> +	free(cmd_buf);
> +}
> +
> +/*
> + * Convert string to unsigned long.
> + * Error prefix expressed as string.
> + */
> +static unsigned long str_to_ulong(
> +	const char *str,
> +	const char *err_prefix
> +	)

Why not just:

static unsigned long str_to_ulong(const char *str, const char *err_prefix)

As far as I can the line fits into 80 chars.

> +{
> +	char *endptr;
> +	unsigned long val;
> +	val = strtoull(str, &endptr, 0);
> +	if (endptr == str)
> +		tst_brkm(TBROK, cleanup,
> +			 "%s: %s: Expected unsigned decimal value",
> +			 err_prefix, str);
> +	if (*endptr != '\0')
> +		tst_brkm(TBROK, cleanup,
> +			 "%s: %s: Garbage character '%c' found after decimal value",
> +			 err_prefix, str, *endptr);
> +
> +	return val;
> +}
> +
> +/*
> + * Call a command using shell.
> + * Command line expressed as va_list.
> + * Returns the command's first line of output.
> + */
> +static char *shell_str(char *dest, int size, const char *cmd, ...)
> +{
> +	int len;
> +	char *cmd_buf;
> +	FILE *file;
> +	va_list va;
> +
> +	/* Build command line */
> +	va_start(va, cmd);
> +	if (vasprintf(&cmd_buf, cmd, va) == -1)
> +		tst_brkm(TBROK, cleanup,
> +			 "%s: Not valid printf format, or out of memory", cmd);
> +	va_end(va);
> +
> +	/* Launch command */
> +	errno = 0;
> +	file = popen(cmd_buf, "r");
> +	if (file == NULL) {
> +		if (errno == 0)
> +			tst_brkm(TBROK, cleanup, "%s: popen(): Out of memory",
> +				 cmd_buf);
> +		else
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +				"%s: popen() failed", cmd_buf);
> +	}

This may be worth of SAFE_POPEN(), I can add it if you want.

> +	tst_resm(TINFO, "%s: Executing", cmd_buf);
> +
> +	/* Read commands stdout */
> +	if (fgets(dest, size, file) == NULL) {
> +		if (feof(file))
> +			tst_brkm(TBROK, cleanup,
> +				 "%s: Expected output from the command, but got nothing",
> +				 cmd_buf);
> +		else
> +			tst_brkm(TBROK | TERRNO, cleanup,
> +				 "%s: Could not read command output",
> +				 cmd_buf);
> +	}
> +
> +	/* Get rid of terminating newline, if any */
> +	len = strlen(dest);
> +	if (dest[len-1] == '\n')
> +		dest[len-1] = '\0';
> +
> +	/* Wait until command execution finish.
> +	 * Main reason for doing this even though we've got what we want is for
> +	 * better error detection. The alternative could be to let cleanup()
> +	 * handle it if process hasn't finished by then. */
> +	assert_exit_status(cmd_buf, pclose(file));
> +
> +	tst_resm(TINFO, "%s: Returns: %s", cmd_buf, dest);
> +
> +	free(cmd_buf);
> +
> +	return dest;
> +}
> +
> +static int child_entry(void *arg)
> +{
> +	(void) arg;
> +
> +	while (!time_is_up)
> +		dummy_value = rand();
> +
> +	return 0;
> +}
> +
> +/*
> + * Start a new thread executing the given function, on the given cpuset
> + * partition and CPU ID. Note that the CPU ID must be one of the
> + * available CPUs in the cpuset partition.
> + */
> +static void launch_child(int cpu)
> +{
> +	char *stack = SAFE_MALLOC(cleanup, STACK_SZ);
> +	int tid;
> +	const int cpuset_tasks_fd = SAFE_OPEN(cleanup, CPUSET_RT_TASKS_FILE,
> +					      O_WRONLY);
> +	char *tid_str;
> +	cpu_set_t cpu_set;
> +
> +	tid = ltp_clone(CLONE_VM, child_entry, NULL, STACK_SZ, stack);
> +	if (tid == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "clone() failed");
> +
> +	/* Move child to RT partition */
> +	SAFE_ASPRINTF(cleanup, &tid_str, "%ld", (long) tid);
> +	SAFE_WRITE(cleanup, 1, cpuset_tasks_fd, tid_str, strlen(tid_str));
> +
> +	free(tid_str);
> +	SAFE_CLOSE(cleanup, cpuset_tasks_fd);

	SAFE_FILE_PRINTF(cleanup, CPUSET_RT_TASKS_FILE, "%ld", (long)tid) ?

	Or is there a good reason to use open(), asprintf(), write() and
	close() instead?

> +
> +	/* Move child to indicated CPU within the RT partition */
> +	CPU_ZERO(&cpu_set);
> +	CPU_SET(cpu, &cpu_set);
> +	if (sched_setaffinity(tid, sizeof(cpu_set), &cpu_set) < 0)
> +		tst_brkm(TBROK | TERRNO, cleanup,
> +			"pid %u: sched_setaffinity() failed",
> +			tid);
> +
> +	tst_resm(TINFO, "pid %d: Starting RT load on cpu %d",
> +		 tid, cpu);
> +}
> +
> +static void cleanup(void)
> +{
> +	static int cleanup_entered;
> +
> +	pid_t pid;
> +	int status;
> +
> +	if (cleanup_entered)
> +		return; /* Called from cleanup() */
> +
> +	cleanup_entered = 1;

Why is this still needed? It shouldn't be if only parent process uses
the tst_* interface.

> +	tst_resm(TINFO, "Cleanup: Terminating children");
> +
> +	time_is_up = 1;
> +
> +	do {
> +		pid = wait(&status);
> +		if (pid != -1) {
> +			char cmd[64];
> +			snprintf(cmd, sizeof(cmd), "Pid %lu",
> +				 (unsigned long) pid);
> +			assert_exit_status(cmd, status);
> +			tst_resm(TINFO,
> +				 "Cleanup: %s: Has terminated successfully",
> +				 cmd);
> +		}
> +	} while (pid != -1);
> +
> +	if (errno != ECHILD)
> +		tst_brkm(TBROK | TERRNO, NULL, "Cleanup: wait() failed");
> +
> +	if (need_partrt_create)
> +		shell("partrt undo");
> +
> +	tst_resm(TINFO, "Cleanup: Done");
> +}
> +
> +static unsigned long determine_nohz_mask(void)
> +{
> +	int range_first;
> +	int range_last;
> +	int bit;
> +	unsigned long mask = 0;
> +	FILE *stream = SAFE_FOPEN(cleanup, CPUSET_RT_CPUS_FILE, "r");
> +	int nr_matches;
> +
> +	for (nr_matches = fscanf(stream, "%d-%d", &range_first, &range_last);
> +	     nr_matches > 0;
> +	     nr_matches = fscanf(stream, ",%d-%d", &range_first, &range_last)) {
> +		if (nr_matches == 1)
> +			range_last = range_first;
> +
> +		/* Set all bits in range */
> +		for (bit = range_first; bit <= range_last; bit++)
> +			mask |= (1 << bit);

                       Are you sure that this would not overflow?

		       I guess that it depends on how you have
		       partitioned your CPUs.
> +	}
> +
> +	SAFE_FCLOSE(cleanup, stream);
> +
> +	if (nr_matches == -1)
> +		tst_brkm(TBROK | TERRNO, cleanup, "%s: fscanf() failed",
> +			 CPUSET_RT_CPUS_FILE);
> +
> +	return mask;
> +}
> +
> +static void tool_available(char *tool_name, const char *env_path)
> +{
> +	int success = 0;
> +
> +	if (strchr(tool_name, '/') != NULL) {
> +		if (access(tool_name, X_OK) == 0)
> +			success = 1;
> +	} else {
> +		char full_path[PATH_MAX];
> +		const char *curr;
> +		char * const alloced_path = strdup(env_path);
> +		char *next = alloced_path;
> +
> +		for (curr = strsep(&next, ":");
> +		     curr != NULL;
> +		     curr = strsep(&next, ":")) {
> +			if (*curr == '\0')
> +				curr = ".";
> +			if (snprintf(full_path, sizeof(full_path),
> +					"%s/%s", curr, tool_name
> +					) >= (int)sizeof(full_path))
> +				continue;
> +			if (access(full_path, X_OK) == 0) {
> +				success = 1;
> +				break;
> +			}
> +		}
> +		free(alloced_path);
> +	}
> +
> +	if (!success)
> +		tst_brkm(TCONF, cleanup,
> +			"%s tool not found, skipping test. Use 'git submodule update utils/rt-tools' to include needed tools in the build.",
> +			tool_name);
> +}
> +
> +static void tools_check(void)
> +{
> +	const char *env_path = getenv("PATH");
> +
> +	if (env_path == NULL)
> +		env_path = "";
> +
> +	tool_available("partrt", env_path);
> +	tool_available("list2mask", env_path);
> +	tool_available("count_ticks", env_path);

We have tst_get_path() that could be used as:

char buf[2048];

if (!tst_get_path("partrt", buf, sizeof(buf)))
	tst_brkm(TCONF, cleanup, "Tool partrt not available");

> +}
> +
> +static void cpuset_check(void)
> +{
> +	FILE * const stream = SAFE_FOPEN(cleanup, PROC_FILESYSTEMS_FILE, "r");
> *
> +	char *name;
> +
> +	while (fscanf(stream, "%as", &name) > 0) {
> +		if (strcmp(name, "cpuset") == 0) {
> +			free(name);
> +			return;
> +		}
> +		free(name);
> +	}
> +
> +	tst_brkm(TCONF, cleanup, "CPUSET not configured in kernel");
> +}
> +
> +/*
> + * Setup and return number of child threads
> + */
> +static int setup_children(void)
> +{
> +	unsigned long nohz_mask;
> +	int bit;
> +	int nr_children = 0;
> +
> +	time_is_up = 0;
> +
> +	tools_check();
> +	tst_require_root(NULL);
> +	cpuset_check();
> +
> +	if (access(CPUSET_RT_PATH, F_OK) == -1)
> +		need_partrt_create = 1;
> +
> +	if (need_partrt_create)
> +		shell("partrt create $(list2mask --nohz)");
> +
> +	nohz_mask = determine_nohz_mask();
> +	tst_resm(TINFO, "Nohz CPU mask: %#lx", nohz_mask);
> +
> +	for (bit = 0; bit < (int) (sizeof(nohz_mask) * 8); bit++) {
> +		if (nohz_mask & (1lu << bit)) {
> +			launch_child(bit);
> +			nr_children++;
> +		}
> +	}
> +
> +	tst_resm(TINFO, "All children started");
> +	return nr_children;
> +}
> +
> +/*
> + * Perform tick measurement for the given number of seconds.
> + */
> +static void test(time_t duration, unsigned nr_children)
> +{
> +	uint64_t nr_ticks;
> +	time_t time_finished;
> +	/* If sched_tick_max_deferment patch has been applied, expect that the
> +	 * partitioning has disabled ticks completely. Otherwise, expect
> +	 * 1Hz ticks */
> +	const int expect_0hz =
> +		access(SCHED_TICK_MAX_FILE, F_OK) == 0;
> +	const time_t current_time = time(NULL);
> +
> +	const uint64_t expected_ticks = expect_0hz ? 0 : duration * nr_children;
> +	char val_str[64];
> +	static const char count_ticks_end_cmd[] =
> +		"count_ticks --cpu rt --batch --end";
> +	int timer_fd;
> +	struct itimerspec timeout = { {0}, {0} };
> +	uint64_t nr_timeouts;
> +
> +	shell("count_ticks --cpu rt --start");
> +
> +	time_finished = time(NULL) + duration;
> +
> +	tst_resm(TINFO, "Execution started: %s", ctime(&current_time));
> +	tst_resm(TINFO, "Execution ends   : %s", ctime(&time_finished));

What is this information good for? As far as I can see it says how long
it took to prepare for the actual test.

> +	timer_fd = timerfd_create(CLOCK_MONOTONIC, 0);
> +	timeout.it_value.tv_sec = duration;
> +	timerfd_settime(timer_fd, 0, &timeout, NULL);
> +
> +	/* Wait for timeout */
> +	SAFE_READ(cleanup, 1, timer_fd, &nr_timeouts, sizeof(nr_timeouts));
> +	if (nr_timeouts != 1)
> +		tst_brkm(TBROK, cleanup,
> +			"Multiple timeouts when single timeout was requested");
> +
> +	shell_str(val_str, sizeof(val_str), count_ticks_end_cmd);
> +	nr_ticks = str_to_ulong(val_str, count_ticks_end_cmd);
> +
> +	if (expect_0hz) {
> +		if (nr_ticks != 0)
> +			tst_resm(TFAIL, "Expected no ticks, but got %" PRIu64,
> +				 nr_ticks);
> +		else
> +			tst_resm(TPASS, "No ticks occurred");
> +	} else {
> +		if (nr_ticks > expected_ticks)
> +			tst_resm(TFAIL,
> +				 "Expected maximum %" PRIu64
> +				 " ticks, but got %" PRIu64,
> +				 expected_ticks, nr_ticks);
> +		else
> +			tst_resm(TPASS,
> +				 "%" PRIu64
> +				 " ticks occurred, which was expected",
> +				 nr_ticks);
> +	}
> +}
> +
> +static void usage(void)
> +{
> +	printf(
> +		"Usage: %s [options]\n"
> +		"       %s --help\n"
> +		"Test whether a CPU can be isolated and made tickless even under load.\n"
> +		"\n"
> +		"  -h         Display this usage text and exit.\n"
> +		"  -v <level> Set verbose level, 0 = default.\n"
> +		"  -d <secs>  Number of seconds to run the test.\n"
> +		,
> +		appname, appname
> +		);
> +
> +	exit(1);

The library exits after usage is printed, the exit(1) here will not be
reached.

> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	long duration = 0;
> +	int lc;
> +	unsigned int nr_children;
> +	char *error_msg;
> +	char *verbose_str = NULL;
> +	char *duration_str = NULL;
> +
> +	const option_t options[] = {
> +		{"v:", NULL, &verbose_str},
> +		{"d:", NULL, &duration_str},
> +		{NULL, NULL, NULL}
> +	};
> +
> +	verbose = 0;
> +	appname = basename(argv[0]);
> +
> +	error_msg = parse_opts(argc, argv, options, usage);
> +	if (error_msg != NULL)
> +		tst_brkm(TBROK, NULL, "Error parsing command line: %s",
> +			error_msg);
> +
> +	if (verbose_str != NULL)
> +		verbose = str_to_ulong(verbose_str, "-v");
> +
> +	if (duration_str == NULL)
> +		tst_brkm(TBROK, cleanup,
> +			 "No duration specified, nothing to do");
> +
> +	duration = (long) str_to_ulong(duration_str, "-d");
> +
> +	tst_resm(TINFO, "%s: Compiled %s %s", __FILE__, __DATE__, __TIME__);

I would say that this is not very useful information, or is it?

> +	nr_children = setup_children();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++)
> +		test(duration, nr_children);
> +
> +	cleanup();
> +	tst_exit();
> +
> +	/* Should not end up here */
> +	return 1;

Remove the return from here. The tst_exit() is marked as
__attribute__((noreturn)) and the compiler knows that you cannot get
here.

> +}
> diff --git a/utils/.gitignore b/utils/.gitignore
> index a582748..f63e51a 100644
> --- a/utils/.gitignore
> +++ b/utils/.gitignore
> @@ -48,3 +48,6 @@
>  /sctp/func_tests/test_tcp_style_v6
>  /sctp/func_tests/test_timetolive
>  /sctp/func_tests/test_timetolive_v6
> +/count_ticks
> +/list2mask
> +/partrt
> diff --git a/utils/Makefile b/utils/Makefile
> index 1508b35..8c2fc7e 100644
> --- a/utils/Makefile
> +++ b/utils/Makefile
> @@ -22,7 +22,11 @@ top_srcdir		?= ..
>  
>  include $(top_srcdir)/include/mk/env_pre.mk
>  
> +ifneq ($(wildcard rt-tools),)
> +MAKE_TARGETS         += ffsb partrt list2mask count_ticks
> +else
>  MAKE_TARGETS         += ffsb
> +endif

This would be better as:

MAKE_TARGETS += ffsb

ifneq ($(wildcard rt-tools),)
MAKE_TARGETS         += partrt list2mask count_ticks
endif

because otherwise we would need to add any new tool into two places
which is prone to mistakes.

>  FFSBDIR			:= ffsb-6.0-rc2
>  FILTER_OUT_DIRS		:= $(FFSBDIR)
> @@ -35,6 +39,9 @@ $(FFSB): $(abs_srcdir)/$(FFSBDIR)
>  ffsb: $(FFSB)
>  	cp $(FFSB) ffsb
>  
> +partrt list2mask count_ticks:
> +	cp rt-tools/install/bin/$@ $@
> +
>  trunk-all: $(FFSB)
>  
>  trunk-clean:: | ffsb-clean
> diff --git a/utils/rt-tools b/utils/rt-tools
> new file mode 160000
> index 0000000..f75b334
> --- /dev/null
> +++ b/utils/rt-tools
> @@ -0,0 +1 @@
> +Subproject commit f75b334922a2243d0b757c0627c6f1c8440818c0
> -- 
> 1.7.10.4
> 
> 
> ------------------------------------------------------------------------------
> "Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
> Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
> unparalleled scalability from the best Selenium testing platform available.
> Simple to use. Nothing to install. Get started now for free."
> http://p.sf.net/sfu/SauceLabs
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
