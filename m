Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SFTtH-0003eJ-Df
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 17:21:03 +0000
Received: from mail-vb0-f47.google.com ([209.85.212.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SFTtG-0007tO-Os
	for ltp-list@lists.sourceforge.net; Wed, 04 Apr 2012 17:21:03 +0000
Received: by vbbfr13 with SMTP id fr13so533069vbb.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 04 Apr 2012 10:20:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201204041320.51396.vapier@gentoo.org>
References: <alpine.BSF.2.00.1204032220270.25027@toaster.local>
	<201204041320.51396.vapier@gentoo.org>
Date: Wed, 4 Apr 2012 10:20:57 -0700
Message-ID: <CAGH67wSBMFA4kQi+QZMuD8W39UGvD5QwOn+=yFE+4ntrPRfBkA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 2/4] Install .awk files
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On Wed, Apr 4, 2012 at 10:20 AM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Wednesday 04 April 2012 01:22:25 Garrett Cooper wrote:
>> --- a/tools/Makefile
>> +++ b/tools/Makefile
>>
>> -INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D *.pl *.sh html_report_h=
eader.txt
>> +INSTALL_TARGETS =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D *awk *.pl *.sh html_rep=
ort_header.txt
>
> *.awk ?

Good catch! Will resubmit.

---------------------------------------------------------------------------=
---
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second =

resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
