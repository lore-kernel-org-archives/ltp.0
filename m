From: Li Wang <liwang@redhat.com>
Date: Thu, 20 Feb 2020 15:25:47 +0800
Subject: [LTP] [PATCH V2 10/10] syscalls/open_tree: New tests
In-Reply-To: <da324ef2c06239f2cb7fc1eee436209e3bd2e35a.1582104018.git.viresh.kumar@linaro.org>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <da324ef2c06239f2cb7fc1eee436209e3bd2e35a.1582104018.git.viresh.kumar@linaro.org>
Message-ID: <CAEemH2ee77jFMsEptSqy39giJ5aXTsOpsRWg1g+6vLr8kfJsFw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Viresh Kumar <viresh.kumar@linaro.org> wrote:

> ...
> +++ b/testcases/kernel/syscalls/open_tree/open_tree01.c
> ...
> +static struct tcase {
> +       char *name;
> +       unsigned int flags;
> +} tcases[] = {
> +       {"Flag OPEN_TREE_CLONE", OPEN_TREE_CLONE},
> +       {"Flag OPEN_TREE_CLOEXEC", OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC},
> +};
>
==> remove Flag


+++ b/testcases/kernel/syscalls/open_tree/open_tree02.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> ...
> +
> +       fsmfd = TST_RET;
> +       TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
> +                       MOVE_MOUNT_F_EMPTY_PATH));
> +       SAFE_CLOSE(fsmfd);
> +
> +       if (TST_RET == -1)
> +               tst_brk(TBROK | TERRNO, "move_mount() failed");
> +
>

+       ismounted = 1;

We need to set 'ismounted' variable to 1 here, otherwise, the test will
break at the second loop.

------Error log------
tst_test.c:1278: INFO: Testing on ext3
tst_mkfs.c:90: INFO: Formatting /dev/loop2 with ext3 opts='' extra opts=''
mke2fs 1.44.6 (5-Mar-2019)
/dev/loop2 is mounted; will not make a filesystem here!
tst_mkfs.c:101: BROK: tst_test.c:831: mkfs.ext3 failed with 1
tst_device.c:222: WARN: ioctl(/dev/loop2, LOOP_CLR_FD, 0) no ENXIO for too
long
tst_tmpdir.c:330: WARN: tst_rmdir: rmobj(/tmp/SHZbDJ) failed:
unlink(/tmp/SHZbDJ/mntpoint) failed; errno=21: EISDIR

Summary:
passed   3
failed   0
skipped  0
warnings 0

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200220/dd859363/attachment.htm>
