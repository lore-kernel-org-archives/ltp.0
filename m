From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 6 May 2021 07:30:12 +0200
Subject: [LTP] [PATCH] syscalls/unlinkat01: Bugfix and update to new API
In-Reply-To: <ebf341b8fdd0424aae31204b4376d559@huawei.com>
References: <ebf341b8fdd0424aae31204b4376d559@huawei.com>
Message-ID: <YJN+5P2lUWi0gX5K@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Gongyi,

> Hi Petr,

> Thanks for your review!
yw :)

> > > -char *TCID = "unlinkat01";
> > > -int TST_TOTAL = TEST_CASES;
> > > -
> > >  static const char pathname[] = "unlinkattestdir",
> > >  		  subpathname[] = "unlinkatsubtestdir",
> > >  		  subpathdir[] = "unlinkattestdir/unlinkatsubtestdir",
> > > @@ -65,82 +41,79 @@ static const int flags[] = { 0, 0, 0, 0, 9999, 0,
> > > AT_REMOVEDIR };

> > Could you please use static struct for testcases data which is the usual way
> > in LTP instead of using arrays? (e.g. in
> > testcases/kernel/syscalls/access/access02.c).
> > It helps to the readability of the code as we'll be able to remove lines like:
> > 	fds[1] = fds[4] = fds[6] = fds[0];

> > and most of the setup.

> > Than you can then drop also TEST_CASES.

> It is more clearer that using arrays, but in this case, fds and filenames can not be complete initialized at first, so it seems there are some trouble to cleanup,

> Chould you give me some suggestions for it?
How about adding functions to setup things and have pointer to the functions?
See examples in testcases/kernel/syscalls/chmod/chmod06.c
or testcases/kernel/syscalls/clone/clone08.c

Kind regards,
Petr
