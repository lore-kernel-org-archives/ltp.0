Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Njcou-0008S2-9O
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 18:15:48 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Njcos-00040r-QP
	for ltp-list@lists.sourceforge.net; Mon, 22 Feb 2010 18:15:48 +0000
Received: by pwi5 with SMTP id 5so2502158pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Feb 2010 10:15:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <OF7B2672AC.4ABA3E07-ON652576D2.005673AB-652576D2.005717E8@in.ibm.com>
References: <4B823681.7010300@linux.vnet.ibm.com>
	<OF7B2672AC.4ABA3E07-ON652576D2.005673AB-652576D2.005717E8@in.ibm.com>
Date: Mon, 22 Feb 2010 10:15:40 -0800
Message-ID: <364299f41002221015q76fb174eq268c7badb9ce8031@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============5497154523859443413=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Iranna D Ankad <iranna.ankad@in.ibm.com>
Cc: Rishikesh K Rajak <risrajak@in.ibm.com>, LTP <ltp-list@lists.sourceforge.net>, Vishukumar S Shetty <svishuku@in.ibm.com>

--===============5497154523859443413==
Content-Type: multipart/alternative; boundary=000e0cd11246b8b0040480346b73

--000e0cd11246b8b0040480346b73
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 22, 2010 at 7:48 AM, Iranna D Ankad <iranna.ankad@in.ibm.com>wr=
ote:

>
> Hello Rishi,
> LTP compilation on my system halted with below build errors, please check
> this out.    Thanks!
>
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall
>  -I/root/ltp-intermediate-20100228/testcases/kernel/include
> -I/root/ltp-intermediate-20100228/testcases/kernel/syscalls/mbind/../util=
s/
> -I../../../../include -I../../../../include   -L../../../../lib  mbind01.=
c
> -lltp -lnuma -o mbind01
> mbind01.c:184: error: =91MPOL_DEFAULT=92 undeclared here (not in a functi=
on)
> mbind01.c:196: error: =91MPOL_BIND=92 undeclared here (not in a function)
> mbind01.c:208: error: =91MPOL_INTERLEAVE=92 undeclared here (not in a fun=
ction)
> mbind01.c:220: error: =91MPOL_PREFERRED=92 undeclared here (not in a func=
tion)
> mbind01.c: In function =91do_test=92:
> mbind01.c:309: error: =91MPOL_F_ADDR=92 undeclared (first use in this fun=
ction)
> mbind01.c:309: error: (Each undeclared identifier is reported only once
> mbind01.c:309: error: for each function it appears in.)
> mbind01.c:317: warning: comparison between pointer and integer
> mbind01.c:319: warning: comparison between pointer and integer
> make[4]: *** [mbind01] Error 1
> make[4]: Leaving directory
> `/root/ltp-intermediate-20100228/testcases/kernel/syscalls/mbind'
> make[3]: *** [all] Error 2
> make[3]: Leaving directory
> `/root/ltp-intermediate-20100228/testcases/kernel/syscalls'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory
> `/root/ltp-intermediate-20100228/testcases/kernel'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/root/ltp-intermediate-20100228/testcases'
> make: *** [testcases-all] Error 2
> [root@mx3655 ltp-intermediate-20100228]#
>
> Here are the make & autoconf versions I am running.
>
> [root@mx3655 ltp-intermediate-20100228]# rpm -qa | grep make
> automake14-1.4p6-13
> imake-1.0.2-3
> automake17-1.7.9-7
> automake15-1.5-16
> automake16-1.6.3-8
> make-3.81-3.el5
> automake-1.9.6-2.1
> [root@mx3655 ltp-intermediate-20100228]# rpm -qa | grep autoconf
> autoconf-2.59-12
> [root@mx3655 ltp-intermediate-20100228]#
>
>
> -Iranna D Ankad
>
> -------------------------------------------------------------------------=
---------------------------
> Linux-Technology Center, IBM India Software Labs
> Manyata Embassy Park, BENGALURU - 560045,
> Ph: +91-080-28055007   Extn: 55007
>
> -------------------------------------------------------------------------=
---------------------------
> "If you don't have patience to test the software, the software will test
> your patience !!"
>
>
>  *Rishikesh <risrajak@linux.vnet.ibm.com>*
>
> 02/22/10 01:17 PM
>   To
> LTP <ltp-list@lists.sourceforge.net>
> cc
> Garrett Cooper <yanegomi@gmail.com>, Rishikesh K Rajak/India/IBM@IBMIN,
> Vishukumar S Shetty/India/IBM@IBMIN, Iranna D Ankad/India/IBM@IBMIN
> Subject
> [ANNOUNCEMENT]: Intermediate release for FEB'10
>
>
>
>
> Hi All,
>
> Welcome to ltp community.
>
> The February 2010 Intermediate release is out now. This build contains
> many fixes. Changelog you can find as attached.
>
> You can directly download from:
>
> https://sourceforge.net/projects/ltp/files/LTP%20Source/ltp-20100228/ltp-=
intermediate-20100228.tgz/download
>
> And for more details you can just have a look to ltp Home Page:
> http://ltp.sourceforge.net/
>
> --
> Thanks&  Regards
> Rishi Kesh K Rajak
> IBM LTC, Bangalore
> LTP Maintainer
> Please join IRC: #ltp @ freenode.net
>
> [attachment "ChangeLog.new" deleted by Iranna D Ankad/India/IBM]
>

Iranna,

I've stumbled down this bloody hole too many times to know that we should
NOT be too hasty in jumping down here again.
1. How did you compile everything (STEP BY STEP... from scratch after
getting autotools, etc)?
2. If you are running autotools, you DO realize that you're running with an
incompatible copy of autoconf, correct? INSTALL explicitly states:

make 3.81 can be obtained here:
- http://ftp.gnu.org/gnu/make/make-3.81.tar.bz2

------------------------> If you want to use auto configuration, be sure
autoconf-2.61+ & automake-1.10+ <------------------------
are installed.

automake-1.10.2's sources can be downloaded from:
- ftp://ftp.gnu.org/gnu/automake/automake-1.10.2.tar.bz2
- ftp://ftp.gnu.org/gnu/automake/automake-1.10.2.tar.gz

autoconf-2.61's sources can be downloaded from:
- ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.61.tar.bz2
- ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.61.tar.gz

autoconf-2.61 also requires m4-1.4.7+ be installed. Its sources can be
downloaded from:
- http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.bz2
- http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.gz

The default autoconfed files were made available for folks to tune so they
could avoid issues with having to write everything from scratch. As such, i=
t
is your job to a) download and setup appropriate software versions of
autotools so the configuration is done correctly, automatically, or b)
properly configure the file(s) so that everything "works".

Thanks,
-Garrett

--000e0cd11246b8b0040480346b73
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Mon, Feb 22, 2010 at 7:48 AM, Iranna D Ankad =
<span dir=3D"ltr">&lt;<a href=3D"mailto:iranna.ankad@in.ibm.com">iranna.ank=
ad@in.ibm.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex=
; padding-left: 1ex;">

<br><font face=3D"sans-serif" size=3D"2">Hello Rishi,</font>
<br><font face=3D"sans-serif" size=3D"2">LTP compilation on my system halte=
d
with below build errors, please check this out. =A0 =A0Thanks!</font>
<br>
<br><font face=3D"sans-serif" size=3D"2">gcc -g -O2 -g -O2 -fno-strict-alia=
sing
-pipe -Wall =A0-I/root/ltp-intermediate-20100228/testcases/kernel/include
-I/root/ltp-intermediate-20100228/testcases/kernel/syscalls/mbind/../utils/
-I../../../../include -I../../../../include =A0 -L../../../../lib =A0mbind0=
1.c
=A0 -lltp -lnuma -o mbind01</font>
<br><font face=3D"sans-serif" size=3D"2">mbind01.c:184: error: =91MPOL_DEFA=
ULT=92
undeclared here (not in a function)</font>
<br><font face=3D"sans-serif" size=3D"2">mbind01.c:196: error: =91MPOL_BIND=
=92
undeclared here (not in a function)</font>
<br><font face=3D"sans-serif" size=3D"2">mbind01.c:208: error: =91MPOL_INTE=
RLEAVE=92
undeclared here (not in a function)</font>
<br><font face=3D"sans-serif" size=3D"2">mbind01.c:220: error: =91MPOL_PREF=
ERRED=92
undeclared here (not in a function)</font>
<br><font face=3D"sans-serif" size=3D"2">mbind01.c: In function =91do_test=
=92:</font>
<br><font face=3D"sans-serif" size=3D"2">mbind01.c:309: error: =91MPOL_F_AD=
DR=92
undeclared (first use in this function)</font>
<br><font face=3D"sans-serif" size=3D"2">mbind01.c:309: error: (Each undecl=
ared
identifier is reported only once</font>
<br><font face=3D"sans-serif" size=3D"2">mbind01.c:309: error: for each fun=
ction
it appears in.)</font>
<br><font face=3D"sans-serif" size=3D"2">mbind01.c:317: warning: comparison=
 between
pointer and integer</font>
<br><font face=3D"sans-serif" size=3D"2">mbind01.c:319: warning: comparison=
 between
pointer and integer</font>
<br><font face=3D"sans-serif" size=3D"2">make[4]: *** [mbind01] Error 1</fo=
nt>
<br><font face=3D"sans-serif" size=3D"2">make[4]: Leaving directory `/root/=
ltp-intermediate-20100228/testcases/kernel/syscalls/mbind&#39;</font>
<br><font face=3D"sans-serif" size=3D"2">make[3]: *** [all] Error 2</font>
<br><font face=3D"sans-serif" size=3D"2">make[3]: Leaving directory `/root/=
ltp-intermediate-20100228/testcases/kernel/syscalls&#39;</font>
<br><font face=3D"sans-serif" size=3D"2">make[2]: *** [all] Error 2</font>
<br><font face=3D"sans-serif" size=3D"2">make[2]: Leaving directory `/root/=
ltp-intermediate-20100228/testcases/kernel&#39;</font>
<br><font face=3D"sans-serif" size=3D"2">make[1]: *** [all] Error 2</font>
<br><font face=3D"sans-serif" size=3D"2">make[1]: Leaving directory `/root/=
ltp-intermediate-20100228/testcases&#39;</font>
<br><font face=3D"sans-serif" size=3D"2">make: *** [testcases-all] Error 2<=
/font>
<br><font face=3D"sans-serif" size=3D"2">[root@mx3655 ltp-intermediate-2010=
0228]#
</font>
<br>
<br><font face=3D"sans-serif" size=3D"2">Here are the make &amp; autoconf v=
ersions
I am running.</font>
<br>
<br><font face=3D"sans-serif" size=3D"2">[root@mx3655 ltp-intermediate-2010=
0228]#
rpm -qa | grep make</font>
<br><font face=3D"sans-serif" size=3D"2">automake14-1.4p6-13</font>
<br><font face=3D"sans-serif" size=3D"2">imake-1.0.2-3</font>
<br><font face=3D"sans-serif" size=3D"2">automake17-1.7.9-7</font>
<br><font face=3D"sans-serif" size=3D"2">automake15-1.5-16</font>
<br><font face=3D"sans-serif" size=3D"2">automake16-1.6.3-8</font>
<br><font face=3D"sans-serif" size=3D"2">make-3.81-3.el5</font>
<br><font face=3D"sans-serif" size=3D"2">automake-1.9.6-2.1</font>
<br><font face=3D"sans-serif" size=3D"2">[root@mx3655 ltp-intermediate-2010=
0228]#
rpm -qa | grep autoconf</font>
<br><font face=3D"sans-serif" size=3D"2">autoconf-2.59-12</font>
<br><font face=3D"sans-serif" size=3D"2">[root@mx3655 ltp-intermediate-2010=
0228]#</font>
<br>
<br>
<br><font face=3D"sans-serif" size=3D"2">-Iranna D Ankad<br>
---------------------------------------------------------------------------=
-------------------------<br>
Linux-Technology Center, IBM India Software Labs<br>
Manyata Embassy Park, BENGALURU - 560045,<br>
Ph: +91-080-28055007 =A0 Extn: 55007<br>
---------------------------------------------------------------------------=
-------------------------<br>
&quot;If you don&#39;t have patience to test the software, the software wil=
l
test your patience !!&quot;</font>
<br>
<br>
<br>
<table width=3D"100%">
<tbody><tr valign=3D"top">
<td width=3D"40%"><font face=3D"sans-serif" size=3D"1"><b>Rishikesh &lt;<a =
href=3D"mailto:risrajak@linux.vnet.ibm.com" target=3D"_blank">risrajak@linu=
x.vnet.ibm.com</a>&gt;</b>
</font>
<p><font face=3D"sans-serif" size=3D"1">02/22/10 01:17 PM</font>
</p></td><td width=3D"59%">
<table width=3D"100%">
<tbody><tr valign=3D"top">
<td>
<div align=3D"right"><font face=3D"sans-serif" size=3D"1">To</font></div>
</td><td><font face=3D"sans-serif" size=3D"1">LTP &lt;<a href=3D"mailto:ltp=
-list@lists.sourceforge.net" target=3D"_blank">ltp-list@lists.sourceforge.n=
et</a>&gt;</font>
</td></tr><tr valign=3D"top">
<td>
<div align=3D"right"><font face=3D"sans-serif" size=3D"1">cc</font></div>
</td><td><font face=3D"sans-serif" size=3D"1">Garrett Cooper &lt;<a href=3D=
"mailto:yanegomi@gmail.com" target=3D"_blank">yanegomi@gmail.com</a>&gt;,
Rishikesh K Rajak/India/IBM@IBMIN, Vishukumar S Shetty/India/IBM@IBMIN,
Iranna D Ankad/India/IBM@IBMIN</font>
</td></tr><tr valign=3D"top">
<td>
<div align=3D"right"><font face=3D"sans-serif" size=3D"1">Subject</font></d=
iv>
</td><td><font face=3D"sans-serif" size=3D"1">[ANNOUNCEMENT]: Intermediate =
release
for FEB&#39;10</font></td></tr></tbody></table>
<br>
<table>
<tbody><tr valign=3D"top">
<td>
</td><td></td></tr></tbody></table>
<br></td></tr></tbody></table>
<br>
<br>
<br><tt><font size=3D"2"><div><div></div><div class=3D"h5">Hi All,<br>
<br>
Welcome to ltp community.<br>
<br>
The February 2010 Intermediate release is out now. This build contains<br>
many fixes. Changelog you can find as attached.<br>
<br>
You can directly download from:<br>
<a href=3D"https://sourceforge.net/projects/ltp/files/LTP%20Source/ltp-2010=
0228/ltp-intermediate-20100228.tgz/download" target=3D"_blank">https://sour=
ceforge.net/projects/ltp/files/LTP%20Source/ltp-20100228/ltp-intermediate-2=
0100228.tgz/download</a><br>

<br>
And for more details you can just have a look to ltp Home Page: <br>
<a href=3D"http://ltp.sourceforge.net/" target=3D"_blank">http://ltp.source=
forge.net/</a><br>
<br>
-- <br>
Thanks&amp; =A0Regards<br>
Rishi Kesh K Rajak<br>
IBM LTC, Bangalore<br>
LTP Maintainer<br>
Please join IRC: #ltp @ <a href=3D"http://freenode.net" target=3D"_blank">f=
reenode.net</a><br>
<br></div></div>
[attachment &quot;ChangeLog.new&quot; deleted by Iranna D Ankad/India/IBM]
</font></tt>
<br>
</blockquote></div><br>Iranna,<br><br>I&#39;ve stumbled down this bloody ho=
le too many times to know that we should NOT be too hasty in jumping down h=
ere again.<br>1. How did you compile everything (STEP BY STEP... from scrat=
ch after getting autotools, etc)?<br>
2. If you are running autotools, you DO realize that you&#39;re running wit=
h an incompatible copy of autoconf, correct? INSTALL explicitly states:<br>=
<br>make 3.81 can be obtained here:<br>- <a href=3D"http://ftp.gnu.org/gnu/=
make/make-3.81.tar.bz2">http://ftp.gnu.org/gnu/make/make-3.81.tar.bz2</a><b=
r>
<br>------------------------&gt; If you want to use auto configuration, be =
sure autoconf-2.61+ &amp; automake-1.10+ &lt;------------------------<br>ar=
e installed.<br><br>automake-1.10.2&#39;s sources can be downloaded from:<b=
r>
- <a href=3D"ftp://ftp.gnu.org/gnu/automake/automake-1.10.2.tar.bz2">ftp://=
ftp.gnu.org/gnu/automake/automake-1.10.2.tar.bz2</a><br>- <a href=3D"ftp://=
ftp.gnu.org/gnu/automake/automake-1.10.2.tar.gz">ftp://ftp.gnu.org/gnu/auto=
make/automake-1.10.2.tar.gz</a><br>
<br>autoconf-2.61&#39;s sources can be downloaded from:<br>- <a href=3D"ftp=
://ftp.gnu.org/gnu/autoconf/autoconf-2.61.tar.bz2">ftp://ftp.gnu.org/gnu/au=
toconf/autoconf-2.61.tar.bz2</a><br>- <a href=3D"ftp://ftp.gnu.org/gnu/auto=
conf/autoconf-2.61.tar.gz">ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.61.tar=
.gz</a><br>
<br>autoconf-2.61 also requires m4-1.4.7+ be installed. Its sources can be<=
br>downloaded from:<br>- <a href=3D"http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.=
bz2">http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.bz2</a><br>- <a href=3D"http://=
ftp.gnu.org/gnu/m4/m4-1.4.7.tar.gz">http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.=
gz</a><br>
<br>The default autoconfed files were made available for folks to tune so t=
hey could avoid issues with having to write everything from scratch. As suc=
h, it is your job to a) download and setup appropriate software versions of=
 autotools so the configuration is done correctly, automatically, or b) pro=
perly configure the file(s) so that everything &quot;works&quot;.<br>
<br>Thanks,<br>-Garrett<br>

--000e0cd11246b8b0040480346b73--


--===============5497154523859443413==
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
--===============5497154523859443413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5497154523859443413==--

