Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F67AC61CE8
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 13:20:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C8B443CA5E0
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 15:20:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F04463CA189
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 15:20:31 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DC0141A0081A
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 15:20:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CBA901FDA9
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749216029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sNVbIt8GgWxz+0Xad61YbEfJZR3sFDsYnnw+g5jwKWg=;
 b=YDSk5x5IRIe2VDtWttH3d2tnZ86zOAoUJF1rRWdSrN7/8uO8aglbsOCF9CopFnJuYHCO1l
 rVk8Rcky9/6yUHeNvPFNBNHS9yVDsr3zQfFg1J7ZTKGAQVV52l7ZRCh2kYZlFJX0dGqqig
 Hcxf/5ULJHvRP0xpmV1nIG3WFhS8rQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749216029;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sNVbIt8GgWxz+0Xad61YbEfJZR3sFDsYnnw+g5jwKWg=;
 b=1FeEBFSkDT/S9YKI1hDWo91SrPbujDYFiN1dCmf5ZnTkwvN/MD8HCfZUJux+w5vHbl32jk
 51JsrlSF8IR0YOBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749216028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sNVbIt8GgWxz+0Xad61YbEfJZR3sFDsYnnw+g5jwKWg=;
 b=JXYopWMEzhh9hAl+ajkF0WRtMfrp13wxF69qjL0sgJnsjk9nbK5JWpUp28k9rKByGV7h1S
 t8LT1ZXZTnzIlirJnujsGANGWbBnVTmqjBCRpVNHMdKfstee+s2dQQ2JHgnmZ/ji4A+eGp
 qCBGwrL1tOW5OHyLDZk2PlvLyot9+aQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749216028;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=sNVbIt8GgWxz+0Xad61YbEfJZR3sFDsYnnw+g5jwKWg=;
 b=lmktcp6SfnsrbsjFz9gkREJ1ZB1JMsD/rPHeV48qBOPp5CwxFuCIrpv4oSi5XlMpcVWIsd
 ohuKYzX1d5MgGXBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5D241336F
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 13:20:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Qm8gLBzrQmhweAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 06 Jun 2025 13:20:28 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  6 Jun 2025 15:21:00 +0200
Message-ID: <20250606132100.20145-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] [RFC] doc: Add testers guide
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

While we have added a documentation on supported kernels, compilers, how
to compile and run LTP etc. Some kind of a comprehensive guide for
people new to LTP and kernel testing was missing. This patch adds a
short guide that tries to explain some of the pitfalls of kernel
testing. Feel free to point out what is missing and suggest additional
chapters.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/index.rst               |   1 +
 doc/users/testers_guide.rst | 129 ++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)
 create mode 100644 doc/users/testers_guide.rst

diff --git a/doc/index.rst b/doc/index.rst
index c00a59d31..acd16cdbf 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -9,6 +9,7 @@
 
    users/quick_start
    users/setup_tests
+   users/testers_guide
    users/supported_systems
    users/stats
    users/test_catalog
diff --git a/doc/users/testers_guide.rst b/doc/users/testers_guide.rst
new file mode 100644
index 000000000..4232e8bef
--- /dev/null
+++ b/doc/users/testers_guide.rst
@@ -0,0 +1,129 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Testers guide to the Linux test project
+=======================================
+
+While we try to make LTP work out of the box as much as possible there are
+still many things that testers need to consider before the actual testing
+starts. It's advisable to make a test plans in order to asses and formalize the
+expected test coverage or even just sit down for a while and consider different
+aspects of the problem at hand.
+
+
+Is testing even required?
+-------------------------
+
+Sometimes people tend to make an argument that there is no need to test the
+Linux kernel because it's heavily tested in upstream and hence very stable.
+That may be true, or at least one can say that upstream releases are not
+terribly unstable.
+
+However that argument holds only as long as you take the upstream sources
+verbatim, i.e. without any modifications and that includes taking the default
+.config optioins too. Once you stray away from what you consider the stable
+upstream source you introduce diffencies in behavior, possible bugs and
+problems into your codebase. That applies to patch backports too, it's quite
+easy to miss pre-requisites when backporting patches which may result in all
+kinds of breakages.
+
+
+Multi dimensionality
+--------------------
+
+First of all kernel testing is a multi dimensional problem, just compiling and
+running LTP will give you some coverage but very likely not enough. There are
+several big gaps that may be easily missed.
+
+For example 64bit Linux kernel provides compatibility layer for 32bit
+applications which code quality is usually a bit worse than the 64bit ABI.
+Hence recompiling LTP with -m32 in compiler flags and runnig both 64bit and
+32bit test binaries is a good start. If you try to make an argument that your
+application does not need 32bit support it's better to disable the compat layer
+completely since it's possible source of security bugs.
+
+Another dimension is the number of architectures you need to test, for a
+general distribution testing you may end up with a couple of them. Different
+architectures have different platform code as well as differencies in memory
+orderings, etc. that all means that running tests on one architecture out of
+several will give you incomplete coverage.
+
+You also have to decide if you are going to run tests in virtual machine e.g.
+qemu-kvm, on bare metal or both. Testing in virtual machine will give you about
+90% of the coverage for bare metal and vice versa.
+
+There are other options worth of consideration too, Linux kernel has many
+debugging options that are usually disabled on runtime since they incur
+singificant performance penalty. Having a few more LTP testruns with different
+debug options enabled e.g. KASAN may help catch bugs before they materialize in
+production.
+
+In practice your test matrix may easily explode and you may end up with dozens
+of differently configured testruns based on different considerations. The hard
+taks at hand is not to have too many since computing power is not an infinite
+resource and does not scale that easily. If you managed to read up to this
+point "Don't Panic" things are almost never as bad as they may seem at first
+glance.
+
+It's a good idea to start small with an evironment that models your production.
+Once that works well you can try different configurations. Select a few
+interesting ones and run them for some time in order to get an idea of their
+usefulness. If you are feeling adventurous you may try to measure and compare
+actual test coverage with one of the tools such as lcov. If you do so do not
+fall into a trap of attempting to have 100% line coverage. Having 100% of lines
+executed during the test does not mean that your test coverage is 100%. Good
+tests validate much more than just how much code from the tested binary was
+executed.
+
+You may need to sacrifice some coverage in order to match the tests runtime to
+the available computing power. When doing so Pareto principle is your friend.
+
+
+Test scope
+----------
+
+So far we were talking about a code coverage from a point of maximizing test
+coverage while keeping our test matrix as small as poissible. While that is a
+noble goal it's not the universal holy grail of testing. Different use cases
+have different considerations and scope. For a testing before the final release
+such testing is very desirable, however for a continuous integration or smoke
+testing the main requirement is that feedback loops are as short as possible.
+
+When a developer changes the kernel and submits the changes to be merged it's
+desirable to run some tests. Again the hard question is which tests. If we run
+all possible tests in all possible combinations it may take a day or two and
+the developer will move to a diffrent tasks before the tests have a chance to
+finish. If you multiply that by a number of developers in the team you may end
+up in a situation where a developer will retire before tests for his patch may
+have chance to finish.
+
+In this case careful selection of tests is even more important. Having less is
+more in this context. One of the first ideas for CI is to skip tests that run
+for more than a second or so, happily this can be easily done with kirk. In the
+future we may want to explore some heuristics that would map the code changes
+in kernel into a subset of tests, which would allow for a very quick feedback.
+
+
+Debugging test failures
+-----------------------
+
+You may think that you will enjoy some rest once you have your test matrix
+ready and your tests are running. Unfortunatelly that's where the actual work
+starts. Debugging test failures is probably the hardest part of the testing
+process. In some cases failures are easily reproducible and it's not that hard
+to locate the bug, either in the test or in the kernel itself. There are
+however, quite common, cases where the test failure reproduces only in 10% or
+even 1% of the test runs. That does not mean that there is no bug, that usually
+means that the bug depends on more prerequisities that have to manifest at the
+right time in order to trigger the failure. Sadly for modern systems that are
+asynchronous in nature such bugs are more and more common.
+
+The debugging process itself is not complicated at its nature. You have to
+attempt to undestand the failure by checking the logs, reading the source code,
+debugging with strace, gdb, etc. Then form a hypotesis and either prove or
+disprove it. Rinse and repeat until you end up with a clear description of what
+went wrong. Hopefully you will manage to find the root cause but you should not
+be discouraged if you do not. Debugging kernel bugs takes a lot of experience
+and skill one cay say as much as is needed write the kernel code.
+
+
+Happy testing!
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
