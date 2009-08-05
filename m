Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MYoPg-0006g6-1d
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2009 21:52:48 +0000
Received: from qw-out-1920.google.com ([74.125.92.148])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MYoPZ-0001rr-TC
	for ltp-list@lists.sourceforge.net; Wed, 05 Aug 2009 21:52:48 +0000
Received: by qw-out-1920.google.com with SMTP id 5so168882qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 05 Aug 2009 14:52:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <364299f40908051451h20e9a265m1b9edc19a67b2ceb@mail.gmail.com>
References: <364299f40908051451h20e9a265m1b9edc19a67b2ceb@mail.gmail.com>
Date: Wed, 5 Aug 2009 14:52:35 -0700
Message-ID: <364299f40908051452xd03abe2m82e3cc251934458f@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] waitid(2) broken on 2.6.29?
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
To: LTP list <ltp-list@lists.sourceforge.net>

On Wed, Aug 5, 2009 at 2:51 PM, Garrett Cooper<yanegomi@gmail.com> wrote:
> Sorry -- I know this isn't a linux support list but I was wondering
> whether or not anyone else could stimulate this error on x64:
>
> gcooper@orangebox ~ $ gcc -D_GNU_SOURCE -Wall -o foo foo.c
> gcooper@orangebox ~ $ ./foo
> strerror: Invalid argument
> gcooper@orangebox ~ $ cat foo.c
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <stdio.h>
> #include <string.h>
> #include <errno.h>
> #include <stdlib.h>
> #include <unistd.h>
>
> int
> main (void)
> {
> =A0 =A0 =A0 =A0siginfo_t infop;
> =A0 =A0 =A0 =A0errno =3D 0;
> =A0 =A0 =A0 =A0pid_t id =3D fork();
> =A0 =A0 =A0 =A0if (0 <=3D id) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (! id) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0exit (0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0perror("fork()");
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0/*printf("errno: %d\n", errno);*/
> =A0 =A0 =A0 =A0waitid(P_ALL, 0, &infop, WNOHANG);
> =A0 =A0 =A0 =A0/*printf("errno: %d\n", errno);*/
> =A0 =A0 =A0 =A0if (errno) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("strerror: %s\n", strerror(errno));
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 0;
> }
> gcooper@orangebox ~ $ uname -a
> Linux orangebox 2.6.29-gentoo-r5 #2 SMP PREEMPT Sun Jun 14 01:11:32
> PDT 2009 x86_64 Intel(R) Core(TM)2 Quad CPU Q9400 @ 2.66GHz
> GenuineIntel GNU/Linux
>
> For whatever reason it doesn't seem to function, even in a simple test
> program, and it wasn't functioning before in waitid02, so I'm trying
> to determine whether or not this is a valid issue.
>
> IIRC we saw similar issues on 2.6.24 with PPC on mips n32 with cavium
> boards, so this might be a bit-width issue?

Please completely ignore the `with PPC' part. It's spurious.
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
