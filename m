Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shanmuga.jayabalan@sasken.com>) id 1NX9nT-0000M0-7f
	for ltp-list@lists.sourceforge.net; Tue, 19 Jan 2010 08:50:47 +0000
Received: from mta-blr1.sasken.com ([203.200.200.72])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.69) id 1NX9nQ-0001Z5-Ci
	for ltp-list@lists.sourceforge.net; Tue, 19 Jan 2010 08:50:46 +0000
From: Shanmuga Jayabalan <shanmuga.jayabalan@sasken.com>
Date: Tue, 19 Jan 2010 14:20:24 +0530
Message-ID: <653A85C7F32C4741880F71219266EA02031A02FFB1@EXGMBX01.sasken.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] LTP installation configure Error
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2403083064447644782=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "'ltp-list@lists.sourceforge.net'" <ltp-list@lists.sourceforge.net>

--===============2403083064447644782==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_653A85C7F32C4741880F71219266EA02031A02FFB1EXGMBX01saske_"

--_000_653A85C7F32C4741880F71219266EA02031A02FFB1EXGMBX01saske_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi,

I am doing cross compilation of LTP with ARM.

When I do ./configure, I'm also getting the same error message in ltp-full-=
20091231 release.

        configure: error: Couldn't find functional copy of quota v2 - are y=
ou > running 2.4.x ?
As per your suggestion I have tried to do `man 2 quotactl', I'm getting the=
 following message.
        No manual entry for quotactl in section 2
I have ubuntu in my system. I'm able to cross compile with the previous rel=
ease "ltp-full-20091130".
Is there any setup is missing in my system for this release?
Help me to resolve this issue.

Regards,
J.Shanmuga Sundari




  ________________________________
SASKEN BUSINESS DISCLAIMER: This message may contain confidential, propriet=
ary or legally privileged information. In case you are not the original int=
ended Recipient of the message, you must not, directly or indirectly, use, =
disclose, distribute, print, or copy any part of this message and you are r=
equested to delete it and inform the sender. Any views expressed in this me=
ssage are those of the individual sender unless otherwise stated. Nothing c=
ontained in this message shall be construed as an offer or acceptance of an=
y offer by Sasken Communication Technologies Limited ("Sasken") unless sent=
 with that express intent and with due authority of Sasken. Sasken has take=
n enough precautions to prevent the spread of viruses. However the company =
accepts no liability for any damage caused by any virus transmitted by this=
 email.

--_000_653A85C7F32C4741880F71219266EA02031A02FFB1EXGMBX01saske_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from rtf -->
<style><!-- .EmailQuote { margin-left: 1pt; padding-left: 4pt; border-left:=
 #800000 2px solid; } --></style>
</head>
<body>
<font face=3D"Arial, sans-serif" size=3D"3">
<div>&nbsp;</div>
<div><font size=3D"2">Hi,</font></div>
<div><font size=3D"2">&nbsp;</font></div>
<div><font size=3D"2">I am doing cross compilation of LTP with ARM.</font><=
/div>
<div><font size=3D"2">&nbsp;</font></div>
<div><font size=3D"2">When I do ./configure, I'm also getting the same erro=
r message in ltp-full-20091231 release.</font></div>
<div style=3D"margin-top: 5pt; margin-bottom: 5pt; "><font size=3D"2">&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <font face=3D"Arial, sans-serif">conf=
igure: error: Couldn't find functional copy of quota v2 - are you &gt; runn=
ing 2.4.x ? </font></font></div>
<div style=3D"margin-top: 5pt; margin-bottom: 5pt; "><font size=3D"2">As pe=
r your suggestion I have tried to do <font face=3D"Arial, sans-serif">`man =
2 quotactl', I'm getting the following message.</font></font></div>
<div style=3D"margin-top: 5pt; margin-bottom: 5pt; "><font face=3D"Arial, s=
ans-serif" size=3D"2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; No manual =
entry for quotactl in section 2</font></div>
<div style=3D"margin-top: 5pt; margin-bottom: 5pt; "><font face=3D"Arial, s=
ans-serif" size=3D"2">I have ubuntu in my system. I'm able to cross compile=
 with the previous release &quot;ltp-full-20091130&quot;.</font></div>
<div style=3D"margin-top: 5pt; margin-bottom: 5pt; "><font face=3D"Arial, s=
ans-serif" size=3D"2">Is there any setup is missing in my system for this r=
elease?</font></div>
<div style=3D"margin-top: 5pt; margin-bottom: 5pt; "><font face=3D"Arial, s=
ans-serif" size=3D"2">Help me to resolve this issue.</font></div>
<div><font face=3D"Arial, sans-serif" size=3D"2">&nbsp;</font></div>
<div><font size=3D"2">Regards,</font></div>
<div><font size=3D"2">J.Shanmuga Sundari</font></div>
<div><font size=3D"2">&nbsp;</font></div>
<div><font size=3D"2">&nbsp;</font></div>
<div><br>

</div>
<div><font color=3D"#C0C0C0"><u>&nbsp; ________________________________ &nb=
sp;</u></font></div>
<div><font face=3D"Arial, sans-serif" size=3D"2">SASKEN BUSINESS DISCLAIMER=
: This message may contain confidential, proprietary or legally privileged =
information. In case you are not the original intended Recipient of the mes=
sage, you must not, directly or indirectly,
use, disclose, distribute, print, or copy any part of this message and you =
are requested to delete it and inform the sender. Any views expressed in th=
is message are those of the individual sender unless otherwise stated. Noth=
ing contained in this message shall
be construed as an offer or acceptance of any offer by Sasken Communication=
 Technologies Limited (&quot;Sasken&quot;) unless sent with that express in=
tent and with due authority of Sasken. Sasken has taken enough precautions =
to prevent the spread of viruses. However
the company accepts no liability for any damage caused by any virus transmi=
tted by this email.<br>

</font></div>
</font>
</body>
</html>

--_000_653A85C7F32C4741880F71219266EA02031A02FFB1EXGMBX01saske_--


--===============2403083064447644782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
--===============2403083064447644782==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2403083064447644782==--

