From: Enji Cooper <yaneurabeya@gmail.com>
Date: Fri, 12 Apr 2019 09:48:56 -0700
Subject: [LTP] [RFC PATCH 2/3] Add more missing <string.h> and
 <strings.h> includes
In-Reply-To: <806382ed-953c-f5f4-4629-15c5093b240f@xiaopeng.com>
References: <20190411233115.32744-1-pvorel@suse.cz>
 <20190411233115.32744-3-pvorel@suse.cz>
 <b9e58aac-eb0f-965a-c411-ef44c6a3ef27@xiaopeng.com>
 <20190412084932.GA28648@haruka.lan> <20190412084853.GB19937@x230>
 <806382ed-953c-f5f4-4629-15c5093b240f@xiaopeng.com>
Message-ID: <138B08E3-06EF-4DD4-895B-DC7C4FEA531B@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it


> On Apr 12, 2019, at 2:05 AM, 阮正旺 <ruanzw@xiaopeng.com> wrote:
> 
> Hi Petr, 
> 
> 
> -------- Original Message --------
> From: Petr Vorel
> Sent: Fri, 12 Apr 2019 10:48:53 +0200
> To: Cyril Hrubis
> Cc: ?????????, Ltp, Petr Vorel, Sandeep Patil, Steve Muckle
> Subject: Re: [RFC PATCH 2/3] Add more missing <string.h> and <strings.h> includes
>> Hi,
>> 
>>>>> diff --git a/include/tst_numa.h b/include/tst_numa.h
>>>>> index a4cd1be37..4f9806602 100644
>>>>> --- a/include/tst_numa.h
>>>>> +++ b/include/tst_numa.h
>>>>> @@ -7,6 +7,8 @@
>>>>>   #ifndef TST_NUMA_H__
>>>>>   #define TST_NUMA_H__
>>>>> +#include <string.h>
>>>>> +
>>>>>   /**
>>>>>    * Numa nodemap.
>>>>>    */
>>>>> diff --git a/lib/tst_af_alg.c b/lib/tst_af_alg.c
>>>>> index 97be548b4..edf8c0140 100644
>>>>> --- a/lib/tst_af_alg.c
>>>>> +++ b/lib/tst_af_alg.c
>>>>> @@ -5,6 +5,7 @@
>>>>>   #include <errno.h>
>>>>>   #include <stdlib.h>
>>>>> +#include <string.h>
>>>> Why not simply include <string.h>?? in tst_test.h. I did it in my another 
>>>> review thread. This should be OK for most of cases.
>>> Sounds reasonable to me.
>> Agree, that'd be the easiest way :). NOTE: not sure what requires that, but
>> sometimes is <strings.h> needed as well.
> As I know, calls likes str*, mem*, such as, strncpy, memset, requires <string.h>,  but bzero requires <strings.h>.  Fortunately <strings.h> are not used as often as <string.h>. See my another review thread. :-)
> 

(Looking at the header on FreeBSD) In addition to bzero, there are other deprecated functions like bcmp, bcopy, but also lesser used functions like strcasecmp and strncasecmp which are defined in strings.h .
Cheers,
-Enji
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190412/d32f4998/attachment.html>
