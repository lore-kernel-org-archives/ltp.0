Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA814CA5FA5
	for <ltp@archiver.kernel.org>; Thu,  1 Oct 2026 08:02:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 421233E4F05
	for <ltp@archiver.kernel.org>; Thu,  1 Oct 2026 10:02:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D23983E182A
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 10:02:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 99C94200CEC
 for <ltp@lists.linux.it>; Thu,  1 Oct 2026 10:01:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EEA5D21DE1;
 Thu,  1 Oct 2026 08:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790841714; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vw7lJ7nkh5P4ecvDfyD3Gih1JedgDjQSFuIKWSko4sY=;
 b=YwmdfPvyYkSs4WfKlLQ96xBHCgT3XnkEoN7g3B23Xf4Vq4+UKSeRVYpoitUK0PjzvTiOzv
 6MZeq3ZK19l0KAVPShxkVX5eoS+FOPSVNm0mIGGJCPHx+tKWRFInsGUaTMa+bWLY2Tk+Ky
 uJ8JcKsavjO3u3Oj1ZsvulO+ESI/QOg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790841714;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vw7lJ7nkh5P4ecvDfyD3Gih1JedgDjQSFuIKWSko4sY=;
 b=ySRSpeYqYJNU7cYLZQPnwYfEQb/i6NAtTUiCOniAQDkE82MC35/UoSkEt/VYLFRSgED4BV
 YTMb6cXIMnyD1jDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790841708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vw7lJ7nkh5P4ecvDfyD3Gih1JedgDjQSFuIKWSko4sY=;
 b=ozsWyRNSagvwrt6jusLYtQT4/cEj6qcFjCf04rQPjMqspi19ItObTsgLhTm435bAFM/2io
 dxYpObBA4W14RQZwp1Y6OtXuAESES6pDDNEmB2mm5NQtGebwN7emhxHFu9dZzzynEMFqQG
 VsO6e3l/mOz90LpcW1qvT0DhUKHecIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790841708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vw7lJ7nkh5P4ecvDfyD3Gih1JedgDjQSFuIKWSko4sY=;
 b=6S+XirGV9/kSLI5pMJRLIvIwxxfe63M0rpAusmLFIW8mbXbbewZudnWQQ8PAMuiHsY3mSp
 tCZk+79km1VLfrDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B35BB136A5;
 Thu,  1 Oct 2026 08:01:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3qNKI2wTvmq8RgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 01 Oct 2026 08:01:48 +0000
Date: Thu, 1 Oct 2026 10:02:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it, linux-kernel@vger.kernel.org,
 libc-alpha@sourceware.org, valgrind-developers@lists.sourceforge.net
Message-ID: <ar4TexudzfhsKBwT@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 SEPTEMBER 2026
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
Cc: lwn@lwn.net, akpm@linux-foundation.org, torvalds@linux-foundation.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Good news everyone,

the Linux Test Project test suite stable release for *September 2026* has b=
een
released.

Since the last release 382 patches by 41 authors were merged.

Patch review is what most of the projects struggle with and LTP is no
different. If you can spare some effort helping with the patch review is mo=
re
than welcomed.

NOTABLE CHANGES
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

* New CVE regression tests
  - ghostlock aka CVE-2026-43499
    3bfdc63936dd ("rtmutex: Use waiter::task instead of current in remove_w=
aiter()")

  - sctphantom aka CVE-2026-64564
    9b2854f86f0b ("sctp: don't free the ASCONF's own transport in DEL-IP pr=
ocessing")

  - refluxfs aka CVE-2026-64600
    2f4acd0fcd86 ("xfs: resample the data fork mapping after cycling ILOCK")

  - setsockopt11 aka CVE-2026-53362
    736b380e28d0 ("ipv6: account for fraggap on the paged allocation path")

  - cve-2026-46331
    899ee91156e5 ("net/sched: fix pedit partial COW leading to page cache c=
orruption")

  - io_uring04 aka CVE-2026-43494 aka PinTheft
    e17492979319 ("net/rds: reset op_nents when zerocopy page pin fails")

* New tests
  - coredump{01,02} - tests core_pattern and does sanity check on coredump =
file
  - swapon04 - tests swapon discard flags
  - hugemmap41 - test that hugepages can be accessed by ptrace() PKEDATA an=
d PEEKDATA
  - mremap09 - tests that mremap() fails with ENOMEM when existing mapping
    cannot be expanded
  - hugemmap36 - regression test for truncating hugepage files above 4GB of=
fset
                 on 32bit systems
  - hugemmap37 - tests that kernel fails hugepage mmap operations that stra=
ddle
                 TASK_SIZE boundary
  - hugemmap38 - regression test that verifies that kernel properly maintai=
ns
                 hugepage reservation accounting
  - connect03 - test for EPROTOTYPE and EACCES errors
  - landlock08 - landlock UDP bind/connect tests
  - rfim - test for RFIM sysfs interface
  - cpufreq_intel - test for intel_pstate sysfs interface
  - epoll_wait16 - EPOLLEXCLUSIVE test
  - epoll_wait15 - test that all epoll instances are woken up on single eve=
nt
  - epoll_wait{13,14} - tests that events are properly returned if there are
                        more events queued than the syscall can return in t=
he
                        epoll_event array passed to the syscall
  - epoll_wait12 - test for EPOLLERR
  - epoll_wait11 - test for EPOLLHUP
  - epoll_wait10 - test for POLLPRI on /proc/mounts
  - epoll_ctl06 - that hammers epoll_ctl() with all kinds of valid and inva=
lid fds
  - epoll_wait09 - test for recursive epoll event propagation
  - epoll_wait08 - test for EINTR
  - epoll_create03 - test for EMFILE
  - epoll_ctl07 - test for ELOOP
  - acl_link01 - test for ACL operations on symlinks
  - acl_file_ops01 - tests that chmod() and chown() interact correctly with=
 ACL
  - acl_inherit01 - test for default ACL inheritance from parent directory
  - acl_other01 - tests that ACL_OTHER permissions are applied correctly
  - acl_mask01 - tests that ACL_MASK correctly restricts permissions
  - acl_user_obj01 - tests ACL_USER_OBJ permissions
  - futex_cmp_requeue03 - tests for EFAULT
  - futex_wake05 - tests for EFAULT
  - futex_wait07 - tests for EINTR
  - futex_wait06 - tests for EFAULT
  - hugemmap35 - A regression test that file can be mapped PROT_MTE even wh=
en
                 MAP_HUGETL is not set in the mmap flags
  - thermal_interrupt_events - test for Intel CPU termal sensors
  - high_freq_hwp_cap_cppc - test for acpi_cppc on intel CPUs
  - userfaultfd07 - test for UFFDIO_CONTINUE

* New keyctl() sanity tests

  - keyctl30 - tests KEYCTL_PKEY_QUERY on private key
  - keyctl29 - tests KEYCTL_PKEY_QUERY on public key
  - keyctl28 - negative tests for KEYCTL_DH_COMPUTE
  - keyctl27 - tests KEYCTL_DH_COMPUTE KDF key derivation
  - keyctl26 - tests KEYCTL_DH_COMPUTE size query
  - keyctl25 - tests KEYCTL_DH_COMPUTE shared secret computation
  - keyctl24 - negative tests for KEYCTL_RESTRICT_KEYRING
  - keyctl23 - tests KEYCTL_RESTRICT_KEYRING builtin_trusted
  - keyctl22 - tests KEYCTL_RESTRICT_KEYRING reject-all
  - keyctl21 - negative tests for KEYCTL_MOVE
  - keyctl20 - tests KEYCTL_MOVE displacement
  - keyctl19 - tests KEYCTL_MOVE with same source and destination
  - keyctl18 - basic tests for KEYCTL_MOVE
  - keyctl17 - negative tests for KEYCTL_GET_SECURITY
  - keyctl16 - tests KEYCTL_GET_SECURITY truncated copy
  - keyctl15 - tests KEYCTL_GET_SECURITY label retrieval
  - keyctl14 - negative tests for KEYCTL_DESCRIBE
  - keyctl13 - tests KEYCTL_DESCRIBE size query
  - keyctl12 - tests KEYCTL_DESCRIBE with too small buffer
  - keyctl11 - tests KEYCTL_DESCRIBE with exact buffer size
  - keyctl10 - tests KEYCTL_DESCRIBE format parsing

* New sysfs sanity tests

  Sanity tests are mostly read-only tests that assert that sysfs files have
  expected values, e.g. booleans are 0 or 1, etc. The cases where the tests=
 are
  writing the sysfs values are when we can create virtual device, e.g. TUN/=
TAP
  networking interface.

  - sys_thp01 - tests /sys/kernel/mm/transparent_hugepage/* files
  - sys_mm_swap01 - tests /sys/kernel/mm/swap/vma_ra_enabled file
  - sys_ksm01 - tests /sys/kernel/mm/ksm/* files
  - sys_hugepages02 - tests /sys/kernel/mm/hugepages/* files
  - sys_hugepages01 - tests /sys/kernel/mm/hugepages/hugepages-*/* files
  - sys_block_size01 - tests /sys/block/*/{ro, size} files
  - sys_block_queue01 - tests /sys/block/*/queue/* files
  - sys_block_loop01 - tests /sys/block/loop*/* files
  - sys_net04 - tests /sys/class/net/*/* files
  - sys_net03 - tests /sys/class/net/*/* files
  - sys_net02 - tests /sys/class/net/*/* files
  - sys_net01 - tests /sys/class/net/*/* files
  - sys_thermal01 - tests /sys/class/thermal/cooling_device*/* files
  - sys_rtc01 - tests /sys/class/rtc/*/* files
  - sys_wakeup01 - tests /sys/class/wakeup/*/* files
  - sys_leds01 - tests /sys/class/leds/*/* files
  - sys_hwmon01 - tests /sys/class/hwmon/*/* files
  - sys_bdi01 - tests /sys/class/bdi/*/* files
  - sys_ata01 - tests /sys/class/ata_device/*/* files
  - sys_clockevents01 - tests /sys/devices/system/clockevents/* files
  - sys_cpu_cache01 - tests /sys/devices/system/cpu/cpu*/cache/* files
  - sys_cpu_smt01 - tests /sys/devices/system/cpu/smt/* files
  - sys_cpu_vulnerabilities01 - tests /sys/devices/system/cpu/vulnerabiliti=
es/* files
  - sys_cpu_topology02 - tests /sys/devices/system/cpu/cpu*/topology/* files
  - sys_cpu_topology01 - tests /sys/devices/system/cpu/* files
  - sys_node01 - tests /sys/devices/system/node/* files
  - sys_clocksource01 - tests /sys/devices/system/clocksource/* files
  - sys_kernel01 - tests /sys/kernel/* files
  - sys_power01 - tests sysfs/power/* files

* Increased coverage
  - swapon02 - tests for invalid swapon() syscalls flags
  - fanotify21 - added test for FAN_REPORT_ID

* The runtest/irq file was merged into runtest/kernel_misc

* Test scripts that depended on ltp-pan were removed, since ltp-pan was rem=
oved
  in previous release.

  - ltp-aiodio.sh
  - tpm_tools.sh
  - network.sh

* More of LTP API was documented and docs are now available at:
  https://linux-test-project.readthedocs.io/en/latest/developers/api_c_test=
s.html

* LTP removed dependency on the keyutils library

  - back then we were using it mostly for the constants and structures that=
 are
    now part of the kernel uapi.

* 15 tests were rewritten to the new test library API

* LTP has migrated its patchwork from ozlabs to kernel.org

+ The usual amount of fixes and cleanups


NOTABLE CHANGES IN NETWORK TESTS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
brought to you by Petr Vorel

- removed outdated DNS stress tests


KIRK
=3D=3D=3D=3D

The LTP test runner kirk was updated to version 4.2.0

  * Add --dry-run option to preview tests before execution
  * Add configurable fault injection interval option
  * Persist and export partial results when a session is aborted mid-suite
  * Fix --exec-timeout not killing tests in the shell channel
  * Fix JSON report file being opened in read/write instead of write-only m=
ode
  * Fix incorrect log message when test parameters are missing in LTP metad=
ata
  * Fix exception handling in the event subsystem
  * Fix --randomize command-line description
  * Major documentation update (quickstart, SSH, LTX, QEMU, and plugins)
  * Move IOBuffer implementations inside the sut module
  * Improve test suite coverage and fix flaky test cases


DOWNLOAD AND LINKS
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20260930

The project pages as well as GIT repository are hosted on GitHub:

https://github.com/linux-test-project/ltp

If you ever wondered how to write a LTP testcase, don't miss our developer
documentation at:

https://linux-test-project.readthedocs.io/en/latest/developers/test_case_tu=
torial.html

And our library API documentation at:

https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.=
html

Patches, new tests, bugs, comments or questions should go to to our mailing
list at ltp@lists.linux.it.


CREDITS
=3D=3D=3D=3D=3D=3D=3D

Many thanks to the people contributing to this release:

git shortlog -s -e -n 20260529..

   110  Andrea Cervesato <andrea.cervesato@suse.com>
    75  Petr Vorel <pvorel@suse.cz>
    61  Cyril Hrubis <chrubis@suse.cz>
    26  Avinesh Kumar <avinesh.kumar@suse.com>
    13  Martin Doucha <mdoucha@suse.cz>
     9  Sachin Sant <sachinp@linux.ibm.com>
     9  Wake Liu <wakel@google.com>
     9  Wei Gao <wegao@suse.com>
     6  AnonymeMeow <anonymemeow@gmail.com>
     5  Li Wang <li.wang@linux.dev>
     5  Michael Menasherov via ltp <ltp@lists.linux.it>
     5  Pavithra <pavrampu@linux.ibm.com>
     4  Piotr Kubaj <piotr.kubaj@intel.com>
     4  Victor Cheng-Yen Yang <cyyang772@andestech.com>
     4  Sebastian Chlad <sebastian.chlad@suse.com>
     3  Disha Goel <disgoel@linux.ibm.com>
     3  Jinseok Kim <always.starving0@gmail.com>
     3  Mimi Zohar <zohar@linux.ibm.com>
     2  Anders Roxell <anders.roxell@linaro.org>
     2  Kuba Pawlak via ltp <ltp@lists.linux.it>
     2  Ricardo Branco <rbranco@suse.de>
     2  Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
     2  XiaoLei Wu <wxl18715129466@gmail.com>
     1  Amir Goldstein <amir73il@gmail.com>
     1  Benjamin Wheeler via ltp <ltp@lists.linux.it>
     1  Brian Grech <bgrech@redhat.com>
     1  Frank Ranner <frank.ranner@intel.com>
     1  Gang Yan <yangang@kylinos.cn>
     1  Grzegorz Jaszczyk <jaszczyk@google.com>
     1  Hongtao Zhang via ltp <ltp@lists.linux.it>
     1  Ivan Hu via ltp <ltp@lists.linux.it>
     1  Jeff Layton <jlayton@kernel.org>
     1  Kinshu Agrawal <kinshu@google.com>
     1  Pavan G <giridharpavan593@gmail.com>
     1  Runli <mingyu.he@shopee.com>
     1  Samir <samir@linux.ibm.com>
     1  Stephen Bertram via ltp <ltp@lists.linux.it>
     1  Tang Yizhou <yizhou.tang@shopee.com>
     1  Terence Tritton <ttritton@google.com>
     1  Wenbo Ma <wenbo1.ma@intel.com>
     1  Xuewen Wang <wangxuewen@kylinos.cn>

And also thanks to patch reviewers:

git log 20260529.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | s=
ort | uniq -c | sort -n -r

    144 Cyril Hrubis <chrubis@suse.cz>
    140 Petr Vorel <pvorel@suse.cz>
    113 Andrea Cervesato <andrea.cervesato@suse.com>
     63 Li Wang <li.wang@linux.dev>
     13 Avinesh Kumar <avinesh.kumar@suse.com>
     10 Jan Stancek <jstancek@redhat.com>
      7 Martin Doucha <mdoucha@suse.cz>
      6 Wei Gao <wegao@suse.com>
      5 Jan Kara <jack@suse.cz>
      4 Amir Goldstein <amir73il@gmail.com>
      2 Sebastian Chlad <sebastian.chlad@suse.com>
      2 Mimi Zohar <zohar@linux.ibm.com>
      2 Michal Koutn=FD <mkoutny@suse.com>
      1 Wake Liu <wakel@google.com>
      1 Vlastimil Babka (SUSE) <vbabka@kernel.org>
      1 Piotr Kubaj <piotr.kubaj@intel.com>

And everyone else suggesting or co-developing:

git log 20260529.. | grep -Ei '(suggested|co-developed)-by:' | sed 's/.*by:=
 //' | sort | uniq -c | sort -n -r

     13 Cyril Hrubis <chrubis@suse.cz>
      2 Petr Vorel <pvorel@suse.cz>
      2 Li Wang <li.wang@linux.dev>
      2 Andrea Cervesato <andrea.cervesato@suse.com>
      1 Wake Liu <wakel@google.com>
      1 Martin Doucha <mdoucha@suse.cz>
      1 Amir Goldstein <amir73il@gmail.com>

-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
