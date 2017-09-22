From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 22 Sep 2017 04:57:40 -0400 (EDT)
Subject: [LTP] [PATCH v2] syscalls/clone09.c: add kernel version check
In-Reply-To: <1505785364-22465-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20170720121717.GG32092@rei>
 <1505785364-22465-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <986027145.19743530.1506070660802.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 1) On all kernels which support CONFIG_NET_NS, clone(2) only could return
>    EINVAL due to disabled CONFIG_NET_NS instead of unknown flags.  Please
>    see the following kernel code in net/core/net_namespace.c:
>    --------------------------------------------------------------------
>    struct net *copy_net_ns(unsigned long flags, struct net *old_net)
>    ...
>         #ifndef CONFIG_NET_NS
>                 return ERR_PTR(-EINVAL);
>         #endif
>    --------------------------------------------------------------------
> 
>    The support is introduced in kernel:
>    '9dd776b ("[NET]: Add network namespace clone & unshare support.")'
> 
> 2) Usually, a syscall flags should always include a check of the following
>    form in its implementation:
>    ---------------------------------
>    if (flags & ~(FL_XXX | FL_YYY))
>         return -EINVAL;
>    ---------------------------------
> 
>    This check could verify unknown flags, but clone(2) does not have the
>    check and just returns 0, this issue has been around for several years,
>    and it is hardly to be fixed since doing so would break existing
>    applications.
> 
>    Please see the following URL for detailed information:
>    https://lwn.net/Articles/588444/
> 
>    It is hard to make out whether CLONE_NEWNET is supported or not by
>    returned value and errno.
> 
>    According to above reasons and clone()'s manpage, i think we should
>    add kernel version check to skip this case on an old kernel and update
>    description about EINVAL.
> 

Pushed.

Thanks,
Jan
