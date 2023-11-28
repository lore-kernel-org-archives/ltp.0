Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E4DC4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 06:03:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29E3B3CB7FF
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 07:03:24 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB9E03CB7FF
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 07:03:13 +0100 (CET)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C13186010EF
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 07:03:11 +0100 (CET)
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="141214782"
X-IronPort-AV: E=Sophos;i="6.04,233,1695654000"; d="scan'208";a="141214782"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Nov 2023 15:03:10 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com
 [192.168.87.59])
 by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id E47D8C13F9
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 15:03:07 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 19644BF4A0
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 15:03:07 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id A0255411B1
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 15:03:06 +0900 (JST)
Received: from [10.167.215.54] (unknown [10.167.215.54])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 412A81A0070;
 Tue, 28 Nov 2023 14:03:06 +0800 (CST)
Message-ID: <b5ecde53-5d29-f2d9-3e60-28a942e6745f@fujitsu.com>
Date: Tue, 28 Nov 2023 14:03:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it
References: <20231102080535.63847-1-xuyang2018.jy@fujitsu.com>
 <20231102080535.63847-2-xuyang2018.jy@fujitsu.com>
From: Xiao Yang <yangx.jy@fujitsu.com>
In-Reply-To: <20231102080535.63847-2-xuyang2018.jy@fujitsu.com>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28024.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28024.004
X-TMASE-Result: 10--22.687200-10.000000
X-TMASE-MatchedRID: 5U6uFEJz7+qPvrMjLFD6eJTQgFTHgkhZJuDBbd4NSqQabM1FLbewEfy+
 IfkvA3MsEhR3fbScnAAep5R/z/M+R9LD1JtLwEG8rMZ+BqQt2NpMkOX0UoduuToUdFbHYUawjdx
 5FdhImgMi+t+0AiFaYlTUIALB54vg1s1AHJ9E8eBKzjuZtPtIBPNYQxCOihTNKGMPyR9DzLKpuz
 6cn+0UkegIagXx0bQ984RHMLcpypfPl7LciQedTr9A3Bl1/DcVBpEC0DNwn/rlxHa+XqFBzxFEt
 97pQ+C8Ykf8dVZxle+haPHzLt/cif27vtwnQ39AngIgpj8eDcC063Wh9WVqgtQdB5NUNSsiDrBA
 jvbPhh50HSe131POnpBlLa6MK1y4
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] Add error tests for pathconf() system call
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Yang

It looks good to me.
Reviewed-by: Xiao Yang <yangx.jy@fujitsu.com>

Best Regards,
Xiao Yang

On 2023/11/2 16:05, Yang Xu wrote:
> A series of tests were added to test the negative results of pathconf()
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>   runtest/syscalls                              |  1 +
>   testcases/kernel/syscalls/pathconf/.gitignore |  1 +
>   .../kernel/syscalls/pathconf/pathconf02.c     | 97 +++++++++++++++++++
>   3 files changed, 99 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/pathconf/pathconf02.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 1851752cf..e20f0c49e 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -971,6 +971,7 @@ madvise11 madvise11
>   newuname01 newuname01
>   
>   pathconf01 pathconf01
> +pathconf02 pathconf02
>   
>   pause01 pause01
>   pause02 pause02
> diff --git a/testcases/kernel/syscalls/pathconf/.gitignore b/testcases/kernel/syscalls/pathconf/.gitignore
> index 31abe8a28..82e38b253 100644
> --- a/testcases/kernel/syscalls/pathconf/.gitignore
> +++ b/testcases/kernel/syscalls/pathconf/.gitignore
> @@ -1 +1,2 @@
>   /pathconf01
> +/pathconf02
> diff --git a/testcases/kernel/syscalls/pathconf/pathconf02.c b/testcases/kernel/syscalls/pathconf/pathconf02.c
> new file mode 100644
> index 000000000..8d7996190
> --- /dev/null
> +++ b/testcases/kernel/syscalls/pathconf/pathconf02.c
> @@ -0,0 +1,97 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Verify that,
> + *
> + * - pathconf() fails with ENOTDIR if A component used as a directory
> + *   in path is not in fact a directory.
> + * - pathconf() fails with ENOENT if path is an empty string.
> + * - pathconf() fails with ENAMETOOLONG if path is too long.
> + * - pathconf() fails with EINVA if name is invalid.
> + * - pathconf() fails with EACCES if search permission is denied for
> + *   one of the directories in the path prefix of path.
> + * - pathconf() fails with ELOOP if too many symbolic links were
> + *   encountered while resolving path.
> + */
> +
> +#define FILEPATH "testfile/testfile_1"
> +#define TESTELOOP "test_eloop1"
> +
> +#include <stdlib.h>
> +#include <pwd.h>
> +#include "tst_test.h"
> +
> +static char *fpath;
> +static char *emptypath;
> +static char path[PATH_MAX + 2];
> +static char *long_path = path;
> +static char *abs_path;
> +static char *testeloop;
> +static struct passwd *user;
> +
> +static struct tcase {
> +	char **path;
> +	int name;
> +	int exp_errno;
> +	char *desc;
> +} tcases[] = {
> +	{&fpath, 0, ENOTDIR, "path prefix is not a directory"},
> +	{&emptypath, 0, ENOENT, "path is an empty string"},
> +	{&long_path, 0, ENAMETOOLONG, "path is too long"},
> +	{&abs_path, -1, EINVAL, "name is invalid"},
> +	{&abs_path, 0, EACCES, "without full permissions of the path prefix"},
> +	{&testeloop, 0, ELOOP, "too many symbolic links"},
> +};
> +
> +static void verify_fpathconf(unsigned int i)
> +{
> +	struct tcase *tc = &tcases[i];
> +
> +	if (tc->exp_errno == EACCES)
> +		SAFE_SETEUID(user->pw_uid);
> +
> +	TST_EXP_FAIL(pathconf(*tc->path, tc->name), tc->exp_errno,
> +		     "pathconf() fail with %s", tc->desc);
> +
> +	if (tc->exp_errno == EACCES)
> +		SAFE_SETEUID(0);
> +}
> +
> +static void setup(void)
> +{
> +	user = SAFE_GETPWNAM("nobody");
> +
> +	SAFE_TOUCH("testfile", 0777, NULL);
> +
> +	char *tmpdir =  tst_get_tmpdir();
> +
> +	abs_path = tst_aprintf("%s/%s", tmpdir, FILEPATH);
> +
> +	SAFE_CHMOD(tmpdir, 0);
> +	free(tmpdir);
> +
> +	memset(path, 'a', PATH_MAX + 2);
> +
> +	SAFE_SYMLINK("test_eloop1", "test_eloop2");
> +	SAFE_SYMLINK("test_eloop2", "test_eloop1");
> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_fpathconf,
> +	.setup = setup,
> +	.needs_tmpdir = 1,
> +	.bufs = (struct tst_buffers []) {
> +		{&fpath, .str = FILEPATH},
> +		{&emptypath, .str = ""},
> +		{&testeloop, .str = TESTELOOP},
> +		{},
> +	},
> +	.needs_root = 1,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
