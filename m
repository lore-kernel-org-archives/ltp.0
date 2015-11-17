From: Li Wang <liwang@redhat.com>
Date: Tue, 17 Nov 2015 15:52:29 +0800
Subject: [LTP] [PATCH] futex: skip futex_wake04.c if system not support
 huge pages
In-Reply-To: <CAEemH2es-GOQF48wTpcc=FnRWC-Qi7H3327h=gR01ptiBCGUFQ@mail.gmail.com>
References: <1447576860-9189-1-git-send-email-liwang@redhat.com>
 <20151116050627.GA15996@home.allenx.org>
 <CAEemH2ezRDHhyNGHQgzBdMmihB_AXZ91PVcx+21u=9HGnqo9vg@mail.gmail.com>
 <20151116073720.GA1234@home.allenx.org>
 <CAEemH2es-GOQF48wTpcc=FnRWC-Qi7H3327h=gR01ptiBCGUFQ@mail.gmail.com>
Message-ID: <CAEemH2d=8jsB+agXPP9rkkiZ7eA6yifaugAVkzJfjB9POP37kA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On Mon, Nov 16, 2015 at 5:01 PM, Li Wang <liwang@redhat.com> wrote:

> Hi,
>
> On Mon, Nov 16, 2015 at 3:37 PM, Wanlong Gao <wanlong.gao@gmail.com>
> wrote:
>
>> On Mon, Nov 16, 2015 at 02:00:52PM +0800, Li Wang wrote:
>> >
>> > In my test system, there exist file "/proc/sys/vm/nr_hugepages" with
>> normal
>> > permission, but reject any R/W operation.
>> >
>> > So, if I use   if (access(PATH_NR_HUGEPAGES, F_OK) == -1),  It doesn't
>> work.
>> >
>> > # ll /proc/sys/vm/nr_hugepages
>> > -rw-r--r--. 1 root root 0 Nov 15 09:03 /proc/sys/vm/nr_hugepages
>> >
>> > # cat /proc/sys/vm/nr_hugepages
>> > cat: write error: Bad address
>>
>> Would you show your kernel version or investigate why this happens?
>> This should not exist if we disable the hugetlbfs in kernel config.
>>
>
> I looked close to my test bed, it is a KVM Guest which enabled hugetlbfs
> on IBM POWER8E,
>
> the config is:
> CONFIG_CGROUP_HUGETLB=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HUGETLB_PAGE_SIZE_VARIABLE=y
> CONFIG_SYS_SUPPORTS_HUGETLBFS=y
> CONFIG_TRANSPARENT_HUGEPAGE=y
> # CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
> CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=y
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
>
> # uname -r
> 3.10.0-*.el7.ppc64le
>
>
>>
>> > VmallocChunk:   8589850624 kB
>> > HardwareCorrupted:     0 kB
>>
>> > AnonHugePages:         0 kB
>>
>> This tells that your kernel support THP.
>>
>
> yes, the reason is that my kvm guest XML was not added these below line:
>
> guest XML:
>  <memoryBacking>
>       <hugepages/>
>  </memoryBacking>
>
> after adding them, the kvm guest can works well with hugepages.
>
> it is a configuration issue of guest, not a kernel bug.  so, I propose my
> patch as previously.
>

IMO, if we use the original "/proc/sys/vm/nr_hugepages" to check the hugetlb
support, it does not work on the situation which I mentioned above.

So, I suggest to add new Marco 'PATH_SYS_HUGEPAGES'  to skip the testcase.

what do you think?

-- 
Regards,
Li Wang
Email: liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20151117/932a8a90/attachment-0001.html>
