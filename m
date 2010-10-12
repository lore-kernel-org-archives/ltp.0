Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P5lOT-0006YU-Oe
	for ltp-list@lists.sourceforge.net; Tue, 12 Oct 2010 20:24:17 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P5lOS-0000MU-3d
	for ltp-list@lists.sourceforge.net; Tue, 12 Oct 2010 20:24:17 +0000
Received: by gya1 with SMTP id 1so816199gya.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Oct 2010 13:24:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4CAEC847.6050108@cn.fujitsu.com>
References: <000b01cb6062$9848f210$c8dad630$@co.jp>
	<4CAEC847.6050108@cn.fujitsu.com>
Date: Tue, 12 Oct 2010 13:24:10 -0700
Message-ID: <AANLkTikuWFHR_a=uDeWEunH3xCw1Lvh3ErM47Ei9uAjr@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net, =?Big5?B?t+2ueSCwt6Wr?= <toza@ryobi.co.jp>, Mitani <mitani@ryobi.co.jp>

2010/10/8 Bian Naimeng <biannm@cn.fujitsu.com>:
>> Hi,
>>
>>
>> "conformance/interfaces/aio_error/3-1" failed with following message:
>> ------------
>> conformance/interfaces/aio_error/3-1: execution: FAILED: Output:
>> aio_error/3-1.c bad aio_read return value()
>> ------------
>>
>> This testset seems to be the error root test for "aio_error()".
>> Therefore, "aio_error()" must be called after failure of "aio_write()",
>> I think.
>> But, "exit()" is called when expected failure of "aio_write()" occurred:
>> ------------(3-1.c)
>> =A0 =A0 =A0 =A0 if (aio_write(&aiocb) !=3D 0)
>> =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf(TNAME " bad aio_read return value=
()\n");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 exit(PTS_FAIL);
>> =A0}
>> ------------
>>
>> I think that "exit()" must be called when "aio_write()" succeeded.
>>
>
> =A0Agree.
>
>> And the message of unexpected movement of "aio_write()" is
>> "aio_read()"'s one.
>> And the indent of this program "3-1.c" seems to include both space and t=
ab.
>> I want to revise them, too.
>>
>
> =A0Another one should be fix like this.
>
> =A0 =A0 =A0 =A0if (ret !=3D EINVAL)
> =A0 =A0 =A0 =A0{
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf(TNAME " errno is not EINVAL %s\n", s=
trerror(errno));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf(TNAME " errno is not EINVAL %s\n", s=
trerror(ret));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return PTS_FAIL;
> =A0 =A0 =A0 =A0}
>
>>
>> Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> ---
>> a/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c =
=A0 =A0 =A0 2010
>> -09-22 22:31:24.000000000 +0900
>> +++
>> b/testcases/open_posix_testsuite/conformance/interfaces/aio_error/3-1.c =
=A0 =A0 =A0 2010
>> -09-30 09:51:42.000000000 +0900
>> @@ -36,42 +36,41 @@
>>
>> =A0int main()
>> =A0{
>> -
>> - =A0 =A0 =A0 =A0char tmpfname[256];
>> + =A0 =A0 char tmpfname[256];
>> =A0#define BUF_SIZE 512
>> - =A0 =A0 =A0 =A0char buf[BUF_SIZE];
>> - =A0 =A0 =A0 =A0int fd;
>> - =A0 =A0 =A0 =A0struct aiocb aiocb;
>> + =A0 =A0 char buf[BUF_SIZE];
>> + =A0 =A0 int fd;
>> + =A0 =A0 struct aiocb aiocb;
>> =A0 =A0 =A0 int ret=3D0;
>>
>> =A0 =A0 =A0 if (sysconf(_SC_ASYNCHRONOUS_IO) !=3D 200112L)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTS_UNSUPPORTED;
>>
>> - =A0 =A0 =A0 =A0snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_erro=
r_3_1_%d",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0getpid());
>> - =A0 =A0 =A0 =A0unlink(tmpfname);
>> - =A0 =A0 =A0 =A0fd =3D open(tmpfname, O_CREAT | O_RDWR | O_EXCL,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0S_IRUSR | S_IWUSR);
>> - =A0 =A0 =A0 =A0if (fd =3D=3D -1)
>> - =A0 =A0 =A0 =A0{
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(TNAME " Error at open(): %s\n",
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 strerror(errno));
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit(PTS_UNRESOLVED);
>> - =A0 =A0 =A0 =A0}
>> + =A0 =A0 snprintf(tmpfname, sizeof(tmpfname), "/tmp/pts_aio_error_3_1_%=
d",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0getpid());
>> + =A0 =A0 unlink(tmpfname);
>> + =A0 =A0 fd =3D open(tmpfname, O_CREAT | O_RDWR | O_EXCL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 S_IRUSR | S_IWUSR);
>> + =A0 =A0 if (fd =3D=3D -1)
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printf(TNAME " Error at open(): %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0strerror(errno));
>> + =A0 =A0 =A0 =A0 =A0 =A0 exit(PTS_UNRESOLVED);
>> + =A0 =A0 }
>>
>> - =A0 =A0 =A0 =A0unlink(tmpfname);
>> + =A0 =A0 unlink(tmpfname);
>>
>> =A0 =A0 =A0 memset (&aiocb, 0, sizeof (struct aiocb));
>>
>> - =A0 =A0 =A0 =A0aiocb.aio_fildes =3D fd;
>> - =A0 =A0 =A0 =A0aiocb.aio_buf =3D buf;
>> - =A0 =A0 =A0 =A0aiocb.aio_reqprio =3D -1;
>> - =A0 =A0 =A0 =A0aiocb.aio_nbytes =3D BUF_SIZE;
>> + =A0 =A0 aiocb.aio_fildes =3D fd;
>> + =A0 =A0 aiocb.aio_buf =3D buf;
>> + =A0 =A0 aiocb.aio_reqprio =3D -1;
>> + =A0 =A0 aiocb.aio_nbytes =3D BUF_SIZE;
>>
>> - =A0 =A0 =A0 =A0if (aio_write(&aiocb) !=3D 0)
>> + =A0 =A0 if (aio_write(&aiocb) =3D=3D 0)
>> =A0 =A0 =A0 {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf(TNAME " bad aio_read return valu=
e()\n");
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit(PTS_FAIL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 printf(TNAME " bad aio_write return value()\n"=
);
>> + =A0 =A0 =A0 =A0 =A0 =A0 exit(PTS_FAIL);
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 while (aio_error (&aiocb) =3D=3D EINPROGRESS);

    I'll respond to this sometime in the next couple of days after I
do some more investigation on the issue.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
