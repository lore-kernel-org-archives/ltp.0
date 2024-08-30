Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A9F5CA0EE4
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 12:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725022252; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=GpF/Uv82XsMBqKnk2Vn9J3ezMqA6WTw/Vpptx4YgPjY=;
 b=RRv3MMy3Vg0gi5TRLrf7+YT89/ILQXQveMIv+hCp5fc4mPQ6eXQnoX0w7Pb+f5B5kV0pQ
 ZFhn05ABOhGmtoXCmRaeCe8++MohCAEXSgQ6olpEOmdwqWAt9gjXwiMRkIys1FOLNR35SrQ
 tL2acQ5mpaqVy+yx7IQUEXohefPRaNo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EFCB73D277E
	for <ltp@archiver.kernel.org>; Fri, 30 Aug 2024 14:50:51 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE0C63D277E
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 14:50:30 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BB5DF1400044
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 14:50:29 +0200 (CEST)
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5bf006f37daso3000223a12.1
 for <ltp@lists.linux.it>; Fri, 30 Aug 2024 05:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1725022229; x=1725627029; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zsT7tB1WGwSy1EExbeUWjbwMEap+Uk+UNuyMnlp9lNw=;
 b=bD0+E+nxEsWERZy+ohJ1/8d2q2hoeLbAB0XGQmpfsP2KfNtU+vumIwXoQ1RZf0JR7S
 nJD3Fod1SGGvrqGxcSJFD+T7nlI8/5ORqNRRcw3sdX0z++/ovc7psQZrflIYHq/kvvch
 ugCdD3SfswggY+fhuWtGrVJ1jwJSY+G0e4Nx70IixIztjhUeDdgXkrKKc1xBnl2GdaqM
 YiX2Yzh6sCGBShTWkSn/et16o8IEk+jmrsYFenHgWl8mdzlk3n3hZ620Djir9Xsof6yz
 7MdDCkjsuaHijGDEDkuuNgfAHZcxYnpCA9EhvCbntIQcS4ynq6YawOhMsOUoAm0kv/Ph
 zmuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725022229; x=1725627029;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zsT7tB1WGwSy1EExbeUWjbwMEap+Uk+UNuyMnlp9lNw=;
 b=lfMcynHrAINTQoTopxSPBJse3phrRfP782Ms1q1oI5e0cGcEybxb8Plv5oXf4ACSeW
 wp5MMsMqsdv1fG2z+ZMmxWOS/uQzdgGkZWeluX8Zt2Bz2RItWn0+gvRofdUukKmnPOCb
 8qqrdYap4oS0a1awhpYlcOrYthpc5PQf8R1WRWPqbfVcNdNdqW1Hnvp/SIoKZUrsbXsL
 2BUo9kbQF+C7Y4i9KsGo/wocBeANebQvAu858pxNMgz4D1MU+CfiKe4C7SB+hn+BMTJd
 gn6iq28YZaRMWQKRVFnaSHO6xXsAmqATGpA8/UPnnflAVDdXFWvyZSJwpM1FNtrHod8d
 CPdg==
X-Gm-Message-State: AOJu0YwPgLjGEObE2x3g8VQgWT1ka0uEaj/0sFwzcLrU08WTm8dGRzgK
 EefJQW5qj4nG3akASGTsN6+b/Tac66wnuSdZbsGG+LJ002l9qe7Kmipw+mx6azSrsCyoXG1mxBn
 0PZc=
X-Google-Smtp-Source: AGHT+IEj8QdcxtPeVhUydQagn8rSxS0PO3qxyVFYCJGdxWiMNr8luJt+5bUy673yT+MyRJnLL0uxvA==
X-Received: by 2002:a05:6402:50c7:b0:5be:fa53:f74 with SMTP id
 4fb4d7f45d1cf-5c22f698ab6mr2398540a12.0.1725022228143; 
 Fri, 30 Aug 2024 05:50:28 -0700 (PDT)
Received: from [10.232.133.87] ([88.128.90.2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c226ccfe84sm1901328a12.71.2024.08.30.05.50.27
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Aug 2024 05:50:27 -0700 (PDT)
Message-ID: <2781ac75-b91a-4846-8d97-e1d65fda82fc@suse.com>
Date: Fri, 30 Aug 2024 14:50:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240827120237.25805-1-chrubis@suse.cz>
 <20240827120237.25805-5-chrubis@suse.cz>
Content-Language: en-US
In-Reply-To: <20240827120237.25805-5-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/4] testcaes/lib: Add shell loader
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

Also is there a reason why we are adding tests to testcases/lib/tests ?

On 8/27/24 14:02, Cyril Hrubis wrote:
> This commit implements a shell loader so that we don't have to write a C
> loader for each LTP shell test. The idea is simple, the loader parses
> the shell test and prepares the tst_test structure accordingly, then
> runs the actual shell test.
>
> The format for the metadata in the shell test was choosen to be JSON
> because:
>
> - I didn't want to invent an adhoc format and JSON is perfect for
>    serializing data structures
> - The metadata parser for shell test will be trivial, it will just pick
>    the JSON from the comment, no parsing will be required
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> Reviewed-by: Richard Palethorpe <io@richiejp.com>
> ---
>   include/tst_test.h                            |   2 +-
>   testcases/lib/.gitignore                      |   1 +
>   testcases/lib/Makefile                        |   6 +-
>   testcases/lib/run_tests.sh                    |  21 +
>   testcases/lib/tests/shell_loader.sh           |  26 +
>   .../lib/tests/shell_loader_all_filesystems.sh |  27 +
>   .../lib/tests/shell_loader_filesystems.sh     |  33 ++
>   .../lib/tests/shell_loader_invalid_block.sh   |  26 +
>   .../tests/shell_loader_invalid_metadata.sh    |  15 +
>   testcases/lib/tests/shell_loader_kconfigs.sh  |  12 +
>   .../lib/tests/shell_loader_no_metadata.sh     |   8 +
>   .../lib/tests/shell_loader_supported_archs.sh |  12 +
>   testcases/lib/tests/shell_loader_tags.sh      |  15 +
>   testcases/lib/tests/shell_loader_tcnt.sh      |  15 +
>   .../lib/tests/shell_loader_wrong_metadata.sh  |  15 +
>   testcases/lib/tst_env.sh                      |   4 +
>   testcases/lib/tst_loader.sh                   |  11 +
>   testcases/lib/tst_run_shell.c                 | 491 ++++++++++++++++++
>   18 files changed, 738 insertions(+), 2 deletions(-)
>   create mode 100755 testcases/lib/tests/shell_loader.sh
>   create mode 100755 testcases/lib/tests/shell_loader_all_filesystems.sh
>   create mode 100755 testcases/lib/tests/shell_loader_filesystems.sh
>   create mode 100755 testcases/lib/tests/shell_loader_invalid_block.sh
>   create mode 100755 testcases/lib/tests/shell_loader_invalid_metadata.sh
>   create mode 100755 testcases/lib/tests/shell_loader_kconfigs.sh
>   create mode 100755 testcases/lib/tests/shell_loader_no_metadata.sh
>   create mode 100755 testcases/lib/tests/shell_loader_supported_archs.sh
>   create mode 100755 testcases/lib/tests/shell_loader_tags.sh
>   create mode 100755 testcases/lib/tests/shell_loader_tcnt.sh
>   create mode 100755 testcases/lib/tests/shell_loader_wrong_metadata.sh
>   create mode 100644 testcases/lib/tst_loader.sh
>   create mode 100644 testcases/lib/tst_run_shell.c
>
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 9871676a5..d0fa84a71 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -274,7 +274,7 @@ struct tst_fs {
>   	const char *const *mkfs_opts;
>   	const char *mkfs_size_opt;
>   
> -	const unsigned int mnt_flags;
> +	unsigned int mnt_flags;
>   	const void *mnt_data;
>   };
>   
> diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
> index d0dacf62a..385f3c3ca 100644
> --- a/testcases/lib/.gitignore
> +++ b/testcases/lib/.gitignore
> @@ -24,3 +24,4 @@
>   /tst_supported_fs
>   /tst_timeout_kill
>   /tst_res_
> +/tst_run_shell
> diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
> index 928d76d62..b3a9181c1 100644
> --- a/testcases/lib/Makefile
> +++ b/testcases/lib/Makefile
> @@ -4,6 +4,9 @@
>   
>   top_srcdir		?= ../..
>   
> +LTPLIBS = ujson
> +tst_run_shell: LTPLDLIBS = -lujson
> +
>   include $(top_srcdir)/include/mk/testcases.mk
>   
>   INSTALL_TARGETS		:= *.sh
> @@ -13,6 +16,7 @@ MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
>   			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
>   			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill\
>   			   tst_check_kconfigs tst_cgctl tst_fsfreeze tst_ns_create tst_ns_exec\
> -			   tst_ns_ifmove tst_lockdown_enabled tst_secureboot_enabled tst_res_
> +			   tst_ns_ifmove tst_lockdown_enabled tst_secureboot_enabled tst_res_\
> +			   tst_run_shell
>   
>   include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/testcases/lib/run_tests.sh b/testcases/lib/run_tests.sh
> index 60e7d1bcf..e30065f1d 100755
> --- a/testcases/lib/run_tests.sh
> +++ b/testcases/lib/run_tests.sh
> @@ -9,3 +9,24 @@ for i in `seq -w 01 06`; do
>   	echo
>   	./tests/shell_test$i
>   done
> +
> +for i in shell_loader.sh shell_loader_all_filesystems.sh shell_loader_no_metadata.sh \
> +	 shell_loader_wrong_metadata.sh shell_loader_invalid_metadata.sh\
> +	 shell_loader_supported_archs.sh shell_loader_filesystems.sh\
> +	 shell_loader_tcnt.sh shell_loader_kconfigs.sh shell_loader_tags.sh \
> +	 shell_loader_invalid_block.sh; do
> +	echo
> +	echo "*** Running $i ***"
> +	echo
> +	$i
> +done
> +
> +echo
> +echo "*** Testing LTP test -h option ***"
> +echo
> +shell_loader.sh -h
> +
> +echo
> +echo "*** Testing LTP test -i option ***"
> +echo
> +shell_loader.sh -i 2
> diff --git a/testcases/lib/tests/shell_loader.sh b/testcases/lib/tests/shell_loader.sh
> new file mode 100755
> index 000000000..df7f0c0af
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader.sh
> @@ -0,0 +1,26 @@
> +#!/bin/sh
> +#
> +# ---
> +# doc
> +#
> +# [Description]
> +#
> +# This is a simple shell test loader example.
> +# ---
> +#
> +# ---
> +# env
> +# {
> +#  "needs_tmpdir": true
> +# }
> +# ---
> +
> +. tst_loader.sh
> +
> +tst_res TPASS "Shell loader works fine!"
> +case "$PWD" in
> +	/tmp/*)
> +		tst_res TPASS "We are running in temp directory in $PWD";;
> +	*)
> +		tst_res TFAIL "We are not running in temp directory but $PWD";;
> +esac
> diff --git a/testcases/lib/tests/shell_loader_all_filesystems.sh b/testcases/lib/tests/shell_loader_all_filesystems.sh
> new file mode 100755
> index 000000000..d5943c335
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader_all_filesystems.sh
> @@ -0,0 +1,27 @@
> +#!/bin/sh
> +#
> +# ---
> +# env
> +# {
> +#  "needs_root": true,
> +#  "mount_device": true,
> +#  "all_filesystems": true,
> +#  "mntpoint": "ltp_mntpoint"
> +# }
> +# ---
> +
> +. tst_loader.sh
> +
> +tst_res TINFO "In shell"
> +
> +mntpath=$(realpath ltp_mntpoint)
> +mounted=$(grep $mntpath /proc/mounts)
> +
> +if [ -n "$mounted" ]; then
> +	device=$(echo $mounted |cut -d' ' -f 1)
> +	path=$(echo $mounted |cut -d' ' -f 2)
> +
> +	tst_res TPASS "$device mounted at $path"
> +else
> +	tst_res TFAIL "Device not mounted!"
> +fi
> diff --git a/testcases/lib/tests/shell_loader_filesystems.sh b/testcases/lib/tests/shell_loader_filesystems.sh
> new file mode 100755
> index 000000000..5d8aa9808
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader_filesystems.sh
> @@ -0,0 +1,33 @@
> +#!/bin/sh
> +#
> +# ---
> +# env
> +# {
> +#  "mount_device": true,
> +#  "mntpoint": "ltp_mntpoint",
> +#  "filesystems": [
> +#   {
> +#    "type": "btrfs"
> +#   },
> +#   {
> +#    "type": "xfs",
> +#    "mkfs_opts": ["-m", "reflink=1"]
> +#   }
> +#  ]
> +# }
> +# ---
> +
> +. tst_loader.sh
> +
> +tst_res TINFO "In shell"
> +
> +mntpoint=$(realpath ltp_mntpoint)
> +mounted=$(grep $mntpoint /proc/mounts)
> +
> +if [ -n "$mounted" ]; then
> +	fs=$(echo $mounted |cut -d' ' -f 3)
> +
> +	tst_res TPASS "Mounted device formatted with $fs"
> +else
> +	tst_res TFAIL "Device not mounted!"
> +fi
> diff --git a/testcases/lib/tests/shell_loader_invalid_block.sh b/testcases/lib/tests/shell_loader_invalid_block.sh
> new file mode 100755
> index 000000000..f41de04fd
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader_invalid_block.sh
> @@ -0,0 +1,26 @@
> +#!/bin/sh
> +#
> +# ---
> +# doc
> +#
> +# [Description]
> +#
> +# This is a simple shell test loader example.
> +# ---
> +#
> +# ---
> +# env
> +# {
> +#  "needs_tmpdir": true
> +# }
> +# ---
> +#
> +# ---
> +# inv
> +#
> +# This is an invalid block that breaks the test.
> +# ---
> +
> +. tst_loader.sh
> +
> +tst_res TPASS "This should pass!"
> diff --git a/testcases/lib/tests/shell_loader_invalid_metadata.sh b/testcases/lib/tests/shell_loader_invalid_metadata.sh
> new file mode 100755
> index 000000000..c10b00f1b
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader_invalid_metadata.sh
> @@ -0,0 +1,15 @@
> +#!/bin/sh
> +#
> +# This test has wrong metadata and should not be run
> +#
> +# ---
> +# env
> +# {
> +#  {"needs_tmpdir": 42,
> +# }
> +# ---
> +#
> +
> +. tst_loader.sh
> +
> +tst_res TFAIL "Shell loader should TBROK the test"
> diff --git a/testcases/lib/tests/shell_loader_kconfigs.sh b/testcases/lib/tests/shell_loader_kconfigs.sh
> new file mode 100755
> index 000000000..7e9a1dce7
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader_kconfigs.sh
> @@ -0,0 +1,12 @@
> +#!/bin/sh
> +#
> +# ---
> +# env
> +# {
> +#  "needs_kconfigs": ["CONFIG_NUMA=y"]
> +# }
> +# ---
> +
> +. tst_loader.sh
> +
> +tst_res TPASS "Shell loader works fine!"
> diff --git a/testcases/lib/tests/shell_loader_no_metadata.sh b/testcases/lib/tests/shell_loader_no_metadata.sh
> new file mode 100755
> index 000000000..60ba8b889
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader_no_metadata.sh
> @@ -0,0 +1,8 @@
> +#!/bin/sh
> +#
> +# This test has no metadata and should not be executed
> +#
> +
> +. tst_loader.sh
> +
> +tst_res TFAIL "Shell loader should TBROK the test"
> diff --git a/testcases/lib/tests/shell_loader_supported_archs.sh b/testcases/lib/tests/shell_loader_supported_archs.sh
> new file mode 100755
> index 000000000..45213f840
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader_supported_archs.sh
> @@ -0,0 +1,12 @@
> +#!/bin/sh
> +#
> +# ---
> +# env
> +# {
> +#  "supported_archs": ["x86", "ppc64", "x86_64"]
> +# }
> +# ---
> +
> +. tst_loader.sh
> +
> +tst_res TPASS "We are running on supported architecture"
> diff --git a/testcases/lib/tests/shell_loader_tags.sh b/testcases/lib/tests/shell_loader_tags.sh
> new file mode 100755
> index 000000000..a6278c37d
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader_tags.sh
> @@ -0,0 +1,15 @@
> +#!/bin/sh
> +#
> +# ---
> +# env
> +# {
> +#  "tags": [
> +#   ["linux-git", "832478cd342ab"],
> +#   ["CVE", "2099-999"]
> +#  ]
> +# }
> +# ---
> +
> +. tst_loader.sh
> +
> +tst_res TFAIL "Fails the test so that tags are shown."
> diff --git a/testcases/lib/tests/shell_loader_tcnt.sh b/testcases/lib/tests/shell_loader_tcnt.sh
> new file mode 100755
> index 000000000..81fc08179
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader_tcnt.sh
> @@ -0,0 +1,15 @@
> +#!/bin/sh
> +#
> +# The script should be executed tcnt times and the iteration number should be in $1
> +#
> +# ---
> +# env
> +# {
> +#  "tcnt": 2
> +# }
> +# ---
> +#
> +
> +. tst_loader.sh
> +
> +tst_res TPASS "Iteration $1"
> diff --git a/testcases/lib/tests/shell_loader_wrong_metadata.sh b/testcases/lib/tests/shell_loader_wrong_metadata.sh
> new file mode 100755
> index 000000000..752e25eea
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader_wrong_metadata.sh
> @@ -0,0 +1,15 @@
> +#!/bin/sh
> +#
> +# This test has wrong metadata and should not be run
> +#
> +# ---
> +# env
> +# {
> +#  "needs_tmpdir": 42,
> +# }
> +# ---
> +#
> +
> +. tst_loader.sh
> +
> +tst_res TFAIL "Shell loader should TBROK the test"
> diff --git a/testcases/lib/tst_env.sh b/testcases/lib/tst_env.sh
> index 948bc5024..67ba80744 100644
> --- a/testcases/lib/tst_env.sh
> +++ b/testcases/lib/tst_env.sh
> @@ -1,4 +1,8 @@
>   #!/bin/sh
> +#
> +# This is a minimal test environment for a shell scripts executed from C by
> +# tst_run_shell() function. Shell tests must use the tst_loader.sh instead!
> +#
>   
>   tst_script_name=$(basename $0)
>   
> diff --git a/testcases/lib/tst_loader.sh b/testcases/lib/tst_loader.sh
> new file mode 100644
> index 000000000..ed04d0340
> --- /dev/null
> +++ b/testcases/lib/tst_loader.sh
> @@ -0,0 +1,11 @@
> +#!/bin/sh
> +#
> +# This is a loader for shell tests that use the C test library.
> +#
> +
> +if [ -z "$LTP_IPC_PATH" ]; then
> +	tst_run_shell $(basename "$0") "$@"
> +	exit $?
> +else
> +	. tst_env.sh
> +fi
> diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
> new file mode 100644
> index 000000000..8ed0f21b6
> --- /dev/null
> +++ b/testcases/lib/tst_run_shell.c
> @@ -0,0 +1,491 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 Cyril Hrubis <chrubis@suse.cz>
> + */
> +#include <sys/mount.h>
> +
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +#include "tst_safe_stdio.h"
> +#include "ujson.h"
> +
> +static char *shell_filename;
> +
> +static void run_shell(void)
> +{
> +	tst_run_script(shell_filename, NULL);
> +}
> +
> +static void run_shell_tcnt(unsigned int n)
> +{
> +	char buf[128];
> +	char *const params[] = {buf, NULL};
> +
> +	snprintf(buf, sizeof(buf), "%u", n);
> +
> +	tst_run_script(shell_filename, params);
> +}
> +
> +struct tst_test test = {
> +	.runs_script = 1,
> +};
> +
> +static void print_help(void)
> +{
> +	printf("Usage: tst_shell_loader ltp_shell_test.sh ...\n");
> +}
> +
> +static char *metadata;
> +static size_t metadata_size;
> +static size_t metadata_used;
> +
> +static void metadata_append(const char *line)
> +{
> +	size_t linelen = strlen(line);
> +
> +	if (metadata_size - metadata_used < linelen + 1) {
> +		metadata_size += 4096;
> +		metadata = SAFE_REALLOC(metadata, metadata_size);
> +	}
> +
> +	strcpy(metadata + metadata_used, line);
> +	metadata_used += linelen;
> +}
> +
> +enum test_attr_ids {
> +	ALL_FILESYSTEMS,
> +	DEV_MIN_SIZE,
> +	FILESYSTEMS,
> +	FORMAT_DEVICE,
> +	MIN_CPUS,
> +	MIN_MEM_AVAIL,
> +	MIN_KVER,
> +	MIN_SWAP_AVAIL,
> +	MNTPOINT,
> +	MOUNT_DEVICE,
> +	NEEDS_ABI_BITS,
> +	NEEDS_CMDS,
> +	NEEDS_DEVFS,
> +	NEEDS_DEVICE,
> +	NEEDS_DRIVERS,
> +	NEEDS_HUGETLBFS,
> +	NEEDS_KCONFIGS,
> +	NEEDS_ROFS,
> +	NEEDS_ROOT,
> +	NEEDS_TMPDIR,
> +	RESTORE_WALLCLOCK,
> +	SKIP_FILESYSTEMS,
> +	SKIP_IN_COMPAT,
> +	SKIP_IN_LOCKDOWN,
> +	SKIP_IN_SECUREBOOT,
> +	SUPPORTED_ARCHS,
> +	TAGS,
> +	TAINT_CHECK,
> +	TCNT,
> +};
> +
> +static ujson_obj_attr test_attrs[] = {
> +	UJSON_OBJ_ATTR_IDX(ALL_FILESYSTEMS, "all_filesystems", UJSON_BOOL),
> +	UJSON_OBJ_ATTR_IDX(DEV_MIN_SIZE, "dev_min_size", UJSON_INT),
> +	UJSON_OBJ_ATTR_IDX(FILESYSTEMS, "filesystems", UJSON_ARR),
> +	UJSON_OBJ_ATTR_IDX(FORMAT_DEVICE, "format_device", UJSON_BOOL),
> +	UJSON_OBJ_ATTR_IDX(MIN_CPUS, "min_cpus", UJSON_INT),
> +	UJSON_OBJ_ATTR_IDX(MIN_MEM_AVAIL, "min_mem_avail", UJSON_INT),
> +	UJSON_OBJ_ATTR_IDX(MIN_KVER, "min_kver", UJSON_STR),
> +	UJSON_OBJ_ATTR_IDX(MIN_SWAP_AVAIL, "min_swap_avail", UJSON_INT),
> +	UJSON_OBJ_ATTR_IDX(MNTPOINT, "mntpoint", UJSON_STR),
> +	UJSON_OBJ_ATTR_IDX(MOUNT_DEVICE, "mount_device", UJSON_BOOL),
> +	UJSON_OBJ_ATTR_IDX(NEEDS_ABI_BITS, "needs_abi_bits", UJSON_INT),
> +	UJSON_OBJ_ATTR_IDX(NEEDS_CMDS, "needs_cmds", UJSON_ARR),
> +	UJSON_OBJ_ATTR_IDX(NEEDS_DEVFS, "needs_devfs", UJSON_BOOL),
> +	UJSON_OBJ_ATTR_IDX(NEEDS_DEVICE, "needs_device", UJSON_BOOL),
> +	UJSON_OBJ_ATTR_IDX(NEEDS_DRIVERS, "needs_drivers", UJSON_ARR),
> +	UJSON_OBJ_ATTR_IDX(NEEDS_HUGETLBFS, "needs_hugetlbfs", UJSON_BOOL),
> +	UJSON_OBJ_ATTR_IDX(NEEDS_KCONFIGS, "needs_kconfigs", UJSON_ARR),
> +	UJSON_OBJ_ATTR_IDX(NEEDS_ROFS, "needs_rofs", UJSON_BOOL),
> +	UJSON_OBJ_ATTR_IDX(NEEDS_ROOT, "needs_root", UJSON_BOOL),
> +	UJSON_OBJ_ATTR_IDX(NEEDS_TMPDIR, "needs_tmpdir", UJSON_BOOL),
> +	UJSON_OBJ_ATTR_IDX(RESTORE_WALLCLOCK, "restore_wallclock", UJSON_BOOL),
> +	UJSON_OBJ_ATTR_IDX(SKIP_FILESYSTEMS, "skip_filesystems", UJSON_ARR),
> +	UJSON_OBJ_ATTR_IDX(SKIP_IN_COMPAT, "skip_in_compat", UJSON_BOOL),
> +	UJSON_OBJ_ATTR_IDX(SKIP_IN_LOCKDOWN, "skip_in_lockdown", UJSON_BOOL),
> +	UJSON_OBJ_ATTR_IDX(SKIP_IN_SECUREBOOT, "skip_in_secureboot", UJSON_BOOL),
> +	UJSON_OBJ_ATTR_IDX(SUPPORTED_ARCHS, "supported_archs", UJSON_ARR),
> +	UJSON_OBJ_ATTR_IDX(TAGS, "tags", UJSON_ARR),
> +	UJSON_OBJ_ATTR_IDX(TAINT_CHECK, "taint_check", UJSON_BOOL),
> +	UJSON_OBJ_ATTR_IDX(TCNT, "tcnt", UJSON_INT)
> +};
> +
> +static ujson_obj test_obj = {
> +	.attrs = test_attrs,
> +	.attr_cnt = UJSON_ARRAY_SIZE(test_attrs),
> +};
> +
> +static const char *const *parse_strarr(ujson_reader *reader, ujson_val *val)
> +{
> +	unsigned int cnt = 0, i = 0;
> +	char **ret;
> +
> +	ujson_reader_state state = ujson_reader_state_save(reader);
> +
> +	UJSON_ARR_FOREACH(reader, val) {
> +		if (val->type != UJSON_STR) {
> +			ujson_err(reader, "Expected string!");
> +			return NULL;
> +		}
> +
> +		cnt++;
> +	}
> +
> +	ujson_reader_state_load(reader, state);
> +
> +	ret = SAFE_MALLOC(sizeof(char*) * (cnt + 1));
> +
> +	UJSON_ARR_FOREACH(reader, val) {
> +		ret[i++] = strdup(val->val_str);
> +	}
> +
> +	ret[i] = NULL;
> +
> +	return (const char *const *)ret;
> +}
> +
> +enum fs_ids {
> +	MKFS_OPTS,
> +	MKFS_SIZE_OPT,
> +	MNT_FLAGS,
> +	TYPE,
> +};
> +
> +static ujson_obj_attr fs_attrs[] = {
> +	UJSON_OBJ_ATTR_IDX(MKFS_OPTS, "mkfs_opts", UJSON_ARR),
> +	UJSON_OBJ_ATTR_IDX(MKFS_SIZE_OPT, "mkfs_size_opt", UJSON_STR),
> +	UJSON_OBJ_ATTR_IDX(MNT_FLAGS, "mnt_flags", UJSON_ARR),
> +	UJSON_OBJ_ATTR_IDX(TYPE, "type", UJSON_STR),
> +};
> +
> +static ujson_obj fs_obj = {
> +	.attrs = fs_attrs,
> +	.attr_cnt = UJSON_ARRAY_SIZE(fs_attrs),
> +};
> +
> +static int parse_mnt_flags(ujson_reader *reader, ujson_val *val)
> +{
> +	int ret = 0;
> +
> +	UJSON_ARR_FOREACH(reader, val) {
> +		if (val->type != UJSON_STR) {
> +			ujson_err(reader, "Expected string!");
> +			return ret;
> +		}
> +
> +		if (!strcmp(val->val_str, "RDONLY"))
> +			ret |= MS_RDONLY;
> +		else if (!strcmp(val->val_str, "NOATIME"))
> +			ret |= MS_NOATIME;
> +		else if (!strcmp(val->val_str, "NOEXEC"))
> +			ret |= MS_NOEXEC;
> +		else if (!strcmp(val->val_str, "NOSUID"))
> +			ret |= MS_NOSUID;
> +		else
> +			ujson_err(reader, "Invalid mount flag");
> +	}
> +
> +	return ret;
> +}
> +
> +static struct tst_fs *parse_filesystems(ujson_reader *reader, ujson_val *val)
> +{
> +	unsigned int i = 0, cnt = 0;
> +	struct tst_fs *ret;
> +
> +	ujson_reader_state state = ujson_reader_state_save(reader);
> +
> +	UJSON_ARR_FOREACH(reader, val) {
> +		if (val->type != UJSON_OBJ) {
> +			ujson_err(reader, "Expected object!");
> +			return NULL;
> +		}
> +		ujson_obj_skip(reader);
> +		cnt++;
> +	}
> +
> +	ujson_reader_state_load(reader, state);
> +
> +	ret = SAFE_MALLOC(sizeof(struct tst_fs) * (cnt + 1));
> +	memset(ret, 0, sizeof(*ret) * (cnt+1));
> +
> +	UJSON_ARR_FOREACH(reader, val) {
> +		UJSON_OBJ_FOREACH_FILTER(reader, val, &fs_obj, ujson_empty_obj) {
> +			switch ((enum fs_ids)val->idx) {
> +			case MKFS_OPTS:
> +				ret[i].mkfs_opts = parse_strarr(reader, val);
> +			break;
> +			case MKFS_SIZE_OPT:
> +				ret[i].mkfs_size_opt = strdup(val->val_str);
> +			break;
> +			case MNT_FLAGS:
> +				ret[i].mnt_flags = parse_mnt_flags(reader, val);
> +			break;
> +			case TYPE:
> +				ret[i].type = strdup(val->val_str);
> +			break;
> +			}
> +
> +		}
> +
> +		i++;
> +	}
> +
> +	return ret;
> +}
> +
> +static struct tst_tag *parse_tags(ujson_reader *reader, ujson_val *val)
> +{
> +	unsigned int i = 0, cnt = 0;
> +	struct tst_tag *ret;
> +
> +	ujson_reader_state state = ujson_reader_state_save(reader);
> +
> +	UJSON_ARR_FOREACH(reader, val) {
> +		if (val->type != UJSON_ARR) {
> +			ujson_err(reader, "Expected array!");
> +			return NULL;
> +		}
> +		ujson_arr_skip(reader);
> +		cnt++;
> +	}
> +
> +	ujson_reader_state_load(reader, state);
> +
> +	ret = SAFE_MALLOC(sizeof(struct tst_tag) * (cnt + 1));
> +	memset(&ret[cnt], 0, sizeof(ret[cnt]));
> +
> +	UJSON_ARR_FOREACH(reader, val) {
> +		char *name = NULL;
> +		char *value = NULL;
> +
> +		UJSON_ARR_FOREACH(reader, val) {
> +			if (val->type != UJSON_STR) {
> +				ujson_err(reader, "Expected string!");
> +				return NULL;
> +			}
> +
> +			if (!name) {
> +				name = strdup(val->val_str);
> +			} else if (!value) {
> +				value = strdup(val->val_str);
> +			} else {
> +				ujson_err(reader, "Expected only two members!");
> +				return NULL;
> +			}
> +		}
> +
> +		ret[i].name = name;
> +		ret[i].value = value;
> +		i++;
> +	}
> +
> +	return ret;
> +}
> +
> +static void parse_metadata(void)
> +{
> +	ujson_reader reader = UJSON_READER_INIT(metadata, metadata_used, UJSON_READER_STRICT);
> +	char str_buf[128];
> +	ujson_val val = UJSON_VAL_INIT(str_buf, sizeof(str_buf));
> +
> +	UJSON_OBJ_FOREACH_FILTER(&reader, &val, &test_obj, ujson_empty_obj) {
> +		switch ((enum test_attr_ids)val.idx) {
> +		case ALL_FILESYSTEMS:
> +			test.all_filesystems = val.val_bool;
> +		break;
> +		case DEV_MIN_SIZE:
> +			if (val.val_int <= 0)
> +				ujson_err(&reader, "Device size must be > 0");
> +			else
> +				test.dev_min_size = val.val_int;
> +		break;
> +		case FILESYSTEMS:
> +			test.filesystems = parse_filesystems(&reader, &val);
> +		break;
> +		case FORMAT_DEVICE:
> +			test.format_device = val.val_bool;
> +		break;
> +		case MIN_CPUS:
> +			if (val.val_int <= 0)
> +				ujson_err(&reader, "Minimal number of cpus must be > 0");
> +			else
> +				test.min_cpus = val.val_int;
> +		break;
> +		case MIN_MEM_AVAIL:
> +			if (val.val_int <= 0)
> +				ujson_err(&reader, "Minimal available memory size must be > 0");
> +			else
> +				test.min_mem_avail = val.val_int;
> +		break;
> +		case MIN_KVER:
> +			test.min_kver = strdup(val.val_str);
> +		break;
> +		case MIN_SWAP_AVAIL:
> +			if (val.val_int <= 0)
> +				ujson_err(&reader, "Minimal available swap size must be > 0");
> +			else
> +				test.min_swap_avail = val.val_int;
> +		break;
> +		case MNTPOINT:
> +			test.mntpoint = strdup(val.val_str);
> +		break;
> +		case MOUNT_DEVICE:
> +			test.mount_device = val.val_bool;
> +		break;
> +		case NEEDS_ABI_BITS:
> +			if (val.val_int == 32 || val.val_int == 64)
> +				test.needs_abi_bits = val.val_int;
> +			else
> +				ujson_err(&reader, "ABI bits must be 32 or 64");
> +		break;
> +		case NEEDS_CMDS:
> +			test.needs_cmds = parse_strarr(&reader, &val);
> +		break;
> +		case NEEDS_DEVFS:
> +			test.needs_devfs = val.val_bool;
> +		break;
> +		case NEEDS_DEVICE:
> +			test.needs_device = val.val_bool;
> +		break;
> +		case NEEDS_DRIVERS:
> +			test.needs_drivers = parse_strarr(&reader, &val);
> +		break;
> +		case NEEDS_HUGETLBFS:
> +			test.needs_hugetlbfs = val.val_bool;
> +		break;
> +		case NEEDS_KCONFIGS:
> +			test.needs_kconfigs = parse_strarr(&reader, &val);
> +		break;
> +		case NEEDS_ROFS:
> +			test.needs_rofs = val.val_bool;
> +		break;
> +		case NEEDS_ROOT:
> +			test.needs_root = val.val_bool;
> +		break;
> +		case NEEDS_TMPDIR:
> +			test.needs_tmpdir = val.val_bool;
> +		break;
> +		case RESTORE_WALLCLOCK:
> +			test.restore_wallclock = val.val_bool;
> +		break;
> +		case SKIP_FILESYSTEMS:
> +			test.skip_filesystems = parse_strarr(&reader, &val);
> +		break;
> +		case SKIP_IN_COMPAT:
> +			test.skip_in_compat = val.val_bool;
> +		break;
> +		case SKIP_IN_LOCKDOWN:
> +			test.skip_in_lockdown = val.val_bool;
> +		break;
> +		case SKIP_IN_SECUREBOOT:
> +			test.skip_in_secureboot = val.val_bool;
> +		break;
> +		case SUPPORTED_ARCHS:
> +			test.supported_archs = parse_strarr(&reader, &val);
> +		break;
> +		case TAGS:
> +			test.tags = parse_tags(&reader, &val);
> +		break;
> +		case TAINT_CHECK:
> +			test.taint_check = val.val_bool;
> +		break;
> +		case TCNT:
> +			if (val.val_int <= 0)
> +				ujson_err(&reader, "Number of tests must be > 0");
> +			else
> +				test.tcnt = val.val_int;
> +		break;
> +		}
> +	}
> +
> +	ujson_reader_finish(&reader);
> +
> +	if (ujson_reader_err(&reader))
> +		tst_brk(TBROK, "Invalid metadata");
> +}
> +
> +enum parser_state {
> +	PAR_NONE,
> +	PAR_ESC,
> +	PAR_DOC,
> +	PAR_ENV,
> +};
> +
> +static void extract_metadata(void)
> +{
> +	FILE *f;
> +	char line[4096];
> +	char path[4096];
> +	enum parser_state state = PAR_NONE;
> +
> +	if (tst_get_path(shell_filename, path, sizeof(path)) == -1)
> +		tst_brk(TBROK, "Failed to find %s in $PATH", shell_filename);
> +
> +	f = SAFE_FOPEN(path, "r");
> +
> +	while (fgets(line, sizeof(line), f)) {
> +		switch (state) {
> +		case PAR_NONE:
> +			if (!strcmp(line, "# ---\n"))
> +				state = PAR_ESC;
> +		break;
> +		case PAR_ESC:
> +			if (!strcmp(line, "# env\n"))
> +				state = PAR_ENV;
> +			else if (!strcmp(line, "# doc\n"))
> +				state = PAR_DOC;
> +			else
> +				tst_brk(TBROK, "Unknown comment block %s", line);
> +		break;
> +		case PAR_ENV:
> +			if (!strcmp(line, "# ---\n"))
> +				state = PAR_NONE;
> +			else
> +				metadata_append(line + 2);
> +		break;
> +		case PAR_DOC:
> +			if (!strcmp(line, "# ---\n"))
> +				state = PAR_NONE;
> +		break;
> +		}
> +	}
> +
> +	fclose(f);
> +}
> +
> +static void prepare_test_struct(void)
> +{
> +	extract_metadata();
> +
> +	if (metadata)
> +		parse_metadata();
> +	else
> +		tst_brk(TBROK, "No metadata found!");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	if (argc < 2)
> +		goto help;
> +
> +	shell_filename = argv[1];
> +
> +	prepare_test_struct();
> +
> +	if (test.tcnt)
> +		test.test = run_shell_tcnt;
> +	else
> +		test.test_all = run_shell;
> +
> +	tst_run_tcases(argc - 1, argv + 1, &test);
> +help:
> +	print_help();
> +	return 1;
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
