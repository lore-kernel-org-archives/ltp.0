From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 31 Aug 2018 16:48:45 +0800
Subject: [LTP] [PATCH ltp] syscalls/bind03: Add version compare
 according to behaviour difference.
In-Reply-To: <20180831083713.GA11320@dell5510>
References: <20180831132453.6461-1-junchi.chen@intel.com>
 <20180831083713.GA11320@dell5510>
Message-ID: <5B8900ED.6050003@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/08/31 16:37, Petr Vorel wrote:
> Hi Junchi,
>
>> ISSUE:
>>    The case is designed to test the behaviour diverse caused by kernel
>>    commit 0fb44559ffd6. And it failed for the new behaviour.
>> ACTION:
>>    Add a version compare to split part of the test.
>> Signed-off-by: Junchi Chen<junchi.chen@intel.com>
> Merged, thanks!
Hi Petr,

According to bind(2) manpge, bind() should return EINVAL when the socket 
is already
bound to an address.  Commit 0fb4455 actually change the errno to 
EADDRINUSE, but
i am not sure if this change is a expeceted behavior.

Thanks,
Xiao Yang
>
> Kind regards,
> Petr
>



