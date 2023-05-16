Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25570C77B75
	for <ltp@archiver.kernel.org>; Tue, 16 May 2023 08:57:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F08A3CDCFE
	for <ltp@archiver.kernel.org>; Tue, 16 May 2023 10:57:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 684A23CB2EA
 for <ltp@lists.linux.it>; Tue, 16 May 2023 10:57:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 57EE7100036C
 for <ltp@lists.linux.it>; Tue, 16 May 2023 10:57:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 316F81FD88;
 Tue, 16 May 2023 08:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684227447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=Z7Z17UxwlPZXAFlulVYyXcdhXoFSKT89glSYZBLFJ7s=;
 b=spYdVKPjDgzF7j+X6HgjFuBngEzQOJfDn61kr4+qcrvucrxbWQOqjsz2XVy+UHFPmR4RQm
 fk0CK5p8kCxjxHJ7Pjy8PwR5xjatqt/wHFJx2GTeOjHa8gCYkiTVHFSKuBuWX1IAMGxS4b
 MODkFgV9Bwmh+Om+5B149DVFeEpI12M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684227447;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=Z7Z17UxwlPZXAFlulVYyXcdhXoFSKT89glSYZBLFJ7s=;
 b=Wx8Nm2Lcj/TeCb3cjebdMYgwl295oqu7IwhnRLMXegMq4km5vCxQ23qk2gOIIVNQ2rXmWB
 +to/vxDrx3CJQtAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1CB24138F5;
 Tue, 16 May 2023 08:57:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id v8L4BXdFY2T7OQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 16 May 2023 08:57:27 +0000
Date: Tue, 16 May 2023 10:58:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it, linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Message-ID: <ZGNFtfP2ioTEEpC3@yuki>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] The Linux Test Project has been released for MAY 2023
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
Cc: torvalds@linux-foundation.org, akpm@inux-foundation.org, lwn@wn.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Good news everyone,

the Linux Test Project test suite stable release for *May 2023* has been
released.

Since the last release 199 patches by 33 authors were merged.

Patch review is what most of the projects struggle with and LTP is no
different. If you can spare some effort helping with the patch review is more
than welcomed.

NOTABLE CHANGES
===============

* New tests
  - kvm_svm01 aka CVE-2021-3653
  - cgroup_core03 test case for the cgroup kill
  - hugetlb32 regression test for:
    - ba9c1201beaa (mm/hugetlb: clear compound_nr before freeing gigantic pages)
    - a01f43901cfb (hugetlb: be sure to free demoted CMA pages to CMA)
  - mmap20 test for mmap() with MAP_SHARED_VALIDATE
  - mqnotify03 aka CVE-2021-38604
  - mprotect05 regression test for:
    - 2fcd07b7ccd5 (mm/mprotect: Fix successful vma_merge() of next in do_mprotect_pkey())
  - fsconfig03 aka CVE-2022-0185
  - madvise11 regression test for:
    - d4ae9916ea29 (mm: soft-offline: close the race against page allocation)
  - mount07 test case for MS_NOSYMFOLLOW

* Increased coverage
  - NFS tests now run on btrfs, ext4 and xfs
  - setpgid were rewritten and increased coverage in a few corner cases
  - ioctl01 added more termios coverage

* fs_fill test was fixed on 256+ CPUs

* loongarch support was added

+ The usual amount of fixes and cleanups

NOTABLE CHANGES IN NETWORK TESTS
================================
brought to you by Petr Vorel

- NFS tests now run on btrfs, ext4, xfs
  (might be extended to more filesystems later)
- nfs08.sh a new test for NFS cache invalidation

RUNLTP-NG
=========

* The new runltp-ng was finally included in the previous release tarball
  - https://github.com/linux-test-project/runltp-ng/#readme
  - https://www.youtube.com/watch?v=JMeJBt3S7B0

* There were no changes done in this release, however parallel text execution
  is being worked on, possibly there would be preview ready for the next release

REMOVED TESTS
=============

* tomoyo testsuite which is maintained elsewhere by tomoyo devs

* execltp script which was unmaintained for years

DOWNLOAD AND LINKS
==================

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20230516

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

git shortlog -s -e -n 20230127..

    58  Petr Vorel <pvorel@suse.cz>
    20  Andrea Cervesato via ltp <ltp@lists.linux.it>
    19  Yang Xu <xuyang2018.jy@fujitsu.com>
    15  Martin Doucha <mdoucha@suse.cz>
    11  Andrea Cervesato <andrea.cervesato@suse.com>
    11  Edward Liaw <edliaw@google.com>
    10  Wei Gao <wegao@suse.com>
     8  Avinesh Kumar <akumar@suse.de>
     5  Cyril Hrubis <chrubis@suse.cz>
     5  Teo Couprie Diaz <teo.coupriediaz@arm.com>
     4  Li Wang <liwang@redhat.com>
     3  Hao Ge <gehao@kylinos.cn>
     3  Ping Fang <pifang@redhat.com>
     3  Richard Palethorpe <rpalethorpe@suse.com>
     3  Tarun Sahu <tsahu@linux.ibm.com>
     2  Hao Zeng <zenghao@kylinos.cn>
     2  Leo Yu-Chi Liang <ycliang@andestech.com>
     2  Sowmya Indranna <reachmesowmyati@gmail.com>
     1  Andrei Gherzan <andrei.gherzan@canonical.com>
     1  Ashwin Dayanand Kamat via ltp <ltp@lists.linux.it>
     1  David Hildenbrand <david@redhat.com>
     1  Enze Li <lienze@kylinos.cn>
     1  Fabrice Fontaine <fontaine.fabrice@gmail.com>
     1  Frank He <hexiaoxiao@kylinos.cn>
     1  Hui Min Mina Chou <minachou@andestech.com>
     1  Jan Stancek <jstancek@redhat.com>
     1  Liam R. Howlett <Liam.Howlett@oracle.com>
     1  Mahesh Kumar G <maheshkumar657g@gmail.com>
     1  Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
     1  Paulson Raja L <paulson@zilogic.com>
     1  Seth Forshee (DigitalOcean) <sforshee@kernel.org>
     1  Vignesh Raman <vignesh.raman@collabora.com>
     1  William Roche <william.roche@oracle.com>


And also thanks to patch reviewers:

git log 20230127.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r

     68 Cyril Hrubis <chrubis@suse.cz>
     60 Petr Vorel <pvorel@suse.cz>
     36 Richard Palethorpe <rpalethorpe@suse.com>
     35 Li Wang <liwang@redhat.com>
      7 Jan Stancek <jstancek@redhat.com>
      4 Avinesh Kumar <akumar@suse.de>
      3 Yang Xu <xuyang2018.jy@fujitsu.com>
      2 Andrea Cervesato <andrea.cervesato@suse.com>
      1 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
