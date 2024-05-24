Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A92C25B74
	for <ltp@archiver.kernel.org>; Fri, 24 May 2024 14:10:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBEC03D0271
	for <ltp@archiver.kernel.org>; Fri, 24 May 2024 16:10:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6FDB3CB744
 for <ltp@lists.linux.it>; Fri, 24 May 2024 16:10:13 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6F19863CA7A
 for <ltp@lists.linux.it>; Fri, 24 May 2024 16:10:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1225A33B4E;
 Fri, 24 May 2024 14:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716559810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=F26aKVHEn/HJrJC8s7hiOmU9ISqv2CdOYQdRJrNXvj8=;
 b=XwqHhGHdUzYod8u0PTEKmFcHp+qU2dOjuU5VjoxIJtGEukkanafLhxb3iE+lM2qv/s7N7x
 sBrLsOhG+Tl2RkzmwP6e2PXP5RYEUHlvGBo8+Jy7zRJBjei+PK5Ut4iF13CGj4ABuObEeT
 6iU0Z6BsUplfnW4aHAffX6IggUD34kY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716559810;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=F26aKVHEn/HJrJC8s7hiOmU9ISqv2CdOYQdRJrNXvj8=;
 b=nbeNsxxfR68jIe/QlMWUEW07uHFh8aae4yMwEvxcI1jSbKl1HdHN6KVSh+ZoqkRLt1VMVs
 yEm7QJaoM6Cp7pDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XwqHhGHd;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nbeNsxxf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716559810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=F26aKVHEn/HJrJC8s7hiOmU9ISqv2CdOYQdRJrNXvj8=;
 b=XwqHhGHdUzYod8u0PTEKmFcHp+qU2dOjuU5VjoxIJtGEukkanafLhxb3iE+lM2qv/s7N7x
 sBrLsOhG+Tl2RkzmwP6e2PXP5RYEUHlvGBo8+Jy7zRJBjei+PK5Ut4iF13CGj4ABuObEeT
 6iU0Z6BsUplfnW4aHAffX6IggUD34kY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716559810;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type;
 bh=F26aKVHEn/HJrJC8s7hiOmU9ISqv2CdOYQdRJrNXvj8=;
 b=nbeNsxxfR68jIe/QlMWUEW07uHFh8aae4yMwEvxcI1jSbKl1HdHN6KVSh+ZoqkRLt1VMVs
 yEm7QJaoM6Cp7pDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 035A713A6B;
 Fri, 24 May 2024 14:10:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id s2cbO8GfUGaaGQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 24 May 2024 14:10:09 +0000
Date: Fri, 24 May 2024 16:10:10 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it, linux-kernel@vger.kernel.org, libc-alpha@sourceware.org
Message-ID: <ZlCfwm2kzHqhjiWn@yuki>
MIME-Version: 1.0
Content-Disposition: inline
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1225A33B4E
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [ANNOUNCE] The Linux Test Project has been released for MAY
 2024
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

the Linux Test Project test suite stable release for *May 2024* has been
released.

Since the last release 292 patches by 27 authors were merged.

Patch review is what most of the projects struggle with and LTP is no
different. If you can spare some effort helping with the patch review is more
than welcomed.

NOTABLE CHANGES
===============

* New tests

  - mlock05 Test for pre-faulting locked memory
  - kvm_svm04 Functional test for VMSAVE/VMLOAD instructions
  - arch_prctl01 Test for ARCH_SET_CPUID and ARCH_GET_CPUID
  - kallsyms A test to check that it's impossible to read kernel memory from userspace
  - unlink09 Negative tests for unlink()
  - getrandom05 Negative tests for getrandom()
  - gethostname02 Negative tests for gethostname()
  - splice08 Test for splicing from /dev/zero and /dev/full
  - splice09 Test for splicing to /dev/zero and /dev/null
  - shmat04 A regression test for fc0c8f9089c2
           ("mm, mmap: fix vma_merge() case 7 with vma_ops->close")
  - aslr01 Tests that hugepages, that cause addesses to be aligned to higher
           order of 2, are not used for libraries when ASLR is enabled.

* Increased coverage

  - getsockname01 More negative testcases
  - getsockopt01 More negative testcases
  - bind01 More negative testcases
  - swapon01 Runs on all supported filesystems now
  - waitpid01 Tests all deadly signals now
  - fanotify01 Tests setting two marks on different filesystems

* Rewritten tests

  - msgstress testcases were rewritten into a single msgstress01 test
    this should finally fix the test to scale well from small embedded boards
    towards big servers

  - symlink01 has been split into several testcases, previously several different
              testcases were build from the source based on different messy ifdefs

* UCLINUX support was completely removed from LTP

  It was unmaintained and partially broken and nobody stepped up to maintain
  the support.

* Small runtest files cleanup

  - runtest/io was merged into ltp-aiodio.part4
  - runtest/cap_bounds and runtest/filecaps were merged into single runtest file

* 32 testcases were converted to the new test library

+ The usual amount of fixes and cleanups

NOTABLE CHANGES IN NETWORK TESTS
================================
brought to you by Petr Vorel

* New tests

  - nfs09 Regression test for file truncation on NFS.

* Increased coverage

  - nfsstat01.sh: Add support for NFSv4*

* Removed tests

  - clockdiff01.sh Testing clockdiff is not relevant nowadays.
  - telnet01.sh Testing telnet not make sense nowadays, remove it.
  - xinetd_tests.sh Testing xinetd is not relevant nowadays.
  - host01.sh The test does not work in all cases since testing host require
              proper DNS setup or internet connection. Rather than fixing this
	      it makes sense to remove the test.

New documentation
=================

We have finally started working on a comprehensive documentation for LTP and
it's test library, the current state can be seen at:

https://linux-test-project.readthedocs.io/en/latest/

DOWNLOAD AND LINKS
==================

The latest version of the test-suite contains 3000+ tests for the Linux
and can be downloaded at:

https://github.com/linux-test-project/ltp/releases/tag/20240524

The project pages as well as GIT repository are hosted on GitHub:

https://github.com/linux-test-project/ltp

If you ever wondered how to write a LTP testcase, don't miss our developer
documentation at:

https://linux-test-project.readthedocs.io/en/latest/developers/test_case_tutorial.html

And our library API documentation at:

https://linux-test-project.readthedocs.io/en/latest/developers/api_c_tests.html

Patches, new tests, bugs, comments or questions should go to to our mailing
list at ltp@lists.linux.it.

CREDITS
=======

Many thanks to the people contributing to this release:

git shortlog -s -e -n 20240129..

    140  Petr Vorel <pvorel@suse.cz>
     22  Martin Doucha <mdoucha@suse.cz>
     25  Yang Xu <xuyang2018.jy@fujitsu.com>
     21  Li Wang <liwang@redhat.com>
     16  Andrea Cervesato <andrea.cervesato@suse.com>
     15  Andrea Manzini <andrea.manzini@suse.com>
     14  Wei Gao <wegao@suse.com>
     10  Cyril Hrubis <chrubis@suse.cz>
      5  Avinesh Kumar <akumar@suse.de>
      2  Detlef Riekenberg <wine.dev@web.de>
      2  Edward Liaw <edliaw@google.com>
      4  Hui Min Mina Chou <minachou@andestech.com>
      2  lufei <lufei@uniontech.com>
      1  Amir Goldstein <amir73il@gmail.com>
      1  Dennis Brendel <dbrendel@redhat.com>
      1  Filippo Storniolo <fstornio@redhat.com>
      1  Jan Stancek <jstancek@redhat.com>
      1  Khem Raj <raj.khem@gmail.com>
      1  Mete Durlu <meted@linux.ibm.com>
      1  Murphy Zhou <jencce.kernel@gmail.com>
      1  Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
      1  Sebastian Chlad <sebastianchlad@gmail.com>
      1  Sergey Ulanov via ltp <ltp@lists.linux.it>
      1  Shiyang Ruan <ruansy.fnst@fujitsu.com>
      1  Wenjie Xu <xuwenjie04@baidu.com>
      1  Xiangyu Chen <xiangyu.chen@windriver.com>
      1  yangfeng <yangfeng@kylinos.cn>

And also thanks to patch reviewers:

git log 20240129.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r

    125 Petr Vorel <pvorel@suse.cz>
     94 Cyril Hrubis <chrubis@suse.cz>
     31 Li Wang <liwang@redhat.com>
     15 Andrea Cervesato <andrea.cervesato@suse.com>
     12 Martin Doucha <mdoucha@suse.cz>
     11 Avinesh Kumar <akumar@suse.de>
      7 Jan Stancek <jstancek@redhat.com>
      3 Marius Kittler <mkittler@suse.de>
      3 Jan Kara <jack@suse.cz>
      2 Amir Goldstein <amir73il@gmail.com>
      1 Wei Gao <wegao@suse.com>
      1 Vlastimil Babka <vbabka@suse.cz>
      1 Richard Palethorpe <rpalethorpe@suse.com>
      1 Matt Bobrowski <mattbobrowski@google.com>
      1 Kent Overstreet <kent.overstreet@linux.dev>
      1 Joerg Vehlow <joerg.vehlow@aox.de>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
