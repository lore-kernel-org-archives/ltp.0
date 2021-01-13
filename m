From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 13 Jan 2021 16:51:59 +0800
Subject: [LTP] [PATCH v2 1/3] lapi: Move struct file_handle into
 lapi/fcntl.h
In-Reply-To: <X/6xDNIUPMRMTi05@pevik>
References: <20210113075110.31628-1-pvorel@suse.cz>
 <20210113075110.31628-2-pvorel@suse.cz> <5FFEAD16.7050704@cn.fujitsu.com>
 <X/6xDNIUPMRMTi05@pevik>
Message-ID: <5FFEB4AF.5030602@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr
> Hi Xu,
>
> ...
>>> +AC_CHECK_TYPES([struct file_handle],,,[
>>> +#define _GNU_SOURCE
>> I think file_handle struct doesn't need _GNU_SOURCE macro or I miss
>> something?
>
> It does require :).
> In glibc is guarded in sysdeps/unix/sysv/linux/bits/fcntl-linux.h with
> __USE_GNU which is controlled by user with _GNU_SOURCE.
>
> In musl (which is much easier to read) is just guarded by _GNU_SOURCE.
>
> That is the reason why I guarded it with __USE_GNU in uclibc-ng, when I
> backported there the implementation from musl.
Thanks for your explanation, I see glibc code, you are right. I missed 
file_handle struct using _USE_GNU macro. Also, I see feature.h header 
uses _GNU_SOURCE controlling __USE_GNU.

Best Regards
Yang Xu
>
> Kind regards,
> Petr
>
>> Other than this, this patchset LGTM.
>> Acked-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
> Thanks for your review!
>
> Kind regards,
> Petr
>>> +#include<fcntl.h>
>>> +])
>
>
> .
>



