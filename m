From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 29 Aug 2018 03:18:06 -0400 (EDT)
Subject: [LTP] [PATCH v2 1/2] lib: add tst_get_timeout()
In-Reply-To: <CAEemH2cd9_j+g0suRSEXw2UyM+XrPnWUv5UaLCybk8WeikxyFA@mail.gmail.com>
References: <6680bda80c85d424a5219d9f55dc9c5355dc0da1.1535454204.git.jstancek@redhat.com>
 <20180828125808.GB24095@rei> <87wosashbp.fsf@rpws.prws.suse.cz>
 <1445215680.43198555.1535467127164.JavaMail.zimbra@redhat.com>
 <CAEemH2cd9_j+g0suRSEXw2UyM+XrPnWUv5UaLCybk8WeikxyFA@mail.gmail.com>
Message-ID: <800967112.43399023.1535527086665.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> On Tue, Aug 28, 2018 at 10:38 PM, Jan Stancek <jstancek@redhat.com> wrote:
> 
> >
> >
> > ----- Original Message -----
> > > Hello,
> > >
> > > Cyril Hrubis <chrubis@suse.cz> writes:
> > >
> > > > Hi!
> > > > It's just an idea, but we can make this even more elegant API.
> > > >
> > > > We measure the time in the test library anyway, so what about we added
> > > > something as tst_timeout_reached() that would return number of seconds
> > > > remaining to 80% of the real timeout or 0 if in a case that the timeout
> > > > was reached. Then we can use this as a soft-timeout in all the
> > testcases
> > > > without any additional steps.
> > > >
> > > > --
> > > > Cyril Hrubis
> > > > chrubis@suse.cz
> > >
> > > 80% is probably way more than many of the CVE test cases need unless the
> > > overall timeout is reduced from 5 minutes. Probably 20% would be
> > > OK. Assuming this is the kind of usage scenario you had in mind.
> >
> > I'd leave it to user. Give him data how much time is left,
> > and let him decide what is sensible limit for soft-timeout.
> >
> > Hmm, I'm not sure if I have any misunderstood on Cyril's words. But from
> what I think, maybe we also could give more flexible to customize the
> soft-timeout as tst_timeout_reached(0.8) to return true when testcase
> reached 80% of the real timeout. This makes thing more easier and can
> satisfy some kind of demanded.

Sure, but then we are always working with ratios, and can't do something like
"15 seconds before timeout do X". 

