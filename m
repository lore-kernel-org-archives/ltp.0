From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 17 Sep 2018 10:27:52 +0200
Subject: [LTP] statx04.c:53: FAIL: STATX_ATTR_COMPRESSED flag is not set
 - Testing on ext2
In-Reply-To: <CA+G9fYsr=iYgaaepEnJOOu_-bR0p=3gCxAhcw6adQWPUnPfiYA@mail.gmail.com>
References: <CA+G9fYsr=iYgaaepEnJOOu_-bR0p=3gCxAhcw6adQWPUnPfiYA@mail.gmail.com>
Message-ID: <20180917082752.GA7857@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> statx04 test failed on Hikey (arm64) while testing for ext2 which is
> running 4.18 stable kernel and LTP master branch. Same test case got
> PASS for ext3 and ext4.
> 
> Is this test case need any special prerequirements ?

That is a confirmed kernel bug that I've been told by kernel dev will be fixed,
it's written in the test commit message as well:

commit 5ffb23e2c051c718814515527275e92a8d3155e0
Author: vaishnavid <vaishnavi.d@zilogic.com>
Date:   Mon Sep 3 12:18:28 2018 +0000

    syscalls/statx04: Add new test.

    This test will check if statx() reports attribute flags by adding
    FS_COMPR_FL, FS_APPEND_FL, FS_IMMUTABLE_FL and FS_NODUMP_FL to a
    direcotry and checks that the flags are reported correctly and also
    tests a directory with no flags.

    The test is executed against all filesystems, since most of the kernel
    code that implements this functionality is filesystem specific.

    * The ntfs3g fuse driver reports wrong errno for unimplemented ioctls()
      EINVAL while every other filesystem reports ENOTTY correctly

    * The test fails for ext2 filesystem mounted by kernel ext2 driver,
      which is confirmed to be kernel bug that will be fixed later on
      ^
      |
     See this part


-- 
Cyril Hrubis
chrubis@suse.cz
