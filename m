From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 17 Feb 2020 13:59:31 +0530
Subject: [LTP] [PATCH 4/7] syscalls/fsmount: New tests
In-Reply-To: <CAEemH2f2pR1KhLAoKKphzh9fP++yyALbv4TiAh=4Vyv0M3SEdw@mail.gmail.com>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
 <1c61c673a02152c30edac0e25438257c23c3322e.1581680021.git.viresh.kumar@linaro.org>
 <CAEemH2f2pR1KhLAoKKphzh9fP++yyALbv4TiAh=4Vyv0M3SEdw@mail.gmail.com>
Message-ID: <20200217082931.vbjkg2f53lek4uf3@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 17-02-20, 16:17, Li Wang wrote:
> Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> ....
> > +/*
> > + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> > + *
> > + * Description:
> > + * Basic fsmount() test.
> > + */
> > +#include "tst_test.h"
> > +#include "lapi/fsmount.h"
> >
> 
> Adding #include "lapi/fcntl.h" in case of ?AT_FDCWD? undeclared. It seems
> we have to do this for all the tests involves  ?AT_FDCWD?.

my fsmount.h header includes <fcntl.h>, won't that be enough ?

> +
> > +static void run(void)
> > +{
> > ...
> > +
> > +       TEST(fsmount(fd, 0, 0));
> >
> 
> As this fsmount01.c is duplicated with zlang@'s patch, I suggest rewriting
> an enhancement version maybe name fsmount02.c to cover more fsmount
> attributes. Since it is named basic fsmount() test, it shouldn't only test
> fsmount(fd, 0, 0), right?
> 
> +#define MOUNT_ATTR_RDONLY      0x00000001 /* Mount read-only */
> +#define MOUNT_ATTR_NOSUID      0x00000002 /* Ignore suid and sgid bits */
> +#define MOUNT_ATTR_NODEV       0x00000004 /* Disallow access to device
> special files */
> +#define MOUNT_ATTR_NOEXEC      0x00000008 /* Disallow program execution */
> +#define MOUNT_ATTR__ATIME      0x00000070 /* Setting on how atime should
> be updated */
> +#define MOUNT_ATTR_RELATIME    0x00000000 /* - Update atime relative to
> mtime/ctime. */
> +#define MOUNT_ATTR_NOATIME     0x00000010 /* - Do not update access times.
> */
> +#define MOUNT_ATTR_STRICTATIME 0x00000020 /* - Always perform atime
> updates */
> +#define MOUNT_ATTR_NODIRATIME  0x00000080 /* Do not update directory
> access times */

Okay, I will give it a try.
 
> > +       if (TST_RET == -1)
> > +               tst_brk(TFAIL | TERRNO, "fsmount() failed");
> > +
> > +       fsmfd = TST_RET;
> > +
> > +       TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
> > +                       MOVE_MOUNT_F_EMPTY_PATH));
> > +       SAFE_CLOSE(fsmfd);
> >
> 
> I guess we probably need a way to verify the move_mount() does work. The
> function ismount() in zlang@'s patch could be extracted into the library as
> tst_ismount() for all of these tests.
> @Petr Vorel <pvorel@suse.cz>  WDT?

Yeah, I will do that.
 
-- 
viresh
