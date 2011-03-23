Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <joshiplns@gmail.com>) id 1Q2GEW-0005Zp-1j
	for ltp-list@lists.sourceforge.net; Wed, 23 Mar 2011 05:03:48 +0000
Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1Q2GEV-0000S8-At
	for ltp-list@lists.sourceforge.net; Wed, 23 Mar 2011 05:03:48 +0000
Received: by iyb26 with SMTP id 26so10488812iyb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 22 Mar 2011 22:03:42 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 23 Mar 2011 10:33:42 +0530
Message-ID: <AANLkTinnnh7H2fjxSfnnc7JsSFdTBQWCDeWTkzWMDCRO@mail.gmail.com>
From: Naveen Joshi - C and Linux <joshiplns@gmail.com>
Subject: [LTP] New member to mailing list ..
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7873594476452481179=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7873594476452481179==
Content-Type: multipart/alternative; boundary=0003255741d6dcc752049f1f483c

--0003255741d6dcc752049f1f483c
Content-Type: text/plain; charset=ISO-8859-1

Dear all ,

This is Joshi . newer to LTP mailing list.

Right now doing am testing with LTP. having some issues related aio_return.
In aio_return/2-1.c
vi 2-1.c

*#define TNAME "aio_return/2-1.test"
:
Something
:

retval = aio_return(&aiocb)
if (retval != -1)
{
     close()fd)
     printf(TNAME "Second call to aio_return() should return -1 :%d\n",retval)
     exit()

}

Here i calling aio_return(&aiocb)for 3 times . but **if i call
aio_return(&aiocb)2nd ti,e it should fail means it should return
-1 . in my program its retuning other than -1 . SO test is failing
here . Can any one suggest to fix the bug .

Thank you
Joshi*



 .

--0003255741d6dcc752049f1f483c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<font style=3D"font-family: trebuchet ms,sans-serif;" size=3D"4">Dear all ,=
<br><br>This is Joshi . newer to LTP mailing list.<br><br>Right now doing a=
m testing with LTP. having some issues related aio_return. In aio_return/2-=
1.c<br>
vi 2-1.c</font><br><pre><b><font style=3D"color: rgb(255, 0, 0);" size=3D"4=
">#define TNAME &quot;aio_return/2-1.test&quot;<br>:<br>Something<br>:<br><=
br>retval =3D aio_return(&amp;aiocb)<br>if (retval !=3D -1)<br>{<br>     cl=
ose()fd)<br>
     printf(TNAME &quot;Second call to aio_return() should return -1 :%d\n&=
quot;,retval)<br>     exit()<br><br>}</font><br><br style=3D"font-family: t=
ahoma,sans-serif;"><font style=3D"font-family: tahoma,sans-serif;" size=3D"=
4">Here i calling aio_return(&amp;aiocb)for 3 times . but</font><span style=
=3D"font-family: tahoma,sans-serif;"> </span></b><font><font size=3D"4"><b>=
<span style=3D"font-family: tahoma,sans-serif;">if i call aio_return(&amp;a=
iocb)2nd ti,e it should fail means it should return <br>
-1 . in my program its retuning other than -1 . SO test is failing here . C=
an any one suggest to fix the bug . <br><br>Thank you<br>Joshi</span></b><b=
r></font></font><br><br><br></pre>=A0. <br>

--0003255741d6dcc752049f1f483c--


--===============7873594476452481179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enable your software for Intel(R) Active Management Technology to meet the
growing manageability and security demands of your customers. Businesses
are taking advantage of Intel(R) vPro (TM) technology - will your software 
be a part of the solution? Download the Intel(R) Manageability Checker 
today! http://p.sf.net/sfu/intel-dev2devmar
--===============7873594476452481179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7873594476452481179==--

