From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Thu, 15 Apr 2021 15:11:54 +0800
Subject: [LTP] [PATCH] Modify the test logic of mincore.
In-Reply-To: <YHRcJOUer87SUn6v@yuki>
References: <20210330104613.1059-1-zhanglianjie@uniontech.com>
 <YHRcJOUer87SUn6v@yuki>
Message-ID: <cded02a5-6668-8524-d588-b965ed1a7086@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
>> Currently mincore has a vulnerability and is easy to be attacked.
>> CVE has fixed the vulnerability.
>> Please see https://www.linuxkernelcves.com/cves/CVE-2019-5489
>>
>> Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
>> ---
>>   testcases/kernel/syscalls/mincore/mincore04.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/mincore/mincore04.c b/testcases/kernel/syscalls/mincore/mincore04.c
>> index ed0ab7dfa..345dedd9a 100644
>> --- a/testcases/kernel/syscalls/mincore/mincore04.c
>> +++ b/testcases/kernel/syscalls/mincore/mincore04.c
>> @@ -95,12 +95,12 @@ static void test_mincore(void)
>>   	locked_pages = count_pages_in_cache();
>>   	tst_reap_children();
>>
>> -	if (locked_pages == NUM_PAGES)
>> -		tst_res(TPASS, "mincore reports all %d pages locked by child process "
>> -			"are resident", locked_pages);
>> -	else
>> -		tst_res(TFAIL, "mincore reports %d pages resident but %d pages "
>> +	if (locked_pages == 0)
>> +		tst_res(TPASS, "mincore reports %d pages resident but %d pages "
>>   			"locked by child process", locked_pages, NUM_PAGES);
>> +	else
>> +		tst_res(TFAIL, "mincore reports all %d pages locked by child process "
>> +			"are resident", locked_pages);
>>   }
> 
> This does not make any sense, the kernel commit explicitly states that
> all mapped pages are reported as in core. We do call mlock() in the
> child, which will fault all the pages and lock them in memory. So the
> test should work both before and after the fix as well.
> 
> The kernel commit in question weakened mincore() in a sense that it's
> more likely to report pages in core than it previously was. Now all that
> is needed is to fault the pages by reading some bytes from them to make
> sure they are reported as in core.
> 
> If the test fails for you, something is probably broken at your end.
> 

Using the CVE patch on mips, the test will fail because the child 
process mlocks all pages, but the parent process cannot obtain these 
pages through mincore and is locked.


