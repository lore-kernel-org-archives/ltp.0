Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E613C4828F
	for <ltp@archiver.kernel.org>; Sat,  3 Feb 2024 23:57:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE77E3CF670
	for <ltp@archiver.kernel.org>; Sun,  4 Feb 2024 00:57:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14C003CAE45
 for <ltp@lists.linux.it>; Sun,  4 Feb 2024 00:57:12 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B65D110006CF
 for <ltp@lists.linux.it>; Sun,  4 Feb 2024 00:57:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E61FA22205;
 Sat,  3 Feb 2024 23:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707004630;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a6HV+PD6XzbNbLh19dcoh18KnJp8QHEKHWvwQzTfqRE=;
 b=t7ZuaMSvdsKm+kMr/kUzWztDj09iLWVu4a0/Wtmh9zSdzI5cucgi2GmqivpGKk6To9/0He
 iWqv4aMIWAcUI2nzhHzWo1+pC3O9b8pGnYuXo0UvF3+dy4ypPyNMtFhe4bE1TfdCmUBbYW
 e3xhpwhsS8Ifki2no41PTIYSPtaBoYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707004630;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a6HV+PD6XzbNbLh19dcoh18KnJp8QHEKHWvwQzTfqRE=;
 b=Myjn0a1udXLlgMpHmynYcLj8ulmDLuEVwp7eRh9sdbzQPztkHEVI+k0c+80Jph3An9rghL
 v6nd1zX+xf5W/kCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707004629;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a6HV+PD6XzbNbLh19dcoh18KnJp8QHEKHWvwQzTfqRE=;
 b=ZfC9gOZvQFnuZRbympBoBVWyDxmIVNeBdamGqb2aRTbvkVIQP0gFJFzr34xr6H2L0FoOqs
 ARdcCvyj65RLZ9DaFqw1Tthpyfm3yONJJojr5LOMwQTyQIr6ay7laao4k7NV7vPCuHqwzi
 5KlmlEdQPPRiZodiW7vQ8BxgNeehuCs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707004629;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a6HV+PD6XzbNbLh19dcoh18KnJp8QHEKHWvwQzTfqRE=;
 b=jqTdkXVQJoBroLmkHx7xnBrRPcnEECPSdo6hRzGGVDn8DST70/fv3gsjWwMmAE/shKyOZq
 Ks7WSUshnqVu9nCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B50F7137FD;
 Sat,  3 Feb 2024 23:57:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zvKFKtXSvmUxHgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Sat, 03 Feb 2024 23:57:09 +0000
Date: Sun, 4 Feb 2024 00:57:08 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240203235708.GA164636@pevik>
References: <ZbjZxy4vbxoXUJ-i@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZbjZxy4vbxoXUJ-i@yuki>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [ANNOUNCE] The Linux Test Project has been released for
 JANUARY 2024
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: lwn@lwn.net, libc-alpha@sourceware.org, linux-kernel@vger.kernel.org,
 ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Good news everyone,

> the Linux Test Project test suite stable release for *January 2024* has been
> released.

> Since the last release 315 patches by 34 authors were merged.

> Patch review is what most of the projects struggle with and LTP is no
> different. If you can spare some effort helping with the patch review is more
> than welcomed.

> NOTABLE CHANGES
> ===============

FYI, there is missing removal of runtest/connectors [1], which can break some
tooling.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/commit/9b642d89c0bcf5885b051c2d5768fa94b61d86cb

> * New tests
>   - splice07, accept03, readahead01:

>     Tests that feeds the syscall all kinds of invalid file descriptors and
>     checks that the syscall fails properly.

>    - proc_sched_rt01 a regression test for:

>      c1fc6484e1fb ("sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset")
>      079be8fc6309 ("sched/rt: Disallow writing invalid values to sched_rt_period_us")

>   - ksm07 a test for KSM smart-scan.

>   - pathconf02 negative testcases for pathconf()

>   - pipe15 A regresson test for:

>     46c4c9d1beb7 ("pipe: increase minimum default pipe size to 2 pages")

>   - nft02 A regression test for:

>      515ad530795c ("netfilter: nf_tables: do not ignore genmask when looking up chain by id") aka CVE-2023-31248

>   - sched_setscheduler04 a test for SCHED_RESET_ON_FORK

>   - setsockopt10 2c02d41d71f9 ("net/ulp: prevent ULP without clone op from entering the LISTEN status") aka CVE-2023-0461

>   - gettid02 A basic gettid02 test.

>   - splice06 A test that splicing from a /proc files works.

> * Increased coverage

>    - ioctl02 cover more modern termios ioctls() as well.

>    - fanotify13 More test coverage for overlayfs.

>    - input* test now check UI_GET_NAME ioctl() too.

> * Removed tests

>    - fork12 Which was a naive fork bomb test, we do have other tests
>             (setrlimit01.c, ...) that better cover this scenario.

>    - mongo test framework

>      Which was test reiser, ext2 and jfs unmaintained for a decade.

>    - simple_tracer.c Tracing test from 2009 that does not compile anymore.

>    - runtest/fsx-linux This is consolidation of runtest files, since these test
>                        duplicated in ltp-aiodio.part3.

>    - testscripts/autofs{1,4}.sh, testscripts/sysfs.sh,
>      testscripts/ltp-scsi_debug.sh, testscripts/ltpdmmapper.sh

>      These were unmaintained and unused scripts.

>    - scsi/* A testsuite with a custom kernel module for kernel 2.5 that didn't
>             compile cleanly for decades.

>    - load_stress_all_kernel_modules.sh Broken for quite some time.

> * The LTP library now has a functions to iterate over different
>   file descriptors. That allows us to easily implement more comprehensive tests
>   that feed various syscalls all possible file descriptors and check that the
>   syscall fails properly with invalid combinations. Most notable use of this
>   library is the newly introduced splice07.c test.

> * The minimal size of the device for a few filesystem tests was increased to
>   1GB because modern filesystems, most notably Btrfs does not work properly on
>   smaller devices.

> * LTP now tests bcachefs if kernel support and bcache.mkfs is present

> * 30 testcases were converted to the new test library

> + The usual amount of fixes and cleanups

> NOTABLE CHANGES IN NETWORK TESTS
> ================================
> brought to you by Petr Vorel

> The performance tests in net.features can be now skipped by setting
> LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE=1 which is useful when testing is
> executed on VMs on a overloaded host or if we are running tests with a
> background load.

> KIRK (previously RUNLTP-NG)
> ===========================

> Kirk was updated to v1.2

> This version brings the following updates:

>  - show both stdout and stderr when executing tests on host
>  - support for external commands on different SUTs
>  - warning message when SUT doesn't support parallel execution
>  - more stable epoll() communication with LTX
>  - minor fixes
>  - updated documentation

> DOWNLOAD AND LINKS
> ==================

> The latest version of the test-suite contains 3000+ tests for the Linux
> and can be downloaded at:

> https://github.com/linux-test-project/ltp/releases/tag/20240129

> The project pages as well as GIT repository are hosted on GitHub:

> https://github.com/linux-test-project/ltp
> http://linux-test-project.github.io/

> If you ever wondered how to write a LTP testcase, don't miss our developer
> documentation at:

> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines

> https://github.com/linux-test-project/ltp/wiki/C-Test-API

> https://github.com/linux-test-project/ltp/wiki/C-Test-Network-API

> https://github.com/linux-test-project/ltp/wiki/Shell-Test-API

> https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial

> https://github.com/linux-test-project/ltp/wiki/Build-System

> Patches, new tests, bugs, comments or questions should go to to our mailing
> list at ltp@lists.linux.it.

> CREDITS
> =======

> Many thanks to the people contributing to this release:

> git shortlog -s -e -n 20230929..

>    147  Petr Vorel <pvorel@suse.cz>
>     25  Yang Xu <xuyang2018.jy@fujitsu.com>
>     21  Andrea Cervesato <andrea.cervesato@suse.com>
>     18  Martin Doucha <mdoucha@suse.cz>
>     12  Cyril Hrubis <chrubis@suse.cz>
>     11  Marius Kittler <mkittler@suse.de>
>      8  Wei Gao <wegao@suse.com>
>      7  Amir Goldstein <amir73il@gmail.com>
>      7  Richard Palethorpe <rpalethorpe@suse.com>
>      6  Avinesh Kumar <akumar@suse.de>
>      6  Edward Liaw <edliaw@google.com>
>      6  Jan Kara <jack@suse.cz>
>      5  Jan Stancek <jstancek@redhat.com>
>      4  Hongchen Zhang <zhanghongchen@loongson.cn>
>      4  Kevin Brodsky <kevin.brodsky@arm.com>
>      4  Xiao Yang <yangx.jy@fujitsu.com>
>      3  Shiyang Ruan <ruansy.fnst@fujitsu.com>
>      2  Li Wang <liwang@redhat.com>
>      2  Li Zhijian <lizhijian@fujitsu.com>
>      2  Pengfei Xu <pengfei.xu@intel.com>
>      2  Stefan Roesch <shr@devkernel.io>
>      1  Alexander Kanavin <alex@linutronix.de>
>      1  Brennan Ashton <bashton@brennanashton.com>
>      1  Korobeynikov Gleb <mathkgd@mail.ru>
>      1  Marcos Paulo de Souza <mpdesouza@suse.com>
>      1  Mengchi Cheng <mengcc@amazon.com>
>      1  Murphy Zhou <jencce.kernel@gmail.com>
>      1  Shizhao Chen <shichen@redhat.com>
>      1  Shoukui Zhang <zhangshoukui@xiaomi.com>
>      1  Subramanya Swamy <subramanya.swamy.linux@gmail.com>
>      1  haopengxiang <haopengxiang@xiaomi.com>
>      1  nietingting <nietingting@xiaomi.com>
>      1  wangxuewen <wangxuewen@kylinos.cn>
>      1  ybonatakis <ybonatakis@suse.com>

> And also thanks to patch reviewers:

> git log 20230929.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r

>     111 Petr Vorel <pvorel@suse.cz>
>      70 Cyril Hrubis <chrubis@suse.cz>
>      47 Li Wang <liwang@redhat.com>
>      35 Richard Palethorpe <rpalethorpe@suse.com>
>      14 Martin Doucha <mdoucha@suse.cz>
>       8 Amir Goldstein <amir73il@gmail.com>
>       7 Xiao Yang <yangx.jy@fujitsu.com>
>       7 Marius Kittler <mkittler@suse.de>
>       6 Jan Kara <jack@suse.cz>
>       4 Avinesh Kumar <akumar@suse.de>
>       3 Andrea Cervesato <andrea.cervesato@suse.com>
>       3 Jan Stancek <jstancek@redhat.com>
>       2 Yang Xu <xuyang2018.jy@fujitsu.com>
>       1 Petr Vorel <petr.vorel@gmail.com>
>       1 Christian Brauner <brauner@kernel.org>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
