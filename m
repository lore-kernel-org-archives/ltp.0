From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Jul 2019 14:23:25 +0800
Subject: [LTP] [PATCH RFC] move_pages12: handle errno EBUSY for
 madvise(..., MADV_SOFT_OFFLINE)
In-Reply-To: <CAEemH2fGUABOfz=Yq6xONgmHwjaiU6n_q=9EXyZz2EUedpuK8Q@mail.gmail.com>
References: <20190607095213.13372-1-liwang@redhat.com>
 <20190703131005.GA1712@rei>
 <CAEemH2fGUABOfz=Yq6xONgmHwjaiU6n_q=9EXyZz2EUedpuK8Q@mail.gmail.com>
Message-ID: <CAEemH2eMA78=5eNwJnZPJ1kw1GZnimSyBsQ+e_wrAu3E+JOoPg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> iteration, the mmap() will be failed with ENOMEM(since we only have 1 huge
> page in /proc/.../nr_hugepages).
>

Sentence correction:
    It is not "only have 1 huge page in nr_hugepages", I mixed this test
with another case, sorry about that.

But the justification is the same, we don't have enough memory for the
parent does mmap(..., MAP_HUGETLB) in a new loop.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190704/93def422/attachment.htm>
