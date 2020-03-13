From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Mar 2020 08:22:13 +0100
Subject: [LTP] [PATCH V6 05/10] syscalls/fsconfig: New tests
In-Reply-To: <20200313040012.bvkzfbxlvrwkkltd@vireshk-i7>
References: <cover.1584014172.git.viresh.kumar@linaro.org>
 <824c287cd06190cf0a489535fd4617aff8742b03.1584014172.git.viresh.kumar@linaro.org>
 <20200312191025.GD3803@rei.lan>
 <20200313040012.bvkzfbxlvrwkkltd@vireshk-i7>
Message-ID: <20200313072213.GA31549@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> On 12-03-20, 20:10, Cyril Hrubis wrote:
> > Hi!
> > Pushed with two minor changes:

> > diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig01.c b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
> > index d05350ce2..aea6db822 100644
> > --- a/testcases/kernel/syscalls/fsconfig/fsconfig01.c
> > +++ b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
> > @@ -77,6 +77,8 @@ static void run(void)
> >                 SAFE_UMOUNT(MNTPOINT);
> >                 tst_res(TPASS, "fsconfig() passed");
> >         }
> > +
> > +       SAFE_CLOSE(fd);

> This isn't required as cleanup() routine is taking care of it and this
> is a test_all type test.
+1.

> >  }

> > We need to close the fd here, because the test will run out of file
> > descriptors for large enough -i parameter, since cleanup is executed
> > only at the test end. Also note that SAFE_CLOSE() sets the fd to -1 so
> > that cleanup is no-op unless we trigger some of the tst_brk()
> > statements.

> >  static struct tst_test test = {
> > diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig02.c b/testcases/kernel/syscalls/fsconfig/fsconfig02.c
> > index b07a5f3ab..586524f14 100644
> > --- a/testcases/kernel/syscalls/fsconfig/fsconfig02.c
> > +++ b/testcases/kernel/syscalls/fsconfig/fsconfig02.c
> > @@ -94,6 +94,7 @@ static struct tst_test test = {
> >         .test = run,
> >         .setup = setup,
> >         .cleanup = cleanup,
> > +       .needs_tmpdir = 1,

> I probably didn't add this as we weren't mounting anything here.

> >         .needs_root = 1,
> >         .needs_device = 1,
> >  };

> > The test creates a file hence it has to request temporary directory.

Well, tmp dir would be created anyway due .needs_device, see lib/tst_test.c
static int needs_tmpdir(void)
{
	return tst_test->needs_tmpdir ||
	       tst_test->needs_device ||
	       tst_test->mntpoint ||
	       tst_test->resource_files ||
	       tst_test->needs_checkpoints;
}

But true it not required to be added as .needs_device implies needs_tmpdir,
see dae842774 ("Remove duplicated ".needs_tmpdir=1" when using equivalent flags").
But just a minor detail.

Kind regards,
Petr
