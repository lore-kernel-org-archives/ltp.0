From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Jul 2020 16:42:01 +0200
Subject: [LTP] [PATCH v2] Add mincore() test for anonymous mappings
In-Reply-To: <20200706050828.5134-1-shwetha@zilogic.com>
References: <20200706050828.5134-1-shwetha@zilogic.com>
Message-ID: <20200708144201.GA20047@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with minor chnages, thanks.

> Changes from v1:
> 	1.Changed testcase description.
> 	2.Checked ptr before executing SAFE_MUNMAP() in cleanup().
> 	3.Added a setup() fuction.
> 	4.Fixed formatting issues.
> 	5.Changed TPASS and TFAIL messages.
> 	6.Changed syntax for conditional statements. 

This part belongs right after the --- below, so that it's not included
in the final commit message.

> References: #461
> 
> Signed-off-by: Shwetha Subramanian. <shwetha@zilogic.com>
> Reviewed-by: Vijay Kumar B. <vijaykumar@zilogic.com>
> ---
>  runtest/syscalls                              |  1 +
>  testcases/kernel/syscalls/mincore/.gitignore  |  1 +
>  testcases/kernel/syscalls/mincore/mincore03.c | 83 +++++++++++++++++++
>  3 files changed, 85 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/mincore/mincore03.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index b4d523319..e0fe9f87e 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -879,6 +879,7 @@ open_tree02 open_tree02
>  
>  mincore01 mincore01
>  mincore02 mincore02
> +mincore03 mincore03
>  
>  madvise01 madvise01
>  madvise02 madvise02
> diff --git a/testcases/kernel/syscalls/mincore/.gitignore b/testcases/kernel/syscalls/mincore/.gitignore
> index fdb2070e9..fcbe27eac 100644
> --- a/testcases/kernel/syscalls/mincore/.gitignore
> +++ b/testcases/kernel/syscalls/mincore/.gitignore
> @@ -1,2 +1,3 @@
>  /mincore01
>  /mincore02
> +/mincore03
> \ No newline at end of file

And I've added the missing newline here.

-- 
Cyril Hrubis
chrubis@suse.cz
