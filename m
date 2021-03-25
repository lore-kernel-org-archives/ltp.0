From: zhaogongyi <zhaogongyi@huawei.com>
Date: Thu, 25 Mar 2021 02:41:32 +0000
Subject: [LTP] [PATCH] syscalls/setns: Replace libc function with
 safe_macros
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB40389C8AA@dggeml531-mbx.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

I'm sorry! Its my fault, thanks for your review!

I have resubmit the patch.

Best Regards,
Gongyi

> 
> Hi Gongyi,
> 
> thanks for your patchset. While it looks correct, some of changes break
> both tests:
> 
> ./setns01 -i 5
> tst_test.c:1289: TINFO: Timeout per run is 0h 05m 00s
> setns01.c:153: TCONF: no ns types/proc entries
> 
> ./setns02 -i 5
> tst_test.c:1289: TINFO: Timeout per run is 0h 05m 00s
> setns02.c:160: TCONF: your kernel has CONFIG_IPC_NS, CONFIG_UTS_NS
> or CONFIG_PROC disabled
> setns02.c:175: TWARN: shmctl(0, 0, (nil)) failed: EINVAL (22)
> 
> Kind regards,
> Petr
