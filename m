From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 30 Sep 2020 12:47:09 +0200
Subject: [LTP] [PATCH] controllers/cpuset_base_ops_testset.sh: Accept
 either 0 or -EINVAL when passing '0-'
In-Reply-To: <20200929025606.322543-1-yangx.jy@cn.fujitsu.com>
References: <20200929025606.322543-1-yangx.jy@cn.fujitsu.com>
Message-ID: <20200930104709.GC6611@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> When we write '0-' to cpuset.cpus/cpuset.mems, new bitmap_parselist()
> in kernel(e.g. newer than v4.2) treats it as an invalid value and old
> one treats it as a valid '0':
> -------------------------------------------
> on v5.8.0:
>  # echo 0- > cpuset.cpus
>  -bash: echo: write error: Invalid argument
>  # echo 0- > cpuset.mems
>  -bash: echo: write error: Invalid argument
> 
> on v4.0.0:
>  # echo '0-' >cpuset.cpus
>  # cat cpuset.cpus
>  0
>  # echo '0-' >cpuset.mems
>  # cat cpuset.cpus
>  0
> -------------------------------------------
> Note: commit d9282cb66353b changes the behavior.
> 
> Drop the check of kernel version and accept either 0 or -EINVAL
> because the change of behavior can be backported into old kernel.

Why can't we just simply adjust the kernel check, it looks like the
commit you mentioned was added to 4.3 so it should be fixed by changing
the line to:

	if tst_kvcmp -lt "4.3 RHEL6:2.6.32"; then

We want to at least keep the check for kernels newer than 4.3 just to
make sure that kernel keeps rejecting the '0-' invalid value.

-- 
Cyril Hrubis
chrubis@suse.cz
