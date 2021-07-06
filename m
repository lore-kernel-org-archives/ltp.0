From: Li Wang <liwang@redhat.com>
Date: Tue, 6 Jul 2021 20:49:15 +0800
Subject: [LTP] [PATCH] shmget03: fix test when some shm segments already
 exist
In-Reply-To: <20210706105758.43220-1-aleksei.kodanev@bell-sw.com>
References: <20210706105758.43220-1-aleksei.kodanev@bell-sw.com>
Message-ID: <CAEemH2cOm+1BMWE7oWVFttXNOeQsYk9veXePS+ctxAABk2rCWQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,

On Tue, Jul 6, 2021 at 6:59 PM Alexey Kodanev <aleksei.kodanev@bell-sw.com>
wrote:

> It's unlikely, but still possible that some of them could be
> created during the test as well, so the patch only checks
> errno.
>

Thanks for fixing this, seems the msgget03 has this problem as well.
https://github.com/linux-test-project/ltp/issues/842


> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
>
 Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210706/d67fbe02/attachment.htm>
