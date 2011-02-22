Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PrmKE-0004mG-8R
	for ltp-list@lists.sourceforge.net; Tue, 22 Feb 2011 07:06:22 +0000
Received: from mail-pv0-f175.google.com ([74.125.83.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PrmKD-0002xL-Cj
	for ltp-list@lists.sourceforge.net; Tue, 22 Feb 2011 07:06:22 +0000
Received: by pvc30 with SMTP id 30so270421pvc.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 21 Feb 2011 23:06:15 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1082)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <AANLkTim=sePjqf=KMMkx5Ev-gsEULs+z6rLtNkkwccZP@mail.gmail.com>
Date: Mon, 21 Feb 2011 23:06:10 -0800
Message-Id: <F1C33B5B-47B2-44DB-B3F2-1C5BF98B8DE0@gmail.com>
References: <AANLkTinOqU_P=kD065O7MayXgN30NV_=D2cpqWGVwM5E@mail.gmail.com>
	<AANLkTi=iUMsdkEcvw+zpxBnZYT1AAZWAp_OHNEVVxf8=@mail.gmail.com>
	<AANLkTi=xLRif2=pK_dZewBvboKa01g-f2ZyWb-S_g_6y@mail.gmail.com>
	<AANLkTim=sePjqf=KMMkx5Ev-gsEULs+z6rLtNkkwccZP@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="===============4433306424735367674=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Amit kumar <kumaratreya@gmail.com>
Cc: ltp-list@lists.sourceforge.net


--===============4433306424735367674==
Content-Type: multipart/alternative; boundary=Apple-Mail-7-76107488


--Apple-Mail-7-76107488
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 21, 2011, at 9:05 PM, Amit kumar wrote:

> Hi,
>    we have sucessively ported LTP to Android Eclair and getting some =
issues while porting to Gingerbread.
>=20
> These testcases fpathconf and signal_test_06 are found working on =
Eclair.
>=20
> The logs can be seen as below:
>=20
> LTP - Syscall:
> cmdline=3D"fpathconf01"
> contacts=3D""
>=20
> analysis=3Dexit
> <<<test_output>>>
> fpathconf01    1  TPASS  :  fpathconf(fd, _PC_MAX_CANON) returned 255
>=20
> fpathconf01    2  TPASS  :  fpathconf(fd, _PC_MAX_INPUT) returned 255
> fpathconf01    3  TPASS  :  fpathconf(fd, _PC_VDISABLE) returned -1
>=20
> ..hangs
> LTP IPC:
>  <<<test_start>>>
>=20
> tag=3Dsignal_test_06 stime=3D1294900487
> cmdline=3D"		signal_test_06"
>=20
> contacts=3D""
> analysis=3Dexit
> <<<test_output>>>
>=20
> signal_test_06: IPC TestSuite program
>=20
> 	Block all signals from interrupting the process
>=20
>=20
> 	Send MAX (1048576) SIGUSR1 signals to the process...
>=20
> 	Ensure at least one SIGUSR1 signal is pending
>=20
>=20
> 	Change signal mask & wait for SIGUSR1 signal
> ..hangs


Amit,
	Please reread the requests and post relevant information.
	Also, dump mksh or whatever it is that you're running Android =
with when isolating the issue (SIGUSR1 might be the salient point).
Thanks,
-Garrett=

--Apple-Mail-7-76107488
Content-Transfer-Encoding: 7bit
Content-Type: text/html;
	charset=us-ascii

<html><head></head><body style="word-wrap: break-word; -webkit-nbsp-mode: space; -webkit-line-break: after-white-space; "><div><div>On Feb 21, 2011, at 9:05 PM, Amit kumar wrote:</div><br class="Apple-interchange-newline"><blockquote type="cite">Hi,<br>&nbsp;&nbsp; we have sucessively ported LTP to Android Eclair and getting some issues while porting to Gingerbread.<br><br>These testcases fpathconf and signal_test_06 are found working on Eclair.<br><br>The logs can be seen as below:<br>
<font face="Arial"><pre style="color: rgb(0, 0, 0);"><b><span class="x_167443604-22022011"><font size="2"><br>LTP - Syscall:</font></span></b></pre>
<pre><font size="2"><span style="color: rgb(0, 0, 153);">cmdline="fpathconf01"</span><br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">contacts=""</span><br style="color: rgb(0, 0, 153);">
<span style="color: rgb(0, 0, 153);">analysis=exit</span><br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">&lt;&lt;&lt;test_output&gt;&gt;&gt;</span><br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">fpathconf01    1  TPASS  :  fpathconf(fd, _PC_MAX_CANON) returned 255</span><br style="color: rgb(0, 0, 153);">
<span style="color: rgb(0, 0, 153);">fpathconf01    2  TPASS  :  fpathconf(fd, _PC_MAX_INPUT) returned 255</span><br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">fpathconf01    3  TPASS  :  fpathconf(fd, _PC_VDISABLE) returned -1</span><br>
</font></pre>
<pre style="color: rgb(255, 0, 0);"><span class="x_167443604-22022011"><font size="2">..hangs</font></span></pre>
<pre><span class="x_167443604-22022011"><font size="2"></font></span></pre>
<pre><pre style="color: rgb(0, 0, 0);"><b><span class="x_167443604-22022011"><font size="2">LTP IPC:</font></span></b></pre><pre><span class="x_167443604-22022011"></span> <font size="2"><span style="color: rgb(0, 0, 153);">&lt;&lt;&lt;test_start&gt;&gt;&gt;</span><br style="color: rgb(0, 0, 153);">
<span style="color: rgb(0, 0, 153);">tag=signal_test_06 stime=1294900487</span><br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">cmdline="		signal_test_06"</span><br style="color: rgb(0, 0, 153);">
<span style="color: rgb(0, 0, 153);">contacts=""</span><br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">analysis=exit</span><br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">&lt;&lt;&lt;test_output&gt;&gt;&gt;</span><br style="color: rgb(0, 0, 153);">
<span style="color: rgb(0, 0, 153);">signal_test_06: IPC TestSuite program</span><br style="color: rgb(0, 0, 153);"><br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">	Block all signals from interrupting the process</span><br style="color: rgb(0, 0, 153);">
<br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">	Send MAX (1048576) SIGUSR1 signals to the process...</span><br style="color: rgb(0, 0, 153);"><br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">	Ensure at least one SIGUSR1 signal is pending</span><br style="color: rgb(0, 0, 153);">
<br style="color: rgb(0, 0, 153);"><span style="color: rgb(0, 0, 153);">	Change signal mask &amp; wait for SIGUSR1 signal</span><br></font></pre><pre style="color: rgb(255, 0, 0);"><span class="x_167443604-22022011"><font size="2">..hangs</font></span></pre></pre></font></blockquote></div><div><br></div>Amit,<div><span class="Apple-tab-span" style="white-space:pre">	</span>Please reread the requests and post relevant information.</div><div><span class="Apple-tab-span" style="white-space:pre">	</span>Also, dump mksh or whatever it is that you're running Android with when isolating the issue (SIGUSR1 might be the salient point).</div><div>Thanks,</div><div>-Garrett</div></body></html>
--Apple-Mail-7-76107488--


--===============4433306424735367674==
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
--===============4433306424735367674==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4433306424735367674==--

