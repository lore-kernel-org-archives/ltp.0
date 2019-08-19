From: Li Wang <liwang@redhat.com>
Date: Mon, 19 Aug 2019 16:16:45 +0800
Subject: [LTP] [PATCH] lapi/fs.h: Replace MAX_LFS_FILESIZE constant with
 own implementation
In-Reply-To: <20190816085309.fqvip4exe4mvtv2o@XZHOUW.usersys.redhat.com>
References: <20190815083630.26975-1-pvorel@suse.cz>
 <20190816085309.fqvip4exe4mvtv2o@XZHOUW.usersys.redhat.com>
Message-ID: <CAEemH2d7TYn4sZ7kkjRsPc-yBnTrN9LC+w84MAO6pDxYpfiFcw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Aug 16, 2019 at 4:53 PM Murphy Zhou <jencce.kernel@gmail.com> wrote:
>
> On Thu, Aug 15, 2019 at 10:36:30AM +0200, Petr Vorel wrote:
> > Some libc implementations on arm (at least AArch32 target with hard
> > float (arm-linux-gnueabihf)) or some libc (musl, bionic) does not
> > export PAGE_SHIFT. Replace it with own inline function.
> >
> > This required to replace MAX_LFS_FILESIZE constant with function
> > tst_max_lfs_filesize(). Given that we must use MAX_OFF in a function,
> > move dst from tcase struct to verify_copy_file_range().
> >
> > Credits for 32 bit MAX_LFS_FILESIZE algorithm: Cyril Hrubis.
>
> I got the same results:
>
> copy_file_range02.c:120: INFO: dst 9223372036854710270 len 65537
> copy_file_range02.c:136: FAIL: copy_file_range returned wrong value: 32

I'm not chanllenge the tst_max_lfs_filesize().

But I don't understand why to define MAX_OFF as (MAX_LEN - MIN_OFF),
the failure indicates that not to write at a position past the maximum
allowed offset. Shouldn't we give a dst_off large than
MAX_LFS_FILESIZE?

if I change the code as below, then it could be passed.

--- a/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
+++ b/testcases/kernel/syscalls/copy_file_range/copy_file_range02.c
@@ -115,7 +115,7 @@ static void verify_copy_file_range(unsigned int n)
        }

        if (tc->copy_to_fd == &fd_copy)
-               dst = tst_max_lfs_filesize() - MIN_OFF;
+               dst = tst_max_lfs_filesize();


-- 
Regards,
Li Wang
