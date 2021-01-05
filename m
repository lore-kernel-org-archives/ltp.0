From: yangx.jy <yangx.jy@cn.fujitsu.com>
Date: Tue, 5 Jan 2021 22:20:18 +0800
Subject: [LTP] [PATCH 1/2] syscalls/open01.c: Don't continue when open()
 failed
In-Reply-To: <X/RmeykJSClh7a5/@yuki.lan>
References: <20210104125423.19183-1-yangx.jy@cn.fujitsu.com>
 <X/RmeykJSClh7a5/@yuki.lan>
Message-ID: <5FF475A2.3060209@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2021/1/5 21:15, Cyril Hrubis wrote:
> Hi!
>> Avoid calling fstat() with invalid fd:
>> -------------------------------------------
>> ./open01
>> ...
>> open01.c:53: TBROK: fstat(-1,0x7fff731410a0) failed: EBADF (9)
>> -------------------------------------------
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   testcases/kernel/syscalls/open/open01.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/testcases/kernel/syscalls/open/open01.c b/testcases/kernel/syscalls/open/open01.c
>> index 1172f832b..2f0ad550a 100644
>> --- a/testcases/kernel/syscalls/open/open01.c
>> +++ b/testcases/kernel/syscalls/open/open01.c
>> @@ -47,6 +47,9 @@ static void verify_open(unsigned int n)
>>
>>   	TST_EXP_FD(open(tc->filename, tc->flag, tc->mode),
>>   	           "open() with %s", tc->desc);
>> +	if (!TST_PASS)
>> +		return;
>> +
> Doesn't this only happen if the open() that is supposed to return a
> valid file descriptor fails unexpectedly? In that the test fails, right?
Hi Cyril,

Right.
> But I guess that it does not harm, so:
>
> Acked-by: Cyril Hrubis<chrubis@suse.cz>
I will push it soon.

Best Regards,
Xiao Yang



