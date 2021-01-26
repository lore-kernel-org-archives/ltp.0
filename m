From: Li Wang <liwang@redhat.com>
Date: Tue, 26 Jan 2021 15:02:42 +0800
Subject: [LTP] [PATCH] syscalls/msync: Assgin value for page_sz
In-Reply-To: <1611625298-2425-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1611625298-2425-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <CAEemH2cHD43cw0nRNHDYF3R5sr0PQYAhtPHz+oxbDMSqsyEJ+g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jan 26, 2021 at 9:42 AM Yang Xu <xuyang2018.jy@cn.fujitsu.com>
wrote:

> Since the previous patch, it removes useless getpagesize()
> check because this function never fail. But it also remove
> the page_size assignment and it lead case fail as below:
>
> msync02     1  TBROK  :  msync02.c:133: mmap failed: errno=EINVAL(22):
> Invalid argument
> msync02     2  TBROK  :  msync02.c:133: Remaining cases broken
> msync02     3  TBROK  :  msync02.c:147: munmap failed: errno=EINVAL(22):
> Invalid argument
>
> Fix this and also fix compiler warning by using size_t data type instead
> of int.
>

Pushed, thanks for the fix.


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210126/a40c17fd/attachment.htm>
