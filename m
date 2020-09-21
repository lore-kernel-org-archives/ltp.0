From: Chen, Hanxiao <chenhx.fnst@cn.fujitsu.com>
Date: Mon, 21 Sep 2020 10:53:58 +0000
Subject: [LTP] =?gb2312?b?tPC4tDogIFtQQVRDSF0gbWVtY2dfdXNlX2hpZXJhcmNo?=
 =?gb2312?b?eV90ZXN0LnNoOiBza2lwIHNldHRpbmcgdXNlX2hpZXJhcmNoeSBpZiBub3Qg?=
 =?gb2312?b?YXZhaWxhYmxl?=
In-Reply-To: <7584a7ab-bc37-111f-f9bf-38da2d1e8099@cn.fujitsu.com>
References: <20200911092121.1917-1-chenhx.fnst@cn.fujitsu.com>
 <7584a7ab-bc37-111f-f9bf-38da2d1e8099@cn.fujitsu.com>
Message-ID: <ebd86e7d991642cbb13e3ce46d032a69@G08CNEXMBPEKD04.g08.fujitsu.local>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, Yang

> -----????-----
> ??: Re: [LTP] [PATCH] memcg_use_hierarchy_test.sh: skip setting
> use_hierarchy if not available
> 
> Hi hanxiao
> 
> 
> > The precondition of this case is that we can disable use_hierarchy.
> > But some distributions such as CentOS 8 had enabled it in root cgroup
> > and hard to disabled.
[snip]
> /dev/memcg/memory.use_hierarchy" \
> > +                                    "to 0 failed"
> > +                        fi
> > +                fi
> I test this patch on centos7 and testcase2 skips. On centos7(without installing
> docker), /sys/fs/cgroup/memory/memory.use_hierarchy value is equal to 1 and I
> still can disable value for /dev/memcg/memory.use_hierarchy.
> 

The behavior above looks conflicting with https://www.kernel.org/doc/Documentation/cgroup-v1/memory.txt.

> So why not directly use /dev/memcg/memory.use_hierarchy value to judge in
> testcase after setting 0.

In setup_test from memcg_lib.sh, we actually did:
    mount -t cgroup -omemory memcg /dev/memcg
Then kernel will find a suitable cgroup root for us in cgroup1_mount.

In this case, /sys/fs/cgroup/memory/ would be the good choice.
So it's equivalent to read memory.use_hierarchy from either side.

Regards, 
- Hanxiao
> 
> Best Regards
> Yang Xu
> >   	fi
> >
> >   	ROD mkdir "/dev/memcg/$TEST_ID"
> > diff --git
> > a/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_te
> > st.sh
> > b/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_te
> > st.sh
> > index 4cf6b9fc2..1439b6352 100755
> > ---
> > a/testcases/kernel/controllers/memcg/functional/memcg_use_hierarchy_te
> > st.sh
> > +++ b/testcases/kernel/controllers/memcg/functional/memcg_use_hierarch
> > +++ y_test.sh
> > @@ -34,7 +34,9 @@ TST_TOTAL=3
> >   # test if one of the ancestors goes over its limit, the proces will be killed
> >   testcase_1()
> >   {
> > -	echo 1 > memory.use_hierarchy
> > +        if [ "$root_memory_use_hierarchy" != "1" ]; then
> > +                echo 1 > memory.use_hierarchy
> > +        fi
> >   	echo $PAGESIZE > memory.limit_in_bytes
> >
> >   	mkdir subgroup
> > @@ -48,6 +50,10 @@ testcase_1()
> >   # test Enabling will fail if the cgroup already has other cgroups
> >   testcase_2()
> >   {
> > +        if [ "$root_memory_use_hierarchy" = "1" ]; then
> > +               tst_resm TCONF "root cgroup has use_hierarchy enabled,
> skip"
> > +               return
> > +        fi
> >   	mkdir subgroup
> >   	EXPECT_FAIL echo 1 \> memory.use_hierarchy
> >
> > @@ -57,7 +63,9 @@ testcase_2()
> >   # test disabling will fail if the parent cgroup has enabled hierarchy.
> >   testcase_3()
> >   {
> > -	echo 1 > memory.use_hierarchy
> > +        if [ "$root_memory_use_hierarchy" != "1" ]; then
> > +               echo 1 > memory.use_hierarchy
> > +        fi
> >   	mkdir subgroup
> >   	EXPECT_FAIL echo 0 \> subgroup/memory.use_hierarchy
> >
> >


