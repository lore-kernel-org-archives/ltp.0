Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1OnoOo-0002T3-9G
	for ltp-list@lists.sourceforge.net; Tue, 24 Aug 2010 07:58:26 +0000
Received: from out14.sjc.mx.trendmicro.com ([216.99.131.51])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OnoOm-0003J7-Lj
	for ltp-list@lists.sourceforge.net; Tue, 24 Aug 2010 07:58:26 +0000
Message-ID: <000001cb435e$6fd79fa0$4f86dee0$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 24 Aug 2010 16:31:58 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_16_32_00_Tuesday_August_24_2010_22514"
References: <000001cb3ea4$e05de680$a119b380$@co.jp>
	<AANLkTinPERZyV=Gq2RA_h5iWeQsu9bcHhEt_AVsg6XYq@mail.gmail.com>
In-Reply-To: <AANLkTinPERZyV=Gq2RA_h5iWeQsu9bcHhEt_AVsg6XYq@mail.gmail.com>
Content-Language: ja
Subject: Re: [LTP] [PATCH] fix two "2-1.c" tests of POSIX
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
To: 'Garrett Cooper' <yanegomi@gmail.com>, Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net, =?utf-8?B?55W25bqnIOWBpeW4gg==?= <toza@ryobi.co.jp>

This is a multi-part message in MIME format.

----=_NextPart_ST_16_32_00_Tuesday_August_24_2010_22514
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

=0D=0A=0D=0A>The tests need to be written to use only POSIX compliant APIs.=0D=
=0A=0D=0A>defining any _XXX_SOURCE after including any C library headers is=
 pointless...=0D=0A=0D=0AMy means was not good.=0D=0A=0D=0AThis test-set is=
 just for POSIX.=0D=0ABut, if "_GNU_SOURCE" is defined, unnecessary GNU fun=
ction irrelevant=20=0D=0Ato POSIX becomes effective.=0D=0AAnyhow, definitio=
n of "_GNU_SOURCE" is not necessary about following=20=0D=0Atwo test-sets ,=
 I think.=0D=0A  .../pthread_attr_setstack/2-1.c=0D=0A  .../pthread_attr_se=
tstacksize/2-1.c=0D=0A=0D=0AI removed "_GNU_SOURCE" definition from these t=
est-sets, and succeeded=20=0D=0Ato build and run.=0D=0A=0D=0A=0D=0ASigned-o=
ff-by: Tomonori Mitani <mitani@ryobi.co.jp>=0D=0A=0D=0A=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=0D=0A--- a/testcases/open_posix_testsuite/conformance/inter=
faces/pthread_attr_setstack/2-1.c=092010-08-23 07:02:43.000000000 +0900=0D=0A=
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_se=
tstack/2-1.c=092010-08-24 11:40:41.000000000 +0900=0D=0A@@ -15,9 +15,6 @@=0D=
=0A  */=0D=0A=20=0D=0A /* For pthread_getattr_np(3) -- not a POSIX complian=
t API. */=0D=0A-#ifndef _GNU_SOURCE=0D=0A-#define _GNU_SOURCE=0D=0A-#endif=0D=
=0A #include <sys/param.h>=0D=0A #include <errno.h>=0D=0A #include <limits.=
h>=0D=0A--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread=
_attr_setstacksize/2-1.c=092010-08-23 07:02:43.000000000 +0900=0D=0A+++ b/t=
estcases/open_posix_testsuite/conformance/interfaces/pthread_attr_setstacks=
ize/2-1.c=092010-08-24 11:43:19.000000000 +0900=0D=0A@@ -15,9 +15,6 @@=0D=0A=
  */=0D=0A=20=0D=0A /* For pthread_getattr_np(3) -- not a POSIX compliant A=
PI */=0D=0A-#ifndef _GNU_SOURCE=0D=0A-#define _GNU_SOURCE=0D=0A-#endif=0D=0A=
 #include <sys/param.h>=0D=0A #include <errno.h>=0D=0A #include <limits.h>=0D=
=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=0A=0D=0A=0D=0AThank you--=0D=0A=0D=
=0A=0D=0A-Tomonori Mitani=0D=0A=0D=0A> -----Original Message-----=0D=0A> Fr=
om: Garrett Cooper [mailto:yanegomi@gmail.com]=0D=0A> Sent: Wednesday, Augu=
st 18, 2010 4:25 PM=0D=0A> To: Mitani=0D=0A> Cc: ltp-list@lists.sourceforge=
=2Enet; =E7=95=B6=E5=BA=A7 =E5=81=A5=E5=B8=82=0D=0A> Subject: Re: [LTP] [PA=
TCH] fix two "2-1.c" tests of POSIX=0D=0A>=20=0D=0A> 2010/8/18 Mitani <mita=
ni@ryobi.co.jp>:=0D=0A> > Hi,=0D=0A> >=0D=0A> > I tried to build open_posix=
_testsuite testcases with latest git:=0D=0A> >   ltp-dev-e8ad463baada21fb19=
f4c06f7dcab75c420ae373.tar.gz=0D=0A> >=0D=0A> > Several testcases failed to=
 build.=0D=0A> > Two of them is as follows:=0D=0A> > ------------=0D=0A> > =
[...]=0D=0A> > conformance/interfaces/pthread_attr_setstack/2-1 compile FAI=
LED=0D=0A> > In file included from=0D=0A> > ../../../conformance/interfaces=
/pthread_attr_setstack/2-1.c:31:=0D=0A> > ../../../include/posixtest.h:14:2=
: error: #error "Contains=0D=0A> GNU-isms that=0D=0A> > need fixing."=0D=0A=
> > [...]=0D=0A> > conformance/interfaces/pthread_attr_setstacksize/2-1 com=
pile=0D=0A> FAILED=0D=0A> > In file included from=0D=0A> > ../../../conform=
ance/interfaces/pthread_attr_setstacksize/2-1.c:=0D=0A> 31:=0D=0A> > ../../=
=2E./include/posixtest.h:14:2: error: #error "Contains=0D=0A> GNU-isms that=0D=
=0A> > need fixing."=0D=0A> > [...]=0D=0A> > ------------=0D=0A> >=0D=0A> >=
 ".../pthread_attr_setstack/2-1.c" and ".../include/posixtest.h"=0D=0A> are=0D=
=0A> > as follows:=0D=0A> > ------------(.../pthread_attr_setstack/2-1.c)=0D=
=0A> > [...]=0D=0A> > #ifndef _GNU_SOURCE=0D=0A> > #define _GNU_SOURCE=0D=0A=
> > #endif=0D=0A> > #include <pthread.h>=0D=0A> > #include <limits.h>=0D=0A=
> > #include <stdio.h>=0D=0A> > #include <string.h>=0D=0A> > #include <stdl=
ib.h>=0D=0A> > #include <sys/param.h>=0D=0A> > #include <errno.h>=0D=0A> > =
#include <unistd.h>=0D=0A> > #include "posixtest.h"=0D=0A> > [...]=0D=0A> >=
 ------------=0D=0A> >=0D=0A> > ------------(posixtest.h)=0D=0A> > [...]=0D=
=0A> > #if defined(_GNU_SOURCE)=0D=0A> > #error "Contains GNU-isms that nee=
d fixing."=0D=0A> > #elif defined(_BSD_SOURCE)=0D=0A> > #error "Contains BS=
D-isms that need fixing."=0D=0A> > #endif=0D=0A> > [...]=0D=0A> > ---------=
---=0D=0A> >=0D=0A> > In above "2-1.c", "_GNU_SOURCE" is defined. After tha=
t,=0D=0A> "posixtest.h"=0D=0A> > is included.=0D=0A> > And, in "posixtest.h=
", if "_GNU_SOURCE" is defined, error occurs.=0D=0A> >=0D=0A> > If "#ifndef=
 _GNU_SOURCE" is arranged after a line of "posixtest.h",=0D=0A> > error doe=
sn't occur.=0D=0A> > I confirmed that build succeeded by this revision and =
the test=0D=0A> > became PASS.=0D=0A> >=0D=0A> > Another "2-1.c" is same as=
 above testcase.=0D=0A> >=0D=0A> >=0D=0A> > Signed-off-by: Tomonori Mitani =
<mitani@ryobi.co.jp>=0D=0A> >=0D=0A> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=
=0A> > ---=0D=0A> >=0D=0A> a/testcases/open_posix_testsuite/conformance/int=
erfaces/pthread_at=0D=0A> tr_setstac=0D=0A> > k/2-1.c 2010-08-18 07:18:35.0=
00000000 +0900=0D=0A> > +++=0D=0A> >=0D=0A> b/testcases/open_posix_testsuit=
e/conformance/interfaces/pthread_at=0D=0A> tr_setstac=0D=0A> > k/2-1.c 2010=
-08-18 15:43:16.000000000 +0900=0D=0A> > @@ -17,9 +17,6 @@=0D=0A> >  *     =
  provided by nptl, which is developed by Ulrich Drepper.=0D=0A> >  */=0D=0A=
> >=0D=0A> > -#ifndef _GNU_SOURCE=0D=0A> > -#define _GNU_SOURCE=0D=0A> > -#=
endif=0D=0A> >  #include <pthread.h>=0D=0A> >  #include <limits.h>=0D=0A> >=
  #include <stdio.h>=0D=0A> > @@ -30,6 +27,10 @@=0D=0A> >  #include <unistd=
=2Eh>=0D=0A> >  #include "posixtest.h"=0D=0A> >=0D=0A> > +#ifndef _GNU_SOUR=
CE=0D=0A> > +#define _GNU_SOURCE=0D=0A> > +#endif=0D=0A> > +=0D=0A> >  #def=
ine TEST "2-1"=0D=0A> >  #define FUNCTION "pthread_attr_setstack"=0D=0A> > =
 #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "=0D=0A> > =
---=0D=0A> >=0D=0A> a/testcases/open_posix_testsuite/conformance/interfaces=
/pthread_at=0D=0A> tr_setstac=0D=0A> > ksize/2-1.c     2010-08-18 07:18:35.=
000000000 +0900=0D=0A> > +++=0D=0A> >=0D=0A> b/testcases/open_posix_testsui=
te/conformance/interfaces/pthread_at=0D=0A> tr_setstac=0D=0A> > ksize/2-1.c=
     2010-08-18 15:44:56.000000000 +0900=0D=0A> > @@ -17,9 +17,6 @@=0D=0A> =
>  *       provided by nptl, which is developed by Ulrich Drepper.=0D=0A> >=
  */=0D=0A> >=0D=0A> > -#ifndef _GNU_SOURCE=0D=0A> > -#define _GNU_SOURCE=0D=
=0A> > -#endif=0D=0A> >  #include <pthread.h>=0D=0A> >  #include <limits.h>=0D=
=0A> >  #include <stdio.h>=0D=0A> > @@ -30,6 +27,10 @@=0D=0A> >  #include <=
unistd.h>=0D=0A> >  #include "posixtest.h"=0D=0A> >=0D=0A> > +#ifndef _GNU_=
SOURCE=0D=0A> > +#define _GNU_SOURCE=0D=0A> > +#endif=0D=0A> > +=0D=0A> >  =
#define TEST "2-1"=0D=0A> >  #define FUNCTION "pthread_attr_setstacksize"=0D=
=0A> >  #define ERROR_PREFIX "unexpected error: " FUNCTION " " TEST ": "=0D=
=0A>=20=0D=0A> This is intentional :). The tests need to be written to use =
only POSIX=0D=0A> compliant APIs. Otherwise, it isn't truly POSIX compliant=
=2E=0D=0A>=20=0D=0A> Thanks,=0D=0A> -Garrett=0D=0A
----=_NextPart_ST_16_32_00_Tuesday_August_24_2010_22514
Content-Type: application/octet-stream;
	name="2-1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="2-1.patch"

--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_attr_se=
tstack/2-1.c=092010-08-23 07:02:43.000000000 +0900=0A+++ b/testcases/open_p=
osix_testsuite/conformance/interfaces/pthread_attr_setstack/2-1.c=092010-08=
-24 11:40:41.000000000 +0900=0A@@ -15,9 +15,6 @@=0A  */=0A =0A /* For pthre=
ad_getattr_np(3) -- not a POSIX compliant API. */=0A-#ifndef _GNU_SOURCE=0A=
-#define _GNU_SOURCE=0A-#endif=0A #include <sys/param.h>=0A #include <errno=
=2Eh>=0A #include <limits.h>=0A--- a/testcases/open_posix_testsuite/conform=
ance/interfaces/pthread_attr_setstacksize/2-1.c=092010-08-23 07:02:43.00000=
0000 +0900=0A+++ b/testcases/open_posix_testsuite/conformance/interfaces/pt=
hread_attr_setstacksize/2-1.c=092010-08-24 11:43:19.000000000 +0900=0A@@ -1=
5,9 +15,6 @@=0A  */=0A =0A /* For pthread_getattr_np(3) -- not a POSIX comp=
liant API */=0A-#ifndef _GNU_SOURCE=0A-#define _GNU_SOURCE=0A-#endif=0A #in=
clude <sys/param.h>=0A #include <errno.h>=0A #include <limits.h>=0A
----=_NextPart_ST_16_32_00_Tuesday_August_24_2010_22514
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
Be part of this innovative community and reach millions of netbook users 
worldwide. Take advantage of special opportunities to increase revenue and 
speed time-to-market. Join now, and jumpstart your future.
http://p.sf.net/sfu/intel-atom-d2d
----=_NextPart_ST_16_32_00_Tuesday_August_24_2010_22514
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_16_32_00_Tuesday_August_24_2010_22514--

