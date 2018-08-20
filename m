From: Sandeep Patil <sspatil@google.com>
Date: Mon, 20 Aug 2018 09:06:55 -0700
Subject: [LTP] [PATCH] fs: exclude 'wakeup_count' from read_all_sys test.
In-Reply-To: <87mutp4cek.fsf@rpws.prws.suse.cz>
References: <20180803152018.13701-1-sspatil@google.com>
 <87sh3m48jn.fsf@rpws.prws.suse.cz>
 <20180813150202.GB140438@sspatil-desktop.mtv.corp.google.com>
 <87mutp4cek.fsf@rpws.prws.suse.cz>
Message-ID: <20180820160655.GD140438@sspatil-desktop.mtv.corp.google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Aug 14, 2018 at 09:48:03AM +0200, Richard Palethorpe wrote:
> Hello Sandeep,
> 
> Sandeep Patil <sspatil@google.com> writes:
> 
> > On Fri, Aug 10, 2018 at 04:10:04PM +0200, Richard Palethorpe wrote:
> >> Hello,
> >>
> >> Sandeep Patil <sspatil@google.com> writes:
> >>
> >> > /sys/power/wakeup_count semantics state that the read() for the file
> >> > will block as long as there is a wakeup_event in progress. On most
> >> > systems, this will be non deterministic and will result in extremely
> >> > flaky test. Exclude the file from read_all_sys test for the same.
> >> >
> >> > Signed-off-by: Sandeep Patil <sspatil@google.com>
> >> > ---
> >> >  runtest/fs | 2 +-
> >> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >> >
> >> > diff --git a/runtest/fs b/runtest/fs
> >> > index a66948a43..aca7e355f 100644
> >> > --- a/runtest/fs
> >> > +++ b/runtest/fs
> >> > @@ -71,7 +71,7 @@ proc01 proc01 -m 128
> >> >
> >> >  read_all_dev read_all -d /dev -p -q -r 10
> >> >  read_all_proc read_all -d /proc -q -r 10
> >> > -read_all_sys read_all -d /sys -q -r 10
> >> > +read_all_sys read_all -d /sys -q -r 10 -e /sys/power/wakeup_count
> >> >
> >>
> >> This probably won't be the only file with semantics like these. So I am
> >> wondering if we can limit the time it spends blocking with timer_create
> >> and SIGEV_THREAD_ID or something similar?
> >
> > Well, I actually like the fact that this test goes and reads everything and
> > makes sure the kernel operations for those files are "sane". We ended up
> > finding 2 different bugs due to this in the drivers, in 1 case it crashed the
> > kernel and in the other the test halted forever until timeout.
> 
> This is good to know.
> 
> >
> > So, unless the upstream ABI says the semantics are different for some files,
> > I don't think we should do this. 'wakeup_count' is the one I found and after
> > I exclude this, the test passes just fine on Pixel phones for example.
> > (Including the debugfs mount point under /sys/kernel/debug).
> >
> > I say we wait for another case of exclusion show up before considering your
> > approach as I think we will miss real problem if we start timing out. Plus,
> > there is the question of whether we report the test as PASS / FAIL in those
> > cases. The exclusion list is the right approach IMO. We may just have to
> > figure out how to add more than one in the command line as they show up.
> >
> > Agree?
> >
> 
> Yes, but possibly we should add a feature which allows us to annotate some
> file's. Then we can mark this file as 'can_block', so if we do timeout
> while reading it then we still know to PASS. Whereas for other files, we
> can FAIL if it blocks. We discussed doing something like this
> previously, but decided to wait for feedback before trying anything like
> this. We already had to drop privileges due to /dev/watchdog, but
> annotations could allow us to avoid this as well. This could perhaps go
> into read_all02 and read_all01 just continues to use an exclude list and
> drop privs.

Oh, I like this idea too. Sounds reasonable to me.


> 
> I would be happy to implement said feature, but it may take a while.

Same here, I'll keep this in my queue though, please CC me if possible if you
get around to doing it before I do. I'd be happy to test and give feedback.

Thanks again
- ssp

> In
> the meantime I'm not against merging this patch and waiting for another
> file with similar problems to appear.
> 
> What do you think Metan? We could probably replace proc01 with
> read_all02 as well.
> 
> > - ssp
> >
> >>
> >> --
> >> Thank you,
> >> Richard.
> >>
> >> --
> >> You received this message because you are subscribed to the Google Groups "kernel-team" group.
> >> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> >>
> 
> 
> --
> Thank you,
> Richard.
