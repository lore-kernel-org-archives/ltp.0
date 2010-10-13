Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1P5qIg-0004Eq-TE
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 01:38:38 +0000
Received: from out15.sjc.mx.trendmicro.com ([216.99.131.72])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1P5qIe-0005ju-OI
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 01:38:38 +0000
Message-ID: <000601cb6a72$1339eb50$39adc1f0$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Wed, 13 Oct 2010 10:00:49 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_10_00_50_Wednesday_October_13_2010_22317"
References: <000b01cb6062$9848f210$c8dad630$@co.jp>	<4CAEC847.6050108@cn.fujitsu.com>
	<AANLkTikuWFHR_a=uDeWEunH3xCw1Lvh3ErM47Ei9uAjr@mail.gmail.com>
In-Reply-To: <AANLkTikuWFHR_a=uDeWEunH3xCw1Lvh3ErM47Ei9uAjr@mail.gmail.com>
Content-Language: ja
Subject: Re: [LTP] [PATCH] fix "aio_error" test
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

----=_NextPart_ST_10_00_50_Wednesday_October_13_2010_22317
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----=0D=0A> From: Garrett Cooper [mailto:yanegomi@g=
mail.com]=0D=0A> Sent: Wednesday, October 13, 2010 5:24 AM=0D=0A> To: Bian =
Naimeng=0D=0A> Cc: Mitani; ltp-list@lists.sourceforge.net; =E7=95=B6=E5=BA=A7=
 =E5=81=A5=E5=B8=82=0D=0A> Subject: Re: [LTP] [PATCH] fix "aio_error" test=0D=
=0A>=20=0D=0A> 2010/10/8 Bian Naimeng <biannm@cn.fujitsu.com>:=0D=0A> >> Hi=
,=0D=0A> >>=0D=0A> >>=0D=0A> >> "conformance/interfaces/aio_error/3-1" fail=
ed with following=0D=0A> message:=0D=0A> >> ------------=0D=0A> >> conforma=
nce/interfaces/aio_error/3-1: execution: FAILED: Output:=0D=0A> >> aio_erro=
r/3-1.c bad aio_read return value()=0D=0A> >> ------------=0D=0A> >>=0D=0A>=
 >> This testset seems to be the error root test for "aio_error()".=0D=0A> =
>> Therefore, "aio_error()" must be called after failure of=0D=0A> "aio_wri=
te()",=0D=0A> >> I think.=0D=0A> >> But, "exit()" is called when expected f=
ailure of "aio_write()"=0D=0A> occurred:=0D=0A> >> ------------(3-1.c)=0D=0A=
> >>         if (aio_write(&aiocb) !=3D 0)=0D=0A> >>  {=0D=0A> >>          =
       printf(TNAME " bad aio_read return value()\n");=0D=0A> >>           =
      exit(PTS_FAIL);=0D=0A> >>  }=0D=0A> >> ------------=0D=0A> >>=0D=0A> =
>> I think that "exit()" must be called when "aio_write()" succeeded.=0D=0A=
> >>=0D=0A> >=0D=0A> >  Agree.=0D=0A> >=0D=0A> >> And the message of unexpe=
cted movement of "aio_write()" is=0D=0A> >> "aio_read()"'s one.=0D=0A> >> A=
nd the indent of this program "3-1.c" seems to include both space=0D=0A> an=
d tab.=0D=0A> >> I want to revise them, too.=0D=0A> >>=0D=0A> >=0D=0A> >  A=
nother one should be fix like this.=0D=0A> >=0D=0A> >        if (ret !=3D E=
INVAL)=0D=0A> >        {=0D=0A> > -               printf(TNAME " errno is n=
ot EINVAL %s\n",=0D=0A> strerror(errno));=0D=0A> > +               printf(T=
NAME " errno is not EINVAL %s\n",=0D=0A> strerror(ret));=0D=0A> >          =
      return PTS_FAIL;=0D=0A> >        }=0D=0A> >=0D=0A> >>=0D=0A> >> Signe=
d-off-by: Tomonori Mitani <mitani@ryobi.co.jp>=0D=0A> >> =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=0D=0A> >> ---=0D=0A> >>=0D=0A> a/testcases/open_posix_te=
stsuite/conformance/interfaces/aio_error/=0D=0A> 3-1.c       2010=0D=0A> >>=
 -09-22 22:31:24.000000000 +0900=0D=0A> >> +++=0D=0A> >>=0D=0A> b/testcases=
/open_posix_testsuite/conformance/interfaces/aio_error/=0D=0A> 3-1.c       =
2010=0D=0A> >> -09-30 09:51:42.000000000 +0900=0D=0A> >> @@ -36,42 +36,41 @=
@=0D=0A> >>=0D=0A> >>  int main()=0D=0A> >>  {=0D=0A> >> -=0D=0A> >> -     =
   char tmpfname[256];=0D=0A> >> +     char tmpfname[256];=0D=0A> >>  #defi=
ne BUF_SIZE 512=0D=0A> >> -        char buf[BUF_SIZE];=0D=0A> >> -        i=
nt fd;=0D=0A> >> -        struct aiocb aiocb;=0D=0A> >> +     char buf[BUF_=
SIZE];=0D=0A> >> +     int fd;=0D=0A> >> +     struct aiocb aiocb;=0D=0A> >=
>       int ret=3D0;=0D=0A> >>=0D=0A> >>       if (sysconf(_SC_ASYNCHRONOUS=
_IO) !=3D 200112L)=0D=0A> >>               return PTS_UNSUPPORTED;=0D=0A> >=
>=0D=0A> >> -        snprintf(tmpfname, sizeof(tmpfname),=0D=0A> "/tmp/pts_=
aio_error_3_1_%d",=0D=0A> >> -                  getpid());=0D=0A> >> -     =
   unlink(tmpfname);=0D=0A> >> -        fd =3D open(tmpfname, O_CREAT | O_R=
DWR | O_EXCL,=0D=0A> >> -                  S_IRUSR | S_IWUSR);=0D=0A> >> - =
       if (fd =3D=3D -1)=0D=0A> >> -        {=0D=0A> >> -                pr=
intf(TNAME " Error at open(): %s\n",=0D=0A> >> -                       stre=
rror(errno));=0D=0A> >> -                exit(PTS_UNRESOLVED);=0D=0A> >> - =
       }=0D=0A> >> +     snprintf(tmpfname, sizeof(tmpfname),=0D=0A> "/tmp/=
pts_aio_error_3_1_%d",=0D=0A> >> +                      getpid());=0D=0A> >=
> +     unlink(tmpfname);=0D=0A> >> +     fd =3D open(tmpfname, O_CREAT | O=
_RDWR | O_EXCL,=0D=0A> >> +                       S_IRUSR | S_IWUSR);=0D=0A=
> >> +     if (fd =3D=3D -1)=0D=0A> >> +     {=0D=0A> >> +             prin=
tf(TNAME " Error at open(): %s\n",=0D=0A> >> +                        strer=
ror(errno));=0D=0A> >> +             exit(PTS_UNRESOLVED);=0D=0A> >> +     =
}=0D=0A> >>=0D=0A> >> -        unlink(tmpfname);=0D=0A> >> +     unlink(tmp=
fname);=0D=0A> >>=0D=0A> >>       memset (&aiocb, 0, sizeof (struct aiocb))=
;=0D=0A> >>=0D=0A> >> -        aiocb.aio_fildes =3D fd;=0D=0A> >> -        =
aiocb.aio_buf =3D buf;=0D=0A> >> -        aiocb.aio_reqprio =3D -1;=0D=0A> =
>> -        aiocb.aio_nbytes =3D BUF_SIZE;=0D=0A> >> +     aiocb.aio_fildes=
 =3D fd;=0D=0A> >> +     aiocb.aio_buf =3D buf;=0D=0A> >> +     aiocb.aio_r=
eqprio =3D -1;=0D=0A> >> +     aiocb.aio_nbytes =3D BUF_SIZE;=0D=0A> >>=0D=0A=
> >> -        if (aio_write(&aiocb) !=3D 0)=0D=0A> >> +     if (aio_write(&=
aiocb) =3D=3D 0)=0D=0A> >>       {=0D=0A> >> -                printf(TNAME =
" bad aio_read return value()\n");=0D=0A> >> -                exit(PTS_FAIL=
);=0D=0A> >> +             printf(TNAME " bad aio_write return value()\n");=0D=
=0A> >> +             exit(PTS_FAIL);=0D=0A> >>       }=0D=0A> >>=0D=0A> >>=
       while (aio_error (&aiocb) =3D=3D EINPROGRESS);=0D=0A>=20=0D=0A>     =
I'll respond to this sometime in the next couple of days after I=0D=0A> do =
some more investigation on the issue.=0D=0A> Thanks,=0D=0A> -Garrett=0D=0A=0D=
=0A=0D=0AHi,=0D=0A=0D=0AI added Bian's following opinion to patch:=0D=0A---=
---------=0D=0A  Another one should be fix like this.=0D=0A=0D=0A=09if (ret=
 !=3D EINVAL)=0D=0A=09{=0D=0A-=09=09printf(TNAME " errno is not EINVAL %s\n=
", strerror(errno));=0D=0A+=09=09printf(TNAME " errno is not EINVAL %s\n", =
strerror(ret));=0D=0A=09=09return PTS_FAIL;=0D=0A=09}=0D=0A------------=0D=0A=0D=
=0AAnd I added following two modifications.=0D=0A=0D=0A - Closing the file =
descriptor when exit.=0D=0A=0D=0A - Clear "errno".=0D=0A   The first "unlin=
k()" fails because the file doesn't exist.=0D=0A   After that, ENOENT is se=
t to "errno" and kept intact.=0D=0A   I revised to clear "errno".=0D=0A=0D=0A=
I noticed that there were similar problems in the other "aio-..." test prog=
rams.=0D=0ABut I cannot judge whether other test programs must be revised.=0D=
=0AI revise only "aio_error/3-1".=20=0D=0A=0D=0A=0D=0ASigned-off-by: Tomono=
ri Mitani <mitani@ryobi.co.jp>=0D=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=
=0A--- testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.=
c=092010-10-03 09:53:52.000000000 +0900=0D=0A+++ testcases/open_posix_tests=
uite/conformance/interfaces/aio_error/3-1.new=092010-10-13 09:30:12.0000000=
00 +0900=0D=0A@@ -36,42 +36,43 @@=0D=0A=20=0D=0A int main()=0D=0A {=0D=0A-=0D=
=0A-        char tmpfname[256];=0D=0A+=09char tmpfname[256];=0D=0A #define =
BUF_SIZE 512=0D=0A-        char buf[BUF_SIZE];=0D=0A-        int fd;=0D=0A-=
        struct aiocb aiocb;=0D=0A+=09char buf[BUF_SIZE];=0D=0A+=09int fd;=0D=
=0A+=09struct aiocb aiocb;=0D=0A =09int ret=3D0;=0D=0A=20=0D=0A =09if (sysc=
onf(_SC_ASYNCHRONOUS_IO) !=3D 200112L)=0D=0A =09=09return PTS_UNSUPPORTED;=0D=
=0A=20=0D=0A-        snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_err=
or_3_1_%d",=0D=0A-                  getpid());=0D=0A-        unlink(tmpfnam=
e);=0D=0A-        fd =3D open(tmpfname, O_CREAT | O_RDWR | O_EXCL,=0D=0A-  =
                S_IRUSR | S_IWUSR);=0D=0A-        if (fd =3D=3D -1)=0D=0A- =
       {=0D=0A-                printf(TNAME " Error at open(): %s\n",=0D=0A=
-                       strerror(errno));=0D=0A-                exit(PTS_UN=
RESOLVED);=0D=0A-        }=0D=0A+=09snprintf(tmpfname, sizeof(tmpfname), "/=
tmp/pts_aio_error_3_1_%d",=0D=0A+=09=09=09 getpid());=0D=0A+=09unlink(tmpfn=
ame);=0D=0A+=09errno =3D 0;=0D=0A+=09fd =3D open(tmpfname, O_CREAT | O_RDWR=
 | O_EXCL,=0D=0A+=09=09=09  S_IRUSR | S_IWUSR);=0D=0A+=09if (fd =3D=3D -1)=0D=
=0A+=09{=0D=0A+=09=09printf(TNAME " Error at open(): %s\n",=0D=0A+=09=09=09=
   strerror(errno));=0D=0A+=09=09exit(PTS_UNRESOLVED);=0D=0A+=09}=0D=0A=20=0D=
=0A-        unlink(tmpfname);=0D=0A+=09unlink(tmpfname);=0D=0A=20=0D=0A =09=
memset (&aiocb, 0, sizeof (struct aiocb));=0D=0A=20=0D=0A-        aiocb.aio=
_fildes =3D fd;=0D=0A-        aiocb.aio_buf =3D buf;=0D=0A-        aiocb.ai=
o_reqprio =3D -1;=0D=0A-        aiocb.aio_nbytes =3D BUF_SIZE;=0D=0A+=09aio=
cb.aio_fildes =3D fd;=0D=0A+=09aiocb.aio_buf =3D buf;=0D=0A+=09aiocb.aio_re=
qprio =3D -1;=0D=0A+=09aiocb.aio_nbytes =3D BUF_SIZE;=0D=0A=20=0D=0A-      =
  if (aio_write(&aiocb) !=3D 0)=0D=0A+=09if (aio_write(&aiocb) =3D=3D 0)=0D=
=0A =09{=0D=0A-                printf(TNAME " bad aio_read return value()\n=
");=0D=0A-                exit(PTS_FAIL);=0D=0A+=09=09close(fd);=0D=0A+=09=09=
printf(TNAME " bad aio_write return value()\n");=0D=0A+=09=09exit(PTS_FAIL)=
;=0D=0A =09}=0D=0A=20=0D=0A =09while (aio_error (&aiocb) =3D=3D EINPROGRESS=
);=0D=0A@@ -79,7 +80,8 @@=0D=0A=20=0D=0A =09if (ret !=3D EINVAL)=0D=0A =09{=0D=
=0A-=09=09printf(TNAME " errno is not EINVAL %s\n", strerror(errno));=0D=0A=
+=09=09close(fd);=0D=0A+=09=09printf(TNAME " errno is not EINVAL %s\n", str=
error(ret));=0D=0A =09=09return PTS_FAIL;=0D=0A =09}=0D=0A=20=0D=0A=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0D=0A=0D=0A=0D=0ARegards--=0D=0A=0D=0A-Tomonori=
 Mitani=0D=0A
----=_NextPart_ST_10_00_50_Wednesday_October_13_2010_22317
Content-Type: application/octet-stream;
	name="3-1.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="3-1.patch"

--- testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c=09=
2010-10-03 09:53:52.000000000 +0900=0A+++ testcases/open_posix_testsuite/co=
nformance/interfaces/aio_error/3-1.new=092010-10-13 09:30:12.000000000 +090=
0=0A@@ -36,42 +36,43 @@=0A =0A int main()=0A {=0A-=0A-        char tmpfname=
[256];=0A+=09char tmpfname[256];=0A #define BUF_SIZE 512=0A-        char bu=
f[BUF_SIZE];=0A-        int fd;=0A-        struct aiocb aiocb;=0A+=09char b=
uf[BUF_SIZE];=0A+=09int fd;=0A+=09struct aiocb aiocb;=0A =09int ret=3D0;=0A=
 =0A =09if (sysconf(_SC_ASYNCHRONOUS_IO) !=3D 200112L)=0A =09=09return PTS_=
UNSUPPORTED;=0A =0A-        snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_=
aio_error_3_1_%d",=0A-                  getpid());=0A-        unlink(tmpfna=
me);=0A-        fd =3D open(tmpfname, O_CREAT | O_RDWR | O_EXCL,=0A-       =
           S_IRUSR | S_IWUSR);=0A-        if (fd =3D=3D -1)=0A-        {=0A=
-                printf(TNAME " Error at open(): %s\n",=0A-                =
       strerror(errno));=0A-                exit(PTS_UNRESOLVED);=0A-      =
  }=0A+=09snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_error_3_1_%d",=
=0A+=09=09=09 getpid());=0A+=09unlink(tmpfname);=0A+=09errno =3D 0;=0A+=09f=
d =3D open(tmpfname, O_CREAT | O_RDWR | O_EXCL,=0A+=09=09=09  S_IRUSR | S_I=
WUSR);=0A+=09if (fd =3D=3D -1)=0A+=09{=0A+=09=09printf(TNAME " Error at ope=
n(): %s\n",=0A+=09=09=09   strerror(errno));=0A+=09=09exit(PTS_UNRESOLVED);=
=0A+=09}=0A =0A-        unlink(tmpfname);=0A+=09unlink(tmpfname);=0A =0A =09=
memset (&aiocb, 0, sizeof (struct aiocb));=0A =0A-        aiocb.aio_fildes =
=3D fd;=0A-        aiocb.aio_buf =3D buf;=0A-        aiocb.aio_reqprio =3D =
-1;=0A-        aiocb.aio_nbytes =3D BUF_SIZE;=0A+=09aiocb.aio_fildes =3D fd=
;=0A+=09aiocb.aio_buf =3D buf;=0A+=09aiocb.aio_reqprio =3D -1;=0A+=09aiocb.=
aio_nbytes =3D BUF_SIZE;=0A =0A-        if (aio_write(&aiocb) !=3D 0)=0A+=09=
if (aio_write(&aiocb) =3D=3D 0)=0A =09{=0A-                printf(TNAME " b=
ad aio_read return value()\n");=0A-                exit(PTS_FAIL);=0A+=09=09=
close(fd);=0A+=09=09printf(TNAME " bad aio_write return value()\n");=0A+=09=
=09exit(PTS_FAIL);=0A =09}=0A =0A =09while (aio_error (&aiocb) =3D=3D EINPR=
OGRESS);=0A@@ -79,7 +80,8 @@=0A =0A =09if (ret !=3D EINVAL)=0A =09{=0A-=09=09=
printf(TNAME " errno is not EINVAL %s\n", strerror(errno));=0A+=09=09close(=
fd);=0A+=09=09printf(TNAME " errno is not EINVAL %s\n", strerror(ret));=0A =
=09=09return PTS_FAIL;=0A =09}=0A =0A
----=_NextPart_ST_10_00_50_Wednesday_October_13_2010_22317
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
----=_NextPart_ST_10_00_50_Wednesday_October_13_2010_22317
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_10_00_50_Wednesday_October_13_2010_22317--

