Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yaneurabeya@gmail.com>) id 1OmTLM-00064Q-Eb
	for ltp-list@lists.sourceforge.net; Fri, 20 Aug 2010 15:17:20 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OmTLL-0003jB-CB
	for ltp-list@lists.sourceforge.net; Fri, 20 Aug 2010 15:17:20 +0000
Received: by pzk2 with SMTP id 2so1387584pzk.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 20 Aug 2010 08:17:13 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v1081)
From: Garrett Cooper <yaneurabeya@gmail.com>
In-Reply-To: <2019808896.1617958.1282317142128.JavaMail.fmail@mwmweb057>
Date: Fri, 20 Aug 2010 08:17:11 -0700
Message-Id: <48A67539-19CF-4E77-893F-266617B8C429@gmail.com>
References: <1618109809.1627285.1282314318024.JavaMail.fmail@mwmweb060>,
	<BA0785CB-50D5-4D23-B37E-8B171B5021D8@gmail.com>
	<2019808896.1617958.1282317142128.JavaMail.fmail@mwmweb057>
Subject: Re: [LTP] Reboot during LTP?
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7087419929794929649=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: missgrass@email.de
Cc: ltp-list@lists.sourceforge.net


--===============7087419929794929649==
Content-Type: multipart/alternative; boundary=Apple-Mail-3--932446556


--Apple-Mail-3--932446556
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

	Yes, it's possible to do a lot of things. Should it be done? =
Maybe, maybe not... unless you have a compelling reason to do this, I =
would say that having a testcase which runs separately from the standard =
herd is the way to go (i.e. if you're trying to test reboot(2) for =
instance).
Cheers,
-Garrett

On Aug 20, 2010, at 8:12 AM, missgrass@email.de wrote:

> isnt it possible to save the state, for example in a file?
>=20
> Von: Garrett Cooper <yaneurabeya@gmail.com>
> Gesendet: 20.08.2010 16:26:44
> An: missgrass@email.de
> Betreff: Re: [LTP] Reboot during LTP?
>=20
>  No. You'd lose all state with the running tests.
> -Garrett
>=20
> On Aug 20, 2010, at 7:25 AM, missgrass@email.de wrote:
>=20
>  Hi,
>=20
> i wanna know if it is possible to make a reboot during the LTP. That =
means in one case i start an application-tag with intern reboot, is that =
possible? And the other case, to make a reboot with LTP an return to the =
last state? an continue with test...
> =
--------------------------------------------------------------------------=
----
> This SF.net email is sponsored by=20
>=20
> Make an app they can't live without
> Enter the BlackBerry Developer Challenge
> http://p.sf.net/sfu/RIM-dev2dev =
_______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


--Apple-Mail-3--932446556
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=us-ascii

<html><head></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space; =
"><div><span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span>Yes, it's possible to do a lot of things. Should it be done? =
Maybe, maybe not... unless you have a compelling reason to do this, I =
would say that having a testcase which runs separately from the standard =
herd is the way to go (i.e. if you're trying to test reboot(2) for =
instance).</div><div>Cheers,</div><div>-Garrett</div><br><div><div>On =
Aug 20, 2010, at 8:12 AM, <a =
href=3D"mailto:missgrass@email.de">missgrass@email.de</a> =
wrote:</div><br class=3D"Apple-interchange-newline"><blockquote =
type=3D"cite"><div>isnt it possible to save the state, for example in a =
file?<span style=3D"font-size: 9pt;"><span style=3D"font-family: =
verdana,geneva;"><span style=3D"background-color: transparent;"><span =
style=3D"color: #000000;"><span style=3D"color: =
#000000;"><br></span></span></span></span></span><span style=3D"font-size:=
 9pt;"><span style=3D"font-family: verdana,geneva;"><span =
style=3D"background-color: transparent;"><span style=3D"color: =
#000000;"><span style=3D"color: =
#000000;"><br></span></span></span></span></span><span style=3D"font-size:=
 9pt;"><span style=3D"font-family: verdana,geneva;"><span =
style=3D"background-color: transparent;"><span style=3D"color: =
#000000;"><span style=3D"color: #000000;">
<blockquote style=3D"border-left: 2px solid blue; margin-left: 5px; =
padding-left: 5px; padding-top: 5px;">
<hr>
<b>Von:</b> Garrett Cooper &lt;<a =
href=3D"mailto:yaneurabeya@gmail.com">yaneurabeya@gmail.com</a>&gt;<br><b>=
Gesendet:</b> 20.08.2010 16:26:44<br><b>An:</b> <a =
href=3D"mailto:missgrass@email.de">missgrass@email.de</a><br><b>Betreff:</=
b> Re: [LTP] Reboot during LTP?<br><br>
<div style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space;"><span class=3D"Apple-tab-span" =
style=3D"white-space: pre;"> </span>No. You'd lose all state with the =
running tests.
<div>-Garrett</div>
<div><br>
<div>
<div>On Aug 20, 2010, at 7:25 AM, <a =
href=3D"mailto:missgrass@email.de">missgrass@email.de</a> wrote:</div>
<br class=3D"Apple-interchange-newline">
<blockquote>
<div class=3D"bgRepeatYes" style=3D"background-repeat: repeat; =
background-color: #ffffff; color: #000000; font-family: verdana,geneva; =
font-size: 9pt; padding-left: 0px;">
<div style=3D"min-height: 200px; background-image: =
url(https://img.web.de/v/p.gif); background-color: #ffffff; font-family: =
verdana, geneva; font-size: 9pt; padding-left: 0px; position: static; =
z-index: auto; background-repeat: repeat repeat;"><span =
style=3D"font-size: 9pt;"><span style=3D"font-family: =
verdana,geneva;"><span style=3D"background-color: transparent;"><span =
style=3D"color: #000000;"><span style=3D"color: =
#000000;">&nbsp;Hi,<br><br>i wanna know if it is possible to make a =
reboot during the LTP. That means in one case i start an application-tag =
with intern reboot, is that possible? And the other case, to make a =
reboot with LTP an return to the last state? an continue with =
test...</span></span></span></span></span></div>
</div>
</blockquote>
</div>
</div>
</div>
</blockquote>
=
</span></span></span></span></span></div>---------------------------------=
---------------------------------------------<br>This <a =
href=3D"http://SF.net">SF.net</a> email is sponsored by <br><br>Make an =
app they can't live without<br>Enter the BlackBerry Developer =
Challenge<br><a =
href=3D"http://p.sf.net/sfu/RIM-dev2dev">http://p.sf.net/sfu/RIM-dev2dev</=
a> _______________________________________________<br>Ltp-list mailing =
list<br><a =
href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.=
net</a><br>https://lists.sourceforge.net/lists/listinfo/ltp-list<br></bloc=
kquote></div><br></body></html>=

--Apple-Mail-3--932446556--


--===============7087419929794929649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
--===============7087419929794929649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7087419929794929649==--

