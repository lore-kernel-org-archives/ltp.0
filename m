From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 20 Aug 2019 17:09:48 +0800
Subject: [LTP] [PATCH] lapi/fs.h: Replace MAX_LFS_FILESIZE constant with
 own implementation
In-Reply-To: <CAEemH2d7TYn4sZ7kkjRsPc-yBnTrN9LC+w84MAO6pDxYpfiFcw@mail.gmail.com>
References: <20190815083630.26975-1-pvorel@suse.cz>
 <20190816085309.fqvip4exe4mvtv2o@XZHOUW.usersys.redhat.com>
 <CAEemH2d7TYn4sZ7kkjRsPc-yBnTrN9LC+w84MAO6pDxYpfiFcw@mail.gmail.com>
Message-ID: <5D5BB8DC.6070900@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

on 2019/08/19 16:16, Li Wang wrote:

> On Fri, Aug 16, 2019 at 4:53 PM Murphy Zhou<jencce.kernel@gmail.com>  wrote:
>> On Thu, Aug 15, 2019 at 10:36:30AM +0200, Petr Vorel wrote:
>>> Some libc implementations on arm (at least AArch32 target with hard
>>> float (arm-linux-gnueabihf)) or some libc (musl, bionic) does not
>>> export PAGE_SHIFT. Replace it with own inline function.
>>>
>>> This required to replace MAX_LFS_FILESIZE constant with function
>>> tst_max_lfs_filesize(). Given that we must use MAX_OFF in a function,
>>> move dst from tcase struct to verify_copy_file_range().
>>>
>>> Credits for 32 bit MAX_LFS_FILESIZE algorithm: Cyril Hrubis.
>> I got the same results:
>>
>> copy_file_range02.c:120: INFO: dst 9223372036854710270 len 65537
>> copy_file_range02.c:136: FAIL: copy_file_range returned wrong value: 32
> I'm not chanllenge the tst_max_lfs_filesize().
>
> But I don't understand why to define MAX_OFF as (MAX_LEN - MIN_OFF),
> the failure indicates that not to write at a position past the maximum
> allowed offset. Shouldn't we give a dst_off large than
> MAX_LFS_FILESIZE?
Yes, we should use a dst_off large than MAX_LFS_FILESIZE because it used pos to compare
in kernel code as below:

mm/filemap.c
  static int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
...
if (unlikely(pos>= max_size))
   return -EFBIG;
...

I strace xfstest generic/564 code( I follow this test code to ltp), as below:
#max_off=$((8 * 2**60 - 65536 - 1))
#min_off=65537
#xfs_io -f -c "pwrite -S 0x61 0 128k" file
#touch copy
#strace xfs_io -c "copy_range -l $min_off -s 0 -d $max_off file" copy
....
  openat(AT_FDCWD, "file", O_RDONLY)      = 4
  copy_file_range(4, [0], 3, [9223372036854710271], 65537, 0) = 65536
  copy_file_range(4, [65536], 3, [9223372036854775807], 1, 0) = -1 EFBIG (File too large)
....

xfsprogs used a loop to call copy_file_range, and get EFBIG when pos greater than LLONG_MAX.

I think we should  use tst_max_lfs_filesize instead of (tst_max_lfs_filesize -MIN_OFF)
and this case will pass whether xfs,btrfs and ext4.

Thanks for pointing out this.

> if I change the code as below, then it could be passed.
>
> --- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> +++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
> @@ -115,7 +115,7 @@ static void verify_copy_file_range(unsigned int n)
>          }
>
>          if (tc->copy_to_fd ==&fd_copy)
> -               dst = tst_max_lfs_filesize() - MIN_OFF;
> +               dst = tst_max_lfs_filesize();
>
>



