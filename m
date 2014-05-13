Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <mats.liljegren@enea.com>) id 1WkDQz-0006jA-Pk
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 14:11:57 +0000
Received: from sestofw01.enea.se ([192.36.1.252] helo=mx-3.enea.com)
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1WkDQx-00045i-9n
	for ltp-list@lists.sourceforge.net; Tue, 13 May 2014 14:11:57 +0000
From: Mats Liljegren <mats.liljegren@enea.com>
Date: Tue, 13 May 2014 16:11:08 +0200
Message-ID: <1399990269-3383-1-git-send-email-mats.liljegren@enea.com>
In-Reply-To: <1398697619-27372-1-git-send-email-mats.liljegren@enea.com>
References: <1398697619-27372-1-git-send-email-mats.liljegren@enea.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3] partrt_nohz_full: Introducing a new test case
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
To: ltp-list@lists.sourceforge.net
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Kevin Hilman <khilman@linaro.org>

Changes from version 2:
- Added "git submodule init" to README
- Scrapped "verbose" command line parameter entirely, it wasn't implemented
  anyway
- asprintf() replaced with fprintf() in launch_child()
- Introduced cleanup function parameter to assert_exit_status() and shell(),
  making cleanup_entered variable in cleanup() obsolete
- Documented 32 CPU limitation in README. The test code itself has been updated
  to handle all configured CPUs, but the partrt tool does not.
- Simplified tool_available() by using tst_get_path()
- Removed unnecessary exit() and return statements
- Removed rand() to a simple "++" operation as work generator in the RT
  partition. Seemed like rand() could cause ticks for some reason.
- Use SAFE_POPEN() instead of popen().
- Use a 2 second sleep before counting ticks, as a primitive way of emptying
  deferred work in the kernel.

Changes from version 1:
- Style fixes proposed by checkpatch.pl script
- Have rt-tools as a git sub-module instead of requiring it to be cloned
  manually, builds can still be done without checking out rt-tools but
  you can't run partrt_nohz_full test successfully then
- Check if cpuset supported by kernel, TCONF error if not
- Check if rt-tools has been checked out before build, TCONF error if not
- Simplified determined_nohz_mask()
- Use parse_opts() instead of getopt_long() when parsing command line options
- Moved partrt in SUBDIRS so that it is alphabetically correct in
  testcases/kernel/Makefile
- launch_child will now handle moving child thread to the right CPUSET partition
  and CPU, which also eliminates the need for synchronization between parent
  and child
- Children will no longer be able to cause any tst_* calls
- Removed shell_silent(), above changes made it obsolete
- Removed base parameter to str_to_ulong(), will always be 0 now
- setup_children() is now called from main() rather than test() function.
- Macros defining file names
- Use C code for moving children to the right place instead of external
  scripts. Using script invocation from RT partition using NFS mounted file
  system will most likely invoke ticks which can make the test case fail
- Added standard test loop in case reptitions are requested
- Removed atomic operation for cleanup recursion detection, since it is only
  trying to protect recursive invocations from itself
- Using timerfd to wait for timeout instead of busy-waiting
- Removed pid_popen(), pid_wait() and shell_int()
- assert_exit_status() now also checks if status is -1, i.e. command failed
- Moved _GNU_SOURCE macro from Makefile to C file
- Removed -Werror from Makefile
- Removed err(), fail(), pass() and info() macros
- Replaced usage of READ and WRITE macros with STDIN_FILENO and STDOUT_FILENO,
  READ and WRITE macros removed
- Removed some unnecessary comments
- setup() is renamed to setup_children()
- Informational message are made mandatory, verbose only affects output from
  sub-commands, partrt in particular
- Test case name is now partrt_nohz_full

partrt_nohz_full is a test case which checks whether nohz_full mode can achieve
0Hz ticks (if relevant extra patches has been applied) or 1Hz ticks (mainline
kernel).

Appropriate kernel configurations and kernel boot parameters needed are
documented in testcases/kernel/partrt/README.

Mats Liljegren (1):
  partrt_nohz_full: Introducing a new test case

 .gitmodules                                        |    3 +
 README.kernel_config                               |    6 +
 runtest/partrt_nohz_full                           |    1 +
 testcases/kernel/Makefile                          |    1 +
 testcases/kernel/partrt/Makefile                   |   17 +
 testcases/kernel/partrt/README                     |   66 +++
 testcases/kernel/partrt/nohz_full/.gitignore       |    1 +
 testcases/kernel/partrt/nohz_full/Makefile         |   23 +
 .../partrt/nohz_full/test_partrt_nohz_full.c       |  593 ++++++++++++++++++++
 utils/.gitignore                                   |    3 +
 utils/Makefile                                     |    7 +
 utils/rt-tools                                     |    1 +
 12 files changed, 722 insertions(+)
 create mode 100644 runtest/partrt_nohz_full
 create mode 100644 testcases/kernel/partrt/Makefile
 create mode 100644 testcases/kernel/partrt/README
 create mode 100644 testcases/kernel/partrt/nohz_full/.gitignore
 create mode 100644 testcases/kernel/partrt/nohz_full/Makefile
 create mode 100644 testcases/kernel/partrt/nohz_full/test_partrt_nohz_full.c
 create mode 160000 utils/rt-tools

-- 
1.7.10.4


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.
Get unparalleled scalability from the best Selenium testing platform available
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
