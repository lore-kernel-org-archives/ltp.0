Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <romansc@us.ibm.com>) id 1QAO9G-0006FC-Fr
	for ltp-list@lists.sourceforge.net; Thu, 14 Apr 2011 15:07:58 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.74) id 1QAO9F-0001Qx-Ha
	for ltp-list@lists.sourceforge.net; Thu, 14 Apr 2011 15:07:58 +0000
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3EEgWcp002347
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Apr 2011 10:42:32 -0400
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id C367A6E8039
	for <ltp-list@lists.sourceforge.net>;
	Thu, 14 Apr 2011 11:07:51 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3EF7p3O395666
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Apr 2011 11:07:51 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p3EF7mBm017850
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Apr 2011 12:07:50 -0300
In-Reply-To: <BANLkTim9UOO3bCubw+G+Px0-cV6vVuxsNQ@mail.gmail.com>
References: <OFCEFD64D0.BC49FB71-ON8525785E.0065EB2E-8525785E.0066D6A1@LocalDomain>	<OF7FE76060.EAACC2A8-ON85257872.004D62BE-85257872.004ECF6E@us.ibm.com>
	<BANLkTim9UOO3bCubw+G+Px0-cV6vVuxsNQ@mail.gmail.com>
Message-ID: <OFF2FBFC58.67A816F3-ON85257872.0052183E-85257872.00531A4B@us.ibm.com>
From: Scott Romanowski <romansc@us.ibm.com>
Date: Thu, 14 Apr 2011 11:07:40 -0400
MIME-Version: 1.0
Subject: Re: [LTP] ioctl01.c bug in error message
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1623465728956218222=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============1623465728956218222==
Content-type: multipart/related; 
	Boundary="0__=0ABBF2E1DFC19EAE8f9e8a93df938690918c0ABBF2E1DFC19EAE"

--0__=0ABBF2E1DFC19EAE8f9e8a93df938690918c0ABBF2E1DFC19EAE
Content-type: multipart/alternative; 
	Boundary="1__=0ABBF2E1DFC19EAE8f9e8a93df938690918c0ABBF2E1DFC19EAE"

--1__=0ABBF2E1DFC19EAE8f9e8a93df938690918c0ABBF2E1DFC19EAE
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable


True, tty is intializes to 0, so if there's a failure, the error messag=
e is
something like this
    Couldn't open (null), errno =3D 6
Instead of something like
    Couldn't open /dev/ttyFoo, errno =3D 6
I should have written "unused".
--
Scott Romanowski
978-899-5384
IBM
Cubicle BG125C
550 King St.
Littleton, MA 01460


                                                                       =
                                             
  From:       Garrett Cooper <yanegomi@gmail.com>                      =
                                             
                                                                       =
                                             
  To:         Scott Romanowski/Watson/Contr/IBM@IBMUS                  =
                                             
                                                                       =
                                             
  Cc:         ltp-list@lists.sourceforge.net                           =
                                             
                                                                       =
                                             
  Date:       04/14/2011 10:30 AM                                      =
                                             
                                                                       =
                                             
  Subject:    Re: [LTP] ioctl01.c bug in error message                 =
                                             
                                                                       =
                                             





On Thu, Apr 14, 2011 at 7:20 AM, Scott Romanowski <romansc@us.ibm.com>
wrote:
> testcases/kernel/syscalls/ioctl/ioctl01.c has a bug where, if the ope=
n()
> fails, the error message it prints uses an uninitialized char * varia=
ble
> instead of the one that holds the device. This only affects the error=

> message. The solution is to use 'devname' instead of 'tty' in the
> tst_brkm(), and you can also delete the unused variable, 'char *tty;'=
.

    tty is initialized -- just not the value that you want (0 because
it's in the BSS).
    Please try this patch and let me know how things go.
Thanks,
-Garrett
[attachment "fix-ioctl01.patch" deleted by Scott
Romanowski/Watson/Contr/IBM]
=

--1__=0ABBF2E1DFC19EAE8f9e8a93df938690918c0ABBF2E1DFC19EAE
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline
Content-transfer-encoding: quoted-printable

<html><body>
<p><font size=3D"2" face=3D"sans-serif">True, tty is intializes to 0, s=
o if there's a failure, the error message is something like this</font>=
<br>
<font size=3D"1" color=3D"#800000" face=3D"Courier New">    Couldn't op=
en (null), errno =3D 6</font><br>
<font size=3D"2" face=3D"sans-serif">Instead of something like</font><b=
r>
<font size=3D"1" color=3D"#800000" face=3D"Courier New">    Couldn't op=
en /dev/ttyFoo, errno =3D 6</font><br>
<font size=3D"2" face=3D"sans-serif">I should have written &quot;unused=
&quot;.</font><br>
<font size=3D"2" face=3D"sans-serif">--<br>
Scott Romanowski<br>
978-899-5384<br>
IBM<br>
Cubicle BG125C<br>
550 King St.<br>
Littleton, MA 01460</font><br>
<br>
<img width=3D"16" height=3D"16" src=3D"cid:1__=3D0ABBF2E1DFC19EAE8f9e8a=
93df938@us.ibm.com" border=3D"0" alt=3D"Inactive hide details for Garre=
tt Cooper ---04/14/2011 10:30:26 AM---On Thu, Apr 14, 2011 at 7:20 AM, =
Scott Romanowski &lt;romansc"><font size=3D"2" color=3D"#424282" face=3D=
"sans-serif">Garrett Cooper ---04/14/2011 10:30:26 AM---On Thu, Apr 14,=
 2011 at 7:20 AM, Scott Romanowski &lt;romansc@us.ibm.com&gt; wrote: &g=
t; testcases/kernel/sys</font><br>
<br>

<table width=3D"100%" border=3D"0" cellspacing=3D"0" cellpadding=3D"0">=

<tr valign=3D"top"><td width=3D"1%"><img width=3D"96" height=3D"1" src=3D=
"cid:2__=3D0ABBF2E1DFC19EAE8f9e8a93df938@us.ibm.com" border=3D"0" alt=3D=
""><br>

<ul style=3D"padding-left: 4pt"><font size=3D"1" color=3D"#5F5F5F" face=
=3D"sans-serif">From:</font></ul>
</td><td width=3D"100%"><img width=3D"1" height=3D"1" src=3D"cid:2__=3D=
0ABBF2E1DFC19EAE8f9e8a93df938@us.ibm.com" border=3D"0" alt=3D""><br>
<font size=3D"1" face=3D"sans-serif">Garrett Cooper &lt;yanegomi@gmail.=
com&gt;</font></td></tr>

<tr valign=3D"top"><td width=3D"1%"><img width=3D"96" height=3D"1" src=3D=
"cid:2__=3D0ABBF2E1DFC19EAE8f9e8a93df938@us.ibm.com" border=3D"0" alt=3D=
""><br>

<ul style=3D"padding-left: 4pt"><font size=3D"1" color=3D"#5F5F5F" face=
=3D"sans-serif">To:</font></ul>
</td><td width=3D"100%"><img width=3D"1" height=3D"1" src=3D"cid:2__=3D=
0ABBF2E1DFC19EAE8f9e8a93df938@us.ibm.com" border=3D"0" alt=3D""><br>
<font size=3D"1" face=3D"sans-serif">Scott Romanowski/Watson/Contr/IBM@=
IBMUS</font></td></tr>

<tr valign=3D"top"><td width=3D"1%"><img width=3D"96" height=3D"1" src=3D=
"cid:2__=3D0ABBF2E1DFC19EAE8f9e8a93df938@us.ibm.com" border=3D"0" alt=3D=
""><br>

<ul style=3D"padding-left: 4pt"><font size=3D"1" color=3D"#5F5F5F" face=
=3D"sans-serif">Cc:</font></ul>
</td><td width=3D"100%" valign=3D"middle"><img width=3D"1" height=3D"1"=
 src=3D"cid:2__=3D0ABBF2E1DFC19EAE8f9e8a93df938@us.ibm.com" border=3D"0=
" alt=3D""><br>
<font size=3D"1" face=3D"sans-serif">ltp-list@lists.sourceforge.net</fo=
nt></td></tr>

<tr valign=3D"top"><td width=3D"1%"><img width=3D"96" height=3D"1" src=3D=
"cid:2__=3D0ABBF2E1DFC19EAE8f9e8a93df938@us.ibm.com" border=3D"0" alt=3D=
""><br>

<ul style=3D"padding-left: 4pt"><font size=3D"1" color=3D"#5F5F5F" face=
=3D"sans-serif">Date:</font></ul>
</td><td width=3D"100%"><img width=3D"1" height=3D"1" src=3D"cid:2__=3D=
0ABBF2E1DFC19EAE8f9e8a93df938@us.ibm.com" border=3D"0" alt=3D""><br>
<font size=3D"1" face=3D"sans-serif">04/14/2011 10:30 AM</font></td></t=
r>

<tr valign=3D"top"><td width=3D"1%"><img width=3D"96" height=3D"1" src=3D=
"cid:2__=3D0ABBF2E1DFC19EAE8f9e8a93df938@us.ibm.com" border=3D"0" alt=3D=
""><br>

<ul style=3D"padding-left: 4pt"><font size=3D"1" color=3D"#5F5F5F" face=
=3D"sans-serif">Subject:</font></ul>
</td><td width=3D"100%"><img width=3D"1" height=3D"1" src=3D"cid:2__=3D=
0ABBF2E1DFC19EAE8f9e8a93df938@us.ibm.com" border=3D"0" alt=3D""><br>
<font size=3D"1" face=3D"sans-serif">Re: [LTP] ioctl01.c bug in error m=
essage</font></td></tr>
</table>
<hr width=3D"100%" size=3D"2" align=3D"left" noshade style=3D"color:#80=
91A5; "><br>
<br>
<br>
<tt><font size=3D"2">On Thu, Apr 14, 2011 at 7:20 AM, Scott Romanowski =
&lt;romansc@us.ibm.com&gt; wrote:<br>
&gt; testcases/kernel/syscalls/ioctl/ioctl01.c has a bug where, if the =
open()<br>
&gt; fails, the error message it prints uses an uninitialized char * va=
riable<br>
&gt; instead of the one that holds the device. This only affects the er=
ror<br>
&gt; message. The solution is to use 'devname' instead of 'tty' in the<=
br>
&gt; tst_brkm(), and you can also delete the unused variable, 'char *tt=
y;'.<br>
<br>
    tty is initialized -- just not the value that you want (0 because<b=
r>
it's in the BSS).<br>
    Please try this patch and let me know how things go.<br>
Thanks,<br>
-Garrett<br>
[attachment &quot;fix-ioctl01.patch&quot; deleted by Scott Romanowski/W=
atson/Contr/IBM] </font></tt><br>
<br>
</body></html>=


--1__=0ABBF2E1DFC19EAE8f9e8a93df938690918c0ABBF2E1DFC19EAE--


--0__=0ABBF2E1DFC19EAE8f9e8a93df938690918c0ABBF2E1DFC19EAE
Content-type: image/gif; 
	name="graycol.gif"
Content-Disposition: inline; filename="graycol.gif"
Content-ID: <1__=0ABBF2E1DFC19EAE8f9e8a93df938@us.ibm.com>
Content-transfer-encoding: base64

R0lGODlhEAAQAKECAMzMzAAAAP///wAAACH5BAEAAAIALAAAAAAQABAAAAIXlI+py+0PopwxUbpu
ZRfKZ2zgSJbmSRYAIf4fT3B0aW1pemVkIGJ5IFVsZWFkIFNtYXJ0U2F2ZXIhAAA7

--0__=0ABBF2E1DFC19EAE8f9e8a93df938690918c0ABBF2E1DFC19EAE
Content-type: image/gif; 
	name="ecblank.gif"
Content-Disposition: inline; filename="ecblank.gif"
Content-ID: <2__=0ABBF2E1DFC19EAE8f9e8a93df938@us.ibm.com>
Content-transfer-encoding: base64

R0lGODlhEAABAIAAAAAAAP///yH5BAEAAAEALAAAAAAQAAEAAAIEjI8ZBQA7

--0__=0ABBF2E1DFC19EAE8f9e8a93df938690918c0ABBF2E1DFC19EAE--



--===============1623465728956218222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
--===============1623465728956218222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1623465728956218222==--


