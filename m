From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 18 Feb 2016 06:26:14 -0500 (EST)
Subject: [LTP] Test library API changes
In-Reply-To: <20160218110752.GB19157@rei.lan>
References: <20160105111136.GA32659@rei.lan>
 <116630920.20260383.1455280426104.JavaMail.zimbra@redhat.com>
 <20160212175308.GA30723@rei.suse.cz> <20160216211958.GC2515@rei.lan>
 <1799339064.21851637.1455719961718.JavaMail.zimbra@redhat.com>
 <20160217155406.GA12574@rei>
 <1752902661.22105327.1455786359593.JavaMail.zimbra@redhat.com>
 <20160218110752.GB19157@rei.lan>
Message-ID: <1610317133.22142649.1455794774969.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Thursday, 18 February, 2016 12:07:53 PM
> Subject: Re: [LTP] Test library API changes
> 
> Hi!
> > > > 2. Can we keep ltp_syscall() and call correct brk func with some magic?
> > > 
> > > Well we can split the header as we did with the rest of them, do you
> > > think that it's worth of it?
> > 
> > I was thinking some ifdef magic. It has same signature in both
> > versions of API, so adding new function with different name,
> > that does pretty much the same seems like unnecessary complication.
> 
> My reasoning was different. There are only two functions that start with
> ltp_ in the library the ltp_syscall and ltp_clone. So the reason for
> rename is unifying on tst_ and it was convinient in this case as well.
> But I do not care that much about this. If you think keeping
> ltp_syscall() is better, then we can go for it.
> 
> > > > 5c) What if we stored ipc path to env variable?
> > > > 
> > > > setup_ipc
> > > >   generates tmp name based on test name: ltp_ipc_path
> > > >   for convenience will initialize also envp array:
> > > >     ltp_only_ipc_env[] = { "LTP_IPC_PATH="$ltp_ipc_path, NULL }
> > > >   creates ipc file
> > > 
> > > Hmm, that way the test would have to explicitly pass it to the execve().
> > 
> > True, but it would be rare, as you said it's for ~10 testcases.
> > 
> > > 
> > > I would rather make it reasonably unique but decideable without
> > > explicitly passing variables around.
> > 
> > Should we consider multiple instances running at a time? I do
> > recall that tools/pounder21 allows running things in parallel.
> > (Not sure if anyone runs more instances of same test though)
> 
> I think that disabling the possibility just to make writing the test
> library a bit easier is pretty bad idea. Most of the testcases we have
> can run in parallel just fine. There are only a few that stress the
> system to the limit or use global resources (devices, IPC, change system
> time, ...) and if we anotate these tests we can easily speed up the test
> run five times just by running most of the testcases in parallel.

I wasn't suggesting we do that. I was thinking about making ipc filename
more unique for each instance, in case we wouldn't have /proc and test
cleanup doesn't run for whatever reason. That of course would make 
ipc file names less predictable.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
