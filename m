From: xuyang <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 11 Apr 2019 15:54:17 +0800
Subject: [LTP] [PATCH] syscalls/clock_adjtime: Fix compiler error
In-Reply-To: <20190411074640.GA1498@rei>
References: <1554965824-2374-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190411074640.GA1498@rei>
Message-ID: <5CAEF2A9.3000507@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2019/4/11 15:46, Cyril Hrubis wrote:
> Hi!
>> 'ADJ_OFFSET_SS_READ' 'ADJ_NANO' 'STA_NANO' and 'ADJ_MICRO' are not defined on
>> some old distros, so add them into 'include/lapi/posix_clocks.h' to fix it.
>>
>> These macros are introduced by the following commit:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=52bfb36
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=eea83d8
>>
>> sys_clock_adjtime are introduced by the following commit:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=339dc50
>>
>> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   include/lapi/posix_clocks.h | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/include/lapi/posix_clocks.h b/include/lapi/posix_clocks.h
>> index b1f7a7c55..1d29107d8 100644
>> --- a/include/lapi/posix_clocks.h
>> +++ b/include/lapi/posix_clocks.h
>> @@ -39,4 +39,20 @@
>>   # define CLOCK_BOOTTIME_ALARM 9
>>   #endif
>>
>> +#ifndef ADJ_OFFSET_SS_READ
>> +# define ADJ_OFFSET_SS_READ 0xa001
>> +#endif
>> +
>> +#ifndef ADJ_NANO
>> +# define ADJ_NANO 0x2000
>> +#endif
>> +
>> +#ifndef STA_NANO
>> +# define STA_NANO 0x2000
>> +#endif
>> +
>> +#ifndef ADJ_MICRO
>> +# define ADJ_MICRO 0x1000
>> +#endif
> Can we start a new header in the lapi called timex.h and put these
> there? Other than that this looks good.
>
  I forget this.  OK ,I will move it into a new header called timex.h.




