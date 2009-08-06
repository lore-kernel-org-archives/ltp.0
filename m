Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MZ6bG-0002Ta-O2
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 17:17:58 +0000
Received: from mail-qy0-f181.google.com ([209.85.221.181])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MZ6b9-0002yt-18
	for ltp-list@lists.sourceforge.net; Thu, 06 Aug 2009 17:17:58 +0000
Received: by qyk11 with SMTP id 11so984579qyk.28
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 Aug 2009 10:17:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1842FA33-8C6C-4BE1-8FB4-B8836F1C8F6E@kernel.crashing.org>
References: <1842FA33-8C6C-4BE1-8FB4-B8836F1C8F6E@kernel.crashing.org>
Date: Thu, 6 Aug 2009 10:17:45 -0700
Message-ID: <364299f40908061017g44fd05ecv9c6454ebf04badb4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] RANLIB not set?
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
To: Kumar Gala <galak@kernel.crashing.org>
Cc: LTP <ltp-list@lists.sourceforge.net>

On Thu, Aug 6, 2009 at 9:18 AM, Kumar Gala<galak@kernel.crashing.org> wrote:
> I'm seeing this on fedora 11 on ppc64:
>
> make[3]: Leaving directory `/root/ltp/testcases/network/ipv6'
> make[3]: Entering directory `/root/ltp/testcases/network/lib6'
> cc -Wall =A0-I../../../include -g -D_GNU_SOURCE =A0 -c -o runcc.o runcc.c
> ar cr runcc.a runcc.o
> runcc.a
> make[3]: runcc.a: Command not found
> make[3]: *** [runcc.a] Error 127
> make[3]: Leaving directory `/root/ltp/testcases/network/lib6'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/root/ltp/testcases/network'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/root/ltp/testcases'
> make: *** [all] Error 2
>
> - k

    Make sure to export CROSS_COMPILER=3D1 at the top-level make, or
define RANLIB=3D$(CROSS_COMPILE)ranlib, where $(CROSS_COMPILE) is the
prefix for your compiler set, e.g. $(CROSS_COMPILE)gcc.
    One of the many things that will be fixed in a more kosher manner
in the next couple months.
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
