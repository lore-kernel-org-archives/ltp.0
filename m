From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 6 Jun 2019 18:41:30 +0800
Subject: [LTP] [PATCH] sysctl/sysctl02: Add new regression test for
 overflow file-max
In-Reply-To: <1559817080-2991-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1559817080-2991-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <5CF8EDDA.2010107@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all

  Please ingore this email. I will send a v2 patch. :-[ 

Thanks.

> On upstream kernel, before commit[1], the max value in proc_get_long based on
> the number of chars(21). It rejects values such as 184467440737095516160 (21 chars)
> but accepts values such as 18446744073709551616 (20 chars). But we should reject all
> because both are overflows. After this commit,the permitted max value is 2^64-1.
>
> Before commit[2], when writing echo 18446744073709551616 > /proc/sys/fs/file-max
> /proc/sys/fs/file-max will overflow and be set to 0.  It may crash the system. This
> commit sets the max and min value for file-max. After this commit,the permitted max
> value is 2^63-1.
>
> Unfortunately, commit[2] introduced a new bug because the minimum value points at
> the global 'zero' variable which is an int. It may crash system. This bug has been fixed
> bt commit[3].
>
> I will set 2^64 ,2^64-1,2^63 and 0 to file-max in case and test it.
>
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7f2923c4f73f21cfd714d12a2d48de8c21f11cfe
> [2]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=32a5ad9c22852e6bd9e74bdec5934ef9d1480bc5
> [3]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9002b21465fa4d829edfc94a5a441005cffaa972
>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  runtest/commands                      | 1 +
>  testcases/commands/sysctl/sysctl01.sh | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/runtest/commands b/runtest/commands
> index ac15e8b23..1870c4209 100644
> --- a/runtest/commands
> +++ b/runtest/commands
> @@ -40,3 +40,4 @@ keyctl01_sh keyctl01.sh
>  gdb01_sh gdb01.sh
>  unshare01_sh unshare01.sh
>  sysctl01_sh sysctl01.sh
> +sysctl02_sh sysctl02.sh
> diff --git a/testcases/commands/sysctl/sysctl01.sh b/testcases/commands/sysctl/sysctl01.sh
> index 7522da53d..bf89a6d8d 100755
> --- a/testcases/commands/sysctl/sysctl01.sh
> +++ b/testcases/commands/sysctl/sysctl01.sh
> @@ -1,5 +1,5 @@
>  #!/bin/sh
> -
> +#
>  # Copyright (c) 2018 FUJITSU LIMITED. All rights reserved.
>  # Author: Xiao Yang <yangx.jy@cn.fujitsu.com>
>  #



