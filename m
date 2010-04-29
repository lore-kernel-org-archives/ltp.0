Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <serge@us.ibm.com>) id 1O7JQ0-0000qP-9W
	for ltp-list@lists.sourceforge.net; Thu, 29 Apr 2010 02:24:00 +0000
Received: from e34.co.us.ibm.com ([32.97.110.152])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O7JPw-0004Me-Ao
	for ltp-list@lists.sourceforge.net; Thu, 29 Apr 2010 02:24:00 +0000
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e34.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o3T2GaGD000547
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 20:16:36 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o3T2Nodn170824
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 20:23:50 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o3T2NoAM031616
	for <ltp-list@lists.sourceforge.net>; Wed, 28 Apr 2010 20:23:50 -0600
Date: Wed, 28 Apr 2010 19:25:30 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
Message-ID: <20100429002530.GA3923@us.ibm.com>
References: <20100428224750.GA25829@us.ibm.com>
	<x2w364299f41004281602h7256b1b8t9a9554cddee90e5d@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <x2w364299f41004281602h7256b1b8t9a9554cddee90e5d@mail.gmail.com>
Subject: Re: [LTP] [PATCH ltp] make filecaps tests succeed
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Quoting Garrett Cooper (yanegomi@gmail.com):
> On Wed, Apr 28, 2010 at 3:47 PM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> > Most of these are belated cleanup after the move to using /opt/ltp.
> > Also undoing an ill-advised replacement of return with tst_exit. =A0All
> > filecaps tests now succeed on fedora 10.
> >
> > Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> > ---
> > =A0testcases/kernel/security/filecaps/filecapstest.sh | =A0 =A09 ++++++=
---
> > =A0testcases/kernel/security/filecaps/print_caps.c =A0 =A0| =A0 =A03 ++-
> > =A0.../kernel/security/filecaps/verify_caps_exec.c =A0 =A0| =A0 19 ++++=
++++++++++-----
> > =A03 files changed, 22 insertions(+), 9 deletions(-)
> >
> > diff --git a/testcases/kernel/security/filecaps/filecapstest.sh b/testc=
ases/kernel/security/filecaps/filecapstest.sh
> > index 43582dc..6864de4 100755
> > --- a/testcases/kernel/security/filecaps/filecapstest.sh
> > +++ b/testcases/kernel/security/filecaps/filecapstest.sh
> > @@ -22,8 +22,11 @@
> > =A0echo "Running in:"
> > =A0#rm -f print_caps
> > =A0#cp $LTPROOT/testcases/bin/print_caps .
> > -mkfifo caps_fifo
> > -chmod 777 caps_fifo
> > +#FIFOFILE=3D"$LTPROOT/testcases/bin/caps_fifo"
> > +FIFOFILE=3D"/tmp/caps_fifo"
> =

> Why not
> =

> TMP=3D${TMP:=3D/tmp}
> $TMP/caps_fifo
> =

> etc? FWIW if you're in $TMP already, a lot of these changes aren't
> required, correct?

No objection - though then the definition of /tmp/caps_fifo below
needs to be changed as well.

> > +rm -f $FIFOFILE
> > +mkfifo $FIFOFILE
> > +chmod 777 $FIFOFILE
> > =A0exit_code=3D0
> > =A0echo "cap_sys_admin tests"
> > =A0verify_caps_exec 0
> > @@ -46,5 +49,5 @@ if [ $tmp -ne 0 ]; then
> > =A0 =A0 =A0 =A0exit_code=3D$tmp
> > =A0fi
> >
> > -unlink caps_fifo
> > +unlink $FIFOFILE
> > =A0exit $exit_code
> > diff --git a/testcases/kernel/security/filecaps/print_caps.c b/testcase=
s/kernel/security/filecaps/print_caps.c
> > index f0e9bce..b887738 100644
> > --- a/testcases/kernel/security/filecaps/print_caps.c
> > +++ b/testcases/kernel/security/filecaps/print_caps.c
> > @@ -36,7 +36,7 @@
> > =A0#include <sys/capability.h>
> > =A0#endif
> >
> > -#define FIFOFILE "caps_fifo"
> > +#define FIFOFILE "/tmp/caps_fifo"
> >
> > =A0int main(int argc, char *argv[])
> > =A0{
> > @@ -68,4 +68,5 @@ int main(int argc, char *argv[])
> > =A0#else
> > =A0 =A0 =A0 =A0return 0;
> > =A0#endif
> > + =A0 =A0 =A0 return 0;
> =

> What's the value returned for #if ..? If it's `return 0', then why not
> just remove the other two references in the preprocessor blocks?

There was no return in that case.  So really we can just get rid of
the #else altogether.

> > =A0}
> > diff --git a/testcases/kernel/security/filecaps/verify_caps_exec.c b/te=
stcases/kernel/security/filecaps/verify_caps_exec.c
> > index 5250007..7360d4a 100644
> > --- a/testcases/kernel/security/filecaps/verify_caps_exec.c
> > +++ b/testcases/kernel/security/filecaps/verify_caps_exec.c
> > @@ -43,7 +43,7 @@
> > =A0#include <sys/prctl.h>
> > =A0#include <test.h>
> >
> > -#define TSTPATH "./print_caps"
> > +#define TSTPATH "print_caps"
> =

> Ok.
> =

> > =A0char *TCID =3D "filecaps";
> > =A0int TST_TOTAL=3D1;
> >
> > @@ -70,7 +70,7 @@ void print_my_caps()
> > =A0 =A0 =A0 =A0cap_free(txt);
> > =A0}
> >
> > -int drop_root(int keep_perms)
> > +void drop_root(int keep_perms)
> > =A0{
> > =A0 =A0 =A0 =A0int ret;
> >
> > @@ -84,10 +84,19 @@ int drop_root(int keep_perms)
> > =A0 =A0 =A0 =A0}
> > =A0 =A0 =A0 =A0if (keep_perms) {
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cap_t cap =3D cap_from_text("=3Deip");
> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cap_set_proc(cap);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cap) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TBROK, "cap_from=
_text failed\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D cap_set_proc(cap);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret < 0) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 perror(cap_set_proc);
> =

> Why??? This could potentially fubar errno too...

The perror doesn't need to be there.

> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_resm(TBROK | TERRNO, =
"cap_set_proc failed\n");
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_exit();
> =

> tst_brkm(TBROK | TERRNO, tst_exit, "cap_set..."); is better
> =

> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cap_free(cap);
> > =A0 =A0 =A0 =A0}
> > - =A0 =A0 =A0 tst_exit();
> > =A0}
> >
> > =A0int perms_test(void)
> > @@ -114,7 +123,7 @@ int perms_test(void)
> > =A0 =A0 =A0 =A0return ret;
> > =A0}
> >
> > -#define FIFOFILE "caps_fifo"
> > +#define FIFOFILE "/tmp/caps_fifo"
> > =A0void create_fifo(void)
> > =A0{
> > =A0 =A0 =A0 =A0int ret;
> > --
> > 1.6.0.6

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
