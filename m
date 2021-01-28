From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 28 Jan 2021 07:41:59 +0000
Subject: [LTP] [PATCH] memcg/functional: Convert to newlib
In-Reply-To: <YBG4hFVo5wdaFnPa@pevik>
References: <20210125131746.74630-1-lkml@jv-coder.de>
 <e573f919-8205-40e2-5187-49bff0983872@jv-coder.de>
 <YBG4hFVo5wdaFnPa@pevik>
Message-ID: <87a6st8q48.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Petr,

Petr Vorel <pvorel@suse.cz> writes:

> Hi J?rg,
>
>> --- a/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
>> > +++ b/testcases/kernel/controllers/memcg/functional/memcg_failcnt.sh
>> > @@ -1,58 +1,39 @@
>> >   #!/bin/sh
>> > +# SPDX-License-Identifier: GPL-2.0-or-later
>> > +# Copyright (c) 2009 FUJITSU LIMITED
>> > +# Copyright (c) 2018-2019 ARM Ltd. All Rights Reserved.
>> This is bad copy-and-paste for all files, where I mentioned arm, sorry...
> That's not a big deal.
>
> On a first look good cleanup, thank you!
>
> I hope these tests aren't planned to be rewritten to C (like NUMA tests).
> I suppose not, but better to ask earlier.

I can look into that as they should use the new (WIP) CGroup C API. For
now it is probably best to keep them in Shell.

>
> Kind regards,
> Petr


-- 
Thank you,
Richard.
