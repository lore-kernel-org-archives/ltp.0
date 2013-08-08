Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sunildev_63@rediffmail.com>) id 1V7Py4-0005AK-Lp
	for ltp-list@lists.sourceforge.net; Thu, 08 Aug 2013 13:09:28 +0000
Received: from f5mail-224-107.rediffmail.com ([114.31.224.107]
	helo=rediffmail.com) by sog-mx-1.v43.ch3.sourceforge.com with smtp 
	(Exim 4.76) id 1V7Py3-0002wT-4l
	for ltp-list@lists.sourceforge.net; Thu, 08 Aug 2013 13:09:28 +0000
Date: 8 Aug 2013 13:09:19 -0000
Message-ID: <20130808130919.2587.qmail@f5mail-224-107.rediffmail.com>
MIME-Version: 1.0
From: "devaraja b v" <sunildev_63@rediffmail.com>
Subject: [LTP] =?utf-8?q?open_posix_testsuite_compilation?=
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8966624253918963179=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "shubham@linux.vnet.ibm.com" <shubham@linux.vnet.ibm.com>, "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============8966624253918963179==
Content-Type: multipart/alternative;
	boundary="=_59ac4257a6ef60a8d3b93f97631c729e"

--=_59ac4257a6ef60a8d3b93f97631c729e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="UTF-8"

Hi Shubham,
ltp-full-20130109 source code is having old open posix testsuite.New version posixtestsuite-1.5.2&nbsp;is available at&nbsp;http://sourceforge.net/projects/posixtest/files/posixtest/&nbsp;link.Please use this or the latest module in the next release of LTP, as the latest one is easy to cross compile and run on various platforms.
I am facing the following issues when I am compiling this new tool inside LTP.&nbsp;Please let me know any lead or pointer to fix this issue?

cat: LDFLAGS: No such file or
directoryltp/obj-i686/locate-test:
Command not foundltp/obj-i686/locate-test:
Command not foundmake-3.81[3]: *** No rule to
make target `install'.&nbsp; Stop.make-3.81[3]: Leaving
directoryltp/obj-i686/testcases/open_posix_testsuite'

make-3.81[2]: *** [install] Error
2

make-3.81[2]: Leaving directory&nbsp;ltp/obj-i686/testcases'

make-3.81[1]: ***
[testcases-install] Error 2

&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;make-3.81[1]: Leaving directory&nbsp;ltp/obj-i686'

&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp;make-3.81: ***ltp/obj-i686/install.sentinel]
Error 2

&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; &nbsp;mk: FAILED&nbsp;&nbsp;
Thanks &amp; Regards,

Devraj


--=_59ac4257a6ef60a8d3b93f97631c729e
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="UTF-8"

Hi Shubham,<div><br></div><div>ltp-full-20130109 source code is having old =
open posix testsuite.</div><div>New version p<a href=3D"http://sourceforge.=
net/projects/posixtest/files/posixtest/posixtestsuite-1.5.2/" title=3D"Clic=
k to enter posixtestsuite-1.5.2" class=3D"name" style=3D"margin: 0px; paddi=
ng: 0px; vertical-align: baseline; outline: none; color: rgb(0, 102, 153); =
text-decoration: none; -webkit-tap-highlight-color: rgb(0, 119, 170); font-=
family: sans-serif; font-weight: bold; line-height: 18px; white-space: nowr=
ap;">osixtestsuite-1.5.2</a>&nbsp;is available at&nbsp;<a href=3D"http://so=
urceforge.net/projects/posixtest/files/posixtest/">http://sourceforge.net/p=
rojects/posixtest/files/posixtest/</a>&nbsp;link.</div><div>Please use this=
 or the latest module in the next release of LTP, as the latest one is easy=
 to cross compile and run on various platforms.</div><div><br></div><div>I =
am facing the following issues when I am compiling this new tool inside LTP=
.&nbsp;</div><div>Please let me know any lead or pointer to fix this issue?=
</div><div><br></div><div><br></div><div><p class=3D"MsoNormal" style=3D"ma=
rgin-left:1.0in">cat: LDFLAGS: No such file or
directory<o:p></o:p></p><p class=3D"MsoNormal" style=3D"margin-left:1.0in">=
<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">ltp/obj-i686/loca=
te-test:
Command not found</span></p><p class=3D"MsoNormal" style=3D"margin-left:1.0=
in"><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;s=
ans-serif&quot;;
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">ltp/obj-i686/loca=
te-test:
Command not found</span></p><p class=3D"MsoNormal" style=3D"margin-left:1.0=
in"><b>make-3.81[3]: *** No rule to
make target `install'.&nbsp; Stop.<o:p></o:p></b></p><p class=3D"MsoNormal"=
 style=3D"margin-left:1.0in"><span style=3D"font-size:11.0pt;font-family:&q=
uot;Calibri&quot;,&quot;sans-serif&quot;;
mso-fareast-font-family:Calibri;mso-fareast-theme-font:minor-latin;mso-ansi=
-language:
EN-US;mso-fareast-language:EN-US;mso-bidi-language:AR-SA">make-3.81[3]: Lea=
ving
directory</span>ltp/obj-i686/testcases/open_posix_testsuite'</p><p class=3D=
"MsoNormal" style=3D"margin-left:1.0in"><o:p></o:p></p>

<p class=3D"MsoNormal" style=3D"margin-left:1.0in">make-3.81[2]: *** [insta=
ll] Error
2<o:p></o:p></p>

<p class=3D"MsoNormal" style=3D"margin-left:1.0in"><span style=3D"font-fami=
ly: Calibri, sans-serif; font-size: 11pt;">make-3.81[2]: Leaving directory&=
nbsp;</span>ltp/obj-i686/testcases'</p><p class=3D"MsoNormal" style=3D"marg=
in-left:1.0in"><o:p></o:p></p>

<p class=3D"MsoNormal" style=3D"margin-left:1.0in">make-3.81[1]: ***
[testcases-install] Error 2<o:p></o:p></p>

<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-=
serif&quot;;mso-fareast-font-family:
Calibri;mso-fareast-theme-font:minor-latin;mso-ansi-language:EN-US;mso-fare=
ast-language:
EN-US;mso-bidi-language:AR-SA"><span>&nbsp;&nbsp; &nbsp;<span>&nbsp;&nbsp; =
&nbsp;<span>&nbsp;&nbsp; &nbsp;<span>&nbsp;&nbsp; &nbsp;<span>&nbsp;&nbsp; =
&nbsp;<span>&nbsp;&nbsp; &nbsp;<span>&nbsp;&nbsp; &nbsp;<span>&nbsp;&nbsp; =
&nbsp;</span></span></span></span></span></span></span></span>make-3.81[1]:=
 Leaving directory&nbsp;</span>ltp/obj-i686'</div><p class=3D"MsoNormal" st=
yle=3D"margin-left:1.0in"><o:p></o:p></p>

<div><span style=3D"font-family: Calibri, sans-serif; font-size: 11pt;"><sp=
an>&nbsp;&nbsp;<span>&nbsp;&nbsp; &nbsp;<span>&nbsp;&nbsp; &nbsp;<span>&nbs=
p;&nbsp; &nbsp;<span>&nbsp;&nbsp; &nbsp;<span>&nbsp;&nbsp; &nbsp;<span>&nbs=
p;&nbsp; &nbsp;<span>&nbsp;&nbsp; &nbsp;<span>&nbsp;&nbsp; &nbsp;</span></s=
pan></span></span></span></span></span></span> &nbsp;</span>make-3.81: ***<=
/span>ltp/obj-i686/install.sentinel]
Error 2</div><p class=3D"MsoNormal" style=3D"margin-left:1.0in"><o:p></o:p>=
</p>

<p class=3D"MsoNormal" style=3D"margin-left:1.0in"><o:p></o:p></p><div><spa=
n>&nbsp;&nbsp; &nbsp;<span>&nbsp;&nbsp; &nbsp;<span>&nbsp;&nbsp; &nbsp;<spa=
n>&nbsp;&nbsp; &nbsp;<span>&nbsp;&nbsp; &nbsp;<span>&nbsp;&nbsp; &nbsp;<spa=
n>&nbsp;&nbsp; &nbsp;</span></span></span></span></span></span></span>mk: F=
AILED<span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;=
sans-serif&quot;;mso-fareast-font-family:
Calibri;mso-fareast-theme-font:minor-latin;mso-ansi-language:EN-US;mso-fare=
ast-language:
EN-US;mso-bidi-language:AR-SA">&nbsp;</span><span style=3D"font-family: Cal=
ibri, sans-serif; font-size: 11pt;">&nbsp;</span></div><div><br>Thanks &amp=
; Regards,<br>
Devraj<br><br></div><br><A HREF=3D"http://sigads.rediff.com/RealMedia/ads/c=
lick_nx.ads/www.rediffmail.com/signatureline.htm@Middle?" target=3D"_blank"=
><IMG SRC=3D"http://sigads.rediff.com/RealMedia/ads/adstream_nx.ads/www.red=
iffmail.com/signatureline.htm@Middle"></A><br><div style=3D"font-family:Ari=
al, Helvetica, sans-serif; font-size:14px">Get your own <span style=3D"font=
-size:12px; font-family:Arial, Helvetica, sans-serif;background-color:#C00;=
 color:#FFF; padding: 0 3px;"><b>FREE</b></span> website and domain with bu=
siness email solutions, <a href=3D"http://track.rediff.com/click?url=3D___h=
ttp://hosting.rediff.com/rediffmailpro/business-email?sc_cid=3Dsig___&cmp=
=3Dsig&lnk=3Dsig&nsrv1=3Dhost">click here</a></div>
--=_59ac4257a6ef60a8d3b93f97631c729e--


--===============8966624253918963179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
--===============8966624253918963179==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8966624253918963179==--

