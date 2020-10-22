From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 22 Oct 2020 14:27:13 +0800
Subject: [LTP] Broken Fedora build
In-Reply-To: <5F91252F.3040504@cn.fujitsu.com>
References: <20201021193547.GA49488@x230>
 <CAEemH2cAeMzbr6WWDOTTNYkU8b+1J+7WEHjGU283r3qWtXP8TA@mail.gmail.com>
 <5F90F214.20102@cn.fujitsu.com> <5F91163D.9030307@cn.fujitsu.com>
 <CAEemH2eUfSgvmDB4EA6i3K6O9CCgiSa8CA5sKLQS2a_wOhDtXw@mail.gmail.com>
 <5F91252F.3040504@cn.fujitsu.com>
Message-ID: <5F912641.9090004@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/10/22 14:22, Yang Xu wrote:
> Hi Li
>> Xiao Yang<yangx.jy@cn.fujitsu.com>  wrote:
>>
>>>>> I prefer to go replace ftime() by gettimeofday() or clock_gettime()
>>>>> way to solve this from root.
>>>> +1
>>>>
>>>> I have seen the hugetlb.c and trace_sched.c code, they all use the
>>>> time to generate a random value for ftok or sched_priority. So using
>>>> gettimeofday() also looks ok.
>>> Hi,
>>>
>>> It is fine for me to replace ftime(), but I wonder if we can remove
>>> fime() and srand()/srandom() directly? :-)
>>> It seems unnecessary to set the seed for random number.
>>
>> That's true, but random() will generate the same number each time.
> Agree. If we don't call srandom, repeatly call random binary will give 
> same  random num. ie
> root@localhost ~]# ./random
> random num 1804289383
> random num 846930886
> random num 1681692777
> random num 1714636915
> random num 1957747793
> random num 424238335
> random num 719885386
> random num 1649760492
> random num 596516649
> random num 1189641421
> [root@localhost ~]# ./random
> random num 1804289383
> random num 846930886
> random num 1681692777
> random num 1714636915
> random num 1957747793
> random num 424238335
> random num 719885386
> random num 1649760492
> random num 596516649
> random num 1189641421
> [root@localhost ~]# cat random.c
> #include <stdlib.h>
> #include <stdio.h>
>
> void main(void)
> {
>         int num,i;
>         for (i=0;i<10;i++) {
>                 num =random();
>                 printf("random num %d\n", num);
>         }
> }
> [root@localhost ~]#
>
> So keep this maybe better.
Hi Li, Yang

Thanks for your replies. It's reasonable for me to keep it. :-)

Best Regards,
Xiao Yang
>
> Best Regards
> Yang Xu
>> I slightly tend to keep setting the seed by srandom() to get a different
>> randomized number for test variety.
>>
>
> .
>



