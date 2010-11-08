Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PFZcZ-0003r3-A5
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 21:51:23 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PFZcY-0004Oi-5r
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 21:51:23 +0000
Received: by gxk7 with SMTP id 7so2382gxk.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 08 Nov 2010 13:51:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <000001cb773b$ce4f9950$6aeecbf0$@co.jp>
References: <Act3O838preomyfuTIOsmPN0ITLHHQ==>
	<000001cb773b$ce4f9950$6aeecbf0$@co.jp>
Date: Mon, 8 Nov 2010 13:51:15 -0800
Message-ID: <AANLkTinebjz8OJ+7ajN3W5-EqW54SYUMYBF5J6OxnGvc@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] About "realtime" build failure
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Fri, Oct 29, 2010 at 12:35 AM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
> I applied patches which are the effort of various people.
> And I could overcome configuration error and keyctl01's build error.
> (Thanks!!)
> After that, librttest.c build failed:
> ------------
> make[3]: Leaving directory
> `/home/LTP/ltp-dev-20101028/testcases/network/xinetd'
> make[2]: Leaving directory `/home/LTP/ltp-dev-20101028/testcases/network'
> make[2]: Entering directory `/home/LTP/ltp-dev-20101028/testcases/realtim=
e'
> make -C lib -f "/home/LTP/ltp-dev-20101028/testcases/realtime/lib/Makefil=
e"
> all
> make[3]: Entering directory
> `/home/LTP/ltp-dev-20101028/testcases/realtime/lib'
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -D_GNU_SOURCE
> -I/home/LTP/ltp-dev-20101028/testcases/realtime/lib/../include
> -I../../../include -I../../../include =A0-c -o librttest.o librttest.c
> librttest.c: In function `init_pi_mutex':
> librttest.c:569: warning: implicit declaration of function
> `pthread_mutexattr_setprotocol'
> librttest.c:569: error: `PTHREAD_PRIO_INHERIT' undeclared (first use in t=
his
> function)
> librttest.c:569: error: (Each undeclared identifier is reported only once
> librttest.c:569: error: for each function it appears in.)
> librttest.c:572: warning: implicit declaration of function
> `pthread_mutexattr_getprotocol'
> make[3]: *** [librttest.o] Error 1
> make[3]: Leaving directory
> `/home/LTP/ltp-dev-20101028/testcases/realtime/lib'
> make[2]: *** [lib/librealtime.a] Error 2
> make[2]: Leaving directory `/home/LTP/ltp-dev-20101028/testcases/realtime'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/home/LTP/ltp-dev-20101028/testcases'
> make: *** [testcases-all] Error 2
> ------------
>
> "realtime" became to be build by the patch of Makefile:
> ------------
> --- a/testcases/Makefile
> +++ b/testcases/Makefile
> =A0@@ -38,7 +38,12 @@ FILTER_OUT_DIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D bal=
lista kdump mce-test
> open% pounder21
> =A0# XXX (garrcoop): kdump was in this list.
> =A0# XXX (garrcoop): open_hpi_testsuite was in this list.
> =A0ifeq ($(UCLINUX),1)
> =A0-FILTER_OUT_DIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D DOTS realtime
> =A0+FILTER_OUT_DIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D realtime
> =A0+endif
> =A0+
> =A0+# DOTS requires javac
> =A0+ifeq ($(strip $(JAVAC)),)
> =A0+FILTER_OUT_DIRS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D DOTS
> =A0endif
>
> =A0#
> ------------
>
> "realtime" added to build.
> Perhaps this revision caused this failure, I think.

    DOTS is garbage, bitrotted code. If no one has any opposes the
change, then I'll remove it from LTP in 3 days time.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a =

Billion" shares his insights and actions to help propel your =

business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
