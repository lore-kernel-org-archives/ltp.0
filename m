From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 22 Oct 2020 13:18:53 +0800
Subject: [LTP] Broken Fedora build
In-Reply-To: <5F90F214.20102@cn.fujitsu.com>
References: <20201021193547.GA49488@x230>
 <CAEemH2cAeMzbr6WWDOTTNYkU8b+1J+7WEHjGU283r3qWtXP8TA@mail.gmail.com>
 <5F90F214.20102@cn.fujitsu.com>
Message-ID: <5F91163D.9030307@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/10/22 10:44, Yang Xu wrote:
> Hi Li,Petr
>> Petr Vorel<pvorel@suse.cz>  wrote:
>>
>>> Fedora build is broken due missing<sys/timeb.h>  [1].
>>> Quick fix would probably be to use Fedora 33 instead of Rawhide. [2]
>>> But we should port hugetlb.c and trace_sched.c (if used) to 
>>> gettimeofday or
>>> clock_gettime. [3]
>>
>> +1
>> I prefer to go replace ftime() by gettimeofday() or clock_gettime()
>> way to solve this from root.
> +1
>
> I have seen the hugetlb.c and trace_sched.c code, they all use the 
> time to generate a random value for ftok or sched_priority. So using 
> gettimeofday() also looks ok.
Hi,

It is fine for me to replace ftime(), but I wonder if we can remove 
fime() and srand()/srandom() directly? :-)
It seems unnecessary to set the seed for random number.

Best Regards,
Xiao Yang
>
> I will send a patch to use gettimeofday.
>
> Best Regards
> Yang Xu
>>
>
>
>
>



