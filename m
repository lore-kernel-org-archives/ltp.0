From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Jul 2019 11:29:09 +0800
Subject: [LTP] [PATCH RFC] move_pages12: handle errno EBUSY for
 madvise(..., MADV_SOFT_OFFLINE)
In-Reply-To: <5D142EF6.6030402@cn.fujitsu.com>
References: <20190607095213.13372-1-liwang@redhat.com>
 <20190610032754.GA7114@hori.linux.bs1.fc.nec.co.jp>
 <5D0C7204.9020704@cn.fujitsu.com>
 <CAEemH2c+CWAOmAH=1WT+GR-iZ=5RoDcCmD=-zBpc63PHg6xXyQ@mail.gmail.com>
 <5D142EF6.6030402@cn.fujitsu.com>
Message-ID: <CAEemH2dHGvv_fP3AFstX5Corc4D0pK_ULGxANzkf4+biR5WC-A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

On Thu, Jun 27, 2019 at 10:50 AM Yang Xu <xuyang2018.jy@cn.fujitsu.com>
wrote:

> ...
>> Hi Li
>>
>> Your patch can handle EBUSY errno correctly for soft offline.
>> But move page  may be killed by SIGBUS because of  MCE  when we soft
>> offline concurrently.
>> That leads to move_page failed with ESRCH.   Also, move page may fails
>> with ENOMEM .
>> Do you notice it ?
>>
>
> I didn't get this failure, it seems not related to this patch. Two
> questions:
>
> 1. which kernel version do you test?
> 2. can you reproduce this without my patch?
>
> Hi Li
>
> I test it on 3.10.0-957.el7.x86_64  kvm(my machine was not support numa
> and i enable it on kvm. as below:
>  <cpu mode='custom' match='exact' check='full'>
>     <model fallback='forbid'>Penryn</model>
>     <feature policy='require' name='x2apic'/>
>     <feature policy='require' name='hypervisor'/>
>     <numa>
>       <cell id='0' cpus='0' memory='1048576' unit='KiB'/>
>       <cell id='1' cpus='1' memory='1048576' unit='KiB'/>
>     </numa>
>   </cpu>
>
> Does it only exist on kvm and doesn't  exist on physical machine?  I don't
> have physical machine that supports numa.
>

I can reproduce your problem on bare metal too, it seems like you hit the
bug as the commit 6bc9b56433b (mm: fix race on soft-offlining free huge
pages) described, which Naoya pointed out before:

See:

+               /*
+                * We set PG_hwpoison only when the migration source
hugepage
+                * was successfully dissolved, because otherwise hwpoisoned
+                * hugepage remains on free hugepage list, then userspace
will
+                * find it as SIGBUS by allocation failure. That's not
expected
+                * in soft-offlining.
+                */
+               ret = dissolve_free_huge_page(page);
+               if (!ret) {
+                       if (set_hwpoison_free_buddy_page(page))
+                               num_poisoned_pages_inc();
+               }

And, this bz still exists in the latest rhel7 kernel, I will open a bug to
RHEL7 product.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190704/8774640e/attachment-0001.htm>
