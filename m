Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <joyarjit@gmail.com>) id 1P3m6X-0006km-26
	for ltp-list@lists.sourceforge.net; Thu, 07 Oct 2010 08:45:33 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P3m6V-0006m1-AI
	for ltp-list@lists.sourceforge.net; Thu, 07 Oct 2010 08:45:33 +0000
Received: by wwc33 with SMTP id 33so494196wwc.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 07 Oct 2010 01:45:24 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 7 Oct 2010 14:15:13 +0530
Message-ID: <AANLkTinpKZ1qLJ7=s1U4OJ2YaS8WfZhR5fJpNg3bq1Ef@mail.gmail.com>
From: ARJIT SHARMA <joyarjit@gmail.com>
Subject: [LTP] network-stress tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7964117192753950317=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7964117192753950317==
Content-Type: multipart/alternative; boundary=0016367faf8b958438049202e916

--0016367faf8b958438049202e916
Content-Type: text/plain; charset=ISO-8859-1

Hi Hannu,

network-stress tests still not working......    :(

i have done all that is needed to be configured on PC for these tests to
run...

  On Wed, Oct 6, 2010 at 2:39 PM, ARJIT SHARMA <joyarjit@gmail.com> wrote:

> ya hannu i have installed rlogind,rshd,telnetd etc. progs.
>
> runltp log is saying the same thing ie. "TBROK : Environment variable
> LHOST_HWADDR is not set"
> i am using kernel version  2.6.32 (LSP3.0-alpha)
>  On Wed, Oct 6, 2010 at 5:05 PM, Hannu Heikkinen <
> ext-hannu.m.heikkinen@nokia.com> wrote:
>
>>  Waitlist reason: Hannu Heikkinen (ext-hannu.m.heikkinen@nokia.com) is
>> not on your Guest List <https://www.boxbe.com/approved-list> | Approve
>> sender <https://www.boxbe.com/anno?tc=5202046203_85360626> | Approve
>> domain <https://www.boxbe.com/anno?tc=5202046203_85360626&dom> | [image:
>> Boxbe] <https://www.boxbe.com/overview>
>>
>> On 06/10/10 10:18 +0200, ext ARJIT SHARMA wrote:
>> > please send me some reply to solve my problem........   :(
>> >
>> > On Tue, Oct 5, 2010 at 11:13 AM, ARJIT SHARMA <joyarjit@gmail.com
>> <mailto:joyarjit@gmail.com>> wrote:
>> > Hi,
>> >
>> >      I m  running LTP on arm armv7 architechture.
>> >      I have configured my system acoording to the requiremeints of
>> network-stress testcases as mentioned in README and INSTALL(section 6)
>> files.
>> >
>> >      but still the problem in same ie. LHOST_HWADDRS is not set.  :(
>> >
>> >      please tell me why this is happening, is there any way to make them
>> pass....?
>> >
>> > --
>> > Regards,
>> > Arjit Sharma.
>> >
>> >
>> >
>> >
>> > --
>> > Regards,
>> > Arjit Sharma.
>> >
>>
>> Hi,
>>
>> what is your runltp log saying? What distro u are using? Have u installed
>> rlogind etc progs?
>>
>> br,
>> Hannu
>>
>> --
>> Hannu Heikkinen
>> http://www.nixu.com
>>
>>
>
>
> --
> Regards,
> Arjit Sharma.
>
>


-- 
Regards,
Arjit Sharma.




-- 
Regards,
Arjit Sharma.

--0016367faf8b958438049202e916
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote"><br>
<div>Hi Hannu,</div>
<div>=A0</div>
<div>network-stress tests still not working......=A0=A0=A0 :(</div>
<div>=A0</div>
<div>i have done all that is needed to be configured on PC for these tests =
to run...<br><br></div>
<div>
<div></div>
<div class=3D"h5">
<div class=3D"gmail_quote">On Wed, Oct 6, 2010 at 2:39 PM, ARJIT SHARMA <sp=
an dir=3D"ltr">&lt;<a href=3D"mailto:joyarjit@gmail.com" target=3D"_blank">=
joyarjit@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>ya hannu i have installed rlogind,rshd,telnetd etc. progs.</div>
<div>=A0</div>
<div>runltp log is saying the same thing ie. &quot;TBROK : Environment vari=
able LHOST_HWADDR is not set&quot;<br></div>
<div>i am using kernel version=A0 2.6.32 (LSP3.0-alpha)<br></div>
<div class=3D"gmail_quote">
<div>On Wed, Oct 6, 2010 at 5:05 PM, Hannu Heikkinen <span dir=3D"ltr">&lt;=
<a href=3D"mailto:ext-hannu.m.heikkinen@nokia.com" target=3D"_blank">ext-ha=
nnu.m.heikkinen@nokia.com</a>&gt;</span> wrote:<br></div>
<blockquote class=3D"gmail_quote" style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0=
px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div style=3D"FONT-SIZE: 12px; COLOR: #666; FONT-FAMILY: &#39;Lucida Grande=
&#39;, Helvetica, Arial, sans-serif">Waitlist reason: Hannu Heikkinen (<a h=
ref=3D"mailto:ext-hannu.m.heikkinen@nokia.com" target=3D"_blank">ext-hannu.=
m.heikkinen@nokia.com</a>) is not on <a style=3D"COLOR: #5e96ea; TEXT-DECOR=
ATION: none" href=3D"https://www.boxbe.com/approved-list" target=3D"_blank"=
>your Guest List</a> | <a style=3D"COLOR: #5e96ea; TEXT-DECORATION: none" h=
ref=3D"https://www.boxbe.com/anno?tc=3D5202046203_85360626" target=3D"_blan=
k">Approve sender</a> | <a style=3D"COLOR: #5e96ea; TEXT-DECORATION: none" =
href=3D"https://www.boxbe.com/anno?tc=3D5202046203_85360626&amp;dom" target=
=3D"_blank">Approve domain</a> | <a style=3D"COLOR: #5e96ea; TEXT-DECORATIO=
N: none" href=3D"https://www.boxbe.com/overview" target=3D"_blank"><img sty=
le=3D"BORDER-RIGHT: medium none; BORDER-TOP: medium none; MARGIN-LEFT: 5px;=
 BORDER-LEFT: medium none; BORDER-BOTTOM: medium none" alt=3D"Boxbe" src=3D=
"http://www.boxbe.com/images/logo_dark_small.png" width=3D"64"></a><img src=
=3D"http://www.boxbe.com/stfopen?tc=3D5202046203_85360626"><br>
</div><br></div>On 06/10/10 10:18 +0200, ext ARJIT SHARMA wrote:<br>&gt; pl=
ease send me some reply to solve my problem........ =A0 :(<br>&gt;<br>&gt; =
On Tue, Oct 5, 2010 at 11:13 AM, ARJIT SHARMA &lt;<a href=3D"mailto:joyarji=
t@gmail.com" target=3D"_blank">joyarjit@gmail.com</a>&lt;mailto:<a href=3D"=
mailto:joyarjit@gmail.com" target=3D"_blank">joyarjit@gmail.com</a>&gt;&gt;=
 wrote:<br>
&gt; Hi,<br>&gt;<br>&gt; =A0 =A0 =A0I m =A0running LTP on arm armv7 archite=
chture.<br>&gt; =A0 =A0 =A0I have configured my system acoording to the req=
uiremeints of network-stress testcases as mentioned in README and INSTALL(s=
ection 6) files.<br>
&gt;<br>&gt; =A0 =A0 =A0but still the problem in same ie. LHOST_HWADDRS is =
not set. =A0:(<br>&gt;<br>&gt; =A0 =A0 =A0please tell me why this is happen=
ing, is there any way to make them pass....?<br>&gt;<br>&gt; --<br>&gt; Reg=
ards,<br>&gt; Arjit Sharma.<br>
&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt; --<br>&gt; Regards,<br>&gt; Arjit Shar=
ma.<br>&gt;<br><br>Hi,<br><br>what is your runltp log saying? What distro u=
 are using? Have u installed<br>rlogind etc progs?<br><br>br,<br>Hannu<br>
<br>--<br>Hannu Heikkinen<br><a href=3D"http://www.nixu.com/" target=3D"_bl=
ank">http://www.nixu.com</a><br><br></blockquote></div><br><br clear=3D"all=
"><br>-- <br>
<div>Regards,</div>
<div>Arjit Sharma.</div><font color=3D"#888888"><br></font></blockquote></d=
iv><br><br clear=3D"all"><br></div></div>-- <br>
<div>Regards,</div>
<div>Arjit Sharma.</div><font color=3D"#888888"><br></font></div><br><br cl=
ear=3D"all"><br>-- <br>
<div>Regards,</div>
<div>Arjit Sharma.</div><br>

--0016367faf8b958438049202e916--


--===============7964117192753950317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
--===============7964117192753950317==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7964117192753950317==--

