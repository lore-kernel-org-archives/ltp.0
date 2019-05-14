From: Li Wang <liwang@redhat.com>
Date: Tue, 14 May 2019 15:16:34 +0800
Subject: [LTP] LTP Release
In-Reply-To: <20190418111812.GB3073@rei.lan>
References: <20190418111812.GB3073@rei.lan>
Message-ID: <CAEemH2c-xuoLHMmp_-jOhsLa7PVxsxeKXq=wdJ5cVFROHv4yMQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

I have completed the latest LTP testing on RHEL-7.6 and RHEL-8.0 across all
arches(x86_64, ppc64le, ppc64, s390x, aarch64), here I post the summary FYI:

RHEL7.6
------------
1. crypto/af_alg01/02 (all arches - fail)
af_alg01 failure is a kernel bug.
af_alg02 test broken as what Christian's described in the patch. It should
be fixed on the kernel without that commit ecaaab564978 too.

2. binfmt_misc01.sh  (x86_64, s390x - fail, ppc64le/ppc64 - panic)
It looks like a kernel bug.

RHEL8.0
-------------
1. NUMA issue (ppc64le)
Numa test failed on that machine with non-continuous NUMA nodes. Two
patches for the problem solving has been sent to LTP-ML.

2. HUGETLB issue (aarch64)
hugetlb tests sometimes failed to request sufficient huge pages, even we
try limiting to 80% of the max huge page count is still not being satisfied
on 512MB huge page size system sometimes.

Besides these above failures, the remaining test looks pretty good.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190514/59eefb50/attachment.html>
