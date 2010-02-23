Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Njolz-0007Z7-Rt
	for ltp-list@lists.sourceforge.net; Tue, 23 Feb 2010 07:01:35 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Njoly-0007P5-NT
	for ltp-list@lists.sourceforge.net; Tue, 23 Feb 2010 07:01:35 +0000
Received: by pvf33 with SMTP id 33so239909pvf.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Feb 2010 23:01:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41002222252h327ea723wd1500698072dd7a8@mail.gmail.com>
References: <364299f41002221015q76fb174eq268c7badb9ce8031@mail.gmail.com>
	<OFDC4137DB.DFEF0244-ON652576D3.0022D5C8-652576D3.002504C8@in.ibm.com>
	<364299f41002222252h327ea723wd1500698072dd7a8@mail.gmail.com>
Date: Mon, 22 Feb 2010 23:01:28 -0800
Message-ID: <364299f41002222301v5100329bk3e2d2b2a092515a4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [ANNOUNCEMENT]: Intermediate release for FEB'10
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4003727404561269698=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Iranna D Ankad <iranna.ankad@in.ibm.com>
Cc: Rishikesh K Rajak <risrajak@in.ibm.com>, LTP <ltp-list@lists.sourceforge.net>

--===============4003727404561269698==
Content-Type: multipart/alternative; boundary=000e0cd17a127214cf04803f1e04

--000e0cd17a127214cf04803f1e04
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Feb 22, 2010 at 10:52 PM, Garrett Cooper <yanegomi@gmail.com> wrote:

> On Mon, Feb 22, 2010 at 10:41 PM, Iranna D Ankad <iranna.ankad@in.ibm.com>wrote:
>
>>
>> << Iranna,
>> <<I've stumbled down this bloody hole too many times to know that we
>> should NOT be too hasty in jumping down here again.
>> << 1. How did you compile everything (STEP BY STEP... from scratch after
>> getting autotools, etc)?
>> << 2. If you are running autotools, you DO realize that you're running
>> with an incompatible copy of autoconf, correct? INSTALL explicitly states:
>>
>> Hi Garrett,
>> I am running one of the RHEL distro's with default versions of make,
>> automake & autoconf. As you pointed out may be my OS has older versions of
>> automake & autoconf than recommended but I am running right version of make
>> (i.e make-3.81-3.el5). I think, when I am just building LTP using make, I do
>> not think autoconf will interfere here?
>>
>> Here are the steps I am using to compile LTP:
>> #./configure
>> # make
>> ........... hitting reported build errors here ............
>>
>
>     Please run `make ac-clean', then run `./configure ; make' . It looks
> like the tarball wasn't purged of all configure generated files.
> Thanks,
> -Garrett
>

Make sure to save aclocal.m4 though -- it shouldn't be cleaned out by
ac-clean, but is with the tarball (fixed on HEAD).
Thanks,
-GArrett

--000e0cd17a127214cf04803f1e04
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Mon, Feb 22, 2010 at 10:52 PM, Garrett Cooper=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:yanegomi@gmail.com">yanegomi@gmail=
.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"bo=
rder-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding=
-left: 1ex;">
<div class=3D"gmail_quote"><div class=3D"im">On Mon, Feb 22, 2010 at 10:41 =
PM, Iranna D Ankad <span dir=3D"ltr">&lt;<a href=3D"mailto:iranna.ankad@in.=
ibm.com" target=3D"_blank">iranna.ankad@in.ibm.com</a>&gt;</span> wrote:<br=
><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204,=
 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">

<div>
<br><font size=3D"3">&lt;&lt; Iranna,<br>
&lt;&lt;I&#39;ve stumbled down this bloody hole too many times to know that
we should NOT be too hasty in jumping down here again.<br>
&lt;&lt; 1. How did you compile everything (STEP BY STEP... from scratch
after getting autotools, etc)?</font>
<br><font size=3D"3">&lt;&lt; 2. If you are running autotools, you DO reali=
ze
that you&#39;re running with an incompatible copy of autoconf, correct? INS=
TALL
explicitly states:<br>
</font>
<br></div><font face=3D"sans-serif" size=3D"2">Hi Garrett,</font>
<br><font face=3D"sans-serif" size=3D"2">I am running one of the RHEL distr=
o&#39;s
with default versions of make, automake &amp; autoconf. As you pointed
out may be my OS has older versions of automake &amp; autoconf than recomme=
nded
but I am running right version of make (i.e make-3.81-3.el5). I think,
when I am just building LTP using make, I do not think autoconf will interf=
ere
here?</font>
<br>
<br><font face=3D"sans-serif" size=3D"2">Here are the steps I am using to c=
ompile
LTP:</font>
<br><font face=3D"sans-serif" size=3D"2">#./configure</font>
<br><font face=3D"sans-serif" size=3D"2"># make</font>
<br><font face=3D"sans-serif" size=3D"2">........... hitting reported build=
 errors
here ............</font><br></blockquote></div><div><br>=A0=A0=A0 Please ru=
n `make ac-clean&#39;, then run `./configure ; make&#39; . It looks like th=
e tarball wasn&#39;t purged of all configure generated files.<br>Thanks,<br=
>
<font color=3D"#888888">-Garrett </font><br></div></div></blockquote><div><=
br>Make sure to save aclocal.m4 though -- it shouldn&#39;t be cleaned out b=
y ac-clean, but is with the tarball (fixed on HEAD).<br>Thanks,<br>-GArrett=
 <br>
</div></div>

--000e0cd17a127214cf04803f1e04--


--===============4003727404561269698==
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
--===============4003727404561269698==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4003727404561269698==--

