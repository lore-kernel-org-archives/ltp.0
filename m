From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 22 Jan 2020 12:01:06 +0800
Subject: [LTP] [PATCH] syscalls/userfaultfd01: Always require
 CAP_SYS_PTRACE
In-Reply-To: <5E279FB9.6010108@cn.fujitsu.com>
References: <1575532537-27105-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200121052447.GA6657@dell5510>
 <5707ecce-aec4-a80d-5ec6-f9c728625634@cn.fujitsu.com>
 <20200121101513.GA9254@gacrux.arch.suse.de> <5E279FB9.6010108@cn.fujitsu.com>
Message-ID: <2b16f627-1299-9f35-889c-0044139a99b3@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


> On 2020/1/21 18:17, Petr Vorel wrote:
>> Hi Xu,
>>
>>> We have pushed "syscalls/userfaultfd01: add hint about 
>>> unprivileged_userfaultfd" patch(v2)[1].
>>> This is v1.? li Wang and me both think adding hint is more wise, more 
>>> info see[2].
>>> [1] 
>>> https://github.com/linux-test-project/ltp/commit/7dc571d3ad1908d6e50163a06ef848f096fe880a 
>>>
>>> [2] http://lists.linux.it/pipermail/ltp/2020-January/014921.html
>> Thanks for notification, I'll check previous commits next time!
>>
>> BTW this was caused by maintainers not updating patchwork :(.
>> Would you mind to register to patchwork and check state of your 
>> tickets time to
>> time [1]. You'd be able to change state of your own patches.
Hi Petr
  I have registered to patchwork and I will change the state of my other 
patches later. Thanks for your kind advice.

also thanks for xiao that changed the state of this patch.

Best Regards
Yang Xu
> Hi Petr,
> 
> Thanks for your effort.
> Xu is my colleague and I helped him change the state to superseded. :-)
> 
> Best Regards,
> Xiao Yang
>> Kind regards,
>> Petr
>>
>> [1] https://patchwork.ozlabs.org/project/ltp/list/?submitter=76329
>>
> 


