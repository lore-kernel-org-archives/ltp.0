Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PB3th-0005pi-Fz
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 11:10:25 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PB3tg-0004Sv-BM
	for ltp-list@lists.sourceforge.net; Wed, 27 Oct 2010 11:10:25 +0000
Received: by wya21 with SMTP id 21so549466wya.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Oct 2010 04:10:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <AANLkTikbzi44SibVCGa_yJZ0LryqzhiebgxVmPjLAbDb@mail.gmail.com>
References: <AANLkTikbzi44SibVCGa_yJZ0LryqzhiebgxVmPjLAbDb@mail.gmail.com>
Date: Wed, 27 Oct 2010 04:10:18 -0700
Message-ID: <AANLkTik65oonTaya93P59johGHbrtaMZS-+Mq6YtwQXL@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Realtime test filtered out
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
To: David Peverley <pev@sketchymonkey.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Oct 27, 2010 at 3:52 AM, David Peverley <pev@sketchymonkey.com> wro=
te:
> Hi all,
>
> In the ltp-full-20100831 release the realtime test is filtered out.
> This comes from the code in testcases/Makefile. This looks like :
> =A0 # XXX (garrcoop): Not sure why realtime is still in this list; this w=
as the
> =A0 # original list of disabled items...
> =A0 # XXX (garrcoop): kdump was in this list.
> =A0 # XXX (garrcoop): open_hpi_testsuite was in this list.
> =A0 ifneq ($(UCLINUX),1)
> =A0 FILTER_OUT_DIRS =A0 =A0 =A0 =A0 +=3D audit-test DOTS realtime
> =A0 endif
>
> This is filtering out the tests if NOT a uclinux build. Is this
> correct or inverted? I'd assume realtime tests would be built as
> standard but maybe not for uclinux? Also, I can't find the audit-tests
> dir so I'm guessing this may be deprecated?

Commit fixing this will be incoming shortly.
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
