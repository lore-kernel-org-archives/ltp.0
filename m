Return-Path: <ltp-list-bounces@lists.sourceforge.net>
From: Ric White <richard.white@hp.com>
In-Reply-To: <364299f40908251716w38d8570esa60e08eaa6b7064d@mail.gmail.com>
References: <364299f40908191611x4accc24yc36b344956c7a40c@mail.gmail.com>
	<1251162918.4388.33.camel@OSLORic>
	<41008.95.24.171.156.1251178978.squirrel@mail.pigeonpoint.com>
	<1251213123.7108.8.camel@orthanc> <op.uy74unolo8angs@localhost>
	<1251222135.7108.16.camel@orthanc>
	<364299f40908251716w38d8570esa60e08eaa6b7064d@mail.gmail.com>
Content-Type: multipart/mixed; boundary="=-LzaxikfTICOpcNsCsWhZ"
Date: Wed, 26 Aug 2009 18:51:56 -0600
Message-Id: <1251334316.4388.64.camel@OSLORic>
Mime-Version: 1.0
Subject: Re: [LTP] [Openhpi-devel]   [PATCH] Cross-compile configure bug
Reply-To: richard.white@hp.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "openhpi-devel@lists.sourceforge.net" <openhpi-devel@lists.sourceforge.net>, Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>, "Khan,  Shuah" <shuah.khan@hp.com>


--=-LzaxikfTICOpcNsCsWhZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I really like Shuah's idea for a configuration parameter to allow this.

Garrett, could you try the attached patch and let us know if it works
for you? If you call configure with a --enable-non32bit-int parameter
now, a warning message will be generated and the build will be allowed
on targets where ints are not 32 bits.

Best Regards,
Ric



On Wed, 2009-08-26 at 00:16 +0000, Garrett Cooper wrote:
> On Tue, Aug 25, 2009 at 10:42 AM, Shuah Khan<shuah.khan@hp.com> wrote:
> > On Tue, 2009-08-25 at 15:19 +0000, Anton Pak wrote:
> >> I tried many times OpenHPI on x86_64.
> >> It worked fine in the configurations x86 client - x86_64 daemon and x86_64
> >> client - x86 daemon.
> >> However, the functioning on non-x86 64-bit platform or on Itanium is still
> >> an open question for me.
> >>
> >>       Anton Pak
> >
> > Instead of changing the error to a warning, itcould be controlled via a
> > config option, so this error could be ignored on certain architectures
> > using this config tune.
> >
> > -- Shuah
> >>
> >> On Tue, 25 Aug 2009 19:12:03 +0400, Shuah Khan <shuah.khan@hp.com> wrote:
> >>
> >> > On Tue, 2009-08-25 at 05:42 +0000, anton.pak@pigeonpoint.com wrote:
> >> >> Hello!
> >> >>
> >> >> We have the following lines in include/SaHpi.h:
> >> >>
> >> >> typedef unsigned char     SaHpiUint8T;
> >> >> typedef unsigned short    SaHpiUint16T;
> >> >> typedef unsigned int      SaHpiUint32T;
> >> >> typedef signed char       SaHpiInt8T;
> >> >> typedef signed short      SaHpiInt16T;
> >> >> typedef signed int        SaHpiInt32T;
> >> >>
> >> >> Also I suspect there can be marshalling issues, i.e. when
> >> >> daemon on platform with sizeof(int) == 4 but library is not and vice
> >> >> versa.
> >> >>
> >> >>    Anton Pak
> >> >
> >> > The proposed fix might help compile OpenHpi on a 64-bit platform,
> >> > however I agree with the concerns from others that we will see run-time
> >> > issues. Running 32-bit binary and libraries on a 64-bit platform might
> >> > be an option.
> >> >
> >> > -- Shuah
> >> >
> >> >
> >> >>
> >> >>
> >> >> > Hi Garrett,
> >> >> >
> >> >> > I was wondering about your addition of the cross_compiling test. If
> >> >> > there is OpenHPI code that may behave badly on a system where an int
> >> >> > isn't 4 bytes, I'm thinking that a warning should be issued even for a
> >> >> > cross compile to such an architecture as well. Like:
> >> >> >
> >> >> > if test "x$OH_SIZEOF_INT" != "x4"; then
> >> >> >     AC_MSG_WARN([
> >> >> > *** int is not 4 bytes, it is $OH_SIZEOF_INT bytes on this platform
> >> >> > *** undefined behavior may result from this.
> >> >> > ])
> >> >> > fi
> >> >> >
> >> >> > Will having a warning instead of an error cause problems for LTP when
> >> >> > cross compiling?
> >> >> >
> >> >> > Does anyone else in the OpenHPI community oppose changing this error
> >> >> to
> >> >> > a warning?
> >> >> >
> >> >> > Best Regards,
> >> >> > Ric White
> >> >> >
> >> >> >
> >> >> > On Wed, 2009-08-19 at 23:11 +0000, Garrett Cooper wrote:
> >> >> >> Hi,
> >> >> >>     Found this bug while trying to cross-compile with the
> >> >> >> openhpi-test-suite in LTP, and made the ERROR into WARN. Please fix
> >> >> >> this item as per the attached patch.
> >> >> >> Thanks,
> >> >> >> -Garrett
> >> >> >>
> >> >> >> PS Please CC my address in all correspondence w.r.t. this email
> >> >> thread.
> >> >> >>
> >> >> >> Summary:
> >> >> >>
> >> >> >> 1. int != 4 shouldn't be checked for while cross-compiling.
> >> >> >> 2. Warn instead of erroring out, because we have a _lot_ of 64-bit
> >> >> >> platforms that we test on which will be negatively impacted by this
> >> >> >> check.
> >> >> >>
> >> >> >> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
> >> >> >>
> >> >> >> ---
> >> >> >>
> >> >> /nfs.mac/ltp-upgrade/contrib/ltp/src/testcases/open_hpi_testsuite//configure.ac.orig       2009-08-19
> >> >> >> 16:04:08.000000000 -0700
> >> >> >> +++
> >> >> >>
> >> >> /nfs.mac/ltp-upgrade/contrib/ltp/src/testcases/open_hpi_testsuite//configure.ac    2009-08-19
> >> >> >> 16:10:47.000000000 -0700
> >> >> >> @@ -44,14 +44,13 @@
> >> >> >>  AC_PROG_LN_S
> >> >> >>  AC_PROG_MAKE_SET
> >> >> >>
> >> >> >> -dnl die on int != 32bits.  This is too instrumental to our code
> >> >> right
> >> >> >> now.
> >> >> >> +dnl Warn when int != 32bits.  This is too instrumental to our code
> >> >> >> right now.
> >> >> >>  dnl AC_MSG_CHECKING(int is 4 bytes)
> >> >> >>  OH_SET_SIZES
> >> >> >> -if test "x$OH_SIZEOF_INT" != "x4"; then
> >> >> >> -    AC_MSG_ERROR([
> >> >> >> +if test x$cross_compiling != xyes && test "x$OH_SIZEOF_INT" != "x4";
> >> >> >> then
> >> >> >> +    AC_MSG_WARN([
> >> >> >>  *** int is not 4 bytes, it is $OH_SIZEOF_INT bytes on this platform
> >> >> >> -*** undefined behavior will result
> >> >> >> -*** please contact the openhpi development team to fix this
> >> >> >> +*** undefined behavior may result from this.
> >> >> >>  ])
> >> >> >>  fi
> 
> Shuah,
>     Whichever way you find necessary is fine as long as it doesn't
> break builds and there are sufficient warnings at both buildtime and
> at runtime that say `Hey -- this code might not work because of
> integer sizing issues!' so you guys can cover yourself from FAQ-like
> questions as much as possible :).
> Thanks,
> -Garrett
> 
> ------------------------------------------------------------------------------
> Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
> trial. Simplify your report design, integration and deployment - and focus on 
> what you do best, core application coding. Discover what's new with 
> Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> _______________________________________________
> Openhpi-devel mailing list
> Openhpi-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openhpi-devel

--=-LzaxikfTICOpcNsCsWhZ
Content-Disposition: attachment; filename="non32_enable.patch"
Content-Type: text/x-patch; name="non32_enable.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

--- configure.ac	2009-08-26 18:34:15.000000000 -0600
+++ configure.ac.non32	2009-08-26 18:33:06.000000000 -0600
@@ -44,15 +44,32 @@
 AC_PROG_LN_S
 AC_PROG_MAKE_SET
 
+enabled_non32bit="no"
+AC_ARG_ENABLE([non32bit-int],
+    [  --enable-non32bit-int   Allow compile on non 32bit int architectures [[default=no]]],
+    [if test "x$enableval" = "xyes"; then
+        enabled_non32bit="yes"
+    fi])
+
 dnl die on int != 32bits.  This is too instrumental to our code right now.
 dnl AC_MSG_CHECKING(int is 4 bytes)
 OH_SET_SIZES
 if test "x$OH_SIZEOF_INT" != "x4"; then
-    AC_MSG_ERROR([
-*** int is not 4 bytes, it is $OH_SIZEOF_INT bytes on this platform
-*** undefined behavior will result
-*** please contact the openhpi development team to fix this
-])
+    if test "x$enabled_non32bit" = "xyes"; then
+        AC_MSG_WARN([
+*** Size of int is not 4 bytes, it is $OH_SIZEOF_INT bytes on this platform.
+*** The --enable_non32bit_int arg has been used to force compilation regardless.
+*** Execution on this platform is not supported and could produce undefined
+*** behavior.
+        ])
+    else
+        AC_MSG_ERROR([
+*** Size of int is not 4 bytes, it is $OH_SIZEOF_INT bytes on this platform.
+*** Execution on this platform is not supported and could produce undefined
+*** behavior.
+*** Please contact the openhpi development team to fix this
+        ])
+    fi
 fi
 
 AM_CONDITIONAL(CROSS_COMPILATION, test x$cross_compiling = xyes)
@@ -164,7 +181,6 @@
 
 AM_CONDITIONAL(OPENHPID_STATIC, test x$openhpid_static = xyes)
 
-
 AC_ARG_ENABLE([clients],
     [  --enable-clients        build HPI client programs [[default=yes]]],
     [if test "x$enableval" = "xyes"; then

--=-LzaxikfTICOpcNsCsWhZ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--=-LzaxikfTICOpcNsCsWhZ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--=-LzaxikfTICOpcNsCsWhZ--


