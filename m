Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1Ofnjk-000590-Bj
	for ltp-list@lists.sourceforge.net; Mon, 02 Aug 2010 05:38:56 +0000
Received: from out05.sjc.mx.trendmicro.com ([216.99.131.18])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ofnji-0001A9-Rx
	for ltp-list@lists.sourceforge.net; Mon, 02 Aug 2010 05:38:56 +0000
Received: from out02.sjc.mx.trendmicro.com (unknown [216.99.131.6])
	by out05.sjc.mx.trendmicro.com (Postfix) with ESMTP id 13EA841191F
	for <ltp-list@lists.sourceforge.net>;
	Mon,  2 Aug 2010 05:15:41 +0000 (UTC)
Message-ID: <000601cb31fc$50629a30$f127ce90$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Mon, 2 Aug 2010 13:36:45 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_13_36_47_Monday_August_02_2010_8469"
References: <000001cb249e$14ed7490$3ec85db0$@co.jp>	<AANLkTimgkcie9ze6ge5SmrH8Fe8a1z8RT0FgZMhjExW5@mail.gmail.com>
	<AANLkTinaYGjU8MGQZ_ccN1bfuduDzs0KsFPXi638278T@mail.gmail.com>
In-Reply-To: <AANLkTinaYGjU8MGQZ_ccN1bfuduDzs0KsFPXi638278T@mail.gmail.com>
Content-Language: ja
Subject: Re: [LTP]
	=?utf-8?b?4oCd77yj772P772O772U772B772J772O772F772S772T4oCd?=
	=?utf-8?q?_test_was_=22TFAIL=22_but_=22PASS=22_is_in_log_results?=
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
Cc: ltp-list@lists.sourceforge.net, =?utf-8?B?55W25bqnIOWBpeW4gg==?= <toza@ryobi.co.jp>

This is a multi-part message in MIME format.

----=_NextPart_ST_13_36_47_Monday_August_02_2010_8469
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----=0D=0A> From: Garrett Cooper [mailto:yanegomi@g=
mail.com]=0D=0A> Sent: Saturday, July 17, 2010 7:51 AM=0D=0A> To: Mitani=0D=
=0A> Cc: ltp-list@lists.sourceforge.net=0D=0A> Subject: Re: [LTP] =E2=80=9D=
=EF=BC=A3=EF=BD=8F=EF=BD=8E=EF=BD=94=EF=BD=81=EF=BD=89=EF=BD=8E=EF=BD=85=EF=
=BD=92=EF=BD=93=E2=80=9D test was "TFAIL" but "PASS"=0D=0A> is in log resul=
ts=0D=0A>=20=0D=0A> On Fri, Jul 16, 2010 at 3:50 PM, Garrett Cooper <yanego=
mi@gmail.com>=0D=0A> wrote:=0D=0A> > On Thu, Jul 15, 2010 at 9:19 PM, Mitan=
i <mitani@ryobi.co.jp> wrote:=0D=0A> >> Hi,=0D=0A> >>=0D=0A> >> With RHEL5.=
4/5.5 systems, I noticed that "Containers" test failed=0D=0A> but=0D=0A> >>=
 "Containers" is PASS in log results:=0D=0A> >>=0D=0A> >> ---<log results f=
ile>-------------=0D=0A> >> ...=0D=0A> >> hangup01                       PA=
SS       0=0D=0A> >> Containers                     PASS       0=0D=0A> >> =
BindMounts                     PASS       0=0D=0A> >> ...=0D=0A> >> -------=
---------=0D=0A> >>=0D=0A> >> ---<detail in redirected file>-------------=0D=
=0A> >> ...=0D=0A> >> check_netns_enabled    1  TFAIL  :  unshare syscall s=
moke test=0D=0A> failed:=0D=0A> >> errno=3DEINVAL(22): Invalid argument=0D=0A=
> >> Network namespaces not enabled in kernel.  Not running netns tests.=0D=
=0A> >> ...=0D=0A> >> ----------------=0D=0A> >>=0D=0A> >> The source which=
 returned with "Invalid argument" is=0D=0A> >> "check_netns_enabled.c":=0D=0A=
> >>=0D=0A> >> ---<check_netns_enabled.c>-------------=0D=0A> >> main()=0D=0A=
> >> {=0D=0A> >>        /* Checking if the kernel supports unshare with net=
ns=0D=0A> capabilities.=0D=0A> >> */=0D=0A> >>        if (syscall(__NR_unsh=
are, CLONE_NEWNET | CLONE_NEWNS) < 0)=0D=0A> {=0D=0A> >>                tst=
_resm (TFAIL | TERRNO, "unshare syscall smoke=0D=0A> test=0D=0A> >> failed"=
);=0D=0A> >>        }=0D=0A> >>        tst_exit();=0D=0A> >> }=0D=0A> >> --=
--------------=0D=0A> >>=0D=0A> >> In RHEL5.4/5.5 systems, unshare() does n=
ot support the argument=0D=0A> >> "CLONE_NEWNET".=0D=0A> >> But I feel stra=
nge that log results is "PASS" in spite of "TFAIL"=0D=0A> exit.=0D=0A> >>=0D=
=0A> >> "container_test.sh" which calls "check_netns_enabled.c" is as=0D=0A=
> follows:=0D=0A> >> ---<container_test.sh>-------------=0D=0A> >> ...=0D=0A=
> >> check_netns_enabled=0D=0A> >> if [ $=3F -eq 0 ]; then=0D=0A> >>       =
 echo "Running netns tests."=0D=0A> >>        runnetnstest.sh=0D=0A> >> els=
e=0D=0A> >>        echo "Network namespaces not enabled in kernel.  Not=0D=0A=
> running netns=0D=0A> >> tests."=0D=0A> >> fi=0D=0A> >> ...=0D=0A> >> ----=
------------=0D=0A> >>=0D=0A> >> According to above source, "check_netns_en=
abled.c" is only the=0D=0A> judgement=0D=0A> >> whether "runnetnstest.sh" t=
est can be called or not.=0D=0A> >> So, I think that "TFAIL" is not suitabl=
e for the test impossibility=0D=0A> >> message.=0D=0A> >> "TCONF" is more s=
uitable for the message than "TFAIL", I think.=0D=0A> >> But, if "TCONF" is=
 used instead of "TFAIL", "tst_exit" returns with=0D=0A> 0.=0D=0A> >> And t=
he test shell "runnetnstest.sh" is called against intention.=0D=0A> >>=0D=0A=
> >>=0D=0A> >> I thought up two ways of solutions.=0D=0A> >> (1) Insert "ex=
it(1)" just after "tst_resm()" of=0D=0A> "check_netns_enabled.c"=0D=0A> >> =
(2) Replace "TFAIL" with "TWARN", instead of "TCONF".=0D=0A> >>=0D=0A> >> B=
ut above solutions are both irregular measures, I think.=0D=0A> >>=0D=0A> >=
> If there are other good measures, please give me advice.=0D=0A> >>=0D=0A>=
 >>=0D=0A> >> In the following, I nominate a temporary patch for an example=
:=0D=0A> >>=0D=0A> >> Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>=0D=
=0A> >>=0D=0A> >> =3D=3D=3D(1)=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=0A> >> ---=0D=0A=
> a/testcases/kernel/containers/netns/check_netns_enabled.c   2010-=0D=0A> =
07-12=0D=0A> >> 02:01:45.000000000 +0900=0D=0A> >> +++=0D=0A> b/testcases/k=
ernel/containers/netns/check_netns_enabled.c   2010-=0D=0A> 07-16=0D=0A> >>=
 11:58:14.000000000 +0900=0D=0A> >> @@ -43,7 +43,8 @@=0D=0A> >>  {=0D=0A> >=
>        /* Checking if the kernel supports unshare with netns=0D=0A> capab=
ilities.=0D=0A> >> */=0D=0A> >>         if (syscall(__NR_unshare, CLONE_NEW=
NET | CLONE_NEWNS) <=0D=0A> 0) {=0D=0A> >> -               tst_resm (TFAIL =
| TERRNO, "unshare syscall smoke=0D=0A> test=0D=0A> >> failed");=0D=0A> >> =
+               tst_resm (TCONF | TERRNO, "unshare syscall smoke=0D=0A> tes=
t=0D=0A> >> failed");=0D=0A> >> +               exit (1);=0D=0A> >>        =
}=0D=0A> >>        tst_exit();=0D=0A> >>  }=0D=0A> >> =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=0D=0A> >>=0D=0A> >> =3D=3D=3D(2)=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=
=0A> >> ---=0D=0A> a/testcases/kernel/containers/netns/check_netns_enabled.=
c   2010-=0D=0A> 07-12=0D=0A> >> 02:01:45.000000000 +0900=0D=0A> >> +++=0D=0A=
> b/testcases/kernel/containers/netns/check_netns_enabled.c   2010-=0D=0A> =
07-16=0D=0A> >> 11:56:47.000000000 +0900=0D=0A> >> @@ -43,7 +43,7 @@=0D=0A>=
 >>  {=0D=0A> >>        /* Checking if the kernel supports unshare with net=
ns=0D=0A> capabilities.=0D=0A> >> */=0D=0A> >>         if (syscall(__NR_uns=
hare, CLONE_NEWNET | CLONE_NEWNS) <=0D=0A> 0) {=0D=0A> >> -               t=
st_resm (TFAIL | TERRNO, "unshare syscall smoke=0D=0A> test=0D=0A> >> faile=
d");=0D=0A> >> +               tst_resm (TWARN | TERRNO, "unshare syscall s=
moke=0D=0A> test=0D=0A> >> failed");=0D=0A> >>        }=0D=0A> >>        ts=
t_exit();=0D=0A> >>  }=0D=0A> >> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=0A=
> >=0D=0A> > Uh, that would introduce a more serious problem because the ne=
tns=0D=0A> > tests are keyed on whether or not that script passes or fails.=0D=
=0A>=20=0D=0A> s/script/app/=0D=0A>=20=0D=0A> > If you can provide a more s=
table means of detecting whether or not=0D=0A> > CLONE_* is available with =
netns, and integrate that into the tests,=0D=0A> > that would be a better i=
dea.=0D=0A>=20=0D=0A> Thanks,=0D=0A> -Garrett=0D=0A=0D=0A=0D=0ASorry for my=
 late answer.=0D=0A=0D=0AI considered how to judge detecting whether or not=
 CLONE_* is available.=0D=0AHowever, I hit only about errno judgment.=0D=0A=0D=
=0ASigned-off-by: Tomonori Mitani <mitani@ryobi.co.jp>=0D=0A=0D=0A=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=0A--- a/testcases/kernel/containers/netns/ch=
eck_netns_enabled.c=092010-07-30 02:23:32.000000000 +0900=0D=0A+++ b/testca=
ses/kernel/containers/netns/check_netns_enabled.c=092010-08-02 10:38:31.000=
000000 +0900=0D=0A@@ -42,8 +42,12 @@=0D=0A main()=0D=0A {=0D=0A =09/* Check=
ing if the kernel supports unshare with netns capabilities. */=0D=0A-      =
  if (syscall(__NR_unshare, CLONE_NEWNET | CLONE_NEWNS) < 0) {=0D=0A-=09=09=
tst_resm (TFAIL | TERRNO, "unshare syscall smoke test failed");=0D=0A+=09if=
 (syscall(__NR_unshare, CLONE_NEWNET | CLONE_NEWNS) < 0) {=0D=0A+=09=09if (=
errno =3D=3D EINVAL) {=0D=0A+=09=09=09tst_resm (TWARN | TERRNO, "unshare sy=
scall not support CLONE_NEWNET or CLONE_NEWNS");=0D=0A+=09=09} else {=0D=0A=
+=09=09=09tst_resm (TFAIL | TERRNO, "unshare syscall smoke test failed");=0D=
=0A+=09=09}=0D=0A =09}=0D=0A =09tst_exit();=0D=0A }=0D=0A=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=0D=0A=0D=0A=0D=0AThanks--=0D=0A=0D=0A-Tomonori Mitani=0D=
=0A
----=_NextPart_ST_13_36_47_Monday_August_02_2010_8469
Content-Type: application/octet-stream;
	name="check_netns_enabled.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="check_netns_enabled.patch"

--- a/testcases/kernel/containers/netns/check_netns_enabled.c=092010-07-30 =
02:23:32.000000000 +0900=0A+++ b/testcases/kernel/containers/netns/check_ne=
tns_enabled.c=092010-08-02 10:38:31.000000000 +0900=0A@@ -42,8 +42,12 @@=0A=
 main()=0A {=0A =09/* Checking if the kernel supports unshare with netns ca=
pabilities. */=0A-        if (syscall(__NR_unshare, CLONE_NEWNET | CLONE_NE=
WNS) < 0) {=0A-=09=09tst_resm (TFAIL | TERRNO, "unshare syscall smoke test =
failed");=0A+=09if (syscall(__NR_unshare, CLONE_NEWNET | CLONE_NEWNS) < 0) =
{=0A+=09=09if (errno =3D=3D EINVAL) {=0A+=09=09=09tst_resm (TWARN | TERRNO,=
 "unshare syscall not support CLONE_NEWNET or CLONE_NEWNS");=0A+=09=09} els=
e {=0A+=09=09=09tst_resm (TFAIL | TERRNO, "unshare syscall smoke test faile=
d");=0A+=09=09}=0A =09}=0A =09tst_exit();=0A }=0A
----=_NextPart_ST_13_36_47_Monday_August_02_2010_8469
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
----=_NextPart_ST_13_36_47_Monday_August_02_2010_8469
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_13_36_47_Monday_August_02_2010_8469--

