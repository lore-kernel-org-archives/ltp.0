Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chen.nisnkorn@ravellosystems.com>)
	id 1ROCrr-0005GM-Cl
	for ltp-list@lists.sourceforge.net; Wed, 09 Nov 2011 18:27:23 +0000
Received: from na3sys010aog103.obsmtp.com ([74.125.245.74])
	by sog-mx-4.v43.ch3.sourceforge.com with smtp (Exim 4.76)
	id 1ROCrq-0001GN-FM
	for ltp-list@lists.sourceforge.net; Wed, 09 Nov 2011 18:27:23 +0000
MIME-Version: 1.0
Date: Wed, 9 Nov 2011 20:01:32 +0200
Message-ID: <CAKCBqa2tKNhY4LvPF2H=0iL8dVdV_+jYMgt3Qe3ULapL2ndz6g@mail.gmail.com>
From: Chen Nisnkorn <chen.nisnkorn@ravellosystems.com>
Subject: [LTP] FATAL: LTP not installed correctly
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1364818196103139961=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sf.net

--===============1364818196103139961==
Content-Type: multipart/alternative; boundary=f46d04447247fc107c04b1511385

--f46d04447247fc107c04b1511385
Content-Type: text/plain; charset=ISO-8859-1

Hi

i new in LTP and im taring to run it from the first time
i download the ltp-20110915 version and i did the install (by the file)
step by step

but when i tried to run it i get =>


chen@chen:~/QA/LTP/ltp-20110915$ ./runltp -p -l
/home/chen/QA/LTP/result.02.log -f my_command_file
FATAL: LTP not installed correctly
INFO:  Follow directions in INSTALL!

i don't know what is the problem.

when i run = >
sudo /opt/ltp/runltplite.sh -p -l /home/chen/QA/LTP/result.02.log -f
my_command_file

i get = > Illegal option -f

enoter thing is where can i found explanation to what every test is doing
and explanation on how can i config my command file

thanks


chen

--f46d04447247fc107c04b1511385
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi<div><br></div><div>i=A0new in LTP and im=A0taring=A0to =
run it from the first time</div><div>i download the ltp-20110915 version an=
d i did the install (by the file) step by step</div><div><br></div><div>but=
 when i tried to run it i get =3D&gt;</div>
<div><br></div><div><br></div><div><div>chen@chen:~/QA/LTP/ltp-20110915$ ./=
runltp -p -l /home/chen/QA/LTP/result.02.log -f my_command_file</div><div><=
font class=3D"Apple-style-span" color=3D"#cc0000">FATAL: LTP not installed =
correctly</font></div>
<div><font class=3D"Apple-style-span" color=3D"#cc0000">INFO: =A0Follow dir=
ections in INSTALL!</font></div></div><div><br></div><div>i don&#39;t know =
what is the problem.=A0</div><div><br></div><div>when i run =3D &gt;</div><=
div>sudo /opt/ltp/runltplite.sh -p -l /home/chen/QA/LTP/result.02.log -f my=
_command_file</div>
<div><br></div><div>i get =3D &gt;=A0<font class=3D"Apple-style-span" color=
=3D"#cc0000">Illegal option -f</font></div><div><font class=3D"Apple-style-=
span" color=3D"#cc0000"><br></font></div><div>enoter thing is where can i f=
ound explanation to what every test is doing and=A0explanation=A0on how can=
 i config my command file</div>
<div><br></div><div>thanks</div><div><br></div><div><br></div><div>chen</di=
v><div><font class=3D"Apple-style-span" color=3D"#cc0000"><br></font></div>=
<div><font class=3D"Apple-style-span" color=3D"#cc0000"><br></font></div><d=
iv><br>
</div><div><br></div><div><br></div></div>

--f46d04447247fc107c04b1511385--


--===============1364818196103139961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
--===============1364818196103139961==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1364818196103139961==--

