From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 May 2020 15:50:50 +0200
Subject: [LTP] [PATCH] syscalls/ioctl_loop05: Do not fail on success
In-Reply-To: <2b147323-9cc8-e2d9-5e3f-c95ed0b78e75@163.com>
References: <20200429141411.9051-1-chrubis@suse.cz>
 <643ba523-3421-fa27-cdc9-9c64e60647c3@cn.fujitsu.com>
 <20200505141341.GB27810@yuki.lan>
 <2b147323-9cc8-e2d9-5e3f-c95ed0b78e75@163.com>
Message-ID: <20200506135050.GB3198@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >>> The code in __loop_update_dio() uses inode->i_sb->s_bdev to get the
> >>> logical block size for the backing file for the loop device. If that
> >>> pointer is NULL, which happens to be the case for Btrfs, the checks for
> >>> alignment and block size are ignored and direct I/O can be turned on
> >>> regardless of the offset and logical block size.Since kernel comment "the above condition may be loosed in the future,
> >> and direct I/O may be switched runtime at that time because most
> >> of requests in sane applications should be PAGE_SIZE aligned". I think
> >> pass is ok, also print filesystem let user know this fs igores this
> >> align is better.
> > 
> > I do not get what you mean here. Should we change the TPASS message to
> > something "LOOP_SET_DIRECT_IO succeeded, offset is ignored" or something
> > similar?
> Yes. Add a comment here is better.

I've added a longer top level comment explaining why we pass the test
with both outcomes on non-zero offset and pushed the patch.

> > 
> >>     loopinfo.lo_offset = 0;
> >>     TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo),
> >> TST_RETVAL_EQ0);
> >>
> >> These should be moved to the beginning of test function.
> > 
> > I guess that we can do so, just to be extra sure, but we do zero the
> > loopinfo structure in lib/tst_device.c so we start with zero offset,
> > hence it does not matter if we reset it at the start or at the end of
> > the test.
> When I debug this case as below(early return, ext4 filesystem):
> TEST(ioctl(dev_fd, LOOP_SET_DIRECT_IO, 1));
>          if (TST_RET == 0) {
>                  tst_res(TFAIL, "LOOP_SET_DIRECT_IO succeeded 
> unexpectedly");
>                  SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 0);
>          }
> 	return;
> this case will broke when using i parameter,
> ioctl_loop05.c:50: BROK: ioctl(3,LOOP_SET_DIRECT_IO,...) failed: EINVAL (22)
> 
> It seems the last test affected the next test, so I think we should use 
> goto instead of return. Also including two typo, updata->update, need->needs

Let's keep the git history clean and fix that in a subsequent patch.

-- 
Cyril Hrubis
chrubis@suse.cz
