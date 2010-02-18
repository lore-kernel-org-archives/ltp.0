Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vishwa.hochihally@gmail.com>) id 1Ni4yM-0004Ib-CP
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 11:55:10 +0000
Received: from mail-pz0-f199.google.com ([209.85.222.199])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ni4yJ-000121-R1
	for ltp-list@lists.sourceforge.net; Thu, 18 Feb 2010 11:55:10 +0000
Received: by pzk37 with SMTP id 37so8203593pzk.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 18 Feb 2010 03:55:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f41002152330r15274a12p4630be799f88b9d4@mail.gmail.com>
References: <4b9fdcd01002142251l2cb9036fvde4fbc60bbae85a4@mail.gmail.com>
	<364299f41002142303t19a2dd85ve9d87245084ff4ff@mail.gmail.com>
	<4b9fdcd01002142309p2bc18e0yfaa0876694cc4f57@mail.gmail.com>
	<364299f41002142320p24b3e50fj8b56bb15dad2a524@mail.gmail.com>
	<4b9fdcd01002142359w4b275c73s91ea258eee1de146@mail.gmail.com>
	<364299f41002150018p1a6888b6r4cb95731deffcd0b@mail.gmail.com>
	<4b9fdcd01002152325w6bee8349t173c6f0afd935070@mail.gmail.com>
	<364299f41002152330r15274a12p4630be799f88b9d4@mail.gmail.com>
Date: Thu, 18 Feb 2010 17:25:01 +0530
Message-ID: <4b9fdcd01002180355j571da4c5hce9c1dde0ee28f26@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============8450470746783300030=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============8450470746783300030==
Content-Type: multipart/alternative; boundary=000e0cd1ad1c047d69047fdea32a

--000e0cd1ad1c047d69047fdea32a
Content-Type: text/plain; charset=ISO-8859-1

Garret,
>>Do you have an alternative means of checking, like with perl,
python, etc?

Finally I cross-compiled Python and  got it workin on my target device. is
it possible to use python and parse /etc/passwd file for getpwnam() funtion.
I believe if it returns uid and gid of the given user is more than enough
correct?
>>Do you need to update your shadow password db setup?
 I dont have shadow password db setup in filesystem but ported openLDAP  to
my target device, is this help me ? The target device doen't have ethernet
controller support so i cann't communicate to host. Curently passwd and
group files in /etc directory as i mentioned above.

Please let me know your thoughts.

Regards
Vishwa
On Tue, Feb 16, 2010 at 1:00 PM, Garrett Cooper <yanegomi@gmail.com> wrote:

> On Mon, Feb 15, 2010 at 11:25 PM, vishwanath govind
>  <vishwa.hochihally@gmail.com> wrote:
> > I have initramfs file system built using Busybox-1.16.0 and didn't setup
> the
> > ldap/nis. I have few files in /etc like passwd,group and syslogd conf
> > files.But getpwnam() should search local repository(/etc/passwd file) and
> > returns a pointer to a struct passwd, correct?. Do i really need to setup
> > ldap/NIS to make it work getpwnam() funtion? The device i am using has
> > memory restriction to add more stuff to filesystem and its very minimal.
> So
> > please guide me what are the minimal things need to setup to get
> getpwnam()
> > function working? Please correct me if i am wrong here.
> >
> > Regards
> > Vishwa
> >
> > On Mon, Feb 15, 2010 at 1:48 PM, Garrett Cooper <yanegomi@gmail.com>
> wrote:
> >>
> >> On Sun, Feb 14, 2010 at 11:59 PM, vishwanath govind
> >> <vishwa.hochihally@gmail.com> wrote:
> >> > Yes, I checked this before, It return errorno "0". Somehow mknod02
> won't
> >> > display the errorno when it exit with "tst_brkm(TBROK, cleanup, "%s
> not
> >> > in
> >> > /etc/passwd", LTPUSER)" but I have similar tests return errorno 0. I
> see
> >> > "nobody" user and uid/gid -99 is present in /etc/passwd file. Do I
> need
> >> > to
> >> > enable anything in KERNEL config or /etc?
> >> >
> >> > ============================log===============================
> >> > <<<test_start>>>
> >> > tag=nftw01 stime=1170483127
> >> > cmdline="nftw01"
> >> > contacts=""
> >> > analysis=exit
> >> > <<<test_output>>>
> >> > nobody not found in /etc/passwd: No such file or directory
> >> > <<<execution_status>>>
> >> > initiation_status="ok"
> >> > duration=0 termination_type=exited termination_id=1 corefile=no
> >> > cutime=1 cstime=2
> >> > <<<test_end>>>
> >> > <<<test_start>>>
> >> > tag=nftw6401 stime=1170483127
> >> > cmdline="nftw6401"
> >> > contacts=""
> >> > analysis=exit
> >> > <<<test_output>>>
> >> > change_owner: nobody not found in /etc/passwd: No such file or
> directory
> >> > <<<execution_status>>>
> >> > initiation_status="ok"
> >> > duration=0 termination_type=exited termination_id=1 corefile=no
> >> > cutime=2 cstime=1
> >> > <<<test_end>>>
> >> > ==============================end==================================
> >> > Regards
> >> > Vishwa
> >> >
> >> > On Mon, Feb 15, 2010 at 12:50 PM, Garrett Cooper <yanegomi@gmail.com>
> >> > wrote:
> >> >>
> >> >> On Sun, Feb 14, 2010 at 11:09 PM, vishwanath govind
> >> >> <vishwa.hochihally@gmail.com> wrote:
> >> >> > Garrett,
> >> >> >  Thanks for your quick reply. I am using "ltp-full-20091231".
> >> >> > Regards
> >> >> > Vishwa
> >> >> >
> >> >> > On Mon, Feb 15, 2010 at 12:33 PM, Garrett Cooper <
> yanegomi@gmail.com>
> >> >> > wrote:
> >> >> >>
> >> >> >> On Sun, Feb 14, 2010 at 10:51 PM, vishwanath govind
> >> >> >> <vishwa.hochihally@gmail.com> wrote:
> >> >> >> >
> >> >> >> > Hi,
> >> >> >> > I am facing common issue which causing many of the LTP syscalls
> >> >> >> > test
> >> >> >> > cases
> >> >> >> > to fail. I have taken mknod02 test to show this issue here.
> >> >> >> > Definitely I
> >> >> >> > am
> >> >> >> > missing something out here, could you guys please point me to
> >> >> >> > right
> >> >> >> > direction?  Please let me know if you need some more info/log
> >> >> >> >
> >> >> >> > ======================log================================
> >> >> >> > # ls /etc
> >> >> >> > group   passwd
> >> >> >> >
> >> >> >> > # ./IDcheck.sh
> >> >> >> > Checking for required user/group ids
> >> >> >> > 'nobody' user id and group found.
> >> >> >> > 'bin' user id and group found.
> >> >> >> > 'daemon' user id and group found.
> >> >> >> > Users group found.
> >> >> >> > Sys group found.
> >> >> >> > Required users/groups exist.
> >> >> >> >
> >> >> >> > # cat /etc/passwd
> >> >> >> > root:x:0:0:root::
> >> >> >> > nobody:x:99:99:nobody::
> >> >> >> > bin:x:1:1:bin::
> >> >> >> > daemon:x:2:2:daemon::
> >> >> >> >
> >> >> >> > #uname -a
> >> >> >> > Linux (none) 2.6.29 #4 PREEMPT Thu Feb 11 23:37:46 PST 2010
> armv6l
> >> >> >> > GNU/Linux
> >> >> >> >
> >> >> >> > # ./mknod02
> >> >> >> > mknod02     1  TBROK  :  nobody not in /etc/passwd
> >> >> >>
> >> >> >> What version of LTP is this?
> >> >>
> >> >> That's a lousy diagnostic, as any one of the following errors could
> be
> >> >> the culprit:
> >> >>
> >> >> ERRORS
> >> >>       0 or ENOENT or ESRCH or EBADF or EPERM or ...
> >> >>              The given name or uid was not found.
> >> >>
> >> >>       EINTR  A signal was caught.
> >> >>
> >> >>       EIO    I/O error.
> >> >>
> >> >>       EMFILE The maximum number (OPEN_MAX) of files was open already
> >> >> in the calling process.
> >> >>
> >> >>       ENFILE The maximum number of files was open already in the
> >> >> system.
> >> >>
> >> >>       ENOMEM Insufficient memory to allocate passwd structure.
> >> >>
> >> >>       ERANGE Insufficient buffer space supplied.
> >> >>
> >> >> What are the permissions on the file and is there any way where you
> >> >> could grab the latest copy of the file from git and try that out (the
> >> >> patch is available at:
> >>
> >> Nope... you sure your ldap / nis isn't busted?
>
>    No.. heh. I was just wondering if you had it partially setup but
> it was broken somehow.
>    Do you have an alternative means of checking, like with perl,
> python, etc? Do you need to update your shadow password db setup?
> Thanks,
> -Garrett
>

--000e0cd1ad1c047d69047fdea32a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div>Garret,</div>
<div>&gt;&gt;Do you have an alternative means of checking, like with perl,<=
br>python, etc? </div>
<div>=A0</div>
<div>Finally=A0I cross-compiled Python and =A0got=A0it workin on my target =
device. is it possible to use python and parse /etc/passwd file for getpwna=
m() funtion. I believe if it=A0returns uid and gid of the given user is mor=
e than enough correct?=A0=A0<br>
</div>
<div>&gt;&gt;Do you need to update your shadow password db setup?<br>=A0I d=
ont have shadow password db setup in filesystem but ported openLDAP=A0 to m=
y target device, is=A0this help me ? The target device doen&#39;t have ethe=
rnet controller support so i cann&#39;t communicate to host. Curently=A0pas=
swd and group files in /etc directory as i mentioned above.</div>

<div>=A0</div>
<div>Please let me know your thoughts.</div>
<div>=A0</div>
<div>Regards</div>
<div>Vishwa<br></div>
<div class=3D"gmail_quote">On Tue, Feb 16, 2010 at 1:00 PM, Garrett Cooper =
<span dir=3D"ltr">&lt;<a href=3D"mailto:yanegomi@gmail.com">yanegomi@gmail.=
com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Mon, Feb 15, 2010 at 11:25 PM=
, vishwanath govind<br>
<div>
<div></div>
<div class=3D"h5">&lt;<a href=3D"mailto:vishwa.hochihally@gmail.com">vishwa=
.hochihally@gmail.com</a>&gt; wrote:<br>&gt; I have initramfs file system b=
uilt using Busybox-1.16.0 and didn&#39;t setup the<br>&gt; ldap/nis. I have=
 few files in /etc like passwd,group and syslogd conf<br>
&gt; files.But getpwnam() should search local repository(/etc/passwd file) =
and<br>&gt; returns a pointer to a struct passwd, correct?. Do i really nee=
d to setup<br>&gt; ldap/NIS to make it work getpwnam() funtion? The device =
i am using has<br>
&gt; memory restriction to add more stuff to filesystem and its very minima=
l. So<br>&gt; please guide me what are the minimal things need to setup to =
get getpwnam()<br>&gt; function working? Please correct me if i am wrong he=
re.<br>
&gt;<br>&gt; Regards<br>&gt; Vishwa<br>&gt;<br>&gt; On Mon, Feb 15, 2010 at=
 1:48 PM, Garrett Cooper &lt;<a href=3D"mailto:yanegomi@gmail.com">yanegomi=
@gmail.com</a>&gt; wrote:<br>&gt;&gt;<br>&gt;&gt; On Sun, Feb 14, 2010 at 1=
1:59 PM, vishwanath govind<br>
&gt;&gt; &lt;<a href=3D"mailto:vishwa.hochihally@gmail.com">vishwa.hochihal=
ly@gmail.com</a>&gt; wrote:<br>&gt;&gt; &gt; Yes, I checked this before, It=
 return errorno &quot;0&quot;. Somehow mknod02 won&#39;t<br>&gt;&gt; &gt; d=
isplay the errorno when it=A0exit with &quot;tst_brkm(TBROK, cleanup, &quot=
;%s not<br>
&gt;&gt; &gt; in<br>&gt;&gt; &gt; /etc/passwd&quot;, LTPUSER)&quot;=A0but I=
 have similar tests return errorno 0. I see<br>&gt;&gt; &gt; &quot;nobody&q=
uot; user=A0and uid/gid -99=A0is present in /etc/passwd file. Do=A0I need<b=
r>&gt;&gt; &gt; to<br>
&gt;&gt; &gt; enable anything in KERNEL config or /etc?<br>&gt;&gt; &gt;<br=
>&gt;&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3Dlog=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>&gt;&gt; &gt; &lt;&lt;&lt;=
test_start&gt;&gt;&gt;<br>&gt;&gt; &gt; tag=3Dnftw01 stime=3D1170483127<br>
&gt;&gt; &gt; cmdline=3D&quot;nftw01&quot;<br>&gt;&gt; &gt; contacts=3D&quo=
t;&quot;<br>&gt;&gt; &gt; analysis=3Dexit<br>&gt;&gt; &gt; &lt;&lt;&lt;test=
_output&gt;&gt;&gt;<br>&gt;&gt; &gt; nobody not found in /etc/passwd: No su=
ch file or directory<br>
&gt;&gt; &gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>&gt;&gt; &gt; ini=
tiation_status=3D&quot;ok&quot;<br>&gt;&gt; &gt; duration=3D0 termination_t=
ype=3Dexited termination_id=3D1 corefile=3Dno<br>&gt;&gt; &gt; cutime=3D1 c=
stime=3D2<br>
&gt;&gt; &gt; &lt;&lt;&lt;test_end&gt;&gt;&gt;<br>&gt;&gt; &gt; &lt;&lt;&lt=
;test_start&gt;&gt;&gt;<br>&gt;&gt; &gt; tag=3Dnftw6401 stime=3D1170483127<=
br>&gt;&gt; &gt; cmdline=3D&quot;nftw6401&quot;<br>&gt;&gt; &gt; contacts=
=3D&quot;&quot;<br>
&gt;&gt; &gt; analysis=3Dexit<br>&gt;&gt; &gt; &lt;&lt;&lt;test_output&gt;&=
gt;&gt;<br>&gt;&gt; &gt; change_owner: nobody not found in /etc/passwd: No =
such file or directory<br>&gt;&gt; &gt; &lt;&lt;&lt;execution_status&gt;&gt=
;&gt;<br>
&gt;&gt; &gt; initiation_status=3D&quot;ok&quot;<br>&gt;&gt; &gt; duration=
=3D0 termination_type=3Dexited termination_id=3D1 corefile=3Dno<br>&gt;&gt;=
 &gt; cutime=3D2 cstime=3D1<br>&gt;&gt; &gt; &lt;&lt;&lt;test_end&gt;&gt;&g=
t;<br>&gt;&gt; &gt; =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dend=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
&gt;&gt; &gt; Regards<br>&gt;&gt; &gt; Vishwa<br>&gt;&gt; &gt;<br>&gt;&gt; =
&gt; On Mon, Feb 15, 2010 at 12:50 PM, Garrett Cooper &lt;<a href=3D"mailto=
:yanegomi@gmail.com">yanegomi@gmail.com</a>&gt;<br>&gt;&gt; &gt; wrote:<br>
&gt;&gt; &gt;&gt;<br>&gt;&gt; &gt;&gt; On Sun, Feb 14, 2010 at 11:09 PM, vi=
shwanath govind<br>&gt;&gt; &gt;&gt; &lt;<a href=3D"mailto:vishwa.hochihall=
y@gmail.com">vishwa.hochihally@gmail.com</a>&gt; wrote:<br>&gt;&gt; &gt;&gt=
; &gt; Garrett,<br>
&gt;&gt; &gt;&gt; &gt; =A0Thanks for your quick reply. I am using &quot;ltp=
-full-20091231&quot;.<br>&gt;&gt; &gt;&gt; &gt; Regards<br>&gt;&gt; &gt;&gt=
; &gt; Vishwa<br>&gt;&gt; &gt;&gt; &gt;<br>&gt;&gt; &gt;&gt; &gt; On Mon, F=
eb 15, 2010 at 12:33 PM, Garrett Cooper &lt;<a href=3D"mailto:yanegomi@gmai=
l.com">yanegomi@gmail.com</a>&gt;<br>
&gt;&gt; &gt;&gt; &gt; wrote:<br>&gt;&gt; &gt;&gt; &gt;&gt;<br>&gt;&gt; &gt=
;&gt; &gt;&gt; On Sun, Feb 14, 2010 at 10:51 PM, vishwanath govind<br>&gt;&=
gt; &gt;&gt; &gt;&gt; &lt;<a href=3D"mailto:vishwa.hochihally@gmail.com">vi=
shwa.hochihally@gmail.com</a>&gt; wrote:<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>&gt;&gt; &gt;&gt; &gt;&gt; &gt; Hi,<br>&=
gt;&gt; &gt;&gt; &gt;&gt; &gt; I am facing common issue which causing many =
of the LTP syscalls<br>&gt;&gt; &gt;&gt; &gt;&gt; &gt; test<br>&gt;&gt; &gt=
;&gt; &gt;&gt; &gt; cases<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; to fail. I have taken mknod02 test to show =
this issue here.<br>&gt;&gt; &gt;&gt; &gt;&gt; &gt; Definitely I<br>&gt;&gt=
; &gt;&gt; &gt;&gt; &gt; am<br>&gt;&gt; &gt;&gt; &gt;&gt; &gt; missing some=
thing out here, could you guys please point me to<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; right<br>&gt;&gt; &gt;&gt; &gt;&gt; &gt; di=
rection?=A0 Please let me know if you need some more info/log<br>&gt;&gt; &=
gt;&gt; &gt;&gt; &gt;<br>&gt;&gt; &gt;&gt; &gt;&gt; &gt; =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dlog=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br=
>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; # ls /etc<br>&gt;&gt; &gt;&gt; &gt;&gt; &gt=
; group=A0=A0 passwd<br>&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>&gt;&gt; &gt;&gt=
; &gt;&gt; &gt; # ./IDcheck.sh<br>&gt;&gt; &gt;&gt; &gt;&gt; &gt; Checking =
for required user/group ids<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; &#39;nobody&#39; user id and group found.<b=
r>&gt;&gt; &gt;&gt; &gt;&gt; &gt; &#39;bin&#39; user id and group found.<br=
>&gt;&gt; &gt;&gt; &gt;&gt; &gt; &#39;daemon&#39; user id and group found.<=
br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; Users group found.<br>&gt;&gt; &gt;&gt; &gt=
;&gt; &gt; Sys group found.<br>&gt;&gt; &gt;&gt; &gt;&gt; &gt; Required use=
rs/groups exist.<br>&gt;&gt; &gt;&gt; &gt;&gt; &gt;<br>&gt;&gt; &gt;&gt; &g=
t;&gt; &gt; # cat /etc/passwd<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; root:x:0:0:root::<br>&gt;&gt; &gt;&gt; &gt;=
&gt; &gt; nobody:x:99:99:nobody::<br>&gt;&gt; &gt;&gt; &gt;&gt; &gt; bin:x:=
1:1:bin::<br>&gt;&gt; &gt;&gt; &gt;&gt; &gt; daemon:x:2:2:daemon::<br>&gt;&=
gt; &gt;&gt; &gt;&gt; &gt;<br>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; #uname -a<br>&gt;&gt; &gt;&gt; &gt;&gt; &gt=
; Linux (none) 2.6.29 #4 PREEMPT Thu Feb 11 23:37:46 PST 2010 armv6l<br>&gt=
;&gt; &gt;&gt; &gt;&gt; &gt; GNU/Linux<br>&gt;&gt; &gt;&gt; &gt;&gt; &gt;<b=
r>
&gt;&gt; &gt;&gt; &gt;&gt; &gt; # ./mknod02<br>&gt;&gt; &gt;&gt; &gt;&gt; &=
gt; mknod02=A0=A0=A0=A0 1=A0 TBROK=A0 :=A0 nobody not in /etc/passwd<br>&gt=
;&gt; &gt;&gt; &gt;&gt;<br>&gt;&gt; &gt;&gt; &gt;&gt; What version of LTP i=
s this?<br>
&gt;&gt; &gt;&gt;<br>&gt;&gt; &gt;&gt; That&#39;s a lousy diagnostic, as an=
y one of the following errors could be<br>&gt;&gt; &gt;&gt; the culprit:<br=
>&gt;&gt; &gt;&gt;<br>&gt;&gt; &gt;&gt; ERRORS<br>&gt;&gt; &gt;&gt; =A0 =A0=
 =A0 0 or ENOENT or ESRCH or EBADF or EPERM or ...<br>
&gt;&gt; &gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0The given name or uid was not =
found.<br>&gt;&gt; &gt;&gt;<br>&gt;&gt; &gt;&gt; =A0 =A0 =A0 EINTR =A0A sig=
nal was caught.<br>&gt;&gt; &gt;&gt;<br>&gt;&gt; &gt;&gt; =A0 =A0 =A0 EIO =
=A0 =A0I/O error.<br>&gt;&gt; &gt;&gt;<br>
&gt;&gt; &gt;&gt; =A0 =A0 =A0 EMFILE The maximum number (OPEN_MAX) of files=
 was open already<br>&gt;&gt; &gt;&gt; in the calling process.<br>&gt;&gt; =
&gt;&gt;<br>&gt;&gt; &gt;&gt; =A0 =A0 =A0 ENFILE The maximum number of file=
s was open already in the<br>
&gt;&gt; &gt;&gt; system.<br>&gt;&gt; &gt;&gt;<br>&gt;&gt; &gt;&gt; =A0 =A0=
 =A0 ENOMEM Insufficient memory to allocate passwd structure.<br>&gt;&gt; &=
gt;&gt;<br>&gt;&gt; &gt;&gt; =A0 =A0 =A0 ERANGE Insufficient buffer space s=
upplied.<br>
&gt;&gt; &gt;&gt;<br>&gt;&gt; &gt;&gt; What are the permissions on the file=
 and is there any way where you<br>&gt;&gt; &gt;&gt; could grab the latest =
copy of the file from git and try that out (the<br>&gt;&gt; &gt;&gt; patch =
is available at:<br>
&gt;&gt;<br>&gt;&gt; Nope... you sure your ldap / nis isn&#39;t busted?<br>=
<br></div></div>=A0 =A0No.. heh. I was just wondering if you had it partial=
ly setup but<br>it was broken somehow.<br>=A0 =A0Do you have an alternative=
 means of checking, like with perl,<br>
python, etc? Do you need to update your shadow password db setup?<br>Thanks=
,<br><font color=3D"#888888">-Garrett<br></font></blockquote></div><br>

--000e0cd1ad1c047d69047fdea32a--


--===============8450470746783300030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&reg; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs 
proactively, and fine-tune applications for parallel performance. 
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--===============8450470746783300030==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8450470746783300030==--

