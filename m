Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA7AC4828D
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 09:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1707124870; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=5Zm8iPMTbc5GE//h/2mQXsGMKAFhRftxAItL3Ps4L4Y=;
 b=a8bY0XE9MGz1EotVY/zhCVIShSVo6ZWFklkjUVJFQmNlaUFMRqvBLa0U9I3TRcsoGW2mJ
 rs60yxLkOXD4/48MXWtAW5G3xJfZq3tcgJAU9ctM39NioJD1V3hQMKHwWI4HHobs7mQPDGr
 fwMSdSffp2/X6GqM3Y6LxcDrgJNMSOA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53D3A3CC6CE
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 10:21:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10FDB3C9799
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 10:20:47 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F1A801A00700
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 10:20:46 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40fc65783aeso25264585e9.2
 for <ltp@lists.linux.it>; Mon, 05 Feb 2024 01:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1707124846; x=1707729646; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Uo2G2GblDUMRw6SWrq1o/75afAcnJtgGVIv3FKTC0RE=;
 b=CCKfjEoRaS/k+K+7AJSElvdJA6aw3SkXTIvJ2+/7gK/PDwD1Zh9cTa6R7paLijIu2F
 GCenMZFPCEQa2xYKyZ1+lNtQQweCTRVqTB/8zT8UjFQkuweyU2O7J+QvjsSxMtZnzzp5
 gbMxRLBpxcCtWuXzW9PioeZxAcKcfisDC9igHz9UUk4WAT8FNvnfOYdYvZGNykOxpatY
 gN8iG+zykq76sOAEZAaSGvg+RWoFrCJu1L8a+PK0jHYmzWYZ6x+nApfO9O+tbPQsN2j8
 DkXS4YvSaF1Wr4SWwUcbvFaU3Uv0RxTAxMYZkGZ+gBzlC90fGiOlajVsNKvXb7rSa3i0
 dJBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707124846; x=1707729646;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Uo2G2GblDUMRw6SWrq1o/75afAcnJtgGVIv3FKTC0RE=;
 b=inpnpAuNcZSmxtE4WSodOkdjRTb6vwmXxheuzCzHmXInOmTuRuYWs9lUB3m8U6oi53
 NTfgwq5qhZx9dFwLpl7Ou0B7fKEO4i3K80GSqkeBaRIY7ewJOVRPjGQablBlmruG9Cas
 qJgAG1xP2Fl4VAalQrOxxDf0n/ocgTDA45a8b2P0M6arXp8C0oiDB36iWOqCQmIXSQSz
 7C6OTYSOxfi+omTdJC/VQlDdnq8/qx8HyExa3Gf7a8XaocQWVnqUR6lmK8rTfPAIzfAf
 NSWc83IjfFYERamV3UavVdK2NdtUlP404/8BDurR5d0JtqRGMR/xDItBDDzY2FXmBF6F
 KSHA==
X-Gm-Message-State: AOJu0YzBidra0YCHAMHKRk3sDcL/CH0tCsEKpnPau+MRPx3YwebryznP
 NuZ1vGKYgFwCBPWicx50ccxFNJjH8zn765um6DDHYk16dgwhxEW+w3c5MiMMLB9cb1YYJ95ehPB
 ltJk=
X-Google-Smtp-Source: AGHT+IHUhi0+50IONlMey9KTEJeN7+Ed3w1GoolqQqQXh7JDUyXJ5tlD6vE2br7B48GhsiVEH1f8Zw==
X-Received: by 2002:a05:600c:1550:b0:40e:c047:9348 with SMTP id
 f16-20020a05600c155000b0040ec0479348mr3927044wmg.15.1707124845511; 
 Mon, 05 Feb 2024 01:20:45 -0800 (PST)
Received: from [10.232.133.56] ([88.128.88.40])
 by smtp.gmail.com with ESMTPSA id
 s10-20020a05600c044a00b0040efc268713sm7886139wmb.26.2024.02.05.01.20.45
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Feb 2024 01:20:45 -0800 (PST)
Message-ID: <137b0984-044d-458d-ade1-bc205f5c8bfd@suse.com>
Date: Mon, 5 Feb 2024 10:20:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <ZbjZxy4vbxoXUJ-i@yuki>
Content-Language: en-US
In-Reply-To: <ZbjZxy4vbxoXUJ-i@yuki>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Thank you very much for your work guys!
In particular, thanks to Petr Vorel and Cyril Hrubis who worked really 
hard to make this release happen.

Best regards,
Andrea Cervesato

On 1/30/24 12:13, Cyril Hrubis wrote:
> Good news everyone,
>
> the Linux Test Project test suite stable release for *January 2024* has been
> released.
>
> Since the last release 315 patches by 34 authors were merged.
>
> Patch review is what most of the projects struggle with and LTP is no
> different. If you can spare some effort helping with the patch review is more
> than welcomed.
>
> NOTABLE CHANGES
> ===============
>
> * New tests
>    - splice07, accept03, readahead01:
>
>      Tests that feeds the syscall all kinds of invalid file descriptors and
>      checks that the syscall fails properly.
>
>     - proc_sched_rt01 a regression test for:
>
>       c1fc6484e1fb ("sched/rt: sysctl_sched_rr_timeslice show default timeslice after reset")
>       079be8fc6309 ("sched/rt: Disallow writing invalid values to sched_rt_period_us")
>
>    - ksm07 a test for KSM smart-scan.
>
>    - pathconf02 negative testcases for pathconf()
>
>    - pipe15 A regresson test for:
>
>      46c4c9d1beb7 ("pipe: increase minimum default pipe size to 2 pages")
>
>    - nft02 A regression test for:
>
>       515ad530795c ("netfilter: nf_tables: do not ignore genmask when looking up chain by id") aka CVE-2023-31248
>
>    - sched_setscheduler04 a test for SCHED_RESET_ON_FORK
>
>    - setsockopt10 2c02d41d71f9 ("net/ulp: prevent ULP without clone op from entering the LISTEN status") aka CVE-2023-0461
>
>    - gettid02 A basic gettid02 test.
>
>    - splice06 A test that splicing from a /proc files works.
>
> * Increased coverage
>
>     - ioctl02 cover more modern termios ioctls() as well.
>
>     - fanotify13 More test coverage for overlayfs.
>
>     - input* test now check UI_GET_NAME ioctl() too.
>
> * Removed tests
>
>     - fork12 Which was a naive fork bomb test, we do have other tests
>              (setrlimit01.c, ...) that better cover this scenario.
>
>     - mongo test framework
>
>       Which was test reiser, ext2 and jfs unmaintained for a decade.
>
>     - simple_tracer.c Tracing test from 2009 that does not compile anymore.
>
>     - runtest/fsx-linux This is consolidation of runtest files, since these test
>                         duplicated in ltp-aiodio.part3.
>
>     - testscripts/autofs{1,4}.sh, testscripts/sysfs.sh,
>       testscripts/ltp-scsi_debug.sh, testscripts/ltpdmmapper.sh
>
>       These were unmaintained and unused scripts.
>
>     - scsi/* A testsuite with a custom kernel module for kernel 2.5 that didn't
>              compile cleanly for decades.
>
>     - load_stress_all_kernel_modules.sh Broken for quite some time.
>
> * The LTP library now has a functions to iterate over different
>    file descriptors. That allows us to easily implement more comprehensive tests
>    that feed various syscalls all possible file descriptors and check that the
>    syscall fails properly with invalid combinations. Most notable use of this
>    library is the newly introduced splice07.c test.
>
> * The minimal size of the device for a few filesystem tests was increased to
>    1GB because modern filesystems, most notably Btrfs does not work properly on
>    smaller devices.
>
> * LTP now tests bcachefs if kernel support and bcache.mkfs is present
>
> * 30 testcases were converted to the new test library
>
> + The usual amount of fixes and cleanups
>
> NOTABLE CHANGES IN NETWORK TESTS
> ================================
> brought to you by Petr Vorel
>
> The performance tests in net.features can be now skipped by setting
> LTP_NET_FEATURES_IGNORE_PERFORMANCE_FAILURE=1 which is useful when testing is
> executed on VMs on a overloaded host or if we are running tests with a
> background load.
>
> KIRK (previously RUNLTP-NG)
> ===========================
>
> Kirk was updated to v1.2
>
> This version brings the following updates:
>
>   - show both stdout and stderr when executing tests on host
>   - support for external commands on different SUTs
>   - warning message when SUT doesn't support parallel execution
>   - more stable epoll() communication with LTX
>   - minor fixes
>   - updated documentation
>
> DOWNLOAD AND LINKS
> ==================
>
> The latest version of the test-suite contains 3000+ tests for the Linux
> and can be downloaded at:
>
> https://github.com/linux-test-project/ltp/releases/tag/20240129
>
> The project pages as well as GIT repository are hosted on GitHub:
>
> https://github.com/linux-test-project/ltp
> http://linux-test-project.github.io/
>
> If you ever wondered how to write a LTP testcase, don't miss our developer
> documentation at:
>
> https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
>
> https://github.com/linux-test-project/ltp/wiki/C-Test-API
>
> https://github.com/linux-test-project/ltp/wiki/C-Test-Network-API
>
> https://github.com/linux-test-project/ltp/wiki/Shell-Test-API
>
> https://github.com/linux-test-project/ltp/wiki/C-Test-Case-Tutorial
>
> https://github.com/linux-test-project/ltp/wiki/Build-System
>
> Patches, new tests, bugs, comments or questions should go to to our mailing
> list at ltp@lists.linux.it.
>
> CREDITS
> =======
>
> Many thanks to the people contributing to this release:
>
> git shortlog -s -e -n 20230929..
>
>     147  Petr Vorel <pvorel@suse.cz>
>      25  Yang Xu <xuyang2018.jy@fujitsu.com>
>      21  Andrea Cervesato <andrea.cervesato@suse.com>
>      18  Martin Doucha <mdoucha@suse.cz>
>      12  Cyril Hrubis <chrubis@suse.cz>
>      11  Marius Kittler <mkittler@suse.de>
>       8  Wei Gao <wegao@suse.com>
>       7  Amir Goldstein <amir73il@gmail.com>
>       7  Richard Palethorpe <rpalethorpe@suse.com>
>       6  Avinesh Kumar <akumar@suse.de>
>       6  Edward Liaw <edliaw@google.com>
>       6  Jan Kara <jack@suse.cz>
>       5  Jan Stancek <jstancek@redhat.com>
>       4  Hongchen Zhang <zhanghongchen@loongson.cn>
>       4  Kevin Brodsky <kevin.brodsky@arm.com>
>       4  Xiao Yang <yangx.jy@fujitsu.com>
>       3  Shiyang Ruan <ruansy.fnst@fujitsu.com>
>       2  Li Wang <liwang@redhat.com>
>       2  Li Zhijian <lizhijian@fujitsu.com>
>       2  Pengfei Xu <pengfei.xu@intel.com>
>       2  Stefan Roesch <shr@devkernel.io>
>       1  Alexander Kanavin <alex@linutronix.de>
>       1  Brennan Ashton <bashton@brennanashton.com>
>       1  Korobeynikov Gleb <mathkgd@mail.ru>
>       1  Marcos Paulo de Souza <mpdesouza@suse.com>
>       1  Mengchi Cheng <mengcc@amazon.com>
>       1  Murphy Zhou <jencce.kernel@gmail.com>
>       1  Shizhao Chen <shichen@redhat.com>
>       1  Shoukui Zhang <zhangshoukui@xiaomi.com>
>       1  Subramanya Swamy <subramanya.swamy.linux@gmail.com>
>       1  haopengxiang <haopengxiang@xiaomi.com>
>       1  nietingting <nietingting@xiaomi.com>
>       1  wangxuewen <wangxuewen@kylinos.cn>
>       1  ybonatakis <ybonatakis@suse.com>
>
> And also thanks to patch reviewers:
>
> git log 20230929.. | grep -Ei '(reviewed|acked)-by:' | sed 's/.*by: //' | sort | uniq -c | sort -n -r
>
>      111 Petr Vorel <pvorel@suse.cz>
>       70 Cyril Hrubis <chrubis@suse.cz>
>       47 Li Wang <liwang@redhat.com>
>       35 Richard Palethorpe <rpalethorpe@suse.com>
>       14 Martin Doucha <mdoucha@suse.cz>
>        8 Amir Goldstein <amir73il@gmail.com>
>        7 Xiao Yang <yangx.jy@fujitsu.com>
>        7 Marius Kittler <mkittler@suse.de>
>        6 Jan Kara <jack@suse.cz>
>        4 Avinesh Kumar <akumar@suse.de>
>        3 Andrea Cervesato <andrea.cervesato@suse.com>
>        3 Jan Stancek <jstancek@redhat.com>
>        2 Yang Xu <xuyang2018.jy@fujitsu.com>
>        1 Petr Vorel <petr.vorel@gmail.com>
>        1 Christian Brauner <brauner@kernel.org>



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
