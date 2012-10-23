Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <omprakash.pal@stericsson.com>) id 1TQajS-0005fl-GR
	for ltp-list@lists.sourceforge.net; Tue, 23 Oct 2012 09:25:06 +0000
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123])
	by sog-mx-1.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TQajN-0006Xd-V7
	for ltp-list@lists.sourceforge.net; Tue, 23 Oct 2012 09:25:06 +0000
Received: from zeta.dmz-us.st.com (ns4.st.com [167.4.16.71])
	by beta.dmz-us.st.com (STMicroelectronics) with ESMTP id B3B4957
	for <ltp-list@lists.sourceforge.net>;
	Tue, 23 Oct 2012 09:24:20 +0000 (GMT)
Received: from relay1.stm.gmessaging.net (unknown [10.230.100.17])
	by zeta.dmz-us.st.com (STMicroelectronics) with ESMTP id A7EE56F
	for <ltp-list@lists.sourceforge.net>;
	Tue, 23 Oct 2012 04:53:42 +0000 (GMT)
Received: from exdcvycastm022.EQ1STM.local (alteon-source-exch [10.230.100.61])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "exdcvycastm022", Issuer "exdcvycastm022" (not verified))
	by relay1.stm.gmessaging.net (Postfix) with ESMTPS id 3ECFD24C2F3
	for <ltp-list@lists.sourceforge.net>;
	Tue, 23 Oct 2012 11:24:46 +0200 (CEST)
From: Om Prakash PAL <omprakash.pal@stericsson.com>
Date: Tue, 23 Oct 2012 11:24:49 +0200
Message-ID: <3ED83A9DB3B6D94CA68BF7C03F2981D35D01C266B4@EXDCVYMBSTM006.EQ1STM.local>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] Regarding shmat01 syscall test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6829364837709027388=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============6829364837709027388==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_3ED83A9DB3B6D94CA68BF7C03F2981D35D01C266B4EXDCVYMBSTM00_"

--_000_3ED83A9DB3B6D94CA68BF7C03F2981D35D01C266B4EXDCVYMBSTM00_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
I am working on syscall test:  shmat01.c
I have some confusion:

In setup() : it is  allocating shared memory by shmget() and then attaching=
 by shmat() and after  that detaching the attached address (i.e. shmdt())

        if (shmdt((const void *)base_addr) =3D=3D -1) {
                tst_brkm(TBROK, cleanup, "Couldn't detach shared memory");
        }

And again in main function it is using same "base_addr" as attaching addres=
s,

addr =3D shmat(*(TC[i].shmid), base_addr+TC[i].offset,
                                     TC[i].flags);
how can we ensure(100%) that base_addr (virtual) will be free till this poi=
nt for attaching?.
there is possibility that this address(base_addr) will be used, so in that =
case this shmat() will fail.
Please correct me if I am wrong.
Thanks in advance.

Best Regards,
Om Prakash Pal

--_000_3ED83A9DB3B6D94CA68BF7C03F2981D35D01C266B4EXDCVYMBSTM00_
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
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
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
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>Hi,<o:p></o:p></=
p><p class=3DMsoNormal>I am working on syscall test: &nbsp;shmat01.c<o:p></=
o:p></p><p class=3DMsoNormal>I have some confusion:<o:p></o:p></p><p class=
=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>In setup() : it is &=
nbsp;allocating shared memory by shmget() and then attaching by shmat() and=
 after &nbsp;that detaching the attached address (i.e. shmdt()) &nbsp;&nbsp=
;<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNor=
mal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (shmdt((const void *)base=
_addr) =3D=3D -1) {<o:p></o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tst_=
brkm(TBROK, cleanup, &quot;Couldn't detach shared memory&quot;);<o:p></o:p>=
</p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<o:p><=
/o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>And=
 again in main function it is using same &#8220;base_addr&#8221; as attachi=
ng address,<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p clas=
s=3DMsoNormal>addr =3D shmat(*(TC[i].shmid), base_addr+TC[i].offset,<o:p></=
o:p></p><p class=3DMsoNormal>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; TC[i].flags);<o:p></o:p></p><p class=3DMsoNormal> <o:p=
></o:p></p><p class=3DMsoNormal>how can we ensure(100%) that base_addr (vir=
tual) will be free till this point for attaching?.<o:p></o:p></p><p class=
=3DMsoNormal>there is possibility that this address(base_addr) will be used=
, so in that case this shmat() will fail.<o:p></o:p></p><p class=3DMsoNorma=
l>Please correct me if I am wrong.<o:p></o:p></p><p class=3DMsoNormal>Thank=
s in advance.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p cl=
ass=3DMsoNormal>Best Regards,<o:p></o:p></p><p class=3DMsoNormal>Om Prakash=
 Pal &nbsp;&nbsp;<o:p></o:p></p></div></body></html>=

--_000_3ED83A9DB3B6D94CA68BF7C03F2981D35D01C266B4EXDCVYMBSTM00_--


--===============6829364837709027388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
--===============6829364837709027388==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6829364837709027388==--

