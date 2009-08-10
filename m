Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <skrishnakar@gmail.com>) id 1MaXg8-0004uQ-H2
	for Ltp-list@lists.sourceforge.net; Mon, 10 Aug 2009 16:24:56 +0000
Received: from wf-out-1314.google.com ([209.85.200.175])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MaXg2-0004T5-B9
	for Ltp-list@lists.sourceforge.net; Mon, 10 Aug 2009 16:24:56 +0000
Received: by wf-out-1314.google.com with SMTP id 26so1138973wfd.4
	for <Ltp-list@lists.sourceforge.net>;
	Mon, 10 Aug 2009 09:24:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40908100844l44497151g750f745648080c24@mail.gmail.com>
References: <6213bc560908070826u6c2b321ay446997891f2cc21f@mail.gmail.com>
	<1249892426.5187.12.camel@subratamodak.linux.ibm.com>
	<6213bc560908100129r7d59547ale6f55de87e858470@mail.gmail.com>
	<364299f40908100844l44497151g750f745648080c24@mail.gmail.com>
Date: Mon, 10 Aug 2009 21:54:44 +0530
Message-ID: <6213bc560908100924h2d0da433y52391da42aeeaa16@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============7259305080169730109=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: Ltp-list@lists.sourceforge.net

--===============7259305080169730109==
Content-Type: multipart/alternative; boundary=00504502c4e1114b110470cc06c8

--00504502c4e1114b110470cc06c8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Mon, Aug 10, 2009 at 9:14 PM, Garrett Cooper <yanegomi@gmail.com> wrote:

> On Mon, Aug 10, 2009 at 1:29 AM, srikanth
> krishnakar<skrishnakar@gmail.com> wrote:
> >
> >
> > On Mon, Aug 10, 2009 at 1:50 PM, Subrata Modak <
> subrata@linux.vnet.ibm.com>
> > wrote:
> >>
> >> On Fri, 2009-08-07 at 20:56 +0530, srikanth krishnakar wrote:
> >> > I see these two test cases are failing on PowerPC target (ppc440) as
> >> > shown in output file, but they are listed as PASS in log file of the
> >> > LTP :
> >> >
> >> > Target : PowerPC (ppc440)
> >> > Kernel: Linux-2.6.29
> >> > LTP Version : ltp-full-20090731
> >> >
> >> > LTP output file :
> >> > #############
> >> >
> >> >
> >> > 1. add_key01
> >> > --------------------
> >> >
> >> > <<<test_start>>>
> >> > tag=add_key01 stime=1248549741
> >> > cmdline="add_key01"
> >> > contacts=""
> >> > analysis=exit
> >> > <<<test_output>>>
> >> > add_key01    1  TFAIL  :  add_key01 failed - errno = 38 : Function not
> >> > implemented
> >> > <<<execution_status>>>
> >> > initiation_status="ok"
> >> > duration=0 termination_type=exited termination_id=0 corefile=no
> >> > cutime=0 cstime=0
> >> > <<<test_end>>>
> >> >
> >> > 2. add_key02
> >> > ----------------------
> >> >
> >> > <<<test_start>>>
> >> > tag=add_key02 stime=1248549741
> >> > cmdline="add_key02"
> >> > contacts=""
> >> > analysis=exit
> >> > <<<test_output>>>
> >> > add_key02    0  TINFO  :  call add_key() with wrong args got
> >> > UNEXPECTED errno:38
> >> > add_key02    1  TFAIL  :  add_key02 failed - errno = 38 : Function not
> >> > implemented
> >> > <<<execution_status>>>
> >> > initiation_status="ok"
> >> > duration=0 termination_type=exited termination_id=0 corefile=no
> >> > cutime=0 cstime=1
> >> > <<<test_end>>>
> >> >
> >> > --------------------------------------------------------
> >> >
> >> > BUT the Log file shows as PASS to the above test cases :
> >> >
> >> > ###########################
> >> >
> >> > add_key01                      PASS       0
> >> > add_key02                      PASS       0
> >> >
> >> > ###########################
> >> >
> >> >
> >> > May anyone explain, why it is so ? Is it a known behaviour ?
> >>
> >> No. It is not. On my X_32, it passes fine.
> >
> > Is it PowePC target on which you have tested ?
> >>
> >>
> >> $ ./testcases/bin/add_key01
> >> add_key01    1  TPASS  :  add_key call succeeded
> >> $ echo $?
> >> 0
> >> $ ./testcases/bin/add_key02
> >> add_key02    0  TINFO  :  call add_key() with wrong args got EXPECTED
> >> errno:22
> >> add_key02    1  TPASS  :  add_key call succeeded
> >> $ echo $?
> >> 0
> >> $ uname -a
> >> Linux 2.6.18-92.el5 #1 SMP Tue Apr 29 13:16:12 EDT 2008 i686 i686 i386
> >> GNU/Linux
>
> Hi Srikanth,
>    I think that the error is fairly intuitive (function not
> implemented). Are you sure that your subarchitecture supports
> add_key(2)?
> Hi Subrata,
>    As far as the actual issue is concerned, I think that the problem
> is that someone's exiting with exit(0) instead of tst_exit()...
> Thanks,
> -Garrett
>

Thanks Garrett,

I will look into it.

-- 
"The Good You Do, The Best You GET"

Regards
Srikanth Krishnakar
**********************

--00504502c4e1114b110470cc06c8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Mon, Aug 10, 2009 at 9:14 PM, Garrett=
 Cooper <span dir=3D"ltr">&lt;<a href=3D"mailto:yanegomi@gmail.com">yanegom=
i@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; =
padding-left: 1ex;">
<div><div></div><div class=3D"h5">On Mon, Aug 10, 2009 at 1:29 AM, srikanth=
<br>
krishnakar&lt;<a href=3D"mailto:skrishnakar@gmail.com">skrishnakar@gmail.co=
m</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; On Mon, Aug 10, 2009 at 1:50 PM, Subrata Modak &lt;<a href=3D"mailto:s=
ubrata@linux.vnet.ibm.com">subrata@linux.vnet.ibm.com</a>&gt;<br>
&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; On Fri, 2009-08-07 at 20:56 +0530, srikanth krishnakar wrote:<br>
&gt;&gt; &gt; I see these two test cases are failing on PowerPC target (ppc=
440) as<br>
&gt;&gt; &gt; shown in output file, but they are listed as PASS in log file=
 of the<br>
&gt;&gt; &gt; LTP :<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Target : PowerPC (ppc440)<br>
&gt;&gt; &gt; Kernel: Linux-2.6.29<br>
&gt;&gt; &gt; LTP Version : ltp-full-20090731<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; LTP output file :<br>
&gt;&gt; &gt; #############<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; 1. add_key01<br>
&gt;&gt; &gt; --------------------<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; &lt;&lt;&lt;test_start&gt;&gt;&gt;<br>
&gt;&gt; &gt; tag=3Dadd_key01 stime=3D1248549741<br>
&gt;&gt; &gt; cmdline=3D&quot;add_key01&quot;<br>
&gt;&gt; &gt; contacts=3D&quot;&quot;<br>
&gt;&gt; &gt; analysis=3Dexit<br>
&gt;&gt; &gt; &lt;&lt;&lt;test_output&gt;&gt;&gt;<br>
&gt;&gt; &gt; add_key01 =A0 =A01 =A0TFAIL =A0: =A0add_key01 failed - errno =
=3D 38 : Function not<br>
&gt;&gt; &gt; implemented<br>
&gt;&gt; &gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>
&gt;&gt; &gt; initiation_status=3D&quot;ok&quot;<br>
&gt;&gt; &gt; duration=3D0 termination_type=3Dexited termination_id=3D0 cor=
efile=3Dno<br>
&gt;&gt; &gt; cutime=3D0 cstime=3D0<br>
&gt;&gt; &gt; &lt;&lt;&lt;test_end&gt;&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; 2. add_key02<br>
&gt;&gt; &gt; ----------------------<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; &lt;&lt;&lt;test_start&gt;&gt;&gt;<br>
&gt;&gt; &gt; tag=3Dadd_key02 stime=3D1248549741<br>
&gt;&gt; &gt; cmdline=3D&quot;add_key02&quot;<br>
&gt;&gt; &gt; contacts=3D&quot;&quot;<br>
&gt;&gt; &gt; analysis=3Dexit<br>
&gt;&gt; &gt; &lt;&lt;&lt;test_output&gt;&gt;&gt;<br>
&gt;&gt; &gt; add_key02 =A0 =A00 =A0TINFO =A0: =A0call add_key() with wrong=
 args got<br>
&gt;&gt; &gt; UNEXPECTED errno:38<br>
&gt;&gt; &gt; add_key02 =A0 =A01 =A0TFAIL =A0: =A0add_key02 failed - errno =
=3D 38 : Function not<br>
&gt;&gt; &gt; implemented<br>
&gt;&gt; &gt; &lt;&lt;&lt;execution_status&gt;&gt;&gt;<br>
&gt;&gt; &gt; initiation_status=3D&quot;ok&quot;<br>
&gt;&gt; &gt; duration=3D0 termination_type=3Dexited termination_id=3D0 cor=
efile=3Dno<br>
&gt;&gt; &gt; cutime=3D0 cstime=3D1<br>
&gt;&gt; &gt; &lt;&lt;&lt;test_end&gt;&gt;&gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; --------------------------------------------------------<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; BUT the Log file shows as PASS to the above test cases :<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ###########################<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; add_key01 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PASS =A0=
 =A0 =A0 0<br>
&gt;&gt; &gt; add_key02 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0PASS =A0=
 =A0 =A0 0<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; ###########################<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; May anyone explain, why it is so ? Is it a known behaviour ?<=
br>
&gt;&gt;<br>
&gt;&gt; No. It is not. On my X_32, it passes fine.<br>
&gt;<br>
&gt; Is it PowePC target on which you have tested ?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; $ ./testcases/bin/add_key01<br>
&gt;&gt; add_key01 =A0 =A01 =A0TPASS =A0: =A0add_key call succeeded<br>
&gt;&gt; $ echo $?<br>
&gt;&gt; 0<br>
&gt;&gt; $ ./testcases/bin/add_key02<br>
&gt;&gt; add_key02 =A0 =A00 =A0TINFO =A0: =A0call add_key() with wrong args=
 got EXPECTED<br>
&gt;&gt; errno:22<br>
&gt;&gt; add_key02 =A0 =A01 =A0TPASS =A0: =A0add_key call succeeded<br>
&gt;&gt; $ echo $?<br>
&gt;&gt; 0<br>
&gt;&gt; $ uname -a<br>
&gt;&gt; Linux 2.6.18-92.el5 #1 SMP Tue Apr 29 13:16:12 EDT 2008 i686 i686 =
i386<br>
&gt;&gt; GNU/Linux<br>
<br>
</div></div>Hi Srikanth,<br>
 =A0 =A0I think that the error is fairly intuitive (function not<br>
implemented). Are you sure that your subarchitecture supports<br>
add_key(2)?<br>
Hi Subrata,<br>
 =A0 =A0As far as the actual issue is concerned, I think that the problem<b=
r>
is that someone&#39;s exiting with exit(0) instead of tst_exit()...<br>
Thanks,<br>
<font color=3D"#888888">-Garrett<br>
</font></blockquote></div><br>Thanks Garrett,<br><br>I will look into it.<b=
r><br>-- <br>&quot;The Good You Do, The Best You GET&quot;<br><br>Regards<b=
r>Srikanth Krishnakar<br>**********************<br>

--00504502c4e1114b110470cc06c8--


--===============7259305080169730109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============7259305080169730109==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7259305080169730109==--

