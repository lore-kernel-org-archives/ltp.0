From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 Jan 2016 15:35:05 +0100
Subject: [LTP] mkfs01 testcases issue
In-Reply-To: <20160105134815.GB32659@rei.lan>
References: <567D7ED0.2060706@oracle.com>
 <20160105134815.GB32659@rei.lan>
Message-ID: <20160105143504.GB8939@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > While running LTP commands testcases,these three 
> > tests(mkfs01_msdos,mkfs01_vfat,mkswap01) sometimes failed.
> > It is because that mkfs.vfat/mkswap on the test block device which is 
> > made as btrfs( in previous mkfs01_btrfs test) does not work.
> > blkid still show "TYPE="btrfs" after mkfs.vfat/mkswap.
> > Seems the issue is only reproduced with a very small size of block 
> > device(less than 20M).
> > Does anyone hit similar issue,is it a kernel or btrfs bug?

And I've reported the problem with mkfs.vfat here:

https://github.com/dosfstools/dosfstools/issues/19

Let's see if it gets fixed.

-- 
Cyril Hrubis
chrubis@suse.cz
