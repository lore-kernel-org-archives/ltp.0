From: Punit Agrawal <punit.agrawal@arm.com>
Date: Fri, 01 Dec 2017 12:26:40 +0000
Subject: [LTP] [PATCH v2] hugetlb: fix warnings in cleanup()
In-Reply-To: <20171201035559.11478-1-liwang@redhat.com> (Li Wang's message of
 "Fri, 1 Dec 2017 11:55:59 +0800")
References: <20171201035559.11478-1-liwang@redhat.com>
Message-ID: <87a7z2zla7.fsf@e105922-lin.cambridge.arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

Li Wang <liwang@redhat.com> writes:

> Adding two functions [save|restore]_nr_hugepages() to the hugetlb
> library, and meanwhile initialize the 'orig_hugepages' to '-1', then
> we can make use of that to avoid those warnings on a system without
> huge page supporting.
>
> WARNING:
>    safe_file_ops.c:283: WARN: Failed to open FILE '/proc/sys/vm/nr_hugepages'
>    for writing at mem.c:853: ENOENT
>
> Also, including "mem.h" in hugetlb lib to get rid of compile warnings.
>

Thanks for cc'ing me on the patch. It conflicts with a couple of patches
I have in flight. I am happy to rebase on top if this one is ready for
merging.

One of the patches in the series, moves check_hugepage() from
hugetlb/lib/hugetlb.c into lib/mem.c[0] so that the hugepage check can
be added to thp tests.

Thanks,
Punit


[0] http://lists.linux.it/pipermail/ltp/2017-November/006415.html


[...]

