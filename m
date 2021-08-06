From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 06 Aug 2021 08:26:04 +0100
Subject: [LTP] [PATCH v4 3/3] Add setsockopt08, CVE-2021-22555
In-Reply-To: <YQv/lZ858UReF5Vs@yuki>
References: <87a6lwmm6c.fsf@suse.de>
 <20210805083539.20634-1-rpalethorpe@suse.com>
 <20210805083539.20634-3-rpalethorpe@suse.com> <YQv6/oHmYUVeb63S@yuki>
 <YQv/lZ858UReF5Vs@yuki>
Message-ID: <877dgzm3ub.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Cyril,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > +#include "tst_test.h"
>> > +#include "tst_safe_net.h"
>> > +#include "lapi/ip_tables.h"
>> 
>> I've fixed the failure on Centos with missing IFNAMSIZ but this still
>> fails to compile on ubuntu xenial because the tst_safe_net.h pull in
>> netinet/in.h and lapi/ip_tables.h pulls in linux/in.h and on old enough
>> systems these two headers does not like to be included at the same time.
>> 
>> I'm not sure how to fix this, either we drop the include to
>> linux/netfilter_ipv4/ip_tables.h completely or we add a configure check
>> if netinet/in.h and linux/in.h could be included at the same time and
>> ifdef the linux/netfilter_ipv4/ip_tables.h with that check.
>> 
>> Either way both looks like a hack, if anyone has a better idea please
>> suggest it.
>
> Uff and it looks like setsockopt03 does include the same headers so this
> could probably be fixed by another shuffle, but I will have to figure
> out what has to be moved and where.

Looking in libc-compat.h we have:

/* Coordinate with glibc netinet/in.h header. */
#if defined(_NETINET_IN_H)

/* GLIBC headers included first so don't define anything
 * that would already be defined. */
#define __UAPI_DEF_IN_ADDR		0
...


I suppose we may be able to do something similar. In tst_safe_net.h we
could check if _LINUX_IN_H is defined before including
netinet/in.h. Then include lapi/ip_tables.h first. Maybe even put

#ifdef _NETINET_IN_H
# error "incompatible system header ..."
#endif

in lapi/ip_tables.h

IDK if this may break some existing tests.

-- 
Thank you,
Richard.
