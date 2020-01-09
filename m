From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 9 Jan 2020 16:35:34 +0800
Subject: [LTP] [PATCH v2] tst_dev_bytes_written: parsing /proc/diskstats
 instead of sys file
In-Reply-To: <20200108131231.GA23619@rei.lan>
References: <1578299418-4961-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200108131231.GA23619@rei.lan>
Message-ID: <bee8d39f-723f-491d-8676-a1c303f0a5bb@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi
> Hi!
>> Now, tst_dev_bytes_written api can get the whole disk stat correctly(such as /dev/sda),
>> but can not get partition stat correctly(such as /dev/sda5).
>> fail as below:
>> export LTP_DEV=/dev/sda5
>> tst_device.c:388: CONF: Test device stat file: /sys/block/sda5/stat not found
> 
> It seems that in case of partitions the stat file is available under
> /sys/block/sda/sda5/stat.
> 
> For NVME it's similar as:
> 
> /sys/block/nvme0n1/nvme0n1p1/stat
> 
> I do wonder if it wouldn't be easier to try to match the prefix of the
> device name first, then try a directory with a full name after that.
Maybe, I am fine with your way(I tested it). I only  refer to kernel 
documention [1] .sysfs and proc file  use the same source for the 
information and so should not differ. So I use fixed format as kernel 
function to exact.  Also, I want to listen advise from Sumit.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/iostats.rst

Best Regards
Yang Xu
> 


