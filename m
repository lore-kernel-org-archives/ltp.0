Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <kumaratreya@gmail.com>) id 1PrkRV-0001eW-6e
	for ltp-list@lists.sourceforge.net; Tue, 22 Feb 2011 05:05:45 +0000
Received: from mail-vw0-f47.google.com ([209.85.212.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.74) id 1PrkRU-0008CX-AJ
	for ltp-list@lists.sourceforge.net; Tue, 22 Feb 2011 05:05:45 +0000
Received: by vws4 with SMTP id 4so971731vws.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 21 Feb 2011 21:05:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <AANLkTi=xLRif2=pK_dZewBvboKa01g-f2ZyWb-S_g_6y@mail.gmail.com>
References: <AANLkTinOqU_P=kD065O7MayXgN30NV_=D2cpqWGVwM5E@mail.gmail.com>
	<AANLkTi=iUMsdkEcvw+zpxBnZYT1AAZWAp_OHNEVVxf8=@mail.gmail.com>
	<AANLkTi=xLRif2=pK_dZewBvboKa01g-f2ZyWb-S_g_6y@mail.gmail.com>
Date: Tue, 22 Feb 2011 10:35:38 +0530
Message-ID: <AANLkTim=sePjqf=KMMkx5Ev-gsEULs+z6rLtNkkwccZP@mail.gmail.com>
From: Amit kumar <kumaratreya@gmail.com>
Subject: Re: [LTP] LTP test cases fpathconf syscall and signal_test_06 ipc
 test cases found hanging on android Gingerbread kernel
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0994424662154039214=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============0994424662154039214==
Content-Type: multipart/alternative; boundary=bcaec53f944f6991a8049cd7eeb2

--bcaec53f944f6991a8049cd7eeb2
Content-Type: text/plain; charset=ISO-8859-1

Hi,
   we have sucessively ported LTP to Android Eclair and getting some issues
while porting to Gingerbread.

These testcases fpathconf and signal_test_06 are found working on Eclair.

The logs can be seen as below:

*
LTP - Syscall:*

cmdline="fpathconf01"
contacts=""
analysis=exit
<<<test_output>>>
fpathconf01    1  TPASS  :  fpathconf(fd, _PC_MAX_CANON) returned 255
fpathconf01    2  TPASS  :  fpathconf(fd, _PC_MAX_INPUT) returned 255
fpathconf01    3  TPASS  :  fpathconf(fd, _PC_VDISABLE) returned -1

..hangs

 *LTP IPC:*

 <<<test_start>>>
tag=signal_test_06 stime=1294900487
cmdline="		signal_test_06"
contacts=""
analysis=exit
<<<test_output>>>
signal_test_06: IPC TestSuite program

	Block all signals from interrupting the process

	Send MAX (1048576) SIGUSR1 signals to the process...

	Ensure at least one SIGUSR1 signal is pending

	Change signal mask & wait for SIGUSR1 signal

..hangs


Thanks and Regards,

Amit kumar



On Tue, Feb 22, 2011 at 1:35 AM, Garrett Cooper <yanegomi@gmail.com> wrote:

> On Sun, Feb 20, 2011 at 10:31 PM, Amit kumar <kumaratreya@gmail.com>
> wrote:
> > Hi,
> > I am using LTP to test Android platform and successively ported to Eclair
> > after customization.
> >
> >
> > fpathconf syscall and signal_test_06 ipc test cases found hanging on
> Android
> > Gingerbread Kernel.
> >
> >
> > Are these know issues or we need to fix them?
>
>     Does this work when it's treated as a UCLINUX platform? I know
> (based on previous reading) that Android uses Bionic libc, which is a
> BSD based libc, and potentially incomplete compared to glibc or others
> on the GNU/Linux platform.
>    As an aside, I find it funny how Linux folks seem to be mixing and
> matching libraries and kernels on `production' platforms like this,
> expecting success.
> Thanks,
> -Garrett
>



--

--bcaec53f944f6991a8049cd7eeb2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,<br>=A0=A0 we have sucessively ported LTP to Android Eclair and getting =
some issues while porting to Gingerbread.<br><br>These testcases fpathconf =
and signal_test_06 are found working on Eclair.<br><br>The logs can be seen=
 as below:<br>
<font face=3D"Arial"><pre style=3D"color: rgb(0, 0, 0);"><b><span class=3D"=
x_167443604-22022011"><font size=3D"2"><br>LTP - Syscall:</font></span></b>=
</pre>
<pre><font size=3D"2"><span style=3D"color: rgb(0, 0, 153);">cmdline=3D&quo=
t;fpathconf01&quot;</span><br style=3D"color: rgb(0, 0, 153);"><span style=
=3D"color: rgb(0, 0, 153);">contacts=3D&quot;&quot;</span><br style=3D"colo=
r: rgb(0, 0, 153);">
<span style=3D"color: rgb(0, 0, 153);">analysis=3Dexit</span><br style=3D"c=
olor: rgb(0, 0, 153);"><span style=3D"color: rgb(0, 0, 153);">&lt;&lt;&lt;t=
est_output&gt;&gt;&gt;</span><br style=3D"color: rgb(0, 0, 153);"><span sty=
le=3D"color: rgb(0, 0, 153);">fpathconf01    1  TPASS  :  fpathconf(fd, _PC=
_MAX_CANON) returned 255</span><br style=3D"color: rgb(0, 0, 153);">
<span style=3D"color: rgb(0, 0, 153);">fpathconf01    2  TPASS  :  fpathcon=
f(fd, _PC_MAX_INPUT) returned 255</span><br style=3D"color: rgb(0, 0, 153);=
"><span style=3D"color: rgb(0, 0, 153);">fpathconf01    3  TPASS  :  fpathc=
onf(fd, _PC_VDISABLE) returned -1</span><br>
</font></pre>
<pre style=3D"color: rgb(255, 0, 0);"><span class=3D"x_167443604-22022011">=
<font size=3D"2">..hangs</font></span></pre>
<pre><span class=3D"x_167443604-22022011"><font size=3D"2"></font></span></=
pre>
<pre><pre style=3D"color: rgb(0, 0, 0);"><b><span class=3D"x_167443604-2202=
2011"><font size=3D"2">LTP IPC:</font></span></b></pre><pre><span class=3D"=
x_167443604-22022011"></span> <font size=3D"2"><span style=3D"color: rgb(0,=
 0, 153);">&lt;&lt;&lt;test_start&gt;&gt;&gt;</span><br style=3D"color: rgb=
(0, 0, 153);">
<span style=3D"color: rgb(0, 0, 153);">tag=3Dsignal_test_06 stime=3D1294900=
487</span><br style=3D"color: rgb(0, 0, 153);"><span style=3D"color: rgb(0,=
 0, 153);">cmdline=3D&quot;		signal_test_06&quot;</span><br style=3D"color:=
 rgb(0, 0, 153);">
<span style=3D"color: rgb(0, 0, 153);">contacts=3D&quot;&quot;</span><br st=
yle=3D"color: rgb(0, 0, 153);"><span style=3D"color: rgb(0, 0, 153);">analy=
sis=3Dexit</span><br style=3D"color: rgb(0, 0, 153);"><span style=3D"color:=
 rgb(0, 0, 153);">&lt;&lt;&lt;test_output&gt;&gt;&gt;</span><br style=3D"co=
lor: rgb(0, 0, 153);">
<span style=3D"color: rgb(0, 0, 153);">signal_test_06: IPC TestSuite progra=
m</span><br style=3D"color: rgb(0, 0, 153);"><br style=3D"color: rgb(0, 0, =
153);"><span style=3D"color: rgb(0, 0, 153);">	Block all signals from inter=
rupting the process</span><br style=3D"color: rgb(0, 0, 153);">
<br style=3D"color: rgb(0, 0, 153);"><span style=3D"color: rgb(0, 0, 153);"=
>	Send MAX (1048576) SIGUSR1 signals to the process...</span><br style=3D"c=
olor: rgb(0, 0, 153);"><br style=3D"color: rgb(0, 0, 153);"><span style=3D"=
color: rgb(0, 0, 153);">	Ensure at least one SIGUSR1 signal is pending</spa=
n><br style=3D"color: rgb(0, 0, 153);">
<br style=3D"color: rgb(0, 0, 153);"><span style=3D"color: rgb(0, 0, 153);"=
>	Change signal mask &amp; wait for SIGUSR1 signal</span><br></font></pre><=
pre style=3D"color: rgb(255, 0, 0);"><span class=3D"x_167443604-22022011"><=
font size=3D"2">..hangs</font></span></pre>
</pre></font><br>Thanks and Regards,<br><br>Amit kumar<br><br><br><br><div =
class=3D"gmail_quote">On Tue, Feb 22, 2011 at 1:35 AM, Garrett Cooper <span=
 dir=3D"ltr">&lt;<a href=3D"mailto:yanegomi@gmail.com">yanegomi@gmail.com</=
a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div class=3D"im"=
>On Sun, Feb 20, 2011 at 10:31 PM, Amit kumar &lt;<a href=3D"mailto:kumarat=
reya@gmail.com">kumaratreya@gmail.com</a>&gt; wrote:<br>

&gt; Hi,<br>
&gt; I am using LTP to test Android platform and successively ported to Ecl=
air<br>
&gt; after customization.<br>
&gt;<br>
&gt;<br>
&gt; fpathconf syscall and signal_test_06 ipc test cases found hanging on A=
ndroid<br>
&gt; Gingerbread Kernel.<br>
&gt;<br>
&gt;<br>
&gt; Are these know issues or we need to fix them?<br>
<br>
</div> =A0 =A0Does this work when it&#39;s treated as a UCLINUX platform? I=
 know<br>
(based on previous reading) that Android uses Bionic libc, which is a<br>
BSD based libc, and potentially incomplete compared to glibc or others<br>
on the GNU/Linux platform.<br>
 =A0 =A0As an aside, I find it funny how Linux folks seem to be mixing and<=
br>
matching libraries and kernels on `production&#39; platforms like this,<br>
expecting success.<br>
Thanks,<br>
<font color=3D"#888888">-Garrett<br>
</font></blockquote></div><br><br clear=3D"all"><br>-- <br><br>

--bcaec53f944f6991a8049cd7eeb2--


--===============0994424662154039214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Index, Search & Analyze Logs and other IT data in Real-Time with Splunk 
Collect, index and harness all the fast moving IT data generated by your 
applications, servers and devices whether physical, virtual or in the cloud.
Deliver compliance at lower cost and gain new business insights. 
Free Software Download: http://p.sf.net/sfu/splunk-dev2dev
--===============0994424662154039214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============0994424662154039214==--

