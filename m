From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 20 Feb 2020 13:05:48 +0530
Subject: [LTP] [PATCH V2 10/10] syscalls/open_tree: New tests
In-Reply-To: <CAEemH2ee77jFMsEptSqy39giJ5aXTsOpsRWg1g+6vLr8kfJsFw@mail.gmail.com>
References: <cover.1582104018.git.viresh.kumar@linaro.org>
 <da324ef2c06239f2cb7fc1eee436209e3bd2e35a.1582104018.git.viresh.kumar@linaro.org>
 <CAEemH2ee77jFMsEptSqy39giJ5aXTsOpsRWg1g+6vLr8kfJsFw@mail.gmail.com>
Message-ID: <20200220073548.d272x5qzrkc2fq6b@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20-02-20, 15:25, Li Wang wrote:
> Viresh Kumar <viresh.kumar@linaro.org> wrote:
> 
> > ...
> > +++ b/testcases/kernel/syscalls/open_tree/open_tree01.c
> > ...
> > +static struct tcase {
> > +       char *name;
> > +       unsigned int flags;
> > +} tcases[] = {
> > +       {"Flag OPEN_TREE_CLONE", OPEN_TREE_CLONE},
> > +       {"Flag OPEN_TREE_CLOEXEC", OPEN_TREE_CLONE | OPEN_TREE_CLOEXEC},
> > +};
> >
> ==> remove Flag
> 
> 
> +++ b/testcases/kernel/syscalls/open_tree/open_tree02.c
> > @@ -0,0 +1,104 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > ...
> > +
> > +       fsmfd = TST_RET;
> > +       TEST(move_mount(fsmfd, "", AT_FDCWD, MNTPOINT,
> > +                       MOVE_MOUNT_F_EMPTY_PATH));
> > +       SAFE_CLOSE(fsmfd);
> > +
> > +       if (TST_RET == -1)
> > +               tst_brk(TBROK | TERRNO, "move_mount() failed");
> > +
> >
> 
> +       ismounted = 1;
> 
> We need to set 'ismounted' variable to 1 here, otherwise, the test will
> break at the second loop.

Last minute change went untested it seems. Sorry about that.

-- 
viresh
