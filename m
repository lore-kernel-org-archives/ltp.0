From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 11 Apr 2019 08:22:19 -0400
Subject: [LTP] [PATCH v2 1/3] ima: Call test's cleanup inside
 ima_setup.sh cleanup
In-Reply-To: <20190411055114.GA23472@x230>
References: <20190405165225.27216-1-pvorel@suse.cz>
 <20190405165225.27216-2-pvorel@suse.cz>
 <1554944374.25614.25.camel@linux.ibm.com> <20190411055114.GA23472@x230>
Message-ID: <1554985339.7843.18.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Thu, 2019-04-11 at 07:51 +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> thanks for your comments.
> 
> ...
> > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > > @@ -20,7 +20,8 @@
> > >  TST_TESTFUNC="test"
> > >  TST_SETUP_CALLER="$TST_SETUP"
> > >  TST_SETUP="ima_setup"
> > > -TST_CLEANUP="${TST_CLEANUP:-ima_cleanup}"
> > > +TST_CLEANUP_CALLER="$TST_CLEANUP"
> > > +TST_CLEANUP="ima_cleanup"
> 
> > It seems to be working, but defining TST_SETUP and TST_CLEANUP after
> > defining the respective _CALLER looks strange.  The _CALLER's string
> > must be empty.
> TST_{SETUP,CALLER}_CALLER takes setup from the test.
> It's IMHO cleaner way allowing tests to set their setup/cleanup functions and
> not care that there is also some library setup/cleanup (kind of encapsulation).

I'm not questioning the method for initializing this test.  I guess
I'm asking why bother to set TST_{SETUP,CLEANUP}_CALLER this way, if
we know that it isn't set.  Why not just initialize it as ""?

Mimi
> 
> We already used this for setup, I wanted to have a same approach for both setup
> and cleanup. Sure I can instead add ima_setup/ima_cleanup into tests' setup/cleanup
> functions, but both solutions are working and I consider encapsulation as a benefit.
> The only problematic thing would be if some test needed to run it's custom
> cleanup *before* library one while other tests *after*. But that's not a case here.
> We also use this approach in tst_net.sh [1].
> 
> > >  TST_NEEDS_TMPDIR=1
> > >  TST_NEEDS_ROOT=1
> 
> > > @@ -95,6 +96,9 @@ ima_setup()
> > >  ima_cleanup()
> > >  {
> > >  	local dir
> > > +
> > > +	[ -n "$TST_CLEANUP_CALLER" ] && $TST_CLEANUP_CALLER
> > > +
> 
> > Is something else setting TST_CLEANUP_CALLER?
> 
> 
> Kind regards,
> Petr
> 
> [1] https://github.com/linux-test-project/ltp/blob/master/testcases/lib/tst_net.sh#L11
> 

