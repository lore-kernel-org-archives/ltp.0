Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <skrishnakar@gmail.com>) id 1MazN2-0008Mo-H0
	for Ltp-list@lists.sourceforge.net; Tue, 11 Aug 2009 21:59:04 +0000
Received: from wf-out-1314.google.com ([209.85.200.173])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MazN1-0002Z4-DK
	for Ltp-list@lists.sourceforge.net; Tue, 11 Aug 2009 21:59:04 +0000
Received: by wf-out-1314.google.com with SMTP id 26so1487442wfd.4
	for <Ltp-list@lists.sourceforge.net>;
	Tue, 11 Aug 2009 14:58:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A81BA46.3050302@petalogix.com>
References: <6213bc560908070826u6c2b321ay446997891f2cc21f@mail.gmail.com>
	<1249892426.5187.12.camel@subratamodak.linux.ibm.com>
	<6213bc560908100129r7d59547ale6f55de87e858470@mail.gmail.com>
	<364299f40908100844l44497151g750f745648080c24@mail.gmail.com>
	<6213bc560908100924h2d0da433y52391da42aeeaa16@mail.gmail.com>
	<6213bc560908110605q45ced45dgd36026da8adc0bb5@mail.gmail.com>
	<4A81BA46.3050302@petalogix.com>
Date: Wed, 12 Aug 2009 03:28:57 +0530
Message-ID: <6213bc560908111458v711d891cmf14b1212bbd567bc@mail.gmail.com>
From: srikanth krishnakar <skrishnakar@gmail.com>
Subject: Re: [LTP] add_key01 & add_key02 test cases fails and shown as PASS
	in log file
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5857682394122693463=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: michal.simek@petalogix.com
Cc: Ltp-list@lists.sourceforge.net

--===============5857682394122693463==
Content-Type: multipart/alternative; boundary=000e0cd28cf029a68b0470e4cfe4

--000e0cd28cf029a68b0470e4cfe4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Thanks Michal,

I have following options set in my kernel :

#
# Security options
#
*# CONFIG_KEYS is not set*
CONFIG_SECURITY=y
# CONFIG_SECURITYFS is not set
# CONFIG_SECURITY_NETWORK is not set
# CONFIG_SECURITY_PATH is not set
# CONFIG_SECURITY_FILE_CAPABILITIES is not set
CONFIG_SECURITY_DEFAULT_MMAP_MIN_ADDR=0
CONFIG_CRYPTO=y

#

I will re-run after setting this option.

Thanks,
-Srikanth

On Wed, Aug 12, 2009 at 12:06 AM, Michal Simek
<michal.simek@petalogix.com>wrote:

> Trace add_key syscall and find that for this testcases you have to
> enable CONFIG_KEYS in your kernel.
> This could be reason to add new return value for Function is not
> implemented and any sensible description
> to test.
>
> Cheers,
> Michal
> > Hi all,
> >
> > I observed that these two test cases are known to be failing on
> > following architectures :
> >
> > 1. *PowerPC* (ppc440)    > Kernel */Linux-2.6.29.6/*
> > 2. *MIPS*                       > Kernel /*Linux-2.6.28.10*/
> >
> > <<<test_start>>>
> > tag=*add_key01* stime=1249655730
> > cmdline="add_key01"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > add_key01    1  TFAIL  :  add_key01 failed - errno = 38 : *Function
> > not implemented*
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=0 termination_type=exited termination_id=0 corefile=no
> > cutime=1 cstime=0
> > <<<test_end>>>
> >
> >
> > <<<test_start>>>
> > tag=*add_key02* stime=1249655730
> > cmdline="add_key02"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > add_key02    0  TINFO  :  call add_key() with wrong args got
> > UNEXPECTED errno:38
> > add_key02    1  TFAIL  :  add_key02 failed - errno = 38 :* Function
> > not implemented*
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=1 termination_type=exited termination_id=0 corefile=no
> > cutime=0 cstime=2
> > <<<test_end>>>
> >
> > Are these two test cases intended for these architectures ? Have you
> > tested these tests on any of above mentioned architectures ?
> >
> > Waiting for your comments ?
> >
> > -Srikanth
> >
> > On Mon, Aug 10, 2009 at 9:54 PM, srikanth krishnakar
> > <skrishnakar@gmail.com <mailto:skrishnakar@gmail.com>> wrote:
> >
> >
> >
> >     On Mon, Aug 10, 2009 at 9:14 PM, Garrett Cooper
> >     <yanegomi@gmail.com <mailto:yanegomi@gmail.com>> wrote:
> >
> >         On Mon, Aug 10, 2009 at 1:29 AM, srikanth
> >         krishnakar<skrishnakar@gmail.com
> >         <mailto:skrishnakar@gmail.com>> wrote:
> >         >
> >         >
> >         > On Mon, Aug 10, 2009 at 1:50 PM, Subrata Modak
> >         <subrata@linux.vnet.ibm.com <mailto:subrata@linux.vnet.ibm.com>>
> >         > wrote:
> >         >>
> >         >> On Fri, 2009-08-07 at 20:56 +0530, srikanth krishnakar wrote:
> >         >> > I see these two test cases are failing on PowerPC target
> >         (ppc440) as
> >         >> > shown in output file, but they are listed as PASS in log
> >         file of the
> >         >> > LTP :
> >         >> >
> >         >> > Target : PowerPC (ppc440)
> >         >> > Kernel: Linux-2.6.29
> >         >> > LTP Version : ltp-full-20090731
> >         >> >
> >         >> > LTP output file :
> >         >> > #############
> >         >> >
> >         >> >
> >         >> > 1. add_key01
> >         >> > --------------------
> >         >> >
> >         >> > <<<test_start>>>
> >         >> > tag=add_key01 stime=1248549741
> >         >> > cmdline="add_key01"
> >         >> > contacts=""
> >         >> > analysis=exit
> >         >> > <<<test_output>>>
> >         >> > add_key01    1  TFAIL  :  add_key01 failed - errno = 38 :
> >         Function not
> >         >> > implemented
> >         >> > <<<execution_status>>>
> >         >> > initiation_status="ok"
> >         >> > duration=0 termination_type=exited termination_id=0
> >         corefile=no
> >         >> > cutime=0 cstime=0
> >         >> > <<<test_end>>>
> >         >> >
> >         >> > 2. add_key02
> >         >> > ----------------------
> >         >> >
> >         >> > <<<test_start>>>
> >         >> > tag=add_key02 stime=1248549741
> >         >> > cmdline="add_key02"
> >         >> > contacts=""
> >         >> > analysis=exit
> >         >> > <<<test_output>>>
> >         >> > add_key02    0  TINFO  :  call add_key() with wrong args got
> >         >> > UNEXPECTED errno:38
> >         >> > add_key02    1  TFAIL  :  add_key02 failed - errno = 38 :
> >         Function not
> >         >> > implemented
> >         >> > <<<execution_status>>>
> >         >> > initiation_status="ok"
> >         >> > duration=0 termination_type=exited termination_id=0
> >         corefile=no
> >         >> > cutime=0 cstime=1
> >         >> > <<<test_end>>>
> >         >> >
> >         >> > --------------------------------------------------------
> >         >> >
> >         >> > BUT the Log file shows as PASS to the above test cases :
> >         >> >
> >         >> > ###########################
> >         >> >
> >         >> > add_key01                      PASS       0
> >         >> > add_key02                      PASS       0
> >         >> >
> >         >> > ###########################
> >         >> >
> >         >> >
> >         >> > May anyone explain, why it is so ? Is it a known behaviour ?
> >         >>
> >         >> No. It is not. On my X_32, it passes fine.
> >         >
> >         > Is it PowePC target on which you have tested ?
> >         >>
> >         >>
> >         >> $ ./testcases/bin/add_key01
> >         >> add_key01    1  TPASS  :  add_key call succeeded
> >         >> $ echo $?
> >         >> 0
> >         >> $ ./testcases/bin/add_key02
> >         >> add_key02    0  TINFO  :  call add_key() with wrong args
> >         got EXPECTED
> >         >> errno:22
> >         >> add_key02    1  TPASS  :  add_key call succeeded
> >         >> $ echo $?
> >         >> 0
> >         >> $ uname -a
> >         >> Linux 2.6.18-92.el5 #1 SMP Tue Apr 29 13:16:12 EDT 2008
> >         i686 i686 i386
> >         >> GNU/Linux
> >
> >         Hi Srikanth,
> >            I think that the error is fairly intuitive (function not
> >         implemented). Are you sure that your subarchitecture supports
> >         add_key(2)?
> >         Hi Subrata,
> >            As far as the actual issue is concerned, I think that the
> >         problem
> >         is that someone's exiting with exit(0) instead of tst_exit()...
> >         Thanks,
> >         -Garrett
> >
> >
> >     Thanks Garrett,
> >
> >     I will look into it.
> >
> >
> >     --
> >     "The Good You Do, The Best You GET"
> >
> >     Regards
> >     Srikanth Krishnakar
> >     **********************
> >
> >
> >
> >
> > --
> > "The Good You Do, The Best You GET"
> >
> > Regards
> > Srikanth Krishnakar
> > **********************
> > ------------------------------------------------------------------------
> >
> >
> ------------------------------------------------------------------------------
> > Let Crystal Reports handle the reporting - Free Crystal Reports 2008
> 30-Day
> > trial. Simplify your report design, integration and deployment - and
> focus on
> > what you do best, core application coding. Discover what's new with
> > Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> > ------------------------------------------------------------------------
> >
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> >
>
>
> --
> Michal Simek, Ing. (M.Eng)
> PetaLogix - Linux Solutions for a Reconfigurable World
> w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663
>
>


-- 
"The Good You Do, The Best You GET"

Regards
Srikanth Krishnakar
**********************

--000e0cd28cf029a68b0470e4cfe4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks Michal,<br><br>I have following options set in my kernel :<br><br>#<=
br># Security options<br>#<br><b># CONFIG_KEYS is not set</b><br>CONFIG_SEC=
URITY=3Dy<br># CONFIG_SECURITYFS is not set<br># CONFIG_SECURITY_NETWORK is=
 not set<br>
# CONFIG_SECURITY_PATH is not set<br># CONFIG_SECURITY_FILE_CAPABILITIES is=
 not set<br>CONFIG_SECURITY_DEFAULT_MMAP_MIN_ADDR=3D0<br>CONFIG_CRYPTO=3Dy<=
br><br>#<br><br>I will re-run after setting this option.<br><br>Thanks,<br>
-Srikanth<br><br><div class=3D"gmail_quote">On Wed, Aug 12, 2009 at 12:06 A=
M, Michal Simek <span dir=3D"ltr">&lt;<a href=3D"mailto:michal.simek@petalo=
gix.com">michal.simek@petalogix.com</a>&gt;</span> wrote:<br><blockquote cl=
ass=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); mar=
gin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Trace add_key syscall and find that for this testcases you have to<br>
enable CONFIG_KEYS in your kernel.<br>
This could be reason to add new return value for Function is not<br>
implemented and any sensible description<br>
to test.<br>
<br>
Cheers,<br>
Michal<br>
<div><div></div><div class=3D"h5">&gt; Hi all,<br>
&gt;<br>
&gt; I observed that these two test cases are known to be failing on<br>
&gt; following architectures :<br>
&gt;<br>
&gt; 1. *PowerPC* (ppc440) =A0 =A0&gt; Kernel */Linux-2.6.29.6/*<br>
&gt; 2. *MIPS* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; Kernel /*Li=
nux-2.6.28.10*/<br>
&gt;<br>
&gt; &lt;&lt;&lt;test_start&gt;&gt;&gt;<br>
&gt; tag=3D*add_key01* stime=3D1249655730<br>
&gt; cmdline=3D&quot;add_key01&quot;<br>
&gt; contacts=3D&quot;&quot;<br>
&gt; analysis=3Dexit<br>
&gt; &lt;&lt;&lt;test_output&gt;&gt;&gt;<br>
&gt; add_key01 =A0 =A01 =A0TFAIL =A0: =A0add_key01 failed - errno =3D 38 : =
*Function<br>
&gt; not implemented*<br>
&gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>
&gt; initiation_status=3D&quot;ok&quot;<br>
&gt; duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dn=
o<br>
&gt; cutime=3D1 cstime=3D0<br>
&gt; &lt;&lt;&lt;test_end&gt;&gt;&gt;<br>
&gt;<br>
&gt;<br>
&gt; &lt;&lt;&lt;test_start&gt;&gt;&gt;<br>
&gt; tag=3D*add_key02* stime=3D1249655730<br>
&gt; cmdline=3D&quot;add_key02&quot;<br>
&gt; contacts=3D&quot;&quot;<br>
&gt; analysis=3Dexit<br>
&gt; &lt;&lt;&lt;test_output&gt;&gt;&gt;<br>
&gt; add_key02 =A0 =A00 =A0TINFO =A0: =A0call add_key() with wrong args got=
<br>
&gt; UNEXPECTED errno:38<br>
&gt; add_key02 =A0 =A01 =A0TFAIL =A0: =A0add_key02 failed - errno =3D 38 :*=
 Function<br>
&gt; not implemented*<br>
&gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>
&gt; initiation_status=3D&quot;ok&quot;<br>
&gt; duration=3D1 termination_type=3Dexited termination_id=3D0 corefile=3Dn=
o<br>
&gt; cutime=3D0 cstime=3D2<br>
&gt; &lt;&lt;&lt;test_end&gt;&gt;&gt;<br>
&gt;<br>
&gt; Are these two test cases intended for these architectures ? Have you<b=
r>
&gt; tested these tests on any of above mentioned architectures ?<br>
&gt;<br>
&gt; Waiting for your comments ?<br>
&gt;<br>
&gt; -Srikanth<br>
&gt;<br>
&gt; On Mon, Aug 10, 2009 at 9:54 PM, srikanth krishnakar<br>
</div></div><div class=3D"im">&gt; &lt;<a href=3D"mailto:skrishnakar@gmail.=
com">skrishnakar@gmail.com</a> &lt;mailto:<a href=3D"mailto:skrishnakar@gma=
il.com">skrishnakar@gmail.com</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 On Mon, Aug 10, 2009 at 9:14 PM, Garrett Cooper<br>
</div><div class=3D"im">&gt; =A0 =A0 &lt;<a href=3D"mailto:yanegomi@gmail.c=
om">yanegomi@gmail.com</a> &lt;mailto:<a href=3D"mailto:yanegomi@gmail.com"=
>yanegomi@gmail.com</a>&gt;&gt; wrote:<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 On Mon, Aug 10, 2009 at 1:29 AM, srikanth<br>
&gt; =A0 =A0 =A0 =A0 krishnakar&lt;<a href=3D"mailto:skrishnakar@gmail.com"=
>skrishnakar@gmail.com</a><br>
</div><div class=3D"im">&gt; =A0 =A0 =A0 =A0 &lt;mailto:<a href=3D"mailto:s=
krishnakar@gmail.com">skrishnakar@gmail.com</a>&gt;&gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; On Mon, Aug 10, 2009 at 1:50 PM, Subrata Modak<br=
>
</div>&gt; =A0 =A0 =A0 =A0 &lt;<a href=3D"mailto:subrata@linux.vnet.ibm.com=
">subrata@linux.vnet.ibm.com</a> &lt;mailto:<a href=3D"mailto:subrata@linux=
.vnet.ibm.com">subrata@linux.vnet.ibm.com</a>&gt;&gt;<br>
<div><div></div><div class=3D"h5">&gt; =A0 =A0 =A0 =A0 &gt; wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; On Fri, 2009-08-07 at 20:56 +0530, srikanth k=
rishnakar wrote:<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; I see these two test cases are failing o=
n PowerPC target<br>
&gt; =A0 =A0 =A0 =A0 (ppc440) as<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; shown in output file, but they are liste=
d as PASS in log<br>
&gt; =A0 =A0 =A0 =A0 file of the<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; LTP :<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; Target : PowerPC (ppc440)<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; Kernel: Linux-2.6.29<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; LTP Version : ltp-full-20090731<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; LTP output file :<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; #############<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; 1. add_key01<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; --------------------<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; &lt;&lt;&lt;test_start&gt;&gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; tag=3Dadd_key01 stime=3D1248549741<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; cmdline=3D&quot;add_key01&quot;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; contacts=3D&quot;&quot;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; analysis=3Dexit<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; &lt;&lt;&lt;test_output&gt;&gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; add_key01 =A0 =A01 =A0TFAIL =A0: =A0add_=
key01 failed - errno =3D 38 :<br>
&gt; =A0 =A0 =A0 =A0 Function not<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; implemented<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;=
<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; initiation_status=3D&quot;ok&quot;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; duration=3D0 termination_type=3Dexited t=
ermination_id=3D0<br>
&gt; =A0 =A0 =A0 =A0 corefile=3Dno<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; cutime=3D0 cstime=3D0<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; &lt;&lt;&lt;test_end&gt;&gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; 2. add_key02<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; ----------------------<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; &lt;&lt;&lt;test_start&gt;&gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; tag=3Dadd_key02 stime=3D1248549741<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; cmdline=3D&quot;add_key02&quot;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; contacts=3D&quot;&quot;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; analysis=3Dexit<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; &lt;&lt;&lt;test_output&gt;&gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; add_key02 =A0 =A00 =A0TINFO =A0: =A0call=
 add_key() with wrong args got<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; UNEXPECTED errno:38<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; add_key02 =A0 =A01 =A0TFAIL =A0: =A0add_=
key02 failed - errno =3D 38 :<br>
&gt; =A0 =A0 =A0 =A0 Function not<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; implemented<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;=
<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; initiation_status=3D&quot;ok&quot;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; duration=3D0 termination_type=3Dexited t=
ermination_id=3D0<br>
&gt; =A0 =A0 =A0 =A0 corefile=3Dno<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; cutime=3D0 cstime=3D1<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; &lt;&lt;&lt;test_end&gt;&gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; ----------------------------------------=
----------------<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; BUT the Log file shows as PASS to the ab=
ove test cases :<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; ###########################<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; add_key01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0PASS =A0 =A0 =A0 0<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; add_key02 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0PASS =A0 =A0 =A0 0<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; ###########################<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; &gt; May anyone explain, why it is so ? Is it=
 a known behaviour ?<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; No. It is not. On my X_32, it passes fine.<br=
>
&gt; =A0 =A0 =A0 =A0 &gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt; Is it PowePC target on which you have tested ?<br=
>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt;<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; $ ./testcases/bin/add_key01<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; add_key01 =A0 =A01 =A0TPASS =A0: =A0add_key c=
all succeeded<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; $ echo $?<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; 0<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; $ ./testcases/bin/add_key02<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; add_key02 =A0 =A00 =A0TINFO =A0: =A0call add_=
key() with wrong args<br>
&gt; =A0 =A0 =A0 =A0 got EXPECTED<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; errno:22<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; add_key02 =A0 =A01 =A0TPASS =A0: =A0add_key c=
all succeeded<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; $ echo $?<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; 0<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; $ uname -a<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; Linux 2.6.18-92.el5 #1 SMP Tue Apr 29 13:16:1=
2 EDT 2008<br>
&gt; =A0 =A0 =A0 =A0 i686 i686 i386<br>
&gt; =A0 =A0 =A0 =A0 &gt;&gt; GNU/Linux<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 Hi Srikanth,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0I think that the error is fairly intuitive (fun=
ction not<br>
&gt; =A0 =A0 =A0 =A0 implemented). Are you sure that your subarchitecture s=
upports<br>
&gt; =A0 =A0 =A0 =A0 add_key(2)?<br>
&gt; =A0 =A0 =A0 =A0 Hi Subrata,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0As far as the actual issue is concerned, I thin=
k that the<br>
&gt; =A0 =A0 =A0 =A0 problem<br>
&gt; =A0 =A0 =A0 =A0 is that someone&#39;s exiting with exit(0) instead of =
tst_exit()...<br>
&gt; =A0 =A0 =A0 =A0 Thanks,<br>
&gt; =A0 =A0 =A0 =A0 -Garrett<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 Thanks Garrett,<br>
&gt;<br>
&gt; =A0 =A0 I will look into it.<br>
&gt;<br>
&gt;<br>
&gt; =A0 =A0 --<br>
&gt; =A0 =A0 &quot;The Good You Do, The Best You GET&quot;<br>
&gt;<br>
&gt; =A0 =A0 Regards<br>
&gt; =A0 =A0 Srikanth Krishnakar<br>
&gt; =A0 =A0 **********************<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; &quot;The Good You Do, The Best You GET&quot;<br>
&gt;<br>
&gt; Regards<br>
&gt; Srikanth Krishnakar<br>
&gt; **********************<br>
</div></div>&gt; ----------------------------------------------------------=
--------------<br>
<div><div></div><div class=3D"h5">&gt;<br>
&gt; ----------------------------------------------------------------------=
--------<br>
&gt; Let Crystal Reports handle the reporting - Free Crystal Reports 2008 3=
0-Day<br>
&gt; trial. Simplify your report design, integration and deployment - and f=
ocus on<br>
&gt; what you do best, core application coding. Discover what&#39;s new wit=
h<br>
&gt; Crystal Reports now. =A0<a href=3D"http://p.sf.net/sfu/bobj-july" targ=
et=3D"_blank">http://p.sf.net/sfu/bobj-july</a><br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; Ltp-list mailing list<br>
&gt; <a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourc=
eforge.net</a><br>
&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
&gt;<br>
<br>
<br>
--<br>
</div></div><font color=3D"#888888">Michal Simek, Ing. (M.Eng)<br>
PetaLogix - Linux Solutions for a Reconfigurable World<br>
w: <a href=3D"http://www.petalogix.com" target=3D"_blank">www.petalogix.com=
</a> p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663<br>
<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br>&quot;The Good Y=
ou Do, The Best You GET&quot;<br><br>Regards<br>Srikanth Krishnakar<br>****=
******************<br>

--000e0cd28cf029a68b0470e4cfe4--


--===============5857682394122693463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============5857682394122693463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5857682394122693463==--

