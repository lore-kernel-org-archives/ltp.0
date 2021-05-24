From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 24 May 2021 13:25:49 +0200
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for MAY
 2021
Message-ID: <YKuNPWfNNd6DWFHk@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Good news everyone,

the Linux Test Project test suite stable release for *May 2021* has been
released.

Since the last release 364 patches by 50 authors were merged.

NOTABLE CHANGES
===============

* New tests
  - fanotify17 - tests for fanotify() user limits
  - fanotify18 - tests for validating user permissions
  - fanotify19 - tests for unpriviledged events
  - brk02 - test that removes two VMAs on shrink
  - close_range{01,02} - basic close_range() tests
  - rtc02 - /dev/rtc timer tests

* New regression tests
  - bpf_prog05 truncation on 32bit div/mod by zero aka CVE-2021-3444
  - writev03 regression test for d4690f1e1cda 'fix iov_iter_fault_in_readable()'
  - io_uring02 regression test for unsafe handling of the root directory aka CVE-2020-29373

* Increased coverage
  - tmpfs was added for tests that loop over filesystems supported by the SUT
  - fanotify05 added more queue overflow tests and test for unlimited queue

* 52 tests were rewritten to the new library

  - with that we reached important milestone where new library testcases
    outnumber the old library tests for the first time ever

  - Converted tests:
    - chdir01
    - chmod05
    - chown01, chown02, chown03
    - close01, close02
    - get_mempolicy01
    - getgid01, getgid03
    - getpid01, getpid02
    - getppid01, getppid02
    - io_cancel01, io_getevents01
    - mallopt01
    - mmap19
    - netns_netlink
    - pec
    - pidns13
    - reboot01, reboot02
    - sched_getparam01, sched_getparam02, sched_getparam03
    - semctl01, semctl02, semctl03, semctl04, semctl05, semctl07
    - sendfile03, sendfile04, sendfile05, sendfile07
    - setgid01, setgid02, setgid03
    - swapoff01, swapoff02, swapoff03
    - swapon01, swapon02, swapon03
    - time01
    - times01
    - tkill01, tkill02
    - unlinkat01
    - unshare01, unshare02
    - wait01, wait02
    + CAN tests were cleaned up and converted to the new library

* Integrity Measurement Architecture (IMA)
  - new SELinux measurement tests
  + fixes

* Added new library for managing network interfaces over netlink

* Added new library for cgroup discovery and management
  - this is a big leap forward for cgroup testing
  - greatly simplifies testscases as the library gracefully handles v1/v2
    split configurations that are unfortunatelly still common on recent systems
  - first few tests were converted to use the library
  - more tests are in the queue

* Fixed timeouts in shell test library
  - ensure that all child processes are killed on timeout as well
  - runs a cleanup after timeout

* The fuzzy sync library was fixed to yield() on single CPU systems
  - which fixed test timeouts on single CPU systems
  - self tests for the library where implemented where we check that races we
    crafted into the code are triggered correctly by the library even on single
    CPU systems

* Fixed kernel module detection on BusyBox

* Open Posix Testsuite now use $TMPDIR instead of previously hardcoded /tmp

* LTP should now produce reproducible build after a few fixes to the buildsystem and libs

* The documentation generated from the test sources was improved, you can check
  out the generated documentation pages for this release at:

  http://linux-test-project.github.io/metadata/metadata.asciidoctor.html

  Also have a look at a few nice test documentation examples:

  http://linux-test-project.github.io/metadata/metadata.asciidoctor.html#acct02
  http://linux-test-project.github.io/metadata/metadata.asciidoctor.html#bpf_prog05
  http://linux-test-project.github.io/metadata/metadata.asciidoctor.html#semctl09

* We also wrote down a document about the oldest supported kernel and libc, see:
  https://github.com/linux-test-project/ltp/wiki/Supported-kernel,-libc,-toolchain-versions

+ The usual amount of fixes and cleanups

NOTABLE CHANGES IN NETWORK TESTS
================================
brought to you by Petr Vorel

* New tests: UDP encapsulation tests (FOU and GUE)

* Tests converted to new API: CAN tests, multicast stress tests, route-change

* Reduce false positive on tests using tst_netload

+ Other fixes

DOWNLOAD AND LINKS
==================

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20210524

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

git shortlog -s -e -n 20210121..

    84  Petr Vorel <pvorel@suse.cz>
    35  Zhao Gongyi <zhaogongyi@huawei.com>
    35  Richard Palethorpe <rpalethorpe@suse.com>
    26  Xie Ziyao <xieziyao@huawei.com>
    22  Martin Doucha <mdoucha@suse.cz>
    20  Cyril Hrubis <chrubis@suse.cz>
    15  Joerg Vehlow <joerg.vehlow@aox-tech.de>
    13  Li Wang <liwang@redhat.com>
    10  Xiao Yang <yangx.jy@cn.fujitsu.com>
     8  Amir Goldstein <amir73il@gmail.com>
     7  QI Fuli <qi.fuli@fujitsu.com>
     7  Yang Xu <xuyang2018.jy@fujitsu.com>
     6  Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
     5  Alexey Kodanev <alexey.kodanev@oracle.com>
     5  Richard Purdie <richard.purdie@linuxfoundation.org>
     5  Yang Xu <xuyang2018.jy@cn.fujitsu.com>
     4  Jan Stancek <jstancek@redhat.com>
     4  Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
     4  zhanglianjie <zhanglianjie@uniontech.com>
     4  zhao gongyi <zhaogongyi@huawei.com>
     3  Cixi Geng <cixi.geng1@unisoc.com>
     3  Kory Maincent <kory.maincent@bootlin.com>
     3  Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
     3  Shiyang Ruan <ruansy.fnst@fujitsu.com>
     3  Wang Xin <wangxin410@huawei.com>
     2  Palmer Dabbelt via ltp <ltp@lists.linux.it>
     2  Petr Vorel <petr.vorel@gmail.com>
     2  Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
     2  Xiao Yang <yangx.jy@fujitsu.com>
     2  Zenghui Gao <gaozh.jy@fujitsu.com>
     1  Alexander Egorenkov <egorenar@linux.ibm.com>
     1  Ankit Jain <ankitja@vmware.com>
     1  Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
     1  Colin Ian King <colin.king@canonical.com>
     1  Cristian Marussi <cristian.marussi@arm.com>
     1  He Zhe <zhe.he@windriver.com>
     1  Jinghui Huang <huangjh.jy@cn.fujitsu.com>
     1  Jinhui Huang <huangjh.jy@cn.fujitsu.com>
     1  Konstantin Aladyshev <aladyshev22@gmail.com>
     1  Leo Yu-Chi Liang <ycliang@andestech.com>
     1  Liam Howlett <liam.howlett@oracle.com>
     1  QI Fuli <fukuri.sai@gmail.com>
     1  Sharan Turlapati <sturlapati@vmware.com>
     1  Tim Gates <tim.gates@iress.com>
     1  Tree Davies <tdavies@darkphysics.net>
     1  Yann Sionneau via ltp <ltp@lists.linux.it>
     1  dongshijiang <dongshijiang@inspur.com>
     1  ouyangciyan <zintown@qq.com>
     1  sujiaxun <sujiaxun@uniontech.com>
     1  tianyu <tianyu@kylinos.cn>

And also thanks to patch reviewers:

git log 20210121.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r

    151 Cyril Hrubis <chrubis@suse.cz>
    130 Petr Vorel <pvorel@suse.cz>
     70 Li Wang <liwang@redhat.com>
      7 Yang Xu <xuyang2018.jy@fujitsu.com>
      7 Xiao Yang <yangx.jy@cn.fujitsu.com>
      6 Oliver Hartkopp <socketcan@hartkopp.net>
      5 Alexey Kodanev <alexey.kodanev@oracle.com>
      4 Yang Xu <xuyang2018.jy@cn.fujitsu.com>
      4 Martin Doucha <mdoucha@suse.cz>
      4 Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
      4 Jan Stancek <jstancek@redhat.com>
      3 Xiao Yang <yangx.jy@fujitsu.com>
      2 Viresh Kumar <viresh.kumar@linaro.org>
      2 Richard Palethorpe <rpalethorpe@suse.com>
      2 Leo Yu-Chi Liang <ycliang@andestech.com>
      2 Jan Kara <jack@suse.cz>
      1 Liam R. Howlett <Liam.Howlett@Oracle.com>
      1 Jiri Slaby <jirislaby@kernel.org>
      1 Eric Biggers <ebiggers@google.com>
-- 
Cyril Hrubis
chrubis@suse.cz
