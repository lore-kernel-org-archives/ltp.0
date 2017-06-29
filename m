From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 29 Jun 2017 16:27:24 +0200
Subject: [LTP] [PATCH] tutorial: Add a step-by-step C test tutorial
Message-ID: <20170629142724.20004-1-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

A tutorial for writing a complete, if simple test.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

I am hoping this is useful for people relatively new to systems programming as
well as those who just want to know the LTP specifics. I imagine a lot of
people will read it up to a point where they 'get the LTP' then diverge from
it, using the Test Writing Guidlines and existing source code for documentation.

I'm not sure whether to do a more advanced tutorial on multi-threaded tests,
timing functions and triggering race conditions or whether to just update the
Test Writing Guidelines. I think I will leave that until I have had some
feedback.

 doc/c-test-tutorial-simple.txt | 618 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 618 insertions(+)
 create mode 100644 doc/c-test-tutorial-simple.txt

diff --git a/doc/c-test-tutorial-simple.txt b/doc/c-test-tutorial-simple.txt
new file mode 100644
index 000000000..7d8dfd3fc
--- /dev/null
+++ b/doc/c-test-tutorial-simple.txt
@@ -0,0 +1,618 @@
+C Test Case Tutorial
+====================
+
+This is a step-by-step tutorial on writing a simple C LTP test, where topics
+of the LTP and Linux kernel testing will be introduced gradually using
+concrete examples. Most sections will include exercises, some trivial and
+others not so much. If you find an exercise is leading you off at too much of
+a tangent, just leave it for later and move on.
+
+LTP tests can be written in C or Shell script. This tutorial is only for tests
+written in C using the new LTP test API.
+
+0. Assumptions & Feedback
+-------------------------
+
+We assume the reader is familiar with C, Git and common Unix/Linux/GNU tools
+and has some general knowledge of Operating Systems. Experienced Linux
+developers may find it too verbose while people new to system level Linux
+development may find it overwhelming.
+
+Comments and feedback are welcome, please direct them to the mailing list (see
+README).
+
+1. Getting Started
+------------------
+
+Git-clone the main LTP repository as described in the README and change
+directory to the checked-out Git repository. We recommend installing the LTP
+and running one of the tests mentioned in the Quick guide (in the README) to
+ensure you are starting from a good state.
+
+We also recommended cloning the Linux kernel repository for reference, this
+guide will refer to files and directories within the mainline kernel 4.12.
+
+2. Choose a System Call to test
+---------------------------------
+
+We will use the 'statx()' system call, to provide a concrete example of a
+test. At the time of writing there is no test for this call which was
+introduced in Linux kernel version 4.11.
+
+Linux system call specific tests are primarily contained in
+'testcases/kernel/syscalls', but you should also 'git grep' the entire LTP
+repository to check for any existing usages of a system call.
+
+One way to find a system call which is not currently tested by the LTP is to
+look at 'include/linux/syscalls.h' in the kernel tree.
+
+Something the LTP excels at is ensuring bug-fixes are back ported to
+maintenance releases, so targeting a specific regression is another
+option.
+
+2.1. Find an untested System call
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Try to find an untested system call which has a manual page (i.e. `man
+syscall` produces a result). You get extra points for finding one which is not
+tested by the kernel self tests either.
+
+You could also find one with untested parameters or use whatever it is you are
+planning to use the LTP for.
+
+3. Create the test skeleton
+---------------------------
+
+I shall call my test `statx01.c`, by the time you read this that file name
+will probably be taken, so increment the number in the file name as
+appropriate or replace `statx` with the system call chosen in exercise 2.1.
+
+[source,shell]
+------------------------------------------------------------------------------
+$ mkdir testcases/kernel/syscalls/statx
+$ cd testcases/kernel/syscalls/statx
+$ echo statx >> .gitignore
+------------------------------------------------------------------------------
+
+Next open 'statx01.c' and add the following boilerplate. Make sure to change
+the copy right notice to your name/company, correct the test name and minimum
+kernel version if necessary.
+
+[source,c]
+------------------------------------------------------------------------------
+/*
+ * Copyright (c) 2017 Instruction Ignorer <"can't"@be.bothered.com>
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation, either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+/*
+ * Test statx
+ *
+ * All tests should start with a description of what we are testing.
+ */
+
+#include "tst_test.h"
+
+/* The LTP test framework calls this to run the test. You can give it any name
+ * you want, but is is usually called run. */
+static void run(void)
+{
+	/* Declare success */
+	tst_res(TPASS, "Doing hardly anything is easy");
+}
+
+/* The LTP test framework exects this structure to be declared */
+static struct tst_test test = {
+	/* Specify the function which runs the test */
+	.test_all = run,
+	/* Optionally specify the minimum kernel version required */
+	.min_kver = "4.11",
+};
+------------------------------------------------------------------------------
+
+Before continuing we should compile this and check that the basics work. In
+order to compile the test we need a 'Makefile' in the same subdirectory. If
+one already exists, then nothing needs to be done, otherwise add one with the
+following contents.
+
+[source,make]
+------------------------------------------------------------------------------
+# Copyright (c) 2017 Linux Test Project
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License as
+# published by the Free Software Foundation; either version 2 of
+# the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it would be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write the Free Software Foundation,
+# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
+
+------------------------------------------------------------------------------
+
+This will automatically add 'statx01.c' as a build target producing a
+'statx01' executable. Unless you have heavily deviated from the tutorial, and
+probably need to change 'top_srcdir', nothing else needs to be done.
+
+Assuming you are in the test's subdirectory 'testcases/kernel/syscalls/statx',
+do
+
+[source,shell]
+--------------------------------------------------------------------------------
+$ make
+$ ./statx01
+--------------------------------------------------------------------------------
+
+This should build the test and then run it. However, even though the test is
+in the syscalls directory it won't be automatically ran as part of the
+syscall's test group (remember './runltp -f syscalls' from the README?). For
+this we need to add it to the 'runtest' file. So open 'runtest/statx' and add
+the lines starting with a '+'.
+
+[source,diff]
+--------------------------------------------------------------------------------
+ statvfs01 statvfs01
+ statvfs02 statvfs02
+ 
++statx01 statx01
++
+ stime01 stime01
+ stime02 stime02
+ 
+--------------------------------------------------------------------------------
+
+3.1 Report TCONF instead of TPASS
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Maybe the test should report "TCONF: Not implemented" instead or perhaps
+'TBROK'. Try changing it do so (see doc/test-writing-guidelines.txt).
+
+3.2 Check Git ignores the executable
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Create a new branch and commit the new files, but makes sure the 'statx01'
+executable is ignored.
+
+3.3 Run checkpatch.pl on the source file
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+The LTP follows the Linux style guidelines where possible. Check what happens
+if you run 'kernel/linux/scripts/checkpatch.pl --no-tree -f statx01.c' and
+correct any style issues.
+
+3.4 Install the LTP and run the test with runtest
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Run 'statx01' on its own; similar to the 'madvise' tests in the README.
+
+4. Call the system call
+-----------------------
+
+At the time of writing 'statx' has no glibc wrapper. It is also fairly common
+for a distribution's libc version to be older than its kernel or it may use a
+cut down C library in comparison to the GNU one. So we must call 'statx()'
+using the general 'syscall()' interface.
+
+The LTP contains a library for dealing with 'syscall' interface, which is
+located in 'testcases/kernel/include'. System call numbers are listed against
+the relevant call in the '*.in' files (e.g. 'x86_64.in') which are used to
+generate 'linux_syscall_numbers.h', which is the header you should include. On
+rare occasions you may find the system call number is missing from the '*.in'
+files and will need to add it.
+
+System call numbers vary between architectures, hence why there are multiple
+'*.in' files for each architecture. You can find the various values for the
+'statx' syscall across a number of 'uinstd.h' files in the Linux kernel.
+
+Note that we don't use the syscall value available in
+'/usr/include/linux/uinstd.h' because the kernel might be much newer than the
+user land libraries.
+
+For 'statx' we had to add 'statx 332' to 'testcases/kernel/include/x86_64.in',
+'statx 383' to 'testcases/kernel/include/powerpc.in', etc.  Now lets look at
+the code, which I will explain in more detail further down.
+
+[source,c]
+--------------------------------------------------------------------------------
+/*
+ * Test statx
+ *
+ * Check if statx exists and what error code it returns when we give it dodgy
+ * data.
+ */
+
+/* Provides __u* integer type casts. It is a safe bet these exist on any Linux
+ * distro... right? */
+#include <linux/types.h>
+#include "tst_test.h"
+
+/* This header is not located in the normal include directory, but we don't
+ * need to worry about that. It includes the tst_syscall function and the
+ * __NR_statx macro.
+ */
+#include "linux_syscall_numbers.h"
+
+/* The following structs are copied from include/uapi/linux/stat.h in the
+ * kernel tree. As mentioned previously, we can't rely on our distro's copy of
+ * stat.h to be up to date. */
+struct statx_timestamp {
+	__s64	tv_sec;
+	__u32	tv_nsec;
+	__s32	__reserved;
+};
+
+struct statx {
+	__u32	stx_mask;
+	__u32	stx_blksize;
+	__u64	stx_attributes;
+	__u32	stx_nlink;
+	__u32	stx_uid;
+	__u32	stx_gid;
+	__u16	stx_mode;
+	__u16	__spare0[1];
+	__u64	stx_ino;
+	__u64	stx_size;
+	__u64	stx_blocks;
+	__u64	stx_attributes_mask;
+	struct statx_timestamp	stx_atime;
+	struct statx_timestamp	stx_btime;
+	struct statx_timestamp	stx_ctime;
+	struct statx_timestamp	stx_mtime;
+	__u32	stx_rdev_major;
+	__u32	stx_rdev_minor;
+	__u32	stx_dev_major;
+	__u32	stx_dev_minor;
+	__u64	__spare2[14];
+};
+
+/* Our wrapper for the statx syscall. It is not necessary to create a wrapper,
+ * but statx has a lot of arguments and presumably we are going to call it a
+ * lot. Eventually this wrapper should be moved into the LTP library and a
+ * SAFE_STATX macro created. */
+static int sys_statx(int dirfd, const char *pathname, int flags,
+		     unsigned int mask, struct statx *statxbuf)
+{
+	return tst_syscall(__NR_statx, dirfd, pathname, flags, mask, statxbuf);
+}
+
+static void run(void)
+{
+	struct statx statxbuf = { 0 };
+
+	/* According to the man page this should fail with EFAULT because the
+	 * path string is NULL. */
+	TEST(sys_statx(0, NULL, 0, 0, &statxbuf));
+
+	/* The TEST macro just runs statx and sets TEST_RETURN and TEST_ERRNO */
+	if (TEST_RETURN == 0)
+		tst_res(TFAIL, "statx thinks it can stat NULL");
+	else if (TEST_ERRNO == EFAULT)
+		tst_res(TPASS, "statx set errno to EFAULT as expected");
+	else
+		tst_res(TFAIL | TERRNO, "statx set errno to some unexpected value");
+	/* Setting TERRNO will cause a description of the current errno (not
+	 * TEST_ERRNO) value to be printed. */
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.min_kver = "4.11",
+};
+--------------------------------------------------------------------------------
+
+Most of the test is now boiler plate for calling 'statx'. If we try to run the
+test on a system where 'statx' does not exist, then 'tst_syscall' will cause
+it to fail gracefully with 'TCONF'. Where 'TCONF' indicates the test is not
+applicable to our configuration.
+
+The function 'tst_syscall' calls 'tst_brk(TCONF,...)' on failure. 'tst_brk'
+causes the test to exit immediately, which prevents any further test code from
+being run.
+
+Luckily for us we don't need to worry about the case where 'struct statx' is
+already present on the system. If, for some reason, our test had
+'/usr/include/linux/stat.h' somewhere in its include chain we would have to
+modify the 'autotools/m4' scripts to detect the struct's presence and only
+define it if it is missing. Well actually we could just look for the
+'STATX_TYPE' macro which was added at the same time as the structure, but you
+should be aware that there is a system in place for handling occasionally
+missing structs and functions.
+
+4.1 What are the differences between tst_brk and tst_res?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+See 'include/tst_test.h' and the test writing guide. Also what do they have in
+common?
+
+5. Setup, Cleanup and files
+---------------------------
+
+We can make the two following observations; 'statx' operates on files (or file
+like objects) and 'tst_brk' causes 'run' to return early. It makes sense for
+us to create a file for 'statx' to operate on, but we also have to be careful
+not to create a mess. If we were to create this file at the beginning of 'run'
+and delete it at the end. Then we would have to ensure 'tst_brk' is never
+called, so that the file is cleaned up.
+
+Fortunately, like most test libraries, we have setup and cleanup (teardown)
+callbacks. 'setup' is called once before 'run' and 'cleanup' is called once
+afterwards. Note that 'run' itself can be called multiple times by the test
+harness, but that 'setup' and 'cleanup' are only called once.
+
+If either your code, a 'SAFE_*' macro or a library function such as
+'tst_syscall' call 'tst_brk', then 'run' will exit immediately and the
+'cleanup' function is then called. Once 'cleanup' is completed, the test
+executable will then exit altogether abandoning any remaining iterations of
+'run'.
+
+Also there is the issue of where we should create the file. Simply put, we
+just create it in the current working directory and let the LTP test harness
+handle where that should be by setting '.needs_tmpdir = 1'.
+
+[source,c]
+--------------------------------------------------------------------------------
+/*
+ * Test statx
+ *
+ * Check if statx exists and what error code it returns when we give it dodgy
+ * data. Then stat a file and check it returns success.
+ */
+
+#include <fcntl.h>
+#include <linux/types.h>
+#include "tst_test.h"
+#include "linux_syscall_numbers.h"
+
+/* fcntl.h may or may not contain a definition of this. */
+#ifndef AT_FDCWD
+#define AT_FDCWD -100
+#endif
+
+#define FNAME "This string is the name of the file we will stat"
+#define STATX_BASIC_STATS 0x000007ffU
+
+/*************** statx structure and wrapper goes here ! ***************/
+
+/* This is called once before run (sometimes run is called multiple times
+ * which we will explore later). See the tst_test struct at the bottom.*/
+static void setup(void)
+{
+	/* Create the file FNAME in the current directory. 0777 is the file
+	 * mode and the final argument would be the time stamps we want to
+	 * use. There are many SAFE_* macros in the LTP library.*/
+	SAFE_TOUCH(FNAME, 0777, NULL);
+}
+
+/* This is called when the test exits, whether that is due to a tst_brk call,
+ * timeout or run() finishes normally. */
+static void cleanup(void)
+{
+	/* Delete the file even though it will be in a temporary
+	 * directory. This is not just me being anal, but necessary to ensure
+	 * the temporary directory is removed correctly. */
+	SAFE_UNLINK(FNAME);
+}
+
+static void run(void)
+{
+	struct statx statxbuf = { 0 };
+
+	TEST(sys_statx(0, NULL, 0, 0, &statxbuf));
+	if (TEST_RETURN == 0)
+		tst_res(TFAIL, "statx thinks it can stat NULL");
+	else if (TEST_ERRNO == EFAULT)
+		tst_res(TPASS, "statx set errno to EFAULT as expected");
+	else
+		tst_res(TFAIL | TERRNO, "statx set errno to some unexpected value");
+
+	/* Try to stat the file created by setup(). Clearly this isn't a very
+	 * good test. */
+	TEST(sys_statx(AT_FDCWD, FNAME, 0, STATX_BASIC_STATS, &statxbuf));
+	if (TEST_RETURN == 0)
+		tst_res(TPASS, "It returned zero so it must have worked!");
+	else
+		tst_res(TFAIL | TERRNO, "statx can not stat a basic file");
+}
+
+/* As with run/test_all, the setup and cleanup callbacks are explicitly set here so you
+ * can call them what you want. */
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.min_kver = "4.11",
+	/* This indicates that the test executable's working directory will be
+	 * temporary directory where we can create and delete files during the
+	 * test. */
+	.needs_tmpdir = 1
+};
+--------------------------------------------------------------------------------
+
+If you have begun to explore the LTP library headers or older tests then you
+may have come across functions from the old API such as 'tst_brkm'. The first
+argument of 'tst_brkm' is a pointer to a cleanup function and it does not use
+the 'tst_test' structure. The old API is being phased out, so you should not
+use these functions.
+
+So far the 'statx' test and its 'cleanup' function are very simple. Our
+example doesn't answer the question "what happens if part of the cleanup
+fails?". We can answer this by modifying the test to call 'statx' on a
+symbolic link instead of the original file. This naturally expands our 'setup'
+and 'cleanup' callbacks. I will just include the relevant parts below.
+
+[source,c]
+--------------------------------------------------------------------------------
+#define SNAME "This is an additional name for the file"
+
+...
+
+static void setup(void)
+{
+	SAFE_TOUCH(FNAME, 0777, NULL);
+	SAFE_SYMLINK(FNAME, SNAME);
+}
+
+static void cleanup(void)
+{
+	SAFE_UNLINK(SNAME);
+	SAFE_UNLINK(FNAME);
+}
+
+static void run(void)
+{
+        ...
+	
+	TEST(sys_statx(AT_FDCWD, SNAME, 0, STATX_BASIC_STATS, &statxbuf));
+	if (TEST_RETURN == 0)
+		tst_res(TPASS, "It returned zero so it must have worked!");
+	else
+		tst_res(TFAIL | TERRNO, "statx can not stat a basic file");
+}
+--------------------------------------------------------------------------------
+
+If 'SAFE_TOUCH' succeeds, but 'SAFE_SYMLINK' fails, then cleanup will still be
+completed correctly. The behavior of 'tst_brk' is different inside of the
+'cleanup' function. Instead of exiting the callback, it merely prints a
+warning (TWARN) and returns to the cleanup method.
+
+However this code is not following best practices. Generally you should avoid
+creating lots of unnecessary warning messages by checking if a resource exits
+before attempting to clean it up. If 'SAFE_TOUCH' or 'SAFE_SYMLINK' failed, we
+will already have an error message for that. It is not necessary to check if
+the file actually exists before calling 'SAFE_UNLINK', instead we can use a
+heuristic, such as checking if a variable has been set (see the mount example
+in 2.2.1 of the test writing guide).
+
+5.1 Change the cleanup function to follow best practices
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Best practices being to avoid cleaning up a file which will definitely not
+exist.
+
+5.2 Modify the statx test to do something useful
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+For example, check if it reports the correct creation or modification times.
+
+6. Split the test
+-----------------
+
+In our current test, we have essentially rolled two different test cases into
+one. Firstly we check if an error is returned when bad arguments are provided
+and secondly we check what happens when we stat an actual file. Occasionally
+it makes sense to call 'tst_res' multiple times in a single test case because
+we are checking different properties of the same result, but here we are
+clearly testing two different scenarios.
+
+So we should split the test in two. One obvious way to do this is to create
+'statx02.c', but that seems like overkill in order to separate two simple test
+cases. So, for now at least, we are going to do it a different way.
+
+[source,c]
+--------------------------------------------------------------------------------
+...
+
+static void run_stat_null(void)
+{
+	struct statx statxbuf = { 0 };
+
+	TEST(sys_statx(0, NULL, 0, 0, &statxbuf));
+	if (TEST_RETURN == 0)
+		tst_res(TFAIL, "statx thinks it can stat NULL");
+	else if (TEST_ERRNO == EFAULT)
+		tst_res(TPASS, "statx set errno to EFAULT as expected");
+	else
+		tst_res(TFAIL | TERRNO, "statx set errno to some unexpected value");
+}
+
+static void run_stat_symlink(void)
+{
+	struct statx statxbuf = { 0 };
+
+	TEST(sys_statx(AT_FDCWD, SNAME, 0, STATX_BASIC_STATS, &statxbuf));
+	if (TEST_RETURN == 0)
+		tst_res(TPASS, "It returned zero so it must have worked!");
+	else
+		tst_res(TFAIL | TERRNO, "statx can not stat a basic file");
+}
+
+/* The function signature has change to accept a test index. */
+static void run(unsigned int i)
+{
+	switch(i) {
+	case 0: run_stat_null();
+	case 1: run_stat_symlink();
+	}
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	/* We have switched from .test_all to .test */
+	.test = run,
+	/* The test count */
+	.tcnt = 2,
+	.min_kver = "4.11",
+	.needs_tmpdir = 1
+};
+--------------------------------------------------------------------------------
+
+So we have used an alternative form of the 'test' or 'run' callback which
+accepts an index. Some tests use this index with an array of parameters and
+expected return values. Others do something similar to the above. The index
+can be used how you want so long as each iteration calls 'tst_res' in a
+meaningful way.
+
+If an iteration fails to return a result (i.e. call 'tst_res' with a value
+other than 'TINFO') then the test harness will report 'TBROK' and print the
+iteration which failed. This prevents a scenario in your test from silently
+failing due to some faulty logic.
+
+6.1 What is wrong with the switch statement?
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Were you paying attention? Also see the output of checkpatch.pl.
+
+7. Final notes
+--------------
+
+Hopefully you can now grasp the structure of an LTP test and have some idea of
+what is available in the LTP test library. There are a vast number of library
+functions available (mainly located in include and lib), some of which are
+documented in the test writing guidelines and many which are not.
+
+One important topic which has not been covered by this tutorial, is
+multi-process or multi-threaded testing. The LTP library functions work inside
+child processes and threads, but their semantics change slightly. There are
+also various helper functions for synchronising and forking processes. For
+more information see the Test Writing Guidelines (either on the wiki or in
+./doc), in particular sections 2.2.7 to 2.2.10 and 2.2.13.
+
+When it comes time to submit a test, the preferred way to do it is on the
+mailing list although you can also use GitHub. The LTP follows similar rules
+to the kernel for formatting and submitting patches. Generally speaking the
+review cycle is easier for small patches, so try to make small changes or
+additions which can be accepted into the LTP more quickly.
-- 
2.13.1

