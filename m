From: Li Wang <liwang@redhat.com>
Date: Thu, 12 Sep 2019 14:18:13 +0800
Subject: [LTP] [PATCH V2] madvise09:Update PAGES to a larger value
In-Reply-To: <1568266635-17666-1-git-send-email-shuang.qiu@oracle.com>
References: <1568266635-17666-1-git-send-email-shuang.qiu@oracle.com>
Message-ID: <CAEemH2dnWfhmTBHyKPJ9iAgEKPNcCBGwuUJ+zC8+UCFCvX5eSw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Shuang,

Thanks for the quick work on this.

There are two problems that you probably ignored.

1. On ppc64 system, the page size is 64KB, and 970 * 64KB is almost 60MB
which we do allocate. So we'd better raise
the limit_in_bytes/memsw.limit_in_bytes a little in cgroup correspondingly.

2. As Cascardo points out, madvise09 gets retries in an infinite loop when
hitting OOM. That's because, in the run() function, it does not limit the
retry times. We need to take care of this as well.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190912/af7974cb/attachment.htm>
