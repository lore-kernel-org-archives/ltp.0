Return-Path: <ltp-list-bounces@lists.sourceforge.net>
MIME-Version: 1.0
In-Reply-To: <1251222135.7108.16.camel@orthanc>
References: <364299f40908191611x4accc24yc36b344956c7a40c@mail.gmail.com>
	<1251162918.4388.33.camel@OSLORic>
	<41008.95.24.171.156.1251178978.squirrel@mail.pigeonpoint.com>
	<1251213123.7108.8.camel@orthanc> <op.uy74unolo8angs@localhost>
	<1251222135.7108.16.camel@orthanc>
Date: Tue, 25 Aug 2009 17:16:40 -0700
Message-ID: <364299f40908251716w38d8570esa60e08eaa6b7064d@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [Openhpi-devel] [PATCH] Cross-compile configure bug
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
To: Shuah Khan <shuah.khan@hp.com>
Cc: "openhpi-devel@lists.sourceforge.net" <openhpi-devel@lists.sourceforge.net>, LTP list <ltp-list@lists.sourceforge.net>

On Tue, Aug 25, 2009 at 10:42 AM, Shuah Khan<shuah.khan@hp.com> wrote:
> On Tue, 2009-08-25 at 15:19 +0000, Anton Pak wrote:
>> I tried many times OpenHPI on x86_64.
>> It worked fine in the configurations x86 client - x86_64 daemon and x86_=
64
>> client - x86 daemon.
>> However, the functioning on non-x86 64-bit platform or on Itanium is sti=
ll
>> an open question for me.
>>
>> =A0 =A0 =A0 Anton Pak
>
> Instead of changing the error to a warning, itcould be controlled via a
> config option, so this error could be ignored on certain architectures
> using this config tune.
>
> -- Shuah
>>
>> On Tue, 25 Aug 2009 19:12:03 +0400, Shuah Khan <shuah.khan@hp.com> wrote:
>>
>> > On Tue, 2009-08-25 at 05:42 +0000, anton.pak@pigeonpoint.com wrote:
>> >> Hello!
>> >>
>> >> We have the following lines in include/SaHpi.h:
>> >>
>> >> typedef unsigned char =A0 =A0 SaHpiUint8T;
>> >> typedef unsigned short =A0 =A0SaHpiUint16T;
>> >> typedef unsigned int =A0 =A0 =A0SaHpiUint32T;
>> >> typedef signed char =A0 =A0 =A0 SaHpiInt8T;
>> >> typedef signed short =A0 =A0 =A0SaHpiInt16T;
>> >> typedef signed int =A0 =A0 =A0 =A0SaHpiInt32T;
>> >>
>> >> Also I suspect there can be marshalling issues, i.e. when
>> >> daemon on platform with sizeof(int) =3D=3D 4 but library is not and v=
ice
>> >> versa.
>> >>
>> >> =A0 =A0Anton Pak
>> >
>> > The proposed fix might help compile OpenHpi on a 64-bit platform,
>> > however I agree with the concerns from others that we will see run-time
>> > issues. Running 32-bit binary and libraries on a 64-bit platform might
>> > be an option.
>> >
>> > -- Shuah
>> >
>> >
>> >>
>> >>
>> >> > Hi Garrett,
>> >> >
>> >> > I was wondering about your addition of the cross_compiling test. If
>> >> > there is OpenHPI code that may behave badly on a system where an int
>> >> > isn't 4 bytes, I'm thinking that a warning should be issued even fo=
r a
>> >> > cross compile to such an architecture as well. Like:
>> >> >
>> >> > if test "x$OH_SIZEOF_INT" !=3D "x4"; then
>> >> > =A0 =A0 AC_MSG_WARN([
>> >> > *** int is not 4 bytes, it is $OH_SIZEOF_INT bytes on this platform
>> >> > *** undefined behavior may result from this.
>> >> > ])
>> >> > fi
>> >> >
>> >> > Will having a warning instead of an error cause problems for LTP wh=
en
>> >> > cross compiling?
>> >> >
>> >> > Does anyone else in the OpenHPI community oppose changing this error
>> >> to
>> >> > a warning?
>> >> >
>> >> > Best Regards,
>> >> > Ric White
>> >> >
>> >> >
>> >> > On Wed, 2009-08-19 at 23:11 +0000, Garrett Cooper wrote:
>> >> >> Hi,
>> >> >> =A0 =A0 Found this bug while trying to cross-compile with the
>> >> >> openhpi-test-suite in LTP, and made the ERROR into WARN. Please fix
>> >> >> this item as per the attached patch.
>> >> >> Thanks,
>> >> >> -Garrett
>> >> >>
>> >> >> PS Please CC my address in all correspondence w.r.t. this email
>> >> thread.
>> >> >>
>> >> >> Summary:
>> >> >>
>> >> >> 1. int !=3D 4 shouldn't be checked for while cross-compiling.
>> >> >> 2. Warn instead of erroring out, because we have a _lot_ of 64-bit
>> >> >> platforms that we test on which will be negatively impacted by this
>> >> >> check.
>> >> >>
>> >> >> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>> >> >>
>> >> >> ---
>> >> >>
>> >> /nfs.mac/ltp-upgrade/contrib/ltp/src/testcases/open_hpi_testsuite//co=
nfigure.ac.orig =A0 =A0 =A0 2009-08-19
>> >> >> 16:04:08.000000000 -0700
>> >> >> +++
>> >> >>
>> >> /nfs.mac/ltp-upgrade/contrib/ltp/src/testcases/open_hpi_testsuite//co=
nfigure.ac =A0 =A02009-08-19
>> >> >> 16:10:47.000000000 -0700
>> >> >> @@ -44,14 +44,13 @@
>> >> >> =A0AC_PROG_LN_S
>> >> >> =A0AC_PROG_MAKE_SET
>> >> >>
>> >> >> -dnl die on int !=3D 32bits. =A0This is too instrumental to our co=
de
>> >> right
>> >> >> now.
>> >> >> +dnl Warn when int !=3D 32bits. =A0This is too instrumental to our=
 code
>> >> >> right now.
>> >> >> =A0dnl AC_MSG_CHECKING(int is 4 bytes)
>> >> >> =A0OH_SET_SIZES
>> >> >> -if test "x$OH_SIZEOF_INT" !=3D "x4"; then
>> >> >> - =A0 =A0AC_MSG_ERROR([
>> >> >> +if test x$cross_compiling !=3D xyes && test "x$OH_SIZEOF_INT" !=
=3D "x4";
>> >> >> then
>> >> >> + =A0 =A0AC_MSG_WARN([
>> >> >> =A0*** int is not 4 bytes, it is $OH_SIZEOF_INT bytes on this plat=
form
>> >> >> -*** undefined behavior will result
>> >> >> -*** please contact the openhpi development team to fix this
>> >> >> +*** undefined behavior may result from this.
>> >> >> =A0])
>> >> >> =A0fi

Shuah,
    Whichever way you find necessary is fine as long as it doesn't
break builds and there are sufficient warnings at both buildtime and
at runtime that say `Hey -- this code might not work because of
integer sizing issues!' so you guys can cover yourself from FAQ-like
questions as much as possible :).
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
