From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 15 Mar 2018 16:27:01 +0800
Subject: [LTP] [PATCH] commands/sysctl: Add new regression test for
 invalid sched_time_avg
In-Reply-To: <20180314170148.GC27794@rei>
References: <1516695452-23224-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20180306124242.GC16934@rei.lan> <5A9F61AF.6070008@cn.fujitsu.com>
 <20180314170148.GC27794@rei>
Message-ID: <5AAA2E55.1070006@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/03/15 1:01, Cyril Hrubis wrote:
> Hi!
>>> What is this sleep good for? Do we wait here for the kernel to crash?
>> On my RHEL6, restoring the original value immediately after setting an
>> invalid value always didn't
>> trigger a hang in time, so we just wait a moment for kernel to hang.
Hi,
> Shouldn't the kernel crash just by setting the avg_ms to 0 or do I
> misunderstand the kernel commit changelog?
Yes,  if the value which is set to 0 is picked up  by the scheduller, 
the kernel shouldn't crash.
> Or is the offending code that crashes the kernel invoked asynchronously
> so that the value is picked up later by the scheduller? If so I would
> prefer removing the sleep anyways since the test will fail if we happen
> to be able to write 0 to the file anyways which is IMHO enough to inform
> the user about the present bug.
It seems reasonable, and i will remove the sleep.

Thanks,
Xiao Yang
> Other than that the test looks fine.
>



