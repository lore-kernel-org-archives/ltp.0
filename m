From: Zouwei (Samuel) <zou_wei@huawei.com>
Date: Tue, 31 Mar 2020 02:30:48 +0000
Subject: [LTP] =?utf-8?b?562U5aSNOiAgW1BBVENIIHYzIDEvM10gc2VjdXJpdHkvZGly?=
 =?utf-8?q?tyc0w=3A_Fix_bug_caused_by_default_umask?=
In-Reply-To: <e08ee1c3-c537-a1ca-01b1-cf7d25d77117@163.com>
References: <1585553269-119544-1-git-send-email-zou_wei@huawei.com>
 <1585553269-119544-2-git-send-email-zou_wei@huawei.com>
 <20200330091835.GA9845@yuki.lan> <20200330092046.GB9845@yuki.lan>
 <e08ee1c3-c537-a1ca-01b1-cf7d25d77117@163.com>
Message-ID: <C3CD0DF8AD11A84CB25A1426DE537C61E59292BD@dggeml524-mbx.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang and Cyril,

Thank you so much for all your suggestions.

Best Regards
Zou Wei

-----????-----
???: Xiao Yang [mailto:ice_yangxiao@163.com] 
????: 2020?3?30? 20:34
???: Cyril Hrubis <chrubis@suse.cz>; Zouwei (Samuel) <zou_wei@huawei.com>
??: ltp@lists.linux.it
??: Re: [LTP] [PATCH v3 1/3] security/dirtyc0w: Fix bug caused by default umask

On 3/30/20 5:20 PM, Cyril Hrubis wrote:
> Hi!
>>> The case is only successful when system default umask is 0022.
>>> When default umask is 0077 or other values, should clear current umask by umask(0) in setup().
>> What exactly fails in the dirtyc0w because of non-standard umask?
>>
>> I can easily understand why fstat and statx fail, since we check the 
>> file permissions there. Ideally the failure should have been part of 
>> the patch description.
> Looking at the code I guess that the child fails to open the file 
> created in parent before the setgid/setuid, something like this should 
> really have been part of the patch description.
>
Hi Cyril,

Right, some default mask drop the read permission of g/o and

nobody user cannot do read. :-)

Thanks,

Xiao Yang

