From: Li Wang <liwang@redhat.com>
Date: Tue, 16 Jul 2019 13:19:00 +0800
Subject: [LTP] [PATCH v7 1/4] lib/tst_ioctl.c: add helper tst_fibmap
In-Reply-To: <20190611074741.31903-1-xzhou@redhat.com>
References: <CAEemH2e5b4q+bOeE3v8FG-piSUteCinPMVmxpnkVcYCmrUc4Uw@mail.gmail.com>
 <20190611074741.31903-1-xzhou@redhat.com>
Message-ID: <CAEemH2c6FcpN-Z6pBK277UOWoBH+vSvxrCHddH2WCaRcG8N4hw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jun 11, 2019 at 3:48 PM Murphy Zhou <xzhou@redhat.com> wrote:

> To check if FIBMAP ioctl is supported by the filesystem we are
> testing on. It also can check the support status of specific
> files, but that may not needed for now.
>
> Reviewed-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Murphy Zhou <xzhou@redhat.com>
>

Patch set pushed, thanks.

I also added Amir's reviewed by.
    Reviewed-by: Amir Goldstein <amir73il@gmail.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190716/f00a03c3/attachment.htm>
