From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 26 Sep 2019 10:33:46 +0200
Subject: [LTP] LTP Release
In-Reply-To: <748796853.2255246.1569486581084.JavaMail.zimbra@redhat.com>
References: <20190906130707.GA7515@rei.lan> <20190925112236.GA17496@rei.lan>
 <748796853.2255246.1569486581084.JavaMail.zimbra@redhat.com>
Message-ID: <20190926083346.GA13769@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I did a few testruns and so far it looks good.
> > 
> > I've send one patch for acct02, which is mostly cosmetic, that I would
> > like to get merged.
> > 
> > I would still consider merging the eBPF regression test, does anybody
> > have a strong opinion on this?
> > 
> > Apart from this preadv203 sometimes fails to trigger EAGAIN on virtual
> > machines, but I doubt we can fix this before the release, I will try to
> > do so later on.
> > 
> > The rest seems to be good, i.e. failures does not seem to be bugs in
> > tests.
> > 
> > What is the status from rest of you? Is there anything that should be
> > considered for the release? Is something failing unexpectedly?
> 
> I'm thinking if we should patch BPF tests to increase max lock memory
> to +1MB. On Fedora30 default limit is '64', and I found couple
> systems which by default come very close to that limit right after boot.
> So even one iteration of BPF tests will hit a failure.

I've seen them fail on ppc64le, because of 64k pages as well. Maybe we
shouldn't workaround the failure but rather print a TINFO message that
the limit is too low and the test is likely to fail. Then I will write
the email to kernel developers once the release is done and we will do
something about them later on.

-- 
Cyril Hrubis
chrubis@suse.cz
