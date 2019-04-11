From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 11 Apr 2019 07:51:14 +0200
Subject: [LTP] [PATCH v2 1/3] ima: Call test's cleanup inside
 ima_setup.sh cleanup
In-Reply-To: <1554944374.25614.25.camel@linux.ibm.com>
References: <20190405165225.27216-1-pvorel@suse.cz>
 <20190405165225.27216-2-pvorel@suse.cz>
 <1554944374.25614.25.camel@linux.ibm.com>
Message-ID: <20190411055114.GA23472@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi Mimi,

thanks for your comments.

...
> > +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> > @@ -20,7 +20,8 @@
> >  TST_TESTFUNC=3D"test"
> >  TST_SETUP_CALLER=3D"$TST_SETUP"
> >  TST_SETUP=3D"ima_setup"
> > -TST_CLEANUP=3D"${TST_CLEANUP:-ima_cleanup}"
> > +TST_CLEANUP_CALLER=3D"$TST_CLEANUP"
> > +TST_CLEANUP=3D"ima_cleanup"

> It seems to be working, but defining TST_SETUP and TST_CLEANUP after
> defining the respective _CALLER looks strange. =C2=A0The _CALLER's string
> must be empty.
TST_{SETUP,CALLER}_CALLER takes setup from the test.
It's IMHO cleaner way allowing tests to set their setup/cleanup functions a=
nd
not care that there is also some library setup/cleanup (kind of encapsulati=
on).

We already used this for setup, I wanted to have a same approach for both s=
etup
and cleanup. Sure I can instead add ima_setup/ima_cleanup into tests' setup=
/cleanup
functions, but both solutions are working and I consider encapsulation as a=
 benefit.
The only problematic thing would be if some test needed to run it's custom
cleanup *before* library one while other tests *after*. But that's not a ca=
se here.
We also use this approach in tst_net.sh [1].

> >  TST_NEEDS_TMPDIR=3D1
> >  TST_NEEDS_ROOT=3D1

> > @@ -95,6 +96,9 @@ ima_setup()
> >  ima_cleanup()
> >  {
> >  	local dir
> > +
> > +	[ -n "$TST_CLEANUP_CALLER" ] && $TST_CLEANUP_CALLER
> > +

> Is something else setting TST_CLEANUP_CALLER?


Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/lib/tst=
_net.sh#L11
