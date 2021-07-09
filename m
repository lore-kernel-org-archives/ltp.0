From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 09 Jul 2021 08:49:25 +0100
Subject: [LTP] [PATCH 3/7] meltdown: Set CFLAGS for check targets
In-Reply-To: <YOb5g66KfDWx77Hr@yuki>
References: <20210629072710.23800-1-rpalethorpe@suse.com>
 <20210629072710.23800-4-rpalethorpe@suse.com> <YOb5g66KfDWx77Hr@yuki>
Message-ID: <874kd46i62.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> The include set in the CFLAGS is necessary for Sparse to parse the
>> test source. If a specific target has variables set on it. Then these
>> won't be available to the corresponding check-target. Usually this is
>> not a problem because most variables set on a target are just for
>> linking and the checker doesn't need them.
>> 
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> ---
>>  testcases/cve/Makefile | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/testcases/cve/Makefile b/testcases/cve/Makefile
>> index ddf8b6fe1..7b011b6c9 100644
>> --- a/testcases/cve/Makefile
>> +++ b/testcases/cve/Makefile
>> @@ -19,6 +19,7 @@ cve-2014-0196:  LDLIBS += -lutil
>>  endif
>>  
>>  meltdown: CFLAGS += -I$(abs_srcdir)/../realtime/include
>> +check-meltdown: CFLAGS += -I$(abs_srcdir)/../realtime/include
>
> Uff, this will likely bite us in a different ways later on.
>
> I guess that it would be cleaner to move the libtsc.h into top level
> include so that it's clear that the header is used in several tests.

+1

-- 
Thank you,
Richard.
