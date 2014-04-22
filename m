Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WccvV-0000aJ-7Y
	for ltp-list@lists.sourceforge.net; Tue, 22 Apr 2014 15:48:05 +0000
Date: Tue, 22 Apr 2014 17:47:11 +0200
From: chrubis@suse.cz
Message-ID: <20140422154711.GG3951@rei>
References: <0247700D01F14443B9209F90AD938CC524366845@sestoex05.enea.se>
	<1397663294-60210-1-git-send-email-mats.liljegren@enea.com>
	<1397663294-60210-2-git-send-email-mats.liljegren@enea.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1397663294-60210-2-git-send-email-mats.liljegren@enea.com>
Subject: Re: [LTP] [RFC][PATCH] partrt_nohz_full: Introducing a new test case
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
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +CFLAGS			+= -D_GNU_SOURCE -Werror

We usually define _GNU_SOURCE on the top of the C source and please
remove the -Werror when you are done with testing (these flags should be
controlled by the top level configure only).

> +LDLIBS			+= -lrt
> +
> +MAKE_TARGETS		:= test_partrt_nohz_full
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/partrt/nohz_full/test_partrt_nohz_full.c b/testcases/kernel/partrt/nohz_full/test_partrt_nohz_full.c
> new file mode 100644
> index 0000000..750ab45
> --- /dev/null
> +++ b/testcases/kernel/partrt/nohz_full/test_partrt_nohz_full.c
> @@ -0,0 +1,636 @@
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
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program;  if not, write to the Free Software
> + * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> + */
> +
> +#include <errno.h>
> +#include <string.h>
> +#include <getopt.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <sys/syscall.h>
> +#include <sys/stat.h>
> +#include <stdarg.h>
> +#include <inttypes.h>
> +#include <limits.h>
> +#include <time.h>
> +#include <sched.h>
> +#include <fcntl.h>
> +
> +#include <test.h>
> +#include <safe_macros.h>
> +
> +/* Name of test case */
> +const char *TCID = "nohz_full";

This should be 1:1 with the test binary name. I would wote for naming
both 'partrt_nohz_full' or similar.

> +/* Number of expected "TPASS" */
> +const int TST_TOTAL = 1;

No useless comments like this please (see paragraph 1.4 in Test Writing
Guidelines).

> +/* Used for RT load */
> +volatile int dummy_value;
> +
> +/* When true (1), all children will terminate */
> +static volatile int time_is_up = 0;
> +
> +/* Verbosity level chosen from program command line.
> + * 0 = Only errors and status reported
> + * 1 = Show info() messages
> + * 2 = Request verbose information from called sub-programs
> + * 3 = Request more verbose inormation from called sub-programs.
> + */
> +static int verbose = 0;
> +
> +/* Name of application as given in argv[0] */
> +static const char *appname;
> +
> +/* RT load function prototype */
> +typedef void (child_func)(void);
> +
> +/* Report error a'la printf() and terminate test */
> +#define err(MSG...) tst_brkm(TBROK, cleanup, MSG)
> +
> +/* Report test failed. Will not terminate test execution. */
> +#define fail(MSG...) tst_resm(TFAIL, MSG)
> +
> +/* Report test passed. Will not termiunate test execution. */
> +#define pass(MSG...) tst_resm(TPASS, MSG)
> +
> +/* Print information if verbose has been selected */
> +#define info(MSG...) do { if (verbose > 0) tst_resm(TINFO, MSG); } while (0)

Defining such macros is no no (see paragraph 1.1 in Test Writing
Guidelines).

> +/* Amount of stack for RT load threads */
> +#define STACK_SZ (64 * 1024)
> +
> +static void cleanup(void);
> +
> +/*
> + * Check exit status value.
> + * If any signs of error is found, report error and abort testing.
> + */
> +static void assert_exit_status(const char *cmd, int status)
> +{
> +	if (WIFSIGNALED(status))
> +		err("%s: Child terminated unexpectedly due to signal nr %d",
> +		    cmd,
> +		    WTERMSIG(status));
> +	if (!WIFEXITED(status))
> +		err("%s: Child terminated unexpectedly",
> +		    cmd);
> +	if (WEXITSTATUS(status) != 0)
> +		err("%s: Child exited with exit status %d",
> +		    cmd,
> +		    WEXITSTATUS(status));
> +}
> +
> +/*
> + * Generate a load that is guaranteed not to provoke ticks.
> + */
> +static void load_rt(void)
> +{
> +	while (!time_is_up) {
> +		dummy_value = rand();
> +	}
> +}
> +
> +#define READ 0
> +#define WRITE 1

Use either 0 and 1 or STDIN_FILENO and STDOUT_FILENO

> +/*
> + * Execute command, supplying data to the commands stdin using infp if infp
> + * is non-NULL, and supplying data output from the commands stdout using
> + * outfp if outfp is non-NULL.
> + * The command returns the pid of the command executed.
> + */
> +static pid_t
> +pid_popen(const char *cmd, FILE **infp, FILE **outfp)
> +{
> +	int p_stdin[2], p_stdout[2];
> +	pid_t pid;
> +
> +	if (((infp != NULL) && (pipe(p_stdin) != 0)) ||
> +		((outfp != NULL) && (pipe(p_stdout) != 0)))
> +		err("%s: Failed executing command: pipe(): %s",
> +			cmd, strerror(errno));
> +
> +	pid = fork();
> +
> +	if (pid < 0)
> +		err("%s: Failed executing command: fork(): %s",
> +			cmd, strerror(errno));
> +
> +	if (pid == 0) {
> +		if ((infp != NULL) && (dup2(p_stdin[READ], READ) == -1))
> +			err("%s: pid %lu: dup() to stdin failed: %s",
> +				cmd, (unsigned long) pid, strerror(errno));
> +		if ((outfp != NULL) && (dup2(p_stdout[WRITE], WRITE) == -1))
> +			err("%s: pid %lu: dup() to stdout failed: %s",
> +				cmd, (unsigned long) pid, strerror(errno));
> +
> +		/* Close all unneeded descriptors */
> +		if (
> +			((infp != NULL) &&
> +				((close(p_stdin[READ]) == -1) ||
> +					(close(p_stdin[WRITE]) == -1))) ||
> +			((outfp != NULL) &&
> +				((close(p_stdout[READ]) == -1) ||
> +					(close(p_stdout[WRITE]) == -1))))
> +			err("%s: pid %lu: Child: close() of pipe failed: %s",
> +				cmd, (unsigned long) pid, strerror(errno));

This is too ugly.

> +		execl("/bin/sh", "sh", "-c", cmd, NULL);
> +
> +		err("%s: pid %lu: exec() error: %s",
> +			cmd, (unsigned long) pid, strerror(errno));
> +	}
> +
> +	if (((infp != NULL) && (close(p_stdin[READ]) == -1)) ||
> +		((outfp != NULL) && (close(p_stdout[WRITE]) == -1)))
> +		err("%s: pid %lu: Parent: close() of pipe failed: %s",
> +			cmd, (unsigned long) pid, strerror(errno));
> +
> +	if (infp != NULL) {
> +		(*infp) = fdopen(p_stdin[WRITE], "w");
> +		if (*infp == NULL)
> +			err("%s: pid %lu: fdopen() of stdin failed: %s",
> +				cmd, (unsigned long) pid, strerror(errno));
> +	}
> +
> +	if (outfp != NULL) {
> +		(*outfp) = fdopen(p_stdout[READ], "r");
> +		if (*outfp == NULL)
> +			err("%s: pid %lu: fdopen() of stdout failed: %s",
> +				cmd, (unsigned long) pid, strerror(errno));
> +	}
> +
> +	return pid;
> +}

Did you just reinvented popen() with additional parameters that does not
get used? Because the infp is always NULL. Okay this returns pid that
can be used for wait() but even then the code is too complex for what it
does.

Please do not implement functionality that is not used. This only
overcomplicates testcases and creates code that will break sooner or
later.

> +/*
> + * Wait for a command with given pid to finish, and assert that the command
> + * returned success (0).
> + */
> +static void
> +pid_wait(pid_t pid)
> +{
> +	int status;
> +	char prefix[64];
> +
> +	snprintf(prefix, sizeof (prefix), "Pid %lu", (unsigned long) pid);
> +
> +	if (wait(&status) == -1)
> +		err("%s: wait() failed: %s", prefix, strerror(errno));

Use SAFE_WAIT() instead.

> +	assert_exit_status(prefix, status);

You should pass the pid directly instead of the prefix, see below.

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
> +		err("%s: Not valid printf format, or out of memory", cmd);
> +	va_end(va);
> +
> +	info("%s: Executing", cmd_buf);
> +	pid_wait(pid_popen(cmd_buf, NULL, NULL));
> +	info("%s: Returns success", cmd_buf);
> +
> +	free(cmd_buf);
> +}
> +
> +/*
> + * Execute given command using shell, ensure success (0) is returned.
> + * Only reports errors.
> + */
> +static void shell_silent(const char *cmd, ...)
> +{
> +	char *cmd_buf;
> +	va_list va;
> +
> +	va_start(va, cmd);
> +	if (vasprintf(&cmd_buf, cmd, va) == -1)
> +		err("%s: Not valid printf format, or out of memory", cmd);
> +	va_end(va);
> +
> +	pid_wait(pid_popen(cmd_buf, NULL, NULL));
> +
> +	free(cmd_buf);
> +}

Moreove these two functions are almost duplicate for no good reason.

More generally several shell_* wrappers with sligtly different
parameters polute the code.

> +/*
> + * Convert string to unsigned long.
> + * Error prefix expressed as string.
> + */
> +static unsigned long str_to_ulong(
> +	const char *str,
> +	const char *err_prefix,
> +	int base
> +	)
> +{
> +	char *endptr;
> +	unsigned long val;
> +	val = strtoull(str, &endptr, base);
> +	if (endptr == str)
> +		err("%s: %s: Expected unsigned decimal value", err_prefix, str);
> +	if (*endptr != '\0')
> +		err("%s: %s: Garbage character '%c' found after decimal value",
> +			err_prefix, str, *endptr);
> +
> +	return val;
> +}

Use SAFE_STRTOUL() instead.

> +/*
> + * Call a command using shell.
> + * Command line expressed as va_list.
> + * Returns the command's first line of output.
> + */
> +static char * shell_str(char *dest, int size, const char *cmd, ...)
> +{
> +	int len;
> +	char *cmd_buf;
> +	FILE *file;
> +	pid_t pid;
> +	va_list va;
> +
> +	/* Build command line */
> +	va_start(va, cmd);
> +	if (vasprintf(&cmd_buf, cmd, va) == -1)
> +		err("%s: Not valid printf format, or out of memory", cmd);
> +	va_end(va);
> +
> +	/* Launch command */
> +	pid = pid_popen(cmd_buf, NULL, &file);
> +	info("%s: Executing, pid %lu", cmd_buf, (unsigned long) pid);
> +
> +	/* Read commands stdout */
> +	if (fgets(dest, size, file) == NULL) {
> +		if (feof(file))
> +			err("%s: pid %lu: Expected output from the command, but got nothing",
> +				cmd_buf, (unsigned long) pid);
> +		else
> +			err("%s: pid %lu: Could not read command output: %s",
> +				cmd_buf, (unsigned long) pid, strerror(errno));
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
> +	pid_wait(pid);
> +
> +	info("%s: Returns: %s", cmd_buf, dest);
> +
> +	free(cmd_buf);
> +
> +	return dest;
> +}

Reinventing the wheel?

This could be implemented with just va_args, popen(), fgets() and
pclose(). No need to roll custom functions for the function at all.

> +/*
> + * Call a command using shell.
> + * Command line expressed similar to printf().
> + * Expects that the command outputs a value as the first line of output
> + * from stdout.
> + * Asserts that the command returned success (0).
> + */
> +static unsigned long shell_int(int base, const char *cmd, ...)
> +{
> +	va_list va;
> +	unsigned long val;
> +	char val_str[64];
> +	char *cmd_buf;
> +
> +	va_start(va, cmd);
> +	if (vasprintf(&cmd_buf, cmd, va) == -1)
> +		err("%s: Not valid printf format, or out of memory", cmd);
> +	va_end(va);
> +	val = str_to_ulong(
> +		shell_str(val_str, sizeof (val_str), "%s", cmd), cmd, base);
> +
> +	return val;
> +}

The cmd_buf is not used nor freed, the additional parameters are ignored
etc.

If you are going to write shell_int() by using shell_str you must create
vashell_str() first and build both shell_str and shell_int on the top of
it. But given that this function is used only once I would strongy
sugest to use shell_str() and SAFE_STRTOUL() in the caller.

> +/*
> + * Struct used for synchronization between child_entry() and launch_child().
> + */
> +struct child_params {
> +	/* Function to run */
> +	child_func *func;
> +
> +	/* cpuset partition to run in */
> +	const char *cpu_partition;
> +
> +	/* CPU ID to run on. Must be one of the CPUs in chosen cpu_partition */
> +	int cpu;
> +
> +	/* Written by child_entry() when no more activities that might provoke
> +	 * ticks are expected. */
> +	volatile int started;
> +};
> +
> +/*
> + * Child tramponline function for clone() function.
> + */
> +static int child_entry(void *arg)
> +{
> +	const int child_tid = syscall(SYS_gettid);
> +	struct child_params *child_params = arg;
> +
> +	/* Try to be quiet, or else we might provoke ticks */
> +	shell_silent("partrt move %d %s > /dev/null",
> +		child_tid, child_params->cpu_partition);
> +	if (child_params->cpu >= 0)
> +		shell_silent("taskset -p %#lx %d > /dev/null",
> +			(unsigned long) 1 << child_params->cpu,
> +			child_tid);

You must not call tst_* interface from the child process and by
extension you cannot call shell_silent() from here. See paragraph 2.2.7
in the Test Writing Guidelines.

> +	/* Signal parent that this child now enters RT load function
> +	 * (i.e. no more ticks are expected) */
> +	child_params->started = 1;
> +
> +	child_params->func();
> +	return 0;
> +}
> +
> +/*
> + * Start a new thread executing the given function, on the given cpuset
> + * partition and CPU ID. Note that the CPU ID must be one of the
> + * available CPUs in the cpuset partition.
> + */
> +static void launch_child(
> +	child_func *func,
> +	const char *cpu_partition,
> +	int cpu)

This should fit to one line with less than 80 chars.

> +{
> +	char *stack = SAFE_MALLOC(cleanup, STACK_SZ);
> +	int tid;
> +	struct child_params child_params = {
> +		func, cpu_partition, cpu, 0
> +	};
> +
> +	tid = ltp_clone(CLONE_VM, child_entry, &child_params, STACK_SZ, stack);

Is there any reason to use clone instead of fork() of pthread_create()?

> +	if (tid == -1)
> +		err ("clone(): %s", strerror(errno));
                   ^
		   no spaces between function names and brackets

Have you used checkpatch.pl as suggested in the Test Writing Guidelines?

> +	info("tid %d: Starting %s load on cpu %d", tid, cpu_partition, cpu);
> +	while (!child_params.started)
> +		sched_yield();

I do not like the bussy loop here much (We have a pipe base child parent
synchronization code in the LTP library, see paragraph 2.2.7 in the Test
Writing Guidelines) but given that all the childs do is bussy loop...

> +}
> +
> +/*
> + * Perform test cleanup.
> + * Run both when testing is finished, as well as when test is terminated
> + * abnormally.
> + */
> +static void cleanup(void)
> +{
> +	/* Prohibits multiple execution of cleanup function */
> +	static volatile int cleanup_entered = 0;

This is only one reason why you cannot call tst_ interface from the
child processes. Remove this and fix the rest of code.

> +	pid_t pid;
> +	int status;
> +
> +	if (!__sync_bool_compare_and_swap(&cleanup_entered, 0, 1,
> +						cleanup_entered)) {
> +		info("Cleanup: Already cleaning, exiting");
> +		return;
> +	}
> +
> +	info("Cleanup: Terminating children");
> +
> +	time_is_up = 1;
> +
> +	do {
> +		pid = wait(&status);
> +		if (pid != -1) {
> +			char cmd[64];
> +			snprintf(cmd, sizeof (cmd), "Pid %lu",
> +				 (unsigned long) pid);
> +			assert_exit_status(cmd, status);

                        I do not understand why you pass "Pid %lu"
			string instead of the pid. It's more messy
			this way.

> +			info("Cleanup: %s: Has terminated successfully", cmd);
> +		}
> +	} while (pid != -1);
> +
> +	if (errno != ECHILD)
> +		err("Cleanup: wait() failed: %s", strerror(errno));
> +
> +	info("Cleanup: Done");
> +}
> +
> +static unsigned long determine_nohz_mask(void)
> +{
> +	const char *nohz_cpus_filename = "/sys/fs/cgroup/cpuset/rt/cpuset.cpus";
> +	int file = open(nohz_cpus_filename, O_RDONLY);

        this is not file but fd (file descriptor)

> +	char buf[256] = {0};
> +	char *curr;
> +	int range_first;
> +	int range_last;
> +	unsigned long mask = 0;
> +
> +	if (file == -1)
> +		err("%s: Open failed, have you run 'partrt create'?",
> +			nohz_cpus_filename);
> +
> +	SAFE_READ(cleanup, 0, file, buf, sizeof (buf) - 1);
> +
> +	curr = buf;
> +	while (*curr != '\0') {
> +		char *curr_next;
> +		int bit;
> +
> +		range_first = range_last = strtoull(curr, &curr_next, 10);
> +		if (curr == curr_next)
> +			err("%s: %s: Cannot parse CPU list at %s",
> +				nohz_cpus_filename, buf, curr);
> +		curr = curr_next;
> +		if (*curr == '-') {
> +			curr++;
> +			range_last = strtoull(curr, &curr_next, 10);
> +			if (curr == curr_next)
> +				err("%s: %s: Cannot parse CPU list at %s",
> +					nohz_cpus_filename, buf, curr);
> +			curr = curr_next;
> +		}
> +
> +		/* Set all bits in range */
> +		for (bit = range_first; bit <= range_last; bit++) {
> +			mask |= (1 << bit);
> +		}
> +
> +		if ((*curr == ',') || (*curr == '\n') || (*curr == '\r'))
> +			curr++;

You may simplify this part with fmemopen() and sscanf() (which deals
with whitespaces and conversions).

Once you have FILE * handle it should be as simple as:
(beweare untested)

	while (sscanf("%d-%d[^0-9]*", &range_first, &range_last) == 2) {
		//modify bitmask
	}

> +	}
> +
> +	return mask;
> +}
> +
> +/*
> + * Prepare for test.
> + * Perform CPU partitioning and start RT load.
> + */
> +static int setup(void)
> +{
> +	const unsigned long nohz_mask = determine_nohz_mask();
> +	int bit;
> +	int nr_children = 0;
> +
> +	info("Nohz CPU mask: %#lx", nohz_mask);
> +	tst_require_root(NULL);
> +	for (bit = 0; bit < (int) (sizeof (nohz_mask) * 8); bit++) {
> +		if (nohz_mask & (1lu << bit)) {
> +			launch_child(load_rt, "rt", bit);
> +			nr_children++;
> +		}
> +	}
> +
> +	info("All children started");
> +	return nr_children;
> +}

The setup should exit with tst_brkm(TCONF, "Cpuset not available") in
case cpuset is not compiled in kernel.

The easiest way would be trying access() on suitable sysfs path such as
"/sys/fs/cgroup/cpuset/".

> +/*
> + * Test main function.
> + * Perform tick measurement for the given number of seconds.
> + */
> +static void test(time_t duration)
> +{
> +	uint64_t nr_ticks;
> +	time_t time_finished;
> +	/* If sched_tick_max_deferment patch has been applied, expect that the
> +	 * partitioning has disabled ticks completely. Otherwise, expect
> +	 * 1Hz ticks */
> +	const int expect_0hz =
> +		access("/sys/kernel/debug/sched_tick_max_deferment", F_OK) == 0;

This is a bit hacky, I would just use if (...) instead.

> +	const time_t current_time = time(NULL);
> +
> +	const unsigned int nr_children = setup();

Returning number of children from setup is a bit confusing. Maybe it
would be better to make nr_children global variable or rename the
function.

> +	const uint64_t expected_ticks = expect_0hz ? 0 : duration * nr_children;
> +
> +	shell("count_ticks --cpu rt --start");
> +
> +	time_finished = time(NULL) + duration;
> +
> +	info("Execution started: %s", ctime(&current_time));
> +	info("Execution ends   : %s", ctime(&time_finished));
> +
> +	while (time(NULL) != time_finished);

This is not safe, it should be time(NULL) > time_finished, because
otherwise the test will spin forever if the one exact second was missed,
either due to machine load or because ntp daenom that has updated system
time while this loop was running.

Generally it would be better to use clock_gettime() with
CLOCK_MONOTONIC_RAW that is not subject to adjustements.

> +	nr_ticks = shell_int(0, "count_ticks --cpu rt --batch --end");
> +
> +	if (expect_0hz) {
> +		if (nr_ticks != 0)
> +			fail("Expected no ticks, but got %" PRIu64, nr_ticks);
> +		else
> +			pass("No ticks occurred");
> +	} else {
> +		if (nr_ticks > expected_ticks)
> +			fail("Expected maximum %" PRIu64 " ticks, but got %" PRIu64,
> +			     expected_ticks, nr_ticks);
> +		else
> +			pass("%" PRIu64 " ticks occurred, which was expected",
> +			     nr_ticks);
> +	}
> +
> +	cleanup();
> +	tst_exit();
> +}
> +
> +/*
> + * Show usage text and exit.
> + */
> +static void usage(void)
> +{
> +	printf(
> +		"Usage: %s [options]\n"
> +		"       %s --help\n"
> +		"Test whether a CPU can be isolated and made tickless even under load.\n"
> +		"\n"
> +		"  -h, --help         Display this usage text and exit.\n"
> +		"  -d, --duration     Number of seconds to run the test.\n"
> +		,
> +		appname, appname
> +		);
> +
> +	exit(1);
> +}
> +
> +/*
> + * Program entry
> + */

Again commenting the obvious.

> +int main(int argc, char *argv[])
> +{
> +	time_t duration = 0;
> +	int done = 0;
> +
> +	static const struct option options[] = {
> +		{"verbose", optional_argument, NULL, 'v'},
> +		{"duration", required_argument, NULL, 'd'},
> +		{"help", no_argument, NULL, 'h'}
> +	};
> +
> +	static const char short_options[] = "v::d:p:h";
> +
> +	appname = basename(argv[0]);
> +
> +	while (!done) {
> +		const int opt = getopt_long(
> +			argc, argv, short_options, options, NULL);
> +
> +		switch (opt) {
> +		case -1:
> +			done = 1;
> +			break;
> +		case '?':
> +			err("Use '--help' for usage");
> +		case 'h':
> +			usage();
> +		case 'd':
> +			duration =
> +				(time_t) str_to_ulong(optarg, "--duration", 0);
> +			break;
> +		case 'v':
> +			if (optarg != NULL)
> +				verbose = str_to_ulong(optarg, "--verbose", 0);
> +			else
> +				verbose = 1;
> +			break;
> +		default:
> +			err("-%c: Missing implementation for argument", opt);
> +		}
> +
> +	}

Use LTP parse_opts() instead.

> +	if (duration == 0)
> +		err("No duration specified, nothing to do");
> +
> +	info("%s: Compiled %s %s", __FILE__, __DATE__, __TIME__);
> +	info("This test uses partrt, list2mask and count_ticks tools");
> +	info("These tools can be found at: <https://github.com/OpenEneaLinux/rt-tools>");
> +	info("Make sure you have run 'partrt create <cpumask>' before this test");
> +
> +	test(duration);

You should do the standard test looping here (as explained in the
example testcase in the Test Writing Guidelines).

I.e.
	for (lc = 0; TEST_LOOPING(lc); lc++)
		test(duration);

> +	/* Should not end up here */
> +	return 1;

You should have used cleanup() and tst_exit() here instead.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
