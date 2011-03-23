Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <joshiplns@gmail.com>) id 1Q2OYz-00046Q-0N
	for ltp-list@lists.sourceforge.net; Wed, 23 Mar 2011 13:57:29 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.74) id 1Q2OYy-0005rg-4H
	for ltp-list@lists.sourceforge.net; Wed, 23 Mar 2011 13:57:28 +0000
Received: by gyf1 with SMTP id 1so3277993gyf.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 23 Mar 2011 06:57:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTinnnh7H2fjxSfnnc7JsSFdTBQWCDeWTkzWMDCRO@mail.gmail.com>
References: <AANLkTinnnh7H2fjxSfnnc7JsSFdTBQWCDeWTkzWMDCRO@mail.gmail.com>
Date: Wed, 23 Mar 2011 19:27:22 +0530
Message-ID: <AANLkTikTwg00-9HVMduSNJwqb1zSu579OvgV=U108M2b@mail.gmail.com>
From: Naveen Joshi - C and Linux <joshiplns@gmail.com>
Subject: Re: [LTP] New member to mailing list ..
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============9017761273856932138=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============9017761273856932138==
Content-Type: multipart/alternative; boundary=001517511e226cf571049f26bd48

--001517511e226cf571049f26bd48
Content-Type: text/plain; charset=ISO-8859-1

* meanwhile am trying to fix it as follows . *

*Previous Code *

*retval = aio_return(&aiocb)
if (retval != -1)
 {
       close()fd)
       printf(TNAME "Second call to aio_return() should return -1
:%d\n",retval)
       exit()

 }
*
*Modified Code By me*

*/* Second time am Calling here . SO it should give error as other than 0 */
 retval = aio_return(&aiocb)
  if (retval != 0)
  {
       close(fd)
       printf( "Test PASSED")
       exit()

  }*

*Fix for this BUG is Correct .. ? Please Give me your Valuable comments on
this .

Joshi*

On Wed, Mar 23, 2011 at 10:33 AM, Naveen Joshi - C and Linux <
joshiplns@gmail.com> wrote:

> Dear all ,
>
> This is Joshi . newer to LTP mailing list.
>
> Right now doing am testing with LTP. having some issues related aio_return.
> In aio_return/2-1.c
> vi 2-1.c
>
> *#define TNAME "aio_return/2-1.test"
> :
> Something
> :
>
> retval = aio_return(&aiocb)
> if (retval != -1)
> {
>      close()fd)
>
>      printf(TNAME "Second call to aio_return() should return -1 :%d\n",retval)
>      exit()
>
> }
>
> Here i calling aio_return(&aiocb)for 3 times . but **if i call aio_return(&aiocb)2nd ti,e it should fail means it should return
>
> -1 . in my program its retuning other than -1 . SO test is failing here . Can any one suggest to fix the bug .
>
> Thank you
> Joshi*
>
>
>
>  .
>

--001517511e226cf571049f26bd48
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<b><span style=3D"font-family: trebuchet ms,sans-serif;"> meanwhile am tryi=
ng to fix it as follows . </span></b><br style=3D"font-family: trebuchet ms=
,sans-serif;">
<br style=3D"font-family: trebuchet ms,sans-serif;">
<b><span style=3D"font-family: trebuchet ms,sans-serif;">Previous Code </sp=
an></b><br style=3D"font-family: trebuchet ms,sans-serif;">
<br style=3D"font-family: trebuchet ms,sans-serif;">
<b><span style=3D"font-family: trebuchet ms,sans-serif; color: rgb(255, 0, =
0);">retval =3D aio_return(&amp;aiocb)</span><br style=3D"font-family: treb=
uchet ms,sans-serif; color: rgb(255, 0, 0);">
  <span style=3D"font-family: trebuchet ms,sans-serif; color: rgb(255, 0, 0=
);">if (retval !=3D -1)</span><br style=3D"font-family: trebuchet ms,sans-s=
erif; color: rgb(255, 0, 0);">
  <span style=3D"font-family: trebuchet ms,sans-serif; color: rgb(255, 0, 0=
);">

{</span><br style=3D"font-family: trebuchet ms,sans-serif; color: rgb(255, =
0, 0);">
  <span style=3D"font-family: trebuchet ms,sans-serif; color: rgb(255, 0, 0=
);">

=A0=A0 =A0=A0 close()fd)</span><br style=3D"font-family: trebuchet ms,sans-=
serif; color: rgb(255, 0, 0);">
  <span style=3D"font-family: trebuchet ms,sans-serif; color: rgb(255, 0, 0=
);">

=A0=A0 =A0=A0 printf(TNAME &quot;Second call to aio_return() should return =
-1 :%d\n&quot;,retval)</span><br style=3D"font-family: trebuchet ms,sans-se=
rif; color: rgb(255, 0, 0);">
  <span style=3D"font-family: trebuchet ms,sans-serif; color: rgb(255, 0, 0=
);">

=A0=A0 =A0=A0 exit()</span><br style=3D"font-family: trebuchet ms,sans-seri=
f; color: rgb(255, 0, 0);">
  <br style=3D"font-family: trebuchet ms,sans-serif; color: rgb(255, 0, 0);=
">
  <span style=3D"font-family: trebuchet ms,sans-serif; color: rgb(255, 0, 0=
);">=A0}</span><br style=3D"font-family: trebuchet ms,sans-serif;">
</b>

<br style=3D"font-family: trebuchet ms,sans-serif;">
<b><span style=3D"font-family: trebuchet ms,sans-serif;">Modified Code By m=
e</span></b><br style=3D"font-family: trebuchet ms,sans-serif;">
<br style=3D"font-family: trebuchet ms,sans-serif;">
<b><span style=3D"font-family: trebuchet ms,sans-serif; color: rgb(255, 0, =
0);">/* Second time am Calling here . SO it should give error as other than=
 0 */</span><br style=3D"font-family: trebuchet ms,sans-serif; color: rgb(2=
55, 0, 0);">

  <span style=3D"font-family: trebuchet ms,sans-serif; color: rgb(255, 0, 0=
);"> retval =3D aio_return(&amp;aiocb)</span><br style=3D"font-family: treb=
uchet ms,sans-serif; color: rgb(255, 0, 0);">
  <span style=3D"font-family: trebuchet ms,sans-serif; color: rgb(255, 0, 0=
);">=A0
if (retval !=3D 0)</span><br style=3D"font-family: trebuchet ms,sans-serif;=
 color: rgb(255, 0, 0);">
  <span style=3D"font-family: trebuchet ms,sans-serif; color: rgb(255, 0, 0=
);">=A0
{</span><br style=3D"font-family: trebuchet ms,sans-serif; color: rgb(255, =
0, 0);">
  <span style=3D"font-family: trebuchet ms,sans-serif; color: rgb(255, 0, 0=
);">
=A0=A0 =A0=A0 close(fd)</span><br style=3D"font-family: trebuchet ms,sans-s=
erif; color: rgb(255, 0, 0);">
  <span style=3D"font-family: trebuchet ms,sans-serif; color: rgb(255, 0, 0=
);">
=A0=A0 =A0=A0 printf( &quot;Test PASSED&quot;)</span><br style=3D"font-fami=
ly: trebuchet ms,sans-serif; color: rgb(255, 0, 0);">
  <span style=3D"font-family: trebuchet ms,sans-serif; color: rgb(255, 0, 0=
);">
=A0=A0 =A0=A0 exit()</span><br style=3D"font-family: trebuchet ms,sans-seri=
f; color: rgb(255, 0, 0);">
  <br style=3D"font-family: trebuchet ms,sans-serif; color: rgb(255, 0, 0);=
">
  <span style=3D"font-family: trebuchet ms,sans-serif; color: rgb(255, 0, 0=
);">=A0
}</span></b>
<br>
<br style=3D"font-family: trebuchet ms,sans-serif;">
<b><span style=3D"font-family: trebuchet ms,sans-serif;">Fix for this BUG i=
s Correct .. ? Please Give me your Valuable comments on this .</span><br st=
yle=3D"font-family: trebuchet ms,sans-serif;">
  <br style=3D"font-family: trebuchet ms,sans-serif;">
  <span style=3D"font-family: trebuchet ms,sans-serif;">Joshi</span></b><br=
><br><div class=3D"gmail_quote">On Wed, Mar 23, 2011 at 10:33 AM, Naveen Jo=
shi - C and Linux <span dir=3D"ltr">&lt;<a href=3D"mailto:joshiplns@gmail.c=
om">joshiplns@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><font style=3D"fo=
nt-family: trebuchet ms,sans-serif;" size=3D"4">Dear all ,<br><br>This is J=
oshi . newer to LTP mailing list.<br>
<br>Right now doing am testing with LTP. having some issues related aio_ret=
urn. In aio_return/2-1.c<br>
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
</blockquote></div><br>

--001517511e226cf571049f26bd48--


--===============9017761273856932138==
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
--===============9017761273856932138==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============9017761273856932138==--

