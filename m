Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sarath.tadi@gmail.com>) id 1SaVED-0000WD-9Z
	for ltp-list@lists.sourceforge.net; Fri, 01 Jun 2012 17:01:33 +0000
Received: from mail-wg0-f41.google.com ([74.125.82.41])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SaVE9-0005Kv-9J
	for ltp-list@lists.sourceforge.net; Fri, 01 Jun 2012 17:01:33 +0000
Received: by wgbds1 with SMTP id ds1so733949wgb.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 01 Jun 2012 10:01:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CANoG8sX9dk4ztf=pK0JtFtn=qMMknociKAnN+_VEeQjCT8Wc6w@mail.gmail.com>
References: <CANoG8sX9dk4ztf=pK0JtFtn=qMMknociKAnN+_VEeQjCT8Wc6w@mail.gmail.com>
Date: Fri, 1 Jun 2012 22:31:22 +0530
Message-ID: <CABhB_e-14DNvY-033pOhqW5wUsqAZeEZ21YUwsy8XfZLMUXEWA@mail.gmail.com>
From: tadimarri sarath <sarath.tadi@gmail.com>
Subject: Re: [LTP] LTP filesystem related tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============5285903427000820860=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Romu <huruomu@gmail.com>
Cc: ltp-list@lists.sourceforge.net

--===============5285903427000820860==
Content-Type: multipart/alternative; boundary=0016e6d7eaed4d03a804c16c22ac

--0016e6d7eaed4d03a804c16c22ac
Content-Type: text/plain; charset=ISO-8859-1

Hi Romu,
you can use "syscalls" test in addition to that.


On Fri, Jun 1, 2012 at 9:09 PM, Romu <huruomu@gmail.com> wrote:

> Hi,
>
> 1) What option should I use with runltp to test different filesystems?
>  -d TMPDIR and with TMPDIR on different filesystems?
>
> 2) Which tests should I use to test if filesystem is working fine?
> I'm using the following:
>
> filecaps
> fs
> fs_bind
> fs_perms_simple
> fs_readonly
> fsx
>
> Are the above tests a good test suite for filesystem test?  Any other
> tests (e.g. aio, dio)?
>
> Thanks
> Romu
>
>
> ------------------------------------------------------------------------------
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>

--0016e6d7eaed4d03a804c16c22ac
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Romu, <br>you can use &quot;syscalls&quot; test in addition to that. <br=
><br><br><div class=3D"gmail_quote">On Fri, Jun 1, 2012 at 9:09 PM, Romu <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:huruomu@gmail.com" target=3D"_blank">=
huruomu@gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Hi,<br>
<br>
1) What option should I use with runltp to test different filesystems?<br>
=A0-d TMPDIR and with TMPDIR on different filesystems?<br>
<br>
2) Which tests should I use to test if filesystem is working fine?<br>
I&#39;m using the following:<br>
<br>
filecaps<br>
fs<br>
fs_bind<br>
fs_perms_simple<br>
fs_readonly<br>
fsx<br>
<br>
Are the above tests a good test suite for filesystem test? =A0Any other<br>
tests (e.g. aio, dio)?<br>
<br>
Thanks<br>
Romu<br>
<br>
---------------------------------------------------------------------------=
---<br>
Live Security Virtual Conference<br>
Exclusive live event will cover all the ways today&#39;s security and<br>
threat landscape has changed and how IT managers can respond. Discussions<b=
r>
will include endpoint security, mobile security and the latest in malware<b=
r>
threats. <a href=3D"http://www.accelacomm.com/jaw/sfrnl04242012/114/5012226=
3/" target=3D"_blank">http://www.accelacomm.com/jaw/sfrnl04242012/114/50122=
263/</a><br>
_______________________________________________<br>
Ltp-list mailing list<br>
<a href=3D"mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforg=
e.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/ltp-list" target=3D=
"_blank">https://lists.sourceforge.net/lists/listinfo/ltp-list</a><br>
</blockquote></div><br>

--0016e6d7eaed4d03a804c16c22ac--


--===============5285903427000820860==
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
--===============5285903427000820860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============5285903427000820860==--

