From: Chen, Hanxiao <chenhx.fnst@cn.fujitsu.com>
Date: Wed, 14 Oct 2020 07:31:57 +0000
Subject: [LTP] =?utf-8?b?562U5aSNOiAgW1BBVENIXSBtZW1jZ191c2VfaGllcmFyY2h5?=
 =?utf-8?q?=5Ftest=2Esh=3A_skip_setting_use=5Fhierarchy_if_not_available?=
Message-ID: <57e1161dae434ffda48b0e0cc261e706@G08CNEXMBPEKD04.g08.fujitsu.local>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



Hi, Li

>???: Li Wang <liwang@redhat.com>
>????: 2020?10?14? 14:28
>???: Xu, Yang <xuyang2018.jy@cn.fujitsu.com>; Chen, Hanxiao <chenhx.fnst@cn.fujitsu.com>
>??: LTP List <ltp@lists.linux.it>
>??: Re: ??: [LTP] [PATCH] memcg_use_hierarchy_test.sh: skip setting use_hierarchy if not available
>
>
>
>On Tue, Oct 13, 2020 at 11:19 AM Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:
>Hi Hanxiao
>
>> Hi, Yang
>>
>>> -----??????-----
>>> ???: Re: [LTP] [PATCH] memcg_use_hierarchy_test.sh: skip setting
>>> use_hierarchy if not available
[snip]
>> The behavior above looks conflicting with https://www.kernel.org/doc/Documentation/cgroup-v1/memory.txt.
>Yes. Centos7 behavior is different from the documentation.
>>> So why not directly use /dev/memcg/memory.use_hierarchy value to judge in
>>> testcase after setting 0.
>> In setup_test from memcg_lib.sh, we actually did:
>>     mount -t cgroup -omemory memcg /dev/memcg
>> Then kernel will find a suitable cgroup root for us in cgroup1_mount.
>>
>> In this case, /sys/fs/cgroup/memory/ would be the good choice.
>> So it's equivalent to read memory.use_hierarchy from either side.
>I understand. Only a minor suggestion, please use tabs instead of spaces
>at the beginning of the line.
>
>
>This patch looks good to me,
>Acked-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>
>@Li, I think this patch is ok, Do you have some comment about it?
>
>I'm ok to go with memory.use_hierarchy checking in the preconditioning phase.
>
>But how can you assert the default memory cgroup is mount at path: "/sys/fs/cgroup/memory", is there any possibility the default path mount at other places(for different distribution)?

https://github.com/torvalds/linux/blob/b5fc7a89e58bcc059a3d5e4db79c481fb437de59/kernel/cgroup/cgroup.c#L5768

WARN_ON(sysfs_create_mount_point(fs_kobj, "cgroup"));

So the default mount place should be /sys/fs/cgroup if distributions
did not modify these lines.

As the discussion above,
mount -t cgroup -omemory memcg /dev/memcg
kernel will find a suitable cgroup root for us.

How about reading /dev/memcg/memory.use_hierarchy as Yang recommended instead?

Regards,

-   Hanxiao

>--
>Regards,
>Li Wang


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201014/2c23546c/attachment-0001.htm>
