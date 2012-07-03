Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <filip.matusiak@tieto.com>) id 1Sm0Br-0000hR-2d
	for ltp-list@lists.sourceforge.net; Tue, 03 Jul 2012 10:18:39 +0000
Received: from ebb06.tieto.com ([131.207.168.38])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Sm0Bp-0008H7-1L
	for ltp-list@lists.sourceforge.net; Tue, 03 Jul 2012 10:18:39 +0000
From: <filip.matusiak@tieto.com>
Date: Tue, 3 Jul 2012 13:03:21 +0300
Message-ID: <FFB336710AC24540A4636F71A9A3C38B17DFA7E41A@EXMB03.eu.tieto.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP]  WiFi test harness
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7130172194518138921=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--===============7130172194518138921==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_FFB336710AC24540A4636F71A9A3C38B17DFA7E41AEXMB03eutieto_"

--_000_FFB336710AC24540A4636F71A9A3C38B17DFA7E41AEXMB03eutieto_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

Our organization is planning to implement some kind of WiFi test harness. I=
t's going to be and FOSS therefore using LTP comes as one of the obvious ch=
oices. For beginning we're planning to use mac80211_hwsim. I was browsing t=
he archive of LTP in search for anything related for WiFi/WLAN and found ra=
ther little information - most recent one dated 2009.

Latest post on WiFi in LTP list I've found is this:

(1)    http://sourceforge.net/mailarchive/forum.php?thread_name=3D43e72e890=
909271252r12459df1vc3ef263139889dc8%40mail.gmail.com&forum_name=3Dltp-list
The only other thread I've found on WiFi is the one about mesh (but it has =
some information on proposed way forward for wireless as whole):

(2)    http://sourceforge.net/mailarchive/message.php?msg_id=3D20189102

We may be able to extend the hostapd's mac80211_hwsim/tests proposed by Jou=
ni (http://w1.fi/gitweb/gitweb.cgi?p=3Dhostap.git;a=3Dtree;f=3Dmac80211_hws=
im/tests) and integrate it to LTP.
Q1) We must know if it is work that community would benefit from(?).
* Since there's not much about this for last 3 years it was presumably not =
too important.
Q2) Is the latest message from Subrata Modak on the second thread above the=
 way to go?
* (http://sourceforge.net/mailarchive/message.php?msg_id=3D20192822)
Q3) If not then what would be the preferred way forward?

I'd be thankful for any information with regards to LTP WiFi related matter=
s, especially if there was any off-record follow-up for any of the two disc=
ussions referred to above.
Best regards,
Filip Matusiak, Software Engineer
Tieto, Devices R&D, Poland



--_000_FFB336710AC24540A4636F71A9A3C38B17DFA7E41AEXMB03eutieto_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 12 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"Trebuchet MS";
	panose-1:2 11 6 3 2 2 2 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:1674722719;
	mso-list-type:hybrid;
	mso-list-template-ids:591832190 -1514745836 67698713 67698715 67698703 676=
98713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-text:"\(%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:54.0pt;
	text-indent:-18.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>Hello,<o:p></o:p=
></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Our org=
anization is planning to implement some kind of WiFi test harness. It&#8217=
;s going to be and FOSS therefore using LTP comes as one of the obvious cho=
ices. For beginning we&#8217;re planning to use mac80211_hwsim. I was brows=
ing the archive of LTP in search for anything related for WiFi/WLAN and fou=
nd rather little information &#8211; most recent one dated 2009.<o:p></o:p>=
</p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Latest p=
ost on WiFi in LTP list I&#8217;ve found is this:<o:p></o:p></p><p class=3D=
MsoListParagraph style=3D'margin-left:54.0pt;text-indent:-18.0pt;mso-list:l=
0 level1 lfo1'><![if !supportLists]><span style=3D'mso-list:Ignore'>(1)<spa=
n style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp; </span></span><=
![endif]><a href=3D"http://sourceforge.net/mailarchive/forum.php?thread_nam=
e=3D43e72e890909271252r12459df1vc3ef263139889dc8%40mail.gmail.com&amp;forum=
_name=3Dltp-list">http://sourceforge.net/mailarchive/forum.php?thread_name=
=3D43e72e890909271252r12459df1vc3ef263139889dc8%40mail.gmail.com&amp;forum_=
name=3Dltp-list</a><o:p></o:p></p><p class=3DMsoNormal>The only other threa=
d I&#8217;ve found on WiFi is the one about mesh (but it has some informati=
on on proposed way forward for wireless as whole):<o:p></o:p></p><p class=
=3DMsoListParagraph style=3D'margin-left:54.0pt;text-indent:-18.0pt;mso-lis=
t:l0 level1 lfo1'><![if !supportLists]><span style=3D'mso-list:Ignore'>(2)<=
span style=3D'font:7.0pt "Times New Roman"'>&nbsp;&nbsp;&nbsp; </span></spa=
n><![endif]><a href=3D"http://sourceforge.net/mailarchive/message.php?msg_i=
d=3D20189102">http://sourceforge.net/mailarchive/message.php?msg_id=3D20189=
102</a><o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3D=
MsoNormal>We may be able to extend the hostapd&#8217;s mac80211_hwsim/tests=
 proposed by Jouni (<a href=3D"http://w1.fi/gitweb/gitweb.cgi?p=3Dhostap.gi=
t;a=3Dtree;f=3Dmac80211_hwsim/tests">http://w1.fi/gitweb/gitweb.cgi?p=3Dhos=
tap.git;a=3Dtree;f=3Dmac80211_hwsim/tests</a>) and integrate it to LTP. &nb=
sp;<o:p></o:p></p><p class=3DMsoNormal>Q1) We must know if it is work that =
community would benefit from(?). <br>* Since there&#8217;s not much about t=
his for last 3 years it was presumably not too important.<o:p></o:p></p><p =
class=3DMsoNormal>Q2) Is the latest message from Subrata Modak on the secon=
d thread above the way to go? <br>* (<a href=3D"http://sourceforge.net/mail=
archive/message.php?msg_id=3D20192822">http://sourceforge.net/mailarchive/m=
essage.php?msg_id=3D20192822</a>)<o:p></o:p></p><p class=3DMsoNormal>Q3) If=
 not then what would be the preferred way forward? <o:p></o:p></p><p class=
=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>I&#8217;d be thankfu=
l for any information with regards to LTP WiFi related matters, especially =
if there was any off-record follow-up for any of the two discussions referr=
ed to above.<b><span style=3D'font-size:10.0pt;font-family:"Trebuchet MS","=
sans-serif"'><o:p></o:p></span></b></p><p class=3DMsoNormal style=3D'mso-ma=
rgin-top-alt:auto;mso-margin-bottom-alt:auto'><span style=3D'font-size:10.0=
pt;font-family:"Trebuchet MS","sans-serif"'>Best regards,<o:p></o:p></span>=
</p><p class=3DMsoNormal style=3D'mso-margin-top-alt:auto;mso-margin-bottom=
-alt:auto'><b><span style=3D'font-size:10.0pt;font-family:"Trebuchet MS","s=
ans-serif"'>Filip Matusiak,</span></b><span style=3D'font-size:10.0pt;font-=
family:"Trebuchet MS","sans-serif"'> Software Engineer</span><span style=3D=
'font-size:12.0pt;font-family:"Times New Roman","serif"'><br></span><span s=
tyle=3D'font-size:10.0pt;font-family:"Trebuchet MS","sans-serif"'>Tieto, De=
vices R&amp;D, Poland</span><b><span style=3D'font-size:12.0pt;font-family:=
"Times New Roman","serif"'><br><br></span></b><i><span style=3D'font-size:7=
.5pt;font-family:"Arial","sans-serif";color:#595959'><o:p></o:p></span></i>=
</p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p></div></body></html>=

--_000_FFB336710AC24540A4636F71A9A3C38B17DFA7E41AEXMB03eutieto_--


--===============7130172194518138921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--===============7130172194518138921==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7130172194518138921==--

