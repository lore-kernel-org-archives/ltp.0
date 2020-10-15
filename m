From: Li Wang <liwang@redhat.com>
Date: Thu, 15 Oct 2020 14:45:27 +0800
Subject: [LTP] [PATCH] memcg_use_hierarchy_test.sh: skip setting
 use_hierarchy if not available
In-Reply-To: <57e1161dae434ffda48b0e0cc261e706@G08CNEXMBPEKD04.g08.fujitsu.local>
References: <57e1161dae434ffda48b0e0cc261e706@G08CNEXMBPEKD04.g08.fujitsu.local>
Message-ID: <CAEemH2f_XrhCWq_B-njUDC5_rz-PNChm8Os-zDF18pN3AQpfgA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Chen, Hanxiao <chenhx.fnst@cn.fujitsu.com> wrote:

 *...*
>
> >@Li, I think this patch is ok, Do you have some comment about it?
>
> >
>
> >I'm ok to go with memory.use_hierarchy checking in the preconditioning
> phase.
>
> >
>
> >But how can you assert the default memory cgroup is mount at path:
> "/sys/fs/cgroup/memory", is there any possibility the default path mount at
> other places(for different distribution)?
>
>
>
>
> https://github.com/torvalds/linux/blob/b5fc7a89e58bcc059a3d5e4db79c481fb437de59/kernel/cgroup/cgroup.c#L5768
>
>
>
> WARN_ON(sysfs_create_mount_point(fs_kobj, "cgroup"));
>
>
>
> So the default mount place should be /sys/fs/cgroup if distributions
>
> did not modify these lines.
>
>
>
> As the discussion above,
>
> mount -t cgroup -omemory memcg /dev/memcg
>
> kernel will find a suitable cgroup root for us.
>
>
>
> How about reading /dev/memcg/memory.use_hierarchy as Yang recommended
> instead?
>

Sure.

But also, shouldn't we check if the '/dev/memcg' has sub-directory
before changing the memory.use_hiearchy in memcg_lib.sh?

As you noted in the description, enabling/disabling will fail if either
the cgroup already has other cgroups created below it.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201015/654192f6/attachment-0001.htm>
