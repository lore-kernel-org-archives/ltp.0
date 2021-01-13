From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 Jan 2021 09:36:28 +0100
Subject: [LTP] [PATCH v2 1/3] lapi: Move struct file_handle into
 lapi/fcntl.h
In-Reply-To: <5FFEAD16.7050704@cn.fujitsu.com>
References: <20210113075110.31628-1-pvorel@suse.cz>
 <20210113075110.31628-2-pvorel@suse.cz>
 <5FFEAD16.7050704@cn.fujitsu.com>
Message-ID: <X/6xDNIUPMRMTi05@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

...
> > +AC_CHECK_TYPES([struct file_handle],,,[
> > +#define _GNU_SOURCE
> I think file_handle struct doesn't need _GNU_SOURCE macro or I miss
> something?

It does require :).
In glibc is guarded in sysdeps/unix/sysv/linux/bits/fcntl-linux.h with
__USE_GNU which is controlled by user with _GNU_SOURCE.

In musl (which is much easier to read) is just guarded by _GNU_SOURCE.

That is the reason why I guarded it with __USE_GNU in uclibc-ng, when I
backported there the implementation from musl.

Kind regards,
Petr

> Other than this, this patchset LGTM.
> Acked-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Thanks for your review!

Kind regards,
Petr
> > +#include<fcntl.h>
> > +])
