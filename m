From: xieziyao <xieziyao@huawei.com>
Date: Thu, 29 Apr 2021 02:02:36 +0000
Subject: [LTP] [PATCH 1/2] syscalls/tkill: Convert tkill01 to the new API
In-Reply-To: <YImjs5KVqFFjDqw/@pevik>
References: <20210422065732.61222-1-xieziyao@huawei.com>
 <20210422065732.61222-2-xieziyao@huawei.com> <YIaWnt5ksxVyBvxk@pevik>
 <YIlRAanTIk9uKVEP@yuki> <YImjs5KVqFFjDqw/@pevik>
Message-ID: <23fa24747c7a410b9f52f0c34dfc0628@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi, Petr, Cyril,

Learned a lot. Thanks for your review and modifications to the code.

Kind regards,
Ziyao

-----Original Message-----
From: Petr Vorel [mailto:pvorel@suse.cz] 
Sent: Thursday, April 29, 2021 2:05 AM
To: Cyril Hrubis <chrubis@suse.cz>
Cc: xieziyao <xieziyao@huawei.com>; ltp@lists.linux.it
Subject: Re: [LTP] [PATCH 1/2] syscalls/tkill: Convert tkill01 to the new API

Hi Cyril, Xie,

> > > +int sig_flag = 0;

> > It should be
> > static int sig_flag;

> It has to be volatile as well, if we are waiting in a bussy loop on it 
> and it's changed ansynchronously from a signal handler, otherwise 
> compiler may misoptimize the code.

> Generally the code that waits for a signal should look like:

> static volatile sig_atomic_t sig_flag;

Oh, yes, volatile. Thanks for other hints, code adjusted and whole patchset merged.

Kind regards,
Petr
