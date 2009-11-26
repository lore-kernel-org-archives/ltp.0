Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NDlFp-0004Sf-M7
	for ltp-list@lists.sourceforge.net; Thu, 26 Nov 2009 20:47:53 +0000
Received: from mail-pz0-f193.google.com ([209.85.222.193])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NDlFi-0006JL-H8
	for ltp-list@lists.sourceforge.net; Thu, 26 Nov 2009 20:47:53 +0000
Received: by pzk31 with SMTP id 31so677121pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 26 Nov 2009 12:47:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <OFF890576D.887755E8-ON6525767A.0060753E-6525767A.0060D54C@in.ibm.com>
References: <20091112121455.16825.70322.sendpatchset@localhost.localdomain>
	<OFADCFBB49.BAA313D3-ON65257670.00168E44-65257670.0017980F@in.ibm.com>
	<1258359233.5677.36.camel@subratamodak.linux.ibm.com>
	<364299f40911160039w70ed1f57nef1a19ea36ac4f5f@mail.gmail.com>
	<OFF890576D.887755E8-ON6525767A.0060753E-6525767A.0060D54C@in.ibm.com>
Date: Thu, 26 Nov 2009 12:47:40 -0800
Message-ID: <364299f40911261247m54a0711byc45ce10caf24bea@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Power Management: Fix missing make targets.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1686795683022851842=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Poornima Nayak <Poornima.Nayak@in.ibm.com>
Cc: sachinp@linux.vnet.ibm.com, ltp-list@lists.sourceforge.net

--===============1686795683022851842==
Content-Type: multipart/alternative; boundary=000e0cd1473046e84404794c496d

--000e0cd1473046e84404794c496d
Content-Type: text/plain; charset=ISO-8859-1

On Thu, Nov 26, 2009 at 9:39 AM, Poornima Nayak
<Poornima.Nayak@in.ibm.com>wrote:

> Hi Garret
>
> I will fix those false positives displayed. But I have never seen them on
> my test setups.
>

I ran into these issues with the following two configurations:

1. I'm not root.
2. sysfs exists, but power management isn't in the kernel (mips*, ppc, etc).

1. can be resolved through an added check in runpwtests.sh, and I know that
2. was resolved by adding sufficient tests to runpwtests.sh, to replace
get_kv_arch, etc, but you'll run into that issue as well as many others,
particularly if you run with 1.

HTH,
-Garrett

--000e0cd1473046e84404794c496d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Thu, Nov 26, 2009 at 9:39 AM, Poornima Nayak =
<span dir=3D"ltr">&lt;<a href=3D"mailto:Poornima.Nayak@in.ibm.com">Poornima=
.Nayak@in.ibm.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0=
.8ex; padding-left: 1ex;">
<font face=3D"sans-serif" size=3D"2">Hi Garret</font>
<br>
<br><font face=3D"sans-serif" size=3D"2">I will fix those false positives d=
isplayed.
But I have never seen them on my test setups.</font>
<br></blockquote></div><br>I ran into these issues with the following two c=
onfigurations:<br><br>1. I&#39;m not root.<br>2. sysfs exists, but power ma=
nagement isn&#39;t in the kernel (mips*, ppc, etc).<br><br>1. can be resolv=
ed through an added check in runpwtests.sh, and I know that 2. was resolved=
 by adding sufficient tests to runpwtests.sh, to replace get_kv_arch, etc, =
but you&#39;ll run into that issue as well as many others, particularly if =
you run with 1.<br>
<br>HTH,<br>-Garrett<br>

--000e0cd1473046e84404794c496d--


--===============1686795683022851842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============1686795683022851842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============1686795683022851842==--

