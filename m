From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 25 Aug 2020 09:30:55 +0800
Subject: [LTP] [PATCH] travis: Add centos7 build
In-Reply-To: <20200824151210.GA30969@dell5510>
References: <1598250984-5141-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200824151210.GA30969@dell5510>
Message-ID: <4b7cb95c-fb39-6826-b229-723a1e8bb128@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr


> Hi Xu,
> 
>> I have this idea when I meet ALG_SET_AEAD_ASSOCLEN undefined error on centos7.
>> Add centos7 travis target, it is more friendly for centos7 user and it is more
>> meaningful than centos6.
> 
> OK, how about replacing CentOS 6 with CentOS 7?
I have no objection about this because my kernel test team only uses 
centos7/8 to test and doesn't use centos6 for a long time.

But I think ltp community should reach a consensus that minimal 
glibc/kernel/gcc(clang) version , so we can drop the corresponding code 
in travis or m4.

Also, we can raise "Define minimal supported kernel and (g)libc version" 
topic again.

Best Regards
Yang Xu
> 
> Kind regards,
> Petr
> 
>> I have tested this patch on my ltp fork:
>> https://travis-ci.org/github/xuyang0410/ltp/jobs/720541105
> 
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>> ---
>>   .travis.yml | 4 ++++
>>   1 file changed, 4 insertions(+)
> 
>> diff --git a/.travis.yml b/.travis.yml
>> index e8e3189af..281ec9e96 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -47,6 +47,10 @@ matrix:
>>             env: DISTRO=centos:6 TREE=out
>>             compiler: gcc
> 
>> +        - os: linux
>> +          env: DISTRO=centos:7 TREE=out
>> +          compiler: gcc
>> +
>>           - os: linux
>>             env: DISTRO=debian:testing
>>             compiler: gcc
> 
> 


