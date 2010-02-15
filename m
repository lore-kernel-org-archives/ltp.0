Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vishwa.hochihally@gmail.com>) id 1Ngvs5-0000LI-N2
	for ltp-list@lists.sourceforge.net; Mon, 15 Feb 2010 07:59:57 +0000
Received: from mail-pz0-f179.google.com ([209.85.222.179])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ngvs4-0003JE-MF
	for ltp-list@lists.sourceforge.net; Mon, 15 Feb 2010 07:59:57 +0000
Received: by pzk9 with SMTP id 9so2951107pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Sun, 14 Feb 2010 23:59:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41002142320p24b3e50fj8b56bb15dad2a524@mail.gmail.com>
References: <4b9fdcd01002142251l2cb9036fvde4fbc60bbae85a4@mail.gmail.com>
	<364299f41002142303t19a2dd85ve9d87245084ff4ff@mail.gmail.com>
	<4b9fdcd01002142309p2bc18e0yfaa0876694cc4f57@mail.gmail.com>
	<364299f41002142320p24b3e50fj8b56bb15dad2a524@mail.gmail.com>
Date: Mon, 15 Feb 2010 13:29:48 +0530
Message-ID: <4b9fdcd01002142359w4b275c73s91ea258eee1de146@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============1629520040874035075=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============1629520040874035075==
Content-Type: multipart/alternative; boundary=000e0cd104f44fce61047f9f007d

--000e0cd104f44fce61047f9f007d
Content-Type: text/plain; charset=ISO-8859-1

 Yes, I checked this before, It return errorno "0". Somehow mknod02 won't
display the errorno when it exit with "tst_brkm(TBROK, cleanup, "%s not in
/etc/passwd", LTPUSER)" but I have similar tests return errorno 0. I see
"nobody" user and uid/gid -99 is present in /etc/passwd file. Do I need to
enable anything in KERNEL config or /etc?

============================log===============================
<<<test_start>>>
tag=nftw01 stime=1170483127
cmdline="nftw01"
contacts=""
analysis=exit
<<<test_output>>>
nobody not found in /etc/passwd: No such file or directory
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=1 cstime=2
<<<test_end>>>
<<<test_start>>>
tag=nftw6401 stime=1170483127
cmdline="nftw6401"
contacts=""
analysis=exit
<<<test_output>>>
change_owner: nobody not found in /etc/passwd: No such file or directory
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=2 cstime=1
<<<test_end>>>
==============================end==================================
Regards
Vishwa

On Mon, Feb 15, 2010 at 12:50 PM, Garrett Cooper <yanegomi@gmail.com> wrote:

> On Sun, Feb 14, 2010 at 11:09 PM, vishwanath govind
>  <vishwa.hochihally@gmail.com> wrote:
> > Garrett,
> >  Thanks for your quick reply. I am using "ltp-full-20091231".
> > Regards
> > Vishwa
> >
> > On Mon, Feb 15, 2010 at 12:33 PM, Garrett Cooper <yanegomi@gmail.com>
> wrote:
> >>
> >> On Sun, Feb 14, 2010 at 10:51 PM, vishwanath govind
> >> <vishwa.hochihally@gmail.com> wrote:
> >> >
> >> > Hi,
> >> > I am facing common issue which causing many of the LTP syscalls test
> >> > cases
> >> > to fail. I have taken mknod02 test to show this issue here. Definitely
> I
> >> > am
> >> > missing something out here, could you guys please point me to right
> >> > direction?  Please let me know if you need some more info/log
> >> >
> >> > ======================log================================
> >> > # ls /etc
> >> > group   passwd
> >> >
> >> > # ./IDcheck.sh
> >> > Checking for required user/group ids
> >> > 'nobody' user id and group found.
> >> > 'bin' user id and group found.
> >> > 'daemon' user id and group found.
> >> > Users group found.
> >> > Sys group found.
> >> > Required users/groups exist.
> >> >
> >> > # cat /etc/passwd
> >> > root:x:0:0:root::
> >> > nobody:x:99:99:nobody::
> >> > bin:x:1:1:bin::
> >> > daemon:x:2:2:daemon::
> >> >
> >> > #uname -a
> >> > Linux (none) 2.6.29 #4 PREEMPT Thu Feb 11 23:37:46 PST 2010 armv6l
> >> > GNU/Linux
> >> >
> >> > # ./mknod02
> >> > mknod02     1  TBROK  :  nobody not in /etc/passwd
> >>
> >> What version of LTP is this?
>
> That's a lousy diagnostic, as any one of the following errors could be
> the culprit:
>
> ERRORS
>       0 or ENOENT or ESRCH or EBADF or EPERM or ...
>              The given name or uid was not found.
>
>       EINTR  A signal was caught.
>
>       EIO    I/O error.
>
>       EMFILE The maximum number (OPEN_MAX) of files was open already
> in the calling process.
>
>       ENFILE The maximum number of files was open already in the system.
>
>       ENOMEM Insufficient memory to allocate passwd structure.
>
>       ERANGE Insufficient buffer space supplied.
>
> What are the permissions on the file and is there any way where you
> could grab the latest copy of the file from git and try that out (the
> patch is available at:
> <
> http://ltp.git.sourceforge.net/git/gitweb.cgi?p=ltp/ltp-dev.git;a=patch;h=HEAD;hp=8686ad72fbe76a7de8fe8e93ef68a71fff8a049d
> >)?
> Thanks!
> -Garrett
>

--000e0cd104f44fce61047f9f007d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>
<div>Yes, I checked this before, It return err<span class=3D"498335307-1502=
2010">or</span>no &quot;0&quot;. Somehow mknod02 won&#39;t display the erro=
<span class=3D"498335307-15022010">r</span>no when it=A0exit with &quot;tst=
_brkm(TBROK, cleanup, &quot;%s not in /etc/passwd&quot;, LTPUSER)&quot;=A0b=
ut I have similar tests return err<span class=3D"498335307-15022010">or</sp=
an>no 0.<span class=3D"498335307-15022010"> I see &quot;nobody&quot; user=
=A0and uid/gid -99=A0is present in /etc/passwd file. Do=A0I need to enable =
anything in KERNEL config or /etc? </span></div>
</div>
<div>=A0</div>
<div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3Dlog=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</div>
<div>&lt;&lt;&lt;test_start&gt;&gt;&gt;<br>tag=3Dnftw01 stime=3D1170483127<=
br>cmdline=3D&quot;nftw01&quot;<br>contacts=3D&quot;&quot;<br>analysis=3Dex=
it<br>&lt;&lt;&lt;test_output&gt;&gt;&gt;<br>nobody not found in /etc/passw=
d: No such file or directory<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=
=3Dno<br>cutime=3D1 cstime=3D2<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&lt;&=
lt;&lt;test_start&gt;&gt;&gt;<br>
tag=3Dnftw6401 stime=3D1170483127<br>cmdline=3D&quot;nftw6401&quot;<br>cont=
acts=3D&quot;&quot;<br>analysis=3Dexit<br>&lt;&lt;&lt;test_output&gt;&gt;&g=
t;<br>change_owner: nobody not found in /etc/passwd: No such file or direct=
ory<br>
&lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>initiation_status=3D&quot;ok&qu=
ot;<br>duration=3D0 termination_type=3Dexited termination_id=3D1 corefile=
=3Dno<br>cutime=3D2 cstime=3D1<br>&lt;&lt;&lt;test_end&gt;&gt;&gt;<br></div=
>
<div>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3Dend=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br></div>
<div>Regards</div>
<div>Vishwa</div>
<div>=A0</div>
<div class=3D"gmail_quote">On Mon, Feb 15, 2010 at 12:50 PM, Garrett Cooper=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:yanegomi@gmail.com">yanegomi@gmail=
.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Sun, Feb 14, 2010 at 11:09 PM=
, vishwanath govind<br>
<div>
<div></div>
<div class=3D"h5">&lt;<a href=3D"mailto:vishwa.hochihally@gmail.com">vishwa=
.hochihally@gmail.com</a>&gt; wrote:<br>&gt; Garrett,<br>&gt; =A0Thanks for=
 your quick reply. I am using &quot;ltp-full-20091231&quot;.<br>&gt; Regard=
s<br>
&gt; Vishwa<br>&gt;<br>&gt; On Mon, Feb 15, 2010 at 12:33 PM, Garrett Coope=
r &lt;<a href=3D"mailto:yanegomi@gmail.com">yanegomi@gmail.com</a>&gt; wrot=
e:<br>&gt;&gt;<br>&gt;&gt; On Sun, Feb 14, 2010 at 10:51 PM, vishwanath gov=
ind<br>
&gt;&gt; &lt;<a href=3D"mailto:vishwa.hochihally@gmail.com">vishwa.hochihal=
ly@gmail.com</a>&gt; wrote:<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; Hi,<br>&gt;&g=
t; &gt; I am facing common issue which causing many of the LTP syscalls tes=
t<br>
&gt;&gt; &gt; cases<br>&gt;&gt; &gt; to fail. I have taken mknod02 test to =
show this issue here. Definitely I<br>&gt;&gt; &gt; am<br>&gt;&gt; &gt; mis=
sing something out here, could you guys please point me to right<br>&gt;&gt=
; &gt; direction?=A0 Please let me know if you need some more info/log<br>
&gt;&gt; &gt;<br>&gt;&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3Dlog=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>&gt;&gt; &gt; # ls /etc=
<br>&gt;&gt; &gt; group=A0=A0 passwd<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; # ./=
IDcheck.sh<br>&gt;&gt; &gt; Checking for required user/group ids<br>
&gt;&gt; &gt; &#39;nobody&#39; user id and group found.<br>&gt;&gt; &gt; &#=
39;bin&#39; user id and group found.<br>&gt;&gt; &gt; &#39;daemon&#39; user=
 id and group found.<br>&gt;&gt; &gt; Users group found.<br>&gt;&gt; &gt; S=
ys group found.<br>
&gt;&gt; &gt; Required users/groups exist.<br>&gt;&gt; &gt;<br>&gt;&gt; &gt=
; # cat /etc/passwd<br>&gt;&gt; &gt; root:x:0:0:root::<br>&gt;&gt; &gt; nob=
ody:x:99:99:nobody::<br>&gt;&gt; &gt; bin:x:1:1:bin::<br>&gt;&gt; &gt; daem=
on:x:2:2:daemon::<br>
&gt;&gt; &gt;<br>&gt;&gt; &gt; #uname -a<br>&gt;&gt; &gt; Linux (none) 2.6.=
29 #4 PREEMPT Thu Feb 11 23:37:46 PST 2010 armv6l<br>&gt;&gt; &gt; GNU/Linu=
x<br>&gt;&gt; &gt;<br>&gt;&gt; &gt; # ./mknod02<br>&gt;&gt; &gt; mknod02=A0=
=A0=A0=A0 1=A0 TBROK=A0 :=A0 nobody not in /etc/passwd<br>
&gt;&gt;<br>&gt;&gt; What version of LTP is this?<br><br></div></div>That&#=
39;s a lousy diagnostic, as any one of the following errors could be<br>the=
 culprit:<br><br>ERRORS<br>=A0 =A0 =A0 0 or ENOENT or ESRCH or EBADF or EPE=
RM or ...<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0The given name or uid was not found.<br><br>=A0 =
=A0 =A0 EINTR =A0A signal was caught.<br><br>=A0 =A0 =A0 EIO =A0 =A0I/O err=
or.<br><br>=A0 =A0 =A0 EMFILE The maximum number (OPEN_MAX) of files was op=
en already<br>in the calling process.<br>
<br>=A0 =A0 =A0 ENFILE The maximum number of files was open already in the =
system.<br><br>=A0 =A0 =A0 ENOMEM Insufficient memory to allocate passwd st=
ructure.<br><br>=A0 =A0 =A0 ERANGE Insufficient buffer space supplied.<br><=
br>What are the permissions on the file and is there any way where you<br>
could grab the latest copy of the file from git and try that out (the<br>pa=
tch is available at:<br>&lt;<a href=3D"http://ltp.git.sourceforge.net/git/g=
itweb.cgi?p=3Dltp/ltp-dev.git;a=3Dpatch;h=3DHEAD;hp=3D8686ad72fbe76a7de8fe8=
e93ef68a71fff8a049d" target=3D"_blank">http://ltp.git.sourceforge.net/git/g=
itweb.cgi?p=3Dltp/ltp-dev.git;a=3Dpatch;h=3DHEAD;hp=3D8686ad72fbe76a7de8fe8=
e93ef68a71fff8a049d</a>&gt;)?<br>
Thanks!<br><font color=3D"#888888">-Garrett<br></font></blockquote></div><b=
r>

--000e0cd104f44fce61047f9f007d--


--===============1629520040874035075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
--===============1629520040874035075==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1629520040874035075==--

