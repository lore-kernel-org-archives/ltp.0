From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 11 Apr 2019 22:21:00 +0200
Subject: [LTP] [PATCH v2 1/3] ima: Call test's cleanup inside
 ima_setup.sh cleanup
In-Reply-To: <1554985339.7843.18.camel@linux.ibm.com>
References: <20190405165225.27216-1-pvorel@suse.cz>
 <20190405165225.27216-2-pvorel@suse.cz>
 <1554944374.25614.25.camel@linux.ibm.com>
 <20190411055114.GA23472@x230>
 <1554985339.7843.18.camel@linux.ibm.com>
Message-ID: <20190411202100.GA31030@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Mimi,

> > > > +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > > > @@ -20,7 +20,8 @@
> > > >  TST_TESTFUNC="test"
> > > >  TST_SETUP_CALLER="$TST_SETUP"
> > > >  TST_SETUP="ima_setup"
> > > > -TST_CLEANUP="${TST_CLEANUP:-ima_cleanup}"
> > > > +TST_CLEANUP_CALLER="$TST_CLEANUP"
> > > > +TST_CLEANUP="ima_cleanup"

> > > It seems to be working, but defining TST_SETUP and TST_CLEANUP after
> > > defining the respective _CALLER looks strange.  The _CALLER's string
> > > must be empty.
> > TST_{SETUP,CALLER}_CALLER takes setup from the test.
> > It's IMHO cleaner way allowing tests to set their setup/cleanup functions and
> > not care that there is also some library setup/cleanup (kind of encapsulation).

> I'm not questioning the method for initializing this test.  I guess
> I'm asking why bother to set TST_{SETUP,CLEANUP}_CALLER this way, if
> we know that it isn't set.  Why not just initialize it as ""?

Sorry, I wasn't clear, TST_{SETUP,CLEANUP}_CALLER are set by (some) tests
(as TST_{SETUP,CLEANUP}):

$ git grep TST_SETUP= testcases/kernel/security/integrity/ima/tests/*.sh |grep -v ima_setup.sh
testcases/kernel/security/integrity/ima/tests/evm_overlay.sh:TST_SETUP="setup"
testcases/kernel/security/integrity/ima/tests/ima_measurements.sh:TST_SETUP="setup"
testcases/kernel/security/integrity/ima/tests/ima_policy.sh:TST_SETUP="setup"
testcases/kernel/security/integrity/ima/tests/ima_violations.sh:TST_SETUP="setup"

$ git grep TST_CLEANUP= testcases/kernel/security/integrity/ima/tests/*.sh |grep -v ima_setup.sh
testcases/kernel/security/integrity/ima/tests/evm_overlay.sh:TST_CLEANUP="cleanup"
testcases/kernel/security/integrity/ima/tests/ima_violations.sh:TST_CLEANUP="cleanup"

And this variables are set before loading ima_setup.sh.
So TST_{SETUP,CLEANUP}_CALLER get value from tests (if defined), overwrites it
with it's own function for tst_test.sh, where it calls them (if defined).

Or am I missing something?

> Mimi


Kind regards,
Petr
