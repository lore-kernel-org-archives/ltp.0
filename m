Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NjodD-0007cp-Gq
	for ltp-list@lists.sourceforge.net; Tue, 23 Feb 2010 06:52:31 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NjodB-0005QR-CW
	for ltp-list@lists.sourceforge.net; Tue, 23 Feb 2010 06:52:31 +0000
Received: by pvf33 with SMTP id 33so238839pvf.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 22 Feb 2010 22:52:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <OFDC4137DB.DFEF0244-ON652576D3.0022D5C8-652576D3.002504C8@in.ibm.com>
References: <364299f41002221015q76fb174eq268c7badb9ce8031@mail.gmail.com>
	<OFDC4137DB.DFEF0244-ON652576D3.0022D5C8-652576D3.002504C8@in.ibm.com>
Date: Mon, 22 Feb 2010 22:52:23 -0800
Message-ID: <364299f41002222252h327ea723wd1500698072dd7a8@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============7246569460279385420=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Iranna D Ankad <iranna.ankad@in.ibm.com>
Cc: Rishikesh K Rajak <risrajak@in.ibm.com>, LTP <ltp-list@lists.sourceforge.net>

--===============7246569460279385420==
Content-Type: multipart/alternative; boundary=000e0cd1b7e6ed8ca704803efd9e

--000e0cd1b7e6ed8ca704803efd9e
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 22, 2010 at 10:41 PM, Iranna D Ankad <iranna.ankad@in.ibm.com>w=
rote:

>
> << Iranna,
> <<I've stumbled down this bloody hole too many times to know that we shou=
ld
> NOT be too hasty in jumping down here again.
> << 1. How did you compile everything (STEP BY STEP... from scratch after
> getting autotools, etc)?
> << 2. If you are running autotools, you DO realize that you're running wi=
th
> an incompatible copy of autoconf, correct? INSTALL explicitly states:
>
> Hi Garrett,
> I am running one of the RHEL distro's with default versions of make,
> automake & autoconf. As you pointed out may be my OS has older versions o=
f
> automake & autoconf than recommended but I am running right version of ma=
ke
> (i.e make-3.81-3.el5). I think, when I am just building LTP using make, I=
 do
> not think autoconf will interfere here?
>
> Here are the steps I am using to compile LTP:
> #./configure
> # make
> ........... hitting reported build errors here ............
>

    Please run `make ac-clean', then run `./configure ; make' . It looks
like the tarball wasn't purged of all configure generated files.
Thanks,
-Garrett


>
> Thanks!
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
>  *Garrett Cooper <yanegomi@gmail.com>*
>
> 02/22/10 11:45 PM
>   To
> Iranna D Ankad/India/IBM@IBMIN
>  cc
> Rishikesh <risrajak@linux.vnet.ibm.com>, LTP <
> ltp-list@lists.sourceforge.net>, Rishikesh K Rajak/India/IBM@IBMIN,
> Vishukumar S Shetty/India/IBM@IBMIN
> Subject
> Re: [ANNOUNCEMENT]: Intermediate release for FEB'10
>
>
>
>
> On Mon, Feb 22, 2010 at 7:48 AM, Iranna D Ankad <*iranna.ankad@in.ibm.com=
*<iranna.ankad@in.ibm.com>>
> wrote:
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
>   *Rishikesh <**risrajak@linux.vnet.ibm.com* <risrajak@linux.vnet.ibm.com=
>
> *>*
>
> 02/22/10 01:17 PM
>
>   To
> LTP <*ltp-list@lists.sourceforge.net* <ltp-list@lists.sourceforge.net>>
> cc
> Garrett Cooper <*yanegomi@gmail.com* <yanegomi@gmail.com>>, Rishikesh K
> Rajak/India/IBM@IBMIN, Vishukumar S Shetty/India/IBM@IBMIN, Iranna D
> Ankad/India/IBM@IBMIN
> Subject
> [ANNOUNCEMENT]: Intermediate release for FEB'10
>
>
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
> You can directly download from:*
> **
> https://sourceforge.net/projects/ltp/files/LTP%20Source/ltp-20100228/ltp-=
intermediate-20100228.tgz/download
> *<https://sourceforge.net/projects/ltp/files/LTP%20Source/ltp-20100228/lt=
p-intermediate-20100228.tgz/download>
>
> And for more details you can just have a look to ltp Home Page: *
> **http://ltp.sourceforge.net/* <http://ltp.sourceforge.net/>
>
> --
> Thanks&  Regards
> Rishi Kesh K Rajak
> IBM LTC, Bangalore
> LTP Maintainer
> Please join IRC: #ltp @ *freenode.net* <http://freenode.net/>
>
> [attachment "ChangeLog.new" deleted by Iranna D Ankad/India/IBM]
>
> Iranna,
>
> I've stumbled down this bloody hole too many times to know that we should
> NOT be too hasty in jumping down here again.
> 1. How did you compile everything (STEP BY STEP... from scratch after
> getting autotools, etc)?
> 2. If you are running autotools, you DO realize that you're running with =
an
> incompatible copy of autoconf, correct? INSTALL explicitly states:
>
> make 3.81 can be obtained here:
> - *http://ftp.gnu.org/gnu/make/make-3.81.tar.bz2*<http://ftp.gnu.org/gnu/=
make/make-3.81.tar.bz2>
>
> ------------------------> If you want to use auto configuration, be sure
> autoconf-2.61+ & automake-1.10+ <------------------------
> are installed.
>
> automake-1.10.2's sources can be downloaded from:
> - *ftp://ftp.gnu.org/gnu/automake/automake-1.10.2.tar.bz2*<ftp://ftp.gnu.=
org/gnu/automake/automake-1.10.2.tar.bz2>
> - *ftp://ftp.gnu.org/gnu/automake/automake-1.10.2.tar.gz*<ftp://ftp.gnu.o=
rg/gnu/automake/automake-1.10.2.tar.gz>
>
> autoconf-2.61's sources can be downloaded from:
> - *ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.61.tar.bz2*<ftp://ftp.gnu.or=
g/gnu/autoconf/autoconf-2.61.tar.bz2>
> - *ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.61.tar.gz*<ftp://ftp.gnu.org=
/gnu/autoconf/autoconf-2.61.tar.gz>
>
> autoconf-2.61 also requires m4-1.4.7+ be installed. Its sources can be
> downloaded from:
> - *http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.bz2*<http://ftp.gnu.org/gnu/m4/=
m4-1.4.7.tar.bz2>
> - *http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.gz*<http://ftp.gnu.org/gnu/m4/m=
4-1.4.7.tar.gz>
>
> The default autoconfed files were made available for folks to tune so the=
y
> could avoid issues with having to write everything from scratch. As such,=
 it
> is your job to a) download and setup appropriate software versions of
> autotools so the configuration is done correctly, automatically, or b)
> properly configure the file(s) so that everything "works".
>
> Thanks,
> -Garrett
>

--000e0cd1b7e6ed8ca704803efd9e
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Mon, Feb 22, 2010 at 10:41 PM, Iranna D Ankad=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:iranna.ankad@in.ibm.com">iranna.an=
kad@in.ibm.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8e=
x; padding-left: 1ex;">
<div class=3D"im">
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
here ............</font><br></blockquote><div><br>=A0=A0=A0 Please run `mak=
e ac-clean&#39;, then run `./configure ; make&#39; . It looks like the tarb=
all wasn&#39;t purged of all configure generated files.<br>Thanks,<br>-Garr=
ett<br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid =
rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br><font face=3D"sans-serif" size=3D"2">Thanks!</font>
<br><div class=3D"im"><font face=3D"sans-serif" size=3D"2">-Iranna D Ankad<=
br>
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
</div><table width=3D"100%">
<tbody><tr valign=3D"top">
<td width=3D"40%"><div class=3D"im"><font face=3D"sans-serif" size=3D"1"><b=
>Garrett Cooper &lt;<a href=3D"mailto:yanegomi@gmail.com" target=3D"_blank"=
>yanegomi@gmail.com</a>&gt;</b>
</font>
</div><p><font face=3D"sans-serif" size=3D"1">02/22/10 11:45 PM</font>
</p></td><td width=3D"59%">
<table width=3D"100%">
<tbody><tr valign=3D"top">
<td>
<div align=3D"right"><font face=3D"sans-serif" size=3D"1">To</font></div>
</td><td><div class=3D"im"><font face=3D"sans-serif" size=3D"1">Iranna D An=
kad/India/IBM@IBMIN</font>
</div></td></tr><tr valign=3D"top">
<td>
<div align=3D"right"><font face=3D"sans-serif" size=3D"1">cc</font></div>
</td><td><font face=3D"sans-serif" size=3D"1">Rishikesh &lt;<a href=3D"mail=
to:risrajak@linux.vnet.ibm.com" target=3D"_blank">risrajak@linux.vnet.ibm.c=
om</a>&gt;,
LTP &lt;<a href=3D"mailto:ltp-list@lists.sourceforge.net" target=3D"_blank"=
>ltp-list@lists.sourceforge.net</a>&gt;, Rishikesh K Rajak/India/IBM@IBMIN,
Vishukumar S Shetty/India/IBM@IBMIN</font>
</td></tr><tr valign=3D"top">
<td>
<div align=3D"right"><font face=3D"sans-serif" size=3D"1">Subject</font></d=
iv>
</td><td><font face=3D"sans-serif" size=3D"1">Re: [ANNOUNCEMENT]: Intermedi=
ate release
for FEB&#39;10</font></td></tr></tbody></table>
<br>
<table>
<tbody><tr valign=3D"top">
<td>
</td><td></td></tr></tbody></table>
<br></td></tr></tbody></table><div><div></div><div class=3D"h5">
<br>
<br>
<br><font size=3D"3">On Mon, Feb 22, 2010 at 7:48 AM, Iranna D Ankad &lt;</=
font><a href=3D"mailto:iranna.ankad@in.ibm.com" target=3D"_blank"><font col=
or=3D"blue" size=3D"3"><u>iranna.ankad@in.ibm.com</u></font></a><font size=
=3D"3">&gt;
wrote:</font>
<br><font face=3D"sans-serif" size=3D"2"><br>
Hello Rishi,</font><font size=3D"3"> </font><font face=3D"sans-serif" size=
=3D"2"><br>
LTP compilation on my system halted with below build errors, please check
this out. =A0 =A0Thanks!</font><font size=3D"3"> <br>
</font><font face=3D"sans-serif" size=3D"2"><br>
gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall =A0-I/root/ltp-intermedi=
ate-20100228/testcases/kernel/include
-I/root/ltp-intermediate-20100228/testcases/kernel/syscalls/mbind/../utils/
-I../../../../include -I../../../../include =A0 -L../../../../lib =A0mbind0=
1.c
=A0 -lltp -lnuma -o mbind01</font><font size=3D"3"> </font><font face=3D"sa=
ns-serif" size=3D"2"><br>
mbind01.c:184: error: =91MPOL_DEFAULT=92 undeclared here (not in a function=
)</font><font size=3D"3">
</font><font face=3D"sans-serif" size=3D"2"><br>
mbind01.c:196: error: =91MPOL_BIND=92 undeclared here (not in a function)</=
font><font size=3D"3">
</font><font face=3D"sans-serif" size=3D"2"><br>
mbind01.c:208: error: =91MPOL_INTERLEAVE=92 undeclared here (not in a funct=
ion)</font><font size=3D"3">
</font><font face=3D"sans-serif" size=3D"2"><br>
mbind01.c:220: error: =91MPOL_PREFERRED=92 undeclared here (not in a functi=
on)</font><font size=3D"3">
</font><font face=3D"sans-serif" size=3D"2"><br>
mbind01.c: In function =91do_test=92:</font><font size=3D"3"> </font><font =
face=3D"sans-serif" size=3D"2"><br>
mbind01.c:309: error: =91MPOL_F_ADDR=92 undeclared (first use in this funct=
ion)</font><font size=3D"3">
</font><font face=3D"sans-serif" size=3D"2"><br>
mbind01.c:309: error: (Each undeclared identifier is reported only once</fo=
nt><font size=3D"3">
</font><font face=3D"sans-serif" size=3D"2"><br>
mbind01.c:309: error: for each function it appears in.)</font><font size=3D=
"3">
</font><font face=3D"sans-serif" size=3D"2"><br>
mbind01.c:317: warning: comparison between pointer and integer</font><font =
size=3D"3">
</font><font face=3D"sans-serif" size=3D"2"><br>
mbind01.c:319: warning: comparison between pointer and integer</font><font =
size=3D"3">
</font><font face=3D"sans-serif" size=3D"2"><br>
make[4]: *** [mbind01] Error 1</font><font size=3D"3"> </font><font face=3D=
"sans-serif" size=3D"2"><br>
make[4]: Leaving directory `/root/ltp-intermediate-20100228/testcases/kerne=
l/syscalls/mbind&#39;</font><font size=3D"3">
</font><font face=3D"sans-serif" size=3D"2"><br>
make[3]: *** [all] Error 2</font><font size=3D"3"> </font><font face=3D"san=
s-serif" size=3D"2"><br>
make[3]: Leaving directory `/root/ltp-intermediate-20100228/testcases/kerne=
l/syscalls&#39;</font><font size=3D"3">
</font><font face=3D"sans-serif" size=3D"2"><br>
make[2]: *** [all] Error 2</font><font size=3D"3"> </font><font face=3D"san=
s-serif" size=3D"2"><br>
make[2]: Leaving directory `/root/ltp-intermediate-20100228/testcases/kerne=
l&#39;</font><font size=3D"3">
</font><font face=3D"sans-serif" size=3D"2"><br>
make[1]: *** [all] Error 2</font><font size=3D"3"> </font><font face=3D"san=
s-serif" size=3D"2"><br>
make[1]: Leaving directory `/root/ltp-intermediate-20100228/testcases&#39;<=
/font><font size=3D"3">
</font><font face=3D"sans-serif" size=3D"2"><br>
make: *** [testcases-all] Error 2</font><font size=3D"3"> </font><font face=
=3D"sans-serif" size=3D"2"><br>
[root@mx3655 ltp-intermediate-20100228]# </font><font size=3D"3"><br>
</font><font face=3D"sans-serif" size=3D"2"><br>
Here are the make &amp; autoconf versions I am running.</font><font size=3D=
"3">
<br>
</font><font face=3D"sans-serif" size=3D"2"><br>
[root@mx3655 ltp-intermediate-20100228]# rpm -qa | grep make</font><font si=
ze=3D"3">
</font><font face=3D"sans-serif" size=3D"2"><br>
automake14-1.4p6-13</font><font size=3D"3"> </font><font face=3D"sans-serif=
" size=3D"2"><br>
imake-1.0.2-3</font><font size=3D"3"> </font><font face=3D"sans-serif" size=
=3D"2"><br>
automake17-1.7.9-7</font><font size=3D"3"> </font><font face=3D"sans-serif"=
 size=3D"2"><br>
automake15-1.5-16</font><font size=3D"3"> </font><font face=3D"sans-serif" =
size=3D"2"><br>
automake16-1.6.3-8</font><font size=3D"3"> </font><font face=3D"sans-serif"=
 size=3D"2"><br>
make-3.81-3.el5</font><font size=3D"3"> </font><font face=3D"sans-serif" si=
ze=3D"2"><br>
automake-1.9.6-2.1</font><font size=3D"3"> </font><font face=3D"sans-serif"=
 size=3D"2"><br>
[root@mx3655 ltp-intermediate-20100228]# rpm -qa | grep autoconf</font><fon=
t size=3D"3">
</font><font face=3D"sans-serif" size=3D"2"><br>
autoconf-2.59-12</font><font size=3D"3"> </font><font face=3D"sans-serif" s=
ize=3D"2"><br>
[root@mx3655 ltp-intermediate-20100228]#</font><font size=3D"3"> <br>
<br>
</font><font face=3D"sans-serif" size=3D"2"><br>
-Iranna D Ankad<br>
---------------------------------------------------------------------------=
-------------------------<br>
Linux-Technology Center, IBM India Software Labs<br>
Manyata Embassy Park, BENGALURU - 560045,<br>
Ph: +91-080-28055007 =A0 Extn: 55007<br>
---------------------------------------------------------------------------=
-------------------------<br>
&quot;If you don&#39;t have patience to test the software, the software wil=
l
test your patience !!&quot;</font><font size=3D"3"> <br>
<br>
</font>
<table width=3D"100%">
<tbody><tr valign=3D"top">
<td width=3D"22%"><font face=3D"sans-serif" size=3D"1"><b>Rishikesh &lt;</b=
></font><a href=3D"mailto:risrajak@linux.vnet.ibm.com" target=3D"_blank"><f=
ont color=3D"blue" face=3D"sans-serif" size=3D"1"><b><u>risrajak@linux.vnet=
.ibm.com</u></b></font></a><font face=3D"sans-serif" size=3D"1"><b>&gt;</b>
</font>
<p><font face=3D"sans-serif" size=3D"1">02/22/10 01:17 PM</font><font size=
=3D"3">
</font>
</p></td><td width=3D"77%">
<br>
<table width=3D"100%">
<tbody><tr valign=3D"top">
<td width=3D"6%">
<div align=3D"right"><font face=3D"sans-serif" size=3D"1">To</font></div>
</td><td width=3D"93%"><font face=3D"sans-serif" size=3D"1">LTP &lt;</font>=
<a href=3D"mailto:ltp-list@lists.sourceforge.net" target=3D"_blank"><font c=
olor=3D"blue" face=3D"sans-serif" size=3D"1"><u>ltp-list@lists.sourceforge.=
net</u></font></a><font face=3D"sans-serif" size=3D"1">&gt;</font><font siz=
e=3D"3">
</font>
</td></tr><tr valign=3D"top">
<td>
<div align=3D"right"><font face=3D"sans-serif" size=3D"1">cc</font></div>
</td><td><font face=3D"sans-serif" size=3D"1">Garrett Cooper &lt;</font><a =
href=3D"mailto:yanegomi@gmail.com" target=3D"_blank"><font color=3D"blue" f=
ace=3D"sans-serif" size=3D"1"><u>yanegomi@gmail.com</u></font></a><font fac=
e=3D"sans-serif" size=3D"1">&gt;,
Rishikesh K Rajak/India/IBM@IBMIN, Vishukumar S Shetty/India/IBM@IBMIN,
Iranna D Ankad/India/IBM@IBMIN</font><font size=3D"3"> </font>
</td></tr><tr valign=3D"top">
<td>
<div align=3D"right"><font face=3D"sans-serif" size=3D"1">Subject</font></d=
iv>
</td><td><font face=3D"sans-serif" size=3D"1">[ANNOUNCEMENT]: Intermediate =
release
for FEB&#39;10</font></td></tr></tbody></table>
<br>
<br>
<table width=3D"100%">
<tbody><tr valign=3D"top">
<td width=3D"50%">
</td><td width=3D"50%"></td></tr></tbody></table>
<br></td></tr></tbody></table>
<br><font size=3D"3"><br>
<br>
</font>
<br><tt><font size=3D"2">Hi All,<br>
<br>
Welcome to ltp community.<br>
<br>
The February 2010 Intermediate release is out now. This build contains<br>
many fixes. Changelog you can find as attached.<br>
<br>
You can directly download from:</font></tt><tt><font color=3D"blue" size=3D=
"2"><u><br>
</u></font></tt><a href=3D"https://sourceforge.net/projects/ltp/files/LTP%2=
0Source/ltp-20100228/ltp-intermediate-20100228.tgz/download" target=3D"_bla=
nk"><tt><font color=3D"blue" size=3D"2"><u>https://sourceforge.net/projects=
/ltp/files/LTP%20Source/ltp-20100228/ltp-intermediate-20100228.tgz/download=
</u></font></tt></a><tt><font size=3D"2"><br>

<br>
And for more details you can just have a look to ltp Home Page: </font></tt=
><tt><font color=3D"blue" size=3D"2"><u><br>
</u></font></tt><a href=3D"http://ltp.sourceforge.net/" target=3D"_blank"><=
tt><font color=3D"blue" size=3D"2"><u>http://ltp.sourceforge.net/</u></font=
></tt></a><tt><font size=3D"2"><br>
<br>
-- <br>
Thanks&amp; =A0Regards<br>
Rishi Kesh K Rajak<br>
IBM LTC, Bangalore<br>
LTP Maintainer<br>
Please join IRC: #ltp @ </font></tt><a href=3D"http://freenode.net/" target=
=3D"_blank"><tt><font color=3D"blue" size=3D"2"><u>freenode.net</u></font><=
/tt></a><tt><font size=3D"2"><br>
</font></tt>
<br><tt><font size=3D"2">[attachment &quot;ChangeLog.new&quot; deleted by I=
ranna
D Ankad/India/IBM] </font></tt>
<br><font size=3D"3"><br>
Iranna,<br>
<br>
I&#39;ve stumbled down this bloody hole too many times to know that we shou=
ld
NOT be too hasty in jumping down here again.<br>
1. How did you compile everything (STEP BY STEP... from scratch after getti=
ng
autotools, etc)?<br>
2. If you are running autotools, you DO realize that you&#39;re running wit=
h
an incompatible copy of autoconf, correct? INSTALL explicitly states:<br>
<br>
make 3.81 can be obtained here:<br>
- </font><a href=3D"http://ftp.gnu.org/gnu/make/make-3.81.tar.bz2" target=
=3D"_blank"><font color=3D"blue" size=3D"3"><u>http://ftp.gnu.org/gnu/make/=
make-3.81.tar.bz2</u></font></a><font size=3D"3"><br>
<br>
------------------------&gt; If you want to use auto configuration, be
sure autoconf-2.61+ &amp; automake-1.10+ &lt;------------------------<br>
are installed.<br>
<br>
automake-1.10.2&#39;s sources can be downloaded from:<br>
- </font><a href=3D"ftp://ftp.gnu.org/gnu/automake/automake-1.10.2.tar.bz2"=
 target=3D"_blank"><font color=3D"blue" size=3D"3"><u>ftp://ftp.gnu.org/gnu=
/automake/automake-1.10.2.tar.bz2</u></font></a><font size=3D"3"><br>
- </font><a href=3D"ftp://ftp.gnu.org/gnu/automake/automake-1.10.2.tar.gz" =
target=3D"_blank"><font color=3D"blue" size=3D"3"><u>ftp://ftp.gnu.org/gnu/=
automake/automake-1.10.2.tar.gz</u></font></a><font size=3D"3"><br>
<br>
autoconf-2.61&#39;s sources can be downloaded from:<br>
- </font><a href=3D"ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.61.tar.bz2" t=
arget=3D"_blank"><font color=3D"blue" size=3D"3"><u>ftp://ftp.gnu.org/gnu/a=
utoconf/autoconf-2.61.tar.bz2</u></font></a><font size=3D"3"><br>
- </font><a href=3D"ftp://ftp.gnu.org/gnu/autoconf/autoconf-2.61.tar.gz" ta=
rget=3D"_blank"><font color=3D"blue" size=3D"3"><u>ftp://ftp.gnu.org/gnu/au=
toconf/autoconf-2.61.tar.gz</u></font></a><font size=3D"3"><br>
<br>
autoconf-2.61 also requires m4-1.4.7+ be installed. Its sources can be<br>
downloaded from:<br>
- </font><a href=3D"http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.bz2" target=3D"_=
blank"><font color=3D"blue" size=3D"3"><u>http://ftp.gnu.org/gnu/m4/m4-1.4.=
7.tar.bz2</u></font></a><font size=3D"3"><br>
- </font><a href=3D"http://ftp.gnu.org/gnu/m4/m4-1.4.7.tar.gz" target=3D"_b=
lank"><font color=3D"blue" size=3D"3"><u>http://ftp.gnu.org/gnu/m4/m4-1.4.7=
.tar.gz</u></font></a><font size=3D"3"><br>
<br>
The default autoconfed files were made available for folks to tune so they
could avoid issues with having to write everything from scratch. As such,
it is your job to a) download and setup appropriate software versions of
autotools so the configuration is done correctly, automatically, or b)
properly configure the file(s) so that everything &quot;works&quot;.<br>
<br>
Thanks,<br>
-Garrett</font>
<br>
</div></div></blockquote></div><br>

--000e0cd1b7e6ed8ca704803efd9e--


--===============7246569460279385420==
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
--===============7246569460279385420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7246569460279385420==--

