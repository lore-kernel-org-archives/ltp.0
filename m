Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NbN9L-00044g-Mf
	for ltp-list@lists.sourceforge.net; Sat, 30 Jan 2010 23:54:47 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NbN9K-0002MK-U1
	for ltp-list@lists.sourceforge.net; Sat, 30 Jan 2010 23:54:47 +0000
Received: by pxi38 with SMTP id 38so2821887pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Sat, 30 Jan 2010 15:54:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b9d696241001301500g6e36e013g2a8d3bb2ca09ed44@mail.gmail.com>
References: <364299f41001292129odcec445t1514787fb65d69f1@mail.gmail.com>
	<b9d696241001301500g6e36e013g2a8d3bb2ca09ed44@mail.gmail.com>
Date: Sat, 30 Jan 2010 15:54:41 -0800
Message-ID: <364299f41001301554g4b5ed6d1nb4737e65b9d94cba@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] `buffer overflow detected' from ftest0[37] with glibc 2.10
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
To: "K.D. Lucas" <kdlucas@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Sat, Jan 30, 2010 at 3:00 PM, K.D. Lucas <kdlucas@gmail.com> wrote:
> Garrett,
>
> I see this issue all the time, since the July 2009 release.
>
> kdl
>
> On Fri, Jan 29, 2010 at 9:29 PM, Garrett Cooper <yanegomi@gmail.com> wrot=
e:
>>
>> Hi,
>> =A0 =A0I've been seeing the following messages when ftest03 and ftest07
>> are executed on a regular basis as of late (may be due to a recent
>> glibc upgrade):

[..]

All,
    Ok, I might not have been paying attention to that really closely
before now. There are a number of warnings with this test when
compiling it on 64-bit systems, mostly dealing with native bit-width
and the format strings (which suggests that a lot of these items need
appropriate inttypes.h cleanup).

Kelly,
    Have you tried the patch I attached in the previous email?
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the busine=
ss
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
