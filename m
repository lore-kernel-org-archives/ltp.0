Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162D6C71136
	for <ltp@archiver.kernel.org>; Thu, 12 Jun 2025 11:50:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07A853CB3A1
	for <ltp@archiver.kernel.org>; Thu, 12 Jun 2025 13:50:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2858C3C23AC
 for <ltp@lists.linux.it>; Thu, 12 Jun 2025 13:50:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 543AE200967
 for <ltp@lists.linux.it>; Thu, 12 Jun 2025 13:50:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F246821187;
 Thu, 12 Jun 2025 11:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749729035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JXaehDB7n7WvRkV4AWEyssU78gB6M5+fAvZaRKd1tqw=;
 b=Jc35+RgUmf24nZGZtWeSotk+R+FfTMnpEfqNM8JRo8HaGvSHSwDwxqRBDHM9IjIRmRj5JE
 cdZDwPuSQryVRmJmdKPU2EUY3VbD0Bdr+RWnOCGQD8IvXHZGBnjqOieGtWYectU+Zu3q9d
 IiV+eMhOOIim5TCLIhxh6NT3Q/zcPFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749729035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JXaehDB7n7WvRkV4AWEyssU78gB6M5+fAvZaRKd1tqw=;
 b=NyoAlKrlG07lZbmyJId+ufygqT7nk4rWEkYpnYp8Sx5nngSx2CUc4nLPeB3fnzqF4OVfCJ
 uhhCsPDcAHzJvDAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Jc35+RgU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NyoAlKrl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1749729035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JXaehDB7n7WvRkV4AWEyssU78gB6M5+fAvZaRKd1tqw=;
 b=Jc35+RgUmf24nZGZtWeSotk+R+FfTMnpEfqNM8JRo8HaGvSHSwDwxqRBDHM9IjIRmRj5JE
 cdZDwPuSQryVRmJmdKPU2EUY3VbD0Bdr+RWnOCGQD8IvXHZGBnjqOieGtWYectU+Zu3q9d
 IiV+eMhOOIim5TCLIhxh6NT3Q/zcPFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1749729035;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JXaehDB7n7WvRkV4AWEyssU78gB6M5+fAvZaRKd1tqw=;
 b=NyoAlKrlG07lZbmyJId+ufygqT7nk4rWEkYpnYp8Sx5nngSx2CUc4nLPeB3fnzqF4OVfCJ
 uhhCsPDcAHzJvDAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB58B132D8;
 Thu, 12 Jun 2025 11:50:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id H6BFNAq/SmiNawAAD6G6ig
 (envelope-from <akumar@suse.de>); Thu, 12 Jun 2025 11:50:34 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Jun 2025 13:50:34 +0200
Message-ID: <13785793.uLZWGnKmhe@thinkpad>
In-Reply-To: <20250610104538.15687-1-chrubis@suse.cz>
References: <20250610104538.15687-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F246821187
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; CTE_CASE(0.50)[];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:email, suse.de:dkim, suse.de:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: Add testers guide
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tuesday, June 10, 2025 12:45:38 PM CEST Cyril Hrubis wrote:
> While we have added a documentation on supported kernels, compilers, how
> to compile and run LTP etc. Some kind of a comprehensive guide for
> people new to LTP and kernel testing was missing. This patch adds a
> short guide that tries to explain some of the pitfalls of kernel
> testing. Feel free to point out what is missing and suggest additional
> chapters.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Reviewed-by: : Wei Gao <wegao@suse.com>

Reviewed-by: Avinesh Kumar <akumar@suse.de>

Few spelling corrections below.

> ---
> 
> Changes againts the RFC:
> 
> - fixed many typos
> - added a paragraph about filesystems
> - added links and some formatting
> 
>  doc/index.rst               |   1 +
>  doc/users/testers_guide.rst | 151 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 152 insertions(+)
>  create mode 100644 doc/users/testers_guide.rst
> 
> diff --git a/doc/index.rst b/doc/index.rst
> index c00a59d31..acd16cdbf 100644
> --- a/doc/index.rst
> +++ b/doc/index.rst
> @@ -9,6 +9,7 @@
>  
>     users/quick_start
>     users/setup_tests
> +   users/testers_guide
>     users/supported_systems
>     users/stats
>     users/test_catalog
> diff --git a/doc/users/testers_guide.rst b/doc/users/testers_guide.rst
> new file mode 100644
> index 000000000..86f8006f9
> --- /dev/null
> +++ b/doc/users/testers_guide.rst
> @@ -0,0 +1,151 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Testers guide to the Linux test project
> +=======================================
> +
> +While we try to make LTP work out of the box as much as possible there are
> +still many things that testers need to consider before the actual testing
> +starts. It's advisable to make a test plans in order to asses and formalize the
s/a test plans/a test plan
> +expected test coverage or even just sit down for a while and consider different
> +aspects of the problem at hand.
> +
> +
> +Is testing even required?
> +-------------------------
> +
> +Sometimes people tend to make an argument that there is no need to test the
> +Linux kernel because it's heavily tested in upstream and hence very stable.
> +That may be true, or at least one can say that upstream releases are not
> +terribly unstable.
> +
> +However that argument holds only as long as you take the upstream sources
> +verbatim, i.e. without any modifications and that includes taking the default
> +`.config` options too. Once you stray away from what you consider the stable
> +upstream source you introduce differences in behavior, possible bugs and
> +problems into your codebase. That applies to patch backports too, it's quite
> +easy to miss pre-requisites when backporting patches which may result in all
> +kinds of breakages.
> +
> +
> +Multi dimensionality
> +--------------------
> +
> +First of all kernel testing is a multi dimensional problem, just compiling and
> +running LTP will give you some coverage but very likely not enough. There are
> +several big gaps that may be easily missed.
> +
> +For example 64bit Linux kernel provides compatibility layer for 32bit
> +applications which code quality is usually a bit worse than the 64bit ABI.
s/which code/whose code
> +Hence recompiling LTP with `-m32` in compiler flags and running both 64bit
> +and 32bit test binaries is a good start. If you try to make an argument that
> +your application does not need 32bit support it's better to disable the compat
> +layer completely since it's possible source of security bugs.
> +
> +Another dimension is the number of architectures you need to test, for a
> +general distribution testing you may end up with a couple of them. Different
> +architectures have different platform code as well as differences in memory
> +orderings, etc. that all means that running tests on one architecture out of
> +several will give you incomplete coverage.
> +
> +Since most of the POSIX API deals with files the choise of filesystem for the
s/files the choise/files, the choice
> +testing changes the focus and coverage too. LTP defaults to using `/tmp/` as
> +a temporary directory for the tests. If `/tmp/` is mounted as tmpfs subset of
> +tests will be skipped, if that is the case it's advisable to point environment
> +variable `TMPDIR` to a path with a different filesystem instead. Then there
> +are tests that format a device with a filesystem. LTP defaults to `ext2` and
> +loop devices for these testcases, that can be changed with environment
> +variables as well. Lastly but not least a few testcases repeat the test for all
> +supported filesystem, if you are interested in testing on a single filesystem
> +only you can limit these tests to a single filesystem too. See the tests setup
s/only/only,
> +for a comprehensive list of the `evironment variables
> +<setup_tests.html#library-environment-variables>`_.
> +
> +They you also have to decide if you are going to run tests in virtual machine
s/They/Then
> +e.g. `qemu-kvm`, on bare metal or both. Testing in virtual machine will give you
> +about 90% of the coverage for bare metal and vice versa.
> +
> +There are other options worth of consideration too, Linux kernel has many
> +debugging options that are usually disabled on runtime since they incur
> +significant performance penalty. Having a few more LTP testruns with different
s/testruns/test runs
> +debug options enabled e.g. `KASAN
> +<https://www.kernel.org/doc/html/latest/dev-tools/kasan.html>`_ or `KMEMLEAK
> +<https://www.kernel.org/doc/html/latest/dev-tools/kmemleak.html>`_ may help
> +catch bugs before they materialize in production.
> +
> +In practice your test matrix may easily explode and you may end up with dozens
> +of differently configured testruns based on different considerations. The hard
s/testruns/test runs
> +task at hand is not to have too many since computing power is not an infinite
> +resource and does not scale that easily. If you managed to read up to this
> +point *"Don't Panic!"* things are almost never as bad as they may seem at first
> +glance.
> +
> +It's a good idea to start small with an environment that models your
> +production.  Once that works well you can try different configurations. Select
> +a few interesting ones and run them for some time in order to get an idea of
> +their usefulness. If you are feeling adventurous you may try to measure and
> +compare actual test coverage with one of the tools such as `gcov
> +<https://www.kernel.org/doc/html/latest/dev-tools/gcov.html>`_ and `lcov
> +<https://github.com/linux-test-project/lcov>`. If you do so do not fall into a
> +trap of attempting to have 100% line coverage. Having 100% of lines executed
> +during the test does not mean that your test coverage is 100%.  Good tests
> +validate much more than just how much code from the tested binary was executed.
> +
> +You may need to sacrifice some coverage in order to match the tests runtime to
> +the available computing power. When doing so `Pareto principle
> +<https://en.wikipedia.org/wiki/Pareto_principle>`_ is your friend.
> +
> +
> +Test scope
> +----------
> +
> +So far we were talking about a code coverage from a point of maximizing test
> +coverage while keeping our test matrix as small as possible. While that is a
> +noble goal it's not the universal holy grail of testing. Different use cases
> +have different considerations and scope. For a testing before a final release
> +such testing is very desirable, however for a continuous integration or smoke
> +testing the main requirement is that feedback loops are as short as possible.
> +
> +When a developer changes the kernel and submits the changes to be merged it's
> +desirable to run some tests. Again the hard question is which tests. If we run
> +all possible tests in all possible combinations it may take a day or two and
> +the developer will move to a different tasks before the tests have a chance to
> +finish. If you multiply that by a number of developers in the team you may end
> +up in a situation where a developer will retire before tests for his patch may
> +have had a chance to finish.
> +
> +In this case careful selection of tests is even more important. Having less is
> +more in this context. One of the first ideas for CI is to skip tests that run
> +for more than a second or so, happily this can be easily done with `kirk
> +<https://github.com/linux-test-project/kirk/>`_. In the future we may want to
> +explore some heuristics that would map the code changes in kernel into a subset
> +of tests, which would allow for a very quick feedback.
> +
> +
> +Debugging test failures
> +-----------------------
> +
> +You may think that you will enjoy some rest once you have your test matrix
> +ready and your tests are running. Unfortunately that's where the actual work
> +starts. Debugging test failures is probably the hardest part of the testing
> +process. In some cases failures are easily reproducible and it's not that hard
> +to locate the bug, either in the test or in the kernel itself. There are
> +however, quite common, cases where the test failure reproduces only in 10% or
> +even 1% of the test runs. Sometimes tests are not failing in isolation, that is
> +because operating system has a huge internal state and a test failure manifests
> +only after running right sequence of tests. All of that does not mean that
> +there is no bug, that usually means that the bug depends on more prerequisites
> +that have to manifest at the right time in order to trigger the failure. Sadly
> +for modern systems that are asynchronous in nature such bugs are more and more
> +common.
> +
> +The debugging process itself is not complicated by its nature. You have to
> +attempt to understand the failure by checking the logs, reading and
> +understanding the source code, debugging with strace, gdb, etc. Then form a
> +hypothesis and either prove or disprove it. Rinse and repeat until you end up
> +with a clear description of what went wrong. Hopefully you will manage to find
> +the root cause, but you should not be discouraged, if you do not. Debugging
> +kernel bugs takes a lot of experience and skill one can say as much as is
> +needed to write the kernel code.
> +
> +
> +Happy testing!
> 


Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
