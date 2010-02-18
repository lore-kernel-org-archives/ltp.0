Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <md.zafar.ziya@gmail.com>) id 1Nhx4U-0005RA-Vo
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 03:28:58 +0000
Received: from mail-pz0-f187.google.com ([209.85.222.187])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nhx4Q-0001eD-IF
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 03:28:58 +0000
Received: by pzk17 with SMTP id 17so7124093pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Feb 2010 19:28:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20100217120746.GA5966@rishikesh.in.ibm.com>
References: <4B7BA709.8080306@linux.vnet.ibm.com>
	<70aae6bd1002170035j6b8ad2a3la26a90d13b7b800e@mail.gmail.com>
	<20100217120746.GA5966@rishikesh.in.ibm.com>
Date: Thu, 18 Feb 2010 08:58:48 +0530
Message-ID: <70aae6bd1002171928r7b86a5c2g568117a65dc462fe@mail.gmail.com>
From: md zafar ziya <md.zafar.ziya@gmail.com>
Subject: Re: [LTP] CAN LTP BE CROSS COMPILED FOR ANDROID PLATFORM
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4641984577655659189=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Rishikesh K Rajak <rishikesh@rishikesh.in.ibm.com>
Cc: ltp-list@lists.sourceforge.net

--===============4641984577655659189==
Content-Type: multipart/alternative; boundary=0016e64cbaecae0281047fd79050

--0016e64cbaecae0281047fd79050
Content-Type: text/plain; charset=ISO-8859-1

Hello Rishikesh,

1.All LTP application has to compiled against Android bionic library.
2.Use Android Target Cross compiler for building Testcases executables(That
use compiler builtin API also).
3.Android libraray dont have -lrt and -lpthread library,Real time
library(rt) and Thread library(pthread) are not defined inside Bionic,so
just remove these entries from Makefile because these library function are
being moved to bionic C library and for thread API include proper header
file only.
4.Header files are placed to different location in bionic ,So update the
source as per requirement.
5.to run LTP on android based target,use busybox(Cross compiled for
android:Path-http://benno.id.au/blog/2007/11/14/android-busybox).Push to
target and use.
6.Modify script as per requirement because android based target has
different interpretation.
7.Push only scripts and binary of the executables(because of memory
constraints) inside target.
8.Run runltp


The above steps anyone can follow to cross compile LTP to ANDROID and run on
target.

My Job was not to add new test cases(To check kernel stability only),so i
didnt think about that so far.

But i would like to contribute new test case to LTP in the future.LTP is
very good project,If any one would add test cases that can show benchmark of
different interrupt latency ,that will be big advantage for LTP future and
it can make LTP popular among developers.

Thank you

Regards

md zafar ziya


On Wed, Feb 17, 2010 at 5:37 PM, Rishikesh K Rajak <
rishikesh@rishikesh.in.ibm.com> wrote:

> On Wed, Feb 17, 2010 at 02:05:38PM +0530, md zafar ziya wrote:
> > Hello Rishikesh,
> >
> > Thanks for support.
> >
> > LTP cross compilation is being done(Specific test cases for Testing linux
> > kernel features only).
> >
> > If any one want assistance, Contact on zafar.ziya@samsung.com or
> > md.zafar.ziya@gmail.com
> Hi Zafar,
>
> Good to know that it worked for you. It will helpful if you could
> explain the steps here so that everyone over can take the advantage. Also
> let
> us know if you have have faced some hurdles while solving this issue.
>
> And also any plans for new contribution to ltp with new testcases ?
>
> Thanks
> -Rishi
> >
> > Thank you again.
> >
> > regards
> >
> > Zafar ziya
> >
> > On Wed, Feb 17, 2010 at 1:51 PM, Rishikesh <risrajak@linux.vnet.ibm.com
> >wrote:
> >
> > > Hi All,
> > >
> > > Please help Zafar, if anyone has compiled LTP on andriod .
> > >
> > > Ref Mail:
> > > http://marc.info/?l=ltp-list&m=126286998319361&w=2
> > >
> > > --
> > > Thanks&  Regards
> > > Rishi Kesh K Rajak
> > > IBM LTC, Bangalore
> > > LTP Maintainer
> > > Please join IRC: #ltp @ freenode.net
> > >
> > >
>

--0016e64cbaecae0281047fd79050
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello Rishikesh,<br><br>1.All LTP application has to compiled against Andro=
id bionic library.<br>2.Use Android Target Cross compiler for building Test=
cases executables(That use compiler builtin API also).<br>3.Android librara=
y dont have -lrt and -lpthread library,Real time library(rt) and Thread lib=
rary(pthread) are not defined inside Bionic,so just remove these entries fr=
om Makefile because these library function are being moved to bionic C libr=
ary and for thread API include proper header file only.<br>
4.Header files are placed to different location in bionic ,So update the so=
urce as per requirement.<br><a href=3D"http://5.to">5.to</a> run LTP on and=
roid based target,use busybox(Cross compiled for android:Path-<a href=3D"ht=
tp://benno.id.au/blog/2007/11/14/android-busybox).Push">http://benno.id.au/=
blog/2007/11/14/android-busybox).Push</a> to target and use.<br>
6.Modify script as per requirement because android based target has differe=
nt interpretation.<br>7.Push only scripts and binary of the executables(bec=
ause of memory constraints) inside target.<br>8.Run runltp<br><br><br>The a=
bove steps anyone can follow to cross compile LTP to ANDROID and run on tar=
get.<br>
<br>My Job was not to add new test cases(To check kernel stability only),so=
 i didnt think about that so far.<br><br>But i would like to contribute new=
 test case to LTP in the future.LTP is very good project,If any one would a=
dd test cases that can show benchmark of different interrupt latency ,that =
will be big advantage for LTP future and it can make LTP popular among deve=
lopers.<br>
<br>Thank you<br><br>Regards<br><br>md zafar ziya<br><br><br><div class=3D"=
gmail_quote">On Wed, Feb 17, 2010 at 5:37 PM, Rishikesh K Rajak <span dir=
=3D"ltr">&lt;<a href=3D"mailto:rishikesh@rishikesh.in.ibm.com">rishikesh@ri=
shikesh.in.ibm.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>On Wed, Feb 17, 2010 at 02:05:38PM +0530, md zafar ziya wrote:<br>
&gt; Hello Rishikesh,<br>
&gt;<br>
&gt; Thanks for support.<br>
&gt;<br>
&gt; LTP cross compilation is being done(Specific test cases for Testing li=
nux<br>
&gt; kernel features only).<br>
&gt;<br>
&gt; If any one want assistance, Contact on <a href=3D"mailto:zafar.ziya@sa=
msung.com">zafar.ziya@samsung.com</a> or<br>
&gt; <a href=3D"mailto:md.zafar.ziya@gmail.com">md.zafar.ziya@gmail.com</a>=
<br>
</div>Hi Zafar,<br>
<br>
Good to know that it worked for you. It will helpful if you could<br>
explain the steps here so that everyone over can take the advantage. Also l=
et<br>
us know if you have have faced some hurdles while solving this issue.<br>
<br>
And also any plans for new contribution to ltp with new testcases ?<br>
<br>
Thanks<br>
-Rishi<br>
<div><div></div><div class=3D"h5">&gt;<br>
&gt; Thank you again.<br>
&gt;<br>
&gt; regards<br>
&gt;<br>
&gt; Zafar ziya<br>
&gt;<br>
&gt; On Wed, Feb 17, 2010 at 1:51 PM, Rishikesh &lt;<a href=3D"mailto:risra=
jak@linux.vnet.ibm.com">risrajak@linux.vnet.ibm.com</a>&gt;wrote:<br>
&gt;<br>
&gt; &gt; Hi All,<br>
&gt; &gt;<br>
&gt; &gt; Please help Zafar, if anyone has compiled LTP on andriod .<br>
&gt; &gt;<br>
&gt; &gt; Ref Mail:<br>
&gt; &gt; <a href=3D"http://marc.info/?l=3Dltp-list&amp;m=3D126286998319361=
&amp;w=3D2" target=3D"_blank">http://marc.info/?l=3Dltp-list&amp;m=3D126286=
998319361&amp;w=3D2</a><br>
&gt; &gt;<br>
&gt; &gt; --<br>
&gt; &gt; Thanks&amp; =A0Regards<br>
&gt; &gt; Rishi Kesh K Rajak<br>
&gt; &gt; IBM LTC, Bangalore<br>
&gt; &gt; LTP Maintainer<br>
&gt; &gt; Please join IRC: #ltp @ <a href=3D"http://freenode.net" target=3D=
"_blank">freenode.net</a><br>
&gt; &gt;<br>
&gt; &gt;<br>
</div></div></blockquote></div><br>

--0016e64cbaecae0281047fd79050--


--===============4641984577655659189==
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
--===============4641984577655659189==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4641984577655659189==--

