From: Li Wang <liwang@redhat.com>
Date: Thu, 8 Jul 2021 21:35:11 +0800
Subject: [LTP] [PATCH] gethostid: skip test if sethostid undefined
In-Reply-To: <YOb2ddFMEW1aniyI@yuki>
References: <20210708130602.970689-1-liwang@redhat.com> <YOb2ddFMEW1aniyI@yuki>
Message-ID: <CAEemH2ej5BBxppxOLnL-+QTRSChj+M8bVX_Abk75bUULrHpovg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > --- a/testcases/kernel/syscalls/gethostid/gethostid01.c
> > +++ b/testcases/kernel/syscalls/gethostid/gethostid01.c
> > @@ -26,6 +26,8 @@
> >
> >  #include "tst_test.h"
>
> Shouldn't we include config.h here?
>

Yes, merged with including. Thanks for the quick reply.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210708/f407eb87/attachment.htm>
