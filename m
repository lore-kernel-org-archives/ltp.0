From: Nikita Gupta <nikitarulz@gmail.com>
Date: Tue, 27 Nov 2018 16:33:20 +0530
Subject: [LTP] LTP: HugeTLB failures in version ltp-20170516-179-g18916a2
In-Reply-To: <CAEemH2f+WkO6s7+FaiXoSWFf9Fm5UZRyF3Xv4ivSNR3znGAZrg@mail.gmail.com>
References: <CAGyGwR2x=f=h2ZsXz1AEHhjoChRffY69zRndA_7SC1C1D53qHg@mail.gmail.com>
 <CAEemH2f+WkO6s7+FaiXoSWFf9Fm5UZRyF3Xv4ivSNR3znGAZrg@mail.gmail.com>
Message-ID: <CAGyGwR1702Bp_ocoPTGabE1+NvyynSVjSGFEszkWu-Jc-n1OHA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Yes, it shows CONF on 20180926 release.
Looks like the issue was introduced in release 20170516 itself, because it
was showing CONF as expected in previous version "20170116".

Thanks,
Nikita

On Mon, Nov 26, 2018 at 10:20 AM Li Wang <liwang@redhat.com> wrote:

> On Mon, Nov 26, 2018 at 11:55 AM Nikita Gupta <nikitarulz@gmail.com>
> wrote:
> >
> > Hi All,
> >
> > HugeTLB is resulting into Conf in one version and Fail in another
> version for same kernel configuration.
>
> Thanks for reporting this.
>
> >
> > Version LTP-20170116:
> > All test cases of HugeTLB are marked Conf by ltp, stating:
> > 1  TCONF  :  hugetlb.c:45: Huge page is not supported.
> > 2  TCONF  :  hugetlb.c:45: Remaining cases not appropriate for
> configuration
> >
> > Version LTP-20170516-179-g18916a2:
>
> LTP-20170516-179-g18916a2e6 is not a stable release for LTP, it just
> contains part of patch set in hugetlb tests.
>
> The warning you mentioned has been fixed(merged by 20180118) in commit:
>
> commit a5489f1bc843b7bda74fca10fad2f8714b5fb090
> Author: Li Wang <liwang@redhat.com>
> Date:   Fri Dec 1 11:55:59 2017 +0800
>
>     hugetlb: fix warnings in cleanup()
>
>     Adding two functions [save|restore]_nr_hugepages() to the hugetlb
>     library, and meanwhile initialize the 'orig_hugepages' to '-1', then
>     we can make use of that to avoid those warnings on a system without
>     huge page supporting.
>
>     WARNING:
>        safe_file_ops.c:283: WARN: Failed to open FILE
> '/proc/sys/vm/nr_hugepages'
>        for writing at mem.c:853: ENOENT
>
>     Also, including "mem.h" in hugetlb lib to get rid of compile warnings.
>
> > All test cases of HugeTLB are marked Fail by LTP, stating:
> > tst_test.c:908: INFO: Timeout per run is 0h 05m 00s hugetlb.c:46: CONF:
> Huge page is not supported. mem.c:850: INFO: set nr_hugepages to 0
> safe_file_ops.c:283: WARN: Failed to open FILE '/proc/sys/vm/nr_hugepages'
> for writing at mem.c:853: ENOENT
> >
> > Isn't in version ltp-20170516-179-g18916a2 also, all test cases should
> be marked Conf.
> > As the file /proc/sys/vm/nr_hugepages is not present for both the
> versions.
>
> Yes, they should be marked as Conf too. But I think this kind of
> issues would be gone if you use latest LTP version. Can you have a try
> the 20180926 release?
> https://github.com/linux-test-project/ltp/releases/tag/20180926
>
> --
> Regards,
> Li Wang
>


-- 
Regards,
Nikita Gupta
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20181127/6798cf10/attachment.html>
