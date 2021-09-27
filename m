Return-Path: <SRS0=FiD7=OR=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A405AC433FE
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 14:58:09 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEBC260EE2
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 14:58:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AEBC260EE2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9924B3C9AF7
	for <ltp@archiver.kernel.org>; Mon, 27 Sep 2021 16:58:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DABB33C8261
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 16:57:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 969A81400BDC
 for <ltp@lists.linux.it>; Mon, 27 Sep 2021 16:57:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F9BF1FEC5;
 Mon, 27 Sep 2021 14:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632754674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=NN5woYX1HSxN42OI/5IS/aTJL7XrsVlCfC35yzZdz8A=;
 b=vrILWlRFP6/4w9MWTvfLyqk1JnFfHlSYYeFeWVzsasoHbfNTfW9VECoFy0K5vSrsuF3ZCE
 mWr+1dHWbZZloopO5UDS+d8ZZjbQeFDhUNsHxQdh6Wqd3FplLKi/8OuHyN+IIiL2mR96ip
 ML/NDJD5H+A67yAP+Kqdb3oWckb23n0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632754674;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=NN5woYX1HSxN42OI/5IS/aTJL7XrsVlCfC35yzZdz8A=;
 b=tabYx24JiFVBdZ0hk72BXSVmlnWZNX5Ji+R32xNDbJH4M3hclu2QYrhgVsqOJlu7Nt+FEk
 htQ5ppJSAGqSiOCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 549D514007;
 Mon, 27 Sep 2021 14:57:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id TFwtE/LbUWGnSgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 27 Sep 2021 14:57:54 +0000
Date: Mon, 27 Sep 2021 16:58:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it, linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Message-ID: <YVHcFS3A4eFJeNOm@yuki>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 SEPTEMBER 2021
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Good news everyone,

the Linux Test Project test suite stable release for *September 2021* has been
released.

Since the last release 483 patches by 40 authors were merged.

This is a record breaking release by the number of patches as well as by the
amount of newly implemented functionality.

Many thanks to all contributors!

And even more thanks to the reviewers!

Patch review is what most of the projects struggle with and LTP is no
different. If you can spare some effort helping with the patch review is more
than welcomed.

NOTABLE CHANGES
===============

* New tests
  - epoll_ctl05 checks for ELOOP error for circular loop of epolls
  - epoll_ctl04 checks for EINVAL when epoll nesting is too deep
  - epoll_ctl02 checks for EPERM when epoll is not supported for fd
  - epoll_create01 checks that epoll create returns a valid fd
  - epoll_create1_02 checks for EINVAL when epoll_create1() is passed invalid flags
  - epoll_pwait02 test if events are reported properly
  - epoll_pwait03 tests if epoll_pwait/epoll_pwait2 timeouts correctly
  - epoll_pwait04 adds tests for zero timeout and invalid timespec values
  - shmget05 test for /proc/sys/kernel/shm_next_id
  - shmget06 test when shm_next_id is already in use
  - io_getevents02 checks for EINVAL errors via libaio
  - io_cancel02 checks for EFAULT errors via libaio
  - io_submit03 checks for invalid input via syscall
  - io_submit02 checks if correct operation via syscall
  - io_setup02 checks for invalid inputs via syscall
  - io_destroy02 checks for invalid inputs via syscall
  - cfs_bandwidth01 a multi-level cgroup cpu controller test

* New regression tests
  - creat09 privilege escalation using setgid directory aka CVE-2018-13405
  - can_bcm01 race condition vulnerability in CAN BCM aka CVE-2021-3609
  - setsockopt08 out-of-bounds write corrupting aka CVE-2021-22555
  - perf_event_open03 kernel memory leak aka CVE-2020-25704
  - squashfs01 regression test for broken sanity checks
  - set_mempolicy05 information leak aka CVE-2017-7616
  - userns08 broken id mappings in nested namespaces CVE-2018-18955
  - tc01.sh regression test for tc qdisc command
  - fanotify19 added regression test for:
    a8b98c808eab ("fanotify: fix permission model of unprivileged group")
  - kill13 INT_MIN negation reproducer aka CVE-2018-10124
  - wait403 INT_MIN negation reproducer
  - vsock01 race condition reproducer aka CVE-2021-26708
  - icmp_rate_limit01 DNS cache poisoning attack aka CVE-2020-25705

* Increased coverage
  - epoll_create02 checks for more EINVAL failures
  - epoll_ctl03 checks that the syscall works with all valid flags combinations
  - mbind01 more tests for MPOL_LOCAL
  - epoll_pwait01 adds test variants for epoll_pwait2()

* 75 tests were rewritten to the new library

* Removed tests
  - sched/stress as it was unmaintained and unused for years
  - stress_cd and stress_floppy since these scripts were broken and unmaintained for years
  - disktest as it was unmaintained and unused for years

* The CI was moved from Travis to GitHub actions

* 'make check' was introduced to the LTP build system
  - which is a tool for developers that runs various sanity checks on the source code
  - this includes:
     - checkpatch.pl, custom set of sparse rules for C
     - checkbashism.pl for shell
  - please make sure you run 'make check' or 'make check-testname' and fix the
    warnings before submitting patches

* Subset of our library tests i.e. tests for the test library is now executed
  CI in github actions, this is ongoing effort to make sure that the test library
  used by the testcases is working as expected

* The test library was fixed to print all messages to stderr

* Testcases were fixed not to expect certain users and groups to be present on the system
  - some tests were expecting bin, daemon and similar groups and users to exist on the system
  - now LTP depends only on user 'nobody' and group 'nogroup'

* New environment variable LTP_VIRT_OVERRIDE was added
  - this is meant as a quick workaround for cases where the test library
    cannot properly detect if system is virtualized or not
  - see https://github.com/linux-test-project/ltp/wiki/User-Guidelines

* Fixed (again) timeouts in shell test library
  - turns out you cannot make timeouts in shell race-free so the timeout logic
    is now implemented in a small C helper binary

* Finally after the years we are slowly making tests limits-aware
  - cgropup tests and a few others are now aware of pid limits imposed by the system
  - next step would be doing rough estimates on the number of processes we can run
    based on the free system memory

* There is ongoing effort to fix LTP cgroup tests, this release includes many
  small fixes and improvements in the cgroup tests

* The aarch64 system call table was fixed not to include 32bit only syscall numbers

* The TST_EXP_*() macros were improved and a few bugs were fixed

* The test library developer documentation and tutorials were reorganized and improved
  - https://github.com/linux-test-project/ltp/wiki/C-Test-API
  - https://github.com/linux-test-project/ltp/wiki/C-Test-Network-API
  - https://github.com/linux-test-project/ltp/wiki/Shell-Test-API

+ The more that the usual amount of fixes and cleanups

WHAT IS IN THE QUEUE
====================

Next release will hopefully include runltp-ng which is new and improved LTP
testrunner. The current runltp script will be maintained alongside with the
new solution for some time but removed after a few releases.

You are more than welcome to try it and make sure that it works for you before
it becomes the official LTP testrunner.

See: https://github.com/metan-ucw/runltp-ng

NOTABLE CHANGES IN NETWORK TESTS
================================
brought to you by Petr Vorel

* C network library
  - Added device management helpers
  - And documentation:
    https://github.com/linux-test-project/ltp/wiki/C-Test-Network-API

* Shell network library
  - Allow to skip initialization with TST_NET_SKIP_VARIABLE_INIT=1
  - Disable IPv6 Duplicate Address Detection on link-local addresses

* Tests rewritten to the new library
  - getaddrinfo01
  - ssh-stress

* Removed tests
  - broken_ip-totlen

+ More busybox and general fixes

DOWNLOAD AND LINKS
==================

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20210927

The project pages as well as GIT repository are hosted on GitHub:

https://github.com/linux-test-project/ltp
http://linux-test-project.github.io/

If you ever wondered how to write a LTP testcase, don't miss our developer
documentation at:

https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines

https://github.com/linux-test-project/ltp/wiki/C-Test-API

https://github.com/linux-test-project/ltp/wiki/C-Test-Network-API

https://github.com/linux-test-project/ltp/wiki/Shell-Test-API

https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial

https://github.com/linux-test-project/ltp/wiki/BuildSystem

Patches, new tests, bugs, comments or questions should go to to our mailing
list at ltp@lists.linux.it.

CREDITS
=======

Many thanks to the people contributing to this release:

git shortlog -s -e -n 20210927..

    87  Petr Vorel <pvorel@suse.cz>
    51  Xie Ziyao <xieziyao@huawei.com>
    51  Richard Palethorpe <rpalethorpe@suse.com>
    50  Martin Doucha <mdoucha@suse.cz>
    30  Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
    29  Cyril Hrubis <chrubis@suse.cz>
    28  Alexey Kodanev <aleksei.kodanev@bell-sw.com>
    27  Yang Xu <xuyang2018.jy@fujitsu.com>
    20  Li Wang <liwang@redhat.com>
    18  zhanglianjie <zhanglianjie@uniontech.com>
    17  Joerg Vehlow <joerg.vehlow@aox-tech.de>
    12  Vinay Kumar <vinay.m.engg@gmail.com>
     8  Xie Ziyao <ziyaoxie@outlook.com>
     7  sujiaxun <sujiaxun@uniontech.com>
     5  Bogdan Lezhepekov <bogdan.lezhepekov@suse.com>
     5  Dai Shili <daisl.fnst@fujitsu.com>
     5  Jan Stancek <jstancek@redhat.com>
     5  QI Fuli <qi.fuli@fujitsu.com>
     4  Leo Liang <ycliang@andestech.com>
     2  Alexander Egorenkov <egorenar@linux.ibm.com>
     2  Amir Goldstein <amir73il@gmail.com>
     2  Shiyang Ruan <ruansy.fnst@fujitsu.com>
     2  Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
     2  Zhao Gongyi <zhaogongyi@huawei.com>
     1  Alessio Balsini <balsini@android.com>
     1  Bogdan Lezhepekov via ltp <ltp@lists.linux.it>
     1  Cao jin <caojin@uniontech.com>
     1  Egor Petrov <egor.petrov@oracle.com>
     1  Ian May <ian.s.may@gmail.com>
     1  John Stultz <john.stultz@linaro.org>
     1  Leo Yu-Chi Liang <ycliang@andestech.com>
     1  Marius Hillenbrand <mhillen@linux.ibm.com>
     1  Naresh Kamboju <naresh.kamboju@linaro.org>
     1  Radoslav Kolev <radoslav.kolev@suse.com>
     1  Wang Xin <wangxin410@huawei.com>
     1  Xiao Yang <yangx.jy@fujitsu.com>
     1  Zou Wei <zou_wei@huawei.com>
     1  dongshijiang <dongshijiang@inspur.com>

And also thanks to patch reviewers:

git log 20210927.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r

    289 Cyril Hrubis <chrubis@suse.cz>
    113 Petr Vorel <pvorel@suse.cz>
     75 Li Wang <liwang@redhat.com>
     25 Richard Palethorpe <rpalethorpe@suse.com>
     16 Yang Xu <xuyang2018.jy@fujitsu.com>
     12 Alexey Kodanev <aleksei.kodanev@bell-sw.com>
      7 Jan Stancek <jstancek@redhat.com>
      6 Richard Palethorpe <rpalethorpe@suse.de>
      5 Xiao Yang <yangx.jy@fujitsu.com>
      5 Martin Doucha <mdoucha@suse.cz>
      3 Joerg Vehlow <joerg.vehlow@aox-tech.de>
      3 Enji Cooper <yaneurabeya@gmail.com>
      2 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
      1 Yang Xu <xuyang2018.jy@fujitsu.com
      1 Xie Ziyao <xieziyao@huawei.com>
      1 Stephen Kitt <steve@sk2.org>
      1 Petr Vorel <pvorel@suse.com>
      1 Leo Yu-Chi Liang <ycliang@andestech.com>
      1 Joerg Vehlow <lkml@jv-coder.de>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
