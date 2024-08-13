Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1ABC52D7C
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 16:15:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01D733D2119
	for <ltp@archiver.kernel.org>; Tue, 13 Aug 2024 18:15:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 345593C8910
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 18:15:14 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=richiejp.com (client-ip=103.168.172.150;
 helo=fout7-smtp.messagingengine.com; envelope-from=io@richiejp.com;
 receiver=lists.linux.it)
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com
 [103.168.172.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 16702600F05
 for <ltp@lists.linux.it>; Tue, 13 Aug 2024 18:15:12 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal
 [10.202.2.45])
 by mailfout.nyi.internal (Postfix) with ESMTP id 1EB99138FC75;
 Tue, 13 Aug 2024 12:15:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 13 Aug 2024 12:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=richiejp.com; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:subject
 :subject:to:to; s=fm2; t=1723565711; x=1723652111; bh=97Trb2BmEa
 SWHqhSuGJaXuwQ1hFaY5ERVYUIelcjLgI=; b=CoB2cgkLynp9Y0gFImfZq2BNZE
 QKJ9YFTqgPF0rqLrg/yQqzAhttx0n8p0oHs3fkgLZwzkcvFGQxJ83pbo8N7awYeo
 V4T/R4fcJUMyG4NN1/PhGZtaHMn3DLIdk8A0gSsFZhPg2M6Y2GBy5LLpIqs7bvUN
 nh0sCnG7n29pb0F3b8S2DYWStWhbboC05qatNcsenRUNAwyT8J86GhNlfAwgeGWY
 m+SA62/I/yC/Vnjhw9OqnB9p6NiI3vFItDYBhi6KXsI+Mw3m4ed7anD23asBOhT/
 9praPGnSFmceehdnPjv7VC707baNt3uXoU9DmwpKjSv3JmV8zpe6xoGxb02Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1723565711; x=1723652111; bh=97Trb2BmEaSWHqhSuGJaXuwQ1hFa
 Y5ERVYUIelcjLgI=; b=XPeBMJv5XbaJxw3cpc8pS8zkH6f3gLxfWA4SU5A+YGJj
 vm2a538hdYXT1iXLSFh0A0olPp/UyA17SRd2v8hgEt2vD75BSHR5uqT6pSilgLIU
 bJUrmevpuHREOGkxk4Z/GMxYKVpvn7MNBiijGWX7X/WKlYZoltmGYhXmVZMbN5ua
 OO4krmgMDeZEZdNDiX0wACB9RnGa1bKiIwm6uJi2iCjKIRJWNXItJNHhmDEdptAs
 Vp4mO677Bpl41jxlwbqOeIKJOjCz1cAlesfm4SdhmkxOmZzF1/s1pgRmj4egEnvX
 LCGP67nspOHFFSuZDTfRg4SfBA5dq28YvfhE7O237g==
X-ME-Sender: <xms:joa7Zl_-6WmZ41UQokQq5QCgdUGKssFdzyRMb_JqrjIHf8YTIFNAkQ>
 <xme:joa7ZpvEtHxuLUXZAL41YwOiAHfne097GIBq_sGgfdyW6YS7HD0sWPeanO1183xiN
 bEdyNy-JA72RGcJ>
X-ME-Received: <xmr:joa7ZjBQ3yF3NlAXmyVEMIjpFjjymrAQoUudaDIrwZRlqR_QE7ji55WKTmEAvt7Asyz24MEhurC0W8K-fEk3l6A-D0oaPySQzqGof5ejJnI7QIOtzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgleekucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
 rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
 htshculddquddttddmnecujfgurhephffvvefujghffffkgggtsehttdertddttddtnecu
 hfhrohhmpeftihgthhgrrhguucfrrghlvghthhhorhhpvgcuoehiohesrhhitghhihgvjh
 hprdgtohhmqeenucggtffrrghtthgvrhhnpedthfduffekueeukefhjefhleeihfevgefh
 vefggfehtddvleeltdetgeejgfegvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
 grmhepmhgrihhlfhhrohhmpehiohesrhhitghhihgvjhhprdgtohhmpdhnsggprhgtphht
 thhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlthhpsehlihhsthhsrd
 hlihhnuhigrdhithdprhgtphhtthhopegthhhruhgsihhssehsuhhsvgdrtgii
X-ME-Proxy: <xmx:joa7ZpewQ9-3pZz300rTEPewWmxYQwKaZaqgGW0mVwc65Z2XVUdGYw>
 <xmx:joa7ZqOe8dm-JOVzVOb0nfmjRLfJvSrtiHuel1bNtZh3OHECZOdEug>
 <xmx:joa7ZrmZkfmmz98Hd65NdR0c_MVaeHwWC5roIP1n0BvGFkliJmV12w>
 <xmx:joa7Zks7RKq7a-THWJNgVZER8_PpqrhfSpO1L-F8O_mvsvm_JSAyfg>
 <xmx:j4a7Zja9BhFN2je36ZL2TXy2nGFu8roX0hcFGgOXqvez2MyMsmOHlNLe>
Feedback-ID: i12a14689:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 12:15:09 -0400 (EDT)
From: Richard Palethorpe <io@richiejp.com>
To: Cyril Hrubis <chrubis@suse.cz>
In-Reply-To: <20240731092017.8267-4-chrubis@suse.cz> (Cyril Hrubis's message
 of "Wed, 31 Jul 2024 11:20:17 +0200")
References: <20240731092017.8267-1-chrubis@suse.cz>
 <20240731092017.8267-4-chrubis@suse.cz>
Date: Tue, 13 Aug 2024 17:15:08 +0100
Message-ID: <87o75ws8kz.fsf@richiejp.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] testcaes/lib: Add shell loader
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


Hello Cyril Hrubis <chrubis@suse.cz> writes:

> This commit implements a shell loader so that we don't have to write a C
> loader for each LTP shell test. The idea is simple, the loader parses
> the shell test and prepares the tst_test structure accordingly, then
> runs the actual shell test.
>
> The format for the metadata in the shell test was choosen to be JSON
> because:
>
> - I didn't want to invent an adhoc format and JSON is perfect for
>   serializing data structures
> - The metadata parser for shell test will be trivial, it will just pick
>   the JSON from the comment, no parsing will be required
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/tst_test.h                            |   2 +-
>  testcases/lib/.gitignore                      |   1 +
>  testcases/lib/Makefile                        |   6 +-
>  testcases/lib/run_tests.sh                    |   9 +
>  testcases/lib/tests/shell_loader.sh           |  15 +
>  .../lib/tests/shell_loader_all_filesystems.sh |  24 ++
>  .../lib/tests/shell_loader_filesystems.sh     |  30 ++
>  .../tests/shell_loader_invalid_metadata.sh    |  12 +
>  .../lib/tests/shell_loader_no_metadata.sh     |   8 +
>  .../lib/tests/shell_loader_supported_archs.sh |   9 +
>  .../lib/tests/shell_loader_wrong_metadata.sh  |  12 +
>  testcases/lib/tst_env.sh                      |   4 +
>  testcases/lib/tst_loader.sh                   |  11 +
>  testcases/lib/tst_run_shell.c                 | 378 ++++++++++++++++++
>  14 files changed, 519 insertions(+), 2 deletions(-)
>  create mode 100755 testcases/lib/tests/shell_loader.sh
>  create mode 100755 testcases/lib/tests/shell_loader_all_filesystems.sh
>  create mode 100755 testcases/lib/tests/shell_loader_filesystems.sh
>  create mode 100755 testcases/lib/tests/shell_loader_invalid_metadata.sh
>  create mode 100755 testcases/lib/tests/shell_loader_no_metadata.sh
>  create mode 100755 testcases/lib/tests/shell_loader_supported_archs.sh
>  create mode 100755 testcases/lib/tests/shell_loader_wrong_metadata.sh
>  create mode 100644 testcases/lib/tst_loader.sh
>  create mode 100644 testcases/lib/tst_run_shell.c
>
> diff --git a/include/tst_test.h b/include/tst_test.h
> index a334195ac..c04498937 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -274,7 +274,7 @@ struct tst_fs {
>  	const char *const *mkfs_opts;
>  	const char *mkfs_size_opt;
>  
> -	const unsigned int mnt_flags;
> +	unsigned int mnt_flags;
>  	const void *mnt_data;
>  };
>  
> diff --git a/testcases/lib/.gitignore b/testcases/lib/.gitignore
> index d0dacf62a..385f3c3ca 100644
> --- a/testcases/lib/.gitignore
> +++ b/testcases/lib/.gitignore
> @@ -24,3 +24,4 @@
>  /tst_supported_fs
>  /tst_timeout_kill
>  /tst_res_
> +/tst_run_shell
> diff --git a/testcases/lib/Makefile b/testcases/lib/Makefile
> index 928d76d62..b3a9181c1 100644
> --- a/testcases/lib/Makefile
> +++ b/testcases/lib/Makefile
> @@ -4,6 +4,9 @@
>  
>  top_srcdir		?= ../..
>  
> +LTPLIBS = ujson
> +tst_run_shell: LTPLDLIBS = -lujson
> +
>  include $(top_srcdir)/include/mk/testcases.mk
>  
>  INSTALL_TARGETS		:= *.sh
> @@ -13,6 +16,7 @@ MAKE_TARGETS		:= tst_sleep tst_random tst_checkpoint tst_rod tst_kvcmp\
>  			   tst_getconf tst_supported_fs tst_check_drivers tst_get_unused_port\
>  			   tst_get_median tst_hexdump tst_get_free_pids tst_timeout_kill\
>  			   tst_check_kconfigs tst_cgctl tst_fsfreeze tst_ns_create tst_ns_exec\
> -			   tst_ns_ifmove tst_lockdown_enabled tst_secureboot_enabled tst_res_
> +			   tst_ns_ifmove tst_lockdown_enabled tst_secureboot_enabled tst_res_\
> +			   tst_run_shell
>  
>  include $(top_srcdir)/include/mk/generic_trunk_target.mk
> diff --git a/testcases/lib/run_tests.sh b/testcases/lib/run_tests.sh
> index 60e7d1bcf..9857f5f82 100755
> --- a/testcases/lib/run_tests.sh
> +++ b/testcases/lib/run_tests.sh
> @@ -9,3 +9,12 @@ for i in `seq -w 01 06`; do
>  	echo
>  	./tests/shell_test$i
>  done
> +
> +for i in shell_loader.sh shell_loader_all_filesystems.sh shell_loader_no_metadata.sh \
> +	 shell_loader_wrong_metadata.sh shell_loader_invalid_metadata.sh\
> +	 shell_loader_supported_archs.sh shell_loader_filesystems.sh; do
> +	echo
> +	echo "*** Running $i ***"
> +	echo
> +	$i
> +done
> diff --git a/testcases/lib/tests/shell_loader.sh b/testcases/lib/tests/shell_loader.sh
> new file mode 100755
> index 000000000..642ffe97b
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader.sh
> @@ -0,0 +1,15 @@
> +#!/bin/sh
> +#
> +# TEST = {
> +#  "needs_tmpdir": true
> +# }
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
> index 000000000..8432b4b3d
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader_all_filesystems.sh
> @@ -0,0 +1,24 @@
> +#!/bin/sh
> +#
> +# TEST = {
> +#  "needs_root": true,
> +#  "mount_device": true,
> +#  "all_filesystems": true,
> +#  "mntpoint": "ltp_mntpoint"
> +# }
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
> index 000000000..ede1a8fe9
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader_filesystems.sh
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +#
> +# TEST = {
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
> diff --git a/testcases/lib/tests/shell_loader_invalid_metadata.sh b/testcases/lib/tests/shell_loader_invalid_metadata.sh
> new file mode 100755
> index 000000000..265be6f36
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader_invalid_metadata.sh
> @@ -0,0 +1,12 @@
> +#!/bin/sh
> +#
> +# This test has wrong metadata and should not be run
> +#
> +# TEST = {
> +#  {"needs_tmpdir": 42,
> +# }
> +#
> +
> +. tst_loader.sh
> +
> +tst_res TFAIL "Shell loader should TBROK the test"
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
> index 000000000..d5c6c648b
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader_supported_archs.sh
> @@ -0,0 +1,9 @@
> +#!/bin/sh
> +#
> +# TEST = {
> +#  "supported_archs": ["x86", "ppc64", "x86_64"]
> +# }
> +
> +. tst_loader.sh
> +
> +tst_res TPASS "We are running on supported architecture"
> diff --git a/testcases/lib/tests/shell_loader_wrong_metadata.sh b/testcases/lib/tests/shell_loader_wrong_metadata.sh
> new file mode 100755
> index 000000000..f29b9308f
> --- /dev/null
> +++ b/testcases/lib/tests/shell_loader_wrong_metadata.sh
> @@ -0,0 +1,12 @@
> +#!/bin/sh
> +#
> +# This test has wrong metadata and should not be run
> +#
> +# TEST = {
> +#  "needs_tmpdir": 42,
> +# }
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
>  #!/bin/sh
> +#
> +# This is a minimal test environment for a shell scripts executed from C by
> +# tst_run_shell() function. Shell tests must use the tst_loader.sh instead!
> +#
>  
>  tst_script_name=$(basename $0)
>  
> diff --git a/testcases/lib/tst_loader.sh b/testcases/lib/tst_loader.sh
> new file mode 100644
> index 000000000..5ac095e44
> --- /dev/null
> +++ b/testcases/lib/tst_loader.sh
> @@ -0,0 +1,11 @@
> +#!/bin/sh
> +#
> +# This is a loader for shell tests that use the C test library.
> +#
> +
> +if [ -z "$LTP_IPC_PATH" ]; then
> +	tst_run_shell $(basename "$0")
> +	exit $?
> +else
> +	. tst_env.sh
> +fi
> diff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
> new file mode 100644
> index 000000000..96827e1cc
> --- /dev/null
> +++ b/testcases/lib/tst_run_shell.c
> @@ -0,0 +1,378 @@
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
> +	tst_run_shell(shell_filename, NULL);
> +}
> +
> +struct tst_test test = {
> +	.test_all = run_shell,
> +	.runs_script = 1,
> +};
> +
> +static void print_help(void)
> +{
> +	printf("Usage: tst_shell_loader ltp_shell_test.sh ...");
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
> +		metadata_size += 128;

This seems like a very small amount to bother allocating.

> +		metadata = SAFE_REALLOC(metadata, metadata_size);
> +	}
> +
> +	strcpy(metadata + metadata_used, line);
> +	metadata_used += linelen;
> +}
> +
> +static ujson_obj_attr test_attrs[] = {
> +	UJSON_OBJ_ATTR("all_filesystems", UJSON_BOOL),
> +	UJSON_OBJ_ATTR("dev_min_size", UJSON_INT),
> +	UJSON_OBJ_ATTR("filesystems", UJSON_ARR),
> +	UJSON_OBJ_ATTR("format_device", UJSON_BOOL),
> +	UJSON_OBJ_ATTR("min_cpus", UJSON_INT),
> +	UJSON_OBJ_ATTR("min_mem_avail", UJSON_INT),
> +	UJSON_OBJ_ATTR("min_kver", UJSON_STR),
> +	UJSON_OBJ_ATTR("min_swap_avail", UJSON_INT),
> +	UJSON_OBJ_ATTR("mntpoint", UJSON_STR),
> +	UJSON_OBJ_ATTR("mount_device", UJSON_BOOL),
> +	UJSON_OBJ_ATTR("needs_abi_bits", UJSON_INT),
> +	UJSON_OBJ_ATTR("needs_devfs", UJSON_BOOL),
> +	UJSON_OBJ_ATTR("needs_device", UJSON_BOOL),
> +	UJSON_OBJ_ATTR("needs_hugetlbfs", UJSON_BOOL),
> +	UJSON_OBJ_ATTR("needs_rofs", UJSON_BOOL),
> +	UJSON_OBJ_ATTR("needs_root", UJSON_BOOL),
> +	UJSON_OBJ_ATTR("needs_tmpdir", UJSON_BOOL),
> +	UJSON_OBJ_ATTR("restore_wallclock", UJSON_BOOL),
> +	UJSON_OBJ_ATTR("skip_filesystems", UJSON_ARR),
> +	UJSON_OBJ_ATTR("skip_in_compat", UJSON_BOOL),
> +	UJSON_OBJ_ATTR("skip_in_lockdown", UJSON_BOOL),
> +	UJSON_OBJ_ATTR("skip_in_secureboot", UJSON_BOOL),
> +	UJSON_OBJ_ATTR("supported_archs", UJSON_ARR),
> +};
> +
> +static ujson_obj test_obj = {
> +	.attrs = test_attrs,
> +	.attr_cnt = UJSON_ARRAY_SIZE(test_attrs),
> +};
> +
> +/* Must match the order of test_attrs. */

You could use the index syntax like [ALL_FILESYSTEMS] = UJASON_OBJ_ATTR...
IIRC.

Then the order can't be messed up

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
> +	NEEDS_DEVFS,
> +	NEEDS_DEVICE,
> +	NEEDS_HUGETLBFS,
> +	NEEDS_ROFS,
> +	NEEDS_ROOT,
> +	NEEDS_TMPDIR,
> +	RESTORE_WALLCLOCK,
> +	SKIP_FILESYSTEMS,
> +	SKIP_IN_COMPAT,
> +	SKIP_IN_LOCKDOWN,
> +	SKIP_IN_SECUREBOOT,
> +	SUPPORTED_ARCHS,
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
> +static ujson_obj_attr fs_attrs[] = {
> +	UJSON_OBJ_ATTR("mkfs_opts", UJSON_ARR),
> +	UJSON_OBJ_ATTR("mkfs_size_opt", UJSON_STR),
> +	UJSON_OBJ_ATTR("mnt_flags", UJSON_ARR),
> +	UJSON_OBJ_ATTR("type", UJSON_STR),
> +};
> +
> +static ujson_obj fs_obj = {
> +	.attrs = fs_attrs,
> +	.attr_cnt = UJSON_ARRAY_SIZE(fs_attrs),
> +};
> +
> +/* Must match the order of fs_attrs. */
> +enum fs_ids {
> +	MKFS_OPTS,
> +	MKFS_SIZE_OPT,
> +	MNT_FLAGS,
> +	TYPE,
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
> +struct tst_fs *parse_filesystems(ujson_reader *reader, ujson_val *val)
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
> +		case NEEDS_DEVFS:
> +			test.needs_devfs = val.val_bool;
> +		break;
> +		case NEEDS_DEVICE:
> +			test.needs_device = val.val_bool;
> +		break;
> +		case NEEDS_HUGETLBFS:
> +			test.needs_hugetlbfs = val.val_bool;
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
> +		}
> +	}
> +
> +	ujson_reader_finish(&reader);
> +
> +	if (ujson_reader_err(&reader))
> +		tst_brk(TBROK, "Invalid metadata");
> +}
> +
> +static void extract_metadata(void)
> +{
> +	FILE *f;
> +	char line[4096];
> +	char path[4096];
> +	int in_json = 0;
> +
> +	if (tst_get_path(shell_filename, path, sizeof(path)) == -1)
> +		tst_brk(TBROK, "Failed to find %s in $PATH", shell_filename);
> +
> +	f = SAFE_FOPEN(path, "r");
> +
> +	while (fgets(line, sizeof(line), f)) {
> +		if (in_json)
> +			metadata_append(line + 2);
> +
> +		if (in_json) {
> +			if (!strcmp(line, "# }\n"))
> +				in_json = 0;
> +		} else {
> +			if (!strcmp(line, "# TEST = {\n")) {
> +				metadata_append("{\n");
> +				in_json = 1;
> +			}
> +		}

This is maybe a little bit too rigid, even if you want this exact
formatting to be the only valid one. People will get frustrated when
parsing fails due to whitespace and don't see a clear indication why
it failed.

Alternativey you could adopt the standard markdown meta-data format
where the meta-data is enclosed with three dashes like

---
"meta": "data"
---

at the top of the file. I suppose you could change it to have comments
if you want the script to run outside LTP's runner.

In any case using three dots removes any whitespace between tokens which
is harder to trim.

The whole patchset looks good though.

Reviewed-by: Richard Palethorpe <io@richiejp.com>

-- 
Thank you,
Richard,
richiejp.com.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
