From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 9 Jan 2020 15:04:56 +0530
Subject: [LTP] [PATCH v2] tst_dev_bytes_written: parsing /proc/diskstats
 instead of sys file
In-Reply-To: <bee8d39f-723f-491d-8676-a1c303f0a5bb@cn.fujitsu.com>
References: <1578299418-4961-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200108131231.GA23619@rei.lan>
 <bee8d39f-723f-491d-8676-a1c303f0a5bb@cn.fujitsu.com>
Message-ID: <CAFA6WYMk-bT7xKG7nov8mzd=b4T1gzghxrFz9x_OegU8mtSNVA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Yang,

On Thu, 9 Jan 2020 at 14:05, Yang Xu <xuyang2018.jy@cn.fujitsu.com> wrote:
>
> Hi
> > Hi!
> >> Now, tst_dev_bytes_written api can get the whole disk stat correctly(such as /dev/sda),
> >> but can not get partition stat correctly(such as /dev/sda5).
> >> fail as below:
> >> export LTP_DEV=/dev/sda5
> >> tst_device.c:388: CONF: Test device stat file: /sys/block/sda5/stat not found
> >
> > It seems that in case of partitions the stat file is available under
> > /sys/block/sda/sda5/stat.
> >
> > For NVME it's similar as:
> >
> > /sys/block/nvme0n1/nvme0n1p1/stat
> >
> > I do wonder if it wouldn't be easier to try to match the prefix of the
> > device name first, then try a directory with a full name after that.

I did checked earlier that we could use partition specific
sub-directory for "stat" file but I thought it would be complex in
comparison to referring a single file. But your implementation doesn't
look that complex.

> Maybe, I am fine with your way(I tested it). I only  refer to kernel
> documention [1] .sysfs and proc file  use the same source for the
> information and so should not differ. So I use fixed format as kernel
> function to exact.  Also, I want to listen advise from Sumit.
>

TBH, I think it's just a matter of taste. I am fine with either approach.

-Sumit

> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/iostats.rst
>
> Best Regards
> Yang Xu
> >
>
>
