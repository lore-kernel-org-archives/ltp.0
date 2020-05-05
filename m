From: Yang Xu <xuyang_jy_0410@163.com>
Date: Wed, 6 May 2020 00:23:34 +0800
Subject: [LTP] [PATCH] syscalls/ioctl_loop05: Do not fail on success
In-Reply-To: <20200505141341.GB27810@yuki.lan>
References: <20200429141411.9051-1-chrubis@suse.cz>
 <643ba523-3421-fa27-cdc9-9c64e60647c3@cn.fujitsu.com>
 <20200505141341.GB27810@yuki.lan>
Message-ID: <2b147323-9cc8-e2d9-5e3f-c95ed0b78e75@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril


> Hi!
>>> The code in __loop_update_dio() uses inode->i_sb->s_bdev to get the
>>> logical block size for the backing file for the loop device. If that
>>> pointer is NULL, which happens to be the case for Btrfs, the checks for
>>> alignment and block size are ignored and direct I/O can be turned on
>>> regardless of the offset and logical block size.Since kernel comment "the above condition may be loosed in the future,
>> and direct I/O may be switched runtime at that time because most
>> of requests in sane applications should be PAGE_SIZE aligned". I think
>> pass is ok, also print filesystem let user know this fs igores this
>> align is better.
> 
> I do not get what you mean here. Should we change the TPASS message to
> something "LOOP_SET_DIRECT_IO succeeded, offset is ignored" or something
> similar?
Yes. Add a comment here is better.
> 
>>     loopinfo.lo_offset = 0;
>>     TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo),
>> TST_RETVAL_EQ0);
>>
>> These should be moved to the beginning of test function.
> 
> I guess that we can do so, just to be extra sure, but we do zero the
> loopinfo structure in lib/tst_device.c so we start with zero offset,
> hence it does not matter if we reset it at the start or at the end of
> the test.
When I debug this case as below(early return, ext4 filesystem):
TEST(ioctl(dev_fd, LOOP_SET_DIRECT_IO, 1));
         if (TST_RET == 0) {
                 tst_res(TFAIL, "LOOP_SET_DIRECT_IO succeeded 
unexpectedly");
                 SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 0);
         }
	return;
this case will broke when using i parameter,
ioctl_loop05.c:50: BROK: ioctl(3,LOOP_SET_DIRECT_IO,...) failed: EINVAL (22)

It seems the last test affected the next test, so I think we should use 
goto instead of return. Also including two typo, updata->update, need->needs
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop05.c
@@ -5,8 +5,8 @@
   *
   * This is a basic ioctl test about loopdevice.
   *
- * It is designed to test LOOP_SET_DIRECT_IO can updata a live
- * loop device dio mode. It need the backing file also supports
+ * It is designed to test LOOP_SET_DIRECT_IO can update a live
+ * loop device dio mode. It needs the backing file also supports
71,15 +71,16 @@ static void verify_ioctl_loop(void)

         TEST(ioctl(dev_fd, LOOP_SET_DIRECT_IO, 1));
         if (TST_RET == 0) {
-               tst_res(TFAIL, "LOOP_SET_DIRECT_IO succeeded unexpectedly");
+               tst_res(TPASS, "Ignoring offset, LOOP_SET_DIRECT_IO 
succeeded");
                 SAFE_IOCTL(dev_fd, LOOP_SET_DIRECT_IO, 0);
-               return;
+               goto reset_offset;
         }
         if (TST_ERR == EINVAL)
                 tst_res(TPASS | TTERRNO, "LOOP_SET_DIRECT_IO failed as 
expected");
         else
                 tst_res(TFAIL | TTERRNO, "LOOP_SET_DIRECT_IO failed 
expected EINVAL got");

+reset_offset:
         loopinfo.lo_offset = 0;
         TST_RETRY_FUNC(ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo), 
TST_RETVAL_EQ0);


Best Regards
Yang Xu
> 

