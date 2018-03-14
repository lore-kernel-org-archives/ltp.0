From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 14 Mar 2018 16:48:38 +0100
Subject: [LTP] [PATCH 2/2] Add CVE-2017-18075,
	pcrypt mishandles freeing instances
In-Reply-To: <87bmfqofhj.fsf@suse.de>
References: <20180314145427.2738-1-rpalethorpe@suse.com>
 <20180314145427.2738-2-rpalethorpe@suse.com> <87bmfqofhj.fsf@suse.de>
Message-ID: <87zi3avesp.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Nicolai Stange writes:

> Richard Palethorpe <rpalethorpe@suse.com> writes:
>
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> ---
>>
>> I can not find the original reproducer posted upstream. I assume it was
>> created by syzkaller.
>
> Yes: https://groups.google.com/forum/#!topic/syzkaller-bugs/NKn_ivoPOpk
>
> However, this rewrite to crypto's netlink interface might be different
> enough such that ...
>
>
>> diff --git a/testcases/cve/cve-2017-18075.c b/testcases/cve/cve-2017-18075.c
>> new file mode 100644
>> index 000000000..3723b0655
>> --- /dev/null
>> +++ b/testcases/cve/cve-2017-18075.c
>> @@ -0,0 +1,201 @@
>> +/*
>> + * Copyright (c) 2018 SUSE
>> + * Author: Nicolai Stange <nstange@suse.de>
>> + * LTP conversion: Richard Palethorpe <rpalethorpe@suse.com>
>> + *
>> + * Based on the reproducer posted upstream so other copyrights may
>> + * apply.
>
> ... this isn't really needed, but I'm not a lawyer.
>
> Thanks,
>
> Nicolai
>

I will just replace it with a link to the Syzkaller reproducer (mainly
just for people's information). Thanks.

>
>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License
>> + * as published by the Free Software Foundation; either version 2
>> + * of the License, or (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
>> + *
>> + * Test for CVE-2017-5754 - pcrypt mishandles freeing instances
>> + *
>> + * See commit d76c68109f37 crypto: pcrypt - fix freeing pcrypt instances.
>> + *
>> + * If the bug is present this will most likely crash your kernel.
>> + */
>> +


--
Thank you,
Richard.
