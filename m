Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <cristian.valean@live.com>) id 1ZIY8o-0006Y7-R3
	for ltp-list@lists.sourceforge.net; Fri, 24 Jul 2015 08:15:38 +0000
Received: from dub004-omc1s11.hotmail.com ([157.55.0.210])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZIY8a-0005V7-UX
	for ltp-list@lists.sourceforge.net; Fri, 24 Jul 2015 08:15:38 +0000
Message-ID: <DUB407-EAS55640DF929C2D5CE78788E85810@phx.gbl>
From: Cristian Valean <cristian.valean@live.com>
Date: Fri, 24 Jul 2015 11:15:18 +0300
MIME-Version: 1.0
Content-Language: en-us
Subject: [LTP] netns tests failure on ubuntu
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2339018272713010980=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============2339018272713010980==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0009_01D0C602.05D454A0"
Content-Language: en-us

------=_NextPart_000_0009_01D0C602.05D454A0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

All the netns tests are failing when running on ubuntu 14.04.2 from my run.
Is there any configuration to be made or how I can troubleshoot this
further?

The scripts seem to be looking for a child/local variable, which doesn't
exists:

 

<<<test_output>>>

stdin: is not a tty

netns_childns.sh: 142: local: 'child: bad variable name

netns_parentns.sh 1 TBROK : timeout reached!

netns_crtchild    1  TFAIL  :  common.c:89: Error while running the script

 

netns_child_1.sh: 142: local: 31011: bad variable name

netns_parent_1.sh 1 TBROK : timeout reached!

netns_2children    1  TFAIL  :  netns_two_children_ns.c:115: Error while
running the scripts

 

netns_childipv6.sh: 142: local: 33874: bad variable name

 

/opt/ltp/testcases/bin/netns_devices.sh: 26: local: utility,: bad variable
name

 

Ltp results:

netns_crtchild                 FAIL       1    

netns_two_children_ns          FAIL       1    

netns_crtchild_delchild        FAIL       1    

netns_par_chld_ipv6            FAIL       1    

netns_par_chld_ftp             CONF       32   

netns_netlink                  PASS       0    

netns_devices                  FAIL       2    

netns_devices2                 FAIL       2    

netns_isolation                FAIL       2    


------=_NextPart_000_0009_01D0C602.05D454A0
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40"><head><META =
HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii"><meta name=3DGenerator content=3D"Microsoft Word 15 =
(filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US =
link=3D"#0563C1" vlink=3D"#954F72"><div class=3DWordSection1><p =
class=3DMsoNormal>Hello,<o:p></o:p></p><p class=3DMsoNormal>All the =
netns tests are failing when running on ubuntu 14.04.2 from my run. Is =
there any configuration to be made or how I can troubleshoot this =
further?<o:p></o:p></p><p class=3DMsoNormal>The scripts seem to be =
looking for a child/local variable, which doesn&#8217;t =
exists:<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>&lt;&lt;&lt;test_output&gt;&gt;&gt;<o:p></o:p></p><p =
class=3DMsoNormal>stdin: is not a tty<o:p></o:p></p><p =
class=3DMsoNormal>netns_childns.sh: 142: local: 'child: bad variable =
name<o:p></o:p></p><p class=3DMsoNormal>netns_parentns.sh 1 TBROK : =
timeout reached!<o:p></o:p></p><p =
class=3DMsoNormal>netns_crtchild&nbsp;&nbsp;&nbsp; 1&nbsp; TFAIL&nbsp; =
:&nbsp; common.c:89: Error while running the script<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>netns_child_1.sh: 142: local: 31011: bad variable =
name<o:p></o:p></p><p class=3DMsoNormal>netns_parent_1.sh 1 TBROK : =
timeout reached!<o:p></o:p></p><p =
class=3DMsoNormal>netns_2children&nbsp;&nbsp;&nbsp; 1&nbsp; TFAIL&nbsp; =
:&nbsp; netns_two_children_ns.c:115: Error while running the =
scripts<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>netns_childipv6.sh: 142: local: 33874: bad variable =
name<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p =
class=3DMsoNormal>/opt/ltp/testcases/bin/netns_devices.sh: 26: local: =
utility,: bad variable name<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Ltp =
results:<o:p></o:p></p><p =
class=3DMsoNormal>netns_crtchild&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FAIL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; =
<o:p></o:p></p><p =
class=3DMsoNormal>netns_two_children_ns&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; FAIL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1&nbsp;&nbsp;&nbsp; <o:p></o:p></p><p =
class=3DMsoNormal>netns_crtchild_delchild&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; FAIL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1&nbsp;&nbsp;&nbsp; =
<o:p></o:p></p><p =
class=3DMsoNormal>netns_par_chld_ipv6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FAIL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
1&nbsp;&nbsp;&nbsp; <o:p></o:p></p><p =
class=3DMsoNormal>netns_par_chld_ftp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
CONF&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 32&nbsp;&nbsp; =
<o:p></o:p></p><p =
class=3DMsoNormal>netns_netlink&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
PASS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0&nbsp;&nbsp;&nbsp; =
<o:p></o:p></p><p =
class=3DMsoNormal>netns_devices&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FAIL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp; =
<o:p></o:p></p><p =
class=3DMsoNormal>netns_devices2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FAIL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp; =
<o:p></o:p></p><p =
class=3DMsoNormal>netns_isolation&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
FAIL&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2&nbsp;&nbsp;&nbsp; =
<o:p></o:p></p></div></body></html>
------=_NextPart_000_0009_01D0C602.05D454A0--


--===============2339018272713010980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============2339018272713010980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2339018272713010980==--

