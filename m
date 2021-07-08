From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 8 Jul 2021 19:00:10 +0200
Subject: [LTP] [PATCH] gethostid: skip test if sethostid undefined
In-Reply-To: <CAEemH2ej5BBxppxOLnL-+QTRSChj+M8bVX_Abk75bUULrHpovg@mail.gmail.com>
References: <20210708130602.970689-1-liwang@redhat.com> <YOb2ddFMEW1aniyI@yuki>
 <CAEemH2ej5BBxppxOLnL-+QTRSChj+M8bVX_Abk75bUULrHpovg@mail.gmail.com>
Message-ID: <YOcvGinZBbwj12cH@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> > > --- a/testcases/kernel/syscalls/gethostid/gethostid01.c
> > > +++ b/testcases/kernel/syscalls/gethostid/gethostid01.c
> > > @@ -26,6 +26,8 @@

> > >  #include "tst_test.h"

> > Shouldn't we include config.h here?


> Yes, merged with including. Thanks for the quick reply.

Thanks for fixing 39f341af5 ("gethostid: Rewrite with newlib and use/test sethostid")

Kind regards,
Petr
