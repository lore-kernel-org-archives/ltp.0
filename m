From: zhaogongyi <zhaogongyi@huawei.com>
Date: Fri, 12 Mar 2021 07:18:51 +0000
Subject: [LTP] [PATCH] lib/tst_device.c: Add exception handling of
 function tst_find_free_loopdev
Message-ID: <F3D3F6AC3820BB4C9FCA340DB5C32CB4038910A5@dggeml511-mbs.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr, Li,

At first, it seems ok that using ST_RETRY_FUNC macro to try more times for race condition.

In addition, when "loopdevno = ioctl(fd, LOOP_CTL_GET_FREE)" get free loop device i, and 
the loop device file /dev/loop%i has been removed?set_dev_path will return 1 and set " /dev/block/loop%i " 
in path. It might happened in many Embedded Systems because the test process's id is root always. So we could 
also Add exception handling?

Thanks!

Best Regards,
Gongyi

> 
> Hi,
> 
> > > Because of race condition or abnormal env, set_dev_path may be
> > > return 1. And when set_dev_path return 1 in tst_find_free_loopdev,
> > > we should return Immediately.
> 
> 
> > If there exists a race condition, I firstly think of the
> > TST_RETRY_FUNC macro to try more times for the set_dev_path. That
> > might help to get the function success in the follow-up tries.
> 
> +1
> 
> Kind regards,
> Petr
