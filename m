Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <skrishnakar@gmail.com>) id 1MaQHN-00065M-B9
	for Ltp-list@lists.sourceforge.net; Mon, 10 Aug 2009 08:30:53 +0000
Received: from mail-pz0-f196.google.com ([209.85.222.196])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MaQHF-00020q-HD
	for Ltp-list@lists.sourceforge.net; Mon, 10 Aug 2009 08:30:53 +0000
Received: by mail-pz0-f196.google.com with SMTP id 34so2755946pzk.4
	for <Ltp-list@lists.sourceforge.net>;
	Mon, 10 Aug 2009 01:30:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1249892426.5187.12.camel@subratamodak.linux.ibm.com>
References: <6213bc560908070826u6c2b321ay446997891f2cc21f@mail.gmail.com>
	<1249892426.5187.12.camel@subratamodak.linux.ibm.com>
Date: Mon, 10 Aug 2009 13:59:40 +0530
Message-ID: <6213bc560908100129r7d59547ale6f55de87e858470@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============0597305881441848627=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: Ltp-list@lists.sourceforge.net

--===============0597305881441848627==
Content-Type: multipart/alternative; boundary=000e0cd243701ad5790470c56351

--000e0cd243701ad5790470c56351
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Mon, Aug 10, 2009 at 1:50 PM, Subrata Modak
<subrata@linux.vnet.ibm.com>wrote:

> On Fri, 2009-08-07 at 20:56 +0530, srikanth krishnakar wrote:
> > I see these two test cases are failing on PowerPC target (ppc440) as
> > shown in output file, but they are listed as PASS in log file of the
> > LTP :
> >
> > Target : PowerPC (ppc440)
> > Kernel: Linux-2.6.29
> > LTP Version : ltp-full-20090731
> >
> > LTP output file :
> > #############
> >
> >
> > 1. add_key01
> > --------------------
> >
> > <<<test_start>>>
> > tag=add_key01 stime=1248549741
> > cmdline="add_key01"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > add_key01    1  TFAIL  :  add_key01 failed - errno = 38 : Function not
> > implemented
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=0 termination_type=exited termination_id=0 corefile=no
> > cutime=0 cstime=0
> > <<<test_end>>>
> >
> > 2. add_key02
> > ----------------------
> >
> > <<<test_start>>>
> > tag=add_key02 stime=1248549741
> > cmdline="add_key02"
> > contacts=""
> > analysis=exit
> > <<<test_output>>>
> > add_key02    0  TINFO  :  call add_key() with wrong args got
> > UNEXPECTED errno:38
> > add_key02    1  TFAIL  :  add_key02 failed - errno = 38 : Function not
> > implemented
> > <<<execution_status>>>
> > initiation_status="ok"
> > duration=0 termination_type=exited termination_id=0 corefile=no
> > cutime=0 cstime=1
> > <<<test_end>>>
> >
> > --------------------------------------------------------
> >
> > BUT the Log file shows as PASS to the above test cases :
> >
> > ###########################
> >
> > add_key01                      PASS       0
> > add_key02                      PASS       0
> >
> > ###########################
> >
> >
> > May anyone explain, why it is so ? Is it a known behaviour ?
>
> No. It is not. On my X_32, it passes fine.


Is it PowePC target on which you have tested ?

>
>
> $ ./testcases/bin/add_key01
> add_key01    1  TPASS  :  add_key call succeeded
> $ echo $?
> 0
> $ ./testcases/bin/add_key02
> add_key02    0  TINFO  :  call add_key() with wrong args got EXPECTED
> errno:22
> add_key02    1  TPASS  :  add_key call succeeded
> $ echo $?
> 0
> $ uname -a
> Linux 2.6.18-92.el5 #1 SMP Tue Apr 29 13:16:12 EDT 2008 i686 i686 i386
> GNU/Linux
>
> Regards--
> Subrata
>
> >
> >
> > Regards
> > Srikanth Krishnakar
> > **********************
> >
> ------------------------------------------------------------------------------
> > Let Crystal Reports handle the reporting - Free Crystal Reports 2008
> 30-Day
> > trial. Simplify your report design, integration and deployment - and
> focus on
> > what you do best, core application coding. Discover what's new with
> > Crystal Reports now.  http://p.sf.net/sfu/bobj-july
> > _______________________________________________ Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>


-- 
"The Good You Do, The Best You GET"

Regards
Srikanth Krishnakar
**********************

--000e0cd243701ad5790470c56351
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Aug 10, 2009 at 1:50 PM, Subrata=
 Modak <span dir=3D"ltr">&lt;<a href=3D"mailto:subrata@linux.vnet.ibm.com">=
subrata@linux.vnet.ibm.com</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt =
0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class=3D"h5">On Fri, 2009-08-07 at 20:56 +0530, srikan=
th krishnakar wrote:<br>
&gt; I see these two test cases are failing on PowerPC target (ppc440) as<b=
r>
&gt; shown in output file, but they are listed as PASS in log file of the<b=
r>
&gt; LTP :<br>
&gt;<br>
&gt; Target : PowerPC (ppc440)<br>
&gt; Kernel: Linux-2.6.29<br>
&gt; LTP Version : ltp-full-20090731<br>
&gt;<br>
&gt; LTP output file :<br>
&gt; #############<br>
&gt;<br>
&gt;<br>
&gt; 1. add_key01<br>
&gt; --------------------<br>
&gt;<br>
&gt; &lt;&lt;&lt;test_start&gt;&gt;&gt;<br>
&gt; tag=3Dadd_key01 stime=3D1248549741<br>
&gt; cmdline=3D&quot;add_key01&quot;<br>
&gt; contacts=3D&quot;&quot;<br>
&gt; analysis=3Dexit<br>
&gt; &lt;&lt;&lt;test_output&gt;&gt;&gt;<br>
&gt; add_key01 =A0 =A01 =A0TFAIL =A0: =A0add_key01 failed - errno =3D 38 : =
Function not<br>
&gt; implemented<br>
&gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>
&gt; initiation_status=3D&quot;ok&quot;<br>
&gt; duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dn=
o<br>
&gt; cutime=3D0 cstime=3D0<br>
&gt; &lt;&lt;&lt;test_end&gt;&gt;&gt;<br>
&gt;<br>
&gt; 2. add_key02<br>
&gt; ----------------------<br>
&gt;<br>
&gt; &lt;&lt;&lt;test_start&gt;&gt;&gt;<br>
&gt; tag=3Dadd_key02 stime=3D1248549741<br>
&gt; cmdline=3D&quot;add_key02&quot;<br>
&gt; contacts=3D&quot;&quot;<br>
&gt; analysis=3Dexit<br>
&gt; &lt;&lt;&lt;test_output&gt;&gt;&gt;<br>
&gt; add_key02 =A0 =A00 =A0TINFO =A0: =A0call add_key() with wrong args got=
<br>
&gt; UNEXPECTED errno:38<br>
&gt; add_key02 =A0 =A01 =A0TFAIL =A0: =A0add_key02 failed - errno =3D 38 : =
Function not<br>
&gt; implemented<br>
&gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>
&gt; initiation_status=3D&quot;ok&quot;<br>
&gt; duration=3D0 termination_type=3Dexited termination_id=3D0 corefile=3Dn=
o<br>
&gt; cutime=3D0 cstime=3D1<br>
&gt; &lt;&lt;&lt;test_end&gt;&gt;&gt;<br>
&gt;<br>
&gt; --------------------------------------------------------<br>
&gt;<br>
&gt; BUT the Log file shows as PASS to the above test cases :<br>
&gt;<br>
&gt; ###########################<br>
&gt;<br>
&gt; add_key01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PASS =A0 =A0 =A0 =
0<br>
&gt; add_key02 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PASS =A0 =A0 =A0 =
0<br>
&gt;<br>
&gt; ###########################<br>
&gt;<br>
&gt;<br>
&gt; May anyone explain, why it is so ? Is it a known behaviour ?<br>
<br>
</div></div>No. It is not. On my X_32, it passes fine.</blockquote><div><br=
>Is it PowePC target on which you have tested ?=A0 <br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); mar=
gin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<br>
<br>
$ ./testcases/bin/add_key01<br>
add_key01 =A0 =A01 =A0TPASS =A0: =A0add_key call succeeded<br>
$ echo $?<br>
0<br>
$ ./testcases/bin/add_key02<br>
add_key02 =A0 =A00 =A0TINFO =A0: =A0call add_key() with wrong args got EXPE=
CTED<br>
errno:22<br>
add_key02 =A0 =A01 =A0TPASS =A0: =A0add_key call succeeded<br>
$ echo $?<br>
0<br>
$ uname -a<br>
Linux 2.6.18-92.el5 #1 SMP Tue Apr 29 13:16:12 EDT 2008 i686 i686 i386<br>
GNU/Linux<br>
<br>
Regards--<br>
Subrata<br>
<br>
&gt;<br>
&gt;<br>
&gt; Regards<br>
&gt; Srikanth Krishnakar<br>
&gt; **********************<br>
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
&gt; _______________________________________________ Ltp-list mailing list =
<a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforg=
e.net</a> <a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list"=
 target=3D"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a=
><br>

<br>
</blockquote></div><br><br clear=3D"all"><br>-- <br>&quot;The Good You Do, =
The Best You GET&quot;<br><br>Regards<br>Srikanth Krishnakar<br>***********=
***********<br>

--000e0cd243701ad5790470c56351--


--===============0597305881441848627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============0597305881441848627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0597305881441848627==--

