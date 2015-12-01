From: Lijin(Euler Dept 8) <lijin14@huawei.com>
Date: Tue, 1 Dec 2015 17:34:34 +0800
Subject: [LTP] [PATCH] Fix wrong pattern used by fnmatch in test case
 proc01.c
In-Reply-To: <619455416.21202777.1448958949649.JavaMail.zimbra@redhat.com>
References: <1448606649-141790-1-git-send-email-King.lijin@huawei.com>
 <1448606649-141790-2-git-send-email-King.lijin@huawei.com>
 <733187539.20734579.1448887572067.JavaMail.zimbra@redhat.com>
 <565CF833.4070101@huawei.com>
 <619455416.21202777.1448958949649.JavaMail.zimbra@redhat.com>
Message-ID: <565D69AA.1030604@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2015/12/1 16:35, Jan Stancek wrote:
> 
> 
> 
> 
> ----- Original Message -----
>> From: "Lijin(Euler Dept 8)" <lijin14@huawei.com>
>> To: "Jan Stancek" <jstancek@redhat.com>
>> Cc: "Li Jin" <King.lijin@huawei.com>, ltp@lists.linux.it
>> Sent: Tuesday, 1 December, 2015 2:30:27 AM
>> Subject: Re: [LTP] [PATCH] Fix wrong pattern used by fnmatch in test case proc01.c
>>
>> On 2015/11/30 20:46, Jan Stancek wrote:
>>>
>>>
>>>
>>>
>>> ----- Original Message -----
>>>> From: "Li Jin" <King.lijin@huawei.com>
>>>> To: "king lijin" <king.lijin@huawei.com>, ltp@lists.linux.it
>>>> Cc: "Li Jin" <King.lijin@huawei.com>
>>>> Sent: Friday, 27 November, 2015 7:44:09 AM
>>>> Subject: [LTP] [PATCH] Fix wrong pattern used by fnmatch in test case
>>>> 	proc01.c
>>>>
>>>> fnmatch() in proc01.c should use pattern ipv6/conf/[a-z]*/stable_secret
>>>> to replace /ipv6/conf/*/stable_secret to check the known issue string such
>>>> as
>>>> /proc/sys/net/ipv6/conf/all/stable_secret
>>>
>>> Hi,
>>>
>>> An explanation _why_ it is wrong would be helpful too.
>>
>> Got it. The reason is that a single "*" can not be used to match the any
>> string in fnmatch.
> 
> Why not? According to [1] referenced by [2]:
>   The <asterisk> ( '*' ) is a pattern that shall match any string, including the null string
> and it looks like valid 'shell wildcard pattern' (fnmatch(3)).
> 
> [1] http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_13_02
> [2] http://pubs.opengroup.org/onlinepubs/9699919799/functions/fnmatch.html
> 

agreed.

>>>
>>>>
>>>> Signed-off-by: Li Jin <King.lijin@huawei.com>
>>>> ---
>>>>  testcases/kernel/fs/proc/proc01.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/testcases/kernel/fs/proc/proc01.c
>>>> b/testcases/kernel/fs/proc/proc01.c
>>>> index 2825b51..197eb55 100644
>>>> --- a/testcases/kernel/fs/proc/proc01.c
>>>> +++ b/testcases/kernel/fs/proc/proc01.c
>>>> @@ -107,7 +107,7 @@ static const struct mapping known_issues[] = {
>>>>  	{"read", "/proc/fs/nfsd/.getfs", EINVAL},
>>>>  	{"read", "/proc/fs/nfsd/.getfd", EINVAL},
>>>>  	{"read", "/proc/self/net/rpc/use-gss-proxy", EAGAIN},
>>>> -	{"read", "/proc/sys/net/ipv6/conf/*/stable_secret", EIO},
>>>> +	{"read", "/proc/sys/net/ipv6/conf/[a-z]*/stable_secret", EIO},
>>>
>>> This has problems as well:
>>
>> Just ignore it. It's the problem of my linux system
>>
>>>
>>> # ip tuntap add 1tap mode tap
>>> # ./proc01 -m 128
>>> proc01      0  TINFO  :  /proc/sys/fs/binfmt_misc/register: is write-only.
>>> proc01      1  TFAIL  :  proc01.c:393: read failed:
>>> /proc/sys/net/ipv6/conf/1tap/stable_secret: errno=EIO(5): Input/output
>>> error
>>> ...
>>>
>>> How about:
>>> +       {"read", "/proc/sys/net/ipv6/conf/?*/stable_secret", EIO},
>>
>> Good idea. It works and I will send V2 patch.
> 
> I'm curious on what distro and glibc version original code is failing for you.

redhat RHEL 6 and /lib64/libc.so.6 - GNU C Library (GNU libc) stable release version 2.17, by Roland McGrath et al.

Regards,

Jin

> 
> Regards,
> Jan
> 
>>
>> Regards,
>>
>> Jin
>>
>>>
>>> Regards,
>>> Jan
>>>
>>>>  	{"", "", 0}
>>>>  };
>>>>  
>>>> --
>>>> 1.8.3.1
>>>>
>>>>
>>>> --
>>>> Mailing list info: http://lists.linux.it/listinfo/ltp
>>>>
>>>
>>> .
>>>
>>
>>
>>
> 
> .
> 


