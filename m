From: Sandeep Patil <sspatil@android.com>
Date: Fri, 12 Apr 2019 12:49:21 -0700
Subject: [LTP] [PATCH v1] rt_tgsigqueueinfo01.c: replace definition
 ANDROID with __ANDROID__
In-Reply-To: <ee2af517-8cb1-de29-0ec1-a16818087d0b@xiaopeng.com>
References: <1554992779-14595-1-git-send-email-ruanzw@xiaopeng.com>
 <20190411174638.GA11576@dell5510>
 <ee2af517-8cb1-de29-0ec1-a16818087d0b@xiaopeng.com>
Message-ID: <20190412194921.GF124555@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Fri, Apr 12, 2019 at 11:36:46PM +0800, 阮正旺 wrote:
> Hi Petr, Sandeep, Steve,
> 
> 
> -------- Original Message --------
> From: Petr Vorel
> Sent: Thu, 11 Apr 2019 19:46:38 +0200
> To: Zhengwang Ruan, Steve Muckle, Sandeep Patil
> Cc: Ltp
> Subject: Re: [LTP] [PATCH v1] rt_tgsigqueueinfo01.c: replace definition
> ANDROID with __ANDROID__
> > Hi,
> > 
> > > Replace the incorrect definition of ANDROID with __ANDROID__.
> > > +++ b/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
> > > @@ -25,7 +25,7 @@
> > >   #include "tst_test.h"
> > >   #include "lapi/syscalls.h"
> > > -#ifndef ANDROID
> > > +#ifndef __ANDROID__
> > Simple grep in AOSP tree would be for this change (and I'd personally prefer it as well)
> > I'd kindly ask android devs which one is correct :). BTW ANDROID was added by Steve.
> 
> According to also [1], this patch is acceptable, right?

Yes, indeed.

Acked-by: Sandeep Patil <sspatil@android.com>
