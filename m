From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 15 May 2020 16:44:39 +0200
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for MAY
 2020
Message-ID: <20200515144439.GA3267@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Good news everyone,

the Linux Test Project test suite stable release for *May 2020* has been
released.

Since the last release 327 patches by 26 authors were merged.

NOTABLE CHANGES
===============

* New tests
  - fanotify16: FAN_MODIFY_DIR test
  - ioctl_loop01: LO_FLAGS_AUTOCLEAR and LO_FLAGS_PARTSCAN test
  - ioctl_loop02: LO_FLAGS_READ_ONLY and LOOP_CHANGE_FD test
  - ioctl_loop03: LOOP_CHANGE_FD test with WR mode
  - ioctl_loop04: LOOP_SET_CAPACITY ioctl test
  - ioctl_loop05: LOOP_SET_DIRECT_IO ioctl test
  - ioctl_loop06: LOOP_SET_BLOCK_SIZE error test
  - ioctl_loop07: LOOP_SET/GET_STATUS64 sizelimit field test
  - pipe2_02: test for pipe2 O_CLOEXEC flag
  - pipe2_04: test for pipe2 with/without O_NONBLOCK mode
  - timerfd04: time namespace test
  - timens01: time namespace test
  - clock_gettime03: time namespace test
  - clock_nanosleep03: time namespace test
  - sysinfo03: time namespace test
  - clone301, clone301: clone3() syscall tests
  - bind04: Connection tests for stream-oriented sockets (SOCK_STREAM and SOCK_SEQPACKET)
  - bind05: Connection tests for datagram-oriented sockets (SOCK_DGRAM)
  - fcntl37: add error test for fcntl with F_SETPIPE_SZ
  - openat201, openat202, openat203: openat2() syscall tests
  - open_tree01, open_tree02: open_tree() syscall tests
  - fspick01, fspick02: fspick() syscall tests
  - move_mount01, move_mount02: move_mount() syscall tests
  - fsmount01, fsmount02: fsmount() syscall tests
  - fsconfig01, fsconfig02: fsconfig() syscall tests
  - fsopen01, fsopen02: fsopen() syscall tests
  - pty04: Test data transmission with SLIP line discipline
  - fallocate06: test for misaligned fallocate()
  - io_pgetevents01, io_pgetevents02: io_pgetevents() syscall tests
  - pidfd_open01, pidfd_open02, pidfd_open03: pidfd_open() syscall tests
  - vmsplice04: vmsplice() test with SPLICE_F_NONBLOCK
  - pipe12: add new test for pipe when write bytes > pipe size

* New regression tests
  - pty04: Added SLCAN ldisc and check for CVE-2020-11494
  - setsockopt05: Test for CVE-2017-1000112
  - ptrace09: Test for CVE-2018-8897
  - snd_seq01: Test for CVE-2018-7566
  - bind06: Test for CVE-2018-18559
  - ptrace08: Test for CVE-2018-1000199
  - ioctl_sg01: Test for CVE-2018-1000204
  - sendmsg03: Test for CVE-2017-17712
  - timerfd_settime02: Test for CVE-2017-10661
  - connect02: Test for CVE 2018-9568
               and also for setsockopt(IP_ADDRFORM) kernel bug
               (82c9ae440857 ipv6: fix restrict IPV6_ADDRFORM operation)
  - fanotify15: Add a test case for inode marks
              (f367a62a7cad fanotify: merge duplicate events on parent and child)
  - fanotify09: Check merging of events on directories
             (55bf882c7f13 fanotify: fix merging marks masks with FAN_ONDIR)
  - add_key05: add maxbytes/maxkeys test under unprivileged user
               (a08bf91ce28e "KEYS: allow reaching the keys quotas exactly")
  - pipe13: test for pipe to wake up all readers
            (6551d5c56eb0 "pipe: make sure to wake up everybody when the last reader/writer closes")
  - quotactl07: test for Q_XQTUOTARM
            (3dd4d40b4208 "xfs: Sanity check flags of Q_XQUOTARM call")
  - pty03: test for slip/slcan data race
           (0ace17d568241 "can, slip: Protect tty->disc_data in write_wakeup and close with RCU")

* Increased coverage
  - readv01: new test cases added to the test
  - add_key02: add the "big_key" key type

* First half of time64 tests for 64bit timer syscalls has landed in this
  relese, second half is going to be part of the next one1

* Additional 12 tests were converted to the new test library

* Removed tests
  - epoll2: these depended on Portable Coroutine Library and were not even
            compiled by default for a long time

* Fixes for gcc-10 that enables -fno-common by default

* LTP now supports ARC CPUs

* Skip oversleep checks in timer tests under VM

+ The usual amount of fixes and cleanups.


NOTABLE CHANGES IN NETWORK TESTS
================================
brought to you by Petr Vorel

* New netlink based route change tests

* Fixes
  - nfs: detect disabled UDP
  - rpc: cleanup unused tests
  - detect libtirpc with pkg-config

* Rewrite to new API
  - bind02, socketcall0[2-4], test_1_to_1_initmsg_connect (SCTP)
  - rpcinfo01.sh, rpc01.sh, sendfile01.sh, xinetd_tests.sh

DOWNLOAD AND LINKS
==================

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20200515

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

git shortlog -s -e -n 20200120..

   105  Petr Vorel <pvorel@suse.cz>
    49  Yang Xu <xuyang2018.jy@cn.fujitsu.com>
    38  Viresh Kumar <viresh.kumar@linaro.org>
    35  Martin Doucha <mdoucha@suse.cz>
    33  Cyril Hrubis <chrubis@suse.cz>
    11  Richard Palethorpe <rpalethorpe@suse.com>
    10  Jan Stancek <jstancek@redhat.com>
     6  Li Wang <liwang@redhat.com>
     6  Petr Vorel <petr.vorel@gmail.com>
     5  Amir Goldstein <amir73il@gmail.com>
     4  Jorik Cronenberg <jcronenberg@suse.de>
     4  Zou Wei <zou_wei@huawei.com>
     3  Joerg Vehlow <joerg.vehlow@aox-tech.de>
     3  Po-Hsu Lin <po-hsu.lin@canonical.com>
     2  Alexey Kodanev <alexey.kodanev@oracle.com>
     2  Jozef Pupava <jpupava@suse.com>
     2  Xiao Yang <yangx.jy@cn.fujitsu.com>
     1  Anibal Limon <anibal.limon@linux.intel.com>
     1  Chen Li <chenli@uniontech.com>
     1  Jozef Pupava <jpupava@suse.cz>
     1  Khem Raj <raj.khem@gmail.com>
     1  Ronald Monthero <rmonther@redhat.com>
     1  Sean T Allen <sean@seantallen.com>
     1  Vikas Kumar <vikas.kumar2@arm.com>
     1  Vineet Gupta <Vineet.Gupta1@synopsys.com>
     1  Zorro Lang <zlang@redhat.com>

And also thanks to patch reviewers:

git log 20200120.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r

    137 Cyril Hrubis <chrubis@suse.cz>
     62 Petr Vorel <pvorel@suse.cz>
     56 Li Wang <liwang@redhat.com>
     26 Jan Stancek <jstancek@redhat.com>
     17 Yang Xu <xuyang2018.jy@cn.fujitsu.com>
     12 Alexey Kodanev <alexey.kodanev@oracle.com>
      8 Xiao Yang <ice_yangxiao@163.com>
      4 Martin Doucha <mdoucha@suse.cz>
      4 Jan Kara <jack@suse.cz>
      3 Richard Palethorpe <rpalethorpe@suse.com>
      3 Matthew Bobrowski <mbobrowski@mbobrowski.org>
      2 Xiao Yang <yangx.jy@cn.fujitsu.com>
      2 Viresh Kumar <viresh.kumar@linaro.org>
      1 Yang Xu <xuyang_jy_0410@163.com>
      1 Desnes A. Nunes do Rosario <desnesn@linux.ibm.com>

-- 
Cyril Hrubis
chrubis@suse.cz
