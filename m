From: Li Wang <liwang@redhat.com>
Date: Wed, 14 Oct 2020 14:27:33 +0800
Subject: [LTP] 
	=?utf-8?b?562U5aSNOiAgW1BBVENIXSBtZW1jZ191c2VfaGllcmFyY2h5?=
	=?utf-8?q?=5Ftest=2Esh=3A_skip_setting_use=5Fhierarchy_if_not_avai?=
	=?utf-8?q?lable?=
In-Reply-To: <5F851CD7.8030005@cn.fujitsu.com>
References: <20200911092121.1917-1-chenhx.fnst@cn.fujitsu.com>
 <7584a7ab-bc37-111f-f9bf-38da2d1e8099@cn.fujitsu.com>
 <ebd86e7d991642cbb13e3ce46d032a69@G08CNEXMBPEKD04.g08.fujitsu.local>
 <5F851CD7.8030005@cn.fujitsu.com>
Message-ID: <CAEemH2fNrmOcY_wa3xC0GoHBqpnZkOkkMkoBDqeV1vs8pzHfgA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Oct 13, 2020 at 11:19 AM Yang Xu <xuyang2018.jy@cn.fujitsu.com>
wrote:

> Hi Hanxiao
>
> > Hi, Yang
> >
> >> -----??????-----
> >> ???: Re: [LTP] [PATCH] memcg_use_hierarchy_test.sh: skip setting
> >> use_hierarchy if not available
> >>
> >> Hi hanxiao
> >>
> >>
> >>> The precondition of this case is that we can disable use_hierarchy.
> >>> But some distributions such as CentOS 8 had enabled it in root cgroup
> >>> and hard to disabled.
> > [snip]
> >> /dev/memcg/memory.use_hierarchy" \
> >>> +                                    "to 0 failed"
> >>> +                        fi
> >>> +                fi
> >> I test this patch on centos7 and testcase2 skips. On centos7(without
> installing
> >> docker), /sys/fs/cgroup/memory/memory.use_hierarchy value is equal to 1
> and I
> >> still can disable value for /dev/memcg/memory.use_hierarchy.
> >>
> > The behavior above looks conflicting with
> https://www.kernel.org/doc/Documentation/cgroup-v1/memory.txt.
> Yes. Centos7 behavior is different from the documentation.
> >> So why not directly use /dev/memcg/memory.use_hierarchy value to judge
> in
> >> testcase after setting 0.
> > In setup_test from memcg_lib.sh, we actually did:
> >     mount -t cgroup -omemory memcg /dev/memcg
> > Then kernel will find a suitable cgroup root for us in cgroup1_mount.
> >
> > In this case, /sys/fs/cgroup/memory/ would be the good choice.
> > So it's equivalent to read memory.use_hierarchy from either side.
> I understand. Only a minor suggestion, please use tabs instead of spaces
> at the beginning of the line.
>
>
> This patch looks good to me,
> Acked-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>
> @Li, I think this patch is ok, Do you have some comment about it?
>

I'm ok to go with memory.use_hierarchy checking in the preconditioning
phase.

But how can you assert the default memory cgroup is mount at path:
"/sys/fs/cgroup/memory", is there any possibility the default path mount at
other places(for different distribution)?
-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201014/932b3f8b/attachment.htm>
