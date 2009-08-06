Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MZ6fY-00058a-6n
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 17:22:24 +0000
Received: from qw-out-1920.google.com ([74.125.92.144])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MZ6fT-0002Nv-DZ
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 17:22:24 +0000
Received: by qw-out-1920.google.com with SMTP id 5so378864qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 Aug 2009 10:22:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A7AEE38.60101@canonical.com>
References: <4A7AEE38.60101@canonical.com>
Date: Thu, 6 Aug 2009 10:22:14 -0700
Message-ID: <364299f40908061022m926d148o661e1c8a2eb58a5@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] fix lib6 test building
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
Cc: ltp-list@lists.sourceforge.net

On Thu, Aug 6, 2009 at 7:52 AM, Paul Larson<paul.larson@canonical.com> wrot=
e:
> The lib6 tests seem to fail the first pass through building for me
> because ranlib does not seem to get set correctly at any point. =A0This
> seems to fix it up for me.

Fixed on HEAD moments ago:

gcooper@orangebox /scratch/ltp-dev2/ltp $ cvs diff
testcases/network/lib6/Makefile
Index: testcases/network/lib6/Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/network/lib6/Makefile,v
retrieving revision 1.6
diff -r1.6 Makefile
25a26,27
> RANLIB                ?=3D ranlib
>

The problem is that while configure specifies RANLIB, make doesn't. So
if you don't run from a top-level make, there's no guarantee [today]
that the right variables will be set. This will be fixed soon.

If cross-compiling, please specify $(CROSS_COMPILE)ranlib, and the
compile will go through in the child make.

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
