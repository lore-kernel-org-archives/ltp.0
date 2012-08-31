Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <bincy_k_philip@yahoo.co.in>) id 1T7Ihb-00086C-ST
	for ltp-list@lists.sourceforge.net; Fri, 31 Aug 2012 04:19:27 +0000
Received: from nm40-vm4.bullet.mail.sg3.yahoo.com ([106.10.151.207])
	by sog-mx-2.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1T7IhX-0003CZ-4u
	for ltp-list@lists.sourceforge.net; Fri, 31 Aug 2012 04:19:27 +0000
References: <1346324865.59629.YahooMailNeo@web192605.mail.sg3.yahoo.com>
	<50401309.3050400@redhat.com>
Message-ID: <1346386756.61131.YahooMailNeo@web192604.mail.sg3.yahoo.com>
Date: Fri, 31 Aug 2012 12:19:16 +0800 (SGT)
From: Bincy K Philip <bincy_k_philip@yahoo.co.in>
In-Reply-To: <50401309.3050400@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] Container testcases In LTP
Reply-To: Bincy K Philip <bincy_k_philip@yahoo.co.in>
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4763669124154872645=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: cxie <cxie@redhat.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

--===============4763669124154872645==
Content-Type: multipart/alternative;
	boundary="1007199867-1133671153-1346386756=:61131"

--1007199867-1133671153-1346386756=:61131
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

=0A=0AHi=A0 Madper,=0AThanks for your response.=0AI have gone throgh LTP in=
stallation and understood basic flow about ltp.=0ABut I looking for contain=
er specific test caes and the prerequisite required for that.=0AI need some=
 help to understand container test cases.=0ARegards=0ABincy=0A=0A__________=
______________________=0A From: cxie <cxie@redhat.com>=0ATo: Bincy K Philip=
 <bincy_k_philip@yahoo.co.in> =0ASent: Friday, 31 August 2012 6:57 AM=0ASub=
ject: Re: [LTP] Container testcases In LTP=0A =0A=0AHi Bincy, =0A=A0=A0=A0 =
You can find all testcases in `ltp/testcases/`.=0A=A0=A0=A0 You need build =
and install them before you run them. In my=0A      computer, I can build/i=
nstall like follows:=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - change dir to ltp=
=A0=A0=A0=A0=A0=A0 # you need download them=A0=A0=A0=0A      :)=0A=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 - make autotools=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - m=
ake =0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - sudo make install=A0=A0=A0=A0=A0 # =
as root=0A=A0=A0=A0 Then you could find the ltp installed to the `/opt/ltp`=
. For=0A      more detail, please read `ltp/INSTALL`.=0A=A0=A0=A0 Then, you=
 can easily run those cases by follows:=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - =
change dir to `/opt/ltp`=0A=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 - sudo ./runltp -=
f XXXXX=A0=A0 #you can find a test set in=0A      `/opt/ltp/runtest`=0A=A0=
=A0=A0=A0 For more detail, please read `ltp/README`.=A0 Good Luck, Bincy.=
=0A=0A--=0AThanks,=0AMadper Xie.=0AOn 08/30/2012 07:07 PM, Bincy K Philip w=
rote:=0A=0AHi,=0A>=0A>=0A>I am working on linux containers.=0A>Can=A0 anybo=
dy describe me that what all container test cases are addressed in LTP.=0A>=
Any prerequisites is required to run container testcases?=0A>=0A>=0A>Regard=
s=0A>Bincy=0A>=0A>=0A>=0A>-------------------------------------------------=
-----------------------------=0ALive Security Virtual Conference=0AExclusiv=
e live event will cover all the ways today's security and =0Athreat landsca=
pe has changed and how IT managers can respond. Discussions =0Awill include=
 endpoint security, mobile security and the latest in malware =0Athreats. h=
ttp://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/=0A>=0A>=0A>_______=
________________________________________=0ALtp-list mailing list Ltp-list@l=
ists.sourceforge.net https://lists.sourceforge.net/lists/listinfo/ltp-list 
--1007199867-1133671153-1346386756=:61131
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ti=
mes new roman, new york, times, serif;font-size:12pt"><div><span><br></span=
></div><div>Hi&nbsp; Madper,<br>Thanks for your response.<br>I have gone th=
rogh LTP installation and understood basic flow about ltp.<br>But I looking=
 for container specific test caes and the prerequisite required for that.<b=
r>I need some help to understand container test cases.<br>Regards<br>Bincy<=
/div>  <div style=3D"font-family: times new roman, new york, times, serif; =
font-size: 12pt;"> <div style=3D"font-family: times new roman, new york, ti=
mes, serif; font-size: 12pt;"> <div dir=3D"ltr"> <font face=3D"Arial" size=
=3D"2"> <hr size=3D"1">  <b><span style=3D"font-weight:bold;">From:</span><=
/b> cxie &lt;cxie@redhat.com&gt;<br> <b><span style=3D"font-weight: bold;">=
To:</span></b> Bincy K Philip &lt;bincy_k_philip@yahoo.co.in&gt; <br> <b><s=
pan style=3D"font-weight: bold;">Sent:</span></b> Friday, 31 August 2012 6:=
57 AM<br>
 <b><span style=3D"font-weight: bold;">Subject:</span></b> Re: [LTP] Contai=
ner testcases In LTP<br> </font> </div> <br><meta http-equiv=3D"x-dns-prefe=
tch-control" content=3D"off"><div id=3D"yiv1613789460">=0A  =0A=0A    =0A  =
=0A  <div>=0A    <div class=3D"yiv1613789460moz-cite-prefix">Hi Bincy, <br>=
=0A      &nbsp;&nbsp;&nbsp; You can find all testcases in `ltp/testcases/`.=
<br>=0A      &nbsp;&nbsp;&nbsp; You need build and install them before you =
run them. In my=0A      computer, I can build/install like follows:<br>=0A =
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - change =
dir to ltp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # you need download them&nbs=
p;&nbsp;&nbsp;=0A      :)<br>=0A      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; - make autotools<br>=0A      &nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - make <br>=0A      &nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - sudo make install&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; # as root<br>=0A      &nbsp;&nbsp;&nbsp; Then you could=
 find the ltp installed to the `/opt/ltp`. For=0A      more detail, please =
read `ltp/INSTALL`.<br>=0A      &nbsp;&nbsp;&nbsp; Then, you can easily run=
 those cases by follows:<br>=0A      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; - change dir to `/opt/ltp`<br>=0A      &nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; - sudo ./runltp -f XXXXX&nb=
sp;&nbsp; #you can find a test set in=0A      `/opt/ltp/runtest`<br>=0A    =
  &nbsp;&nbsp;&nbsp;&nbsp; For more detail, please read `ltp/README`.&nbsp;=
 Good Luck, Bincy.<br>=0A      <br>=0A      --<br>=0A      Thanks,<br>=0A  =
    Madper Xie.<br>=0A      On 08/30/2012 07:07 PM, Bincy K Philip wrote:<b=
r>=0A    </div>=0A    <blockquote type=3D"cite">=0A      <div style=3D"colo=
r:#000;background-color:#fff;font-family:times new roman, new york, times, =
serif;font-size:12pt;">=0A        <div>Hi,</div>=0A        <div><br>=0A    =
    </div>=0A        <div style=3D"color:rgb(0, 0, 0);font-size:16px;=0Afon=
t-family:times new roman, new york, times, serif;=0Abackground-color:transp=
arent;font-style:normal;">I am working on linux=0A          containers.</di=
v>=0A        <div style=3D"color:rgb(0, 0, 0);font-size:16px;=0Afont-family=
:times new roman, new york, times, serif;=0Abackground-color:transparent;fo=
nt-style:normal;">Can&nbsp; anybody describe me=0A          that what all c=
ontainer test cases are addressed in LTP.</div>=0A        <div style=3D"col=
or:rgb(0, 0, 0);font-size:16px;=0Afont-family:times new roman, new york, ti=
mes, serif;=0Abackground-color:transparent;font-style:normal;">Any prerequi=
sites is=0A          required to run container testcases?</div>=0A        <=
div style=3D"color:rgb(0, 0, 0);font-size:16px;=0Afont-family:times new rom=
an, new york, times, serif;=0Abackground-color:transparent;font-style:norma=
l;"><br>=0A        </div>=0A        <div style=3D"color:rgb(0, 0, 0);font-s=
ize:16px;=0Afont-family:times new roman, new york, times, serif;=0Abackgrou=
nd-color:transparent;font-style:normal;">Regards</div>=0A        <div style=
=3D"color:rgb(0, 0, 0);font-size:16px;=0Afont-family:times new roman, new y=
ork, times, serif;=0Abackground-color:transparent;font-style:normal;">Bincy=
<br>=0A        </div>=0A      </div>=0A      <br>=0A      <fieldset class=
=3D"yiv1613789460mimeAttachmentHeader"></fieldset>=0A      <br>=0A      <pr=
e>-------------------------------------------------------------------------=
-----=0ALive Security Virtual Conference=0AExclusive live event will cover =
all the ways today's security and =0Athreat landscape has changed and how I=
T managers can respond. Discussions =0Awill include endpoint security, mobi=
le security and the latest in malware =0Athreats. <a rel=3D"nofollow" class=
=3D"yiv1613789460moz-txt-link-freetext" target=3D"_blank" href=3D"http://ww=
w.accelacomm.com/jaw/sfrnl04242012/114/50122263/">http://www.accelacomm.com=
/jaw/sfrnl04242012/114/50122263/</a></pre>=0A      <br>=0A      <fieldset c=
lass=3D"yiv1613789460mimeAttachmentHeader"></fieldset>=0A      <br>=0A     =
 <pre>_______________________________________________=0ALtp-list mailing li=
st=0A<a rel=3D"nofollow" class=3D"yiv1613789460moz-txt-link-abbreviated" ym=
ailto=3D"mailto:Ltp-list@lists.sourceforge.net" target=3D"_blank" href=3D"m=
ailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a>=0A=
<a rel=3D"nofollow" class=3D"yiv1613789460moz-txt-link-freetext" target=3D"=
_blank" href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list">http=
s://lists.sourceforge.net/lists/listinfo/ltp-list</a>=0A</pre>=0A    </bloc=
kquote>=0A    <br>=0A  </div>=0A=0A</div><meta http-equiv=3D"x-dns-prefetch=
-control" content=3D"on"><br><br> </div> </div>  </div></body></html>
--1007199867-1133671153-1346386756=:61131--


--===============4763669124154872645==
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
--===============4763669124154872645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4763669124154872645==--

