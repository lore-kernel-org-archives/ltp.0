Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918B0C54EAA
	for <ltp@archiver.kernel.org>; Fri, 27 Jan 2023 14:52:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 052893CC70E
	for <ltp@archiver.kernel.org>; Fri, 27 Jan 2023 15:52:41 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CEB3B3CB390
 for <ltp@lists.linux.it>; Fri, 27 Jan 2023 15:52:31 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 218D0200D59
 for <ltp@lists.linux.it>; Fri, 27 Jan 2023 15:52:30 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 97B021F74B;
 Fri, 27 Jan 2023 14:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1674831149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=NWKJzVLEskhh5spnHD49SgEFwuW9F6uuTnyL8tKjFlo=;
 b=oSWYOAHrzq73sQB+EAdSXD81kcOoITJUvbV2K2GeoRFWlVq0vwm7u43RpsyOdFOt9iBKOn
 g1Gtqk0JK+3abIiiZPJdm8RrOHmyjBdPVuojhcjFa01IZp2WUXaVkcgTirKrr70SDILjXe
 VvfKbX7FgqRVomxZc3IAVXYUt1rIK7Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1674831149;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=NWKJzVLEskhh5spnHD49SgEFwuW9F6uuTnyL8tKjFlo=;
 b=n9VF+8cM4QnU/vlYykHU6d9BofYIBo1Tv2gI426E5y1IvILeFDlnV7XKoG0ntdXQrD0aKO
 Se8z5pR2tTOHFtAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B42E1336F;
 Fri, 27 Jan 2023 14:52:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WtCkFS3l02OoUQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 27 Jan 2023 14:52:29 +0000
Date: Fri, 27 Jan 2023 15:54:02 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it, linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Message-ID: <Y9Plit9dXSDhSqC9@yuki>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 JANUARY 2023
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

the Linux Test Project test suite stable release for *January 2023* has been
released.

Since the last release 278 patches by 37 authors were merged.

Patch review is what most of the projects struggle with and LTP is no
different. If you can spare some effort helping with the patch review is more
than welcomed.

NOTABLE CHANGES
===============

* New tests
  - 31 hugetlb tests were cleaned up and ported from libhugetlbfs
  - test for cve-2022-4378 /proc/sys/ files overflow on writing
  - cgroup_core02 regression test for e57457641613 aka CVE-2021-4197
  - dirtyc0w_shmem aka CVE-2022-2590
  - openat04 regression test for ac6800e279a2
  - nice05 basic functional test for nice()
  - madvise03 new test for MADV_DONTNEED
  - prctl10 basic test for PR_SET/GET_TSC

* Increased coverage
  - mount03 add tests for MS_STRICTATIME, MS_NODIRATIME validate f_flags
  - getitimer01 add check for nonzero timer
  - setitimer01 add interval timer test
  - getitimer02 add ITIMER_VIRTUAL timer error check
  - madvise01 add tests for MADV_COLD and MADV_PAGEOUT

* The minimal supported kernel version was raised to 3.10
  - LTP is no longer tested on older kernels
  - various checks for old kernels were removed from the test code

* The AIO test cleanup was finished with rewrite of aiocp and aio-stress

* LTP is now compiled with explicit -std=gnu99 which forces reasonably
  modern C even on oldest distributions we still have to support

* LTP build system now forces LC_{COLLATE, NUMERIC}=C in order to have
  reproducible builds

* 31 tests were cleaned up and converted for the new test API

+ The usual amount of fixes and cleanups

RUNLTP-NG
=========

* The new runltp-ng is finally included in the released tarball
  - https://github.com/linux-test-project/runltp-ng/#readme
  - https://www.youtube.com/watch?v=JMeJBt3S7B0

REMOVED TESTS
=============

* fs-bench which was broken beyond repair and not worth of keeping

DOWNLOAD AND LINKS
==================

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20230127

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

git shortlog -s -e -n 20220930..

    50  Petr Vorel <pvorel@suse.cz>
    34  Yang Xu <xuyang2018.jy@fujitsu.com>
    33  Tarun Sahu <tsahu@linux.ibm.com>
    28  Avinesh Kumar <akumar@suse.de>
    21  Richard Palethorpe <rpalethorpe@suse.com>
    13  Martin Doucha <mdoucha@suse.cz>
    15  Andrea Cervesato <andrea.cervesato@suse.com>
     9  Li Wang <liwang@redhat.com>
     9  Zhao Gongyi <zhaogongyi@huawei.com>
     6  Akihiko Odaki <akihiko.odaki@daynix.com>
     6  David Hildenbrand <david@redhat.com>
     6  Jan Stancek <jstancek@redhat.com>
     6  Tudor Cretu <tudor.cretu@arm.com>
     6  Luo xiaoyu <luoxiaoyu9@huawei.com>
     4  Wei Gao <wegao@suse.com>
     3  Edward Liaw via ltp <ltp@lists.linux.it>
     3  Jan Kara <jack@suse.cz>
     2  Alessandro Carminati <alessandro.carminati@gmail.com>
     2  Alex <aleksandrosansan@gmail.com>
     2  Cyril Hrubis <chrubis@suse.cz>
     2  Pengfei Xu <pengfei.xu@intel.com>
     2  Rong Tao <rongtao@cestc.cn>
     2  Teo Couprie Diaz <teo.coupriediaz@arm.com>
     1  He Zhe <zhe.he@windriver.com>
     1  Huangjie Liao <liaohj.jy@fujitsu.com>
     1  Ilya Kurdyukov <59548320+ilyakurdyukov@users.noreply.github.com>
     1  Jie2x Zhou <jie2x.zhou@intel.com>
     1  Joerg Vehlow <joerg.vehlow@aox.de>
     1  Khem Raj <raj.khem@gmail.com>
     1  Murphy Zhou <jencce.kernel@gmail.com>
     1  Nikolaus Voss <nikolaus.voss@haag-streit.com>
     1  Randolph <randolph@andestech.com>
     1  Sven Schnelle <svens@linux.ibm.com>
     1  Vitaly Chikunov <vt@altlinux.org>
     1  chenhx.fnst@fujitsu.com <chenhx.fnst@fujitsu.com>
     1  wangkaiyuan <wangkaiyuan@inspur.com>
     1  zijunzhao <zijunzhao@google.com>

And also thanks to patch reviewers:

git log 20220930.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r

    106 Richard Palethorpe <rpalethorpe@suse.com>
     70 Petr Vorel <pvorel@suse.cz>
     47 Cyril Hrubis <chrubis@suse.cz>
     45 Li Wang <liwang@redhat.com>
     14 Yang Xu <xuyang2018.jy@fujitsu.com>
      7 Jan Stancek <jstancek@redhat.com>
      8 Martin Doucha <mdoucha@suse.cz>
      3 Avinesh Kumar <akumar@suse.de>
      2 Pengfei Xu <pengfei.xu@intel.com>
      1 Richard Purdie <richard.purdie@linuxfoundation.org>
      1 Khem Raj <raj.khem@gmail.com>
      1 Christian Brauner (Microsoft) <brauner@kernel.org>
      1 Chang S. Bae <chang.seok.bae@intel.com>
      1 Andrea Cervesato <andrea.cervesato@suse.de>
      1 Akihiko Odaki <akihiko.odaki@daynix.com>
-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
