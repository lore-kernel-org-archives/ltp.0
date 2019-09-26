From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 26 Sep 2019 05:52:22 -0400 (EDT)
Subject: [LTP] LTP Release
In-Reply-To: <20190926090853.GB13769@rei.lan>
References: <20190906130707.GA7515@rei.lan> <20190925112236.GA17496@rei.lan>
 <748796853.2255246.1569486581084.JavaMail.zimbra@redhat.com>
 <20190926083346.GA13769@rei.lan>
 <1811360181.2258162.1569488053513.JavaMail.zimbra@redhat.com>
 <20190926090853.GB13769@rei.lan>
Message-ID: <2048272111.2267199.1569491542749.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> Hi!
> > > > I'm thinking if we should patch BPF tests to increase max lock memory
> > > > to +1MB. On Fedora30 default limit is '64', and I found couple
> > > > systems which by default come very close to that limit right after
> > > > boot.
> > > > So even one iteration of BPF tests will hit a failure.
> > > 
> > > I've seen them fail on ppc64le, because of 64k pages as well. Maybe we
> > > shouldn't workaround the failure but rather print a TINFO message that
> > > the limit is too low and the test is likely to fail. Then I will write
> > > the email to kernel developers once the release is done and we will do
> > > something about them later on.
> > 
> > This appears to be known, and some tools like perf started auto-bumping
> > limit:
> >   https://lkml.org/lkml/2019/7/17/714
> > 
> > I'd prefer LTP does that too, we can always revert later when it's
> > fixed/changed on kernel side.
> 
> Agreed then, will you prepare the patch?

Sure, I'll post it today.

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
