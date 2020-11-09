From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 9 Nov 2020 11:56:55 +0800
Subject: [LTP] [PATCH 1/4] syscalls/sync01: Remove it
In-Reply-To: <20201107165518.GB10159@pevik>
References: <1603691317-22811-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <5FA21AA9.9020208@cn.fujitsu.com> <20201106123604.GA30097@yuki.lan>
 <0bc685ce-1983-b900-787f-3d89e75ca48d@163.com>
 <20201106164742.GA6449@rei.lan>
 <f99d3484-f86d-dd8a-e64e-7d9d94533de4@163.com> <20201107165518.GB10159@pevik>
Message-ID: <5FA8BE07.4040201@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On  020/11/8 0:55, Petr Vorel wrote:
> Hi,
>
>> On 11/7/20 12:47 AM, Cyril Hrubis wrote:
>>> Hi!
>>>> I have a doubt after reading Xu's patch[1] and Martin's patch[2]:
>>>> 1) Xu removed sync01 because sync() always return 0.
>>> Actually sync() is defined as void function, so the tests were bogusly
>>> checking the TST_RET value which haven't been set at all.
>> Hi Cyril,
>> Oops, I gave a wrong example. :-(
>> On error, I just wonder if we need to check all return value(i.e. negative
>> value except -1).
>> IOW, Is it possible for syscall to get a error value which is not -1?
> There are probably other examples, but I've found only these:
>
> man malloc_get_state(3)
>
> 	If the implementation detects that state does not point to a correctly
> 	formed data structure, malloc_set_state() returns -1.
> 	If the implementation detects that the version of the data structure
> 	referred to by state is a more recent version than this implementation knows
> 	about, malloc_set_state() returns -2.
>
> man mmap(2)
> 	On error, the value MAP_FAILED (that is, (void *) -1) is returned.
Hi,

Sorry, I didn't describe the doubt clearly.
For example:
1) open(2) will return -1 if an error occur.
     Is it necessary to check invalid return value(except -1) if an 
error occur?
2) mmap(2) will return MAP_FAILED if an error occurs.
     Is it necessary to check invalid value(except MAP_FAILED) if an 
error occur?
Martin's patches have added a check for invalid return value in many 
safe macros but a lot of syscall tests(e.g. after doingTEST()) don't add 
the check for now.
I am not sure if we need to add the check for all syscall tests. :-)
BTW: In my opinion, it is hardly to get invalid return value so the 
check seems unnecessary and redundance.

Best Regards,
Xiao Yang
>> Best Regards,
>> Xiao Yang
>
> Kind regards,
> Petr
>



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201109/f564f88c/attachment-0001.htm>
