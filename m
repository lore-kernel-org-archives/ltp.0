From: zhaogongyi <zhaogongyi@huawei.com>
Date: Fri, 26 Feb 2021 06:37:42 +0000
Subject: [LTP] [PATCH] syscalls/ioctl: Remove requirement of loop driver
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB40387A866@dggeml511-mbs.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> 1) I think .needs_driver can parse either CONFIG_BLK_DEV_LOOP=y or
> CONFIG_BLK_DEV_LOOP=m correctly.
>      Do you have any issue that .needs_driver cannot parse

I known the reason why test fail and report TCONF, there is no file modules.builtin on my system.

> CONFIG_BLK_DEV_LOOP=y correctly?
> 2) If CONFIG_BLK_DEV_LOOP is not set, we would like to report TCONF
> by .needs_driver rather than TBROK by tst_find_free_loopdev().
>

It looks like good.


Thanks!

----------------------------------------------------------------------------------------------------

> 
> On 2021/2/26 12:00, Zhao Gongyi wrote:
> > There is no loop driver when config CONFIG_BLK_DEV_LOOP is set to y,
> > and we have check the loop device in tst_find_free_loopdev. So we can
> > remove the requirement of loop driver.
> Hi Zhongyi,
> 
> 1) I think .needs_driver can parse either CONFIG_BLK_DEV_LOOP=y or
> CONFIG_BLK_DEV_LOOP=m correctly.
>      Do you have any issue that .needs_driver cannot parse
> CONFIG_BLK_DEV_LOOP=y correctly?
> 2) If CONFIG_BLK_DEV_LOOP is not set, we would like to report TCONF
> by .needs_driver rather than TBROK by tst_find_free_loopdev().
> 
> Best Regards,
> Xiao Yang
