From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 28 Jun 2018 12:20:45 +0200
Subject: [LTP] [PATCH 1/2 v2] tst_test: Fail the test subprocess cannot
 be killed
In-Reply-To: <CAEemH2f7TQG+eSznxEnM-NgBx4gjvx=wy6JZh0mjCD_+=mbsGQ@mail.gmail.com>
References: <20180627152217.7067-1-chrubis@suse.cz>
 <CAEemH2f7TQG+eSznxEnM-NgBx4gjvx=wy6JZh0mjCD_+=mbsGQ@mail.gmail.com>
Message-ID: <20180628102045.GB21866@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +       unsigned int sleep = 100;
> > +       unsigned int retries = 0;
> > +
> > +       while (kill(-test_pid, 0) == 0) {
> 
> I'm a little worried about here, image that, if a process_A(test_pid)
> exist to make function kill(-test_pid, 0) return 0 at first time, then
> we go into this while loop, but during the sleeping time process_A
> exit and system reuse the test_pid to another process_B, we will still
> keep looping and very probably make mistake to report TFAIL(with stack
> of  process_B dump to ltp user in PATCH 2/2).

That is known limitation of UNIX. In practice it's very unlikely that
the pid would be reused in very short timeframe unless there is a fork
bomb running on the system or the system is out of pids, which both
means greater trouble.

Just try to run 'watch /proc/self/stat' and look how fast is the first
number increasing. On an idle system it's increased by a single digit
number every two seconds and even if you run a parallel compilation in
background it takes a long time until we start to reuse recenlty used
pids.

I guess that we can remove the part that doubles the sleep and increase
the number of retries accordingly, that way we would be much more likely
to hit even very short interval when the pid was not allocated.

We can also include various sanity checks, we may examine the process
whoose process group matches the test_pid to some degree. We can for
instance check if the process has been reparented to init i.e. parent
pid == 1 which happens when the parent is killed. However I would like
to avoid anything too complicated since at a point we get to this
situation the kernel has been likely corrupted so all bets are off, the
system is in inconsistent state and the best action to take is to try to
inform the tester that something went wrong.

-- 
Cyril Hrubis
chrubis@suse.cz
