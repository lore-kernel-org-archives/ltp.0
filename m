From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 26 Jan 2018 19:03:21 +0100
Subject: [LTP] [RFC PATCH 2/2] security/ima: Run measurements after
	policy
In-Reply-To: <20180126131145.GB12731@rei>
References: <20180111202821.31639-1-pvorel@suse.cz>
 <20180111202821.31639-3-pvorel@suse.cz>
 <20180126131145.GB12731@rei>
Message-ID: <20180126180321.7k644bvf64nv4uqr@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  runtest/ima | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)

> > diff --git a/runtest/ima b/runtest/ima
> > index 20d2e0810..3462d12b1 100644
> > --- a/runtest/ima
> > +++ b/runtest/ima
> > @@ -1,5 +1,5 @@
> >  #DESCRIPTION:Integrity Measurement Architecture (IMA)
> > -ima01 ima_measurements.sh
> > -ima02 ima_policy.sh
> > +ima01 ima_policy.sh
> > +ima02 ima_measurements.sh
> >  ima03 ima_tpm.sh
> >  ima04 ima_violations.sh

> Uh, depending on order of testcases in runtest file is broken anyways,
> what is the real problem here?
If system is configured with no policy, ima_measurements.sh fails. ima_policy.sh loads
some policy (if none loaded) / adds to policy (if policy already loaded and it's allowed
by kernel). So, the first case prevents failing ima_measurements.sh.
One problem with IMA testing I see is that IMHO it's not possible to revert policy.
That's why I added warnings that reboot is required. I know that this is against LTP
principle.
Mimi, Dmitry, am I right?

> Also I suppose that we may as well rename the test ids (e.g. ima01) to
> match the shell script name, since I find it more descriptive.
Sure!


Kind regards,
Petr
