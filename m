From: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date: Sat, 27 Jan 2018 19:57:11 -0500
Subject: [LTP] [RFC PATCH 2/2] security/ima: Run measurements after
 policy
In-Reply-To: <20180126180321.7k644bvf64nv4uqr@dell5510>
References: <20180111202821.31639-1-pvorel@suse.cz>
 <20180111202821.31639-3-pvorel@suse.cz> <20180126131145.GB12731@rei>
 <20180126180321.7k644bvf64nv4uqr@dell5510>
Message-ID: <1517101031.29187.128.camel@linux.vnet.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Fri, 2018-01-26 at 19:03 +0100, Petr Vorel wrote:
> Hi,
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > >  runtest/ima | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> > > diff --git a/runtest/ima b/runtest/ima
> > > index 20d2e0810..3462d12b1 100644
> > > --- a/runtest/ima
> > > +++ b/runtest/ima
> > > @@ -1,5 +1,5 @@
> > >  #DESCRIPTION:Integrity Measurement Architecture (IMA)
> > > -ima01 ima_measurements.sh
> > > -ima02 ima_policy.sh
> > > +ima01 ima_policy.sh
> > > +ima02 ima_measurements.sh
> > >  ima03 ima_tpm.sh
> > >  ima04 ima_violations.sh
> 
> > Uh, depending on order of testcases in runtest file is broken anyways,
> > what is the real problem here?
> If system is configured with no policy, ima_measurements.sh fails. ima_policy.sh loads
> some policy (if none loaded) / adds to policy (if policy already loaded and it's allowed
> by kernel). So, the first case prevents failing ima_measurements.sh.
> One problem with IMA testing I see is that IMHO it's not possible to revert policy.
> That's why I added warnings that reboot is required. I know that this is against LTP
> principle.
> Mimi, Dmitry, am I right?

The current ordering of the tests assume that the system was booted
with the builtin "ima_tcb" policy enabled on the boot command line.
 Assuming that the kernel doesn't require policies to be signed,
changing the order of the tests is fine.  Or simply test whether the
system was booted with either "ima_tcb" or "ima_policy=tcb" boot
command line options.

Mimi

> > Also I suppose that we may as well rename the test ids (e.g. ima01) to
> > match the shell script name, since I find it more descriptive.
> Sure!
> 
> 
> Kind regards,
> Petr
> 

