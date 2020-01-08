From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Jan 2020 14:12:31 +0100
Subject: [LTP] [PATCH v2] tst_dev_bytes_written: parsing /proc/diskstats
 instead of sys file
In-Reply-To: <1578299418-4961-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1578299418-4961-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <20200108131231.GA23619@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Now, tst_dev_bytes_written api can get the whole disk stat correctly(such as /dev/sda),
> but can not get partition stat correctly(such as /dev/sda5).
> fail as below:
> export LTP_DEV=/dev/sda5
> tst_device.c:388: CONF: Test device stat file: /sys/block/sda5/stat not found

It seems that in case of partitions the stat file is available under
/sys/block/sda/sda5/stat.

For NVME it's similar as:

/sys/block/nvme0n1/nvme0n1p1/stat

I do wonder if it wouldn't be easier to try to match the prefix of the
device name first, then try a directory with a full name after that.

-- 
Cyril Hrubis
chrubis@suse.cz
