Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ccnandi@yahoo.com>) id 1WgMOs-0003DZ-W9
	for ltp-list@lists.sourceforge.net; Fri, 02 May 2014 22:57:51 +0000
Received: from nm49.bullet.mail.bf1.yahoo.com ([216.109.114.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WgMOr-0005Sq-Ti
	for ltp-list@lists.sourceforge.net; Fri, 02 May 2014 22:57:50 +0000
References: <1399071397.9456.YahooMailNeo@web141601.mail.bf1.yahoo.com>
Message-ID: <1399071464.2771.YahooMailNeo@web141601.mail.bf1.yahoo.com>
Date: Fri, 2 May 2014 15:57:44 -0700 (PDT)
From: C Nandi <ccnandi@yahoo.com>
In-Reply-To: <1399071397.9456.YahooMailNeo@web141601.mail.bf1.yahoo.com>
MIME-Version: 1.0
Subject: [LTP] Fw: Typo
Reply-To: C Nandi <ccnandi@yahoo.com>
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6974960161826948890=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============6974960161826948890==
Content-Type: multipart/alternative;
	boundary="1633104601-188127112-1399071464=:2771"

--1633104601-188127112-1399071464=:2771
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,=0A=0ACorrection is required for the "netdefs.h" file.=0A=0A=0A=0A=0Adif=
f --git a/testcases/network/tcp_cmds/include/netdefs.h b/testcases/network/=
tcp_cmds/include/netdefs.h=0Aindex 067f20a..c6647e9 100644=0A--- a/testcase=
s/network/tcp_cmds/include/netdefs.h=0A+++=0A b/testcases/network/tcp_cmds/=
include/netdefs.h=0A@@ -37,7 +37,7 @@ typedef struct sockaddr_in6=A0=A0 sai=
_t;=0A=A0#define AFI=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 AF_INET6=0A=A0#define IERP=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 ICMP6_ECHO_REPLY=0A=A0#define IERQ=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 ICMP6_ECHO_REQUEST=0A-#define ICMP_PROTO=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 "ipv6-imcp"=0A+#define ICMP_PROTO=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 "ipv6-icmp"=0A=A0#define=0A PFI=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PF_INET6=0A=0A=A0#else=0A@@ -52,7 +=
52,7 @@ typedef struct sockaddr_in=A0=A0=A0 sai_t;=0A=A0#define AFI=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AF_INET=0A=A0#define IE=
RP=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ICMP_ECHOREPLY=0A=
=A0#define IERQ=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ICMP_=
ECHO=0A-#define ICMP_PROTO=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "imcp"=0A+#d=
efine=0A ICMP_PROTO=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "icmp"=0A=A0#define=
 PFI=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 PF_INET=0A=0A=
=A0#endif=0A=0A=0A=A0=0AThanks and Regards, =0ACHANDRASHEKHAR NANDI
--1633104601-188127112-1399071464=:2771
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:Co=
urier New, courier, monaco, monospace, sans-serif;font-size:10pt">Hi,<div s=
tyle=3D"font-family: Courier New, courier, monaco, monospace, sans-serif; f=
ont-size: 10pt;"><div style=3D"font-family: HelveticaNeue, Helvetica Neue, =
Helvetica, Arial, Lucida Grande, sans-serif; font-size: 12pt;"><div class=
=3D"y_msg_container"><div id=3D"yiv3450087424"><div><div style=3D"color:#00=
0;background-color:#fff;font-family:Courier New, courier, monaco, monospace=
, sans-serif;font-size:10pt;"><div style=3D"" class=3D"yiv3450087424"><br><=
/div>Correction is required for the "netdefs.h" file.<br><br><br><span styl=
e=3D"" class=3D"yiv3450087424"></span><div style=3D"color:rgb(0, 0, 0);font=
-size:13.3333px;font-family:Courier New, courier, monaco, monospace, sans-s=
erif;background-color:transparent;font-style:normal;" class=3D"yiv345008742=
4"><span style=3D"" class=3D"yiv3450087424"><br></span></div><div style=3D"=
color:rgb(0, 0,
 0);font-size:13.3333px;font-family:Courier New, courier, monaco, monospace=
, sans-serif;background-color:transparent;font-style:normal;" class=3D"yiv3=
450087424"><span style=3D"" class=3D"yiv3450087424">diff --git a/testcases/=
network/tcp_cmds/include/netdefs.h b/testcases/network/tcp_cmds/include/net=
defs.h<br style=3D"" class=3D"yiv3450087424">index 067f20a..c6647e9 100644<=
br style=3D"" class=3D"yiv3450087424">--- a/testcases/network/tcp_cmds/incl=
ude/netdefs.h<br style=3D"" class=3D"yiv3450087424">+++=0A b/testcases/netw=
ork/tcp_cmds/include/netdefs.h<br style=3D"" class=3D"yiv3450087424">@@ -37=
,7 +37,7 @@ typedef struct sockaddr_in6&nbsp;&nbsp; sai_t;<br style=3D"" cl=
ass=3D"yiv3450087424">&nbsp;#define AFI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; AF_INET6<br style=3D"" class=3D"yiv3450087424">&nbsp;#define IERP&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; ICMP6_ECHO_REPLY<br style=3D"" class=3D"yiv3450=
087424">&nbsp;#define IERQ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICMP6_ECHO_REQU=
EST<br style=3D"" class=3D"yiv3450087424">-#define ICMP_PROTO&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "ipv6-imcp"<br s=
tyle=3D"" class=3D"yiv3450087424">+#define ICMP_PROTO&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "ipv6-icmp"<br style=3D"=
"
 class=3D"yiv3450087424">&nbsp;#define=0A PFI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; PF_INET6<br style=3D"" class=3D"yiv3450087424"><br style=3D"" cla=
ss=3D"yiv3450087424">&nbsp;#else<br style=3D"" class=3D"yiv3450087424">@@ -=
52,7 +52,7 @@ typedef struct sockaddr_in&nbsp;&nbsp;&nbsp; sai_t;<br style=
=3D"" class=3D"yiv3450087424">&nbsp;#define AFI&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; AF_INET<br style=3D"" class=3D"yiv3450087424">&nbsp;#define IER=
P&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICMP_ECHOREPLY<br style=3D"" class=3D"yi=
v3450087424">&nbsp;#define IERQ&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ICMP_ECHO<=
br style=3D"" class=3D"yiv3450087424">-#define ICMP_PROTO&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 "imcp"<br style=3D"" class=3D"yiv3450087424">+#define=0A ICMP_PROTO&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "icmp"<br=
 style=3D"" class=3D"yiv3450087424">&nbsp;#define PFI&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; PF_INET<br style=3D"" class=3D"yiv3450087424"><br style=
=3D"" class=3D"yiv3450087424">&nbsp;#endif<br style=3D"" class=3D"yiv345008=
7424"><br style=3D"" class=3D"yiv3450087424"></span></div><div style=3D"" c=
lass=3D"yiv3450087424">&nbsp;</div><div style=3D"" class=3D"yiv3450087424">=
Thanks and Regards,=0A<br style=3D"" class=3D"yiv3450087424">CHANDRASHEKHAR=
 NANDI</div></div></div></div><br><br></div> </div> </div>  </div></body></=
html>
--1633104601-188127112-1399071464=:2771--


--===============6974960161826948890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
--===============6974960161826948890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6974960161826948890==--

