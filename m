From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 28 Apr 2021 20:04:35 +0200
Subject: [LTP] [PATCH 1/2] syscalls/tkill: Convert tkill01 to the new API
In-Reply-To: <YIlRAanTIk9uKVEP@yuki>
References: <20210422065732.61222-1-xieziyao@huawei.com>
 <20210422065732.61222-2-xieziyao@huawei.com>
 <YIaWnt5ksxVyBvxk@pevik> <YIlRAanTIk9uKVEP@yuki>
Message-ID: <YImjs5KVqFFjDqw/@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Xie,

> > > +int sig_flag = 0;

> > It should be
> > static int sig_flag;

> It has to be volatile as well, if we are waiting in a bussy loop on it
> and it's changed ansynchronously from a signal handler, otherwise
> compiler may misoptimize the code.

> Generally the code that waits for a signal should look like:

> static volatile sig_atomic_t sig_flag;

Oh, yes, volatile. Thanks for other hints, code adjusted and whole patchset
merged.

Kind regards,
Petr
