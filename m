Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MbiyI-0007xD-JE
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 22:40:34 +0000
Received: from mail-qy0-f181.google.com ([209.85.221.181])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MbiyC-0005oY-7J
	for ltp-list@lists.sourceforge.net; Thu, 13 Aug 2009 22:40:34 +0000
Received: by qyk11 with SMTP id 11so964474qyk.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 13 Aug 2009 15:40:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A845364.6070308@canonical.com>
References: <4A833919.9040603@canonical.com>
	<1250183880.6656.21.camel@subratamodak.linux.ibm.com>
	<4A845364.6070308@canonical.com>
Date: Thu, 13 Aug 2009 15:40:22 -0700
Message-ID: <364299f40908131540q4d2b02bcg3717fa97b859699b@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Add option to skip tests
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
To: Paul Larson <paul.larson@canonical.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

On Thu, Aug 13, 2009 at 10:54 AM, Paul Larson<paul.larson@canonical.com> wr=
ote:
> You were not providing the full path. =A0Here's a new version that should
> let you either provide absolute or relative path (including no patch
> assuming the file is in LTPROOT). =A0See if this works better for you.
>
>
> Add a -S option to runltp that allows the user to specify a SKIPFILE of
> tests to skip.
>
> Signed-off-by: Paul Larson <paul.larson@canonical.com>

    Cool innovation Paul! I see potential for this providing us with
the shims necessary to automatically generate which testcases need to
be skipped after running autoconf and/or the compile end :). Also, I'd
say that if the basename is the same as the specified skipfile, and
the skipfile isn't in the base directory, then it should be assumed to
be in a predefined directory. Otherwise, it's not in the default
directory. That way we don't invite any confusing defaults...
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with =

Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
