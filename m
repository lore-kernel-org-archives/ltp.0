Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB66BC5AD49
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 15:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749222218; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=afWJKPfZdXjJAYVoTpDxe4Ehma23J2WWWPR4J0eFJ6E=;
 b=fmoeOsuB38z0uX5nTr/bkUgQzyjAcX9gZYh/w7akfnnMLQj4mesYEr6SsuCN1cYXA/J7X
 y5m7tMFcuV61/tORSHeL0DfnEt2hQwU0vM/75L+yj6D131WPfHuS1+eNWgbnqIlK7yzx43h
 Pf9Gj6PeRMTsLb/HGQM6Jp4196KCwh8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DA053CA63C
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 17:03:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DABD3C9A93
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 17:03:16 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5912A1400968
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 17:03:15 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a3798794d3so1764141f8f.1
 for <ltp@lists.linux.it>; Fri, 06 Jun 2025 08:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749222195; x=1749826995; darn=lists.linux.it;
 h=in-reply-to:references:subject:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L7jX+Xw6VlJkK6VlGLEtzfGueduosz4ZY75ohQoycUQ=;
 b=MjEG3QxFfRkrk2SMHyVeNp3DYzwgFLnCRdcIzaoll7S7HcM2toPiYx9ttg3kI5hsq2
 T/DYoKbD2nww6RCefdduFB3qXW76SA6CKlKjC0sXpHqcVhPLpsnGfW6JPaC/Hh40hCAM
 AYmeP/pJTos6XpZEuNTnejiERQD+uPSzqDfSgac8ZceuUYOpz4kYQ/6keBo6kJwqlHEw
 n4lXcZDsfgvdQlBvykhayUGZzgxD492ij/ywppZwt0afW3m5Eu93gn0IadE+weGX06OD
 jOAFwtnA+QMy0TKlH9vNNWraW5ujpwjN6NYVdj2PsyQEYExbIQB6lR0tpOHo2hyQo37X
 susg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749222195; x=1749826995;
 h=in-reply-to:references:subject:to:cc:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L7jX+Xw6VlJkK6VlGLEtzfGueduosz4ZY75ohQoycUQ=;
 b=BdPsKkGJfgDVZw0PgMToxApD8P6vYX0KjGs9GojSxwwy6ILLsNEDjOrKGWT9eBGJ+1
 c6g6v/HF0nx8K0+Yu7ULq/+pHAo7wXMcDT6EUpeVOi+TJRwNh5714rnm8UgaCRQS3L8O
 QeGwfpJIw9FAQjPtbecuInUgMNpYrLrIjkSFyw1bQpKieBAYUga+j0jE9AIwdMe/9Iht
 gYoRn14BM1BcovWCLIshzX6Di1kzoyAy4kZ9NgaBqhbWK8d65W0Tmr0kduOhBE+uwMNq
 Q7Q4rzgkVd7TJUy9s71KhyrqD2s3e5iJfDiywGnYFeQkSMD5D+qGTPFSrunGZ53BwFC8
 42rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVkgXGOsysXqqGjL8xZVleE4MbFVHJwdpCHafSxq+AYIiAErgbpFVHhfv5JNEK+PK5A9E=@lists.linux.it
X-Gm-Message-State: AOJu0YzXuFO+RLDKcI/EDnZfwF1mvS1QbdjpIoLFzjxG60UBkUGA9Kdq
 WQkRPM7Ig09SXviy9ZAXlfSjqTNfGATHFO5s1gurvyBCUe7MXZnUO6KfTNw4rYn4tXKmhnmjY/Y
 g7NJ3
X-Gm-Gg: ASbGnctUdmrTcYn4vLCE/Vi0IfncqEdryoYy/DInRPfcffGZlOPQjV7QgALk32Z/Cxv
 8oEl3RDTtfuUPap5WsqNL3sGU/iJzOV7Tn+CaU0UxnoRyh98zRDsZEwmQU4Gs/CASmLVQB0cyUd
 ugWedHNaKkHgw6OxrCiFAeZ3x7I40j51Qt2CqcgVr/etziCjnyyOJYrVrt0L1aSzQ1eZzSoHVSi
 kx6OHsOFoC48xpH+Y1GYlwxeX/9PbJLctXd/8h+LUcXKSkBJlFv44ktcXUccomKh6NwF+xTu27K
 acXZRaN+LXEaeBI+SorFRg68ZaeBywbOS80qLpociyb3Cw9l
X-Google-Smtp-Source: AGHT+IGD6eh6X5YvnCiOnbjOpgWwGPsT2y9t1LTcW7zrMdWQPAq/8zhnjqMeUMFkc6eMk/wopDJo4g==
X-Received: by 2002:a05:6000:2482:b0:3a4:ec32:e4f3 with SMTP id
 ffacd0b85a97d-3a531ab517emr2867080f8f.17.1749222194228; 
 Fri, 06 Jun 2025 08:03:14 -0700 (PDT)
Received: from localhost ([189.99.236.12]) by smtp.gmail.com with UTF8SMTPSA id
 71dfb90a1353d-530e6429475sm1234338e0c.45.2025.06.06.08.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 08:03:13 -0700 (PDT)
Mime-Version: 1.0
Date: Fri, 06 Jun 2025 12:03:09 -0300
Message-Id: <DAFJIK6CJSHJ.OL9N7OOAWO9P@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250606132100.20145-1-chrubis@suse.cz>
In-Reply-To: <20250606132100.20145-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] [RFC] doc: Add testers guide
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

That's very good, thanks for writing this. A few minor typos and
suggestions below.

On Fri Jun 6, 2025 at 10:21 AM -03, Cyril Hrubis wrote:
> While we have added a documentation on supported kernels, compilers, how
> to compile and run LTP etc. Some kind of a comprehensive guide for
> people new to LTP and kernel testing was missing. This patch adds a
> short guide that tries to explain some of the pitfalls of kernel
> testing. Feel free to point out what is missing and suggest additional
> chapters.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  doc/index.rst               |   1 +
>  doc/users/testers_guide.rst | 129 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 130 insertions(+)
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
> index 000000000..4232e8bef
> --- /dev/null
> +++ b/doc/users/testers_guide.rst
> @@ -0,0 +1,129 @@
> +.. SPDX-License-Identifier: GPL-2.0-or-later
> +
> +Testers guide to the Linux test project
> +=======================================
> +
> +While we try to make LTP work out of the box as much as possible there are
> +still many things that testers need to consider before the actual testing
> +starts. It's advisable to make a test plans in order to asses and formalize the
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
> +.config optioins too. Once you stray away from what you consider the stable

optioins

> +upstream source you introduce diffencies in behavior, possible bugs and

diffencies

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
> +Hence recompiling LTP with -m32 in compiler flags and runnig both 64bit and
> +32bit test binaries is a good start. If you try to make an argument that your
> +application does not need 32bit support it's better to disable the compat layer
> +completely since it's possible source of security bugs.
> +
> +Another dimension is the number of architectures you need to test, for a
> +general distribution testing you may end up with a couple of them. Different
> +architectures have different platform code as well as differencies in memory
> +orderings, etc. that all means that running tests on one architecture out of
> +several will give you incomplete coverage.
> +
> +You also have to decide if you are going to run tests in virtual machine e.g.
> +qemu-kvm, on bare metal or both. Testing in virtual machine will give you about
> +90% of the coverage for bare metal and vice versa.
> +
> +There are other options worth of consideration too, Linux kernel has many
> +debugging options that are usually disabled on runtime since they incur
> +singificant performance penalty. Having a few more LTP testruns with different

singificant

> +debug options enabled e.g. KASAN may help catch bugs before they materialize in
> +production.
> +
> +In practice your test matrix may easily explode and you may end up with dozens
> +of differently configured testruns based on different considerations. The hard
> +taks at hand is not to have too many since computing power is not an infinite

taks

is to not have ?

> +resource and does not scale that easily. If you managed to read up to this
> +point "Don't Panic" things are almost never as bad as they may seem at first
> +glance.
> +
> +It's a good idea to start small with an evironment that models your production.

evironment

> +Once that works well you can try different configurations. Select a few
> +interesting ones and run them for some time in order to get an idea of their
> +usefulness. If you are feeling adventurous you may try to measure and compare
> +actual test coverage with one of the tools such as lcov. If you do so do not
> +fall into a trap of attempting to have 100% line coverage. Having 100% of lines
> +executed during the test does not mean that your test coverage is 100%. Good
> +tests validate much more than just how much code from the tested binary was
> +executed.
> +
> +You may need to sacrifice some coverage in order to match the tests runtime to
> +the available computing power. When doing so Pareto principle is your friend.
> +
> +
> +Test scope
> +----------
> +
> +So far we were talking about a code coverage from a point of maximizing test

about code coverage ?

> +coverage while keeping our test matrix as small as poissible. While that is a

poissible

> +noble goal it's not the universal holy grail of testing. Different use cases
> +have different considerations and scope. For a testing before the final release
> +such testing is very desirable, however for a continuous integration or smoke
> +testing the main requirement is that feedback loops are as short as possible.
> +
> +When a developer changes the kernel and submits the changes to be merged it's
> +desirable to run some tests. Again the hard question is which tests. If we run
> +all possible tests in all possible combinations it may take a day or two and
> +the developer will move to a diffrent tasks before the tests have a chance to
> +finish. If you multiply that by a number of developers in the team you may end
> +up in a situation where a developer will retire before tests for his patch may
> +have chance to finish.
> +
> +In this case careful selection of tests is even more important. Having less is
> +more in this context. One of the first ideas for CI is to skip tests that run
> +for more than a second or so, happily this can be easily done with kirk. In the
> +future we may want to explore some heuristics that would map the code changes
> +in kernel into a subset of tests, which would allow for a very quick feedback.
> +
> +
> +Debugging test failures
> +-----------------------
> +
> +You may think that you will enjoy some rest once you have your test matrix
> +ready and your tests are running. Unfortunatelly that's where the actual work

Unfortunatelly

> +starts. Debugging test failures is probably the hardest part of the testing
> +process. In some cases failures are easily reproducible and it's not that hard
> +to locate the bug, either in the test or in the kernel itself. There are
> +however, quite common, cases where the test failure reproduces only in 10% or

quite commonly ?

> +even 1% of the test runs. That does not mean that there is no bug, that usually
> +means that the bug depends on more prerequisities that have to manifest at the
> +right time in order to trigger the failure. Sadly for modern systems that are
> +asynchronous in nature such bugs are more and more common.
> +
> +The debugging process itself is not complicated at its nature. You have to
> +attempt to undestand the failure by checking the logs, reading the source code,
> +debugging with strace, gdb, etc. Then form a hypotesis and either prove or
> +disprove it. Rinse and repeat until you end up with a clear description of what
> +went wrong. Hopefully you will manage to find the root cause but you should not
> +be discouraged if you do not. Debugging kernel bugs takes a lot of experience
> +and skill one cay say as much as is needed write the kernel code.

needed to ?

> +
> +
> +Happy testing!


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
