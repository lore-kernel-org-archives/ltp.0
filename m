From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 19 Oct 2020 15:40:48 +0530
Subject: [LTP] [PATCH V3 2/3] syscalls: select: Verify that data is
 available to read
In-Reply-To: <20201014121343.GD31816@yuki.lan>
References: <6fbfc6919c0000e7a7745afbc3c94baab02603fa.1599558175.git.viresh.kumar@linaro.org>
 <fb31dd18ad396ab602ba8957ee01a666f79ad9bb.1599558175.git.viresh.kumar@linaro.org>
 <20201014121343.GD31816@yuki.lan>
Message-ID: <20201019101048.knbl2w3q2xev6ywc@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 14-10-20, 14:13, Cyril Hrubis wrote:
> Hi!
> > select() returns a positive value on success if timeout hasn't happened,
> > else returns 0. Check that and send some data to the write file
> > descriptor for the same.
> > 
> > Acked-by: Li Wang <liwang@redhat.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  testcases/kernel/syscalls/select/select01.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> > 
> > diff --git a/testcases/kernel/syscalls/select/select01.c b/testcases/kernel/syscalls/select/select01.c
> > index 1213aa931251..c6b30aa67dd7 100644
> > --- a/testcases/kernel/syscalls/select/select01.c
> > +++ b/testcases/kernel/syscalls/select/select01.c
> > @@ -25,25 +25,32 @@ static struct select_info {
> >  	int *nfds;
> >  	fd_set *readfds;
> >  	fd_set *writefds;
> > +	int *writefd;
> >  	char *desc;
> >  } tests[] = {
> > -	{&fd_reg, &readfds_reg, NULL, "with regular file"},
> > -	{&fds_pipe[1], &readfds_pipe, &writefds_pipe, "with system pipe"},
> > -	{&fd_npipe, &readfds_npipe, &writefds_npipe, "with named pipe (FIFO)"},
> > +	{&fd_reg, &readfds_reg, NULL, NULL, "with regular file"},
> > +	{&fds_pipe[1], &readfds_pipe, &writefds_pipe, &fds_pipe[1], "with system pipe"},
> > +	{&fd_npipe, &readfds_npipe, &writefds_npipe, &fd_npipe, "with named pipe (FIFO)"},
> >  };
> >  
> >  static void run(unsigned int n)
> >  {
> >  	struct select_info *tc = &tests[n];
> >  	struct timeval timeout;
> > +	char buf;
> >  
> >  	timeout.tv_sec = 0;
> >  	timeout.tv_usec = 100000;
> >  
> > +	if (tc->writefd)
> > +		SAFE_WRITE(0, *tc->writefd, &buf, sizeof(buf));
> 
> I'm not sure why we are writing data here. For both the pipe and fifo
> the select() will return that we can write there, hence the return would
> be non-zero regardless.

Maybe I haven't understood what you meant when you said this earlier:

  And the coverate in these tests is a bit lacking, we do not have a
  single tests that would send a data over a pipe to a fd select is
  watching and check that select was woken up by that. There is no such
  test in the pselect/ directory either.

> Also I would like to be more specific. E.g. expecting specific return
> instead of just non-zero and also making sure the right bits are enabled
> in the fd sets.

Something like this ?

diff --git a/testcases/kernel/syscalls/select/select01.c b/testcases/kernel/syscalls/select/select01.c
index e4b5caecbb10..4b33c0a01380 100644
--- a/testcases/kernel/syscalls/select/select01.c
+++ b/testcases/kernel/syscalls/select/select01.c
@@ -38,12 +38,15 @@ static void run(unsigned int n)
        struct tcases *tc = &tests[n];
        struct timeval timeout;
        char buf;
+       int exp_ret = 1;
 
        timeout.tv_sec = 0;
        timeout.tv_usec = 100000;
 
-       if (tc->writefd)
+       if (tc->writefd) {
                SAFE_WRITE(0, *tc->writefd, &buf, sizeof(buf));
+               exp_ret++;
+       }
 
        TEST(do_select(*tc->nfds + 1, tc->readfds, tc->writefds, 0, &timeout));
 
@@ -51,6 +54,8 @@ static void run(unsigned int n)
                tst_res(TFAIL | TTERRNO, "select() failed %s", tc->desc);
        else if (!TST_RET)
                tst_res(TFAIL, "select() timed out %s", tc->desc);
+       else if (TST_RET != exp_ret)
+               tst_res(TFAIL, "select() returned incorrect value: %s, expected: %d, got: %lu", tc->desc, exp_ret, TST_RET);
        else
                tst_res(TPASS, "select() passed %s", tc->desc);
 }

-- 
viresh
