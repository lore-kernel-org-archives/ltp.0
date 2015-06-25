Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yshuo@umich.edu>) id 1Z7y2X-0005pO-T5
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 03:41:25 +0000
Received: from mail-pd0-f175.google.com ([209.85.192.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z7y2W-00035J-Qy
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 03:41:25 +0000
Received: by pdcu2 with SMTP id u2so43953632pdc.3
	for <ltp-list@lists.sourceforge.net>;
	Wed, 24 Jun 2015 20:41:19 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
From: Shuo Yang <yshuo@umich.edu>
In-Reply-To: <558B62CB.8060401@cn.fujitsu.com>
Date: Wed, 24 Jun 2015 20:12:49 -0700
Message-Id: <E0CF1826-54DC-40DE-8281-FE4F57492332@umich.edu>
References: <CANuOEEhmmS_E-O9umbGEHerBONT+bGAOFHH5O055ajH_V+Rgaw@mail.gmail.com>
	<558B62CB.8060401@cn.fujitsu.com>
Subject: Re: [LTP] How to specify testcases by running runltp
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============6141240192813198401=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net


--===============6141240192813198401==
Content-Type: multipart/alternative;
	boundary="Apple-Mail=_B5C7D0AE-9961-4D5C-BDF7-B04C96648859"


--Apple-Mail=_B5C7D0AE-9961-4D5C-BDF7-B04C96648859
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=iso-8859-1

Thank you so much for the answer. The file system I want to test is not =
from a regular device. I implemented a virtual file system on top of =
FUSE, so I only have a mount point to test. Is there a way to do this?=20=


Thanks,
Shuo Yang




> On Jun 24, 2015, at 7:09 PM, Xiaoguang Wang =
<wangxg.fnst@cn.fujitsu.com> wrote:
>=20
> Hi,
>=20
> On 06/25/2015 09:29 AM, Shuo Yang wrote:
>> Hi guys,
>>=20
>> I just started using ltp, so this question is kind of dumb. I want to =
use it to run some file system tests but I don't know what the command =
should be. Currently I can run runtlp command but I don't know how to =
control the testcases. Assuming the file system I want to test is under =
/tmp/foo/. Could someone tell me how can I run the testcases =
specifically for testing file system.=20
>>=20
> Script runltp's '-b DEVICE' and '-B LTP_DEV_FS_TYPE' can control the =
file
> system you want to test. Assume /tmp/foo/ is a mount point, the =
corresponding
> device is /dev/sda1 and file system type is xfs, then you can try =
'./runltp -b /dev/sda1 -B xfs'.
> Also if you want to test file system, xfstests is a good candidate.
>=20
> Regards,
> Xiaoguang Wang
>=20
>> Thanks,
>> Shuo
>>=20
>>=20
>>=20
>> =
--------------------------------------------------------------------------=
----
>> Monitor 25 network devices or servers for free with OpManager!
>> OpManager is web-based network management software that monitors=20
>> network devices and physical & virtual servers, alerts via email & =
sms=20
>> for fault. Monitor 25 devices for free with no restriction. Download =
now
>> http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
>>=20
>>=20
>>=20
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>=20
>=20


--Apple-Mail=_B5C7D0AE-9961-4D5C-BDF7-B04C96648859
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=iso-8859-1

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Diso-8859-1"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;" =
class=3D"">Thank you so much for the answer. The file system I want to =
test is not from a regular device. I implemented a virtual file system =
on top of FUSE, so I only have a mount point to test. Is there a way to =
do this?&nbsp;<div class=3D""><br class=3D""></div><div =
class=3D"">Thanks,</div><div class=3D"">Shuo Yang<br class=3D""><div =
apple-content-edited=3D"true" class=3D""><div style=3D"color: rgb(0, 0, =
0); letter-spacing: normal; orphans: auto; text-align: start; =
text-indent: 0px; text-transform: none; white-space: normal; widows: =
auto; word-spacing: 0px; -webkit-text-stroke-width: 0px; word-wrap: =
break-word; -webkit-nbsp-mode: space; -webkit-line-break: =
after-white-space;" class=3D""><br =
class=3D"Apple-interchange-newline"></div><br =
class=3D"Apple-interchange-newline"><br =
class=3D"Apple-interchange-newline">
</div>
<br class=3D""><div><blockquote type=3D"cite" class=3D""><div =
class=3D"">On Jun 24, 2015, at 7:09 PM, Xiaoguang Wang &lt;<a =
href=3D"mailto:wangxg.fnst@cn.fujitsu.com" =
class=3D"">wangxg.fnst@cn.fujitsu.com</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><div class=3D"">Hi,<br class=3D""><br =
class=3D"">On 06/25/2015 09:29 AM, Shuo Yang wrote:<br =
class=3D""><blockquote type=3D"cite" class=3D"">Hi guys,<br class=3D""><br=
 class=3D"">I just started using ltp, so this question is kind of dumb. =
I want to use it to run some file system tests but I don't know what the =
command should be. Currently I can run runtlp command but I don't know =
how to control the testcases. Assuming the file system I want to test is =
under /tmp/foo/. Could someone tell me how can I run the testcases =
specifically for testing file system. <br class=3D""><br =
class=3D""></blockquote>Script runltp's '-b DEVICE' and '-B =
LTP_DEV_FS_TYPE' can control the file<br class=3D"">system you want to =
test. Assume /tmp/foo/ is a mount point, the corresponding<br =
class=3D"">device is /dev/sda1 and file system type is xfs, then you can =
try './runltp -b /dev/sda1 -B xfs'.<br class=3D"">Also if you want to =
test file system, xfstests is a good candidate.<br class=3D""><br =
class=3D"">Regards,<br class=3D"">Xiaoguang Wang<br class=3D""><br =
class=3D""><blockquote type=3D"cite" class=3D"">Thanks,<br =
class=3D"">Shuo<br class=3D""><br class=3D""><br class=3D""><br =
class=3D"">---------------------------------------------------------------=
---------------<br class=3D"">Monitor 25 network devices or servers for =
free with OpManager!<br class=3D"">OpManager is web-based network =
management software that monitors <br class=3D"">network devices and =
physical &amp; virtual servers, alerts via email &amp; sms <br =
class=3D"">for fault. Monitor 25 devices for free with no restriction. =
Download now<br class=3D""><a =
href=3D"http://ad.doubleclick.net/ddm/clk/292181274;119417398;o" =
class=3D"">http://ad.doubleclick.net/ddm/clk/292181274;119417398;o</a><br =
class=3D""><br class=3D""><br class=3D""><br =
class=3D"">_______________________________________________<br =
class=3D"">Ltp-list mailing list<br =
class=3D"">Ltp-list@lists.sourceforge.net<br =
class=3D"">https://lists.sourceforge.net/lists/listinfo/ltp-list<br =
class=3D""><br class=3D""></blockquote><br =
class=3D""></div></blockquote></div><br class=3D""></div></body></html>=

--Apple-Mail=_B5C7D0AE-9961-4D5C-BDF7-B04C96648859--


--===============6141240192813198401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
--===============6141240192813198401==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============6141240192813198401==--

