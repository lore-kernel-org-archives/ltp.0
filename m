From: Xu, Pengfei <pengfei.xu@intel.com>
Date: Sat, 21 Dec 2019 02:14:33 +0000
Subject: [LTP] [PATCH v4 4/4] lib: add any kconfig to match the expected
 value function document
In-Reply-To: <257bd5cb-1277-def3-f4ac-e20b15e4273d@cn.fujitsu.com>
References: <20191219131855.28799-1-pengfei.xu@intel.com>
 <20191219131855.28799-4-pengfei.xu@intel.com>
 <9ac02979-d8ec-4a11-7705-bb484dd79a20@cn.fujitsu.com>
 <20191220060151.nqvekuzs24yipia7@xpf-desktop>
 <5e859ac0-d009-3281-e712-fc86f7c72986@cn.fujitsu.com>
 <20191220070926.i4jknfoo6pdhersl@xpf-desktop>,
 <257bd5cb-1277-def3-f4ac-e20b15e4273d@cn.fujitsu.com>
Message-ID: <CD7C6F33-6957-4B71-8032-ACE82C4866B5@intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



Thanks Xu! :)

BR.
> ? 2019?12?20??15:20?Yang Xu <xuyang2018.jy@cn.fujitsu.com> ???
> 
> ?Hi Pengfei
>> Hi Xu,
>>   Due to memory copy, there is some bit and display issue in last string.
>>   So for your question, for CONFIG_A|CONFIG_B without expect value, maybe y
>>   or m.
>>   We could add it with below style:
>>   "CONFIG_A|CONFIG_B|NA", and add it into guidelines, NA will not be solved,
>>   actually you could fill with any string after last '|'.
>>   Is it ok?
> It sounds reasonable. I think it is ok.
> 
> Kind Regards
> Yang Xu
>>   Thanks!
>>> On 2019-12-20 at 14:00:00 +0800, Yang Xu wrote:
>>> Hi Pengfei
>>>> Hi Xu,
>>>> 
>>>> 
>>>>> Before your patch, I know we can use the following two formats kconfigs
>>>>> CONFIG_A
>>>>> CONFIG_A=y/m/v
>>>>> after your patch set, we can use the following three formats kconfigs
>>>>> CONFIG_A
>>>>> CONFIG_A=y/m/v
>>>>> CONFIG_A|CONFIGB=y/m/v
>>>>> As the usual extend logic,  we think  CONFIGA|CONFIGB is also ok. But in
>>>>> fact, we use "|" or "=" to delim string. So  we can't parse CONFIGA|CONFIGB
>>>>> correctly. So, if we can tell user or developer about this in here, it will
>>>>> be better.
>>>>> 
>>>>> ps: we can add configA| config B test in your third patch.
>>>>> 
>>>>    Actually present patch could support CONFIG_A|CONFIG_B style, and it works
>>>> well, you could change "CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP=y" to
>>>> "CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP" in test_kconfig.c and have a try. : )
>>> "CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP" is useful because
>>> CONFIG_X86_INTEL_UMIP is in our kernel configs . If you use
>>> "CONFIG_X86_UMIP|CONFIG_X86_INTEL_UMIP", it will report error.
>>> 
>>> Kind Regards
>>> Yang Xu
>>>> 
>>>> Thanks!
>>>>> Kind Regards
>>>>> Yang Xu
>>>>>>    #include "tst_test.h"
>>>>>>    static const char *kconfigs[] = {
>>>>>> -    "CONFIG_X86_INTEL_UMIP",
>>>>>> +    "CONFIG_EXT4_FS=y",
>>>>>> +    "CONFIG_MMU",
>>>>>> +    "CONFIG_X86_INTEL_UMIP|CONFIG_X86_UMIP=y",
>>>>>>        NULL
>>>>>>    };
>>>>>> 
>>>>> 
>>>>> 
>>>> 
>>>> 
>>> 
>>> 
> 
> 
