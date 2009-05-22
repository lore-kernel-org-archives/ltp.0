Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <srinivass@in.ibm.com>) id 1M7Vk9-0005n9-Qf
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 14:29:05 +0000
Received: from e28smtp08.in.ibm.com ([59.145.155.8])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M7Vk8-0007b5-1U
	for ltp-list@lists.sourceforge.net; Fri, 22 May 2009 14:29:05 +0000
From: Srinivasan Subramanian3 <srinivass@in.ibm.com>
Date: Fri, 22 May 2009 09:02:47 -0400
Message-ID: <OF8E537471.9A2FB872-ON652575BE.004CF0F4@in.ibm.com>
MIME-Version: 1.0
Subject: [LTP] LTP Build fail on System z 64 bit machine
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8472550167124707547=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sf.net

--===============8472550167124707547==
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<STYLE type=3D"text/css">.container {PADDING-LEFT: 8px; font-family: Taho=
ma, Helvetica, Arial, sans-serif; font-size: 10px; background-color: #F5F=
5F5;} .container .name {font-weight: bold;} .container .email {color: #33=
99FF;} .container .date, .container .to, .container .toValue, .container =
.subject, .container .subjectValue {display:none; position: absolute; lef=
t: -10000px;} .container .body {PADDING-LEFT: 10px; BORDER-LEFT: dotted 1=
px black; font-size: 13px;}</STYLE><p>Hi all,</p><p>When i tried to build=
 ltp on a RHEL4.8 machine, the build failed with undefined reference on s=
plice02.</p><p><b>Machine info</b></p><p>RHEL4.8 GA (64 bit)</p><p>Kernel=
 version-=C2=A02.6.9-89.EL</p><p><b>Error Info</b></p><style type=3D"text=
/css">
body { margin: 0 0 0 0; padding:0 0 0 0 }
td,div { font-family:Tahoma;font-size:8pt;vertical-align:top }
body { margin: 0 0 0 0; padding:0 0 0 0 }
transcript { background-color:#d2d2d2; }
messageBlock { margin-left:4px; margin-bottom:3px }
message { margin-left:100px; word-wrap:break-word; white-space:-moz-pre-w=
rap; _white-space:pre; }
messageCont { margin-left:100px; word-wrap:break-word; white-space:-moz-p=
re-wrap; _white-space:pre;}
other { color:#39577a;vertical-align:top;font-weight:bold;font-style:norm=
al;float:left; width:95px; }
myself { color:#da8103;font-style:normal;font-weight:bold;font-style:norm=
al;float:left; width:95px; }
otherCont { font-size:8px;text-align:right; color:#39577a;font-family:Ari=
al,Lucida Grande;font-style:normal;vertical-align:top;font-weight:bold;fl=
oat:left; width:95px; }
myselfCont { font-size:8px;text-align:right; color:#da8103;font-family:Ar=
ial,Lucida Grande;font-style:normal;vertical-align:top;font-weight:bold;f=
loat:left; width:95px; }
system { margin-left:4px; word-wrap:break-word;color:#da8103;font-style:n=
ormal;font-weight:normal; white-space:-moz-pre-wrap; _white-space:pre; }
showTimestamp { margin-right:3px; float:right; color:#999999;font-style:n=
ormal;font-weight:normal; }
other1 { color:#ac2000;vertical-align:top;font-weight:bold;font-style:nor=
mal;float:left; width:95px; }
otherCont1 { font-size:8px;text-align:right; color:#ac2000;font-family:Ar=
ial,Lucida Grande;font-style:normal;vertical-align:top;font-weight:bold;f=
loat:left; width:95px; }
other2 { color:#3c9fa8;vertical-align:top;font-weight:bold;font-style:nor=
mal;float:left; width:95px; }
otherCont2 { font-size:8px;text-align:right; color:#3c9fa8;font-family:Ar=
ial,Lucida Grande;font-style:normal;vertical-align:top;font-weight:bold;f=
loat:left; width:95px; }
other3 { color:#e25614;vertical-align:top;font-weight:bold;font-style:nor=
mal;float:left; width:95px; }
otherCont3 { font-size:8px;text-align:right; color:#e25614;font-family:Ar=
ial,Lucida Grande;font-style:normal;vertical-align:top;font-weight:bold;f=
loat:left; width:95px; }
other4 { color:#0b6ac8;vertical-align:top;font-weight:bold;font-style:nor=
mal;float:left; width:95px; }
otherCont4 { font-size:8px;text-align:right; color:#0b6ac8;font-family:Ar=
ial,Lucida Grande;font-style:normal;vertical-align:top;font-weight:bold;f=
loat:left; width:95px; }
other5 { color:#b23290;vertical-align:top;font-weight:bold;font-style:nor=
mal;float:left; width:95px; }
otherCont5 { font-size:8px;text-align:right; color:#b23290;font-family:Ar=
ial,Lucida Grande;font-style:normal;vertical-align:top;font-weight:bold;f=
loat:left; width:95px; }
other6 { color:#02e7c7;vertical-align:top;font-weight:bold;font-style:nor=
mal;float:left; width:95px; }
otherCont6 { font-size:8px;text-align:right; color:#02e7c7;font-family:Ar=
ial,Lucida Grande;font-style:normal;vertical-align:top;font-weight:bold;f=
loat:left; width:95px; }
other7 { color:#5b3284;vertical-align:top;font-weight:bold;font-style:nor=
mal;float:left; width:95px; }
otherCont7 { font-size:8px;text-align:right; color:#5b3284;font-family:Ar=
ial,Lucida Grande;font-style:normal;vertical-align:top;font-weight:bold;f=
loat:left; width:95px; }
tsDisplay { display:block }</style>
/root/ltp-intermediate-20090521/testcases/kernel/syscalls/splice/splice02=
.c:126: undefined reference to `splice'<br />collect2: ld returned 1 exit=
 status<br />make[4]: *** [splice02] Error 1<br />make[4]: Leaving direct=
ory `/root/ltp-intermediate-20090521/testcases/kernel/syscalls/splice'<br=
 />make[3]: *** [all] Error 2<br />make[3]: Leaving directory `/root/ltp-=
intermediate-20090521/testcases/kernel/syscalls'<br />make[2]: *** [all] =
Error 2<br />make[2]: Leaving directory `/root/ltp-intermediate-20090521/=
testcases/kernel'<br />make[1]: *** [all] Error 2<br />make[1]: Leaving d=
irectory `/root/ltp-intermediate-20090521/testcases'<br />make: *** [all]=
 Error 2<table width=3D"500px"><tbody /></table>
<p>Kindly help me on this issue.</p><p>Thanks &amp;=C2=A0</p><p>---------=
------------------------
<br />Best Regards,
<br />Srinivasan S,=20
<br />Linux on System z, LTC
<br />srinivass@in.ibm.com
<br />srinivass@linux.vnet.ibm.com
<br />----------------------------------<br /></p><p />


--===============8472550167124707547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
--===============8472550167124707547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8472550167124707547==--
