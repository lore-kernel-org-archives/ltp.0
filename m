From: Petr Vorel <petr.vorel@gmail.com>
Date: Thu, 17 Oct 2019 22:16:12 +0200
Subject: [LTP] [PATCH 1/1] setxattr03: define _GNU_SOURCE to fix build
 on musl
In-Reply-To: <20191017091533.GA20152@rei.lan>
References: <20191016213001.23047-1-petr.vorel@gmail.com>
 <20191017091533.GA20152@rei.lan>
Message-ID: <20191017201611.GA4840@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Jan,

> Hi!
> > musl defines loff_t in <fcntl.h> (already included) and guard it under _GNU_SOURCE.
> > NOTE: glibc and others define it in <sys/types.h>

> I would say that this is obvious enough to go in without a review, acked
> nevertheless.

Thanks for review, pushed.
Sorry for taking your time with obvious fix, next time I'll push it.

Kind regards,
Petr
