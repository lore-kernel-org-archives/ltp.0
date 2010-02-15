Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vishwa.hochihally@gmail.com>) id 1Ngv4v-00041h-6Z
	for ltp-list@lists.sourceforge.net; Mon, 15 Feb 2010 07:09:09 +0000
Received: from mail-pz0-f179.google.com ([209.85.222.179])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ngv4t-0003Vu-Ce
	for ltp-list@lists.sourceforge.net; Mon, 15 Feb 2010 07:09:09 +0000
Received: by pzk9 with SMTP id 9so2915644pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Sun, 14 Feb 2010 23:09:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41002142303t19a2dd85ve9d87245084ff4ff@mail.gmail.com>
References: <4b9fdcd01002142251l2cb9036fvde4fbc60bbae85a4@mail.gmail.com>
	<364299f41002142303t19a2dd85ve9d87245084ff4ff@mail.gmail.com>
Date: Mon, 15 Feb 2010 12:39:01 +0530
Message-ID: <4b9fdcd01002142309p2bc18e0yfaa0876694cc4f57@mail.gmail.com>
From: vishwanath govind <vishwa.hochihally@gmail.com>
Subject: Re: [LTP] facing issue "TBROK : nobody not in /etc/passwd"
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4688119366283318948=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============4688119366283318948==
Content-Type: multipart/alternative; boundary=000e0cd13a66b18ac2047f9e4aa8

--000e0cd13a66b18ac2047f9e4aa8
Content-Type: text/plain; charset=ISO-8859-1

Garrett,
 Thanks for your quick reply. I am using "ltp-full-20091231".
Regards
Vishwa

On Mon, Feb 15, 2010 at 12:33 PM, Garrett Cooper <yanegomi@gmail.com> wrote:

>  On Sun, Feb 14, 2010 at 10:51 PM, vishwanath govind
> <vishwa.hochihally@gmail.com> wrote:
> >
> > Hi,
> > I am facing common issue which causing many of the LTP syscalls test
> cases
> > to fail. I have taken mknod02 test to show this issue here. Definitely I
> am
> > missing something out here, could you guys please point me to right
> > direction?  Please let me know if you need some more info/log
> >
> > ======================log================================
> > # ls /etc
> > group   passwd
> >
> > # ./IDcheck.sh
> > Checking for required user/group ids
> > 'nobody' user id and group found.
> > 'bin' user id and group found.
> > 'daemon' user id and group found.
> > Users group found.
> > Sys group found.
> > Required users/groups exist.
> >
> > # cat /etc/passwd
> > root:x:0:0:root::
> > nobody:x:99:99:nobody::
> > bin:x:1:1:bin::
> > daemon:x:2:2:daemon::
> >
> > #uname -a
> > Linux (none) 2.6.29 #4 PREEMPT Thu Feb 11 23:37:46 PST 2010 armv6l
> GNU/Linux
> >
> > # ./mknod02
> > mknod02     1  TBROK  :  nobody not in /etc/passwd
>
> What version of LTP is this?
> Thanks,
> -Garrett
>

--000e0cd13a66b18ac2047f9e4aa8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Garrett,</div>
<div>=A0Thanks for your quick reply. I am using &quot;ltp-full-20091231&quo=
t;.</div>
<div>Regards</div>
<div>Vishwa<br><br></div>
<div class=3D"gmail_quote">On Mon, Feb 15, 2010 at 12:33 PM, Garrett Cooper=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:yanegomi@gmail.com">yanegomi@gmail=
.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div></div>
<div class=3D"h5">On Sun, Feb 14, 2010 at 10:51 PM, vishwanath govind<br>&l=
t;<a href=3D"mailto:vishwa.hochihally@gmail.com">vishwa.hochihally@gmail.co=
m</a>&gt; wrote:<br>&gt;<br>&gt; Hi,<br>&gt; I am facing common issue which=
 causing many of the LTP syscalls test cases<br>
&gt; to fail. I have taken mknod02 test to show this issue here. Definitely=
 I am<br>&gt; missing something out here, could you guys please point me to=
 right<br>&gt; direction?=A0 Please let me know if you need some more info/=
log<br>
&gt;<br>&gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3Dlog=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>&gt; # ls /etc<br>&gt; group=A0=A0 passwd=
<br>&gt;<br>&gt; # ./IDcheck.sh<br>&gt; Checking for required user/group id=
s<br>&gt; &#39;nobody&#39; user id and group found.<br>
&gt; &#39;bin&#39; user id and group found.<br>&gt; &#39;daemon&#39; user i=
d and group found.<br>&gt; Users group found.<br>&gt; Sys group found.<br>&=
gt; Required users/groups exist.<br>&gt;<br>&gt; # cat /etc/passwd<br>&gt; =
root:x:0:0:root::<br>
&gt; nobody:x:99:99:nobody::<br>&gt; bin:x:1:1:bin::<br>&gt; daemon:x:2:2:d=
aemon::<br>&gt;<br>&gt; #uname -a<br>&gt; Linux (none) 2.6.29 #4 PREEMPT Th=
u Feb 11 23:37:46 PST 2010 armv6l GNU/Linux<br>&gt;<br>&gt; # ./mknod02<br>
&gt; mknod02=A0=A0=A0=A0 1=A0 TBROK=A0 :=A0 nobody not in /etc/passwd<br><b=
r></div></div>What version of LTP is this?<br>Thanks,<br><font color=3D"#88=
8888">-Garrett<br></font></blockquote></div><br>

--000e0cd13a66b18ac2047f9e4aa8--


--===============4688119366283318948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
--===============4688119366283318948==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4688119366283318948==--

