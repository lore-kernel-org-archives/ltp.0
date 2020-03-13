From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Fri, 13 Mar 2020 14:18:53 +0530
Subject: [LTP] [PATCH V6 05/10] syscalls/fsconfig: New tests
In-Reply-To: <20200313080334.GA6597@rei.lan>
References: <cover.1584014172.git.viresh.kumar@linaro.org>
 <824c287cd06190cf0a489535fd4617aff8742b03.1584014172.git.viresh.kumar@linaro.org>
 <20200312191025.GD3803@rei.lan>
 <20200313040012.bvkzfbxlvrwkkltd@vireshk-i7>
 <20200313080334.GA6597@rei.lan>
Message-ID: <20200313084853.lnfi4dnyoht5yupi@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 13-03-20, 09:03, Cyril Hrubis wrote:
> Hi!
> > > diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig01.c b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
> > > index d05350ce2..aea6db822 100644
> > > --- a/testcases/kernel/syscalls/fsconfig/fsconfig01.c
> > > +++ b/testcases/kernel/syscalls/fsconfig/fsconfig01.c
> > > @@ -77,6 +77,8 @@ static void run(void)
> > >                 SAFE_UMOUNT(MNTPOINT);
> > >                 tst_res(TPASS, "fsconfig() passed");
> > >         }
> > > +
> > > +       SAFE_CLOSE(fd);
> > 
> > This isn't required as cleanup() routine is taking care of it and this
> > is a test_all type test.
> 
> It _is_, I've tried top explain in the paragraph below, just run the
> test with large enough -i, sooner or late the test will run out of file
> descriptiors and then it will fail.
> 
> The key here is that the run() function can be called repeatedly but
> setup() and cleanup() are called only once at the start and at the end
> of the test.

I didn't knew about the -i option, yeah your change makes sense now :)

-- 
viresh
