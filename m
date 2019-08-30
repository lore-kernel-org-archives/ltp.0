From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 30 Aug 2019 10:04:57 +0800
Subject: [LTP] [PATCH 1/2] runtest/syscalls: add set_mempolicy*
In-Reply-To: <20190829203826.GA5711@dell5510>
References: <1566987255-3010-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20190829203826.GA5711@dell5510>
Message-ID: <5D688449.3080906@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/08/30 4:38, Petr Vorel wrote:
> Hi,
>
>> Since commit 55ee8a5ad ("syscalls: Add set_mempolicy numa tests"),
>> these cases have been added into runtests/numa, but forget to add it
>> in runtest/syscalls.
>> Signed-off-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>> ---
>>   runtest/syscalls | 5 +++++
>>   1 file changed, 5 insertions(+)
>> diff --git a/runtest/syscalls b/runtest/syscalls
>> index c41ba2a0d..1694ef147 100644
>> --- a/runtest/syscalls
>> +++ b/runtest/syscalls
>> @@ -1177,6 +1177,11 @@ setitimer01 setitimer01
>>   setitimer02 setitimer02
>>   setitimer03 setitimer03
>> +set_mempolicy01 set_mempolicy01
>> +set_mempolicy02 set_mempolicy02
>> +set_mempolicy03 set_mempolicy03
>> +set_mempolicy04 set_mempolicy04
>> +
>>   setns01 setns01
>>   setns02 setns02
> Wouldn't be better to move all NUMA tests out of syscalls?
> Syscalls are big already.
Hi Petr,

all NUMA tests actually verify the functionality of 
syscalls(move_pages(2), set_mempolicy(2), etc)
so I think that they can be added into syscalls group.

PS: If someone want to run syscalls from LTP as many as possible, they 
just need to run syscalls group directly.

Best Regards,
Xiao Yang
> BTW I'm looking forward to the new testrunner [1][2], which also solve problem
> of runtest files :)
>
> Kind regards,
> Petr
>
> [1] https://people.kernel.org/metan/towards-parallel-kernel-test-runs
> [2] https://github.com/metan-ucw/ltp/tree/master/docparse
>
>
> .
>



