From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 17 Feb 2020 09:58:18 +0100
Subject: [LTP] [PATCH 4/7] syscalls/fsmount: New tests
In-Reply-To: <20200217082931.vbjkg2f53lek4uf3@vireshk-i7>
References: <cover.1581680021.git.viresh.kumar@linaro.org>
 <1c61c673a02152c30edac0e25438257c23c3322e.1581680021.git.viresh.kumar@linaro.org>
 <CAEemH2f2pR1KhLAoKKphzh9fP++yyALbv4TiAh=4Vyv0M3SEdw@mail.gmail.com>
 <20200217082931.vbjkg2f53lek4uf3@vireshk-i7>
Message-ID: <20200217085818.GA11345@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> On 17-02-20, 16:17, Li Wang wrote:
> > Viresh Kumar <viresh.kumar@linaro.org> wrote:

> > ....
> > > +/*
> > > + * Copyright (c) 2020 Viresh Kumar <viresh.kumar@linaro.org>
> > > + *
> > > + * Description:
> > > + * Basic fsmount() test.
> > > + */
> > > +#include "tst_test.h"
> > > +#include "lapi/fsmount.h"


> > Adding #include "lapi/fcntl.h" in case of ?AT_FDCWD? undeclared. It seems
> > we have to do this for all the tests involves  ?AT_FDCWD?.

> my fsmount.h header includes <fcntl.h>, won't that be enough ?
Unfortunately it won't be enough. LAPI files are here for adding missing
definitions in old distros, which is exactly the case for AT_FDCWD on old RHEL.

I also suggest following change to v7, see diff below (fsmount.h using
"lapi/fcntl.h", thus not needed in fsmount01.c).

> > > +static void run(void)
> > > +{
> > > ...
> > > +
> > > +       TEST(fsmount(fd, 0, 0));


> > As this fsmount01.c is duplicated with zlang@'s patch, I suggest rewriting
> > an enhancement version maybe name fsmount02.c to cover more fsmount
> > attributes. Since it is named basic fsmount() test, it shouldn't only test
> > fsmount(fd, 0, 0), right?
+1.

> > +#define MOUNT_ATTR_RDONLY      0x00000001 /* Mount read-only */
> > +#define MOUNT_ATTR_NOSUID      0x00000002 /* Ignore suid and sgid bits */
> > +#define MOUNT_ATTR_NODEV       0x00000004 /* Disallow access to device
> > special files */
> > +#define MOUNT_ATTR_NOEXEC      0x00000008 /* Disallow program execution */
> > +#define MOUNT_ATTR__ATIME      0x00000070 /* Setting on how atime should
> > be updated */
> > +#define MOUNT_ATTR_RELATIME    0x00000000 /* - Update atime relative to
> > mtime/ctime. */
> > +#define MOUNT_ATTR_NOATIME     0x00000010 /* - Do not update access times.
> > */
> > +#define MOUNT_ATTR_STRICTATIME 0x00000020 /* - Always perform atime
> > updates */
> > +#define MOUNT_ATTR_NODIRATIME  0x00000080 /* Do not update directory
> > access times */

> Okay, I will give it a try.
Great thanks!

> > > +       if (TST_RET == -1)
> > > +               tst_brk(TFAIL | TERRNO, "fsmount() failed");
> > > +
> > > +       fsmfd = TST_RET;
> > > +
> > > +       TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
> > > +                       MOVE_MOUNT_F_EMPTY_PATH));
> > > +       SAFE_CLOSE(fsmfd);


> > I guess we probably need a way to verify the move_mount() does work. The
> > function ismount() in zlang@'s patch could be extracted into the library as
> > tst_ismount() for all of these tests.
> > @Petr Vorel <pvorel@suse.cz>  WDT?

> Yeah, I will do that.
+1. But I'd suggest to first merge tests which I sent as v7 [1] (with change
below) and then doing this.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/list/?series=158902&state=*
[2] https://travis-ci.org/pevik/ltp/builds/651390749

diff --git include/lapi/fsmount.h include/lapi/fsmount.h
index 87f2f229c..97c41629c 100644
--- include/lapi/fsmount.h
+++ include/lapi/fsmount.h
@@ -7,12 +7,12 @@
 #ifndef FSMOUNT_H__
 #define FSMOUNT_H__
 
-#include <fcntl.h>
+#include "config.h"
 #include <sys/mount.h>
 #include <sys/syscall.h>
 #include <sys/types.h>
 
-#include "config.h"
+#include "lapi/fcntl.h"
 #include "lapi/syscalls.h"
 
 #ifndef HAVE_FSOPEN
diff --git testcases/kernel/syscalls/fsmount/fsmount01.c testcases/kernel/syscalls/fsmount/fsmount01.c
index 464458080..6ba226acc 100644
--- testcases/kernel/syscalls/fsmount/fsmount01.c
+++ testcases/kernel/syscalls/fsmount/fsmount01.c
@@ -10,7 +10,6 @@
 #include <sys/mount.h>
 
 #include "tst_test.h"
-#include "lapi/fcntl.h"
 #include "lapi/fsmount.h"
 #include "tst_safe_stdio.h"
 
