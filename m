From: Li Wang <liwang@redhat.com>
Date: Mon, 17 Feb 2020 16:17:27 +0800
Subject: [LTP] [PATCH 4/7] syscalls/fsmount: New tests
In-Reply-To: <1c61c673a02152c30edac0e25438257c23c3322e.1581680021.git.viresh.kumar@linaro.org>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
 <1c61c673a02152c30edac0e25438257c23c3322e.1581680021.git.viresh.kumar@linaro.org>
Message-ID: <CAEemH2f2pR1KhLAoKKphzh9fP++yyALbv4TiAh=4Vyv0M3SEdw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Viresh Kumar <viresh.kumar@linaro.org> wrote:

....
> +/*
> + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> + *
> + * Description:
> + * Basic fsmount() test.
> + */
> +#include "tst_test.h"
> +#include "lapi/fsmount.h"
>

Adding #include "lapi/fcntl.h" in case of ?AT_FDCWD? undeclared. It seems
we have to do this for all the tests involves  ?AT_FDCWD?.

+
> +static void run(void)
> +{
> ...
> +
> +       TEST(fsmount(fd, 0, 0));
>

As this fsmount01.c is duplicated with zlang@'s patch, I suggest rewriting
an enhancement version maybe name fsmount02.c to cover more fsmount
attributes. Since it is named basic fsmount() test, it shouldn't only test
fsmount(fd, 0, 0), right?

+#define MOUNT_ATTR_RDONLY      0x00000001 /* Mount read-only */
+#define MOUNT_ATTR_NOSUID      0x00000002 /* Ignore suid and sgid bits */
+#define MOUNT_ATTR_NODEV       0x00000004 /* Disallow access to device
special files */
+#define MOUNT_ATTR_NOEXEC      0x00000008 /* Disallow program execution */
+#define MOUNT_ATTR__ATIME      0x00000070 /* Setting on how atime should
be updated */
+#define MOUNT_ATTR_RELATIME    0x00000000 /* - Update atime relative to
mtime/ctime. */
+#define MOUNT_ATTR_NOATIME     0x00000010 /* - Do not update access times.
*/
+#define MOUNT_ATTR_STRICTATIME 0x00000020 /* - Always perform atime
updates */
+#define MOUNT_ATTR_NODIRATIME  0x00000080 /* Do not update directory
access times */



> +       if (TST_RET == -1)
> +               tst_brk(TFAIL | TERRNO, "fsmount() failed");
> +
> +       fsmfd = TST_RET;
> +
> +       TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
> +                       MOVE_MOUNT_F_EMPTY_PATH));
> +       SAFE_CLOSE(fsmfd);
>

I guess we probably need a way to verify the move_mount() does work. The
function ismount() in zlang@'s patch could be extracted into the library as
tst_ismount() for all of these tests.
@Petr Vorel <pvorel@suse.cz>  WDT?


> +
> +       if (TST_RET == -1)
> +               tst_brk(TBROK | TERRNO, "move_mount() failed");
> +
> +       SAFE_CLOSE(TST_RET);
> +       TEST(umount(MNTPOINT));
>

SAFE_UMOUNT(MNTPOINT);

+
> +       tst_res(TPASS, "fsmount() passed");
> +}
> +
> +static struct tst_test test = {
>

Suggest referring to my previous comments for this part.

+       .min_kver = "5.2",
> +       .test_all = run,
> +       .setup = setup,
> +       .cleanup = cleanup,
> +       .needs_root = 1,
> +       .needs_tmpdir = 1,
> +       .format_device = 1,
> +       .mntpoint = MNTPOINT,
> +};
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200217/0678ec1f/attachment.htm>
