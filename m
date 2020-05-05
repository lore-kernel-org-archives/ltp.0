From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 5 May 2020 16:13:41 +0200
Subject: [LTP] [PATCH] syscalls/ioctl_loop05: Do not fail on success
In-Reply-To: <643ba523-3421-fa27-cdc9-9c64e60647c3@cn.fujitsu.com>
References: <20200429141411.9051-1-chrubis@suse.cz>
 <643ba523-3421-fa27-cdc9-9c64e60647c3@cn.fujitsu.com>
Message-ID: <20200505141341.GB27810@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > The code in __loop_update_dio() uses inode->i_sb->s_bdev to get the
> > logical block size for the backing file for the loop device. If that
> > pointer is NULL, which happens to be the case for Btrfs, the checks for
> > alignment and block size are ignored and direct I/O can be turned on
> > regardless of the offset and logical block size.Since kernel comment "the above condition may be loosed in the future, 
> and direct I/O may be switched runtime at that time because most
> of requests in sane applications should be PAGE_SIZE aligned". I think 
> pass is ok, also print filesystem let user know this fs igores this 
> align is better.

I do not get what you mean here. Should we change the TPASS message to
something "LOOP_SET_DIRECT_IO succeeded, offset is ignored" or something
similar?

>    loopinfo.lo_offset = 0;
>    TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), 
> TST_RETVAL_EQ0);
> 
> These should be moved to the beginning of test function.

I guess that we can do so, just to be extra sure, but we do zero the
loopinfo structure in lib/tst_device.c so we start with zero offset,
hence it does not matter if we reset it at the start or at the end of
the test.

-- 
Cyril Hrubis
chrubis@suse.cz
