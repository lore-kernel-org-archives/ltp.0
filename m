Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MbLN1-00021P-MW
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 21:28:31 +0000
Received: from qw-out-1920.google.com ([74.125.92.145])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MbLMx-0001rm-Dv
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 21:28:31 +0000
Received: by qw-out-1920.google.com with SMTP id 5so120441qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 12 Aug 2009 14:28:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A832F96.4020701@canonical.com>
References: <4A7AEE38.60101@canonical.com>
	<364299f40908061022m926d148o661e1c8a2eb58a5@mail.gmail.com>
	<4A82DC0A.3050502@canonical.com>
	<E831A4F6-658A-47BE-9778-D00D7D3E9741@gmail.com>
	<4A832F96.4020701@canonical.com>
Date: Wed, 12 Aug 2009 14:28:19 -0700
Message-ID: <364299f40908121428k607b57aeue88aa9888cc32a17@mail.gmail.com>
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

On Wed, Aug 12, 2009 at 2:09 PM, Paul Larson<paul.larson@canonical.com> wro=
te:
> Garrett Cooper wrote:
>> On Aug 12, 2009, at 8:13 AM, Paul Larson wrote:
>>
>>> Garrett Cooper wrote:
>>>> On Thu, Aug 6, 2009 at 7:52 AM, Paul
>>>> Larson<paul.larson@canonical.com> wrote:
>>>>> The lib6 tests seem to fail the first pass through building for me
>>>>> because ranlib does not seem to get set correctly at any point. =A0Th=
is
>>>>> seems to fix it up for me.
>>>>
>>>> Fixed on HEAD moments ago:
>>>>
>>>> gcooper@orangebox /scratch/ltp-dev2/ltp $ cvs diff
>>>> testcases/network/lib6/Makefile
>>>> Index: testcases/network/lib6/Makefile
>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>>> RCS file: /cvsroot/ltp/ltp/testcases/network/lib6/Makefile,v
>>>> retrieving revision 1.6
>>>> diff -r1.6 Makefile
>>>> 25a26,27
>>>>> RANLIB =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0?=3D ranlib
>>> The patch you checked in does not correct the build failure.
>>
>> =A0 =A0 Error message please?
> Same error as before:
> make[3]: Entering directory `/home/plars/ltp2/testcases/network/lib6'
> cc -Wall =A0-I../../../include -g -D_GNU_SOURCE =A0 -c -o runcc.o runcc.c
> ar cr runcc.a runcc.o
> runcc.a
> make[3]: runcc.a: Command not found
> make[3]: *** [runcc.a] Error 127
> make[3]: Leaving directory `/home/plars/ltp2/testcases/network/lib6'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/home/plars/ltp2/testcases/network'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/home/plars/ltp2/testcases'
> make: *** [all] Error 2
>
> My make-foo is a bit rusty, but I'm guessing that the higher level
> export is exporting an empty RANLIB, so the RANLIB ?=3D ranlib is not
> doing anything since RANLIB already exists.

You're right. I've just fixed it on HEAD with the following comment:

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: Makefile
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/Makefile,v
retrieving revision 1.40
diff -u -r1.40 Makefile
--- Makefile	10 Jul 2009 23:01:27 -0000	1.40
+++ Makefile	12 Aug 2009 21:27:24 -0000
@@ -7,6 +7,11 @@
 CC=3D$(CROSS_COMPILER)gcc
 AR=3D$(CROSS_COMPILER)ar
 RANLIB=3D$(CROSS_COMPILER)ranlib
+else
+# RANLIB isn't a standard Make variable, which means that when it's export=
ed
+# to leaf callers as an empty value, builds fail.
+# testcases/network/lib6/Makefile is a prime example.
+RANLIB?=3Dranlib
 endif

 HAS_NUMA=3D$(shell sh tools/scripts/numa_test.sh)

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
