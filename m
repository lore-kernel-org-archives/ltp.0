Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1O2hnK-0007vB-DM
	for ltp-list@lists.sourceforge.net; Fri, 16 Apr 2010 09:25:02 +0000
Received: from out03.sjc.mx.trendmicro.com ([216.99.131.7])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O2hnI-0001rK-1G
	for ltp-list@lists.sourceforge.net; Fri, 16 Apr 2010 09:25:02 +0000
Message-ID: <000601cadd46$8a38d4f0$9eaa7ed0$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Fri, 16 Apr 2010 18:23:56 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_18_23_58_Friday_April_16_2010_3628"
References: <000001cadad6$c061c590$412550b0$@co.jp>	
	<4BC487C9.9080300@xenotime.net>	
	<000901cadb78$a2d05080$e870f180$@co.jp>	
	<g2p364299f41004132317v539c2b02g3eea49dc830cea0f@mail.gmail.com>	
	<000601cadbb0$9fb8b5d0$df2a2170$@co.jp>	
	<20100414081953.7356b407.rdunlap@xenotime.net>	
	<000001cadd0e$7b35e250$71a1a6f0$@co.jp>
	<w2l364299f41004152205ybf7a92eekb87553630949773a@mail.gmail.com>
In-Reply-To: <w2l364299f41004152205ybf7a92eekb87553630949773a@mail.gmail.com>
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

----=_NextPart_ST_18_23_58_Friday_April_16_2010_3628
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

=0D=0A> -----Original Message-----=0D=0A> From: Garrett Cooper [mailto:yane=
gomi@gmail.com]=0D=0A> Sent: Friday, April 16, 2010 2:06 PM=0D=0A> To: Mita=
ni=0D=0A> Cc: Randy Dunlap; ltp-list@lists.sourceforge.net=0D=0A> Subject: =
Re: [LTP] [PATCH] fix "hugetlb" several tests=0D=0A>=20=0D=0A> On Thu, Apr =
15, 2010 at 7:42 PM, Mitani <mitani@ryobi.co.jp> wrote:=0D=0A> >=0D=0A> >> =
-----Original Message-----=0D=0A> >> From: Randy Dunlap [mailto:rdunlap@xen=
otime.net]=0D=0A> >> Sent: Thursday, April 15, 2010 12:20 AM=0D=0A> >> To: =
Mitani=0D=0A> >> Cc: 'Garrett Cooper'; ltp-list@lists.sourceforge.net=0D=0A=
> >> Subject: Re: [LTP] [PATCH] fix "hugetlb" several tests=0D=0A> >>=0D=0A=
> >> On Wed, 14 Apr 2010 17:58:17 +0900 Mitani wrote:=0D=0A> >>=0D=0A> >> >=
 Hi,=0D=0A> >> >=0D=0A> >> > I suggest new patch.=0D=0A> >> >=0D=0A> >> > S=
igned-off-by: Tomonori Mitani <mitani@ryobi.co.jp>=0D=0A> >>=0D=0A> >> This=
 one is OK with me also, but...=0D=0A> >>=0D=0A> >> Is it possible to deter=
mine the difference between a kernel that=0D=0A> does=0D=0A> >> not support=
 hugepages at all and a kernel that does support hugepages=0D=0A> >> but ju=
st does not have enough of them allocated=3F=0D=0A> >>=0D=0A> >> or maybe w=
e don't care about this difference. =A0Do we=3F=0D=0A> >=0D=0A> > I cannot =
give a good opinion because I'm not a creator of these test=0D=0A> > progra=
ms, but ...=0D=0A> > I think that the difference of test refusal reason isn=
't so important.=0D=0A> > How about following message=3F :=0D=0A> > -------=
-----=0D=0A> > Not support Hugepages or not enough available Hugepages=0D=0A=
> > ------------=0D=0A> >=0D=0A> > If users read above message, they will e=
xamine a reason by themselves=0D=0A> > and will do appropriate measures (se=
t an enough hugepages value or=0D=0A> > gave up this test), I think.=0D=0A>=
=20=0D=0A>     It's fine as-is. `Zero [supported] hugepages' is the same as=
 `not=0D=0A> enough hugepages'. If people can't read the message, and put t=
ogether=0D=0A> the details based on what's in the test output versus the=0D=
=0A> documentation and the source code, they quite frankly shouldn't be=0D=0A=
> running the tests.=0D=0A> Thanks,=0D=0A> -Garrett=0D=0A=0D=0A=0D=0AI made=
 patch for both Hugepages non-support message and "tst_exit()"=20=0D=0Acall=
ing.=0D=0AI attach the patch as a file.=0D=0A=0D=0ASigned-off-by: Tomonori =
Mitani <mitani@ryobi.co.jp>=0D=0A=0D=0ARegards--=0D=0A=0D=0A-Tomonori Mitan=
i=0D=0A=0D=0A
----=_NextPart_ST_18_23_58_Friday_April_16_2010_3628
Content-Type: application/octet-stream;
	name="hugetlb.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="hugetlb.patch"

--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap04.c=092010-04-01 15:23=
:09.000000000 +0900=0D=0A+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemm=
ap04.c=092010-04-16 14:33:44.000000000 +0900=0D=0A@@ -127,8 +127,7 @@=0D=0A=
=20=0D=0A =09/* Check number of hugepages */=0D=0A =09if (get_no_of_hugepag=
es() <=3D 0 || hugepages_size() <=3D 0)=0D=0A-=09=09tst_brkm(TBROK, cleanup=
, "Test cannot be continued owning to \=0D=0A-=09=09=09=09sufficient availa=
bility of Hugepages on the system");=0D=0A+=09=09tst_brkm(TCONF, tst_exit, =
"Not support Hugepages or not enough available Hugepages");=0D=0A=20=0D=0A =
=09/* Perform global setup for test */=0D=0A =09setup();=0D=0A--- a/testcas=
es/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c=092010-04-01 15:23:09.0000000=
00 +0900=0D=0A+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat01.c=09=
2010-04-16 14:31:56.000000000 +0900=0D=0A@@ -105,7 +105,7 @@=0D=0A =09}=0D=0A=
=20=0D=0A         if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D=
 0 )=0D=0A-             tst_brkm(TBROK, cleanup, "Test cannot be continued =
owning to sufficient availability of Hugepages on the system");=0D=0A+     =
        tst_brkm(TCONF, tst_exit, "Not support Hugepages or not enough avai=
lable Hugepages");=0D=0A         else            =20=0D=0A              hug=
e_pages_shm_to_be_allocated =3D ( get_no_of_hugepages() * hugepages_size() =
* 1024) / 2 ;=0D=0A=20=0D=0A--- a/testcases/kernel/mem/hugetlb/hugeshmat/hu=
geshmat02.c=092010-04-01 15:23:09.000000000 +0900=0D=0A+++ b/testcases/kern=
el/mem/hugetlb/hugeshmat/hugeshmat02.c=092010-04-16 14:32:13.000000000 +090=
0=0D=0A@@ -102,7 +102,7 @@=0D=0A =09}=0D=0A=20=0D=0A         if ( get_no_of=
_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=0D=0A-             tst_brk=
m(TBROK, cleanup, "Test cannot be continued owning to sufficient availabili=
ty of Hugepages on the system");=0D=0A+             tst_brkm(TCONF, tst_exi=
t, "Not support Hugepages or not enough available Hugepages");=0D=0A       =
  else            =20=0D=0A              huge_pages_shm_to_be_allocated =3D=
 ( get_no_of_hugepages() * hugepages_size() * 1024) / 2 ;=0D=0A=20=0D=0A---=
 a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat03.c=092010-04-01 15:23:=
09.000000000 +0900=0D=0A+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugesh=
mat03.c=092010-04-16 14:32:26.000000000 +0900=0D=0A@@ -86,7 +86,7 @@=0D=0A =
=09}=0D=0A=20=0D=0A         if ( get_no_of_hugepages() <=3D 0 || hugepages_=
size() <=3D 0 )=0D=0A-             tst_brkm(TBROK, cleanup, "Test cannot be=
 continued owning to sufficient availability of Hugepages on the system");=0D=
=0A+             tst_brkm(TCONF, tst_exit, "Not support Hugepages or not en=
ough available Hugepages");=0D=0A         else            =20=0D=0A        =
      huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages() * hugepage=
s_size() * 1024) / 2 ;=0D=0A=20=0D=0A--- a/testcases/kernel/mem/hugetlb/hug=
eshmctl/hugeshmctl01.c=092010-04-01 15:23:09.000000000 +0900=0D=0A+++ b/tes=
tcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl01.c=092010-04-16 14:35:10.0=
00000000 +0900=0D=0A@@ -130,7 +130,7 @@=0D=0A =09}=0D=0A=20=0D=0A         i=
f ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=0D=0A-       =
      tst_brkm(TBROK, cleanup, "Test cannot be continued owning to sufficie=
nt availability of Hugepages on the system");=0D=0A+             tst_brkm(T=
CONF, tst_exit, "Not support Hugepages or not enough available Hugepages");=0D=
=0A         else            =20=0D=0A              huge_pages_shm_to_be_all=
ocated =3D ( get_no_of_hugepages() * hugepages_size() * 1024) / 2 ;=0D=0A =0D=
=0A--- a/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl02.c=092010-04-0=
1 15:23:09.000000000 +0900=0D=0A+++ b/testcases/kernel/mem/hugetlb/hugeshmc=
tl/hugeshmctl02.c=092010-04-16 14:35:21.000000000 +0900=0D=0A@@ -102,7 +102=
,7 @@=0D=0A =09}=0D=0A=20=0D=0A         if ( get_no_of_hugepages() <=3D 0 |=
| hugepages_size() <=3D 0 )=0D=0A-             tst_brkm(TBROK, cleanup, "Te=
st cannot be continued owning to sufficient availability of Hugepages on th=
e system");=0D=0A+             tst_brkm(TCONF, tst_exit, "Not support Hugep=
ages or not enough available Hugepages");=0D=0A         else             =0D=
=0A              huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages()=
 * hugepages_size() * 1024) / 2 ;=0D=0A=20=0D=0A--- a/testcases/kernel/mem/=
hugetlb/hugeshmctl/hugeshmctl03.c=092010-04-01 15:23:09.000000000 +0900=0D=0A=
+++ b/testcases/kernel/mem/hugetlb/hugeshmctl/hugeshmctl03.c=092010-04-16 1=
4:35:31.000000000 +0900=0D=0A@@ -105,7 +105,7 @@=0D=0A =09}=0D=0A=20=0D=0A =
        if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=0D=0A=
-             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to =
sufficient availability of Hugepages on the system");=0D=0A+             ts=
t_brkm(TCONF, tst_exit, "Not support Hugepages or not enough available Huge=
pages");=0D=0A         else            =20=0D=0A              huge_pages_sh=
m_to_be_allocated =3D ( get_no_of_hugepages() * hugepages_size() * 1024) / =
2 ;=0D=0A=20=0D=0A--- a/testcases/kernel/mem/hugetlb/hugeshmdt/hugeshmdt01.=
c=092010-04-01 15:23:09.000000000 +0900=0D=0A+++ b/testcases/kernel/mem/hug=
etlb/hugeshmdt/hugeshmdt01.c=092010-04-16 14:36:39.000000000 +0900=0D=0A@@ =
-87,7 +87,7 @@=0D=0A =09}=0D=0A=20=0D=0A         if ( get_no_of_hugepages()=
 <=3D 0 || hugepages_size() <=3D 0 )=0D=0A-             tst_brkm(TBROK, cle=
anup, "Test cannot be continued owning to sufficient availability of Hugepa=
ges on the system");=0D=0A+             tst_brkm(TCONF, tst_exit, "Not supp=
ort Hugepages or not enough available Hugepages");=0D=0A         else      =
      =20=0D=0A              huge_pages_shm_to_be_allocated =3D ( get_no_of=
_hugepages() * hugepages_size() * 1024) / 2 ;=0D=0A=20=0D=0A--- a/testcases=
/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c=092010-04-01 15:23:09.0000000=
00 +0900=0D=0A+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget01.c=09=
2010-04-16 14:38:22.000000000 +0900=0D=0A@@ -78,14 +78,14 @@=0D=0A =09=09ts=
t_brkm(TBROK, cleanup, "OPTION PARSING ERROR - %s", msg);=0D=0A =09}=0D=0A =0D=
=0A-=09setup();=09=09=09/* global setup */=0D=0A-=0D=0A =09/* The following=
 loop checks looping state if -i option given */=0D=0A         if ( get_no_=
of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=0D=0A-             tst_b=
rkm(TBROK, cleanup, "Test cannot be continued owning to sufficient availabi=
lity of Hugepages on the system");=0D=0A+             tst_brkm(TCONF, tst_e=
xit, "Not support Hugepages or not enough available Hugepages");=0D=0A     =
    else            =20=0D=0A               huge_pages_shm_to_be_allocated =
=3D ( get_no_of_hugepages() * hugepages_size() * 1024) / 2 ;=0D=0A         =0D=
=0A+=09setup();=09=09=09/* global setup */=0D=0A+=0D=0A         for (lc =3D=
 0; TEST_LOOPING(lc); lc++) {=0D=0A =09=09/* reset Tst_count in case we are=
 looping */=0D=0A =09=09Tst_count =3D 0;=0D=0A--- a/testcases/kernel/mem/hu=
getlb/hugeshmget/hugeshmget02.c=092010-04-01 15:23:09.000000000 +0900=0D=0A=
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget02.c=092010-04-16 1=
4:38:33.000000000 +0900=0D=0A@@ -84,7 +84,7 @@=0D=0A =09}=0D=0A=20=0D=0A   =
      if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=0D=0A-=
             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to s=
ufficient availability of Hugepages on the system");=0D=0A+             tst=
_brkm(TCONF, tst_exit, "Not support Hugepages or not enough available Hugep=
ages");=0D=0A         else            =20=0D=0A              huge_pages_shm=
_to_be_allocated =3D ( get_no_of_hugepages() * hugepages_size() * 1024) / 2=
 ;=0D=0A  =20=0D=0A--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget=
03.c=092010-04-01 15:23:09.000000000 +0900=0D=0A+++ b/testcases/kernel/mem/=
hugetlb/hugeshmget/hugeshmget03.c=092010-04-16 14:38:49.000000000 +0900=0D=0A=
@@ -85,7 +85,7 @@=0D=0A=20=0D=0A =09/* The following loop checks looping st=
ate if -i option given */=0D=0A         if ( get_no_of_hugepages() <=3D 0 |=
| hugepages_size() <=3D 0 )=0D=0A-             tst_brkm(TBROK, cleanup, "Te=
st cannot be continued owning to sufficient availability of Hugepages on th=
e system");=0D=0A+             tst_brkm(TCONF, tst_exit, "Not support Hugep=
ages or not enough available Hugepages");=0D=0A         else             =0D=
=0A              huge_pages_shm_to_be_allocated =3D ( get_no_of_hugepages()=
 * hugepages_size() * 1024) / 2 ;=0D=0A=20=0D=0A--- a/testcases/kernel/mem/=
hugetlb/hugeshmget/hugeshmget05.c=092010-04-01 15:23:09.000000000 +0900=0D=0A=
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget05.c=092010-04-16 1=
4:39:00.000000000 +0900=0D=0A@@ -86,7 +86,7 @@=0D=0A =09}=0D=0A=20=0D=0A   =
      if ( get_no_of_hugepages() <=3D 0 || hugepages_size() <=3D 0 )=0D=0A-=
             tst_brkm(TBROK, cleanup, "Test cannot be continued owning to s=
ufficient availability of Hugepages on the system");=0D=0A+             tst=
_brkm(TCONF, tst_exit, "Not support Hugepages or not enough available Hugep=
ages");=0D=0A         else            =20=0D=0A              huge_pages_shm=
_to_be_allocated =3D ( get_no_of_hugepages() * hugepages_size() * 1024) / 2=
 ;=0D=0A       =20=0D=0A
----=_NextPart_ST_18_23_58_Friday_April_16_2010_3628
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
----=_NextPart_ST_18_23_58_Friday_April_16_2010_3628
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_18_23_58_Friday_April_16_2010_3628--

