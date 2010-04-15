Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1O2DR3-0006zb-MQ
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 01:00:01 +0000
Received: from out07.sjc.mx.trendmicro.com ([216.99.131.23])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O2DR0-0006dX-Sd
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 01:00:01 +0000
Message-ID: <001301cadc36$77e08cf0$67a1a6d0$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 15 Apr 2010 09:56:22 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_09_56_24_Thursday_April_15_2010_12141"
References: <000001cadad6$c061c590$412550b0$@co.jp>	
	<4BC487C9.9080300@xenotime.net>	
	<000901cadb78$a2d05080$e870f180$@co.jp>	
	<g2p364299f41004132317v539c2b02g3eea49dc830cea0f@mail.gmail.com>	
	<000601cadbb0$9fb8b5d0$df2a2170$@co.jp>
	<p2y364299f41004140230u4e312ea7y7623fce2dbfd0ba6@mail.gmail.com>
In-Reply-To: <p2y364299f41004140230u4e312ea7y7623fce2dbfd0ba6@mail.gmail.com>
Content-Language: ja
Subject: Re: [LTP] [PATCH] fix "hugetlb" several tests
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
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, kamimura@ryobi.co.jp

This is a multi-part message in MIME format.

----=_NextPart_ST_09_56_24_Thursday_April_15_2010_12141
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

=0D=0A> -----Original Message-----=0D=0A> From: Garrett Cooper [mailto:yane=
gomi@gmail.com]=0D=0A> Sent: Wednesday, April 14, 2010 6:31 PM=0D=0A> To: M=
itani=0D=0A> Cc: ltp-list@lists.sourceforge.net=0D=0A> Subject: Re: [LTP] [=
PATCH] fix "hugetlb" several tests=0D=0A>=20=0D=0A> On Wed, Apr 14, 2010 at=
 1:58 AM, Mitani <mitani@ryobi.co.jp> wrote:=0D=0A> >> -----Original Messag=
e-----=0D=0A> >> From: Garrett Cooper [mailto:yanegomi@gmail.com]=0D=0A> >>=
 Sent: Wednesday, April 14, 2010 3:18 PM=0D=0A> >> To: Mitani=0D=0A> >> Cc:=
 Randy Dunlap; ltp-list@lists.sourceforge.net=0D=0A> >> Subject: Re: [LTP] =
[PATCH] fix "hugetlb" several tests=0D=0A> >>=0D=0A> >> On Tue, Apr 13, 201=
0 at 7:17 PM, Mitani <mitani@ryobi.co.jp> wrote:=0D=0A> >> > Hi Randy,=0D=0A=
> >> >=0D=0A> >> > I couldn't notice a misspelling. Sorry.=0D=0A> >> > I de=
cided to use "due to" according to your advice.=0D=0A> >> >=0D=0A> >> > May=
 I suggest revised patch=3F=0D=0A> >> >=0D=0A> > [...]=0D=0A> >> >=0D=0A> >=
> > Thank you--=0D=0A> >> >=0D=0A> >> > -Tomonori Mitani=0D=0A> >> >=0D=0A>=
 >> >=0D=0A> >> >> -----Original Message-----=0D=0A> >> >> From: Randy Dunl=
ap [mailto:rdunlap@xenotime.net]=0D=0A> >> >> Sent: Wednesday, April 14, 20=
10 12:04 AM=0D=0A> >> >> To: Mitani=0D=0A> >> >> Cc: ltp-list@lists.sourcef=
orge.net=0D=0A> >> >> Subject: Re: [LTP] [PATCH] fix "hugetlb" several test=
s=0D=0A> >> >>=0D=0A> >> >> On 04/12/10 23:58, Mitani wrote:=0D=0A> >> >> >=
 ------------=0D=0A> >> >> > =A0a) All tests:=0D=0A> >> >> > "TBROK =A0: =A0=
Test cannot be continued owning to sufficient=0D=0A> >> >> availability of=0D=
=0A> >> >> > Hugepages on the system"=0D=0A> >> >> >=0D=0A> >> >> > =A0b) 2=
), 3), 5), 6), 8), 10), 11) tests:=0D=0A> >> >> > "TWARN =A0: =A0tst_rmdir(=
): TESTDIR was NULL; no removal=0D=0A> attempted"=0D=0A> >> >> > ----------=
--=0D=0A> >> >> >=0D=0A> >> >> > Both case a) and case b) are caused by the=
 same reason.=0D=0A> >> >> >=0D=0A> >> >> > All of case a) failures occured=
 at the following points (for=0D=0A> >> example=0D=0A> >> >> > hugemmap04):=0D=
=0A> >> >> > ------------<hugemmap04.c - main()>=0D=0A> >> >> > =A0 =A0 =A0=
 =A0 /* Check number of hugepages */=0D=0A> >> >> > =A0 =A0 =A0 =A0 if (get=
_no_of_hugepages() <=3D 0 || hugepages_size()=0D=0A> <=3D=0D=0A> >> 0)=0D=0A=
> >> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tst_brkm(TBROK, cleanup, "Test ca=
nnot be=0D=0A> >> continued=0D=0A> >> >> owning to=0D=0A> >> >> > \=0D=0A> =
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suf=
ficient availability=0D=0A> of=0D=0A> >> >> Hugepages on the=0D=0A> >> >> >=
 system");=0D=0A> >> >> > ------------=0D=0A> >> >> >=0D=0A> >> >> > I foun=
d out that "HugePages_Total" parameter of "/proc/meminfo"=0D=0A> >> file=0D=
=0A> >> >> > is set to "0". This caused above TBROK failure. It is environm=
ent=0D=0A> >> >> problem.=0D=0A> >> >> >=0D=0A> >> >> > But, in this case, =
tests must not return with TBROK, but with=0D=0A> TCONF,=0D=0A> >> >> > I t=
hink.=0D=0A> >> >>=0D=0A> >> >> That makes sense to me.=0D=0A> >> >>=0D=0A>=
 >> >> > And, in case b), these tests try to delete "TESTDIR" directory=0D=0A=
> >> by=0D=0A> >> >> > calling "tst_rmdir()" function in "cleanup()" functi=
on.=0D=0A> >> >> > But, "TESTDIR" never set if "tst_tmpdir()" function isn'=
t=0D=0A> called.=0D=0A> >> >> > I think that case b)'s tests must not call =
cleanup() function.=0D=0A> >> >> >=0D=0A> >> >> >=0D=0A> >> >> > I want to =
suggest following patch.=0D=0A> >> >> >=0D=0A> >> >> > Signed-off-by: Tomon=
ori Mitani <mitani@ryobi.co.jp>=0D=0A>=20=0D=0A>     Sorry to ask again, bu=
t Gmail always mangles patches. Could you=0D=0A> please attach it as a file=
=3F=0D=0A> Thanks,=0D=0A> -Garrett=0D=0A=0D=0A=0D=0ASorry.=0D=0AI attach a =
patch file.=0D=0A=0D=0A=0D=0ASigned-off-by: Tomonori Mitani <mitani@ryobi.c=
o.jp>=0D=0A=0D=0A=0D=0ARegards--=0D=0A=0D=0A-Tomonori Mitani=0D=0A
----=_NextPart_ST_09_56_24_Thursday_April_15_2010_12141
Content-Type: application/octet-stream;
	name="hugetlb.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hugetlb.patch"

--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c=092010-04-01 15:23=
:09.000000000 +0900=0A+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap0=
4.c=092010-04-14 16:40:25.000000000 +0900=0A@@ -127,8 +127,7 @@=0A =0A =09/=
* Check number of hugepages */=0A =09if (get_no_of_hugepages() <=3D 0 || hu=
gepages_size() <=3D 0)=0A-=09=09tst_brkm(TBROK, cleanup, "Test cannot be co=
ntinued owning to \=0A-=09=09=09=09sufficient availability of Hugepages on =
the system");=0A+=09=09tst_brkm(TCONF, cleanup, "Not enough available Hugep=
ages");=0A =0A =09/* Perform global setup for test */=0A =09setup();=0A--- =
a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c=092010-04-01 15:23:0=
9.000000000 +0900=0A+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat0=
1.c=092010-04-14 16:48:54.000000000 +0900=0A@@ -105,7 +105,7 @@=0A =09}=0A =
=0A         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=0A=
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to =
sufficient availability of Hugepages on the system");=0A+             tst_b=
rkm(TCONF, tst_exit, "Not enough available Hugepages");=0A         else    =
         =0A              huge_pages_shm_to_be_allocated =3D ( get_no_of_hu=
gepages() * hugepages_size() * 1024) / 2 ;=0A =0A--- a/testcases/kernel/mem=
/hugetlb/hugeshmat/hugeshmat02.c=092010-04-01 15:23:09.000000000 +0900=0A++=
+ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat02.c=092010-04-14 16:49=
:15.000000000 +0900=0A@@ -102,7 +102,7 @@=0A =09}=0A =0A         if ( get_n=
o_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=0A-             tst_br=
km(TBROK, cleanup, "Test cannot be continued owning to sufficient availabil=
ity of Hugepages on the system");=0A+             tst_brkm(TCONF, tst_exit,=
 "Not enough available Hugepages");=0A         else             =0A        =
      huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages() * hugepage=
s_size() * 1024) / 2 ;=0A =0A--- a/testcases/kernel/mem/hugetlb/hugeshmat/h=
ugeshmat03.c=092010-04-01 15:23:09.000000000 +0900=0A+++ b/testcases/kernel=
/mem/hugetlb/hugeshmat/hugeshmat03.c=092010-04-14 16:49:31.000000000 +0900=0A=
@@ -86,7 +86,7 @@=0A =09}=0A =0A         if ( get_no_of_hugepages() <=3D 0 =
|| hugepages_size() <=3D 0 )=0A-             tst_brkm(TBROK, cleanup, "Test=
 cannot be continued owning to sufficient availability of Hugepages on the =
system");=0A+             tst_brkm(TCONF, cleanup, "Not enough available Hu=
gepages");=0A         else             =0A              huge_pages_shm_to_b=
e_allocated =3D ( get_no_of_hugepages() * hugepages_size() * 1024) / 2 ;=0A=
 =0A--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c=092010-04-=
01 15:23:09.000000000 +0900=0A+++ b/testcases/kernel/mem/hugetlb/hugeshmctl=
/hugeshmctl01.c=092010-04-14 16:50:16.000000000 +0900=0A@@ -130,7 +130,7 @@=
=0A =09}=0A =0A         if ( get_no_of_hugepages() <=3D 0 || hugepages_size=
() <=3D 0 )=0A-             tst_brkm(TBROK, cleanup, "Test cannot be contin=
ued owning to sufficient availability of Hugepages on the system");=0A+    =
         tst_brkm(TCONF, tst_exit, "Not enough available Hugepages");=0A   =
      else             =0A              huge_pages_shm_to_be_allocated =3D =
( get_no_of_hugepages() * hugepages_size() * 1024) / 2 ;=0A =0A--- a/testca=
ses/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c=092010-04-01 15:23:09.0000=
00000 +0900=0A+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c=09=
2010-04-14 16:50:28.000000000 +0900=0A@@ -102,7 +102,7 @@=0A =09}=0A =0A   =
      if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=0A-   =
          tst_brkm(TBROK, cleanup, "Test cannot be continued owning to suff=
icient availability of Hugepages on the system");=0A+             tst_brkm(=
TCONF, tst_exit, "Not enough available Hugepages");=0A         else        =
     =0A              huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepa=
ges() * hugepages_size() * 1024) / 2 ;=0A =0A--- a/testcases/kernel/mem/hug=
etlb/hugeshmctl/hugeshmctl03.c=092010-04-01 15:23:09.000000000 +0900=0A+++ =
b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c=092010-04-14 16:50=
:40.000000000 +0900=0A@@ -105,7 +105,7 @@=0A =09}=0A =0A         if ( get_n=
o_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=0A-             tst_br=
km(TBROK, cleanup, "Test cannot be continued owning to sufficient availabil=
ity of Hugepages on the system");=0A+             tst_brkm(TCONF, cleanup, =
"Not enough available Hugepages");=0A         else             =0A         =
     huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages() * hugepages=
_size() * 1024) / 2 ;=0A =0A--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hu=
geshmdt01.c=092010-04-01 15:23:09.000000000 +0900=0A+++ b/testcases/kernel/=
mem/hugetlb/hugeshmdt/hugeshmdt01.c=092010-04-14 16:51:11.000000000 +0900=0A=
@@ -87,7 +87,7 @@=0A =09}=0A =0A         if ( get_no_of_hugepages() <=3D 0 =
|| hugepages_size() <=3D 0 )=0A-             tst_brkm(TBROK, cleanup, "Test=
 cannot be continued owning to sufficient availability of Hugepages on the =
system");=0A+             tst_brkm(TCONF, tst_exit, "Not enough available H=
ugepages");=0A         else             =0A              huge_pages_shm_to_=
be_allocated =3D ( get_no_of_hugepages() * hugepages_size() * 1024) / 2 ;=0A=
 =0A--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c=092010-04-=
01 15:23:09.000000000 +0900=0A+++ b/testcases/kernel/mem/hugetlb/hugeshmget=
/hugeshmget01.c=092010-04-14 16:51:34.000000000 +0900=0A@@ -82,7 +82,7 @@=0A=
 =0A =09/* The following loop checks looping state if -i option given */=0A=
         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=0A-=
             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to s=
ufficient availability of Hugepages on the system");=0A+             tst_br=
km(TCONF, cleanup, "Not enough available Hugepages");=0A         else      =
       =0A               huge_pages_shm_to_be_allocated =3D ( get_no_of_hug=
epages() * hugepages_size() * 1024) / 2 ;=0A         =0A--- a/testcases/ker=
nel/mem/hugetlb/hugeshmget/hugeshmget02.c=092010-04-01 15:23:09.000000000 +=
0900=0A+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c=092010-=
04-14 16:51:45.000000000 +0900=0A@@ -84,7 +84,7 @@=0A =09}=0A =0A         i=
f ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=0A-          =
   tst_brkm(TBROK, cleanup, "Test cannot be continued owning to sufficient =
availability of Hugepages on the system");=0A+             tst_brkm(TCONF, =
tst_exit, "Not enough available Hugepages");=0A         else             =0A=
              huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages() * =
hugepages_size() * 1024) / 2 ;=0A   =0A--- a/testcases/kernel/mem/hugetlb/h=
ugeshmget/hugeshmget03.c=092010-04-01 15:23:09.000000000 +0900=0A+++ b/test=
cases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c=092010-04-14 16:51:55.00=
0000000 +0900=0A@@ -85,7 +85,7 @@=0A =0A =09/* The following loop checks lo=
oping state if -i option given */=0A         if ( get_no_of_hugepages() <=3D=
 0 || hugepages_size() <=3D 0 )=0A-             tst_brkm(TBROK, cleanup, "T=
est cannot be continued owning to sufficient availability of Hugepages on t=
he system");=0A+             tst_brkm(TCONF, tst_exit, "Not enough availabl=
e Hugepages");=0A         else             =0A              huge_pages_shm_=
to_be_allocated =3D ( get_no_of_hugepages() * hugepages_size() * 1024) / 2 =
;=0A =0A--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c=092010=
-04-01 15:23:09.000000000 +0900=0A+++ b/testcases/kernel/mem/hugetlb/hugesh=
mget/hugeshmget05.c=092010-04-14 16:52:10.000000000 +0900=0A@@ -86,7 +86,7 =
@@=0A =09}=0A =0A         if ( get_no_of_hugepages() <=3D 0 || hugepages_si=
ze() <=3D 0 )=0A-             tst_brkm(TBROK, cleanup, "Test cannot be cont=
inued owning to sufficient availability of Hugepages on the system");=0A+  =
           tst_brkm(TCONF, cleanup, "Not enough available Hugepages");=0A  =
       else             =0A              huge_pages_shm_to_be_allocated =3D=
 ( get_no_of_hugepages() * hugepages_size() * 1024) / 2 ;=0A        =0A
----=_NextPart_ST_09_56_24_Thursday_April_15_2010_12141
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
----=_NextPart_ST_09_56_24_Thursday_April_15_2010_12141
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_09_56_24_Thursday_April_15_2010_12141--

