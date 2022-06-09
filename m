Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD80C43334
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 11:25:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D88103C91D2
	for <ltp@archiver.kernel.org>; Thu,  9 Jun 2022 13:25:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E82043C910C
 for <ltp@lists.linux.it>; Thu,  9 Jun 2022 13:25:43 +0200 (CEST)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BF15B14004EC
 for <ltp@lists.linux.it>; Thu,  9 Jun 2022 13:25:42 +0200 (CEST)
Received: from [10.40.94.1] (unknown [37.24.96.116])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 5CEE69F6A4
 for <ltp@lists.linux.it>; Thu,  9 Jun 2022 11:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1654773941; bh=vT86ORW6pTYJqpwJxeRAbid7rwJdN4sN8dINOHI5eVo=;
 h=Message-ID:Date:MIME-Version:To:From:Subject;
 b=uSOIHqt7s5s0ifheA+l6aveHYJA7bcg5fU8ZlEcwWnp1SsYR92afB0XK4jDX9HvLI
 PYw9cnSvUC9EGY4tSFOywnY5U20kA3DoxNqvwu3lD29Ned56AaxGs29ZxNeeBp8iug
 ZZHA0HXIqYbzQvP+28ktl+gqUD44qDjO03q51S68=
Message-ID: <3e9f91c4-b94b-21c4-4cfa-cb39af5e1110@jv-coder.de>
Date: Thu, 9 Jun 2022 13:25:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Content-Language: en-US
To: LTP List <ltp@lists.linux.it>
From: Joerg Vehlow <lkml@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] Open Posix Testsuite install layout
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

Hi,

I am currently reviewing openembedded's recipe ([1]). It is currently
installing the openposix testsuite twice: Once in
/opt/ltp/testcases/open_posix_testsuite and also directly into
/opt/ltp/. This is probably due to the fact, that the open posix
testsuite had no install target until 20110606 and then it was installed
into a different directory:




In 3b808b4 ("Add install target; shuffle around/cleanup code."), make
install was added to open posix testsuite, but the install layout is a
bit odd.

It installs:

/opt/ltp/bin/run-all-posix-option-group-tests.sh
/opt/ltp/bin/t0
/opt/ltp/bin/run-tests.sh
/opt/ltp/bin/Makefile
/opt/ltp/bin/run-posix-option-group-test.sh

This is mostly ok, although run-tests.sh should be called
run-posix-tests.sh, otherwise it looks like it would run "normal" ltp tests.
And the scripts are structured a bit weird, at least
run-all-posix-option-group-tests.sh and run-posix-option-group-test.sh
could be merged into a single script. And
run-all-posix-option-group-tests.sh does not execute all tests, but only
(maybe not even all) conformance/interface tests. Based on the name of
the script and the available documentation, this makes sense, but I
don't see how these scripts are useful. Why would anyone want to only
run tests for optional posix features, but not for other?

The Makefile shouldn't be installed at all.


But what is worth is the fact, that the open posix testsuites are
installed directly into /opt/ltp

/opt/ltp/stress
/opt/ltp/conformance
/opt/ltp/functional

They should be installed into /opt/ltp/testcases/open_posix_testsuite or
maybe /opt/ltp/open_posix_testsuite otherwise it is very confusing.
This would of course require the shell scripts, that execute open posix
tests to be changed during installation (currently they use "$(dirname
"$0")/../conformance/interfaces"). Additionally all generated run.sh
scripts would need adaption, as they use run-tests.sh.



I would propose and volunteer to:
1. Move testsuites to /opt/ltp/testcases/open_posix_testsuite
2. Move run-tests.sh and t0 to /opt/ltp/testcases
   /open_posix_testsuite/bin, because it is only used by run.sh scriptss
   from the suites directories
3. Fix paths in run-posix-option-group-test.sh during installation
   (or drop them completely? Are they even used by anyone?)
2. Remove the Makefile from /opt/ltp/bin



For the future it would probably be a good idea to integrate the tests
into the default ltp testrunner or at least provide something, that can
execute the installed tests automatically. But to be honest, I don't
care about this, because we are executing the tests with our own testrunner.


Joerg

[1]
https://git.openembedded.org/openembedded-core/tree/meta/recipes-extended/ltp/ltp_20220527.bb

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
