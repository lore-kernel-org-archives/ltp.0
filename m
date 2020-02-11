From: Li Wang <liwang@redhat.com>
Date: Tue, 11 Feb 2020 19:53:27 +0800
Subject: [LTP] [PATCH] syscalls/setrlimit06: lower RLIMIT_CPU parameters
In-Reply-To: <1734212650.7000036.1581418326024.JavaMail.zimbra@redhat.com>
References: <87e6761eb699c7912e2064dea222f5ac7fd04a6b.1581338640.git.jstancek@redhat.com>
 <CAEemH2f90MPBV_w2+gw331cg0Fiu-=aqgp3M1BHhBCXcFUbyyg@mail.gmail.com>
 <1734212650.7000036.1581418326024.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2cJhxWcMj3k1ayasQegL-aPgjkkdypk881dXmjeV=MQmA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Feb 11, 2020 at 6:52 PM Jan Stancek <jstancek@redhat.com> wrote:

>
>
> ----- Original Message -----
> > On Mon, Feb 10, 2020 at 8:47 PM Jan Stancek <jstancek@redhat.com> wrote:
> >
> > > Lower the parameters so that test completes faster where possible.
> > >
> > > This also increases alarm timer slightly, which in combination with
> > > lower RLIMIT_CPU aims to avoid false positives in environments with
> > > high steal time, where it can take multiple of wall clock seconds
> > > to spend single second on a cpu.
> > >
> >
> > This patch could reduce the test failure possibility, but I'm afraid it
> > can't fix the problem radically, because with `stress -c 20' to overload
> an
> > s390x system(2cpus) in the background then setrlimit06(patched) still
> > easily gets failed:
> >     setrlimit06.c:98: FAIL: Got only SIGXCPU after reaching both limit
> >
> > Another way I can think of is to raise the priority before its running,
> not
> > sure if that will disturb the original test but from my test, it always
> > gets a pass even with too much overload.
>
> Is this in addition to my patch? Because on its own I don't see how this
> will help when load is coming from different guests.
>

Yes, this is only solving for itself loads. Besides the high steal time,
that's another reason I guess it causes the same failure, so do you think
it makes sense to merge two methods together?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200211/e6aadb11/attachment.htm>
