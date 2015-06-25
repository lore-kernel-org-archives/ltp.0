Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ced.hnyda@gmail.com>) id 1Z80iY-0000EY-Rh
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 06:32:58 +0000
Received: from mail-wi0-f178.google.com ([209.85.212.178])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z80iY-00013F-4D
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2015 06:32:58 +0000
Received: by wicgi11 with SMTP id gi11so65704106wic.0
	for <ltp-list@lists.sourceforge.net>;
	Wed, 24 Jun 2015 23:32:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <558B9D33.1090305@cn.fujitsu.com>
References: <558B6C8C.5000202@huawei.com>
	<558B9D33.1090305@cn.fujitsu.com>
Date: Thu, 25 Jun 2015 08:32:52 +0200
Message-ID: <CALPnEb6td8AGRvRWSG1frhi=VZr67apQtqNd7UUvAgC8Wg4hDg@mail.gmail.com>
From: =?UTF-8?Q?C=C3=A9dric_Hnyda?= <ced.hnyda@gmail.com>
Subject: Re: [LTP] Cedric
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7007282915548935638=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

--===============7007282915548935638==
Content-Type: multipart/alternative; boundary=001a11360312fbbb0d051951ca90

--001a11360312fbbb0d051951ca90
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi!

On 06/25/2015 04:50 AM, Yuan Sun wrote:
> Hi Cedric,
>      I encounter the following error in ubuntu14.04. Your patch
> "syscall/getrandom: Add tests for getrandom" leads to the error.
>      Do I need to install new libraries?

getrandom() was introduced in version 3.17 of the Linux kernel.
Ubuntu 14.04 gets shipped with kernel 3.13.

Try to upgrade your kernel to a more recent version to get the syscall.

Best,
C=C3=A9dric Hnyda

--001a11360312fbbb0d051951ca90
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi!<br><br><span class=3D"im">On 06/25/2015=
 04:50 AM, Yuan Sun wrote:<br>
&gt; Hi Cedric,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 I encounter the following error in ubuntu14.04. Yo=
ur patch<br>
&gt; &quot;syscall/getrandom: Add tests for getrandom&quot; leads to the er=
ror.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 Do I need to install new libraries?</span><br><br>=
</div>getrandom() was introduced in version 3.17 of the Linux kernel.<br></=
div>Ubuntu 14.04 gets shipped with kernel 3.13.<br><br></div>Try to upgrade=
 your kernel to a more recent version to get the syscall.<br><div><div><br>=
</div><div>Best,<br></div><div>C=C3=A9dric Hnyda<br></div></div></div>

--001a11360312fbbb0d051951ca90--


--===============7007282915548935638==
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
--===============7007282915548935638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============7007282915548935638==--

