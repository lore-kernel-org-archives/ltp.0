From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Sep 2020 17:58:20 +0200
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 SEPTEMBER 2020
Message-ID: <20200930155820.GE12097@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Good news everyone,

the Linux Test Project test suite stable release for *September 2020* has been
released.

Since the last release 357 patches by 38 authors were merged.

NOTABLE CHANGES
===============

* New tests
  - mmap17 for MAP_FIXED_NOREPLACE
  - semctl08 to verify the _time_high fields
  - shmctl06 to verify the _time_high fields
  - msgctl05 to verify the _time_high fields
  - clock_gettime04 to check consistency during successive timer readings
  - mincore03 test for anonymous mappings
  - io_uring01 basic test for asynchronous read()
  - ioctl09 test for BLKRRPART
  - mincore04 test for pages faulted in child
  - clock_settime03 test if timers works fine when clocks overflows 32bit timestamp
  - msgget04 for /proc/sys/kernel/msg_next_id
  - msgget05 for /proc/sys/kernel/msg_next_id
  - send02 for send() with MSG_MORE flag
  - msgrcv03 for MSG_COPY flag
  - msgrcv07 for MSG_COPY flag
  - fcntl38 for F_SETSIG and F_NOTIFY
  - shmctl03 for IPC_INFO flag
  - shmctl07 for SHM_LOCK and SHM_UNLOCK flags
  - shmctl08 for IPC_SET flag
  - mmap18 for MAP_GROWSDOWN flag
  - ima_keys.sh, ima_kexec.sh new IMA tests + examples of required policies

* New regression tests
  - setsockopt07 race condition between packet_set_ring() and tp_reserve() aka CVE-2017-1000111
  - fanotify10 for 2f02fd3fa13e (fanotify: fix ignore mask logic for events on child and on dir)
  - thp04 Huge Dirty Cow aka CVE-2017-1000405
  - pty05 race between flush_tx_queue() and n_hdlc_send_frames() aka CVE-2017-2636
  - adjtimex03 4-byte kernel data leak via adjtimex CVE-2018-11508
  - af_alg07 use-after-free in sockfs_setattr() aka CVE-2019-8912
  - bpf_prog04 bug in 32bit eBFP verifier aka CVE-2018-18445
  - timer_settime03 overflow of posix timer overrun counter aka CVE-2018-12896

* Increased coverage
  - ioctl_loop01 added LO_FLAGS_AUTOCLEAR flag coverage
  - timer_gettime01 added timer_gettime64() coverage
  - timer_settime{01,02} added timer_settime64() coverage
  - timerfd{01,04} added timerfd_gettime64() coverage
  - timerfd_gettime01 added timerfd_gettime64() coverage
  - timerfd_settime{01,02} added timerfd_gettime64() coverage
  - sched_rr_get_interval{01,02,03} added sched_rr_get_interval_time64() coverage
  - sched_rr_get_interval01 checks the return value against /proc/sys/kernel/sched_rr_timeslice_ms
  - io_pgetevents{01,02} added io_pgetevents_time64() coverage
  - ioctl_loop02 added LOOP_CONFIGURE test for LO_FLAGS_READ_ONLY
  - pidfd_open01 added check for CLOEXEC handling
  - rt_sigtimedwait01 added rt_sigtimedwait_time64() coverage
  - futex_cmp_requeue{01,02} added futex_time64() coverage
  - futex_wait{01,02,03,04} added futex_time64() coverage
  - futex_wait_bitset01 added futex_time64() coverage
  - mq_timedreceive01 added mq_timedreceive64() coverage
  - mq_timedsend01 added mq_timedsend64() coverage
  - sendmmsg01 added sys_recvmmsg64() coverage
  - ppoll01 added ppoll_time64 coverage
  - ioctl_loop06 added LOOP_CONFIGURE test for block_size
  - select04 added pselect6_time64() coverage
  - utimensat01 added utimensat_time64() coverage
  - msgsnd01 added check for msg_lspid and msg_stime
  - msgrcv01 added check for msg_lrpid and msg_rtime
  - msgrcv07 added more msgtyp tests
  - semop{01,02,03} added semtimedop() and semtimedop_time64() coverage
  - fanotify{14,16} added FAN_REPORT_DFID_NAME and FAN_REPORT_* coverage
  - fanotify09 added cases with subdirectory marks
  - fanotify10 added cets for FAN_REPORT_NAME and ignore mask
  - ioctl_loop07 added LOOP_CONFIGURE test for lo_sizelimit

* As you can see this release got the rest of the the 64bit timestamp
  testcases, 64bit timestamp syscalls should be reasonably covered now

* The quickhit runtest file was removed and replaced for quick integration
  tests with smoketest runtest file

* Additional 26 tests were converted to the new test library, significant part
  of these were cleaned up and rewritten SystemV IPC testcases

* LTP now includes VDSO parser and explicitly tests timer VDSO functions

* The backing files for a loop devices are now created by fallocate(), if
  possible, which speeds up loop device based tests quite a bit

* The build system was tweaked to produce much cleaner output,
  verbose output could be enabled by setting an environment variable V=1

+ The usual amount of fixes and cleanups.


NOTABLE CHANGES IN NETWORK TESTS
================================
brought to you by Petr Vorel

* remove RSH support (for legacy tests use SSH by default in $LTP_RSH)

* removed rsh, rcp, rlogin tests

* NFS: detect disabled UDP, expect it being disabled on v5.6+
       (NFS_DISABLE_UDP_SUPPORT is default y)

* TST_NET_RHOST_RUN_DEBUG=1 enables debugging

+ various fixes and updated docs

DOWNLOAD AND LINKS
==================

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20200930

The project pages as well as GIT repository are hosted on GitHub:

https://github.com/linux-test-project/ltp
http://linux-test-project.github.io/

If you ever wondered how to write a LTP testcase, don't miss our developer
documentation at:

https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial
https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
https://github.com/linux-test-project/ltp/wiki/BuildSystem

Patches, new tests, bugs, comments or questions should go to to our mailing
list at ltp@lists.linux.it.


CREDITS
=======

Many thanks to the people contributing to this release:

git shortlog -s -e -n 20200515..

    70  Petr Vorel <pvorel@suse.cz>
    66  Viresh Kumar <viresh.kumar@linaro.org>
    37  Cyril Hrubis <chrubis@suse.cz>
    35  Yang Xu <xuyang2018.jy@cn.fujitsu.com>
    33  Martin Doucha <mdoucha@suse.cz>
    19  Li Wang <liwang@redhat.com>
    13  Jan Stancek <jstancek@redhat.com>
    11  Amir Goldstein <amir73il@gmail.com>
    10  Xiao Yang <yangx.jy@cn.fujitsu.com>
     6  Richard Palethorpe <rpalethorpe@suse.com>
     5  Alexey Kodanev <alexey.kodanev@oracle.com>
     5  Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
     4  Filip Bozuta <Filip.Bozuta@syrmia.com>
     4  Lachlan Sneff <t-josne@linux.microsoft.com>
     4  Po-Hsu Lin <po-hsu.lin@canonical.com>
     3  Erico Nunes <ernunes@redhat.com>
     3  Petr Vorel <petr.vorel@gmail.com>
     3  Yixin Zhang <yixin.zhang@intel.com>
     2  Eric Biggers <ebiggers@google.com>
     2  Khem Raj <raj.khem@gmail.com>
     2  Michal Kowalczyk <mkow@invisiblethingslab.com>
     2  Shwetha Subramanian <shwetha@zilogic.com>
     2  Vikas Kumar <vikas.kumar2@arm.com>
     2  Yuan Gao <aiden.gaoyuan@gmail.com>
     1  Bird, Tim <Tim.Bird@sony.com>
     1  Fabrice Fontaine <fontaine.fabrice@gmail.com>
     1  Harish <harish@linux.ibm.com>
     1  He Zhe <zhe.he@windriver.com>
     1  Kushal Chand <kushalchand@zilogic.com>
     1  Nirav Parmar <niravparmar@zilogic.com>
     1  Qais Yousef <qais.yousef@arm.com>
     1  Qian Cai <cai@redhat.com>
     1  Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
     1  Tree Davies <tdavies@darkphysics.net>
     1  Vishwajith-K <31800616+Vishwajith-K@users.noreply.github.com>
     1  Vitaly Chikunov <vt@altlinux.org>
     1  aidengao <aidengao@google.com>
     1  pravin <pravinraghul@zilogic.com>


And also thanks to patch reviewers:

git log 20200515.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r

    136 Cyril Hrubis <chrubis@suse.cz>
     72 Petr Vorel <pvorel@suse.cz>
     48 Li Wang <liwang@redhat.com>
     22 Jan Stancek <jstancek@redhat.com>
     11 Xiao Yang <yangx.jy@cn.fujitsu.com>
      9 Yang Xu <xuyang2018.jy@cn.fujitsu.com>
      9 Alexey Kodanev <alexey.kodanev@oracle.com>
      8 Martin Doucha <mdoucha@suse.cz>
      7 Mimi Zohar <zohar@linux.ibm.com>
      5 Vijay Kumar B. <vijaykumar@zilogic.com>
      4 Viresh Kumar <viresh.kumar@linaro.org>
      4 Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
      2 Tim Bird <tim.bird@sony.com>
      2 Petr Vorel <petr.vorel@gmail.com>
      2 Arnd Bergmann <arnd@arndb.de>
      2 Amir Goldstein <amir73il@gmail.com>
      1 Richard Palethorpe <rpalethorpe@suse.com>
      1 Jan Kara <jack@suse.cz>
      1 Christian Brauner <christian.brauner@ubuntu.com>

-- 
Cyril Hrubis
chrubis@suse.cz
